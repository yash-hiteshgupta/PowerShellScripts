$PeopleDefinition=@"
using System;
using System.Collections;
using System.Collections.Generic;

namespace People
{
    public enum Gender
    {
        Unknown,
        Male,
        Female
    }

    public class Person
    {
        private People _people;
        public String _motherID = "";
        public String _fatherID = "";
        public String _spouseID = "";
        public People People { set { this._people = value; } }
        public String ID { get { return this.Name; } }
        public string Name { get; set; }
        public Gender Gender { get; set; }
        public int Age { get; set; }
        public bool IsMale { get {return (this.Gender == Gender.Male);} }
        public bool IsFemale { get {return (this.Gender == Gender.Female);} }
        public Person Mother
        {
            get
            {
                return _people[this._motherID];
            }
            set
            {
                if (value != null) { this._motherID = value.ID; }
            }
        }
        public Person Father
        {
            get
            {
                return _people[this._fatherID];
            }
            set
            {
                if (value != null) { this._fatherID = value.ID; }
            }
        }
        public Person Spouse
        {
            get
            {
                return _people[this._spouseID];
            }
            set
            {
                if (value != null) { this._spouseID = value.ID; }
            }
        }
        public Persons Parents
        {
            get
            {
                Persons Parents = new Persons();
                Parents.Add(this.Mother);
                Parents.Add(this.Father);
                return Parents;
            }
            set
            {
                foreach (Person Parent in value)
                {
                    if (Parent.Gender == Gender.Male)
                    {
                        this.Father = Parent;
                    }
                    else if (Parent.Gender == Gender.Female)
                    {
                        this.Mother = Parent;
                    }
                }
            }
        }
        public Persons Children
        {
            get
            {
                return _people.Person_Children(this);
            }
        }
        public Persons Siblings
        {
            get
            {
                return _people.Person_Siblings(this);
            }
        }
        public Persons GrandChildren
        {
            get
            {
                Persons grandChildren = new Persons();
                foreach (Person child in this.Children)
                {
                    grandChildren.AddPersons(child.Children);
                }
                return grandChildren;
            }
        }
        public Persons GrandParents
        {
            get
            {
                Persons grandParents = new Persons();
                foreach (Person parent in this.Parents)
                {
                    grandParents.AddPersons(parent.Parents);
                }
                return grandParents;
            }
        }
        public Person(People people, string Name, Gender Gender, int Age)
        {
            this._people = people;
            this.Name = Name;
            this.Gender = Gender;
            this.Age = Age;
        }
    }

    public class Persons : System.Collections.IEnumerable
    {
        private System.Collections.Generic.List<Person> _persons = new System.Collections.Generic.List<Person>();
        public int Count { get { return _persons.Count; } }

        public Person this[int index]
        {
            get { return (Person)_persons[index]; }
        }

        public void Add(Person person)
        {
            if (person != null)
            {
                _persons.Add(person);
            }
        }
        public void AddPersons(Persons persons)
        {
            foreach (Person person in persons)
            {
                this.Add(person);
            }
        }
        public System.Collections.IEnumerator GetEnumerator()
        {
            return new PersonEnumerator(_persons);
        }
        private class PersonEnumerator : System.Collections.IEnumerator
        {
            private System.Collections.Generic.List<Person> _persons;
            private int _position = -1;

            public PersonEnumerator(System.Collections.Generic.List<Person> persons)
            {
                _persons = persons;
            }
            object System.Collections.IEnumerator.Current
            {
                get
                {
                    return _persons[_position];
                }
            }
            bool System.Collections.IEnumerator.MoveNext()
            {
                _position++;
                return (_position < _persons.Count);
            }
            void System.Collections.IEnumerator.Reset()
            {
                _position = -1;
            }
        }
    }

    public class People : DictionaryBase
    {
        public void Add(string key, Person person)
        {
            if (person != null)
            {
                Dictionary.Add(key, person);
            }
        }
        public void Remove(string key)
        {
            Dictionary.Remove(key);
        }
        public Person this[string key]
        {
            get { return (Person)Dictionary[key]; }
            set { Dictionary[key] = value; }
        }
        public Persons Person_Children(Person person)
        {
            Persons children = new Persons();
            if (person != null)
            {
                foreach (DictionaryEntry PersonEntry in Dictionary)
                {
                    Person child = PersonEntry.Value as Person;
                    if (child._motherID == person.ID)
                    {
                        children.Add(child);
                    }
                    else if (child._fatherID == person.ID)
                    {
                        children.Add(child);
                    }
                }
            }
            return children;
        }
        public Persons Person_Siblings(Person person)
        {
            Persons siblings = new Persons();
            if (person != null)
            {
                foreach (DictionaryEntry PersonEntry in Dictionary)
                {
                    Person sibling = PersonEntry.Value as Person;
                    if (sibling.ID != person.ID)
                    {
                        if (sibling._motherID != "" &&
                            sibling._motherID == person._motherID)
                        {
                            siblings.Add(sibling);
                        }
                        else if (sibling._fatherID != "" &&
                                 sibling._fatherID == person._fatherID)
                        {
                            siblings.Add(sibling);
                        }
                    }
                }
            }
            return siblings;
        }
    }

    public static class Factory
    {
        public static Person NewPerson(People people, string Name, Gender Gender, int Age)
        {
            Person Person = new Person(people, Name, Gender, Age);
            people.Add(Person.ID, Person);
            return Person;
        }
        public static Person NewMan(People people, string Name, int Age)
        {
            return NewPerson(people, Name, Gender.Male, Age);
        }
        public static Person NewWoman(People people, string Name, int Age)
        {
            return NewPerson(people, Name, Gender.Female, Age);
        }
        public static Persons AsCouple(Person man, Person woman)
        {
            Persons couple = new Persons();
            if (man != null)
            {
                man.Spouse = woman;
                couple.Add(man);
            }
            if (woman != null)
            {
                woman.Spouse = man;
                couple.Add(woman);
            }
            return couple;
        }
        public static void AsFamily(Person father, Person mother, Person person, Person brother, Person sister)
        {
            Persons parents = AsCouple(father, mother);
            if (person != null) { person.Parents = parents; }
            if (sister != null) { sister.Parents = parents; }
            if (brother != null) { brother.Parents = parents; }
        }
        public static People BuildPeople()
        {
            People People = new People();

            Person Father, Mother;
            Person Person, Brother, Sister;

            Father = Factory.NewMan(People, "Father", 79);
            Mother = Factory.NewWoman(People, "Mother", 77);
            Person = Factory.NewMan(People, "Person", 60);
            Brother = Factory.NewMan(People, "Brother", 59);
            Sister = Factory.NewWoman(People, "Sister", 58);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            Father = Person;
            Mother = Factory.NewWoman(People, "Spouse", 57);
            Person = null;
            Brother = Factory.NewMan(People, "Son", 40);
            Sister = Factory.NewWoman(People, "Daughter", 39);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            return People;
        }

        public static People BuildExtendedPeople()
        {
            People People = new People();

            Person Person, Brother, Sister;
            Person Father, FatherBrother, FatherSister;
            Person Mother, MotherBrother, MotherSister;
            Person Me, MyFather, MyMother, MyBrother, MySister, MySon, MyDaughter;
            Person Spouse, SpouseFather, SpouseMother, SpouseBrother, SpouseSister;

#region "Father's Family"
            Father = Factory.NewMan(People, "Father's Father", 99);
            Mother = Factory.NewWoman(People, "Father's Mother", 98);
            Person = Factory.NewMan(People, "Father", 79);
            Brother = Factory.NewMan(People, "Father's Brother", 78);
            Sister = Factory.NewWoman(People, "Father's Sister", 77);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
            MyFather = Person;
            FatherBrother = Brother;
            FatherSister = Sister;

            Father = FatherBrother;
            Mother = Factory.NewWoman(People, "Father's Brother's Spouse", 77);
            Person = null;
            Brother = Factory.NewMan(People, "Father's Brother's Son", 56);
            Sister = Factory.NewWoman(People, "Father's Brother's Daughter", 55);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            Father = Factory.NewMan(People, "Father's Sister's Spouse", 76);
            Mother = FatherSister;
            Person = null;
            Brother = Factory.NewMan(People, "Father's Sister's Son", 54);
            Sister = Factory.NewWoman(People, "Father's Sister's Daughter", 53);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

#endregion
#region "Mother's Family"
            Father = Factory.NewMan(People, "Mother's Father", 97);
            Mother = Factory.NewWoman(People, "Mother's Mother", 96);
            Person = Factory.NewWoman(People, "Mother", 77);
            Brother = Factory.NewMan(People, "Mother's Brother", 74);
            Sister = Factory.NewWoman(People, "Mother's Sister", 73);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
            MyMother = Person;
            MotherBrother = Brother;
            MotherSister = Sister;

            Father = MotherBrother;
            Mother = Factory.NewWoman(People, "Mother's Brother's Spouse", 76);
            Person = null;
            Brother = Factory.NewMan(People, "Mother's Brother's Son", 52);
            Sister = Factory.NewWoman(People, "Mother's Brother's Daughter", 51);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            Father = Factory.NewMan(People, "Mother's Sister's Spouse", 76);
            Mother = MotherSister;
            Person = null;
            Brother = Factory.NewMan(People, "Mother's Sister's Son", 54);
            Sister = Factory.NewWoman(People, "Mother's Sister's Daughter", 53);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

#endregion
#region "Spouse's Father's Family"
            Father = Factory.NewMan(People, "Father-Inlaw's Father", 95);
            Mother = Factory.NewWoman(People, "Father-Inlaw's Mother", 94);
            Person = Factory.NewMan(People, "Father-Inlaw", 75);
            Brother = Factory.NewMan(People, "Father-Inlaw's Brother", 74);
            Sister = Factory.NewWoman(People, "Father-Inlaw's Sister", 73);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
            SpouseFather = Person;
            FatherBrother = Brother;
            FatherSister = Sister;

            Father = FatherBrother;
            Mother = Factory.NewWoman(People, "Father-Inlaw's Brother's Spouse", 77);
            Person = null;
            Brother = Factory.NewMan(People, "Father-Inlaw's Brother's Son", 54);
            Sister = Factory.NewWoman(People, "Father-Inlaw's Brother's Daughter", 53);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            Father = Factory.NewMan(People, "Father-Inlaw's Sister's Spouse", 76);
            Mother = FatherSister;
            Person = null;
            Brother = Factory.NewMan(People, "Father-Inlaw's Sister's Son", 52);
            Sister = Factory.NewWoman(People, "Father-Inlaw's Sister's Daughter", 51);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

#endregion
#region "Spouse's Mother's Family"
            Father = Factory.NewMan(People, "Mother-Inlaw's Father", 93); 
            Mother = Factory.NewWoman(People, "Mother-Inlaw's Mother", 92);
            Person = Factory.NewWoman(People, "Mother-Inlaw", 73);
            Brother = Factory.NewMan(People, "Mother-Inlaw's Brother", 72);
            Sister = Factory.NewWoman(People, "Mother-Inlaw's Sister", 71);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
            SpouseMother = Person;

            MotherBrother = Brother;
            MotherSister = Sister;
            Father = MotherBrother;
            Mother = Factory.NewWoman(People, "Mother-Inlaw's Brother's Spouse", 76);
            Person = null;
            Brother = Factory.NewMan(People, "Mother-Inlaw's Brother's Son", 52);
            Sister = Factory.NewWoman(People, "Mother-Inlaw's Brother's Daughter", 51);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            Father = Factory.NewMan(People, "Mother-Inlaw's Sister's Spouse", 76);
            Mother = MotherSister;
            Person = null;
            Brother = Factory.NewMan(People, "Mother-Inlaw's Sister's Son", 54);
            Sister = Factory.NewWoman(People, "Mother-Inlaw's Sister's Daughter", 53);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

#endregion
#region "Our Family"
            Father = MyFather;
            Mother = MyMother;
            Person = Factory.NewMan(People, "Person", 60);
            Brother = Factory.NewMan(People, "Brother", 59);
            Sister = Factory.NewWoman(People, "Sister", 58);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
            Me=Person;
            MyBrother = Brother;
            MySister = Sister;

            Father = MyBrother;
            Mother = Factory.NewWoman(People, "Brother's Spouse", 57);
            Person = null;
            Brother = Factory.NewMan(People, "Brother's Son", 36);
            Sister = Factory.NewWoman(People, "Brother's Daughter", 37);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            Father = Factory.NewMan(People, "Sister's Spouse", 56);
            Mother = MySister;
            Person = null;
            Brother = Factory.NewMan(People, "Sister's Son", 34);
            Sister = Factory.NewWoman(People, "Sister's Daughter", 33);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
#endregion
#region "Spouse's Family"
            Father = SpouseFather;
            Mother = SpouseMother;
            Person = Factory.NewWoman(People, "Spouse", 57);
            Brother = Factory.NewMan(People, "Spouse's Brother", 56);
            Sister = Factory.NewWoman(People, "Spouse's Sister", 55);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
            Spouse = Person;
            SpouseBrother = Brother;
            SpouseSister = Sister;

            Father = SpouseBrother;
            Mother = Factory.NewWoman(People, "Spouse's Brother's Spouse", 57);
            Person = null;
            Brother = Factory.NewMan(People, "Spouse's Brother's Son", 36);
            Sister = Factory.NewWoman(People, "Spouse's Brother's Daughter", 37);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);

            Father = Factory.NewMan(People, "Spouse's Sister's Spouse", 56);
            Mother = SpouseSister;
            Person = null;
            Brother = Factory.NewMan(People, "Spouse's Sister's Son", 34);
            Sister = Factory.NewWoman(People, "Spouse's Sister's Daughter", 33);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
#endregion
#region "My Family"
            Father = Me;
            Mother = Spouse;
            Person = null;
            Brother = Factory.NewMan(People, "Son", 40);
            Sister = Factory.NewWoman(People, "Daughter", 39);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
            Me = Person;
            MySon = Brother;
            MyDaughter = Sister;
#endregion
#region "My Son's Family"
            Father = MySon;
            Mother = Factory.NewWoman(People, "Son's Spouse", 39); 
            Person = null;
            Brother = Factory.NewMan(People, "Son's Son", 20);
            Sister = Factory.NewWoman(People, "Son's Daughter", 19);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
#endregion
#region "My Daughter's Family"
            Father = Factory.NewMan(People, "Daughter's Spouse", 38);
            Mother = MyDaughter;
            Person = null;
            Brother = Factory.NewMan(People, "Daughter's Son", 20);
            Sister = Factory.NewWoman(People, "Daughter's Daughter", 19);
            Factory.AsFamily(Father, Mother, Person, Brother, Sister);
#endregion
            return People;
        }
    }

}
"@

#region Get-Parents - Get-GrandParents - Get-GreatGrandParents - Get-GreatGreatGrandParents
Function Get-Parents
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | % { $_.Parents} 
    }
 }

Function Get-GrandParents
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Parents | Get-Parents
    }
 }

Function Get-GreatGrandParents
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-GrandParents | Get-Parents
    }
 }

Function Get-GreatGreatGrandParents
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-GreatGrandParents | Get-Parents
    }
 }
#endregion

#region Get-Children - Get-GrandChildren - Get-GreatGrandChildren - Get-GreatGreatGrandChildren
Function Get-Children
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | % { $_.Children} 
    }
 }

Function Get-GrandChildren
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Children | Get-Children
    }
 }

Function Get-GreatGrandChildren
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-GrandChildren | Get-Children
    }
 }

Function Get-GreatGreatGrandChildren
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-GreatGrandChildren | Get-Children
    }
 }
#endregion

#region Get-Males - Get-Females
Function Get-Males
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Where { $_.IsMale} 
    }
 }

Function Get-Females
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Where { $_.IsFemale} 
    }
 }
#endregion

#region Get-Sons - Get-Daughters - Get-GrandSons - Get-GrandDaughters
Function Get-Sons
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Children | Get-Males
    }
 }
Function Get-Daughters
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Children | Get-Females
    }
 }
Function Get-GrandSons
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-GrandChildren | Get-Males
    }
 }
Function Get-GrandDaughters
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-GrandChildren | Get-Females
    }
 }
#endregion

#region Get-Siblings - Get-Brothers - Get-Sisters
Function Get-Siblings
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | % { $_.Siblings}
    }
 }

Function Get-Brothers
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Siblings | Get-Males
    }
 }

Function Get-Sisters
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Siblings | Get-Females
    }
 }
#endregion

#region Get-Aunts - Get-Uncles - Get-Cousins - Get-Nephews - Get-Nieces
Function Get-Aunts
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Parents | Get-Sisters
    }
 }

Function Get-Uncles
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Parents | Get-Brothers
    }
 }

Function Get-Cousins
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Parents | Get-Siblings | Get-Children
    }
 }

Function Get-Nephews
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Siblings | Get-Sons
    }
 }

Function Get-Nieces
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Person | Get-Siblings | Get-Daughters
    }
 }
#endregion

#region Get-Ancestors - Get-Descendants
Function Get-Ancestors
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Parents = $Person | Get-Parents
       IF ($Parents -NE $Null)
       {
          $Parents
          Get-Ancestors $Parents
       }
    }
 }

Function Get-Descendants 
{
    [CmdletBinding()]
    Param([Parameter(Mandatory=$true, 
                     ValueFromPipeline=$true,
                     ValueFromPipelineByPropertyName=$true)]
          [Object]$Person
    )
    Process 
    { 
       $Children = $Person | Get-Children
       IF ($Children -NE $Null)
       {
          $Children
          Get-Descendants $Children
       }
    }
 }

#endregion

Add-Type -TypeDefinition $PeopleDefinition
Remove-Variable PeopleDefinition
$People = [People.Factory]::BuildExtendedPeople()
$Person = $People["Person"]

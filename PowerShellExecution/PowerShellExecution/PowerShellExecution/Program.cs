using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace PowerShellExecution
{
    class Program
    {
        static void Main(string[] args)
        {

            using (PowerShell PowerShellInstance = PowerShell.Create())
            {
                var script = @"$PSVersionTable";

                // this script has a sleep in it to simulate a long running script
                PowerShellInstance.AddScript(script);

                // begin invoke execution on the pipeline
                IAsyncResult result = PowerShellInstance.BeginInvoke();

                // do something else until execution has completed.
                // this could be sleep/wait, or perhaps some other work
                while (result.IsCompleted == false)
                {
                    Console.WriteLine("Waiting for pipeline to finish...");
                    Thread.Sleep(1000);

                    // might want to place a timeout here...
                }

                Console.WriteLine("Finished!");
                Console.ReadKey();
            }
        }
    }
}

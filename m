From: Milian Wolff <mail@milianw.de>
Subject: Re: Size of perf data files
Date: Wed, 26 Nov 2014 19:11:01 +0100
Message-ID: <1439400.fEBkspRaxp@milian-kdab2>
References: <1601237.BEhNSa8l6d@milian-kdab2> <20141126160617.GD30226@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:44327 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbaKZSLF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Nov 2014 13:11:05 -0500
In-Reply-To: <20141126160617.GD30226@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Wednesday 26 November 2014 13:06:17 Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 26, 2014 at 01:47:41PM +0100, Milian Wolff escreveu:
> > I wonder whether there is a way to reduce the size of perf data files.
> > Esp.
> > when I collect call graph information via Dwarf on user space
> > applications, I easily end up with multiple gigabytes of data in just a
> > few seconds.
> > 
> > I assume currently, perf is built for lowest possible overhead in mind.
> > But
> > could maybe a post-processor be added, which can be run after perf is
> > finished collecting data, that aggregates common backtraces etc.?
> > Essentially what I'd like to see would be something similar to:
> > 
> > perf report --stdout | gzip > perf.report.gz
> > perf report -g graph --no-children -i perf.report.gz
> > 
> > Does anything like that exist yet? Or is it planned?
> 
> No, it doesn't, and yes, it would be something nice to have, i.e. one
> that would process the file, find the common backtraces, and for that
> probably we would end up using the existing 'report' logic and then
> refer to those common backtraces by some index into a new perf.data file
> section, perhaps we could use the features code for that...

Yes, this sounds excellent. Now someone just needs the time to implement this, 
damn ;-)

> But one thing you can do now to reduce the size of perf.data files with
> dwarf callchains is to reduce the userspace chunk it takes, what is
> exactly the 'perf record' command line you use?

So far, the default, since I assumed that was good enough:

perf record --call-graph dwarf <app +args|-p PID>

> The default is to get 8KB of userspace stack per sample, from
> 'perf record --help':
> 
>     -g             enables call-graph recording
>         --call-graph <mode[,dump_size]>
>                    setup and enables call-graph (stack chain/backtrace)
> recording: fp dwarf -v, --verbose  be more verbose (show counter open
> errors, etc)
> 
> So, please try with something like:
> 
>  perf record --call-graph dwarf,512
> 
> And see if it is enough for your workload and what kind of effect you
> notice on the perf.data file size. Play with that dump_size, perhaps 4KB
> would be needed if you have deep callchains, perhaps even less would do.

I tried this on a benchmark of mine:

before:
[ perf record: Woken up 196 times to write data ]
[ perf record: Captured and wrote 48.860 MB perf.data (~2134707 samples) ]

after, with dwarf,512
[ perf record: Woken up 18 times to write data ]
[ perf record: Captured and wrote 4.401 MB perf.data (~192268 samples) ]

What confuses me though is the number of samples. When the workload is equal, 
shouldn't the number of samples stay the same? Or what does this mean? The 
resulting reports both look similar enough.

But how do I know whether 512 is "enough for your workload" - do I get an 
error/warning message if that is not the case?

Anyhow, I'll use your command line in the future. Could this maybe be made the 
default?

> Something you can use to speed up the _report_ part is:
> 
>         --max-stack <n>   Set the maximum stack depth when parsing the
>                           callchain, anything beyond the specified depth
>                           will be ignored. Default: 127
> 
> But this won't reduce the perf.data file, obviously.

Thanks for the tip, but in the test above this does not make a difference for 
me:

milian@milian-kdab2:/ssd/milian/projects/.build/kde4/akonadi$ perf stat perf 
report -g graph --no-children -i perf.data --stdio > /dev/null
Failed to open [nvidia], continuing without symbols
Failed to open [ext4], continuing without symbols
Failed to open [scsi_mod], continuing without symbols

 Performance counter stats for 'perf report -g graph --no-children -i 
perf.data --stdio':

       1008.389483      task-clock (msec)         #    0.977 CPUs utilized          
               304      context-switches          #    0.301 K/sec                  
                15      cpu-migrations            #    0.015 K/sec                  
            54,965      page-faults               #    0.055 M/sec                  
     2,837,339,980      cycles                    #    2.814 GHz                     
[49.97%]
   <not supported>      stalled-cycles-frontend  
   <not supported>      stalled-cycles-backend   
     2,994,058,232      instructions              #    1.06  insns per cycle         
[75.08%]
       586,461,237      branches                  #  581.582 M/sec                   
[75.21%]
         6,526,482      branch-misses             #    1.11% of all branches         
[74.85%]

       1.032337255 seconds time elapsed

milian@milian-kdab2:/ssd/milian/projects/.build/kde4/akonadi$ perf stat perf 
report --max-stack 64 -g graph --no-children -i perf.data --stdio > /dev/null
Failed to open [nvidia], continuing without symbols
Failed to open [ext4], continuing without symbols
Failed to open [scsi_mod], continuing without symbols

 Performance counter stats for 'perf report --max-stack 64 -g graph --no-
children -i perf.data --stdio':

       1053.129822      task-clock (msec)         #    0.995 CPUs utilized          
               266      context-switches          #    0.253 K/sec                  
                 0      cpu-migrations            #    0.000 K/sec                  
            50,740      page-faults               #    0.048 M/sec                  
     2,965,952,028      cycles                    #    2.816 GHz                     
[50.10%]
   <not supported>      stalled-cycles-frontend  
   <not supported>      stalled-cycles-backend   
     3,153,423,696      instructions              #    1.06  insns per cycle         
[75.08%]
       618,865,595      branches                  #  587.644 M/sec                   
[75.27%]
         6,534,277      branch-misses             #    1.06% of all branches         
[74.79%]

       1.058710369 seconds time elapsed

Thanks
-- 
Milian Wolff
mail@milianw.de
http://milianw.de

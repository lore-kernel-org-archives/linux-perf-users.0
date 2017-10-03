From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 6/8] perf top: Implement multithreading for
 perf_event__synthesize_threads
Date: Tue, 3 Oct 2017 19:37:30 +0200
Message-ID: <20171003173729.k5xobn24qerr2tuw@gmail.com>
References: <20171003125540.331-1-acme@kernel.org>
 <20171003125540.331-7-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34809 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdJCRhe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Oct 2017 13:37:34 -0400
Content-Disposition: inline
In-Reply-To: <20171003125540.331-7-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Kan Liang <kan.liang@intel.com>
> 
> The proc files which is sorted with alphabetical order are evenly
> assigned to several synthesize threads to be processed in parallel.
> 
> For 'perf top', the threads number hard code to online CPU number. The
> following patch will introduce an option to set it.
> 
> For other perf tools, the thread number is 1. Because the process
> function is not ready for multithreading, e.g.
> process_synthesized_event.
> 
> This patch series only support event synthesize multithreading for 'perf
> top'. For other tools, it can be done separately later.

Just to give some quick feedback: this is really nice stuff!

Is anyone working on multi-threading 'perf record' (and the recording portion of 
'perf top' perhaps)?

Especially with complex, high-frequency profiling there's alot of SMP overhead 
coming from a single recording thread. If there was a single thread per CPU, and 
it truly only recorded the events from its own CPU, things would become a lot more 
scalable.

For example, if we measure the current overhead of perf record of a (limited) 
parallel kernel build:

  triton:~/tip> perf stat --no-inherit --pre "make clean >/dev/null 2>&1" perf record -F 10000 make -j kernel
  ...
  [ perf record: Captured and wrote 5.124 MB perf.data (108400 samples) ]

 Performance counter stats for 'perf record -F 10000 make -j kernel':

        183.582587      task-clock (msec)         #    0.039 CPUs utilized          
             2,496      context-switches          #    0.014 M/sec                  
               157      cpu-migrations            #    0.855 K/sec                  
             6,649      page-faults               #    0.036 M/sec                  
       817,478,151      cycles                    #    4.453 GHz                    
       416,641,913      stalled-cycles-frontend   #   50.97% frontend cycles idle   
     1,018,336,301      instructions              #    1.25  insn per cycle         
                                                  #    0.41  stalled cycles per insn
       217,255,137      branches                  # 1183.419 M/sec                  
         2,970,118      branch-misses             #    1.37% of all branches        

       4.710378510 seconds time elapsed

That's 1018336301 just to record 108400 samples, i.e. every sample takes 9,300 
instructions to _record_. That's insanely high overhead from what is in essence a 
tracing utility.


Even if I add "-B -N" to disable buildid generation (which is the worst offender), 
it's still very high overhead:

 [ perf record: Captured and wrote 5.585 MB perf.data ]

 Performance counter stats for 'perf record -B -N -F 10000 make -j kernel':

         45.625321      task-clock (msec)         #    0.009 CPUs utilized          
             2,950      context-switches          #    0.065 M/sec                  
               204      cpu-migrations            #    0.004 M/sec                  
             1,992      page-faults               #    0.044 M/sec                  
       193,127,853      cycles                    #    4.233 GHz                    
       117,098,418      stalled-cycles-frontend   #   60.63% frontend cycles idle   
       197,899,633      instructions              #    1.02  insn per cycle         
                                                  #    0.59  stalled cycles per insn
        41,221,863      branches                  #  903.487 M/sec                  
           502,158      branch-misses             #    1.22% of all branches        

       4.858962925 seconds time elapsed

... that's still 1,800+ instructions per event!

As a comparison, ftrace has a tracing overhead of less than 100 instructions per 
event.

Thanks,

	Ingo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4E1E529
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jan 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzb2QBrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF56C433C7;
	Fri, 12 Jan 2024 15:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705072701;
	bh=cyoFKDJwKlwWfdVSC4UDlCsz5aFY6MIAyF8OoPAC1OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tzb2QBrN1nlXWvKcxU6npNk3ZBcfz8gY0S0OGJZhBcYrKGCbyUJe8zsDkQTYahimM
	 5YsQGruhbr4Kw3ZPuxgE9+A0HgpBOO7cCcTkVF9jmqgGwdTj1WfKnYQfgsB5fx9Rgw
	 Mc4FPOlN9MedJx6JnwlJXxTjaCrd7kNcQuwE2KK4RHP58Fc+Tnu+XEWVYtKSSDd2t3
	 05hzzRCfsb/5lEzOWE2QPvtMHi3igSNpS4yGouqSjYaIAMj7ysP+I0mWSXoDuQxQ77
	 vmJg1canrYxG2nIuvpqHIkAepqC48V9gptoNWKFk64hhDQhjISODpw75Nb9pyd9QIt
	 a+liLMRIvu/4g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 95664403EF; Fri, 12 Jan 2024 12:18:18 -0300 (-03)
Date: Fri, 12 Jan 2024 12:18:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yuzhong Huang <yuzhongh@usc.edu>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Unable to run `perf stat` on Intel hybrid system with e-core
 (atom) disabled
Message-ID: <ZaFYOt5Wz4UFpymW@kernel.org>
References: <CAMRy72f0kF_8-BoJfb1_qmpgMLcNFmzPhYQaury_XeDnhPPXxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRy72f0kF_8-BoJfb1_qmpgMLcNFmzPhYQaury_XeDnhPPXxA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Sat, Dec 30, 2023 at 02:25:55AM -0800, Yuzhong Huang escreveu:
> Hi Linux Perf Users,
> 
> On my system (intel 12600k), if I disable the e-cores in bios, perf
> stat command would fail:
> > root@localhost:~# perf stat sleep 1
> > Error:
> > The sys_perf_event_open() syscall returned with 12 (Cannot allocate memory) for event (cpu_atom/cycles/).
> > /bin/dmesg | grep -i perf may provide additional information.
> 
> Looks like it's trying to read some counters from the e-core (atom). I
> have tried `perf stat --cputype=core  sleep 1`, still doesn't work.
> 
> I notice that if I do a system wide `perf stat`, it works as expected.
> Other perf tools like `perf record`, `perf top` all work as expected.
> 
> I have run `perf list`, which does include all kinds of events from
> e-core(atom), even though they have been disabled in the bios.
> 
> I wonder if there is a switch to get around this? For example to
> override the list of events. Or if it has to be fixed somewhere in the
> code, which file should I look at? I am happy to work on a patch.

Well, you can try asking explicitely for the events:

root@number:~# cat /sys/devices/cpu_core/cpus 
0-15
root@number:~# taskset --cpu-list 0-15 perf stat -e task-clock,context-switches,cpu-migrations,page-faults,cpu_core/cycles/,cpu_core/instructions/,cpu_core/branches/,cpu_core/branch-misses/ sleep 1

 Performance counter stats for 'sleep 1':

              0.32 msec task-clock                       #    0.000 CPUs utilized             
                 1      context-switches                 #    3.141 K/sec                     
                 0      cpu-migrations                   #    0.000 /sec                      
                70      page-faults                      #  219.852 K/sec                     
         1,224,616      cpu_core/cycles/                 #    3.846 GHz                       
         1,108,386      cpu_core/instructions/           #    3.481 G/sec                     
           228,392      cpu_core/branches/               #  717.321 M/sec                     
             6,995      cpu_core/branch-misses/          #   21.969 M/sec                     

       1.000733944 seconds time elapsed

       0.000568000 seconds user
       0.000000000 seconds sys


root@number:~#

Or perhaps even:

root@number:~# taskset --cpu-list 0-15 perf stat sleep 1

 Performance counter stats for 'sleep 1':

              0.30 msec task-clock                       #    0.000 CPUs utilized             
                 1      context-switches                 #    3.318 K/sec                     
                 0      cpu-migrations                   #    0.000 /sec                      
                69      page-faults                      #  228.948 K/sec                     
     <not counted>      cpu_atom/cycles/                                                        (0.00%)
         1,122,373      cpu_core/cycles/                 #    3.724 GHz                       
     <not counted>      cpu_atom/instructions/                                                  (0.00%)
         1,103,740      cpu_core/instructions/                                                
     <not counted>      cpu_atom/branches/                                                      (0.00%)
           225,963      cpu_core/branches/               #  749.764 M/sec                     
     <not counted>      cpu_atom/branch-misses/                                                 (0.00%)
             7,047      cpu_core/branch-misses/                                               
             TopdownL1 (cpu_core)                 #     29.3 %  tma_backend_bound      
                                                  #     11.5 %  tma_bad_speculation    
                                                  #     40.4 %  tma_frontend_bound     
                                                  #     18.8 %  tma_retiring           

       1.000696289 seconds time elapsed

       0.000570000 seconds user
       0.000000000 seconds sys


root@number:~#

Or perhaps:

root@number:~# taskset --cpu-list 0-15 perf stat -C 0-15 sleep 1
WARNING: A requested CPU in '0-15' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cpu_atom/TOPDOWN_RETIRING.ALL/'
WARNING: A requested CPU in '0-15' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'TOPDOWN_FE_BOUND.ALL'
WARNING: A requested CPU in '0-15' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'TOPDOWN_BE_BOUND.ALL'
WARNING: A requested CPU in '0-15' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cpu_atom/CPU_CLK_UNHALTED.CORE/'
WARNING: A requested CPU in '0-15' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'TOPDOWN_RETIRING.ALL'
WARNING: A requested CPU in '0-15' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cpu_atom/TOPDOWN_FE_BOUND.ALL/'
WARNING: A requested CPU in '0-15' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cpu_atom/TOPDOWN_BE_BOUND.ALL/'

 Performance counter stats for 'CPU(s) 0-15':

         16,026.51 msec cpu-clock                        #   15.994 CPUs utilized
               838      context-switches                 #   52.288 /sec
                26      cpu-migrations                   #    1.622 /sec
               860      page-faults                      #   53.661 /sec
   <not supported>      cpu_atom/cycles/
       262,965,507      cpu_core/cycles/                 #    0.016 GHz
   <not supported>      cpu_atom/instructions/
       237,584,876      cpu_core/instructions/
   <not supported>      cpu_atom/branches/
        45,808,011      cpu_core/branches/               #    2.858 M/sec
   <not supported>      cpu_atom/branch-misses/
         1,104,286      cpu_core/branch-misses/
             TopdownL1 (cpu_core)                 #     42.8 %  tma_backend_bound
                                                  #      7.5 %  tma_bad_speculation
                                                  #     34.9 %  tma_frontend_bound
                                                  #     14.9 %  tma_retiring

       1.002034581 seconds time elapsed

root@number:~#

That WARNING doesn't seem to make sense, we're explicitely asking for
just cpu_core ones :-\

Ian?

Also, is there a way to ask for metrics to be counted just on cpu_core?

root@number:~# taskset --cpu-list 0-15 perf stat -e task-clock,context-switches,cpu-migrations,page-faults,cpu_core/cycles/,cpu_core/instructions/,cpu_core/branches/,cpu_core/branch-misses/ -M TopdownL1 sleep 1

 Performance counter stats for 'sleep 1':

              0.33 msec task-clock                       #    0.000 CPUs utilized
                 1      context-switches                 #    3.057 K/sec
                 0      cpu-migrations                   #    0.000 /sec
                70      page-faults                      #  214.010 K/sec
         1,245,532      cpu_core/cycles/                 #    3.808 GHz
         1,117,650      cpu_core/instructions/           #    3.417 G/sec
           229,211      cpu_core/branches/               #  700.765 M/sec
             7,112      cpu_core/branch-misses/          #   21.743 M/sec
         7,473,192      cpu_core/TOPDOWN.SLOTS/          #     32.2 %  tma_backend_bound
                                                  #     10.4 %  tma_bad_speculation
                                                  #     40.6 %  tma_frontend_bound
                                                  #     16.9 %  tma_retiring
         1,260,185      cpu_core/topdown-retiring/
           761,972      cpu_core/topdown-bad-spec/
           263,759      cpu_core/topdown-heavy-ops/
         3,047,890      cpu_core/topdown-fe-bound/
         2,403,144      cpu_core/topdown-be-bound/
     <not counted>      cpu_atom/TOPDOWN_RETIRING.ALL/                                          (0.00%)
     <not counted>      cpu_atom/TOPDOWN_FE_BOUND.ALL/                                          (0.00%)
     <not counted>      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                          (0.00%)
     <not counted>      cpu_atom/CPU_CLK_UNHALTED.CORE/                                         (0.00%)
     <not counted>      cpu_atom/TOPDOWN_RETIRING.ALL/                                          (0.00%)
     <not counted>      cpu_atom/TOPDOWN_FE_BOUND.ALL/                                          (0.00%)
            11,655      cpu_core/INT_MISC.UOP_DROPPING/  #   35.633 M/sec
     <not counted>      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                          (0.00%)

       1.000732788 seconds time elapsed

       0.000000000 seconds user
       0.000606000 seconds sys


root@number:~#

Also would be interesting to provide some info on the output about
thread mode being used for some of the counters used in metrics:

root@number:~# taskset --cpu-list 0-15 perf stat -e task-clock,context-switches,cpu-migrations,page-faults,cpu_core/cycles/,cpu_core/instructions/,cpu_core/branches/,cpu_core/branch-misses/,cpu_core/topdown-retiring/,cpu_core/topdown-bad-spec/,cpu_core/topdown-heavy-ops/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/,cpu_core/INT_MISC.UOP_DROPPING/ sleep 1
WARNING: events were regrouped to match PMUs
Error:
Invalid event (cpu_core/topdown-retiring/) in per-thread mode, enable system wide with '-a'.
root@number:~# taskset --cpu-list 0-15 perf stat -e task-clock,context-switches,cpu-migrations,page-faults,cpu_core/cycles/,cpu_core/instructions/,cpu_core/branches/,cpu_core/branch-misses/,cpu_core/topdown-bad-spec/,cpu_core/topdown-heavy-ops/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/,cpu_core/INT_MISC.UOP_DROPPING/ sleep 1
WARNING: events were regrouped to match PMUs
Error:
Invalid event (cpu_core/topdown-bad-spec/) in per-thread mode, enable system wide with '-a'.
root@number:~# taskset --cpu-list 0-15 perf stat -e task-clock,context-switches,cpu-migrations,page-faults,cpu_core/cycles/,cpu_core/instructions/,cpu_core/branches/,cpu_core/branch-misses/,cpu_core/topdown-heavy-ops/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/,cpu_core/INT_MISC.UOP_DROPPING/ sleep 1
WARNING: events were regrouped to match PMUs
Error:
Invalid event (cpu_core/topdown-heavy-ops/) in per-thread mode, enable system wide with '-a'.
root@number:~# taskset --cpu-list 0-15 perf stat -e task-clock,context-switches,cpu-migrations,page-faults,cpu_core/cycles/,cpu_core/instructions/,cpu_core/branches/,cpu_core/branch-misses/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/,cpu_core/INT_MISC.UOP_DROPPING/ sleep 1
WARNING: events were regrouped to match PMUs
Error:
Invalid event (cpu_core/topdown-fe-bound/) in per-thread mode, enable system wide with '-a'.
root@number:~# taskset --cpu-list 0-15 perf stat -e task-clock,context-switches,cpu-migrations,page-faults,cpu_core/cycles/,cpu_core/instructions/,cpu_core/branches/,cpu_core/branch-misses/,cpu_core/topdown-be-bound/,cpu_core/INT_MISC.UOP_DROPPING/ sleep 1

 Performance counter stats for 'sleep 1':

              0.33 msec task-clock                       #    0.000 CPUs utilized
                 1      context-switches                 #    3.040 K/sec
                 0      cpu-migrations                   #    0.000 /sec
                69      page-faults                      #  209.746 K/sec
         1,219,634      cpu_core/cycles/                 #    3.707 GHz
         1,126,731      cpu_core/instructions/           #    3.425 G/sec
           231,144      cpu_core/branches/               #  702.629 M/sec
             6,999      cpu_core/branch-misses/          #   21.275 M/sec
   <not supported>      cpu_core/topdown-be-bound/
            11,832      cpu_core/INT_MISC.UOP_DROPPING/  #   35.967 M/sec

       1.000772605 seconds time elapsed

       0.000638000 seconds user
       0.000000000 seconds sys


root@number:~#

- Arnaldo

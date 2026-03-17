Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15CF344DB0;
	Tue, 17 Mar 2026 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777414; cv=none; b=F7MV4laElPQCKAF6RSq+FJQh4XVpbSip3qaHcmMK5sxZCheZAz6v9IuOcD5+/rL8T6nIYKaOmFwqnOe6nvppT2QhEwgPDVVdSaITlsvAozMg1eaOFRte9B3/OuRX+T+DUoTIHEPO47kqLLMboj0ROrVc1ybV7XUrJLbURqVquFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777414; c=relaxed/simple;
	bh=nr+0AF/LJGBs41F5SP1TU/89MmAfFCkTmhEWFAyGjfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig6rfEfl5BPf05x6rOmW1m0/f+aOPkhjxVdtvuElwLZ1kQXpX2OrtdtT+BraQZzwLs0TenoeiAGUczYPM6VZZEz2Y61pCwy0NaXCu4FdVXmZdNlPCP9UOQ3Mqd0dzeETxE5LsCwJ66dghQG806xDZPFk6IsA4UaKdCEEiomoKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOhGN3jH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOhGN3jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF077C2BC9E;
	Tue, 17 Mar 2026 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777414;
	bh=nr+0AF/LJGBs41F5SP1TU/89MmAfFCkTmhEWFAyGjfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOhGN3jHGGvYfml8pG6NmONvMRyAy+ZifzhL4queJ+Kcdi18CDia4528O1YICj28H
	 daRNE9s7apHACoaoYgAn19Ds27TwP2JuDV5guXapTv/KAAIBHYkKc57hYG6Zn2Xufa
	 E079pG8UXZzRbSdaarv94x9uxbKjLQifZ2Hvu6EZwZoTfmBWTDvAy82R0doHMfW2ju
	 Sx0aTkyKEYQ1hujHwjkwR9mA4uOkSAEG+NWBZGtc4QtFK1JLaylrfRlCy1VFEJPe9V
	 Z55KURZ+BxoqvXKKDQduo5TTURSZ0x+ZMPxmzc20U9sj8hoDoGNJ9G5otpMJfTG6V5
	 lLPMGum08CM6A==
Date: Tue, 17 Mar 2026 16:56:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, Jan Polensky <japo@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf stat issue with 7.0.0rc3
Message-ID: <abmyA5q9nXjagJIL@x1>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1>
 <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <abmt6FhLfWrzWGwU@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abmt6FhLfWrzWGwU@x1>

On Tue, Mar 17, 2026 at 04:39:24PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 13, 2026 at 08:41:48AM -0700, Ian Rogers wrote:
> > On Fri, Mar 13, 2026 at 8:19 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
> > > > I just discovered a strange behavior on linux 7.0.0rc3.
> > > > This is the epected output, however when I use the perf version 7.0.0rc3:
> 
> > > > bash-5.3# ./perf -v
> > > > perf version 7.0.rc3.g1f318b96cc84
> > > > bash-5.3# ./perf stat -- true
> > > > Error:
> > > > No supported events found.
> > > > trace.args_alignment
> 
> > > And this last line is even stranger, in my case I get something else,
> > > also on x86_64:
> 
> > > root@number:~#  perf stat -- true
> > > Error:
> > > No supported events found.
> > > addr2line.style
> > > root@number:~#
> 
> > > On an ARM machine:
> 
> > > acme@raspberrypi:~/git/perf-tools $ perf stat -- true
> > > Error:
> > > No supported events found.
> 
> > > acme@raspberrypi:~/git/perf-tools $ uname -a
> > > Linux raspberrypi 6.12.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.62-1+rpt1 (2025-12-18) aarch64 GNU/Linux
> > > acme@raspberrypi:~/git/perf-tools $
> 
> > > I'll try to bisect this later, thanks for the report!
>  
> > Hi Arnaldo,
>  
> > Leo has pointed at the fix:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/util/metricgroup.c?h=perf-tools-next&id=c5a244bf17caf2de22f9e100832b75f72b31d3e6
> > This also showed up as missing for the LTS backports:
> > https://lore.kernel.org/lkml/ad95d781-7eb2-4c0c-a9e9-aaabae8eb602@kernel.org/
> > so I thought it was flagged as a fix for the next PR. I don't see it in there:
> > https://lore.kernel.org/lkml/20260313151434.1695228-1-acme@kernel.org/
> > Could we get it in?
> 
> So, I applied the one Leo pointed out and got this:
> 
> root@number:~# perf stat sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>                  1      context-switches                 #   3509.1 cs/sec  cs_per_second
>                  0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
>                 75      page-faults                      # 263181.0 faults/sec  page_faults_per_second
>               0.28 msec task-clock                       #      0.0 CPUs  CPUs_utilized
>              8,018      branch-misses                    #      4.2 %  branch_miss_rate
>            191,108      branches                         #    670.6 M/sec  branch_frequency
>            870,234      cpu-cycles                       #      3.1 GHz  cycles_frequency
>      <not counted>      instructions                     #      nan instructions  insn_per_cycle  (0.00%)
>      <not counted>      stalled-cycles-frontend          #      nan frontend_cycles_idle        (0.00%)
> 
>        1.001839832 seconds time elapsed
> 
>        0.000727000 seconds user
>        0.000000000 seconds sys
> 
> 
> Some events weren't counted. Try disabling the NMI watchdog:
> 	echo 0 > /proc/sys/kernel/nmi_watchdog
> 	perf stat ...
> 	echo 1 > /proc/sys/kernel/nmi_watchdog
> root@number:~#  echo 0 > /proc/sys/kernel/nmi_watchdog
> 
> 
> Which is strange, in the past (see below) instructions and
> stalled-cycles-frontend were counted in the default (no -e) 'perf stat'
> set of events, now if I disable the nmi_watchdog I get 'instructions'
> back, but not 'stalled-cycles-frontend':
> 
> 
> root@number:~# perf stat sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>                  1      context-switches                 #   6524.7 cs/sec  cs_per_second
>                  0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
>                 71      page-faults                      # 463256.0 faults/sec  page_faults_per_second
>               0.15 msec task-clock                       #      0.0 CPUs  CPUs_utilized
>              7,484      branch-misses                    #      4.0 %  branch_miss_rate
>            186,108      branches                         #   1214.3 M/sec  branch_frequency
>            810,475      cpu-cycles                       #      5.3 GHz  cycles_frequency
>            893,290      instructions                     #      1.1 instructions  insn_per_cycle
>      <not counted>      stalled-cycles-frontend          #      nan frontend_cycles_idle        (0.00%)
> 
>        1.000382345 seconds time elapsed
> 
>        0.000443000 seconds user
>        0.000000000 seconds sys
> 
> 
> If I go back to v6.18 (will try a bisect to see exactly where this
> happens), I get the events above, with a different printing order, but
> 'instructions' and 'stalled-cycles-frontend' successfully counts:
> 
> root@number:~# perf -v
> perf version 6.18.g7d0a66e4bb90
> root@number:~# perf stat sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>            202,103      task-clock                       #    0.000 CPUs utilized
>                  1      context-switches                 #    4.948 K/sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 71      page-faults                      #  351.306 K/sec
>            895,485      instructions                     #    0.85  insn per cycle
>                                                   #    0.56  stalled cycles per insn
>          1,048,898      cycles                           #    5.190 GHz
>            504,794      stalled-cycles-frontend          #   48.13% frontend cycles idle
>            186,002      branches                         #  920.333 M/sec
>              7,857      branch-misses                    #    4.22% of all branches
> 
>        1.000537221 seconds time elapsed
> 
>        0.000542000 seconds user
>        0.000000000 seconds sys
> 
> 
> root@number:~#
> 
> Trying bisection now.

Its related to that:

a3248b5b5427dc2126c19aa9c32f1e840b65024f is the first bad commit
commit a3248b5b5427dc2126c19aa9c32f1e840b65024f
Author: Ian Rogers <irogers@google.com>
Date:   Tue Nov 11 13:21:52 2025 -0800

    perf jevents: Add metric DefaultShowEvents

    Some Default group metrics require their events showing for
    consistency with perf's previous behavior. Add a flag to indicate when
    this is the case and use it in stat-display.

root@number:~# strace -e perf_event_open perf stat sleep 1
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_SW_CONTEXT_SWITCHES, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 3
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_SW_CPU_MIGRATIONS, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 4
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_SW_PAGE_FAULTS, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 5
perf_event_open({type=PERF_TYPE_SOFTWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_SW_TASK_CLOCK, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 7
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xc3, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 8
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_BRANCH_INSTRUCTIONS, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, 8, PERF_FLAG_FD_CLOEXEC) = 9
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_BRANCH_INSTRUCTIONS, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 10
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 11
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 12
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xc0, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, 12, PERF_FLAG_FD_CLOEXEC) = 13
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 14
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0xa9, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, 14, PERF_FLAG_FD_CLOEXEC) = 15
perf_event_open({type=PERF_TYPE_RAW, size=PERF_ATTR_SIZE_VER9, config=0x76, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = 16
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, inherit=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, 16, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
perf_event_open({type=PERF_TYPE_HARDWARE, size=PERF_ATTR_SIZE_VER9, config=PERF_COUNT_HW_STALLED_CYCLES_BACKEND, sample_period=0, sample_type=PERF_SAMPLE_IDENTIFIER, read_format=PERF_FORMAT_TOTAL_TIME_ENABLED|PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP, disabled=1, inherit=1, enable_on_exec=1, precise_ip=0 /* arbitrary skid */, ...}, 249821, -1, -1, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=249821, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---

 Performance counter stats for 'sleep 1':

                 1      context-switches                 #   3356.1 cs/sec  cs_per_second     
                 0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
                74      page-faults                      # 248352.1 faults/sec  page_faults_per_second
              0.30 msec task-clock                       #      0.0 CPUs  CPUs_utilized       
             7,566      branch-misses                    #      4.0 %  branch_miss_rate       
           189,307      branches                         #    635.3 M/sec  branch_frequency   
           798,790      cpu-cycles                       #      2.7 GHz  cycles_frequency     
           908,746      instructions                     #      1.1 instructions  insn_per_cycle
     <not counted>      stalled-cycles-frontend          #      nan frontend_cycles_idle        (0.00%)

       1.000722079 seconds time elapsed

       0.000000000 seconds user
       0.000714000 seconds sys


--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=249820, si_uid=0} ---
+++ exited with 0 +++
root@number:~#

It is not trying PERF_COUNT_HW_STALLED_CYCLES_FRONTEND, is asking for
PERF_COUNT_HW_STALLED_CYCLES_BACKEND instead...

- Arnaldo

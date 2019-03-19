From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 02/10] perf, tools, stat: Avoid memory overrun with -r
Date: Tue, 19 Mar 2019 16:14:52 -0300
Message-ID: <20190319191452.GM3029@kernel.org>
References: <20190314225002.30108-1-andi@firstfloor.org>
 <20190314225002.30108-2-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190314225002.30108-2-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Mar 14, 2019 at 03:49:54PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When -r is used memory would get corrupted because the evsel->id array
> would get overrun. evsel->ids is a running counter of the last id.
> Normally this works fine, but with -r the same event is initialized
> multiple times, but not this counter, so it would keep growing
> beyond the array limit and corrupt random memory.
> 
> Always reinitialize ->ids, and also add an assert to catch
> such overruns in the future.
> 
> This fixes a perf segfault when running it from toplev.
> 
> Before:
> 
> $ valgrind perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
> ==27012== Memcheck, a memory error detector
> ==27012== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==27012== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
> ==27012== Command: perf stat -r2 -e {cycles,cycles,cycles,cycles} true
> ==27012==
> ==27012== Invalid write of size 8
> ==27012==    at 0x33090F: perf_evlist__id_add_fd (in /usr/bin/perf)
> ==27012==    by 0x33C99B: perf_evsel__store_ids (in /usr/bin/perf)
> ==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
> ==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
> ==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
> ==27012==    by 0x29C7A9: main (in /usr/bin/perf)
> ==27012==  Address 0x13182be8 is 0 bytes after a block of size 8 alloc'd
> ==27012==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
> ==27012==    by 0x33C921: perf_evsel__store_ids (in /usr/bin/perf)
> ==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
> ==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
> ==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
> ==27012==    by 0x29C7A9: main (in /usr/bin/perf)
> ==27012==
> ...
> 
> After:
> 
> $ valgrind ./perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
> ==27026== Memcheck, a memory error detector
> ==27026== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==27026== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
> ==27026== Command: ./perf stat -r2 -e {cycles,cycles,cycles,cycles} true
> ==27026==
> 
>  Performance counter stats for 'true' (2 runs):

So, this made this break:

[root@quaco perf]# perf test backward
50: Read backward ring buffer                             : FAILED!
[root@quaco perf]# perf test -v backward
50: Read backward ring buffer                             :
--- start ---
test child forked, pid 11127
Using CPUID GenuineIntel-6-8E-A
registering plugin: /root/.traceevent/plugins/plugin_cfg80211.so
registering plugin: /root/.traceevent/plugins/plugin_kvm.so
registering plugin: /root/.traceevent/plugins/plugin_function.so
registering plugin: /root/.traceevent/plugins/plugin_scsi.so
registering plugin: /root/.traceevent/plugins/plugin_jbd2.so
registering plugin: /root/.traceevent/plugins/plugin_sched_switch.so
registering plugin: /root/.traceevent/plugins/plugin_xen.so
registering plugin: /root/.traceevent/plugins/plugin_kmem.so
registering plugin: /root/.traceevent/plugins/plugin_hrtimer.so
registering plugin: /root/.traceevent/plugins/plugin_mac80211.so
mmap size 1052672B
mmap size 8192B
perf: util/evlist.c:533: perf_evlist__id_add: Assertion `evsel->ids < evsel->sample_id->max_x * evsel->sample_id->max_y' failed.
test child interrupted
---- end ----
Read backward ring buffer: FAILED!


I'm removing it till we go thru it to figure out what is the best way to
go, not to get in the way of the other patches going upstream.

- Arnaldo

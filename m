From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace report with time consumed
Date: Wed, 30 Mar 2016 11:53:14 -0300
Message-ID: <20160330145314.GE3420@kernel.org>
References: <1894563.GPSC8z33rH@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54437 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939AbcC3OxT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 30 Mar 2016 10:53:19 -0400
Content-Disposition: inline
In-Reply-To: <1894563.GPSC8z33rH@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Em Tue, Mar 29, 2016 at 10:39:36PM +0200, Milian Wolff escreveu:
> Hey all,
> 
> with "perf trace record --call-graph dwarf" I get a nice data file with 
> potentially everything required to find slow syscalls in user space 
> applications. But I'm missing a way to rewrite the data file to let "perf 
> report" attribute samples with the time spent as cost, instead of the raw 
> number of syscalls, i.e. samples.

Humm, perhaps use 'perf trace', maybe this is the push to add support for callgraphs there:


[root@jouet ~]# trace record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.026 MB perf.data (68 samples) ]
[root@jouet ~]# ls -la perf.data
-rw-------. 1 root root 34446 Mar 30 11:49 perf.data
[root@jouet ~]# trace -s -i perf.data

 Summary of events:

 sleep (1139), 67 events, 98.5%, 0.000 msec

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   read                   1     0.002     0.002     0.002     0.002      0.00%
   open                   3     0.017     0.005     0.006     0.006      3.14%
   close                  5     0.004     0.001     0.001     0.002     30.49%
   fstat                  3     0.003     0.001     0.001     0.002     22.16%
   mmap                   9     0.028     0.001     0.003     0.005     14.67%
   mprotect               4     0.018     0.003     0.005     0.007     17.07%
   munmap                 1     0.008     0.008     0.008     0.008      0.00%
   brk                    4     0.005     0.000     0.001     0.003     43.48%
   access                 1     0.005     0.005     0.005     0.005      0.00%
   nanosleep              1  1000.056  1000.056  1000.056  1000.056      0.00%
   arch_prctl             1     0.001     0.001     0.001     0.001      0.00%


[root@jouet ~]# trace -i perf.data
     0.021 ( 0.001 ms): sleep/1139 brk(                                                                  ) = 0x5619db285000
     0.036 ( 0.003 ms): sleep/1139 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f3e5264b000
     0.046 ( 0.005 ms): sleep/1139 access(filename: 0x52449e10, mode: R                                  ) = -1 ENOENT No such file or directory
     0.055 ( 0.005 ms): sleep/1139 open(filename: 0x52448761, flags: CLOEXEC                             ) = 4
     0.058 ( 0.002 ms): sleep/1139 fstat(fd: 4, statbuf: 0x7ffebed25ef0                                  ) = 0
     0.062 ( 0.004 ms): sleep/1139 mmap(len: 106798, prot: READ, flags: PRIVATE, fd: 4                   ) = 0x7f3e52630000
     0.063 ( 0.001 ms): sleep/1139 close(fd: 4                                                           ) = 0
     0.078 ( 0.006 ms): sleep/1139 open(filename: 0x5264b640, flags: CLOEXEC                             ) = 4
     0.081 ( 0.002 ms): sleep/1139 read(fd: 4, buf: 0x7ffebed26080, count: 832                           ) = 832
     0.083 ( 0.001 ms): sleep/1139 fstat(fd: 4, statbuf: 0x7ffebed25f30                                  ) = 0
     0.089 ( 0.004 ms): sleep/1139 mmap(len: 3934784, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 4   ) = 0x7f3e5206b000
     0.097 ( 0.007 ms): sleep/1139 mprotect(start: 0x7f3e52222000, len: 2097152                          ) = 0
     0.103 ( 0.005 ms): sleep/1139 mmap(addr: 0x7f3e52422000, len: 24576, prot: READ|WRITE, flags: PRIVATE|DENYWRITE|FIXED, fd: 4, off: 1798144) = 0x7f3e52422
     0.109 ( 0.003 ms): sleep/1139 mmap(addr: 0x7f3e52428000, len: 14912, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS|FIXED, fd: -1) = 0x7f3e52428000
     0.114 ( 0.001 ms): sleep/1139 close(fd: 4                                                           ) = 0
     0.126 ( 0.002 ms): sleep/1139 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f3e5262f000
     0.131 ( 0.002 ms): sleep/1139 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f3e5262e000
     0.134 ( 0.001 ms): sleep/1139 mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x7f3e5262d000
     0.136 ( 0.001 ms): sleep/1139 arch_prctl(option: 4098, arg2: 139905646913280, arg3: 3, arg4: 34, arg5: 4294967295) = 0
     0.201 ( 0.005 ms): sleep/1139 mprotect(start: 0x7f3e52422000, len: 16384, prot: READ                ) = 0
     0.224 ( 0.004 ms): sleep/1139 mprotect(start: 0x5619d955f000, len: 4096, prot: READ                 ) = 0
     0.229 ( 0.003 ms): sleep/1139 mprotect(start: 0x7f3e5264c000, len: 4096, prot: READ                 ) = 0
     0.239 ( 0.008 ms): sleep/1139 munmap(addr: 0x7f3e52630000, len: 106798                              ) = 0
     0.306 ( 0.001 ms): sleep/1139 brk(                                                                  ) = 0x5619db285000
     0.309 ( 0.003 ms): sleep/1139 brk(brk: 0x5619db2a6000                                               ) = 0x5619db2a6000
     0.310 ( 0.000 ms): sleep/1139 brk(                                                                  ) = 0x5619db2a6000
     0.320 ( 0.006 ms): sleep/1139 open(filename: 0x521f6e20, flags: CLOEXEC                             ) = 4
     0.325 ( 0.001 ms): sleep/1139 fstat(fd: 4, statbuf: 0x7f3e524279a0                                  ) = 0
     0.330 ( 0.004 ms): sleep/1139 mmap(len: 111950656, prot: READ, flags: PRIVATE, fd: 4                ) = 0x7f3e4b5a7000
     0.335 ( 0.001 ms): sleep/1139 close(fd: 4                                                           ) = 0
  1000.423 (1000.056 ms): sleep/1139 nanosleep(rqtp: 0x7ffebed266c0                                        ) = 0
  1000.440 ( 0.002 ms): sleep/1139 close(fd: 1                                                           ) = 0
  1000.443 ( 0.001 ms): sleep/1139 close(fd: 2                                                           ) = 0
  1000.447 ( 0.000 ms): sleep/1139 exit_group(                                                           
[root@jouet ~]# 

There is even:

[root@jouet ~]# trace --duration 1000 -i perf.data
  1000.423 (1000.056 ms): sleep/1139 nanosleep(rqtp: 0x7ffebed266c0) = 0
[root@jouet ~]# 

Having that with callgraph from userspace is what you're asking for, no?

'trace' here is just an alias for 'perf trace'.

- Arnaldo
 
> Is this functionality there already? Or do I have to write another "perf 
> inject" command, similar to "perf inject --sched-stat"?
> 
> Thanks
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts

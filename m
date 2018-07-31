From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf build: Fix installation directory for bpf
Date: Tue, 31 Jul 2018 10:20:42 -0300
Message-ID: <20180731132042.GA4909@kernel.org>
References: <20180731073254.91090-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180731073254.91090-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jul 31, 2018 at 09:32:54AM +0200, Thomas Richter escreveu:
> Output after using command ./perf test -Fv 40:
> echo '...[bpf-program-source]...' | /usr/bin/clang ... \
> 		 -I/root/lib/perf/include/bpf ...
>                              ^^^^^^^^^^^^
> ...
> [root@p23lp27 perf]# ./perf test -F 40
> 40: BPF filter                                            :
> 40.1: Basic BPF filtering                                 : Ok
> 40.2: BPF pinning                                         : Ok
> 40.3: BPF prologue generation                             : Ok
> 40.4: BPF relocation checker                              : Ok
> [root@p23lp27 perf]#

So, testing it:

[root@jouet perf]# cat tools/perf/examples/bpf/5sec.c
// SPDX-License-Identifier: GPL-2.0
/*
    Description:

    . Disable strace like syscall tracing (--no-syscalls), or try tracing
      just some (-e *sleep).

    . Attach a filter function to a kernel function, returning when it should
      be considered, i.e. appear on the output.

    . Run it system wide, so that any sleep of >= 5 seconds and < than 6
      seconds gets caught.

    . Ask for callgraphs using DWARF info, so that userspace can be unwound

    . While this is running, run something like "sleep 5s".

    . If we decide to add tv_nsec as well, then it becomes:

      int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)

      I.e. add where it comes from (rqtp->tv_nsec) and where it will be
      accessible in the function body (nsec)

    # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
         0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
                                           hrtimer_nanosleep ([kernel.kallsyms])
                                           __x64_sys_nanosleep ([kernel.kallsyms])
                                           do_syscall_64 ([kernel.kallsyms])
                                           entry_SYSCALL_64 ([kernel.kallsyms])
                                           __GI___nanosleep (/usr/lib64/libc-2.26.so)
                                           rpl_nanosleep (/usr/bin/sleep)
                                           xnanosleep (/usr/bin/sleep)
                                           main (/usr/bin/sleep)
                                           __libc_start_main (/usr/lib64/libc-2.26.so)
                                           _start (/usr/bin/sleep)
    ^C#

   Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
*/

#include <bpf.h>

int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
{
	return sec == 5;
}

license(GPL);
[root@jouet perf]# perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c
     0.000 perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe0) tv_sec=5
  3145.238 perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe0) tv_sec=5
^C[root@jouet perf]#

After it works just the same, thanks, applying.

I need to get the above testing process hooked up in 'perf test', so
that besides adding that -I/root/lib/perf/include/bpf we actually _try_
to include something from there from the /root/lib/perf/examples/bpf/
bpf example scripts.

- Arnaldo

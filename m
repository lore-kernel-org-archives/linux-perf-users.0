From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 2/2] perf: Fix bpf prologue generation
Date: Tue, 9 Jun 2020 12:27:14 -0300
Message-ID: <20200609152714.GE24868@kernel.org>
References: <20200609081019.60234-1-sumanthk@linux.ibm.com>
 <20200609081019.60234-3-sumanthk@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200609081019.60234-3-sumanthk@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, tmricht@linux.ibm.com, heiko.carstens@de.ibm.com, mhiramat@kernel.org, iii@linux.ibm.com, Steven Rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Jun 09, 2020 at 10:10:19AM +0200, Sumanth Korikkar escreveu:
> Issue:
> bpf_probe_read is no longer available for architecture which has
> overlapping address space. Hence bpf prologue generation fails
> 
> Fix:
> Use bpf_probe_read_kernel for kernel member access. For user
> attribute access in kprobes, use bpf_probe_read_user.
> 
> Other:
> @user attribute was introduced in commit 1e032f7cfa14 ("perf-probe:
>  Add user memory access attribute support")
> 
> Test:
> 1. ulimit -l 128 ; ./perf record -e tests/bpf_sched_setscheduler.c
> 2. cat tests/bpf_sched_setscheduler.c
> 
> static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
>         (void *) 6;
> static int (*bpf_probe_read_user)(void *dst, __u32 size,
>                                   const void *unsafe_ptr) = (void *) 112;
> static int (*bpf_probe_read_kernel)(void *dst, __u32 size,
>         const void *unsafe_ptr) = (void *) 113;
> 
> SEC("func=do_sched_setscheduler  pid policy param->sched_priority@user")
> int bpf_func__setscheduler(void *ctx, int err, pid_t pid, int policy,
>                            int param)
> {
>         char fmt[] = "prio: %ld";
>         bpf_trace_printk(fmt, sizeof(fmt), param);
>         return 1;
> }
> 
> char _license[] SEC("license") = "GPL";
> int _version SEC("version") = LINUX_VERSION_CODE;
> 
> 3. ./perf script
>    sched 305669 [000] 1614458.838675: perf_bpf_probe:func: (2904e508)
>    pid=261614 policy=2 sched_priority=1
> 
> 4. cat /sys/kernel/debug/tracing/trace
>    <...>-309956 [006] .... 1616098.093957: 0: prio: 1

Thanks for providing a detailed set of steps to test your patch, that is
great!

I added this, an alterenative way to test it, combining all the aspects
in one 'perf trace' call:

Committer testing:

I had to add some missing headers in the bpf_sched_setscheduler.c test
proggie, then instead of using record+script I used 'perf trace' to
drive everything in one go:

  # cat bpf_sched_setscheduler.c
  #include <linux/types.h>
  #include <bpf.h>

  static void (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) = (void *) 6;
  static int (*bpf_probe_read_user)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) 112;
  static int (*bpf_probe_read_kernel)(void *dst, __u32 size, const void *unsafe_ptr) = (void *) 113;

  SEC("func=do_sched_setscheduler  pid policy param->sched_priority@user")
  int bpf_func__setscheduler(void *ctx, int err, pid_t pid, int policy, int param)
  {
          char fmt[] = "prio: %ld";
          bpf_trace_printk(fmt, sizeof(fmt), param);
          return 1;
  }

  char _license[] SEC("license") = "GPL";
  int _version SEC("version") = LINUX_VERSION_CODE;
  #
  #
  # perf trace -e bpf_sched_setscheduler.c chrt -f 42 sleep 1
     0.000 chrt/80125 perf_bpf_probe:func(__probe_ip: -1676607808, policy: 1, sched_priority: 42)
  #

And even with backtraces :-)

  # perf trace -e bpf_sched_setscheduler.c/max-stack=8/ chrt -f 42 sleep 1
       0.000 chrt/79805 perf_bpf_probe:func(__probe_ip: -1676607808, policy: 1, sched_priority: 42)
                                         do_sched_setscheduler ([kernel.kallsyms])
                                         __x64_sys_sched_setscheduler ([kernel.kallsyms])
                                         do_syscall_64 ([kernel.kallsyms])
                                         entry_SYSCALL_64 ([kernel.kallsyms])
                                         __GI___sched_setscheduler (/usr/lib64/libc-2.30.so)
  # 

- Arnaldo

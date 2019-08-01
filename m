From: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 01/12] tools include UAPI: Sync x86's syscalls_64.tbl and
 generic unistd.h to pick up clone3 and pidfd_open
Date: Thu, 1 Aug 2019 21:54:09 +0200
Message-ID: <20190801195407.hdek7qyrgjmaf4m5@brauner.io>
References: <20190729211456.6380-1-acme@kernel.org>
 <20190729211456.6380-2-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729211456.6380-2-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Jul 29, 2019 at 06:14:48PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
>   05a70a8ec287 ("unistd: protect clone3 via __ARCH_WANT_SYS_CLONE3")
>   8f3220a80654 ("arch: wire-up clone3() syscall")
>   7615d9e1780e ("arch: wire-up pidfd_open()")
> 
> Silencing the following tools/perf build warnings
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
>   diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
>   Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
> 
> Now 'perf trace -e pidfd*,clone*' will trace those syscalls as well as the
> others with those prefixes.
> 
>   $ diff -u /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
>   --- /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before	2019-07-26 12:24:55.020944201 -0300
>   +++ /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c	2019-07-26 12:25:03.919047217 -0300
>   @@ -344,5 +344,7 @@
>         [431] = "fsconfig",
>         [432] = "fsmount",
>         [433] = "fspick",
>   +     [434] = "pidfd_open",
>   +     [435] = "clone3",
>    };
>   -#define SYSCALLTBL_x86_64_MAX_ID 433
>   +#define SYSCALLTBL_x86_64_MAX_ID 435
>   $
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-0isnnqxtr1ihz6p8wzjiy47d@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> ---
>  tools/include/uapi/asm-generic/unistd.h           | 8 +++++++-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
> index a87904daf103..1be0e798e362 100644
> --- a/tools/include/uapi/asm-generic/unistd.h
> +++ b/tools/include/uapi/asm-generic/unistd.h
> @@ -844,9 +844,15 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
>  __SYSCALL(__NR_fsmount, sys_fsmount)
>  #define __NR_fspick 433
>  __SYSCALL(__NR_fspick, sys_fspick)
> +#define __NR_pidfd_open 434
> +__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
> +#ifdef __ARCH_WANT_SYS_CLONE3
> +#define __NR_clone3 435
> +__SYSCALL(__NR_clone3, sys_clone3)
> +#endif
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 434
> +#define __NR_syscalls 436
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> index b4e6f9e6204a..c29976eca4a8 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -355,6 +355,8 @@
>  431	common	fsconfig		__x64_sys_fsconfig
>  432	common	fsmount			__x64_sys_fsmount
>  433	common	fspick			__x64_sys_fspick
> +434	common	pidfd_open		__x64_sys_pidfd_open
> +435	common	clone3			__x64_sys_clone3/ptregs
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> -- 
> 2.21.0
> 

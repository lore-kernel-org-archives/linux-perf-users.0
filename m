From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] perf build: Allow explicitely disabling the
 NO_SYSCALL_TABLE variable
Date: Fri, 29 May 2020 20:07:17 +0200
Message-ID: <20200529180717.GF506785@krava>
References: <20200529155552.463-1-acme@kernel.org>
 <20200529155552.463-3-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200529155552.463-3-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, May 29, 2020 at 12:55:52PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This is useful to see if, on x86, the legacy libaudit still works, as it
> is used in architectures that don't have the SYSCALL_TABLE logic and we
> want to have it tested in 'make -C tools/perf/ build-test'.
> 
> E.g.:
> 
> Without having audit-libs-devel installed:
> 
>   $ make NO_SYSCALL_TABLE=1 O=/tmp/build/perf -C tools/perf install-bin
>   make: Entering directory '/home/acme/git/perf/tools/perf'
>     BUILD:   Doing 'make -j12' parallel build
>   <SNIP>
>   Auto-detecting system features:
>   <SNIP>
>   ...                      libaudit: [ OFF ]
>   ...                        libbfd: [ on  ]
>   ...                        libcap: [ on  ]
>   <SNIP>
>   Makefile.config:664: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
>   <SNIP>
> 
> After installing it:
> 
>   $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
>   $ time make NO_SYSCALL_TABLE=1 O=/tmp/build/perf  -C tools/perf install-bin ; perf test python

heya,
seems ok, perhaps also put it in comment to Makefile.perf
among other NO_* stuff and to tests/make

jirka

>   make: Entering directory '/home/acme/git/perf/tools/perf'
>     BUILD:   Doing 'make -j12' parallel build
>     HOSTCC   /tmp/build/perf/fixdep.o
>     HOSTLD   /tmp/build/perf/fixdep-in.o
>     LINK     /tmp/build/perf/fixdep
>   Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
>   diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>   Warning: Kernel ABI header at 'tools/perf/util/hashmap.c' differs from latest version at 'tools/lib/bpf/hashmap.c'
>   diff -u tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
> 
>   Auto-detecting system features:
>   <SNIP>
>   ...                      libaudit: [ on  ]
>   ...                        libbfd: [ on  ]
>   ...                        libcap: [ on  ]
>   <SNIP>
>   $ ldd ~/bin/perf | grep audit
>   	libaudit.so.1 => /lib64/libaudit.so.1 (0x00007fc18978e000)
>   $
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.config | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 93fb7510a9a9..6bc9251f1634 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -24,20 +24,22 @@ $(call detected_var,SRCARCH)
>  
>  NO_PERF_REGS := 1
>  
> -NO_SYSCALL_TABLE := 1
> +ifneq ($(NO_SYSCALL_TABLE),1)
> +  NO_SYSCALL_TABLE := 1
>  
> -ifeq ($(SRCARCH),x86)
> -  ifeq (${IS_64_BIT}, 1)
> -    NO_SYSCALL_TABLE := 0
> -  endif
> -else
> -  ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
> -    NO_SYSCALL_TABLE := 0
> +  ifeq ($(SRCARCH),x86)
> +    ifeq (${IS_64_BIT}, 1)
> +      NO_SYSCALL_TABLE := 0
> +    endif
> +  else
> +    ifneq ($(SRCARCH),$(filter $(SRCARCH),powerpc arm64 s390))
> +      NO_SYSCALL_TABLE := 0
> +    endif
>    endif
> -endif
>  
> -ifneq ($(NO_SYSCALL_TABLE),1)
> -  CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> +  ifneq ($(NO_SYSCALL_TABLE),1)
> +    CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> +  endif
>  endif
>  
>  # Additional ARCH settings for ppc
> -- 
> 2.25.3
> 

From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: linux-next: Tree for Nov 20
Date: Wed, 20 Nov 2019 16:52:28 +0530
Message-ID: <CA+G9fYufQjPVsDATdyDn+xtxD1FrwnVGKJ+bpVAxvoropJ=7hg@mail.gmail.com>
References: <20191120203434.2a0727b3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191120203434.2a0727b3@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-perf-users.vger.kernel.org

Perf build failed on linux next for i386 and armv7.

On Wed, 20 Nov 2019 at 15:04, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Changes since 20191119:
>
> The net tree gained a conflict against Linus' tree.
>
> Non-merge commits (relative to Linus' tree): 11697
>  10361 files changed, 506041 insertions(+), 224327 deletions(-)

i386 build failed log,
---------------------------
 In file included from libbpf.c:52:0:
 libbpf.c: In function 'bpf_program__collect_reloc':
 libbpf_internal.h:59:22: error: format '%lu' expects argument of type
 'long unsigned int', but argument 3 has type 'Elf64_Addr {aka long
long unsigned int}' [-Werror=format=]
   libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                       ^
 libbpf_internal.h:62:27: note: in expansion of macro '__pr'
  #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                            ^~~~
 libbpf.c:1874:5: note: in expansion of macro 'pr_warn'
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
      ^~~~~~~
 libbpf.c:1874:38: note: format string is defined here
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
                                     ~~^
                                     %llu
 Makefile:652: arch/x86/Makefile: No such file or directory
 cc1: all warnings being treated as errors

 find: unknown predicate `-m32/arch'

 Try 'find --help' for more information.
   CC       perf/1.0-r9/perf-1.0/staticobjs/libbpf_probes.o
 i686-linaro-linux-gcc: warning: '-x c' after last input file has no effect
   CC       perf/1.0-r9/perf-1.0/staticobjs/xsk.o
 i686-linaro-linux-gcc: error: unrecognized command line option
'-m32/include/uapi/asm-generic/errno.h'
 i686-linaro-linux-gcc: fatal error: no input files
 compilation terminated.

arm build log:
------------------
 Makefile:652: arch/arm/Makefile: No such file or directory
 In file included from libbpf.c:52:0:
 libbpf.c: In function 'bpf_program__collect_reloc':
 libbpf_internal.h:59:22: error: format '%lu' expects argument of type
 'long unsigned int', but argument 3 has type 'Elf64_Addr {aka long
long unsigned int}' [-Werror=format=]
   libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                       ^
 libbpf_internal.h:62:27: note: in expansion of macro '__pr'
  #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                            ^~~~
 libbpf.c:1874:5: note: in expansion of macro 'pr_warn'
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
      ^~~~~~~
 libbpf.c:1874:38: note: format string is defined here
      pr_warn("bad call relo offset: %lu\n", sym.st_value);
                                     ~~^
                                     %llu

ref:
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/650/consoleText
https://ci.linaro.org/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/650/consoleText

- Naresh

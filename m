From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 19/28] perf beauty: Wire up the mmap flags table
 generator to the Makefile
Date: Mon, 5 Nov 2018 07:44:33 -0800
Message-ID: <20181105154433.GA11115@roeck-us.net>
References: <20181031164508.4784-1-acme@kernel.org>
 <20181031164508.4784-20-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181031164508.4784-20-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Oct 31, 2018 at 01:44:59PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:
> 
>   $ cat /tmp/build/perf/trace/beauty/generated/mmap_flags_array.c
>   static const char *mmap_flags[] = {
> 	[ilog2(0x40) + 1] = "32BIT",
> 	[ilog2(0x01) + 1] = "SHARED",
> 	[ilog2(0x02) + 1] = "PRIVATE",
> 	[ilog2(0x10) + 1] = "FIXED",
> 	[ilog2(0x20) + 1] = "ANONYMOUS",
> 	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
> 	[ilog2(0x0100) + 1] = "GROWSDOWN",
> 	[ilog2(0x0800) + 1] = "DENYWRITE",
> 	[ilog2(0x1000) + 1] = "EXECUTABLE",
> 	[ilog2(0x2000) + 1] = "LOCKED",
> 	[ilog2(0x4000) + 1] = "NORESERVE",
> 	[ilog2(0x8000) + 1] = "POPULATE",
> 	[ilog2(0x10000) + 1] = "NONBLOCK",
> 	[ilog2(0x20000) + 1] = "STACK",
> 	[ilog2(0x40000) + 1] = "HUGETLB",
> 	[ilog2(0x80000) + 1] = "SYNC",
>   };
>   $
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-t3fn7u3tjsupio6e6vkufx9m@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.perf | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a31c5c29d53a..3ccb4f0bf088 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1,4 +1,5 @@
>  include ../scripts/Makefile.include
> +include ../scripts/Makefile.arch
>  
>  # The default target of this Makefile is...
>  all:
> @@ -385,6 +386,8 @@ export INSTALL SHELL_PATH
>  SHELL = $(SHELL_PATH)
>  
>  linux_uapi_dir := $(srctree)/tools/include/uapi/linux
> +asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
> +arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
>  

This doesn't work for me. With v4.20-rc1:

$ make ARCH=x86_64 defconfig
*** Default configuration is based on 'x86_64_defconfig'
#
# configuration written to .config
#
groeck@server:~/src/linux-staging$ make ARCH=x86_64 -j30 tools/perf
scripts/kconfig/conf  --syncconfig Kconfig
  BUILD:   Doing 'make -j16' parallel build
  HOSTCC   /home/groeck/src/linux-staging/tools/perf/fixdep.o
  HOSTLD   /home/groeck/src/linux-staging/tools/perf/fixdep-in.o
  LINK     /home/groeck/src/linux-staging/tools/perf/fixdep
Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/ioctls.h' differs from latest version at 'include/uapi/asm-generic/ioctls.h'
diff -u tools/include/uapi/asm-generic/ioctls.h include/uapi/asm-generic/ioctls.h
Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:851: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
make[4]: *** No rule to make target '/home/groeck/src/linux-staging/tools/arch/x86_64/include/uapi/asm//mman.h', needed by '/home/groeck/src/linux-staging/tools/perf/trace/beauty/generated/mmap_flags_array.c'.  Stop.
make[4]: *** Waiting for unfinished jobs....
  PERF_VERSION = 4.20.rc1.g6510223
Makefile.perf:206: recipe for target 'sub-make' failed
make[3]: *** [sub-make] Error 2
Makefile:69: recipe for target 'all' failed
make[2]: *** [all] Error 2
Makefile:77: recipe for target 'perf' failed
make[1]: *** [perf] Error 2
Makefile:1688: recipe for target 'tools/perf' failed
make: *** [tools/perf] Error 2
groeck@server:~/src/linux-staging$ ls tools/arch
alpha  arc  arm  arm64	h8300  hexagon	ia64  microblaze  mips	parisc	powerpc  s390  sh  sparc  x86  xtensa

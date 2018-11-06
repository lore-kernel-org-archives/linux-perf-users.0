From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/18] perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers
Date: Tue,  6 Nov 2018 09:06:10 -0300
Message-ID: <20181106120612.8262-17-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Guenter reported that using ARCH=x86_64 to build perf has regressed:

  $ make -C tools/perf O=/tmp/build/perf ARCH=x86_64
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j4' parallel build
    HOSTCC   /tmp/build/perf/fixdep.o
    HOSTLD   /tmp/build/perf/fixdep-in.o
    LINK     /tmp/build/perf/fixdep

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  <SNIP>
  ...                           bpf: [ on  ]

    GEN      /tmp/build/perf/common-cmds.h
  make[2]: *** No rule to make target '/home/acme/git/perf/tools/arch/x86_64/include/uapi/asm//mman.h', needed by '/tmp/build/perf/trace/beauty/generated/mmap_flags_array.c'.  Stop.
  make[2]: *** Waiting for unfinished jobs....
    PERF_VERSION = 4.19.gf6c23e3
  make[1]: *** [Makefile.perf:207: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $

This is because we must use $(SRCARCH) where we were using $(ARCH), so
that, just like the top level Makefile, we get this done:

  # Additional ARCH settings for x86
  ifeq ($(ARCH),i386)
          SRCARCH := x86
  endif
  ifeq ($(ARCH),x86_64)
          SRCARCH := x86
  endif

Which is done in tools/scripts/Makefile.arch, so switch to use
$(SRCARCH).

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: fbd7458db757 ("perf beauty: Wire up the mmap flags table generator to the Makefile")
Link: https://lkml.kernel.org/r/20181105184612.GD7077@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3ccb4f0bf088..d95655489f7e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -387,7 +387,7 @@ SHELL = $(SHELL_PATH)
 
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
-arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
+arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
-- 
2.14.4

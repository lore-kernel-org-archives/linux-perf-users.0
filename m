Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8101FF7CF;
	Tue,  3 Dec 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260115; cv=none; b=p3BO08I1peTb0J61gW/CmAxiVoR9eJsVvQjz52opKg1RGBMgBlbsoktxqgv/5NG9dW7J6tnq0AaHz1qrpZ5m6SLq8oNvY/GbgOfo5Es7regoTphC6pTYmbH8AJpQzfCvntN5miBihHkTI10R+bXH7zqbRpPZYjaUV5J8e+u/wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260115; c=relaxed/simple;
	bh=4fxsKITTX+Rs/Yqy21qGGSmQwsfRopyu1pynG7Pre7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pa3ctXTY1XmAc/+eSNpl1KnbbJJW2qTuMb71ENOQjG5tYdTgCgVDKJ8nWbXjRX8E/6ZW+C8xov+pfn8ir6wBa/ye72y56RQDZvuEs9kOKE/vafwd5Je4FVLhOxf+TFRkO8BQvgEpUf5wDqcXgB6HznqAy8BbO3Ak4zlCZZ0sn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlMepYra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlMepYra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230FAC4CECF;
	Tue,  3 Dec 2024 21:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733260114;
	bh=4fxsKITTX+Rs/Yqy21qGGSmQwsfRopyu1pynG7Pre7s=;
	h=Date:From:To:Cc:Subject:From;
	b=MlMepYrazVueV581SKGBYMlGSLbQLbidhR9aw3p59N0xzu8n86Nsj2s2lt5+u7PGm
	 bND1MnpFeZSNSAvgRFnk9krlr1Um6FJ2TBGUctxRynT5TwtqkaAOyHPix/D8Oewqy1
	 y2V3uHFch1jahajBUBnacKlYueY/lbM6PKdLx9eSHO+L6sA5cgBnndYEd3IloUkUwB
	 tnBfDJiX0cMhmfxz29LEZCuABPxspjTkALIYozvLU8w+ABZ5tFXRO7xlYL6aqFwlcF
	 twRMgxgPYa0y2FkCeSaY1qOuONVxwwVl+S63HjlwaG5g+fON/y5C3XNe9f8jWmCCe3
	 FXH1EoukIkG4Q==
Date: Tue, 3 Dec 2024 18:08:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 perf-tools-next] tools features: Don't check for
 libunwind devel files by default
Message-ID: <Z09zTztD8X8qIWCX@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than
opt-out"), so we shouldn't by default be testing for its availability at
build time in tools/build/features/test-all.c.

That test was designed to test the features we expect to be the most
common ones in most builds, so if we test build just that file, then we
assume the features there are present and will not test one by one.

Removing it from test-all.c gets rid of the first impediment for
test-all.c to build successfully:

  $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  In file included from test-all.c:62:
  test-libunwind.c:2:10: fatal error: libunwind.h: No such file or directory
      2 | #include <libunwind.h>
        |          ^~~~~~~~~~~~~
  compilation terminated.
  $

We then get to:

  $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  /usr/bin/ld: cannot find -lunwind-x86_64: No such file or directory
  /usr/bin/ld: cannot find -lunwind: No such file or directory
  collect2: error: ld returned 1 exit status
  $

So make all the logic related to setting CFLAGS, LDFLAGS, etc for
libunwind to be conditional on NO_LIBWUNWIND=1, which is now the
default, now we get a faster build:

  $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
  $ ldd /tmp/build/perf-tools-next/feature/test-all.bin
  	linux-vdso.so.1 (0x00007fef04cde000)
  	libdw.so.1 => /lib64/libdw.so.1 (0x00007fef04a49000)
  	libpython3.12.so.1.0 => /lib64/libpython3.12.so.1.0 (0x00007fef04478000)
  	libm.so.6 => /lib64/libm.so.6 (0x00007fef04394000)
  	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007fef0436c000)
  	libtracefs.so.1 => /lib64/libtracefs.so.1 (0x00007fef04345000)
  	libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007fef03e95000)
  	libz.so.1 => /lib64/libz.so.1 (0x00007fef03e72000)
  	libelf.so.1 => /lib64/libelf.so.1 (0x00007fef03e56000)
  	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007fef03e48000)
  	libslang.so.2 => /lib64/libslang.so.2 (0x00007fef03b65000)
  	libperl.so.5.38 => /lib64/libperl.so.5.38 (0x00007fef037c6000)
  	libc.so.6 => /lib64/libc.so.6 (0x00007fef035d5000)
  	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fef035a0000)
  	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007fef034e1000)
  	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007fef034cd000)
  	/lib64/ld-linux-x86-64.so.2 (0x00007fef04ce0000)
  	libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007fef03495000)
  $

Fixes: 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than opt-out")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-all.c |  5 --
 tools/perf/Makefile.config     | 83 ++++++++++++++++++++--------------
 2 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 59ef3d7fe6a4e771..80ac297f81967171 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -58,10 +58,6 @@
 # include "test-libelf-getshdrstrndx.c"
 #undef main
 
-#define main main_test_libunwind
-# include "test-libunwind.c"
-#undef main
-
 #define main main_test_libslang
 # include "test-libslang.c"
 #undef main
@@ -184,7 +180,6 @@ int main(int argc, char *argv[])
 	main_test_libelf_getphdrnum();
 	main_test_libelf_gelf_getnote();
 	main_test_libelf_getshdrstrndx();
-	main_test_libunwind();
 	main_test_libslang();
 	main_test_libbfd();
 	main_test_libbfd_buildid();
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2916d59c88cd08b2..0e4f6a860ae25339 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -43,7 +43,9 @@ endif
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
   CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
-  LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
+  ifndef NO_LIBUNWIND
+    LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
+  endif
 endif
 
 # Additional ARCH settings for x86
@@ -53,25 +55,35 @@ ifeq ($(SRCARCH),x86)
   ifeq (${IS_64_BIT}, 1)
     CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT
     ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
-    LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
+    ifndef NO_LIBUNWIND
+      LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
+    endif
     $(call detected,CONFIG_X86_64)
   else
-    LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
+    ifndef NO_LIBUNWIND
+      LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
+    endif
   endif
 endif
 
 ifeq ($(SRCARCH),arm)
-  LIBUNWIND_LIBS = -lunwind -lunwind-arm
+  ifndef NO_LIBUNWIND
+    LIBUNWIND_LIBS = -lunwind -lunwind-arm
+  endif
 endif
 
 ifeq ($(SRCARCH),arm64)
   CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
-  LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
+  ifndef NO_LIBUNWIND
+    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
+  endif
 endif
 
 ifeq ($(SRCARCH),loongarch)
   CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
-  LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
+  ifndef NO_LIBUNWIND
+    LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
+  endif
 endif
 
 ifeq ($(ARCH),s390)
@@ -80,7 +92,9 @@ endif
 
 ifeq ($(ARCH),mips)
   CFLAGS += -I$(OUTPUT)arch/mips/include/generated
-  LIBUNWIND_LIBS = -lunwind -lunwind-mips
+  ifndef NO_LIBUNWIND
+    LIBUNWIND_LIBS = -lunwind -lunwind-mips
+  endif
 endif
 
 ifeq ($(ARCH),riscv)
@@ -121,16 +135,18 @@ ifdef LIBUNWIND_DIR
   $(foreach libunwind_arch,$(LIBUNWIND_ARCHS),$(call libunwind_arch_set_flags,$(libunwind_arch)))
 endif
 
-# Set per-feature check compilation flags
-FEATURE_CHECK_CFLAGS-libunwind = $(LIBUNWIND_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
-FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
-
-FEATURE_CHECK_LDFLAGS-libunwind-arm += -lunwind -lunwind-arm
-FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
-FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
-FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
+ifndef NO_LIBUNWIND
+  # Set per-feature check compilation flags
+  FEATURE_CHECK_CFLAGS-libunwind = $(LIBUNWIND_CFLAGS)
+  FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
+  FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
+  FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
+  
+  FEATURE_CHECK_LDFLAGS-libunwind-arm += -lunwind -lunwind-arm
+  FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
+  FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
+  FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
+endif
 
 FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 
@@ -734,26 +750,25 @@ ifeq ($(dwarf-post-unwind),1)
   $(call detected,CONFIG_DWARF_UNWIND)
 endif
 
-ifndef NO_LOCAL_LIBUNWIND
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
-    $(call feature_check,libunwind-debug-frame)
-    ifneq ($(feature-libunwind-debug-frame), 1)
-      $(warning No debug_frame support found in libunwind)
+ifndef NO_LIBUNWIND
+  ifndef NO_LOCAL_LIBUNWIND
+    ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
+      $(call feature_check,libunwind-debug-frame)
+      ifneq ($(feature-libunwind-debug-frame), 1)
+        $(warning No debug_frame support found in libunwind)
+        CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
+      endif
+    else
+      # non-ARM has no dwarf_find_debug_frame() function:
       CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
     endif
-  else
-    # non-ARM has no dwarf_find_debug_frame() function:
-    CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
+    EXTLIBS += $(LIBUNWIND_LIBS)
+    LDFLAGS += $(LIBUNWIND_LIBS)
+  endif
+  ifeq ($(findstring -static,${LDFLAGS}),-static)
+    # gcc -static links libgcc_eh which contans piece of libunwind
+    LIBUNWIND_LDFLAGS += -Wl,--allow-multiple-definition
   endif
-  EXTLIBS += $(LIBUNWIND_LIBS)
-  LDFLAGS += $(LIBUNWIND_LIBS)
-endif
-ifeq ($(findstring -static,${LDFLAGS}),-static)
-  # gcc -static links libgcc_eh which contans piece of libunwind
-  LIBUNWIND_LDFLAGS += -Wl,--allow-multiple-definition
-endif
-
-ifndef NO_LIBUNWIND
   CFLAGS  += -DHAVE_LIBUNWIND_SUPPORT
   CFLAGS  += $(LIBUNWIND_CFLAGS)
   LDFLAGS += $(LIBUNWIND_LDFLAGS)
-- 
2.47.0


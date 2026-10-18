Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A43A0E8D;
	Sun, 18 Oct 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331605; cv=none; b=btr4JApIdTwP+GX/39nfsqAINZDNH08smmEsrnFSL7vxVxSIdMAkx//C6ZIvhf4AOgsT6io8XkfDSij7l5Jd21fJfqzrdShebOrp3xT24UKY+xVh00gd44R7xUiX5cBQX7Z3CRqwbvO+XCU8uBsuh8syJwXilhtXCvFZq9Ljtqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331605; c=relaxed/simple;
	bh=KctWqJST7nfxyupAA2J5xHEBT3XdDbjPxcDs9puAyPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfV8z161MzaokyzZNNUNaaDP7Rx9vLgv/9+98YioGaMCSr7qVqdCwVkKoNFCa0YS94giuvL63VFEiPfHCnWVhXC0RxirklqqUr8RXG6Q3m5ObAExSzyvmyce4oUXNdZFXHsd23Kq+qC3/UuDX974/ldv8Cd4SX1nWcASJ53eC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnnPaWMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnnPaWMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6D31F000C4;
	Sun, 18 Oct 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331604;
	bh=wqJ7HMhfZ1UXOizQ/gTd6cfSpGI3pyYRZlzk0XOEYZA=;
	h=From:To:Cc:Subject:Date;
	b=CnnPaWMuO1rmXx6rsK2ugD18RlhrYCeUIQrNwqgqWC5eRg91r7M/f8FDH6Nsjss5E
	 hGTe6sj9pgnisn3lNx55AQv2ouArzvwn1CU2QH4ftn47KXG9ghhK/YXxJSo+UJqBhv
	 dklvDPpDwgDbnSlUKaUb6c3CRHS3ObExVtGlMql3LdFJNJ8LPoxJGYy8pqNAE0Rf0m
	 sYihkhDikm37SoInyYoxqtMRwAuvIhWaJi3QHg3/sTMIYHTKYT9Rt+rG1f2dPsE9t3
	 fHNNHw3vqh0pVOQRVcFW52eb3Oo0Di/QEUj8bb2qhriyB8qB+eYOqbf09yt3fd1eqV
	 tJf/zP9+C7DRQ==
From: Sasha Levin <sashal@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] perf build: Add MINIMAL=1 to build without optional features
Date: Sun, 18 Oct 2026 09:53:21 -0400
Message-ID: <20261018135321.3986899-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turning off every optional feature takes a long list of NO_* variables,
and the list has to follow features as they are added and renamed. The
one in tests/make for make_minimal has fallen behind: it leaves
libtraceevent, jevents, slang, AIO, LZMA, zlib, libLLVM and Rust to be
detected, so a make_minimal build still needs libtraceevent and python.

Add MINIMAL=1, which turns off every optional feature, the BPF
skeletons, and the shellcheck, mypy and pylint runs. perf then builds,
natively or cross, with no library beyond the C library and without
python, pkg-config, clang or rustc, and the result does not depend on
what is installed on the build machine.

A MINIMAL=1 build also leaves out the notices that post unwind and
python support are disabled, which it asked for, and the one about the
pkg-config search path for cross builds, as pkg-config is not needed
then.

It is handled in Makefile.perf rather than Makefile.config, as
Makefile.config is included after the pkg-config, shellcheck, mypy and
pylint setup.

Use it for make_minimal in tests/make.

Suggested-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
The kbuild series that builds perf with MINIMAL=1 carries the mainline
version of this patch:
https://lore.kernel.org/r/20261016143143.3613501-1-sashal@kernel.org

 tools/perf/Makefile.config |  8 ++++++--
 tools/perf/Makefile.perf   | 42 ++++++++++++++++++++++++++++++++++++--
 tools/perf/tests/make      |  8 +-------
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b4764f69f47f4..4af7934887539 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -753,7 +753,9 @@ dwarf-post-unwind-text := BUG
 # setup DWARF post unwinder
 ifdef NO_LIBUNWIND
   ifdef NO_LIBDW
-    $(warning Disabling post unwind, no support found.)
+    ifneq ($(MINIMAL),1)
+      $(warning Disabling post unwind, no support found.)
+    endif
     dwarf-post-unwind := 0
   else
     dwarf-post-unwind-text := libdw
@@ -828,7 +830,9 @@ endif
 
 PYTHON_EXTENSION_SUFFIX := '.so'
 ifdef NO_PYTHON_MODULE
-  $(call disable-python,Python support disabled by user)
+  ifneq ($(MINIMAL),1)
+    $(call disable-python,Python support disabled by user)
+  endif
 else
 
   ifndef PYTHON
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2d9379fea2672..5297fc15a3c9e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -129,6 +129,9 @@ include ../scripts/utilities.mak
 # Define NO_MYPY if you do not want to run mypy during build
 #
 # Define NO_PYLINT if you do not want to run pylint during build
+#
+# Define MINIMAL=1 to build without any optional feature, needing only a C
+# compiler and library, flex and bison
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -174,6 +177,39 @@ endef
 
 LD += $(EXTRA_LDFLAGS)
 
+# MINIMAL=1 is handled here rather than in Makefile.config, which is included
+# after the pkg-config, shellcheck, mypy and pylint setup below
+ifeq ($(MINIMAL),1)
+  NO_LIBELF := 1
+  NO_LIBDW := 1
+  NO_LIBTRACEEVENT := 1
+  NO_JEVENTS := 1
+  NO_PYTHON_MODULE := 1
+  NO_LIBBPF := 1
+  BUILD_BPF_SKEL := 0
+  NO_SLANG := 1
+  NO_DEMANGLE := 1
+  NO_BACKTRACE := 1
+  NO_AIO := 1
+  NO_ZLIB := 1
+  NO_LZMA := 1
+  NO_LIBZSTD := 1
+  NO_LIBNUMA := 1
+  NO_LIBLLVM := 1
+  NO_CAPSTONE := 1
+  NO_LIBPFM4 := 1
+  NO_LIBDEBUGINFOD := 1
+  NO_BABELTRACE2 := 1
+  NO_SDT := 1
+  NO_JVMTI := 1
+  NO_RUST := 1
+  NO_PERF_READ_VDSO32 := 1
+  NO_PERF_READ_VDSOX32 := 1
+  NO_SHELLCHECK := 1
+  NO_MYPY := 1
+  NO_PYLINT := 1
+endif
+
 # Some distros provide the command $(CROSS_COMPILE)pkg-config for
 # searching packges installed with Multiarch. Use it for cross
 # compilation if it is existed.
@@ -195,8 +231,10 @@ else
       PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
       PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
       export PKG_CONFIG_LIBDIR
-      $(warning Missing PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH and PKG_CONFIG_SYSROOT_DIR for cross compilation,)
-      $(warning set PKG_CONFIG_LIBDIR for using Multiarch libs.)
+      ifneq ($(MINIMAL),1)
+        $(warning Missing PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH and PKG_CONFIG_SYSROOT_DIR for cross compilation,)
+        $(warning set PKG_CONFIG_LIBDIR for using Multiarch libs.)
+      endif
     endif
   endif
 endif
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de5228029..bef5599b95d6f 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -119,13 +119,7 @@ make_install_prefix       := install prefix=/tmp/krava
 make_install_prefix_slash := install prefix=/tmp/krava/
 make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1
 
-# all the NO_* variable combined
-make_minimal        := NO_PYTHON_MODULE=1
-make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
-make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
-make_minimal        += NO_LIBBPF=1
-make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
-make_minimal        += NO_CAPSTONE=1
+make_minimal        := MINIMAL=1
 
 # binutils 2_42 and newer have bfd_thread_init()
 new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep bfd_thread_init)

base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
-- 
2.53.0


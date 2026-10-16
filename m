Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356434EF15C;
	Fri, 16 Oct 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161115; cv=none; b=sjd2iGsqcsyhsS/Egsl3dxsZjo1eu2m9qxws8BWgCedwzNltOXp8y+SOcQRgxkyRKZoJ0jVzpj43hnZupCS6EEUbfzjsE5Vmh8i7j32Ug48dkUMRLfZ56+AZnESZME5gc8Koewkdjrk69qT9CJVyNjUTu6vaYDqYOdNzKd5FPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161115; c=relaxed/simple;
	bh=tpPKHTNIh+iZmJxRVNXERXyYawE7kyva5mLfnt3111A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szkV3okBx8RJRIdXWtKPysJNIObgdjnrAG9R9kPmCI7+KbcRcW45YA/tckErwGyQ8K+0EJFp4ucUUWdIP/73VAg6xj8SLsD1AFJa7d7AzugwsTx1TE+4Hh9uj2mLbcSD5r2EjDh66mGUbXvTJGFB6pwFfh4gGFxtYGvX3vmb+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSmRpzFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSmRpzFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8E41F000C4;
	Fri, 16 Oct 2026 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161112;
	bh=jFzSZUYc31MKOoaHPq3p3ywoqeQrK04V56IEuU9E1XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FSmRpzFJGFUezAHoYXMe/QPKLNO4MFw9PItA+d+YHvxot8ONwR2aof6emABP6wuQV
	 PLc/crIHz2qolZ477OF69Syj3T62MOEmv5++gOioSJa5pQkV80/8uxTzfpbn0dfIYt
	 BhWSKY9zZSTF3jN6i7YYg0nDWpJCCcErWVoCIpnSxJ2cTQvmjeJCzIgHM9zlZcIaTN
	 wvqdlz+wS/gC2U4drGyb3R/TwyP1IRTyYv1oe6ipk9rP+QS1LUA5e0OqdnL9UsaLIU
	 CHekzetLDlwVGqL7rKzXrxD7EvOlMH2OdtqgN/XnB8Px2KERYOSSgcjWhz55OMgAIG
	 HBxpu5IxIKMGw==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/7] perf build: Add MINIMAL=1 to build without optional features
Date: Fri, 16 Oct 2026 10:31:39 -0400
Message-ID: <20261016143143.3613501-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016143143.3613501-1-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
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

Add MINIMAL=1, which turns off every optional feature, the BPF skeletons
and the shellcheck run. perf then builds, natively or cross, with no
library beyond the C library and without python, pkg-config, clang or
rustc, and the result does not depend on what is installed on the build
machine.

A MINIMAL=1 build also leaves out the notices that post unwind and
python support are disabled, which it asked for, and the one about the
pkg-config search path for cross builds, as pkg-config is not needed
then.

It is handled in Makefile.perf rather than Makefile.config, as
Makefile.config is included after the pkg-config and shellcheck setup.

Use it for make_minimal in tests/make.

Suggested-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.config |  8 ++++++--
 tools/perf/Makefile.perf   | 40 ++++++++++++++++++++++++++++++++++++--
 tools/perf/tests/make      |  8 +-------
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4d5993da9f945..137c9e120670b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -742,7 +742,9 @@ dwarf-post-unwind-text := BUG
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
@@ -828,7 +830,9 @@ endef
 
 PYTHON_EXTENSION_SUFFIX := '.so'
 ifdef NO_LIBPYTHON
-  $(call disable-python,Python support disabled by user)
+  ifneq ($(MINIMAL),1)
+    $(call disable-python,Python support disabled by user)
+  endif
 else
 
   ifndef PYTHON
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 29cfd44c427f3..c770077e7d392 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -129,6 +129,9 @@ include ../scripts/utilities.mak
 # Define GEN_VMLINUX_H to generate vmlinux.h from the BTF.
 #
 # Define NO_SHELLCHECK if you do not want to run shellcheck during build
+#
+# Define MINIMAL=1 to build without any optional feature, needing only a C
+# compiler and library, flex and bison
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -174,6 +177,37 @@ endef
 
 LD += $(EXTRA_LDFLAGS)
 
+# MINIMAL=1 is handled here rather than in Makefile.config, which is included
+# after the pkg-config and shellcheck setup below
+ifeq ($(MINIMAL),1)
+  NO_LIBELF := 1
+  NO_LIBDW := 1
+  NO_LIBTRACEEVENT := 1
+  NO_JEVENTS := 1
+  NO_LIBPYTHON := 1
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
+endif
+
 # Some distros provide the command $(CROSS_COMPILE)pkg-config for
 # searching packges installed with Multiarch. Use it for cross
 # compilation if it is existed.
@@ -195,8 +229,10 @@ else
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
index d2c2f526e1db0..dbbc971a144b2 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -115,13 +115,7 @@ make_install_prefix       := install prefix=/tmp/krava
 make_install_prefix_slash := install prefix=/tmp/krava/
 make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1
 
-# all the NO_* variable combined
-make_minimal        := NO_LIBPYTHON=1
-make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
-make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
-make_minimal        += NO_LIBBPF=1
-make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
-make_minimal        += NO_CAPSTONE=1
+make_minimal        := MINIMAL=1
 
 # binutils 2_42 and newer have bfd_thread_init()
 new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep bfd_thread_init)
-- 
2.53.0


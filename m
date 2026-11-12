Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513279;
	b=QF9GWYQEaIb8cVOAfBeTPioGQyRCj+X3fdqhQBtVKdTLC3cQbDsx6vA6MdI14vWQ6wni
	 olbpxqrgiCZYspHWMrstPNRuCtkxprZX8OUKIN6L0AxE6yrGGZ/Mpm0Hf07Nom2lGJVfY
	 VBi/exbvBcPnuLM74MHgn9R3/XaB6/aWaBjceyWW/XR3Z2EcID//MkFbmFQ887LWKSQj5
	 kbGuwM9f6j344lgN4TLMAab+aCAeo2pxlaIG8UQ7iu3hPYkFMChMnUQ43r6ZheApjIzpp
	 wwixQ9WqnZlJpTEUP5PKDgrBwxuSZyIGt1OLfisAIRSp9pcfZQnVEIo8wh2TkgydKXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TkvIJtT2uYGtfsA/9mgNPYvW+4raY7xxarpE4GskwG4=;
	b=IU1zrVhCWLUMH18CRDqVRl83WF+yTEDMqeaeeuzQnTjFNooBxgz/AcLHhOyqEUgKfzSh
	 d+u0LyXCUvzLqswcQ1l4eu0biqEe2ztIiQrXSlyqrh4ZFLNK+7iMMJVqjyeXsZjp6N3qi
	 B2nwq6vvC1UuMYA7bEkF9Rd1g5nlYMcw32Rfr6bVX3hy99F+3lhl17wxqlXXtgQxh9fy1
	 4jdDqWbrv+wJBI//EL9fUoR8gOhhkvVFsvD93tt5hzwt7xO6QB3Ib4CSD6fZxRmCMeJIO
	 uEQ3W1vEueUhuIG4JuOUKMZazAN1lLWxsUj8nCsdxBSxQWWBG096dLBBl8njYkwYJWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hS0AhEqM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038260A260E;
	Thu, 12 Nov 2026 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hS0AhEqM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF451F000C4;
	Thu, 12 Nov 2026 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513278;
	bh=TkvIJtT2uYGtfsA/9mgNPYvW+4raY7xxarpE4GskwG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hS0AhEqMjVTlCs99dK+ngIr7wHnenyTnnild9ZRKK5uyjUr2PFQKl5hl+llryYHs9
	 B6T2eYBDvAPdN2IyspiYk/PunVpZchVxnOqYkXpRYblYseW0683bNdu/RYfUXB5hUk
	 wJdJZlaSv1RBpkpW5Ihf8nlAL95yih0GlWQN8W6cCWXUcswPSr63oz8rH+WgEGRG1n
	 IJkTau3eo108Bd/nEeY68ig3cSleW0LfI6m/LtaWkcVuFSaa2r3nbQ8O7KN4Z8BTQw
	 tgrBEjXtTZ6S9XpA5OP+rqirTdOmLNPrFQslTrngr/Hn7KpmEXMTzkdpzPM5UvmLNI
	 MqFo4GxcmKGLw==
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
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 3/7] perf build: Add MINIMAL=1 to build without optional features
Date: Thu, 12 Nov 2026 14:54:23 -0500
Message-ID: <20261112195427.3411746-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112195427.3411746-1-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
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
index b74b534e1153f..c178c3976d154 100644
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
-- 
2.53.0


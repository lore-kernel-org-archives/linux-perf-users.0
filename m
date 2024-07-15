Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E8F18C33E;
	Mon, 15 Jul 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053780; cv=none; b=tmDKQn0iTMPnKHne08gifUF2mtDHj3hqvJ44pq4m/XHl24m/7oR1cCr7er813qB9P0p+RbJqlrkrdO9bMjESzeztZmiWAwqHRzPpqAEG0K7Kq9jCtlrPCUpiqJGZbCWt2KBMMLJRhGFBlO5ZkLnDd748IxIcTtODVn/vyLJXbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053780; c=relaxed/simple;
	bh=YZKkOo2iIN7sg6inRV92qD4tbNh1Uovs6wd5L8+CTEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjV0j2Goe+FWrjUvK0hUNwhvXtud32k0yrhQlR2Dj518CjAPcnXZ8j0er442YeD4HP35R67Cbnyzavssroy1zD3SUNrg1vEPkpO9YeZ0yGFD6DGxXgAI4O8tx1Yn6n7SwP8sIad/pmnqy0Q8fxCdX2m2LF8wHkpRvWvvFls7nK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26033FEC;
	Mon, 15 Jul 2024 07:30:03 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 469053F766;
	Mon, 15 Jul 2024 07:29:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 1/6] perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
Date: Mon, 15 Jul 2024 15:29:16 +0100
Message-Id: <20240715142921.51881-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715142921.51881-1-leo.yan@arm.com>
References: <20240715142921.51881-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On recent Linux distros like Ubuntu Noble and Debian Bookworm, the
'pkg-config-aarch64-linux-gnu' package is missing. As a result, the
aarch64-linux-gnu-pkg-config command is not available, which causes
build failures.

When a build passes the environment variables PKG_CONFIG_LIBDIR or
PKG_CONFIG_PATH, like a user uses make command or a build system
(like Yocto, Buildroot, etc) prepares the variables and passes to the
Perf's Makefile, the commit keeps these variables for package
configuration. Otherwise, this commit sets the PKG_CONFIG_LIBDIR
variable to use the Multiarch libs for the cross compilation.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 25 ++++++++++++++++++++++++-
 tools/perf/Makefile.perf     | 27 ++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ed54cef450f5..dff65d03d30d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -82,7 +82,30 @@ FILES=                                          \
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
-PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+# Some distros provide the command $(CROSS_COMPILE)pkg-config for
+# searching packges installed with Multiarch. Use it for cross
+# compilation if it is existed.
+ifneq (, $(shell which $(CROSS_COMPILE)pkg-config))
+  PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+else
+  PKG_CONFIG ?= pkg-config
+
+  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR, alongside PKG_CONFIG_SYSROOT_DIR
+  # for modified system root, are required for the cross compilation.
+  # If these PKG_CONFIG environment variables are not set, Multiarch library
+  # paths are used instead.
+  ifdef CROSS_COMPILE
+    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
+      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+      export PKG_CONFIG_LIBDIR
+    endif
+  endif
+endif
 
 all: $(FILES)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..a4a3dca2033a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -193,7 +193,32 @@ HOSTLD  ?= ld
 HOSTAR  ?= ar
 CLANG   ?= clang
 
-PKG_CONFIG = $(CROSS_COMPILE)pkg-config
+# Some distros provide the command $(CROSS_COMPILE)pkg-config for
+# searching packges installed with Multiarch. Use it for cross
+# compilation if it is existed.
+ifneq (, $(shell which $(CROSS_COMPILE)pkg-config))
+  PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+else
+  PKG_CONFIG ?= pkg-config
+
+  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR, alongside PKG_CONFIG_SYSROOT_DIR
+  # for modified system root, is required for the cross compilation.
+  # If these PKG_CONFIG environment variables are not set, Multiarch library
+  # paths are used instead.
+  ifdef CROSS_COMPILE
+    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
+      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+      export PKG_CONFIG_LIBDIR
+      $(warning Missing PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH and PKG_CONFIG_SYSROOT_DIR for cross compilation,)
+      $(warning set PKG_CONFIG_LIBDIR for using Multiarch libs.)
+    endif
+  endif
+endif
 
 RM      = rm -f
 LN      = ln -f
-- 
2.34.1


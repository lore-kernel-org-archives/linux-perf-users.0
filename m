Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18614F20C;
	Sat,  6 Jul 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290574; cv=none; b=UJRcvV6RTSYY92egY0eOBUW33u9IdU7vQ1lASCKlW9NlpP9v7qlVX7suEqRlHHG1tAY6OrI54VYKOCj4BfRJrqk+vqnmAYsktTIvLQ5cZdUznlFr1BCYlBXpL4HXwr2Iu4M7hSs1wjtfH4SxIr9Y9ufLzliBE6oolWvkn00IPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290574; c=relaxed/simple;
	bh=QUJHAl5HWSQBQqaZ0Gq2f/wE/3aTMbbgoZpKTbCLhQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWYWkw64leoXuoWVwVV4ya4D5cSxyi0X2LwgL9uT7rDJghvjnxic9sNqlBtvHMDdjsVZr7XtSoUgOc/zXel/2jz8uPK/kZv72HtI3i5SvI2qIkLJ3QOz+ULiVOJae/aL/PnOc4BUh0pDxfP49PPuU62Fe2iDmciXae23IpzXCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D39212FC;
	Sat,  6 Jul 2024 11:29:56 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E8B43F73B;
	Sat,  6 Jul 2024 11:29:28 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 1/7] perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
Date: Sat,  6 Jul 2024 19:29:06 +0100
Message-Id: <20240706182912.222780-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706182912.222780-1-leo.yan@arm.com>
References: <20240706182912.222780-1-leo.yan@arm.com>
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
 tools/build/feature/Makefile | 26 +++++++++++++++++++++++++-
 tools/perf/Makefile.perf     | 26 +++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ed54cef450f5..65fd2b2cfacb 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -82,7 +82,31 @@ FILES=                                          \
 
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
+  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR is required for the cross
+  # compilation. If both is not set, try to set the lib paths installed
+  # by multiarch.
+  ifdef CROSS_COMPILE
+    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
+      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+      export PKG_CONFIG_LIBDIR
+      $(warning Missing PKG_CONFIG_LIBDIR and PKG_CONFIG_PATH for cross compilation,)
+      $(warning set PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) for building with Multiarch libs.)
+    endif
+  endif
+endif
 
 all: $(FILES)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..270490be0a1a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -193,7 +193,31 @@ HOSTLD  ?= ld
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
+  # PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR is required for the cross
+  # compilation. If both is not set, try to set the lib paths installed
+  # by multiarch.
+  ifdef CROSS_COMPILE
+    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH)$(PKG_CONFIG_SYSROOT_DIR),)
+      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+      export PKG_CONFIG_LIBDIR
+      $(warning Missing PKG_CONFIG_LIBDIR and PKG_CONFIG_PATH for cross compilation,)
+      $(warning set PKG_CONFIG_LIBDIR to $(PKG_CONFIG_LIBDIR) for using libs with Multiarch.)
+    endif
+  endif
+endif
 
 RM      = rm -f
 LN      = ln -f
-- 
2.34.1


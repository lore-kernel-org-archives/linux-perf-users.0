Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FB757F5;
	Mon, 10 Jun 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013309; cv=none; b=ZPZqeWZRZN2dVecBUOqlbSrv6PvW5krx3QmxDcLShBEFmQQArlEJfy4RVyvFcrXujuBQYok3KOo7qQFuAh3Ri5VEuzeng9bSMVNMgAivdaEsNwMbkSbURBqtEqqh/grmFB1URZRW8A0R9gQcNrEl92i4r8ODyttEyohM/YqtcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013309; c=relaxed/simple;
	bh=EJvYdtAU/vnXNiBRedH73QJqwaqsKTQoOOFCKDfrpyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+sQpNMy9FYJL2411UOXitCJyKc1ax/YF0edUlCNNy5QlCatg+MA5pX2buIc549ZzvdIcetX7g+1T4c8ZTrZdr6yHkdHPhzsD4CDJF/554VKEFtREYRPiJbuPtBKCJ1peggS1Zl+VCcPyXmZi4mbJv2xaNVkTwdEz5Sv9YUu/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CBBF1688;
	Mon, 10 Jun 2024 02:55:31 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A44063F73B;
	Mon, 10 Jun 2024 02:55:04 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 1/6] perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
Date: Mon, 10 Jun 2024 10:54:28 +0100
Message-Id: <20240610095433.336295-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610095433.336295-1-leo.yan@arm.com>
References: <20240610095433.336295-1-leo.yan@arm.com>
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
index ed54cef450f5..084f803093c3 100644
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
+    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH),)
+      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+      export PKG_CONFIG_LIBDIR
+      $(warning Missing PKG_CONFIG_LIBDIR and PKG_CONFIG_PATH for cross compilation,)
+      $(warning set PKG_CONFIG_LIBDIR=$(PKG_CONFIG_LIBDIR) for building with Multiarch libs.)
+    endif
+  endif
+endif
 
 all: $(FILES)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..2c9e89415e48 100644
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
+    ifeq ($(PKG_CONFIG_LIBDIR)$(PKG_CONFIG_PATH),)
+      CROSS_ARCH = $(shell $(CC) -dumpmachine)
+      PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+      PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
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


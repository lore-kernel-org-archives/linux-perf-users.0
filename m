Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D548414431B;
	Tue,  4 Jun 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493563; cv=none; b=hz4R85a3AIjUfVFCF/mOEMXqhGyww8HLVCyCluhPD6Rc13vjo6ZZPgUH6GxDYBLz3cyQVa+WayghnZqllCdwaiLq+EktglfYc84nAeWZjGNtJE51J0P0w4ayYyteosANzptlNbZZqtx4od8R4wVBc43MIf9jMvr4m1uvxpr1ocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493563; c=relaxed/simple;
	bh=AYIsr6BHCMO5M5g+WYj0gNdRpucero0xaGIOB77Fy78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9oDbRTbHkBF1vHW183/JGc0CCEvkX0mgTwY92gVSRS1S1y50XuuvntVEkmhW6RhfivYg4aNKZZVUkrbOkJ3xfqYR0Z+ULF8Yi2yT3Q9x8toeYxU1vRKORpt5izeHVcvifDC3b/fZTT2d6IvS1vRl8cKAPfBBXfO9/kDIskoWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AABD11063;
	Tue,  4 Jun 2024 02:33:05 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DBD53F762;
	Tue,  4 Jun 2024 02:32:39 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	"Mateusz Kowalczyk" <fuuzetsu@fuuzetsu.co.uk>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/6] perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
Date: Tue,  4 Jun 2024 10:32:18 +0100
Message-Id: <20240604093223.1934236-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604093223.1934236-1-leo.yan@arm.com>
References: <20240604093223.1934236-1-leo.yan@arm.com>
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

Alternatively, this commit sets the PKG_CONFIG_LIBDIR environment
variable dynamically based on the cross compiler to ensure the correct
package configurations.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 14 +++++++++++++-
 tools/perf/Makefile.perf     | 15 ++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ed54cef450f5..6f52f892f9a3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -82,7 +82,19 @@ FILES=                                          \
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
-PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
+PKG_CONFIG ?= pkg-config
+
+ifdef CROSS_COMPILE
+  ifndef PKG_CONFIG_LIBDIR
+    CROSS_ARCH = $(shell $(CC) -dumpmachine)
+    PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+    export PKG_CONFIG_LIBDIR
+  endif
+endif
 
 all: $(FILES)
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..c1553a546a4f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -193,7 +193,20 @@ HOSTLD  ?= ld
 HOSTAR  ?= ar
 CLANG   ?= clang
 
-PKG_CONFIG = $(CROSS_COMPILE)pkg-config
+PKG_CONFIG ?= pkg-config
+
+# Set the PKG_CONFIG_LIBDIR for cross compilation.
+ifdef CROSS_COMPILE
+  ifndef PKG_CONFIG_LIBDIR
+    CROSS_ARCH = $(shell $(CC) -dumpmachine)
+    PKG_CONFIG_LIBDIR := /usr/local/$(CROSS_ARCH)/lib/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/lib/$(CROSS_ARCH)/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/lib/$(CROSS_ARCH)/pkgconfig/
+    PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
+    export PKG_CONFIG_LIBDIR
+  endif
+endif
 
 RM      = rm -f
 LN      = ln -f
-- 
2.34.1


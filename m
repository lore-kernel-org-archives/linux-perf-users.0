Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DE7BB15;
	Fri, 28 Jun 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606894; cv=none; b=b58xpoOif9S3aA5te+zR25PDUREbnzv43cKptAjg51qK5HCc8LwPW84We/ZEgwSU3WdAYhlU5csJe6siLUGO/RqkZIerQk8+oGiDYh6mvJgLn/6D5G+4USMKSU2s1nA7sYVGf2Hm6mAMVR+0XYUj6c7uLSWZC3iKF38JEZh7yXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606894; c=relaxed/simple;
	bh=0C/AV8V/vlEgTlfHWOoe9+jvPFrRMgyVzsMX2ATnSvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdT8LNGSKQQ6wmdogF/TZbrLnGXdYt2JTToMyFeuTpQaGnzLz5CzwKrmqxzhPp8PBmUOzkm/2yAVbXpTp5OUjzqzteXaQ6Sr/PbIVuGFBheKOtczQwYiTBOsKBgUg0iFTjBZUG6lXz57vN7XBd0bHPCTIf7j8g5kEGD5gOdtkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Guilherme Amadio <amadio@gentoo.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>
Subject: [PATCH v2 3/6] tools: Make pkg-config dependency checks usable by other tools
Date: Fri, 28 Jun 2024 22:34:29 +0200
Message-ID: <20240628203432.3273625-3-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628203432.3273625-1-amadio@gentoo.org>
References: <20240628202608.3273329-1-amadio@gentoo.org>
 <20240628203432.3273625-1-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other tools, in tools/verification and tools/tracing, make use of
libtraceevent and libtracefs as dependencies. This allows setting
up the feature check flags for them as well.

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/build/Makefile.feature | 20 ++++++++++++++++++++
 tools/perf/Makefile.config   | 10 ----------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1e2ab148d5db..79a03e034073 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -149,6 +149,26 @@ FEATURE_DISPLAY ?=              \
 #
 FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
 
+#
+# Declare list of feature dependency packages that provide pkg-config files.
+#
+FEATURE_PKG_CONFIG ?=           \
+         libtraceevent          \
+         libtracefs
+
+feature_pkg_config = $(eval $(feature_pkg_config_code))
+define feature_pkg_config_code
+  ifeq ($(shell $(PKG_CONFIG) --exists $(1) 2>&1 1>/dev/null; echo $$?),0)
+    FEATURE_CHECK_CFLAGS-$(1) := $(shell $(PKG_CONFIG) --cflags $(1))
+    FEATURE_CHECK_LDFLAGS-$(1) := $(shell $(PKG_CONFIG) --libs $(1))
+  endif
+endef
+
+# Set FEATURE_CHECK_(C|LD)FLAGS-$(package) for packages using pkg-config.
+ifneq ($(PKG_CONFIG),)
+  $(foreach package,$(FEATURE_PKG_CONFIG),$(call feature_pkg_config,$(package)))
+endif
+
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
 # mentioned in this list we need to refactor this ;-).
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ba51ecfca02b..23f2b54d8ee6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -187,16 +187,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
   endif
 endif
-ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
-  # for linking with debug library, run like:
-  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
-  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
-  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
-endif
-ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
-  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
-  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
-endif
 
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config
-- 
2.45.2


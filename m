Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E3197A90;
	Thu, 27 Jun 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500829; cv=none; b=BSeFHJeJY19CBO0j4+pP8PS8M1JYJQuvI2OyNkdBoEHN7rgO3n2pjJsnNfMISuxdW2pe0ayLpwNElPpdoSlIegP/BQ+fmR1ZBKa83VLApdNRt/q4NAPLJVmOXvqOoaASxvQDLC8L7ER79rerZU4zvtvU2JUUjyLejOoQ02kNwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500829; c=relaxed/simple;
	bh=MryslQBD5IImV8ow+80dZKOGE39uz37LExdW1ZlKWyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjdppFKglJhndzvOIsQZ03ZRTAulIgS4GiUyFN75ZmsLp/79PVOlMFsV+2Ynw42X1VmcGX3zHjuBXu1rpmxBds5UNwp2yG1+so/gxgAOISHG8x+pYt2yalh8CnYa+lVjZFfSQTusibqSA8nVGeOEFaq8LXQ5UG7sUECjgznCcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Guilherme Amadio <amadio@gentoo.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: [PATCH 1/2] perf build: conditionally add feature check flags for libtrace{event,fs}
Date: Thu, 27 Jun 2024 17:06:05 +0200
Message-ID: <20240627150606.2224888-1-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.2
Reply-To: <Znxp3bpc-5tvaa3m@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This avoids reported warnings when the packages are not installed.

Fixes: 0f0e1f44569061e3dc590cd0b8cb74d8fd53706b
Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/perf/Makefile.config | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 81f73f68d256..987b48f242d3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -182,14 +182,6 @@ endif
 FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
 
-# for linking with debug library, run like:
-# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
-FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
-FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
-
-FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
-FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
-
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config
 -include $(src-perf)/arch/$(SRCARCH)/Makefile
@@ -211,6 +203,17 @@ endif
 ifneq ($(NO_LIBTRACEEVENT),1)
   ifeq ($(call get-executable,$(PKG_CONFIG)),)
   dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
+  else
+    ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent),0)
+      # for linking with debug library, run like:
+      # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
+      FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
+      FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
+    endif
+    ifeq ($(shell $(PKG_CONFIG) --exists libtracefs),0)
+      FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
+      FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
+    endif
   endif
 endif
 
-- 
2.45.2


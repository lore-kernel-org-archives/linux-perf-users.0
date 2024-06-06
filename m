Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC5194ADF
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688222; cv=none; b=TpsZXp4KS+aDE0qD0mMupZqQswhDbpZIFhBPcLIj/iniY3vXaJYBhccmJlPqIsHZ2WB3jnlkmRi6ckLJMU99ofSgoEsCd3GLL6v5oZ+ithnbM+vMc0L207QP05eWFUkIenlBrRSdPkv8c4O31JZZRqo0L16gBYau8WMp5YvPiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688222; c=relaxed/simple;
	bh=fyEizfj0LKTq0U3iSAWmXanrLgLos11xRe2c3g1Fog4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1Y5eW98TSZsvk1wffQrdqIFn3RrDTNRSazWzPEI/UxmWJm/QzdTLXWhp7cRkuazsdqD+y0Jf6ttkzukC6QFna9JzORbrO41LhUMy686JQ4rbTdAW0WuXvfwC5DRp4Eiv4IvKYPiRpysuB5bkeCKi/5UajcWVFqFKwpNZ5WVPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: amadio@gentoo.org
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>,
	Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf build: Use pkg-config for feature check for libtrace{event,fs}
Date: Thu,  6 Jun 2024 17:33:01 +0200
Message-ID: <20240606153625.2255470-2-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606153625.2255470-1-amadio@gentoo.org>
References: <20240606153625.2255470-1-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guilherme Amadio <amadio@gentoo.org>

Needed to add required include directories for the feature detection
to succeed. The header tracefs.h is installed either into the include
directory /usr/include/tracefs/tracefs.h when using the Makefile, or
into /usr/include/libtracefs/tracefs.h when using meson to build
libtracefs. The header tracefs.h uses #include <event-parse.h> from
libtraceevent, so pkg-config needs to pick the correct include directory
for libtracefs and add the one for libtraceevent to succeed.

Note that in baa2ca59ec1e31ccbe3f24ff0368152b36f68720 the variable
LIBTRACEEVENT_DIR was introduced, and now the method to compile against
non-standard locations requires PKG_CONFIG_PATH to be set instead, which
works for both libtraceevent and libtracefs.

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
Cc: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-libtracefs.c |  2 +-
 tools/perf/Makefile.config            | 27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
index 8eff16c0c10b..29a757a7d848 100644
--- a/tools/build/feature/test-libtracefs.c
+++ b/tools/build/feature/test-libtracefs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <tracefs/tracefs.h>
+#include <tracefs.h>
 
 int main(void)
 {
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..54a6c6bf23c7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -183,14 +183,12 @@ FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
 
 # for linking with debug library, run like:
-# make DEBUG=1 LIBTRACEEVENT_DIR=/opt/libtraceevent/
-TRACEEVENTLIBS := -ltraceevent
-ifdef LIBTRACEEVENT_DIR
-  LIBTRACEEVENT_CFLAGS  := -I$(LIBTRACEEVENT_DIR)/include
-  LIBTRACEEVENT_LDFLAGS := -L$(LIBTRACEEVENT_DIR)/lib
-endif
-FEATURE_CHECK_CFLAGS-libtraceevent := $(LIBTRACEEVENT_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libtraceevent := $(LIBTRACEEVENT_LDFLAGS) $(TRACEEVENTLIBS)
+# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
+FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
+FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
+
+FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
+FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
 
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config
@@ -1178,10 +1176,10 @@ endif
 ifneq ($(NO_LIBTRACEEVENT),1)
   $(call feature_check,libtraceevent)
   ifeq ($(feature-libtraceevent), 1)
-    CFLAGS += -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
-    LDFLAGS += $(LIBTRACEEVENT_LDFLAGS)
-    EXTLIBS += ${TRACEEVENTLIBS}
-    LIBTRACEEVENT_VERSION := $(shell PKG_CONFIG_PATH=$(LIBTRACEEVENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
+    CFLAGS += -DHAVE_LIBTRACEEVENT
+    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
+    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtraceevent)
+    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
     LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
@@ -1194,7 +1192,9 @@ ifneq ($(NO_LIBTRACEEVENT),1)
 
   $(call feature_check,libtracefs)
   ifeq ($(feature-libtracefs), 1)
-    EXTLIBS += -ltracefs
+    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
+    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
+    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
     LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
     LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
     LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
@@ -1315,7 +1315,6 @@ ifeq ($(VF),1)
   $(call print_var,LIBUNWIND_DIR)
   $(call print_var,LIBDW_DIR)
   $(call print_var,JDIR)
-  $(call print_var,LIBTRACEEVENT_DIR)
 
   ifeq ($(dwarf-post-unwind),1)
     $(call feature_print_text,"DWARF post unwind library", $(dwarf-post-unwind-text)) $(info $(MSG))
-- 
2.45.1


Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456ACB645;
	Fri, 28 Jun 2024 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606891; cv=none; b=PkOAAcvrC85w+yw/4ZKyIJP0UmLZ9pLwT6/u85hK5BzPr3qdre+4dq9ByZMeVLQQ64ZsCqSnplIlpmGE+m/z20QQ1rKKZonEfL6L4ec+5AbtAz5X4C8UhL+iESuinlIN09CARTVOdzR8mckF+sOxuaTu5Hs4YpyOmu8XC9zWsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606891; c=relaxed/simple;
	bh=9/pKLiSDErO/rP0tiigunW6k5yudQcr7yv0zlctBgbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be364L22pIWuSCcpuB1t8RnSWkokm7+Wdo0kzTyWLdaqKyK7oApufez3jqx1NDDheQex8m8lyBUXJFID3ZLHKQyqoeQlG609myxmfgbXcpmXxm33AEfXipS0cTeSraSkO3y1XwV1kBpBLomnMP3BlBeCv5dmHGbVQ4CSk4AYMjI=
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
Subject: [PATCH v2 1/6] perf build: Conditionally add feature check flags for libtrace{event,fs}
Date: Fri, 28 Jun 2024 22:34:27 +0200
Message-ID: <20240628203432.3273625-1-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628202608.3273329-1-amadio@gentoo.org>
References: <20240628202608.3273329-1-amadio@gentoo.org>
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
 tools/perf/Makefile.config | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5271a4c1d2b3..5387babb8f04 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -182,13 +182,21 @@ endif
 FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
 
-# for linking with debug library, run like:
-# make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
-FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
-FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
-
-FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
-FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
+ifneq ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
+  endif
+endif
+ifeq ($(shell $(PKG_CONFIG) --exists libtraceevent 2>&1 1>/dev/null; echo $$?),0)
+  # for linking with debug library, run like:
+  # make DEBUG=1 PKG_CONFIG_PATH=/opt/libtraceevent/(lib|lib64)/pkgconfig
+  FEATURE_CHECK_CFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --cflags libtraceevent)
+  FEATURE_CHECK_LDFLAGS-libtraceevent := $(shell $(PKG_CONFIG) --libs libtraceevent)
+endif
+ifeq ($(shell $(PKG_CONFIG) --exists libtracefs 2>&1 1>/dev/null; echo $$?),0)
+  FEATURE_CHECK_CFLAGS-libtracefs := $(shell $(PKG_CONFIG) --cflags libtracefs)
+  FEATURE_CHECK_LDFLAGS-libtracefs := $(shell $(PKG_CONFIG) --libs libtracefs)
+endif
 
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config
@@ -208,12 +216,6 @@ ifeq ($(call get-executable,$(BISON)),)
   $(error Error: $(BISON) is missing on this system, please install it)
 endif
 
-ifneq ($(NO_LIBTRACEEVENT),1)
-  ifeq ($(call get-executable,$(PKG_CONFIG)),)
-  dummy := $(error Error: $(PKG_CONFIG) needed by libtraceevent is missing on this system, please install it)
-  endif
-endif
-
 ifneq ($(OUTPUT),)
   ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
     BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
-- 
2.45.2


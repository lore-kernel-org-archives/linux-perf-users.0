Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31F194ADF
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688224; cv=none; b=mwR1wbc+0WSv+P7ZvdirK+7qOKlTPAvO7LXkvIt1c3xQj2jits+3Z8Cz/tqEpm7+2oV5IaSSadrJRI/YbhRdl9nKnZQW+nMrpAspaUg4h0T/Ai/pf9PzsNZUsEwNGcSMweAACtIbr2nTJbfl9DADLMYUuoeEZ9+PWr9M/MT7Fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688224; c=relaxed/simple;
	bh=VIx4zZ6+nnsbGomq49TWuitUfNpum+dP48d2VKPHOkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyBmeMoT+ciAjOgrmMpn4RtKn5LEe8VuwiTItDfEQ6wxO8FHb/rVjkdLRqAkJlExhtn65O0iH80hVQ0TgD7iURzIHNY7H6Uvepl8yoe3XxLhQoqmC9J4yNnqTCgm9+MNdowuQqnDbve1J6FOeX9TFqjPVtb6XmU6HEFrE8ytOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: amadio@gentoo.org
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>,
	Peter Volkov <peter.volkov@gmail.com>,
	Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf build: Ensure libtraceevent and libtracefs versions have 3 components
Date: Thu,  6 Jun 2024 17:33:02 +0200
Message-ID: <20240606153625.2255470-3-amadio@gentoo.org>
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

When either of these have a shorter version, like 1.8, the expression
that computes the version has a syntax error that can be seen in the
output of make:

expr: syntax error: missing argument after +

Link: https://bugs.gentoo.org/917559
Reported-by: Peter Volkov <peter.volkov@gmail.com>
Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 54a6c6bf23c7..81f73f68d256 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1179,7 +1179,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS += -DHAVE_LIBTRACEEVENT
     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
     EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtraceevent)
-    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
+    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent).0.0
     LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
     LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
@@ -1195,7 +1195,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
     EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
-    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs)
+    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs).0.0
     LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
     LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
     LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
-- 
2.45.1


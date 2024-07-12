Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09504AED4;
	Fri, 12 Jul 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813542; cv=none; b=JFTfEywPHpCVAQGrMMh22hxS7uXL/Y0x3p1QtHJyoFm1Mae0+rs5tmkhnJJvv6Ip+mKBT0dGYq02IR5F/x6piDahvSxfMF0zRNYDJ6BMjtvOPhqhtvfax5qcV7pySEaUilb+usX4/XUVSVILYOA0gZOcfapz+ZGdcBjRy5QFABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813542; c=relaxed/simple;
	bh=zXYoxhyxzG75t94bhKBw7qFADYigSajJzXH4xK6fVWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+wVQpfy98PLUphIIBUJgfyNAtX+DTwV69ASoBdZpGKMXAjV2Z071JMRsH53mk2Btg9BIcw1MX3pyJPUQtSJ2xTwHXVM5REGRBSW5H2SVrUKusJvMW5ZCFu2t/GScFZ2D9/aKnQUtscW+/7/gjokkyLumrnEPyIe3UDWUqZmabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Guilherme Amadio <amadio@gentoo.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>
Subject: [PATCH v3 5/5] tools/latency: Use pkg-config in lib_setup of Makefile.config
Date: Fri, 12 Jul 2024 21:40:50 +0200
Message-ID: <20240712194511.3973899-6-amadio@gentoo.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712194511.3973899-1-amadio@gentoo.org>
References: <CAM9d7ciLGP_w9YYOb-2U2ESg8kQx_knQXuB6_2JZVZ2ktL+bzg@mail.gmail.com>
 <20240712194511.3973899-1-amadio@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows to build against libtraceevent and libtracefs installed
in non-standard locations.

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/tracing/latency/Makefile.config | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
index b25e531a1f95..0fe6b50f029b 100644
--- a/tools/tracing/latency/Makefile.config
+++ b/tools/tracing/latency/Makefile.config
@@ -3,8 +3,9 @@
 STOP_ERROR :=
 
 define lib_setup
-  $(eval EXTLIBS += -l$(1))
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
+  $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
+  $(eval EXTLIBS += $(shell sh -c "$(PKG_CONFIG) --libs-only-l lib$(1)"))
 endef
 
 $(call feature_check,libtraceevent)
-- 
2.45.2


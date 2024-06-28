Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1680C0A;
	Fri, 28 Jun 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606899; cv=none; b=mPZ7EDdadaRLn9eXs3pcpNDY9clOH/ALRnFeIVvrV1ae3FTOdjLM6KWuzEjbdsjpItntoRr2ux6o/iwPp5qPRSDyg4sKstDdoQ2DhO5sWuUO9Uw0A+kLu6Erh2R5iexmeBKQBW1ZOy8WTxwxvPoukDm1VySNanZrzsDwzGouELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606899; c=relaxed/simple;
	bh=zXYoxhyxzG75t94bhKBw7qFADYigSajJzXH4xK6fVWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQwS2c1gXYfLKkoY8NENuFkA7DZEGiqUSffTey96q9RumGUOPIfqJXK6S6SQls9hLH8cJONQdeaWn8WbnrmQrDOpnaRIe4KI1/SSoDDiRvhO3toQoS3HS1S4fnhTwi37bWnfuw+0oTpzZXlSLrfrHccluQFhK9Jx8ZH2lgw+wwM=
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
Subject: [PATCH v2 6/6] tools/latency: Use pkg-config in lib_setup of Makefile.config
Date: Fri, 28 Jun 2024 22:34:32 +0200
Message-ID: <20240628203432.3273625-6-amadio@gentoo.org>
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


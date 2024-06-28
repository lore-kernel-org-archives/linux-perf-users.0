Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15607FBB7;
	Fri, 28 Jun 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606897; cv=none; b=QzvKqjSWonyh3wyOZK64Fp6TFlyT4FmZPowoHqrh7OxGpO6xVWS+EHteg9xx7WxoX6ZKGvF0riCb1HBsvHiAmiY9equFsd0wEZvXkfPANljj+agaqbTPI8TE0MJOjGv8SqWCQEUBpGoutMQZHWh88cXc3a6C2oKHVzEOxC+ckaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606897; c=relaxed/simple;
	bh=Z04U1ZXfxS+bYK5z/ONreK5ewQ50GaYHpXHXQORZkrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T22k6zo7COBrp2afRTXpp5mztHtI5ktiQMABgUmkpNprEHoaXtd0UebJBnzy9UEheJbok8b+rM1A7J4aBNzZteJFpHDxbqzGIHXJ+UCNDdzCdjB7xQ8ExE+3y+jRM1IxPm7I+yMvCEb70Yi8lQGFcv/QxQLYpuVu6ua5TvlwDkI=
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
Subject: [PATCH v2 5/6] tools/rtla: Use pkg-config in lib_setup of Makefile.config
Date: Fri, 28 Jun 2024 22:34:31 +0200
Message-ID: <20240628203432.3273625-5-amadio@gentoo.org>
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
 tools/tracing/rtla/Makefile.config | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 0b7ecfb30d19..5f8c286712d4 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -7,7 +7,8 @@ LIBTRACEFS_MIN_VERSION = 1.6
 
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
-  $(eval EXTLIBS += -l$(1))
+  $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
+  $(eval EXTLIBS += $(shell sh -c "$(PKG_CONFIG) --libs-only-l lib$(1)"))
 endef
 
 $(call feature_check,libtraceevent)
-- 
2.45.2


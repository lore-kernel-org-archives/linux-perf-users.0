Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36078C7B;
	Fri, 28 Jun 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606893; cv=none; b=t4ktHu9kB22nbEGR2T5uCMyl+61gdnr+0ciJU6zOEB8jF8uky6cFOB9R0L10Efz6dq8i5bdRb1UHAlBa3tQJiFieQOnWTxiOIZwkS1/fN8CStF1pkiVOnLIWFFV42D7569zjWkKWHfmqBJefHtupjOL23Wq8lrhA4Y1JSyfPkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606893; c=relaxed/simple;
	bh=HbOIV7wQ2REeMzVLnr3zwWlJWDdlsPlPehDZCZGbkEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a34uebOKYM5qMP2ak1MQPFwvMxW6QBGKEP7weZqnhOb2DkSday1H1jsLVqlxJTANeNaN+is9PVq3rQCKCQ09g1D4Hu3sfMaWEgklpXgRYj1y1B2Qi8KhGuTGT1uj8OkoMcP7e+kc0tIk2FfdBeI5XL7vMckOAZ3MlJ2rwDTUD3I=
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
Subject: [PATCH v2 2/6] perf build: Warn if libtracefs is not found
Date: Fri, 28 Jun 2024 22:34:28 +0200
Message-ID: <20240628203432.3273625-2-amadio@gentoo.org>
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

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5387babb8f04..ba51ecfca02b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1208,6 +1208,8 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
     LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
     CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
+  else
+    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
   endif
 endif
 
-- 
2.45.2


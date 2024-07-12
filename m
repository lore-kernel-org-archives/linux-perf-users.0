Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551A45C1C;
	Fri, 12 Jul 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813539; cv=none; b=pn76erY5weP7u38sfn7BhP2JLnnjt6qEL2Kn0X3Lzje5COlhNDURoBamBDbBeWKuMdvHWhHE7dSrNSceezDdtsXTavY1a+/W1tB1ckBoNNxUJGHMgMXpnvvmpOXrcvXp8L/T9kz+2S9oWMUHsX31I3wr/KbNP4B2hdRFMNW3y68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813539; c=relaxed/simple;
	bh=qLk1Nx3+6Nf4dSawq50Swo8NMyunKff2l6NNw0/rYxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeHOf8gPHnraArPjgQpoWMmmM/+fMC4YGVmAyXdbEqfmr6I9ueTqSnuv/UvwJc/ZxSlrsq+fN+0WCXEjQVxv7sEZhFh4s7Ha8QnyOoY3WFgvWiOWyhy+SJkO1AaqiK/iAL42cBpwntUhEwjqJGzgKD3ryKpkVaFuFNf6oITxqAI=
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
Subject: [PATCH v3 3/5] tools/verification: Use pkg-config in lib_setup of Makefile.config
Date: Fri, 12 Jul 2024 21:40:48 +0200
Message-ID: <20240712194511.3973899-4-amadio@gentoo.org>
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
 tools/verification/rv/Makefile.config | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/verification/rv/Makefile.config b/tools/verification/rv/Makefile.config
index 6d4ba77847b6..066302230eb2 100644
--- a/tools/verification/rv/Makefile.config
+++ b/tools/verification/rv/Makefile.config
@@ -7,7 +7,8 @@ LIBTRACEFS_MIN_VERSION = 1.3
 
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
-  $(eval EXTLIBS += -l$(1))
+  $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
+  $(eval EXTLIBS += $(shell sh -c "$(PKG_CONFIG) --libs-only-l lib$(1)"))
 endef
 
 $(call feature_check,libtraceevent)
-- 
2.45.2


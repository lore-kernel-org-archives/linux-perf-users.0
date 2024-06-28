Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6119A7F484;
	Fri, 28 Jun 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606896; cv=none; b=iVpGd9fdqkamiTf2UrK6TFh4mUZ1b0J2ub5r9MjeNOFtAjrEo/YYyZqPmRWE9uCGi1WK8WRtG+9PfqTdftURWKSHp+qQo4TDQIZ6/Za8X/BOoe7Dz/AG0oDwVB3SH5xCCR8KPRpUn6ZLaSf1NMFF9+R3gw6zOizgpaIpokTkPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606896; c=relaxed/simple;
	bh=qLk1Nx3+6Nf4dSawq50Swo8NMyunKff2l6NNw0/rYxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4wqMK7H1hkGU7SpJOXWTnWBzKu3f0oGvyLGF9NyKLikbFYFMhsPeWkA1AgKZx0vRkWq3iBVqpGysRoOGkyeOiJCHYiEt1RM/cM26+tpuuokBz9B1GFiwiBhvZFX/plmnBRVw4u6m/g0lV7x2T6bZiz0I0aYWpXgZe9yjbtaNqc=
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
Subject: [PATCH v2 4/6] tools/verification: Use pkg-config in lib_setup of Makefile.config
Date: Fri, 28 Jun 2024 22:34:30 +0200
Message-ID: <20240628203432.3273625-4-amadio@gentoo.org>
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


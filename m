Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2E224FD;
	Fri, 12 Jul 2024 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813536; cv=none; b=UhEdTIaQlTVbaaWE3TVr0r8L0Jl1B3EC+zzjRqzGcmUh0Tvc86stLONcYWtF65BPBXpwdikyTUCI3DgeYPfTsiD3LBJnABtW9XjngIzY6v4201u3gOiEyEGkaOnQ+ynskei7kRVeyomC4oOaxi5FwI4Sp3GQUlctHxmvVuRwkIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813536; c=relaxed/simple;
	bh=qlY3ce3aTLN3a11GeVfOh1OUSwpc/UT6wsLeukSXBB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogha5dppQl6kAUP7nKLWvmH4RwfTTr3IrVbWQHxF5AxyesYLvc2ycj1ppXNvQzMDosPvkNbOtjmZNiTvqDYAavLto9D5XBFaV74QmnOWle5cF7i4Xe4JheHzDt6jXjc1Dyx1PP1H+ir7MER4za+XpeErvQMR/AKwaKszqd+AEn4=
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
Subject: [PATCH v3 1/5] perf build: Warn if libtracefs is not found
Date: Fri, 12 Jul 2024 21:40:46 +0200
Message-ID: <20240712194511.3973899-2-amadio@gentoo.org>
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

Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a4829b6532d8..44f010b9f562 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1206,6 +1206,8 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
     LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
     CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
+  else
+    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
   endif
 endif
 
-- 
2.45.2


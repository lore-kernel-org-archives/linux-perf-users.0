Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC0254AF4;
	Wed, 19 Mar 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382307; cv=none; b=r5E9KAr8QUAKpJ345sXz5lyr9qsYnUC9v102oJP4RmwjP7LMU0RTbrFzdKNeBKRJrxy4hF+rlt6wEFJ25iRPdKGC8XPDzsEXVSLi6/9EttJmd4LBwEnDSQfCu/WEHM0bFVMiBVNzm+L6t6ES2Icr8ffeCQQV1x7UdUFeevnF1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382307; c=relaxed/simple;
	bh=H8YZFy2OpxQjvAr2hYSF9g8nC85UqKFdVDGcV6abypA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VMtFurxoajiVOHhE3RFgfDfY9BRdnULINBvPzZoFJJulGKZznq+rJi7n0aotSxPFlhAxSfDoT+3HzOI3hTSWUAr0//9F3DpiAKRj1kfb58VpG8fj/luJ1s9dA46b6/KpoE5SYuPpqiWnxjbENYylfq2aP/ubVzguVgRpTGvjLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89A79106F;
	Wed, 19 Mar 2025 04:05:09 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98FE73F63F;
	Wed, 19 Mar 2025 04:04:59 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf build: Restore {0} initializer since GCC-15
Date: Wed, 19 Mar 2025 11:04:54 +0000
Message-Id: <20250319110454.3230687-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC-15 release claims [1]:

 {0} initializer in C or C++ for unions no longer guarantees clearing
 of the whole union (except for static storage duration initialization),
 it just initializes the first union member to zero. If initialization
 of the whole union including padding bits is desirable, use {} (valid
 in C23 or C++) or use -fzero-init-padding-bits=unions option to
 restore old GCC behavior.

This new behaviour might cause stale and unexpected data we defined in
Perf.  Add the -fzero-init-padding-bits=unions option for entirely
zeroing union structures.

[1] https://gcc.gnu.org/gcc-15/changes.html

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a148ca9efca9..f767ab634022 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -323,6 +323,14 @@ FEATURE_CHECK_LDFLAGS-libaio = -lrt
 FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
 
+# As described in GCC-15 release: https://gcc.gnu.org/gcc-15/changes.html:
+#   "{0} initializer in C or C++ for unions no longer guarantees clearing
+#    of the whole union (except for static storage duration initialization),
+#    it just initializes the first union member to zero. ... use {} (valid
+#    in C23 or C++) or use -fzero-init-padding-bits=unions option to
+#    restore old GCC behavior."
+CORE_CFLAGS += $(call cc-option,-fzero-init-padding-bits=unions)
+
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
-- 
2.34.1


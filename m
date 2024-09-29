Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931823CF6A;
	Sun, 29 Sep 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602265; cv=none; b=XkYOEtaNrH7daEvdggGQKOGgCud17babushvqqXoAK1qyPbgDJkelaZViSS/E0wgicn+48ggCUQlGAWc0D5iQxu9tZFOjF7qM1Wqos7stbL+Fw9sHxgYSS3q4arsN0C+yZp+dx2f1zWqgzkpcqG8ihNHRgmHhx24FMYpZyhtpPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602265; c=relaxed/simple;
	bh=y/yrw8IdhUiYNjwL6f7V5Tpfh4cenVZCMUjGHoW82Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RX1Kt4x1JGT9GDG710gT9nbkcqBSmSVUVZlfJO6EBwYEreb2IRBjQ42UdMbLrL3FUchm/vFgogskzrwJfd9jHvEqiVPOOb0tvRBY8mI3mfC+FID4rzM2PUmmZFt2UNbjORBEIxuJjHQEHeXpx2ZLCqguyvX/52xF0P1Ze8dLr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mAIjeo4u; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mAIjeo4u"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727602254; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1KEEdab501pVAO9JeHpa5jIgJVWskFMCc3LD/HsYdGs=;
	b=mAIjeo4u4tG7CsTZ42m6cPZS0drO+xoC3hmDFrM52dYwb8eY12v5B187wvkRpgzfUjCVIq10NYj2CqMedpGmcDqkJ19DPnvtylI61pi51lDu/3vV7RE5VVcI90RkHmbDROyxnJl4phQCCd4TRiTbCi194mef2u3KDgVIca2VKEI=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WFvzT5V_1727602246)
          by smtp.aliyun-inc.com;
          Sun, 29 Sep 2024 17:30:53 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2 -next] perf test: Use ARRAY_SIZE for array length
Date: Sun, 29 Sep 2024 17:30:45 +0800
Message-Id: <20240929093045.10136-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./tools/perf/tests/demangle-java-test.c:31:34-35: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11173
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Modify the header file "kselftest.h" to "linux/kernel.h".

 tools/perf/tests/demangle-java-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
index 44d1be303b67..93c94408bdc8 100644
--- a/tools/perf/tests/demangle-java-test.c
+++ b/tools/perf/tests/demangle-java-test.c
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <linux/kernel.h>
 #include "tests.h"
 #include "session.h"
 #include "debug.h"
@@ -28,7 +29,7 @@ static int test__demangle_java(struct test_suite *test __maybe_unused, int subte
 		  "void java.lang.Object<init>()" },
 	};
 
-	for (i = 0; i < sizeof(test_cases) / sizeof(test_cases[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		buf = java_demangle_sym(test_cases[i].mangled, 0);
 		if (strcmp(buf, test_cases[i].demangled)) {
 			pr_debug("FAILED: %s: %s != %s\n", test_cases[i].mangled,
-- 
2.32.0.3.g01195cf9f


Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55280188A13;
	Fri, 27 Sep 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426414; cv=none; b=m1FAVEistxbS7/Nup912e9usFGZE0izd/8XsWhR17JtKsdoj907ciYCVILNcmkkxvExS4tkTaXLnQv8Kn2eXBsxmbgsLKVrgSTvNkyVz1sYEx0/ojCt04JiBSyfs8yjf3NpsJiNHGomK/2u/hwvbheRDy8MZIZ30epeGdYEEgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426414; c=relaxed/simple;
	bh=2FBkk0yLD16RQQyh1heH4ztZUj0UmTANpi28s92/U7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kqftJ36GHcJ9+uBhNF+DD3NJRf6ktd9TcyngueHRZsbl4T0H2tXcGajnnd1xJNdAhXYe6o9j3qfCppEEB3szElKyLORCZS6Pc2S7Q7pn0XlUQhXYQ8c6Qh0hQKsEg6SLctiGaBtX8fRrNc7J4SDfbhgDr5xlmq2NsPoKFsXskjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=llo5zjpR; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="llo5zjpR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727426408; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GDvQ4ucNXmwvli4Xh35RrqDvu4gn2U4viPcCqlB44+Q=;
	b=llo5zjpRTzI2R7TvskGynMXMIpkjhiuBFBnceBmWNNtttKrG/cbcpdqoA+3JzVnWeeon59/WiVL3O2iSxt9KpEQl4Gvjoy56w/fjVzRf2oTPil4iyU18cDlkC2sCQ8mG8DFfTdv51S7moUOv7UodDaKx2lhpF5cG0zvoZFN3HWM=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WFq6Vdc_1727426403)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 16:40:08 +0800
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
Subject: [PATCH -next] perf test: Use ARRAY_SIZE for array length
Date: Fri, 27 Sep 2024 16:40:02 +0800
Message-Id: <20240927084002.8437-1-jiapeng.chong@linux.alibaba.com>
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
 tools/perf/tests/demangle-java-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
index 44d1be303b67..611c18cdf4d3 100644
--- a/tools/perf/tests/demangle-java-test.c
+++ b/tools/perf/tests/demangle-java-test.c
@@ -6,6 +6,7 @@
 #include "session.h"
 #include "debug.h"
 #include "demangle-java.h"
+#include "kselftest.h"
 
 static int test__demangle_java(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
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


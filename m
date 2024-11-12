Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6A1A0AFE;
	Tue, 12 Nov 2024 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391285; cv=none; b=raazxSBXhI4Q6dz1tDKtzI7tEbPtYlzOImBU3EVVOYh/1aj6pwhzJYEt5iyPP9IPuMS1ohesaQlFWPgHXawTsjeyqIMZn31trAeRetYxJxFUIKg8R6qbTtaWCAq7FPga8Te/tY64Ohvo8Klr7q97CpxAG+AuJyoYV10quYQ6nHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391285; c=relaxed/simple;
	bh=66qUZLgWuxj88U/ojOcgZSc3hCJottpI1ddRUJ5yBmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbqLUraH9qnHu4bjHthA/Olrow59GUZQK0xc7J7v3xL+ce+Xtr9FD26eiWGbvNEXHyOSXbMIj/Q4RGGmgIraxAy+wYDcipYR7Mw/7Q/AzhgD0Jxg9kBsif06tEI/48Cn9sWu4YsFZH2UJltlP31WQmg4mXlsL/OMJgVPprXRrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96732ef2b026-1203b;
	Tue, 12 Nov 2024 14:01:15 +0800 (CST)
X-RM-TRANSID:2ee96732ef2b026-1203b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96732ef2aaab-46f56;
	Tue, 12 Nov 2024 14:01:15 +0800 (CST)
X-RM-TRANSID:2ee96732ef2aaab-46f56
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org
Subject: [PATCH] perf jvmti: Remove unnecessary ret variable in jvmti_write_code
Date: Tue, 12 Nov 2024 14:01:03 +0800
Message-Id: <20241112060103.282531-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <ZzJErOTawAelWAQd@x1>
References: <ZzJErOTawAelWAQd@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Following the approach in the jvmti_write_debug_info function, just
remove the ret variable from jvmti_write_code function. It's safe since
we don’t really care about the return value of fwrite_unlocked. This
change makes the code cleaner and more compiler-friendly.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/perf/jvmti/jvmti_agent.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 526dcaf9f..9b49a880b 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -363,7 +363,6 @@ jvmti_write_code(void *agent, char const *sym,
 	struct jr_code_load rec;
 	size_t sym_len;
 	FILE *fp = agent;
-	int ret = -1;
 
 	/* don't care about 0 length function, no samples */
 	if (size == 0)
@@ -400,7 +399,7 @@ jvmti_write_code(void *agent, char const *sym,
 	 */
 	rec.code_index = code_generation++;
 
-	ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
+	fwrite_unlocked(&rec, sizeof(rec), 1, fp);
 	fwrite_unlocked(sym, sym_len, 1, fp);
 
 	if (code)
@@ -408,9 +407,7 @@ jvmti_write_code(void *agent, char const *sym,
 
 	funlockfile(fp);
 
-	ret = 0;
-
-	return ret;
+	return 0;
 }
 
 int
-- 
2.27.0




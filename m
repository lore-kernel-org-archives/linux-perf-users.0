Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E6E2C187;
	Mon, 22 Sep 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534667; cv=none; b=jkaMXEG0gldDMWd9+u//A8XSM6MKHz2cto4oV90mrxfK72pSIcY0cG3LcX7jB1YoqyAuq5x/R/5HbB8nXdPkFuUnno3GUGTcpFzSQxyD9AM3sgQpuv5KSUFaWZgrPNOlWyucSQ1SFGBw/VU6Gv+bYZD8oF668QY8NtC8vh3kWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534667; c=relaxed/simple;
	bh=UFwZJr0aFA/XsWzfw/1yPz0pmDbK1CxNoKSdVsZrNPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cg9IOW61R0lLOFqFqHOsJh4wh+ymp40mSOwY0whIE/5RgrKkMAjIA4I4kAVmNH8hY0ORS0k5rOQbUgn4tqcVunR8lBAArdVUrYCQ+towiJDmTW2OFHgKVclgX9lS9s0T6UP8c7xieA+vjqho+VeXbT5ZgOfRwXP9mZpfKrFmRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee168d11c044bc-ffea6;
	Mon, 22 Sep 2025 17:51:00 +0800 (CST)
X-RM-TRANSID:2ee168d11c044bc-ffea6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee368d11c021c8-9f99b;
	Mon, 22 Sep 2025 17:51:00 +0800 (CST)
X-RM-TRANSID:2ee368d11c021c8-9f99b
From: liujing <liujing@cmss.chinamobile.com>
To: john.g.garry@oracle.com
Cc: will@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	suzuki.poulose@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] perf sample: Fix the wrong format specifier
Date: Mon, 22 Sep 2025 17:50:57 +0800
Message-Id: <20250922095057.3136-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the file tools/perf/util/cs-etm.c, queue_nr is of type unsigned
int and should be printed with %u.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 30f4bb3e7fa3..d13575285b19 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -777,7 +777,7 @@ static void cs_etm__packet_dump(const char *pkt_string, void *data)
 	char queue_nr[64];
 
 	if (verbose)
-		snprintf(queue_nr, sizeof(queue_nr), "Qnr:%d; ", etmq->queue_nr);
+		snprintf(queue_nr, sizeof(queue_nr), "Qnr:%u; ", etmq->queue_nr);
 	else
 		queue_nr[0] = '\0';
 
-- 
2.27.0




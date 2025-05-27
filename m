Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B2252900;
	Tue, 27 May 2025 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748348328; cv=none; b=EabCQXiZonUxQm+ayiH4V8v9gIiwTWW2pDiGZQKhFS82TdOGeGLOPHu997HQTtTwSoTv/Jxl7eJku8fQY+alEFtLmfQ+H2M+PtJ3tRXl9ddVOmcwgRmAs8paR7IYZTR77TDTlTVCgpq4uH/ZyN7M9ae0oFYf5tkLtVO/fYuRLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748348328; c=relaxed/simple;
	bh=/eefn+eDVVtUFUuomF+8uZlnhalwFfkkO+s8F61KuII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohPSDXhIFujCpQR6l9liL9KXmgix1Uacyq4sf7wed9QeOb/XMuJc51zDvT9tGp9zi5WhvBbF+8NEdnZZdBJ4fESkEotSqhuN7OQVMmf3p/3kQDum03jNwcxT+Rxj9Ty5ApUXMbNSh53OYGuql3BuPyPht9zyFuquLNt8QpjxmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFFD614BF;
	Tue, 27 May 2025 05:18:28 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D85593F5A1;
	Tue, 27 May 2025 05:18:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf: arm_spe: Relax period restriction
Date: Tue, 27 May 2025 13:18:27 +0100
Message-Id: <20250527121827.3919495-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The minimum interval specified the PMSIDR_EL1.Interval field is a
hardware recommendation. However, this value is set by hardware designer
before the production. It may not accurately reflects actual hardware
limitations, and tools currently have no way to test shorter periods.

This change relaxes the limitation by allowing any non-zero periods.
This gives chance for experimenting smaller periods. Add a warning
for reminding the period is less than recommended threshold.

The downside is that small periods may increase the risk of AUX ring
buffer overruns. When an overrun occurs, the perf core layer will
trigger an irq work to disable the event and wake up the tool in user
space to read the trace data. After the tool finishes reading, it will
re-enable the AUX event.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3efed8839a4e..a00229ddfa08 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -309,15 +309,22 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
 static void arm_spe_event_sanitise_period(struct perf_event *event)
 {
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
+	struct device *dev = &spe_pmu->pdev->dev;
 	u64 period = event->hw.sample_period;
 	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
 
-	if (period < spe_pmu->min_period)
-		period = spe_pmu->min_period;
-	else if (period > max_period)
+	if (period < spe_pmu->min_period) {
+		/* Period must set to a non-zero value */
+		if (!period)
+			period = 1;
+
+		dev_warn_ratelimited(dev, "Period %llu < %u (recommended minimum interval).\n",
+				     period, spe_pmu->min_period);
+	} else if (period > max_period) {
 		period = max_period;
-	else
+	} else {
 		period &= max_period;
+	}
 
 	event->hw.sample_period = period;
 }
-- 
2.34.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08895453A45;
	Wed, 29 Jul 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336966; cv=none; b=OO0jPHExTRdJzIJLqhrFwuCjIuc1RR6k+CQVJ5PyMIc5VZumwEmBp7LDNPq1l1wCQ5F2PQ7/6v6nLxsKlnm37SJNEc+rtlNkAm0XAVQ2sT0GbVUCS48ONzRxbg4NhyaLA1xqBZFsgb/N1RSjkgrAPj9v0V7eBoOfb98LYjNfzVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336966; c=relaxed/simple;
	bh=xuqRq7oiM55XGUB6WttPCCYgnRIQVqmtUNyhJK1fnTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbC7g6oYe/HGXthXQbzn8OcdteZLQ8icSd+wcBtRICXkwR0olu00/B0obXBLZzFWw4kWncrkuEFk9aQJky9z0kEjSXlLX9PHNKvM6Oqy/Cc3H+4D4EAWz3UKZVhFbEOAz7zGd/M5A+6n3+aliZICO+wAnQycK1ARjPNRt5mwUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91EC1F000E9;
	Wed, 29 Jul 2026 14:56:04 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to the managed CPU
Date: Wed, 29 Jul 2026 07:55:51 -0700
Message-ID: <20260729145555.3919550-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145555.3919550-1-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMU pins its overflow interrupt to info->on_cpu in the hotplug
online/offline callbacks, but requests it with only IRQF_SHARED |
IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
smp_affinity write can move the interrupt to another CPU. cxl_pmu_irq()
then runs cxl_pmu_read() there, doing local64_cmpxchg()/local64_add() on
hwc->prev_count and event->count concurrently with the managing CPU;
local64_t is only atomic against same-CPU access, so counts get
corrupted.

Add IRQF_NOBALANCING so the pinning done in the hotplug callbacks holds,
matching other uncore-style PMU drivers.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index d1e810601e36..8b89db8f4d68 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
 	if (!irq_name)
 		return -ENOMEM;
 
-	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
+	rc = devm_request_irq(dev, irq, cxl_pmu_irq,
+			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,
 			      irq_name, info);
 	if (rc)
 		return rc;
-- 
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0D4137BF;
	Tue, 28 Jul 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272764; cv=none; b=T7Q+WIG3G4HgExbaphCyFQPNP6XHBWu97z1cqRJrAH6vm0k1HKBcGs8vKP+382XtorEjBk6Xlcuo9E9kU2S5wkIFw7xiRbwFvBlnsvHeMBG9vgu/Yjqfm4yAXUlFGH67uT79B++4qAwCwLV/7JN8U/dx+F0w3JO6WeQ/j2zBTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272764; c=relaxed/simple;
	bh=a4r8yl43AtuLsF86YlSfpyqoiX93garWsUYzJ93iNiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMl3k/Z6CvHd359x9aXmYnN9qTd9/9lkxuaG2DGCZ8LO1z03Xuw3Z6AAUxJgGsFtFtOuklRvkLr40Ko9nEoeDJv0ePWRTC9ZH+BRrz/6eCfeaDTLGqbYXyet/0ZeRYMBJCZn3PlSPVXCZ2GCPtlXKXRQuaZAj4eMgYlgwuXHnTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AFF1F000E9;
	Tue, 28 Jul 2026 21:06:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 5/9] perf/cxl: Keep the overflow interrupt pinned to the managed CPU
Date: Tue, 28 Jul 2026 14:05:47 -0700
Message-ID: <20260728210551.2449093-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728210551.2449093-1-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
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
index 7db858727ac6..0c53f9e5ccb1 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -876,7 +876,8 @@ static int cxl_pmu_probe(struct device *dev)
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


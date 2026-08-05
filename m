Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0034C990;
	Wed,  5 Aug 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945566; cv=none; b=VR0gbIjREq4RRI3zrnnacmtjy/WUp09PV+GsUw+lOAYYO0zkHa9JMyMZ3xZGbfG7VbsjjOvvufOFloRe5rDQURiKUmbcywGwzlKXrCwt3dXtYPcj803HKKjvlQv/FjtQUN9xUHbZrBuF+puWcnEWeuq7d2nwBbYPM/nPxeW8TXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945566; c=relaxed/simple;
	bh=VCkp5ryVq1A6siNUMMKti6+PcB0fUFEUBdSI/EGQIbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+SurfHpFNJ32jfLBWtXVsaR14bAeb872T3q7oHlbYg4doVsDomHex9S6SeKHcJeqPSDnCl30W4ryenU5h11JvII9ub9eMV29BsGIIBCst9l8scq8S5vxoAu4LoLBT6PgR7PB6syVKw17K9rwh2FwtMlncTnlyVhgEvzDhwqVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2331F00A3E;
	Wed,  5 Aug 2026 15:59:18 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH v4 04/11] perf/cxl: Accept an overflow interrupt on MSI message number 0
Date: Wed,  5 Aug 2026 08:59:04 -0700
Message-ID: <20260805155911.1304807-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_pmu_probe() rejects the PMU when info->irq <= 0, but at that point the
field still holds the MSI/MSI-X message number the device signals overflow
on, not a Linux virq. That number is 0-based, and -1 means no interrupt
support. Message number 0 is valid and pci_irq_vector() takes a 0-based
index, so a compliant device signalling on the first vector fails to probe.

Reject only the no-interrupt case, matching how the CXL mailbox and event
interrupts handle it.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Move ahead of the info->msi_vec rename so this one-liner stands alone for
  backporting (Robin).
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 40741e529d9b..2bebbbe67a0a 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -873,7 +873,7 @@ static int cxl_pmu_probe(struct device *dev)
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	if (info->irq <= 0)
+	if (info->irq < 0)
 		return -EINVAL;
 
 	rc = pci_irq_vector(pdev, info->irq);
-- 
2.54.0


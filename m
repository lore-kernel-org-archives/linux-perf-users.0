Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443048424B;
	Wed, 29 Jul 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336964; cv=none; b=cdlVfgaYT9pJt1OkA8QsdGCtSvq/I+T090v3i5nxDPPvOpxbNCCVzFTDG7H10CR4x1ONXYnb7yoNBVw+RKywsGUyy5xe3kbxQ2732CnetJc5FhZFNGKtBfdxyY9+hJYPsFI+sUzVI4lWhMwZSEwb8R0FaVNLq2W7/hjaTnKgLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336964; c=relaxed/simple;
	bh=3aqtGz4B8aNp3idomMo7CIBCoZ3MJmmmAY4m7Vyz3hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1g/K5xXkkJaj9zhXDl6irzKTvQs7GNKqbTOPKsgpYzC/HQxYbT6CIsAP3fIqmHxq5pP4bLHqROM/ktVZ4k8MPj5HWm61cd5O3p3gVInKoNHoRAyqYHl6m2bnPARsKchvuBFwsReL+wfN1f+BuETl+cKg5CEUmo1HsvX3qjC60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520491F00A3D;
	Wed, 29 Jul 2026 14:56:03 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 4/9] perf/cxl: Accept an overflow interrupt on MSI message number 0
Date: Wed, 29 Jul 2026 07:55:50 -0700
Message-ID: <20260729145555.3919550-5-dave.jiang@intel.com>
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

cxl_pmu_probe() rejects the PMU with -EINVAL when info->irq <= 0, but
info->irq holds the MSI/MSI-X message number the device signals overflow
on (CXL_PMU_CAP_MSI_N_MSK, a 0-based 4-bit field), with -1 meaning "no
interrupt support". Message number 0 is valid and pci_irq_vector() takes
a 0-based index, so a compliant device signalling on the first vector is
wrongly refused and fails to probe.

Reject only the no-interrupt case (info->irq < 0), matching the sibling
CXL mailbox and event IRQ handling.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 956da8202551..d1e810601e36 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -876,7 +876,7 @@ static int cxl_pmu_probe(struct device *dev)
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	if (info->irq <= 0)
+	if (info->irq < 0)
 		return -EINVAL;
 
 	rc = pci_irq_vector(pdev, info->irq);
-- 
2.55.0


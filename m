Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E493F4831;
	Tue, 28 Jul 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272762; cv=none; b=i7R1Eq60kZYiGIcpZo5mWagbJhDFfRlEvBx7XLn63BXniJpkjk44XXVRuPTbEyBpx/WlcIUXIrd34lvjAFF6QAiG95YN5uXKSMkXVVXb0jZvesP3g0QZ81zEO+KgWnyZQm2cDoue5MX2ZuS7Fa9hI/2ce/XZ5DYbSKff6RrzyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272762; c=relaxed/simple;
	bh=BNhQyT+dIMNUCsnsTCoRhJ1awXqkWcOT4lcZrDeZZ68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA7kegWjGMFZkw8WZZ0TqJtgCKJeepVjqe/irJSuQrBQ9yzLdIAobsPGOeG9UKuBM52AJGJ+YzyfYHGAF9ZXFsTnDp6JQ79gvTI7P4bTgIwwyfQ2lYT9FRHGBfocCiIVieFcD4vNG9IrbJeb/pJlG+7d2+68uJFXc8aPYFmzudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB41E1F00A3A;
	Tue, 28 Jul 2026 21:06:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 4/9] perf/cxl: Accept an overflow interrupt on MSI message number 0
Date: Tue, 28 Jul 2026 14:05:46 -0700
Message-ID: <20260728210551.2449093-5-dave.jiang@intel.com>
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
index 410c9162c824..7db858727ac6 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -864,7 +864,7 @@ static int cxl_pmu_probe(struct device *dev)
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	if (info->irq <= 0)
+	if (info->irq < 0)
 		return -EINVAL;
 
 	rc = pci_irq_vector(pdev, info->irq);
-- 
2.55.0


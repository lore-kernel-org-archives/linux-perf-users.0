Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC447FB04
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945311; cv=none; b=p/2TSRv/1pLZ5XVQy2ygORpsStfjtmuKhmkJRiCb9W7hVMxyaEf2ShWcAZ30dMlWOx18tdw4qt+fOeczUYVF2bXie0vaIixm8lEgC9XzByOVbsZ71SM0wtStO3IdJXq+uhI9rP7Fv9/utf5z4QRc+iyn8XrPNgW6nmD4ztQ06xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945311; c=relaxed/simple;
	bh=VCkp5ryVq1A6siNUMMKti6+PcB0fUFEUBdSI/EGQIbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPJlhCbZIvROTAXMpuIsxFdAGqg4KLY5aH2mm5XcVDbzjfJ44kQvVOfY43EnG0978Z/VqanJkLuVm1J33t20UbmVyiJ4yMdFZGnwyZ54RwjeMDdSm0xee61qrLu5tw46jp9U08SZeZ6wv3H2Cee2ExEnCMtnNdMZ+qJbOtFXhGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34231F000E9;
	Wed,  5 Aug 2026 15:55:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: inux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 04/11] perf/cxl: Accept an overflow interrupt on MSI message number 0
Date: Wed,  5 Aug 2026 08:54:54 -0700
Message-ID: <20260805155501.1294472-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155501.1294472-1-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
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


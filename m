Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778D3C3F50;
	Fri, 31 Jul 2026 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540517; cv=none; b=ABLOm3jF4VjrNrt1lEk2G9LMQayA7RJQ1dQC0JYhExwMuw/Sx++rXS80Kj50zmrfZ0sFxVzhqrQT42eMQePg7dy8wdzDqlC7z+Zx1Ei/pV1NRSlP5mT5U5Qnw64NOfn/rifnj6VxMpjmde4H1szEny6BQJeSfGKWPtC7iP83vE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540517; c=relaxed/simple;
	bh=APurx+3M8unRDj8PZiXm0YdM7n3o3uA21nOGNjgLF8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRmmLyo2oYcf5M0O/qp0he9C7rbcrvdbxA3lPastx2OoM7wIvjBWpP6HGLXhiNVKxhhRQkexmgClJeVOXJ9rX2LHAk65JdB8Ooa9dPMIH3uagrXueUUhqGNwjqGmYLeZeFvY043g0AsMWR5c1gLT5fJdkVspES+NvhDF9rIeHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306BF1F00ACA;
	Fri, 31 Jul 2026 23:28:36 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 5/9] perf/cxl: Accept an overflow interrupt on MSI message number 0
Date: Fri, 31 Jul 2026 16:28:23 -0700
Message-ID: <20260731232827.401447-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731232827.401447-1-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_pmu_probe() rejects the PMU when info->msi_vec <= 0, but that field
holds the MSI/MSI-X message number the device signals overflow on. The
field is 0-based, and -1 means no interrupt support. Message number 0 is
valid and pci_irq_vector() takes a 0-based index, so a compliant device
signalling on the first vector fails to probe.

Reject only the no-interrupt case, matching how the CXL mailbox and event
interrupts handle it.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Rebase on the preceding patch, so this tests info->msi_vec rather than
  info->irq. The fix is unchanged and the hunk is still one line.
- Not guarding against pci_irq_vector()'s INTx fallback for vector 0, which
  it returns when neither MSI nor MSI-X is enabled. A v3 draft added a
  pci_dev_msi_enabled() check for that, but a modern CXL device wiring up
  INTx is not a realistic prospect, and the consequence otherwise is a PMU
  that counts nothing rather than anything unsafe. Left alone to keep this
  a one-liner.
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 56e6ae7bebf7..c9e30cb149df 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -875,7 +875,7 @@ static int cxl_pmu_probe(struct device *dev)
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	if (info->msi_vec <= 0)
+	if (info->msi_vec < 0)
 		return -EINVAL;
 
 	rc = pci_irq_vector(pdev, info->msi_vec);
-- 
2.55.0


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72033481241;
	Wed,  5 Aug 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945571; cv=none; b=GWJ9k9talxJPPz5ghmZde4wHSqn3VUjulvSnuiNASEQJbXn8PZy4kPf2FIeIUJU9rsho2wNQxMX7DJbGx9AeeBpLVTn+E+QauW0mzpUSU4S+KDYcOmmnGZtnY/7OgC9swdBP0YPatgG9i+nNwCJDgEwN/ve/I6y+4pEU8guQY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945571; c=relaxed/simple;
	bh=9mC0vWnG6zGdJJwjH0qspuBkVa29oc8jd5CQlhwJGbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiEemnGh6TZaB4ffhpWm3cQbDopyEE7ONVZICNnMHwz/q96E9196BM8YQODpHtf2WwmyL0iDBlVWhX0J/QXWYVqX6t0VQ2EJVp2b1H5HA2QK4hfogU8R1Bl3XIV+38lOKpO01T6QrkFdIwETuOF7insKdrlKMpiewiV26CmA/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610411F00A3F;
	Wed,  5 Aug 2026 15:59:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com
Subject: [RESEND PATCH v4 05/11] perf/cxl: Split the MSI vector out of info->irq
Date: Wed,  5 Aug 2026 08:59:05 -0700
Message-ID: <20260805155911.1304807-6-dave.jiang@intel.com>
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

info->irq means two different things depending on how far probe has got.
cxl_pmu_parse_caps() sets it to the MSI/MSI-X message number from the CPMU
Capability register. cxl_pmu_probe() passes that to pci_irq_vector() and
then overwrites it with the Linux virq, which is what the hotplug callbacks
hand to irq_set_affinity().

Both are ints called irq, so nothing catches a mix-up, and the valid ranges
differ. 0 is a fine message number but never a valid virq.

Give the message number its own field. No functional change.

Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Move after the one-line fix so that fix has no dependency on this rename
  (Robin).
---
 drivers/perf/cxl_pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 2bebbbe67a0a..481d32d0c1b0 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -106,6 +106,7 @@ struct cxl_pmu_info {
 	int on_cpu;
 	struct hlist_node node;
 	bool filter_hdm;
+	int msi_vec;
 	int irq;
 };
 
@@ -143,9 +144,9 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 
 	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
 	if (FIELD_GET(CXL_PMU_CAP_INT, val))
-		info->irq = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
+		info->msi_vec = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
 	else
-		info->irq = -1;
+		info->msi_vec = -1;
 
 	/* First handle fixed function counters; note if configurable counters found */
 	for (i = 0; i < info->num_counters; i++) {
@@ -873,10 +874,10 @@ static int cxl_pmu_probe(struct device *dev)
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	if (info->irq < 0)
+	if (info->msi_vec < 0)
 		return -EINVAL;
 
-	rc = pci_irq_vector(pdev, info->irq);
+	rc = pci_irq_vector(pdev, info->msi_vec);
 	if (rc < 0)
 		return rc;
 	irq = rc;
-- 
2.54.0


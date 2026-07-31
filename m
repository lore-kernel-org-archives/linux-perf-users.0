Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B423C3F50;
	Fri, 31 Jul 2026 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540516; cv=none; b=smAEUZXM3bYpZba0sgKjIYYBa6h7s938u1WSJuoTr3tamwsVg+8cFPhzPs4s5XbJOfdz9SUYk+tb4kUm07g75T/p+CwwhZ3yAkkkXLTgBONlR6Ag8dAXCggk1bAVXJfuPMSG0TTfOS1tc2aFDkaG+oBHfYEmqquURs3+MIEqRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540516; c=relaxed/simple;
	bh=aX6wbFW3AmDQxsnnJI8hSWA4TtQhMM+EjrGODgpdZ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcXBFTKWV7dQd43s3UyzqVdrZ2/Yo6pdBx6HrYGEG01mUCpamMaM434DMTb92+fddz23x1WsQcCMmouKFB8pPN1TQcMT8dcvLbm+8B4p13tRjdEhIEyvEWwsOjBXspE7WFopX83ej6xKH8ljkKh6BNu5P7icxn3iZHMSsvvXNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89871F00AC4;
	Fri, 31 Jul 2026 23:28:34 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com
Subject: [PATCH v3 4/9] perf/cxl: Split the MSI vector out of info->irq
Date: Fri, 31 Jul 2026 16:28:22 -0700
Message-ID: <20260731232827.401447-5-dave.jiang@intel.com>
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

info->irq means two different things depending on how far probe has got.
cxl_pmu_parse_caps() sets it to the MSI/MSI-X message number from the CPMU
Capability register. cxl_pmu_probe() passes that to pci_irq_vector() and
then overwrites it with the Linux virq, which is what the hotplug callbacks
hand to irq_set_affinity().

Give the message number its own field. No functional change.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- New patch
---
 drivers/perf/cxl_pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 3511d049aea4..56e6ae7bebf7 100644
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
@@ -874,10 +875,10 @@ static int cxl_pmu_probe(struct device *dev)
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	if (info->irq <= 0)
+	if (info->msi_vec <= 0)
 		return -EINVAL;
 
-	rc = pci_irq_vector(pdev, info->irq);
+	rc = pci_irq_vector(pdev, info->msi_vec);
 	if (rc < 0)
 		return rc;
 	irq = rc;
-- 
2.55.0


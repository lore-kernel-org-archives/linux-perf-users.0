Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2047D932
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945314; cv=none; b=pnYAFmHtxQmtCnlJHwZhRnsH9vUplTr7MO685h9ns7zkZWaSfCmHpqAkpsFUFwAOiQ1O0PRCHFeSpQgAbLfXlqR11Ee993dy+oaGDTrRzPUXZetZG8GjsJE+M0LRoq8PkMq5y5i4HZmsE1s4DpYO0jKaAfC9S7Ble64ZY1wZFuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945314; c=relaxed/simple;
	bh=zvIx8GZYlZMfIJ5stpFdDNrYpXFApk8rb8wBlS6RYFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GT9d0cZUHbySTiXyL57sU1YjTyWRNViSrvrPOxmo4/vpNUFge4LLGqUBFJ74mTX7jfGCwPVBmoj+3MTINnfy7ED6SyAcJWgdteEduqhVvLRGjDcmtwQ4zltF9ll7rw5Jf9CItb8chnNKG4fTnqyuJ9JdsiQY7VC89l3L1rRVNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61D41F000E9;
	Wed,  5 Aug 2026 15:55:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: inux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com
Subject: [PATCH v4 06/11] cxl/pci: Add the PMUs after configuring events
Date: Wed,  5 Aug 2026 08:54:56 -0700
Message-ID: <20260805155501.1294472-7-dave.jiang@intel.com>
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

cxl_pci_probe() adds the CPMU instances before configuring the event
interrupts. Both take an MSI/MSI-X vector the device names in its own
capability registers, and the spec lets a device point several capabilities
at one message number, so the two can collide.

They do not fail the same way. A failed devm_cxl_pmu_add() only breaks out
of the loop, while a failed cxl_event_config() aborts probe and the memory
device never appears. Going PMUs-first therefore lets a peripheral facility
take the vector and deny it to one that matters.

Configure events first, so a collision costs the PMU rather than the
memdev. Return 0 explicitly afterwards, since rc still holds any PMU error
that cxl_event_config() used to overwrite on the way past.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- New patch, ahead of the PMU dropping IRQF_SHARED. Without this that
  change can turn a shared vector into a probe failure for the whole
  memdev rather than a missing PMU (sashiko-bot).
---
 drivers/cxl/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..975d32716762 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -894,6 +894,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "No CXL FWCTL setup\n");
 
+	rc = cxl_event_config(host_bridge, mds, irq_avail);
+	if (rc)
+		return rc;
+
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
 	if (pmu_count < 0)
 		return pmu_count;
@@ -920,13 +924,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		}
 	}
 
-	rc = cxl_event_config(host_bridge, mds, irq_avail);
-	if (rc)
-		return rc;
-
 	pci_save_state(pdev);
 
-	return rc;
+	/* A missing PMU is not fatal, the memdev is still usable */
+	return 0;
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
-- 
2.54.0


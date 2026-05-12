Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2A385D76;
	Tue, 12 May 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629183; cv=none; b=YS+x6KwvDDREOW53sOpPsv+HGORQwPxMTfBvH8WBhXBy7QsWk6Th9gDcnKC9SZUQzryaFm80zYnRopdod30qklGKCw0YgDiXED4jhgmxSQEHXPbK8siNoNPlSR5BCeg1TBz7rk1xlLB6jAy/7RERs6xWkKISwaiU+DIOqw3T2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629183; c=relaxed/simple;
	bh=Uh78jhupvmAjblcnhk6BuHPWXf1ZefV1rjPJeUC7A5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDkcBnpOgU4ZIhqkMpNKRhpdyGeW+ZLQOss/HfF1iC/pTT/m/1P3O9r04XOMQ5oFGPaBm8VzsE1WhqBMpt6HLW3RpvlB56EBFPtyct8EsoI7DxwkOviVPvkhjr4S3YWhW9Sns0Iwu8oNPr464E2JOhZKLm638izf5hdGKtAhI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSmur+2Z; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSmur+2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778629181; x=1810165181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uh78jhupvmAjblcnhk6BuHPWXf1ZefV1rjPJeUC7A5M=;
  b=VSmur+2ZHdjP4ahvIia50cw8rItLcgm9akT8UZBNLNyFmfZZzvncbTRy
   Y21/NntgwS0ZeraO12nNy0NosaAybwhXfxKhAiWuw3VodtM6MV7qzVjPS
   87yOJjPhiddqEkaGIqaYS2EHgMIvAsGJhAIONy/DpeXBwzmOWwFsPGJyZ
   uFsoeDwy/HMfxTXLj8cuPV5CGWwXAcinf9BvXiVGoWFl/yeV7PyQkWnza
   4EYBtPRT/F0lgoczpc50InBqmolE7NSpuXXyd7n3vkwGbVyIPRzxw1NuS
   OzXGdExevmDpPgtDNBjfDBQesFXSZiY6Qh5AAAnq4DP7Z06ZNOGsp5T4I
   Q==;
X-CSE-ConnectionGUID: Cr0movvtQYyESinYOWFxRw==
X-CSE-MsgGUID: 6SJ6dIemR1G5HW/BH43SXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="105008887"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="105008887"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
X-CSE-ConnectionGUID: lelIqNLqRP6wMjjiawDtnQ==
X-CSE-MsgGUID: QN5atMd9TU2WqQjZb3Y0vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242271294"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 16:39:37 -0700
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH 4/7] perf/x86/intel/uncore: Factor out box setup code
Date: Tue, 12 May 2026 16:30:45 -0700
Message-ID: <20260512233048.9577-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512233048.9577-1-zide.chen@intel.com>
References: <20260512233048.9577-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI uncore PMU path already implements a lazy registration model:
the PMU is registered when the first active box appears and
unregistered when the last active box is removed.

Factor this registration management into a shared helper, so the same
code can be reused by the MSR and MMIO paths in later changes.

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c | 39 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 8d5170788af2..00ed4e5047ac 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1148,6 +1148,29 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
 	return pmu;
 }
 
+static int uncore_box_setup(struct intel_uncore_pmu *pmu,
+			    struct intel_uncore_box *box)
+{
+	int dies, ret;
+
+	/* die_refcnt tracks online dies, not only functioning boxes. */
+	dies = atomic_inc_return(&pmu->die_refcnt);
+	uncore_box_init(box);
+
+	/* First active box registers the pmu. */
+	if (dies > 1)
+		return 0;
+
+	ret = uncore_pmu_register(pmu);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	uncore_box_exit(box);
+	return ret;
+}
+
 /*
  * Register the PMU for a PCI device
  * @pdev: The PCI device.
@@ -1173,19 +1196,13 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	box->dieid = die;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
-	uncore_box_init(box);
 
-	pmu->boxes[die] = box;
-	if (atomic_inc_return(&pmu->die_refcnt) > 1)
-		return 0;
-
-	/* First active box registers the pmu */
-	ret = uncore_pmu_register(pmu);
-	if (ret) {
-		pmu->boxes[die] = NULL;
-		uncore_box_exit(box);
+	ret = uncore_box_setup(pmu, box);
+	if (!ret)
+		pmu->boxes[die] = box;
+	else
 		kfree(box);
-	}
+
 	return ret;
 }
 
-- 
2.54.0


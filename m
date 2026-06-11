Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE441C31D;
	Thu, 11 Jun 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194181; cv=none; b=gvIT6bEcSDEe3AF20F/rMTNp75ri5UHrj1y6Ae1tkO6yW6EgWVHPJr+ateS3bVi8JLxYxCCfkz1IpUJLQM/0Gd9UHr3ojDU3HUA8plms7QfRZyhDlcu5PDzCZ87Mecqvoc6Mh5UuA8bBG5x4ncyLVIwBbOfiK+fQ1IF99HX12Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194181; c=relaxed/simple;
	bh=on08egIOAIUyCSOrqKSgoOplMCXk0tbeTuaN1e++TjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwEosx4qn/IS5pjC4fnqo6JkEyPcCOW7v2AP6TNvxHb7jq8x6DRnLZkWsB5AeobFfbamoQATEXz5SOVJlWMubTyIG47b4IHHM1Mn8sZuL9Cl70RspgQCpNCrx7kuzNxWCetfVnciUKntJjteV2KcyDNtsW6n6sUdI1gLPRRXAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe4lcpnS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe4lcpnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194180; x=1812730180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=on08egIOAIUyCSOrqKSgoOplMCXk0tbeTuaN1e++TjA=;
  b=Fe4lcpnSlhwligsYmkjQjzpDHhpL0cksRppjbZbtfDrdWQMKhpEpZxC+
   G6xUgI1UYsFpwCbdOk7PhSpaucBieAHX2bFtOEbuyvIepsdDsYBpEUYx6
   F9SyeXoGD7Vm2e4vDrcuIIZ+yAywvj+ZVh9QheHbXYRdmW4oJSrTUYy4W
   wN6aJhZMVBqrd1F7Ncg3DwsicS5EevNS7D0KRAonrBt4GNHENfEgvxxhG
   +h90NsXY05u7pP7apF9TLkHlrJy75oZ3MFQGzd1sbf5Ka2Y87MV2rbCi/
   BHc8ofc3Qnr9xbiGx3Acjkqs94j5DD9fraKWN9zntqiKBpDW7MfEFUHmW
   Q==;
X-CSE-ConnectionGUID: eMGIE1obQGem0ryMkfMoXg==
X-CSE-MsgGUID: 2JkGXLJGQy6xeYJ03pRyMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81994984"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81994984"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
X-CSE-ConnectionGUID: NBWOECADRSy3h2yTKolROw==
X-CSE-MsgGUID: 1A3tmy05SAiautpBduHF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246403601"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
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
Subject: [PATCH V3 5/8] perf/x86/intel/uncore: Factor out box setup code
Date: Thu, 11 Jun 2026 09:00:30 -0700
Message-ID: <20260611160033.66760-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611160033.66760-1-zide.chen@intel.com>
References: <20260611160033.66760-1-zide.chen@intel.com>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3: Add Reviewed-by tag.
---
 arch/x86/events/intel/uncore.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index eae335df7634..06ef89f6ccc2 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1148,6 +1148,29 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
 	return pmu;
 }
 
+static int uncore_box_setup(struct intel_uncore_pmu *pmu,
+			    struct intel_uncore_box *box)
+{
+	int ret;
+
+	uncore_box_init(box);
+
+	/* First active box registers the pmu. */
+	if (atomic_inc_return(&pmu->activeboxes) > 1)
+		return 0;
+
+	ret = uncore_pmu_register(pmu);
+	if (ret) {
+		atomic_dec(&pmu->activeboxes);
+		goto err;
+	}
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
@@ -1174,20 +1197,13 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	box->dieid = die;
 	box->pci_dev = pdev;
 	box->pmu = pmu;
-	uncore_box_init(box);
 
-	pmu->boxes[die] = box;
-	if (atomic_inc_return(&pmu->activeboxes) > 1)
-		return 0;
-
-	/* First active box registers the pmu */
-	ret = uncore_pmu_register(pmu);
-	if (ret) {
-		atomic_dec(&pmu->activeboxes);
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


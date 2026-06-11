Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A37409636;
	Thu, 11 Jun 2026 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194178; cv=none; b=dH5NroU9/lwlKYxKP6XorOcCQ0m9MAd4/eXpCiBdqgCOx7thscPORbO9H/eeyKK5J3jB4GoZL8ZJhHlbDDGcsnbYOKW+yN3iojNDsKfdDQLfiwnsDn3wbaETr2uH2Mg3DnJd70z48ex5vHzyTSuDFxpiUAHd1KqxNFWMScnzlos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194178; c=relaxed/simple;
	bh=Krnalm3gofcxrYqeJe2mgn6O2TBD/liaqN+jY92+f/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz7RoEoiawD1OzpBU0DRSoO6UcLGp5vGdkOiJeGF8piKCE7yjpIqNlHOYSSuNrZw6AGHiZcZHl70g+ThWpr5VSpZW5g68gU1ob1cqxwRDoMvuFV7j13Bf+BuG5w/lxRSkNh/51mf2R3J4YwZEvjbnLzjmBf89NM/lYrp1JuByLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI23TyLx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI23TyLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781194177; x=1812730177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Krnalm3gofcxrYqeJe2mgn6O2TBD/liaqN+jY92+f/k=;
  b=OI23TyLx0t0CKF00aODzGlfMZvx3xmefd0//JVdVGTTwDtHGhBDgYGnA
   xvJZrG3I/YY85snwpp8W6m3h+O2YQqI+Txd4L5vtfl4cql3jcAVKFv439
   LGNGCPWNDzSEjo2FYkUzuAUVaAJ0pFTKSh90f3kSCuV6h1rGdEJS4xMwz
   ZMpd3w2nSShBYadXf9yKFlGI/MZcb7PWavCvmmEDtq7AlclFUrXnZWjkm
   Lpio2YfTV31BYT647GvQJDwt9TtH8A6xUUerX56qcuIqJ/WtlHkURjRNh
   QxmpiebJDfFy9hnGsN7OPrUPnVq3YCyYaJKzzytmYXRKJViRTEs8y2yf9
   w==;
X-CSE-ConnectionGUID: D3nCQUq2SYuSSCugrRgoQA==
X-CSE-MsgGUID: vEXftG2xTfuBi6tfxjxsQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81994962"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81994962"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:09:36 -0700
X-CSE-ConnectionGUID: WGKOPhP1STKcxMttKWCgjQ==
X-CSE-MsgGUID: QSSquFLhRneHtbh5MudJog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246403589"
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
Subject: [PATCH V3 1/8] perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure
Date: Thu, 11 Jun 2026 09:00:26 -0700
Message-ID: <20260611160033.66760-2-zide.chen@intel.com>
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

When uncore_pci_pmu_register() fails, pmu->boxes[die] is set to NULL
before returning.  In the uncore_pci_remove() path, this causes
uncore_pci_pmu_unregister() to be skipped entirely, leaking
pmu->activeboxes.  In the uncore_bus_notify() path,
uncore_pci_pmu_unregister() may still be called and must exit early
when pmu->boxes[die] is NULL to avoid a NULL pointer dereference, and
to ensure activeboxes is only decremented for a previously active box.

Additionally, since pci_get_drvdata() returns NULL on registration
failure, uncore_pci_remove() can no longer treat NULL drvdata as an
indicator of an auxiliary PCI device.  Remove the associated
WARN_ON_ONCE().

Link: https://sashiko.dev/#/patchset/20260512233048.9577-1-zide.chen@intel.com?part=1
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3: Add Reviewed-by tag.
v2: New patch.
---
 arch/x86/events/intel/uncore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7857959c6e82..b69b6a21d46b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1183,6 +1183,7 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	/* First active box registers the pmu */
 	ret = uncore_pmu_register(pmu);
 	if (ret) {
+		atomic_dec(&pmu->activeboxes);
 		pmu->boxes[die] = NULL;
 		uncore_box_exit(box);
 		kfree(box);
@@ -1248,6 +1249,9 @@ static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
 {
 	struct intel_uncore_box *box = pmu->boxes[die];
 
+	if (!box)
+		return;
+
 	pmu->boxes[die] = NULL;
 	if (atomic_dec_return(&pmu->activeboxes) == 0)
 		uncore_pmu_unregister(pmu);
@@ -1272,7 +1276,6 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 				break;
 			}
 		}
-		WARN_ON_ONCE(i >= UNCORE_EXTRA_PCI_DEV_MAX);
 		return;
 	}
 
-- 
2.54.0


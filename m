Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293353DD509;
	Mon,  1 Jun 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333810; cv=none; b=ZgUumfwewF8h91GU2fqgY9AyIbxi0XI6LwMbdNTQTOGFQ3OsN8CNH/b2HWDV37BXZcWM4BOAlazsvFDpAAz1joJFCt7tAoi4jdWH9skV4Fgbw2lUEr20j1d566Hp05e6XvARM/n3YyampFj7vV+1O2s677NZHQ8q/AVTIygDbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333810; c=relaxed/simple;
	bh=ccNqajT2vmkif2k63dKCM1as1mgTnfGG7rmjgdDJSUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etJEhg0SncfAVRmbYnM2M2qU1RBiwWAM5HU76Ibk1RmGcNVW0em2LlsjApYmKNEG5kZ1FMaEA51I52ckgVX8mFDtfAzPD5oGyEz3UjhvAWVyROr7kfg4IL1qobp+C+aOj6QR6KUpJ+x/56dr7w2zIXCTyuvXRoCrbkodEK67tKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOTnJVha; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOTnJVha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333810; x=1811869810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccNqajT2vmkif2k63dKCM1as1mgTnfGG7rmjgdDJSUM=;
  b=QOTnJVhaB0+gglGM/9zZzHCU/dU0mLIWgqhKuyXU1EwjWpdhhSkv+4AJ
   /lkgpS0ES0HF1gVuDlfFi4AQfB84EaEAaXu7FjH4qy5FGClytRUW1LnpQ
   3SCwie+I5Npj0Hmo12AFnIxEAGG16iOb5rdR5XHCk41d0XfhBLSnci/kM
   +rR87GOcw1ro/ghc+58QLFC38O3/KCnUvkYFmoI5OazRoSGW0Fe2Zzusz
   kDktQhx3rXdhHWXcjvpkBZCsLvYS/1GgjvffX9vlhvxt1vEwziuYGuC/i
   lkpxiRy9Ms8FgoPXzceKeoJRD+ZmZ39euvWpyNXkcxql56oRiMASryskK
   A==;
X-CSE-ConnectionGUID: iKOTgsmmQQWeQxyBFrWYoA==
X-CSE-MsgGUID: ed4uSLLCQaKj2HZnBHzxQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98516999"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98516999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:07 -0700
X-CSE-ConnectionGUID: TdwAkYSgSbKQrg3y0idZ4A==
X-CSE-MsgGUID: TEZxcyYoTjGQ2A0leM29hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242585010"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:05 -0700
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
Subject: [PATCH V2 5/8] perf/x86/intel/uncore: Factor out box setup code
Date: Mon,  1 Jun 2026 10:01:11 -0700
Message-ID: <20260601170114.173359-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601170114.173359-1-zide.chen@intel.com>
References: <20260601170114.173359-1-zide.chen@intel.com>
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
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6df44f69cc5b..283e41933ba7 100644
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
@@ -1173,20 +1196,13 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
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


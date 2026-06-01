Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2893DC4C9;
	Mon,  1 Jun 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333809; cv=none; b=F3CbaJ/TQEur5xxF21R0gzwiEl4q9OdU6K2WtYqflBg1CAjGqQZAiFmjo+qSG9SsbBh0bHo4Vyv28mvpPoZpBety0Yc1E1TSOgZr1nTGC3et/B0sbFRe6np4Fj9SLafi88ia6jwE37BFsel3Y6GMZ3rTGnxc0ZmJWU6FjFGdaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333809; c=relaxed/simple;
	bh=Vz5wRenO9oLtDKGOqzT06Br1hg84C+tO+WUk+mLl+sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIPHI2HkKmC6NlupIoLutY9sNaHw4nczGxE2lbFMKKm5nh8uQQurk8LV6ENyFKx7hKjY175+UmGiDR9FnzAZVbzEzk4YfEjiGLE8y6NVEAcStEOSENuJ0wXHwdzpMJiXbtIYsUFFOzLR3/EIfunj9uCaba4mygrplpmJ/6t0baU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQhtJZwZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQhtJZwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780333808; x=1811869808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vz5wRenO9oLtDKGOqzT06Br1hg84C+tO+WUk+mLl+sY=;
  b=DQhtJZwZ+mkG48eVZUvCJoG6BjBpSB6bZ2/EOxCHisGH4vrb9fr8gB44
   MJmcmmxclp5zjd+6r4t4XP6rxfuveBdCpBYJykLirlvo4domyZEtp+8J+
   fWfwIGNxIueADhr6AeQtzfxRSJ3h262KJ4NC+jByyic6M5c9sIeGYpzHG
   JRyi0XyQCpIu2pUrWscnKtmLmBr/Yj1FzI205s7c7hvIa2qq4EaTgkx6i
   ChpXNGD92NYekDFzRiTvGxIHNW/7ztweaIHGD28hoELqm9+brj4mNrUD2
   IicrCt45BRXHR5kGdQtZZzRO5ezBPdjpB4JkdgSBBkzr0qUVdLkaZ8l2B
   w==;
X-CSE-ConnectionGUID: 6hqO/M+7RsSO2N1IMwomng==
X-CSE-MsgGUID: hL8zspENTD6yo03cil+UVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98516973"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98516973"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:10:06 -0700
X-CSE-ConnectionGUID: e2fBIgZwSEajAjYy/GJYUQ==
X-CSE-MsgGUID: NpneE18JQxm8u7i4aT7H3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242584998"
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
Subject: [PATCH V2 1/8] perf/x86/intel/uncore: Fix PCI PMU cleanup on setup failure
Date: Mon,  1 Jun 2026 10:01:07 -0700
Message-ID: <20260601170114.173359-2-zide.chen@intel.com>
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
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2: new patch.
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


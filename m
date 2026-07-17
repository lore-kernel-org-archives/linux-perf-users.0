Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D13E00B6;
	Fri, 17 Jul 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275802; cv=none; b=JMjPAFh81JWZ1sM8oPkp/7vb7pyU80SxgBzEGdEK+YeNpIIOZz/75A1o3E8nuASJ5RXcZCBSFBu3HhC90UULqRGfCtz0uVm1bMgi3oRMsXj8IEwkdO6A8n0N3xRwVFLUINMXX5ieA+0llrof178j6Q+sDBMCp8KO9wfmm8xhkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275802; c=relaxed/simple;
	bh=yX9+N+DdmDF1QDMBR4DN+rdXvBk3lsq7f9U47rRl8zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2MwgK+UCnv+hBCcjMwrG/phWvZ9omxjMa7nnLQWtGJg6BO7uozwkB+OAfANkdx+GmsxEE+bUY+1v1b1JkeObf+rJvsJQVMKyp0OIuyjE9KkG9IECF0Heni6ZvK+PG311Q1SCIdamEmPvaGBNq0h9Y1oLDiHrUxFSj85DCEee9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFpkymy0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFpkymy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275801; x=1815811801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yX9+N+DdmDF1QDMBR4DN+rdXvBk3lsq7f9U47rRl8zs=;
  b=ZFpkymy0JJOLFKu5EjY6NoBHp2UOYN19f87+ztQBtR52dJXbZiox8ups
   37U+UXFgkVCAh048RAXBBXyKlRxRtiNLEqY8daTPcOAgiFRgZ3CPJOMsB
   lJaKUU8oR6Hh2BTwCHyRktDP9/fj+ffaFTMEkzA+dHCdOtfOSrdAm0xP2
   GbWQnMlG3PmK1qeYyANc+j0Dn99qHUU5HzFFrR3/6E4ZaO0Eu3mlQdKsX
   aq/J2fR19EXj6BQe0+xsrGCznflPRk6T+RkgSwhyBMWcH+4XcERRaW2vz
   3j8N8uFQ0eyyyzagbc/eWgj+2kBVrumPj9n71qHx+qdhMgF4bJRAm6qCM
   A==;
X-CSE-ConnectionGUID: N5Ia80XMS+q0g/DXixY8PQ==
X-CSE-MsgGUID: EZOKIMPVQ3emB/aeifUW4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065498"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065498"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:01 -0700
X-CSE-ConnectionGUID: fZMHA9qcTuWxycg80T86PQ==
X-CSE-MsgGUID: pjo3KI1xSZ6wLbQRRAdeGA==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315456"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:09:57 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 2/8] perf/x86: Free hybrid state on PMU init failure
Date: Fri, 17 Jul 2026 16:03:36 +0800
Message-Id: <20260717080342.1879573-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If PMU initialization fails, for example in check_hw_exists(), hybrid
state can be left partially initialized: x86_pmu.hybrid_pmu is not freed
and perf_is_hybrid remains set. This can leak memory and leave stale
hybrid state reachable after a failed init path.

Add x86_pmu_free_hybrid() and use it on PMU init failure paths so all
hybrid-related state is consistently reset.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 872d07a5fa80..6c63b27e11e6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2130,6 +2130,17 @@ void x86_pmu_show_pmu_cap(struct pmu *pmu)
 	pr_info("... global_ctrl mask:          %016llx\n", hybrid(pmu, intel_ctrl));
 }
 
+static void x86_pmu_free_hybrid(void)
+{
+	if (!x86_pmu.hybrid_pmu)
+		return;
+
+	static_branch_disable(&perf_is_hybrid);
+	kfree(x86_pmu.hybrid_pmu);
+	x86_pmu.hybrid_pmu = NULL;
+	x86_pmu.num_hybrid_pmus = 0;
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2258,9 +2269,6 @@ static int __init init_hw_perf_events(void)
 			for (j = 0; j < i; j++)
 				perf_pmu_unregister(&x86_pmu.hybrid_pmu[j].pmu);
 			pr_warn("Failed to register hybrid PMUs\n");
-			kfree(x86_pmu.hybrid_pmu);
-			x86_pmu.hybrid_pmu = NULL;
-			x86_pmu.num_hybrid_pmus = 0;
 			goto out2;
 		}
 	}
@@ -2276,6 +2284,7 @@ static int __init init_hw_perf_events(void)
 pmi_unregister:
 	unregister_nmi_handler(NMI_LOCAL, "PMI");
 out_bad_pmu:
+	x86_pmu_free_hybrid();
 	memset(&x86_pmu, 0, sizeof(x86_pmu));
 	return err;
 }
-- 
2.34.1


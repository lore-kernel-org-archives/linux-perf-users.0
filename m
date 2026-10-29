Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249258;
	b=lFf6HU5JBVafe5ed34EHadAfW7GjNF28aFRbR4gX4i967KiwM2jFCFKgo8mMhGIoGsnd
	 uG36pWYS/T0AFBk8YUokQ7NdMT+oR6KX4O/Rw+JiiAUrga5kcTMOx146K/HSNt6Ph92+A
	 Oscgi6mVBljUCN62yROHuYPK0u+brY7Jfec37WTFoYvPnj72NJMQkelHXqbbu91GizGA1
	 ahExOJWQmxaD2ymI/RbTymPYZfiWE9cRWIGPc9zTBJxPpujSgt26e5NLS5vAx4CqmhkBZ
	 dF6faP+99AkK56qZuHGFEWFUX/u+Q/IL6yKuCC7oNntQqNt2zJo67yzvpeXk3hTsLNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249258;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7H517ih2QKkF65P2g05OYpwiyOXcBEcIDC4a2KxLCvI=;
	b=Ofz1UaLd4esPWHe6BYgLfZ97rL4N+nspwZURpaA3h9fDXDkwArSC+gvhIRRytUEW7FAj
	 t1A8XiyT/6AQyqn2cesqigreqrqtl4kwhGkugyKfqKr9R1jeKqCl6L+/m6HQ5JH+R6yY7
	 HYMtNxyLRu2N0+hJ1rYZHKZGn6eLAJ5Yug00NNpYJspst9MXKU2xd1ZUwKiWIqI79DVE/
	 XolmHEtP1ZJmYoi8Z73LoVmJGBvZ6Sn/0GDntzuuK+n36jLXpKIIg55krGwCni3oAx3GB
	 Af70khcmycw7KzAwhFNjPAWsSA9fY/NLpcfbjOMNMUMUM9hw2DFl+Zi/QuAXWMuJV5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HkkPt4Hi;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADB606A330;
	Thu, 29 Oct 2026 04:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71ADB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HkkPt4Hi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249259; x=1824785259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYJ8o+l9Yq+fKQczZRVZDecUhMCewR5u7c8v0y4dmyI=;
  b=HkkPt4HiqXIJ0PE73lC8g4uQd3lTUo4QklrfsllkruVk87n7xSO2FDVl
   NB54nUwe+orBjKtyYBY+LIte69A7AvHrEDMBUuaDF1fKtJvMN3PIubgdQ
   TtzkdOY8deaYuyIWcf5NbF6tFXi/zJBt2N+i+gWr43JaflbLFaRCQawpS
   bffhp+zb2K1QadYBkV06X67CUfEr30eKRZ4l8HVzsnpRYJ8+PxP2TuXe1
   T/XenVrPfEnkig6ZL+7VfcbrEfAufsZ7zu/8572Gzb9IZG3tKuRnkjJ3n
   Wi1BOBWk3o8umiHin8mEshgV/tkj6qk1U1D+W24rc28nEHEUwj4OQNsgD
   g==;
X-CSE-ConnectionGUID: SDKiNKE6RtaRMtg+vpTpSw==
X-CSE-MsgGUID: dAj5Q1nOTHCOCwndBIrJmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986314"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986314"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:38 -0700
X-CSE-ConnectionGUID: ZuOxzOF2TjaNA75bNS5ETQ==
X-CSE-MsgGUID: A0I/KKMdSMaZ09ieTOU0wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420516"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:34 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 12/18] perf/x86/intel: Always snapshot live hardware LBR state for BPF
Date: Thu, 29 Oct 2026 12:39:08 +0800
Message-Id: <20261029043914.1395147-13-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__intel_pmu_snapshot_branch_stack() is intended to capture the current
live hardware LBR state for the BPF path. However, that snapshot is
currently skipped when all LBR users are PEBS events.

BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
no longer a risk of clobbering the shared default LBR stack. As a
result, always snapshot the live hardware LBR state for the BPF path.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 10 ++++++++--
 arch/x86/events/intel/lbr.c  |  9 ---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 482a148916bf..110fff65bd50 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4069,8 +4069,14 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
-	intel_pmu_lbr_read(&cpuc->lbr_stack,
-			   cpuc->lbr_entries, cpuc->lbr_counters);
+	/*
+	 * No need to read the LBR stack when all LBR users are PEBS events,
+	 * since the PEBS handler updates it.
+	 */
+	if (cpuc->lbr_users != cpuc->lbr_pebs_users) {
+		intel_pmu_lbr_read(&cpuc->lbr_stack,
+				   cpuc->lbr_entries, cpuc->lbr_counters);
+	}
 
 	/*
 	 * Do not clear the LBR frozen status here; keep LBR frozen
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 63f0504f9d2a..790580f96040 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1050,15 +1050,6 @@ void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
 		return;
 	}
 
-	/*
-	 * Don't read when all LBRs users are using adaptive PEBS.
-	 *
-	 * This could be smarter and actually check the event,
-	 * but this simple approach seems to work for now.
-	 */
-	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
-		return;
-
 	x86_pmu.lbr_read(cpuc, lbr_stack, lbr_entries);
 
 	intel_pmu_lbr_filter(cpuc, lbr_stack, lbr_entries, lbr_counters);
-- 
2.34.1


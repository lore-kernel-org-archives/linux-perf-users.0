Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249220;
	b=k+ZqEO9N2jKaXo9c3luay1bs9kWUIyGJrzbcPPKtEoO4XLtNzla8KhzYbe9tbEwKJfZY
	 lOajOkPm7KE++YHFKMf91S4tsWBcKGzZPKyfqGOHWD/10GjlG6VrPk7NwZjhbYqbs160d
	 iLSNTjE20QSKoofvpvtAlmeTbBQFM6saHmDV/eJ8H13uZ0gVirrZMJpExNGNcMIumwBqk
	 Ve5m1meFmCQdWulfRAj6ayEb2fuX/CZyL4zdiatBAfdnA0jl0l3B17ULYy33OiqF9zQnw
	 G4ySKtny4lJA7MhHFDUuLZm5ttIs6iEa20K/NRVfFtdJ6q/38MiX18Lrf1hCKah7nuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249220;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4cks0gT066dDiYYpLlQjfNBoBy1m1RhIOfEaeQCMfjQ=;
	b=isXCiHYERf9zgt9NXbOhvfHuzQmxZMgkkxpOfo+HibUd/qG2uZ1RAYysIr/v1/0nqLHg
	 2ngWUjVu8SNzp7/sqN3Zxi40R5ZRuMXe2SxYJ4TmcdFROzKP2293lpiJjmwu28yhrVpou
	 tsN5yJThPJA+Pivuwm+ir1Vb5NFyWNRS0j3DAmIc06/4UsV7+hQG4TC0CddBaVx9y55hQ
	 ygv5APyq+/Kp0ixqcp9bKTorVWjr9sR/D1mGlequACpaNPXDspwUxCHcrI7B4GHfCS+bg
	 8ET6xJSm3PP5PIcANRRxAXVFBd//ksCkAP4srg7J1huTIPAxS7h5ARIZmIL7dWa1PGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FqPaEmax;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA907606A31C;
	Thu, 29 Oct 2026 04:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA907606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FqPaEmax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249220; x=1824785220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+0hIINLpeugcPvI770gmUmx9DDQYrcYVy8/XA8KedE=;
  b=FqPaEmaxJBbsyhOwNR5lo+LbYykqGEmNVeJy86mAhgqHarts5UvxJFI+
   Lex8ECA47UxRuj5RnxHugQO07qVt/OLcduOKUCUkOR7MFkD1gk9mDFhzd
   S1ktWOLM5+pHlwC22eptONLunP2MDRq+5KfzWSxzkpZUOYOV0AFRIIqZL
   n6L6gsblMHNC3ENGTxaPHcbUUru8N8WF06CVzxlx4BvikKqv1d0BeiPKa
   AQ4AM8/m7w36rnUtVf3R5FaAkABZWsBTjYJJG4LMsrq9UFtW0ziONzEr8
   gzcgc7NBSIBew2XK/xZK805lTB8PRJdkm7aKY2oineoCLfEUOTIIY/Tfm
   w==;
X-CSE-ConnectionGUID: oqfh3lp3S/eVugHOQRQxvA==
X-CSE-MsgGUID: R+rFvqKPSm2wjAh+dawZEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986262"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986262"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:00 -0700
X-CSE-ConnectionGUID: gglATrSIT/K8g/nMoN2rLw==
X-CSE-MsgGUID: dQ6YtSaJSNercFsc023agw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420329"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:46:55 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v5 04/18] perf/x86/intel/lbr: Limit branch snapshots to valid entries
Date: Thu, 29 Oct 2026 12:39:00 +0800
Message-Id: <20261029043914.1395147-5-dapeng1.mi@linux.intel.com>
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

The branch snapshot callback used by bpf_get_branch_snapshot() always
copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
last LBR read kept fewer branches. The entries past lbr_stack.nr hold
invalid branches which end up reaching BPF programs.

Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
no active LBR events or LBR hardware is owned by guest. So the stale or
guest LBR stack data can't be leaked.

For the case where all LBR events are PEBS events, hardware LBR reads are
currently skipped; that can leave stale LBR stack data from previous PEBS
sampling in place and may be inconsistent with the intended semantics of
bpf_get_branch_snapshot(). This will be addressed in a follow-up patch.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/lbr.c  | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 10c694db85ea..18cae4ac32b6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	intel_pmu_lbr_read();
-	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 	intel_pmu_enable_all(0);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index a2e4ba7e1a4f..1ae853f7ac1a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1027,14 +1027,19 @@ void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (!cpuc->lbr_users || vlbr_exclude_host()) {
+		/* Reset lbr_stack.nr to prevent stale data leakage. */
+		cpuc->lbr_stack.nr = 0;
+		return;
+	}
+
 	/*
 	 * Don't read when all LBRs users are using adaptive PEBS.
 	 *
 	 * This could be smarter and actually check the event,
 	 * but this simple approach seems to work for now.
 	 */
-	if (!cpuc->lbr_users || vlbr_exclude_host() ||
-	    cpuc->lbr_users == cpuc->lbr_pebs_users)
+	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
 	x86_pmu.lbr_read(cpuc);
-- 
2.34.1


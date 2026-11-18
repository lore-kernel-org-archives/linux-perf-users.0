Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972217;
	b=Vrg2zUYWbv1Nn3ZwBXB6ZRQ8KT9KDsn0P/Vg4E06st48Ki1mW9YBUinGOcSOil2+sEsv
	 OYT6GobRQdzwZRYK6g633u10y3AbCoB9iKKBES96BFMFNCGbJ/RJFyMrasl+IYzoR4V2j
	 eyif6gAnRHr1d0JMMPqQMF1IR62u3qycA5OPrhlUpNd//VE3nuGatAQG23QeIw6qbePt1
	 Roi0+eN1Hyl1xEy1O+ZDJvNHbW7v1C3zwv8VI6ui0n8HBTcNg5yw/rJVgmPtKAoVu5n0G
	 KX5mXtfTFZyA9kSEmAhIWddZDDH29wSE7G4hfMSRz0Epk7TxLiCrcTEPjchSKr9lHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972217;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sJsHqtrUaXruhK3/z6thEf7S2D69ICDgs8vrT7ZLEa0=;
	b=IrOwuIH0Wk0N6TkBvyYqLvIFAxb4ncrwbbo6Oo38Wm05/wwPhh0cf92P3jAqSwez4jZR
	 9ipDuEPpHSIeR7c7/pt2dTZqu+aEzRnWWwTbTK4VIe3IPCgN+EEQ+J+FImCnAHymmrBp/
	 TtZM/Tj8QsJsb1KTwjHfUjg4t9pYPKD3czQqt5jFOU5ezzbEPf66qMp0czLYSeMR98nm8
	 nqw0pVaTNlbXOIXTpRbJauDUl6/XMf6E8+xCa9/z6MdTKdTRE8Pos7B8lDrkjBIQPep3x
	 NWnevxPECvmGZjikqqhk1P4Vk66tNONn1PoSncojV1c8dhUN4tZ0fzFgJ3W3ba+WAog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hKn7gTM8;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FE606A33E;
	Wed, 18 Nov 2026 03:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364FE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hKn7gTM8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972218; x=1826508218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WAyJKBJ2Sy5VUrXkMvmcDuzshiw8JtUcChTHgZ7LJDM=;
  b=hKn7gTM8i8q1negj6Rgc8onn5sfp9KB/kLGOUpZDwMvlsV9ed54OurzP
   q61o8LdyRJm7mRjIrtR9jL/fdZdkgOT3sNgASxtyRbBXwbkKWyrZc/0xI
   pYKhf49+3oEC2o1miVMXjraJl6xnY2QCVf2F8QU/s4GebvlSIHWt0JaL2
   WFaNvxN8z/3Qj9zlxjCVMLroPYlVqIMkZZXs0JcnAIZ67VgBSps/ezlK3
   GfoAW3nVPPz3CU6vaTF2dtEj8UIVwkRzXwzltu3Z3ZPyYB4NxrXl9Eh52
   tc9tpbY0OV5DZ95nuD9elRWMEBrVHBZLkvTzHruRbOEUTpa9U9BOVKhXO
   Q==;
X-CSE-ConnectionGUID: C86LmAq6R2+mCzfEEBRvGg==
X-CSE-MsgGUID: CZ5vKW3mQaCsg9N0oin86Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629871"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629871"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:18 -0800
X-CSE-ConnectionGUID: RZTkrb4OTjG5trdtg/gw8Q==
X-CSE-MsgGUID: r6kYUrtuRma+zgs9Ff8o6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894178"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:13 -0800
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
Subject: [Patch v7 06/24] perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
Date: Wed, 18 Nov 2026 11:14:35 +0800
Message-Id: <20261118031453.1353625-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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

amd_pmu_v2_snapshot_branch_stack() currently re-enables the PMU and LBR
unconditionally even when they were already disabled in PMI context.
This can cause events such as cycles and instructions to be counted
while the PMI handler is running, which is not intended.

Only restore the PMU and LBR on the BPF path if they were originally
enabled.

Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bf631f60757c..dd0e24f26c6b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -932,22 +932,31 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 {
 	struct cpu_hw_events *cpuc;
 	unsigned long flags;
+	int pmu_enabled;
+	int lbr_enabled;
 
 	/*
 	 * The sequence of steps to freeze LBR should be completely inlined
 	 * and contain no branches to minimize contamination of LBR snapshot
 	 */
 	local_irq_save(flags);
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	pmu_enabled = cpuc->enabled;
+	lbr_enabled = cpuc->lbr_enabled;
+	cpuc->enabled = 0;
 	amd_pmu_core_disable_all();
 	__amd_pmu_lbr_disable();
 
-	cpuc = this_cpu_ptr(&cpu_hw_events);
-
 	amd_pmu_lbr_read();
 	cnt = min(cnt, cpuc->lbr_stack.nr);
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 
-	amd_pmu_v2_enable_all(0);
+	if (pmu_enabled) {
+		cpuc->enabled = 1;
+		amd_pmu_core_enable_all();
+	}
+	if (lbr_enabled)
+		amd_pmu_lbr_enable_all();
 	local_irq_restore(flags);
 
 	return cnt;
-- 
2.34.1


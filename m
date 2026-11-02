Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793581609;
	b=XqyDOunGT2u12rWahaUygJiXzCoRos1PSXmpHjzTj2pNqzRXK4QX72ystSgIUA2o1IZm
	 bKrqwj+THD8lpFCYAZ6zINh66oUWEHAid8HGXkck+KH4dBBlhvwq8XH4ceU4kLDnhEL52
	 rs1c6sE1cE0+vqBxoBN9ytP8TxTVMSQruY1F10aSL50NKgsUjTLH1hSJCe2peVJXWL03n
	 5+aFNN/fXKj0N+oOXlTWax+gGMJbEcwywO96MdSWexBdE/Dz5/34yJY+EavGGpM8ZRls7
	 Jp15STQ4ocMb53bPUjw4671pKA4SFPg16RmXbFRh/yz5TVp8zovFhJD5SI1kd0/BxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793581609;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AUjSmHXfLT2gi8Fgm+ThC2mvbmf8MyE+898uzs3bVLU=;
	b=TbOAiryrYcV+OM0Wp4r1XVxZUfpmEYb31wEgjevtcnDRXLlRQjpJ7fpNwruAUvF0KOzJ
	 UQtGtybEu4KHTpCoMbzJtZu2yqxqmtC4IUl7EmvHjHVVCWmsFyX4Jf8Aj7tCKMCRUoCwY
	 qSkTGR8dcmPpyAYCvSXZ1v12eIa3rEJrI97T7ItgyAF1gKQV7ETwqJuOkOQuMcPFeqPOU
	 t2T8bkwDTfnqLBQigSkDmUj6Yn3UVyf5Q7Wgv2ZcOR3Dp567onUtGu+1U1pdbWrrb5jk9
	 ZIQ+Fa0n8HxE/IPOtf8w0tFYvGHDuvO1qrV7/PJOjDcRho7+zq9KeOciHulPlrfWYJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dHxf7xki;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50E606A324;
	Mon,  2 Nov 2026 01:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B50E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dHxf7xki
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793581609; x=1825117609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h3sGhMWylHDbWx7qk02bfTT/q2nZbBG2djgSRusnxIU=;
  b=dHxf7xki4YnvmwrC7+52ywOvtYyUsTMt8h9CNiR0bsF3jb9pimX42UPI
   bW+OdC2/zCPR0eqHsiXaQrdHLdV2n8R2cAWHM7uH2UKirA9KxEYyMmKNh
   EedNmq22SWBRZgGL0JinLdsqJqWlrlxnGNXfyWjMfNnezmAqjZvirtuCJ
   0uZuRzYP7QaE6im8uIa2RyYNq1TYsxVmuhhVak52GCnRxoJVTja6bmwRw
   JRvLsMYYIAkSvccWEnNtDVR5Sgd0gRkpH6AiIqpk0RnLg5u15DPpvlbxJ
   XWvyd6AwdHXi0k0Nsad72G92bZZ1i9xOD7LFeOk62Owr1NosPFIIoHwET
   w==;
X-CSE-ConnectionGUID: LD4ZkOczRMab19+NU983CQ==
X-CSE-MsgGUID: cYWQBxUuR5+j+iNttjL0HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2146009"
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="2146009"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 17:06:48 -0800
X-CSE-ConnectionGUID: HqnpdBkSSFSrHUIgBwiWPA==
X-CSE-MsgGUID: CF2iGjdbRGuudQLQT6T9mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="6106332"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa003.fm.intel.com with ESMTP; 01 Nov 2026 17:06:43 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Hanxiang Xu <xuhx@hust.edu.cn>
Subject: [PATCH 1/2] perf/core: Avoid NULL dereference in mux interval store
Date: Mon,  2 Nov 2026 08:59:04 +0800
Message-Id: <20261102005905.2017784-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

perf_pmu_register() currently exposes the PMU device and its attributes
before the per-CPU perf_cpu_pmu_context (cpc) has been allocated and
initialized. That allows a race where user space writes
perf_event_mux_interval_ms before cpc is ready, and
perf_event_mux_interval_ms_store() dereferences it unconditionally.

Fix this by allocating and initializing the per-CPU PMU context before
making the PMU attribute visible, and add a NULL check in
perf_event_mux_interval_ms_store() to avoid dereferencing a missing cpc.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Closes: https://lore.kernel.org/all/de936c3.1476b.1a162c34cec.Coremail.xuhx@hust.edu.cn/
Fixes: 62b856397927 ("perf: Add sysfs entry to adjust multiplexing interval per PMU")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 kernel/events/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7cdd02dba4f1..e088c31534bc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12831,6 +12831,9 @@ perf_event_mux_interval_ms_store(struct device *dev,
 	if (timer == pmu->hrtimer_interval_ms)
 		return count;
 
+	if (!pmu->cpu_pmu_context)
+		return -ENODEV;
+
 	mutex_lock(&mux_interval_mutex);
 	pmu->hrtimer_interval_ms = timer;
 
@@ -13062,12 +13065,6 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 	pmu->type = pmu_type.id;
 	atomic_set(&pmu->exclusive_cnt, 0);
 
-	if (pmu_bus_running && !pmu->dev) {
-		int ret = pmu_dev_alloc(pmu);
-		if (ret)
-			return ret;
-	}
-
 	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context *);
 	if (!pmu->cpu_pmu_context)
 		return -ENOMEM;
@@ -13086,6 +13083,12 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 		__perf_mux_hrtimer_init(cpc, cpu);
 	}
 
+	if (pmu_bus_running && !pmu->dev) {
+		int ret = pmu_dev_alloc(pmu);
+		if (ret)
+			return ret;
+	}
+
 	if (!pmu->start_txn) {
 		if (pmu->pmu_enable) {
 			/*
-- 
2.34.1


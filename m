Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972218;
	b=VPK+IYJZRPiAPc3Bri1DWclcvXC9MP+O7w0cNbQLYV6qTC57uYt68cgl6lZhuYdKeaeH
	 LXAG/4hSsTxjicwg3DFyBiq35f3dd/MxtR7XdAWLCjJMjPtk2ybTkc4lcSe8xWXWBQREe
	 lysZi5GBKt5Jf4BkQZ9C8uvPmK72niSalOavxEOtiOnr8x9QgNabFpv4ywgvddVhZjMuA
	 EbfpFQRPSbqJtPpEVCdcAMq4CdCGYOj12ZwXqFzs1fUlExSDR1a4zWvENDWP+gdf7+e44
	 KIrx7ikHApgCWYLc5zztx9eeQNmGf1zfuC0x8QUsKSB7DR1MPKUMZRliLYazIXKNVfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972218;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=puCEmtYA8XjU5FxzFLlKEd9qFbv540kN/jw5cDFtQXc=;
	b=U2LWnPqIZ20IUaMAd3vr+/tty1LVNSk5bK6TVREBshe45pvPkWV6c9eqpg8gMrFl7ZxZ
	 WvnHYRux+rObGmeqPV/GxrUiaEZjC+OF9/e7Osv43mL2TcY4La3DtzTGHkXPeBpnn9yzE
	 /8EMOLniwvrtye8hGrUsg1uk2eQrWGk71xWudeSxDABmYMJPyDXXVRkqF3v4f4wMNJYMV
	 9o0oqv3R+NpUpSkdxWWkKKU2HFq5QQmMFC3NqS+JkoOVLG9fVqhgjOP9/qMZizeSEFuYK
	 N2LM3niMkJlvsy/7gEFoF/k3U7hgAko/f8NvaMKIK4P31MYtJzra3WOLNsGp3CbvwLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Ho1uw/EU";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ED160A2609;
	Wed, 18 Nov 2026 03:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2ED160A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ho1uw/EU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972219; x=1826508219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fpFu7Medjq7O1jQCfldWTqfpWHy2xfRKC2imA1vSroU=;
  b=Ho1uw/EUwSqTr4C/6LB6lh7OS6Sx1v9ZJjRH1UnLIg05L6Kh8q8D7JHp
   q2WPYvuIwefbHUEVTiI/aTkTj4vYbdqnJJ6//Oekjmsd1oncAROgpIB6Z
   5qkEPC6JMDLiXaEggLkLSARbeiSc4/ZhWweZO7EalhCSP6qKEKKMw1iBh
   n9zv613pz4AX4AUYR8tL4orwKvPL9eWaUycUgkMos0zpLkU3BTPBeczeX
   quIRrN7TmEQkJTDR2gk+VLBbu6N7I6YllNBLfsZT7OhywPs1ktl3mjS3t
   dy7l02Ir5koyqmddgw5cpdXIoWsLFoCEWjVfzoAvroiErkeqedbEW3sum
   g==;
X-CSE-ConnectionGUID: hWU0k1CST5CURH9YmgzP+w==
X-CSE-MsgGUID: hxYRDMOBTc+hb1Ubl7Y8Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629902"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629902"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:32 -0800
X-CSE-ConnectionGUID: pesw07tURrapnIGGvEGHVA==
X-CSE-MsgGUID: Q9Pl6/3bSjCDIE2vAOpHxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894222"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:27 -0800
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
Subject: [Patch v7 09/24] perf/x86/intel: Keep LBR frozen throughout PMI handling
Date: Wed, 18 Nov 2026 11:14:38 +0800
Message-Id: <20261118031453.1353625-10-dapeng1.mi@linux.intel.com>
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

On PMU version 4 and later, the streamlined freeze sets
PERF_GLOBAL_STATUS.LBR_FRZ to freeze LBR when a counter overflows.
However, the current PMI handler clears the LBR freeze bit too early,
allowing branch operations that occur during PMI handling to be recorded
into the LBR stack.

This can pollute or overwrite the intended branch snapshot, especially
when bpf_get_branch_snapshot() is invoked from bpf_overflow_handler().
In that case, branches recorded while processing the PMI are mixed into
the original LBR data.

Defer unfreezing until after PMI handling completes so the LBR remains
frozen for the entire PMI path and no branch activity from the handler
is recorded.

Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b8b4e5d8a0e2..2e9e2127e34e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4063,7 +4063,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	loops = 0;
 again:
 	intel_pmu_lbr_read();
-	intel_pmu_ack_status(status);
+
+	/*
+	 * Keep the LBR state frozen throughout PMI handling so that the PMI
+	 * processing itself does not pollute the LBR state.
+	 */
+	intel_pmu_ack_status(status & ~GLOBAL_STATUS_LBRS_FROZEN);
+
 	if (++loops > 100) {
 		static bool warned;
 
@@ -4082,10 +4088,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * Repeat if there is more work to be done:
 	 */
 	status = intel_pmu_get_status();
-	if (status)
+	if (status & ~GLOBAL_STATUS_LBRS_FROZEN)
 		goto again;
 
 done:
+	if (status & GLOBAL_STATUS_LBRS_FROZEN)
+		intel_pmu_ack_status(status & GLOBAL_STATUS_LBRS_FROZEN);
+
 	if (mid_ack)
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940160;
	b=bm4PeUIumb7fI5dcUliBwTarN6dwHJAa2EPYgaLv067NANbJQObPBjWZjCH6JBywMIFh
	 h+0yi6QDpJzUN8sykKSQQmK/hlyOa7cDuFbixLiMEoqdb46WEIqL6wce2QvralXh5/vfK
	 8O9L4GtlTWoBG6YH+qm5+qJ5CPiz2xZKsvESqkrUvFraIRfbDApvSLZAzAH0XVepLdHs+
	 Ojinof+PCJp2fhNMoE/O1xPei/E23s2eU+R8kh81Uqyzows7lWUBRa+n0pmUaAB+eS/Kz
	 xavk0RFSulCiONrwLqNcNBw8MAV/uk+M9Whs7oGtV+VW7mDGbLmZUDRFyRH664eD3oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940160;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6B9Rk6ErtFVn5nzx7x1z37dAnA1db3t28+1FYc0Y5Fk=;
	b=aClX4+jg3SiTKPhQBIvQYxtVKQ2RQmyBFG81LwGYobVh8YSeGWq7pjPub37JPeVfjYFj
	 uWBMkiRRaNxb2jny8tITJTu2v50PZJQ6W+Nz1373Q2wsnWtYvGqdUGRSPIaM0Cxo/gWk1
	 MbPcrZ+v0wQp4sfraZ2fXCe/VZMhndcGd0FZepMHfm1R7ULMUQsCROJw/ZtL2F/T7lUWm
	 hf/JYhfyIooIDfqpDYIpPq7jV0S2lGUfawdVzr5QLPWfJ8BPp+5v1ATCNBTG919IJJEqQ
	 0/crEwRcNiynw19dzyljroomFYw7dYpqllwP/yp333ziO2rySJUWyoiS+I+e59lyWLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hGmymuHO;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FA606A328;
	Fri,  6 Nov 2026 04:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 027FA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hGmymuHO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940161; x=1825476161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sFQFHR37u0yD7u3TkXfU+i6tiYb70BaaYHxhNFw+MTo=;
  b=hGmymuHOgqpgRb7TIuKVvLtmkd6rQOM1BUcPwhieXhsmqAyzi98OGfgc
   qAwSQW6PgpZvkVe7ZXcghEnXOVrjOnBAF9egyGRcY2Dd73cVfMW+eOpP7
   oQn6RN4Y5ux3cJDRhQVnDNlaZUOiR+KN8ZKTnwfpa7tizuzr1XyX/h4T5
   77jgGhjWSjBYT0EhgRi0XSW2Jv1yuwI2EUm2A5T3P0AXp3mbX4lBDmSzy
   qn2OJUpWQEclZfXw4ne8rxwXBugzLPCtIKEtNsE8YRF+YvoM3CWq/95yh
   /yFvh2OaMglvK/xzCnh4DkymHbpaqDGvAh2OUa1zPeLSWhg0+uDtaLG7Q
   g==;
X-CSE-ConnectionGUID: 4qskt6h/QrSFvpyCao928A==
X-CSE-MsgGUID: ppnZOF4sTfiy31/JUaHXWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780959"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780959"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:42:03 -0800
X-CSE-ConnectionGUID: bCZARbNsS1qOaPHZfw8Swg==
X-CSE-MsgGUID: 2lbY0lUcTcelwcNlLocDNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7223026"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:58 -0800
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
Subject: [Patch v6 18/20] perf/x86/intel: Refill LBR stack for LBR counter events in PMI handler
Date: Fri,  6 Nov 2026 12:32:55 +0800
Message-Id: <20261106043257.842864-19-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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

When handling an LBR counter event, the raw LBR counters in the reserved
field of each LBR entry are cleared after the stack is processed and
reported to userspace. This prevents raw counter data from leaking.

However, if multiple events overflow in the same PMI, an LBR counter
event may not be the first one processed. In that case, the raw LBR
counters may already have been cleared by the previous LBR event, so the
later LBR counter event cannot read the correct values.

Refill the LBR stack before processing an LBR counter event when multiple
events are handled in a single PMI. This restores the correct raw LBR
counter data for the event in this corner case.

This situation is rare, the performance impact from extra refill should
be negligible.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 707bff285ed7..f4d4613fb9f7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3866,6 +3866,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	bool lbr_refreshed = false;
+	bool lbr_counter_cleared = false;
 	int handled = 0;
 	int bit;
 
@@ -4036,12 +4037,20 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, last_period);
 
 		if (has_branch_stack(event)) {
-			if (!lbr_refreshed) {
+			/*
+			 * The raw LBR counters stored in the reserved field of
+			 * the LBR entries were cleared during processing of the
+			 * previous LBR event, so refresh the LBR stack again if
+			 * this event needs the LBR counters.
+			 */
+			if (!lbr_refreshed ||
+			    (lbr_counter_cleared && is_branch_counters_group(event))) {
 				intel_pmu_lbr_read(cpu_lbr_stack(cpuc),
 						   cpuc->lbr_counters);
 				lbr_refreshed = true;
 			}
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
+			lbr_counter_cleared = true;
 		}
 
 		x86_pmu_clear_perf_regs(regs);
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249278;
	b=a6efOv/pfB0bEjZbgOyhvc4bXmdBJknu8YkcJFKYv1Tip+RbzMT9AiBJItNcjbkanVFh
	 V+c+OlpMciYKSvWd1HEU/JoEuJlfcs8NIOSjASlSJYrrfqeezydGprUDDh8/w9xsHjnBD
	 6VRLU94dmm1p+3fVtUaRc3JiiqXOWi4ReulztalC+qVEVguonQ1NpuAUhGJQKotO4cy5s
	 7JSAS6CX85XgkoKFw3Kg8s5ZI4M+EyX7row1cTvl+giL8I+2IWNvHAOL3LiqpcMxJPtvT
	 tZH066LWzbeH3n84J6BvK4BM2PBEOnBpxCISkcXEUzuw6CcgmLqa04zVu9Q90N08jcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V9dOg3JB7ogyWZqheDacWQ4pkw3FEXeP9ZU/TzY6tt8=;
	b=puBHlIzMLUGC7o9qI9unrA/NoGtqDxgopdjtXycXELOEtD+M9ihA9l1X8ONHwo3fp8DE
	 5MpzUXqj7yhCuro2mpm6kbTvciBF+Us7jNZmA+RGGls+nfhIbgMp8uwFzOdLDXxgLW9c4
	 TNGwQBnkxzY9hxFISMLUzAHFW+YCXH9uvJu6Vjye5Jv1POn5tdtWpZpTZSnW7cO/n7AI3
	 5qLwaIAXSZsKpXWvoLuR93Rbbz07rgTe37SvI8Hbwtar5vY4e/eFkODYxWRziUV//UYJx
	 TTqo3AXpjn9O7cpvP8a0coN3KhTDbYwi8PEgzp092yEBpAECycvsyFxk/qaNEojh47g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aY4dbN7d;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7360A2625;
	Thu, 29 Oct 2026 04:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03E7360A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aY4dbN7d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249278; x=1824785278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BQvHliOZMVGgAvUvkgNp457E2qX+B1bIxT22KC+BNTU=;
  b=aY4dbN7dWG7nfMYSB0bbf60mdbqk+kXoZDcRMFbgvxty0H7QcHwxndG2
   8ZuUL8hh8aOX/oviyiDzIM8IgL9T67hu44D9sNew40TFEf14n7lxTm78k
   Vb7JfFkLGUcfOfUY11DW59t5Yrl0yG1bpdbuTncwITNgAZTcoQFdKtKZF
   jZUOptq5OA6Iba8pvOCS+Zkqm9msHDXIhYu8EOJEjqlTOFY2tNMj62fGQ
   lLhPjqrenQVO9DPphuEtSMguPbZhIyTcERGRrr6rdJipslO6VGhXFkpiI
   AxtG2LAoT/8KpdB4ZqJroxil3fm+3C9UxGimjE53MhId4sTimIUh30RDp
   A==;
X-CSE-ConnectionGUID: CoJGGWjcRuuzqSQ74R3jxA==
X-CSE-MsgGUID: 6dy1/flfQte1C4+Y7dMlTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986347"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986347"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:58 -0700
X-CSE-ConnectionGUID: 8bpUlvYxQPeuIOGBKzgtOA==
X-CSE-MsgGUID: 54l8uKG3RCq//xHXTjDoPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420602"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:54 -0700
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
Subject: [Patch v5 16/18] perf/x86/intel: Refill LBR stack for LBR counter events in PMI handler
Date: Thu, 29 Oct 2026 12:39:12 +0800
Message-Id: <20261029043914.1395147-17-dapeng1.mi@linux.intel.com>
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
index e1834b329e37..9267f2d7d21b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3864,6 +3864,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	bool lbr_counter_cleared = false;
 	bool lbr_need_update = false;
 	int handled = 0;
 	int bit;
@@ -4025,12 +4026,20 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, last_period);
 
 		if (has_branch_stack(event)) {
-			if (lbr_need_update) {
+			/*
+			 * The raw LBR counters stored in the reserved field of
+			 * the LBR entries were cleared during processing of the
+			 * previous LBR event, so refresh the LBR stack again if
+			 * this event needs the LBR counters.
+			 */
+			if (lbr_need_update ||
+			    (lbr_counter_cleared && is_branch_counters_group(event))) {
 				intel_pmu_lbr_read(&cpuc->lbr_stack,
 					cpuc->lbr_entries, cpuc->lbr_counters);
 				lbr_need_update = false;
 			}
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
+			lbr_counter_cleared = true;
 		}
 
 		x86_pmu_clear_perf_regs(regs);
-- 
2.34.1


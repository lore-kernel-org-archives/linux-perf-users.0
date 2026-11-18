Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972249;
	b=GD4WAQQovsdyYvqzJUCdQYxcQjZrotR2v3qinVYWS0pqZHhZ+cjskGYPI+QSxn6JVoRN
	 b/HfQ5KxDx2PZ0/6buYgj5jC2m9sy4T30Q74G15XnSDI3xF+LcsIuGIj7KuPeNeN98CSy
	 APESqFF6dKK1lAsRd053Gr69dPprYnYM1aYOv9C4DG0Nqbj5V5UzZ29MFSVX1UFmZ2ZiP
	 OBQ8D/CYTAvLTE3JigF38ZxGg6PjkW0yS9CNCN6qUXJBdCAQLul6BupWtfotKnOya44h2
	 paRCjWJYFqeyJYOnenf+oLlucv5kXIkYd/+KaELn/kkCiIh9vFQLHlu8ARUiTHAQVNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972249;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=da3Lils9OD3A5OqTLMQepFpLKjdzomZlXg5qA/2Jk94=;
	b=ilp02iMwGxvzYlqrHSqn5rcrS0HP94IRFqnAOpevKqDoJ/lSQ3s91d3gVQTxDXF1iTqk
	 gbg/OyxjCE2LNh8RklnJDzgNShT19BUXuFZu505kV+84BMLooKILYEr7ayP3nr2vKaIco
	 vpmHIaqQ5hRcrXquT05zBXoBwjBWKd9kh4tsVVYsKAdz5nYzIYoNT2iFfEavK5yIw5XUD
	 ZwQwx6A1EBbLosB1hzvTdBfnHJT8k6IF/5RT1xM+XIyVi7rr0uJOO/JKm9l//V2F3ryjL
	 QXoDFht+fnn3tVR54qH6QPfrSrWu/e45URPq9lDEb/afYgjYo78vHpxrHbAuE65wzcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k7Pb203d;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37731606A31C;
	Wed, 18 Nov 2026 03:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37731606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k7Pb203d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972250; x=1826508250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+BiEYO4DEY/hSKCQD2gRpr6Q795tZnY/9LHgg1LUdE=;
  b=k7Pb203dmUn7sWkiHSjONAUgJXZdlt53xaEa6u7nEqcSxdelQxnqcWCT
   mzqXWLWJItoJ67BuAMedacAWLEIBLkSmCAHeTIhfZjUmEdOb4wqpBJThW
   CtLC7nbkNM3H9u9549qEKKQIckLPYDMrKsi/coECSJMdZ5HbTjlFYjTv6
   1R04LCCXNsHk2EazF7iIApI2uHAp9KUH5ilNww0bSLYrFD27wKpSouaRe
   YH4xinInVVL55mEDPsY15P1W31Mdpn3XUk2NjY8MIlCEVcsRTJ8Pkr+jk
   1hka6ulVMGyHdZu9aZq+1+jv9Blc7mw3cgdWUEl1MYOmQYw5vS3QKxCGL
   Q==;
X-CSE-ConnectionGUID: GJ4fvRBJR4CjEO3PnufFeQ==
X-CSE-MsgGUID: YmggwBbESyWhlhsLD4H+wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629969"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629969"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:09 -0800
X-CSE-ConnectionGUID: CnlObg09Qg2nSghK50EVQg==
X-CSE-MsgGUID: iUo7/IgcRyuR+o7kveqNNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894322"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:05 -0800
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
Subject: [Patch v7 17/24] perf/x86/intel: Refresh LBR stack for non-PEBS LBR events when needed
Date: Wed, 18 Nov 2026 11:14:46 +0800
Message-Id: <20261118031453.1353625-18-dapeng1.mi@linux.intel.com>
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

PEBS and non-PEBS events share the same LBR stack in cpuc->__lbr_stack.
In the PMI handler, the non-PEBS path refreshes the LBR state before the
PEBS buffer is drained.

When PEBS and non-PEBS LBR events overflow in the same PMI, draining the
PEBS buffer can overwrite the shared LBR stack with the PEBS snapshot.
This leaves stale LBR data from the PEBS record in place, so userspace
can see the wrong branch stack instead of the live LBR state at PMI
entry.

Track whether the LBR stack still contains the live state from PMI entry
with a cpuc->lbr_stack_live flag. The flag starts out clear on each pass
of the PMI handler and is set once the live LBR state has been read.
Draining PEBS records with LBR data clears it again, so a non-PEBS LBR
event re-reads the stack only when it is needed. Since the LBR state is
frozen for the duration of PMI handling, it only needs to be read once
for multiple non-PEBS LBR events in the same PMI.

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 18 ++++++++++++++----
 arch/x86/events/intel/lbr.c  |  1 +
 arch/x86/events/perf_event.h |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5491cd4f4c6f..aa7034c5ea41 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4054,8 +4054,14 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (has_branch_stack(event))
+		if (has_branch_stack(event)) {
+			if (!cpuc->lbr_stack_live) {
+				intel_pmu_lbr_read(cpu_lbr_stack(cpuc),
+						   cpuc->lbr_counters);
+				cpuc->lbr_stack_live = true;
+			}
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
+		}
 
 		x86_pmu_clear_perf_regs(regs);
 		x86_pmu_update_perf_regs(event, &data, regs, false);
@@ -4111,12 +4117,16 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 	loops = 0;
 again:
+	cpuc->lbr_stack_live = false;
 	/*
-	 * No need to read the LBR stack when all LBR users are PEBS events,
-	 * since the PEBS handler updates it.
+	 * If PEBS can't record LBRs, draining PEBS can't overwrite the
+	 * LBR stack, so read it here at PMI entry. Otherwise, it is read
+	 * after PEBS draining when needed.
 	 */
-	if (cpuc->lbr_users != cpuc->lbr_pebs_users)
+	if (cpuc->lbr_users > 0 && !intel_pmu_has_pebs_lbr(cpuc->pmu)) {
 		intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
+		cpuc->lbr_stack_live = true;
+	}
 
 	/*
 	 * Keep the LBR state frozen throughout PMI handling so that the PMI
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 3a282352b0d2..740d5a5ba4c3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1317,6 +1317,7 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 
 	intel_pmu_store_lbr(lbr, cpu_lbr_stack(cpuc));
 	intel_pmu_lbr_filter(cpuc, cpu_lbr_stack(cpuc), cpuc->lbr_counters);
+	cpuc->lbr_stack_live = false;
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8d64bfcdc82d..4e6cf5c1e865 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -525,6 +525,7 @@ struct cpu_hw_events {
 	/*
 	 * Intel LBR bits
 	 */
+	bool				lbr_stack_live; /* If LBR stack holds the live LBR state */
 	int				lbr_users;
 	int				lbr_pebs_users;
 	u64				__lbr_stack[LBR_STACK_SIZE / sizeof(u64)];
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940170;
	b=kxX96UilDJmrSWKWWMAQhWG1jPNbH9q9FSbFaBGMMTt5wMHqP6XwG27SxjCuq5yyGNgk
	 6S5Zh/dmHt6iwqdSbfRhidSeUeuuyu/NxW6y/CVg2W2NNWYzVBePxgSFSIPd+imEALfZ3
	 9zOUDfa8GBYdxKdKSeeSOgLMnhro9JBYxQVFS/dsMuSvA+4qzPzVrK0yL6ANQqznlGiFf
	 fvEDCv/2Wxn6NiRpgAOb5a6kcP/Uvs8ER0ayR2vJMJ5JnhZg9PubygbkfCtr6eFQ5hTS6
	 9nDiXifzwT0HHB9Q92fd2rjWcdgyrsB04fJT+XsHy7NN5hXdaMSUQUNIa3I/0dmTLtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940170;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mGYz6T1YNtMToOuFFVV8f16Yx1jlDiaTue13r3kuigI=;
	b=WBs/DhXNtglPX2izeFrNy9+Ojy1mx1wD0nNC8HjqtdBho0uHjQJTZjTmL6ec8JZ5sSAi
	 vGjeTdmxJuEwTcXEPRUyAL1z6YqiONNNRFqVmX29S77Zo/UhCoa/JG+KUGc2mTbyyfK5l
	 P+uCk9N8k+Bh3zivNGKPB6jLUi9SVNRa5vdVkclRz7k9lwRA0RGfMdQXxFamcw8PzBn5R
	 l6aKkMN32vbLAk9NHEMGA3uNjcBm9CYPFvIbnS5oGTmk4P6/OXImQSTlDV9xUHmbk2C0o
	 1FydS4kUnxVjwhU2LkA7DZWF3dQPdAHiINX997bngslvCQfGp+YECowuB/jGWmRGgUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fv8ssbJE;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A4606A333;
	Fri,  6 Nov 2026 04:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 437A4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fv8ssbJE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940158; x=1825476158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AutAiSLbDQHs4raNcef64NvICMZipClIevHqdZQdR4U=;
  b=fv8ssbJE6vHJcnc79LmfTISR0ayWQRofUg/WZ4glMwz6s0HGxv9o1Wlh
   jS78lhOT3B0tl9SDpNEQp8Mjf846x7+S7p0II/CuAl9vdonQmMyHC0nuk
   HTr8AZ9yLURGiRobaisw2bFUBgbY7tkSFNP7rNDHJHEzyDfdBple3IQIH
   suQIm18BN1a7peSNxxC57L8cCNeds3BeF6WDqsBfifyc4sLIYKJmtnB9u
   023WScTkeeDCPaz/6C/YCw+BxUEnOqeK/cjaOtWeyron7r1U58nyosMyt
   092TCWm9AJnEpzIHs4zuFpVH1N9Z7pE0gncaBCXrV1tsxuUcVTQTK7UDV
   g==;
X-CSE-ConnectionGUID: UGYCLwCuT9mmxiFxsFw8kA==
X-CSE-MsgGUID: ajLWMGCHSOmnulMJ4LVkZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780953"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780953"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:58 -0800
X-CSE-ConnectionGUID: 2KDr0F2OTvmYWp5n3Lzqlw==
X-CSE-MsgGUID: S3n3Rm5nQvmQ3iQ5RWi6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7223021"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:53 -0800
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
Subject: [Patch v6 17/20] perf/x86/intel: Clear raw LBR counters in the LBR stack
Date: Fri,  6 Nov 2026 12:32:54 +0800
Message-Id: <20261106043257.842864-18-dapeng1.mi@linux.intel.com>
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

Raw LBR counters are currently stored in the reserved fields of the LBR
stack even when no LBR event needs them.

If an LBR counter event is present, it clears the raw LBR counters while
processing the stack, but those counters can be leaked to userspace when
no LBR event requires them. Clear the raw LBR counters when no LBR event
uses them.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  1 +
 arch/x86/events/intel/lbr.c  | 13 +++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b267c68f9467..707bff285ed7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2835,6 +2835,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 		(struct perf_branch_stack *)bpf->__lbr_stack;
 
 	intel_pmu_lbr_read(lbr_stack, bpf->counters);
+	intel_pmu_lbr_clear_counters(lbr_stack);
 	cnt = min_t(unsigned int, cnt, lbr_stack->nr);
 
 	memcpy(entries, lbr_stack->entries,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 3500cf3518f4..fbc053ebbeaf 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -987,6 +987,18 @@ static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
 	}
 }
 
+void intel_pmu_lbr_clear_counters(struct perf_branch_stack *lbr_stack)
+{
+	int i;
+
+	if (!(x86_pmu.flags & PMU_FL_BR_CNTR))
+		return;
+
+	/* reserved field stores raw branch counters, clear it. */
+	for (i = 0; i < lbr_stack->nr; i++)
+		lbr_stack->entries[i].reserved = 0;
+}
+
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event)
@@ -997,6 +1009,7 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 		return;
 	}
 
+	intel_pmu_lbr_clear_counters(cpu_lbr_stack(cpuc));
 	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0213e2a8efff..a4e53c99eaf5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1984,6 +1984,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_pebs_init(void);
 
+void intel_pmu_lbr_clear_counters(struct perf_branch_stack *lbr_stack);
+
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event);
-- 
2.34.1


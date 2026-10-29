Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249273;
	b=4250JKArss693GDbeBfUPVXrM9W5BbybMgv+IJZWRCzggLNzyv1Ag1cE3s9eZti8MspO
	 qE5HTNgL2JLFzY3YE/6Ygqavwg+rJBfvF/YpvRTzjMD1ptRP8B1S66uGQxaTbqkAb4tL5
	 B6LWJLJUKx2JOKrnLYkoxcpEL9D0IMHcowOymnTXMAcCZAxwwRIaaLi3S/C6O32pe0OFd
	 KIn2EjhWQms3InyCyjaxt3PEJsSJ9s8LUELA9evIQ2Jbv8LzCTu++T5q+wQZSrS/sOZlt
	 49OhugE0BSbb/0y2hKH1v1/tnjdX7V+oajPg/DdPlpGny9ReyBklHOS7LBjR+bLaT+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249273;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lYSbStC3/f8lSAaS/hdLzRAwZuraDA2vOdTp4POg6pk=;
	b=mrTrsdKehcVkITaQZiCxx/XQwk9VX6piKu4osxLdgdpoKVP+6qxxLEr6tgoRj/lJRrXi
	 W11mcu18hQ7yRR1JxtvgFkDKqLv8GuL4TQvJcySKW3A7rzPOrm4rw27vrbtSTZp56I1V8
	 8vt16x3YnMFc20m7mZ4ouEAo1RX6Cuc2SvemMTJ5G3lHUbS0aAWc3Cxf+RdAOAy8FSxzG
	 qlMVLu55QBhIrTxULZGjxwOXN1YfKrnjDeN578tKFPUgdkLDxTaeC6RtWyrfLn++Z9fNe
	 wKIlqGiB1o2XPsdEzpPz0soFK206XG5hJX3VEO3AYceIgOkjeyZEigflXLjXMHYyXMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mB/MHydD";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A9606A32D;
	Thu, 29 Oct 2026 04:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 346A9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mB/MHydD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249273; x=1824785273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uIxA7b4A/5PXrqleqgdiwaqJRCL5HJ48coinFVhYNo=;
  b=mB/MHydDqzgSL6X5/DHnLl48tHB2EXskoer0NsFogjSCAAVVhUdxLHqT
   7cT02tAL7HC9HZ0efIcw1JbDH0xaybYEwfii42B3mIZ8I2fZ9rbDZfVtg
   9kOnfPXEWecqYWMGkbPtsrF8Wm6lCv6mINI+P44GFPrzg9f/mJfY2abw8
   fkqLmb63i0n116ZGQaKedq7hbUkY46RwR7/v7JI3s/zFXwxoKb8AcKll/
   daGa4R1bdDIk71w94eJqsls3+xBb7sAo5vAuOgIXRES3CFZhmBsg9YH3A
   exEXhMEtm4dgFTqy7wWiliP3hBBUHV1mfPe5iUD/wcZhaifrJBtODq4Hj
   Q==;
X-CSE-ConnectionGUID: 3zdcuk8aQ0GE4tnq1WkUCw==
X-CSE-MsgGUID: J6Oo0OzcTYu3Fy5mUh1CHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986339"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986339"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:53 -0700
X-CSE-ConnectionGUID: J4NwF6oyRh6E4YNew5izwA==
X-CSE-MsgGUID: x3LXpIiJTlKYhikq4TaFQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420575"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:49 -0700
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
Subject: [Patch v5 15/18] perf/x86/intel: Clear raw LBR counters in the LBR stack
Date: Thu, 29 Oct 2026 12:39:11 +0800
Message-Id: <20261029043914.1395147-16-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/lbr.c  | 14 ++++++++++++++
 arch/x86/events/perf_event.h |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 37f304a1b48c..e1834b329e37 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2834,6 +2834,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	struct lbr_snapshot *bpf = this_cpu_ptr(&lbr_snapshot);
 
 	intel_pmu_lbr_read(&bpf->stack, bpf->entries, bpf->counters);
+	intel_pmu_lbr_clear_counters(&bpf->stack, bpf->entries);
 	cnt = min_t(unsigned int, cnt, bpf->stack.nr);
 
 	memcpy(entries, bpf->entries,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 2c9c9cf42e94..e9336d570242 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -996,6 +996,19 @@ static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
 	}
 }
 
+void intel_pmu_lbr_clear_counters(struct perf_branch_stack *lbr_stack,
+				  struct perf_branch_entry *lbr_entries)
+{
+	int i;
+
+	if (!(x86_pmu.flags & PMU_FL_BR_CNTR))
+		return;
+
+	/* reserved field stores raw branch counters, clear it. */
+	for (i = 0; i < lbr_stack->nr; i++)
+		lbr_entries[i].reserved = 0;
+}
+
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event)
@@ -1006,6 +1019,7 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 		return;
 	}
 
+	intel_pmu_lbr_clear_counters(&cpuc->lbr_stack, cpuc->lbr_entries);
 	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 82e0c20e435d..160df7b99621 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1971,6 +1971,9 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_pebs_init(void);
 
+void intel_pmu_lbr_clear_counters(struct perf_branch_stack *lbr_stack,
+				  struct perf_branch_entry *lbr_entries);
+
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event);
-- 
2.34.1


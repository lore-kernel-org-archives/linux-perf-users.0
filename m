Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972245;
	b=A3ulvMj1Xt0QmEWpSZSA+ZW8DL77uaIxkGb47G4tl623UFl08nsWaZDpcnRM2QEvRgLa
	 hhCxBzrKYQF/wsLeI+nsoLifbtiChq5tKmmhjGLPNjbt+9uOTWhfNwss8JlDMoN8s+ixQ
	 wWex++mxBXJC/Esz/DLzOIOhruyzKoRVhRMgDhApfutV2tBQHM820sgRRvNWw4yAVBgIp
	 F2evZ7BAYyGMAU7LHWsZ79YNGJ9/nfHw58eMvil5OM36yHDTLWxCRiy/Cir7r/kAo3B89
	 TRg45oEWqxx+nfoNCCbsw9T+lLZbz8EeEcYuPxlBZuC8ncq8ptMJg0myEXN1LGcZLiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972245;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i93ugYROrWsf6udsBbMWwu1lSyHTdWb3OvYJHUG08Io=;
	b=epq1WfDomY+eWdh2Ctlp/l0chQ+GCgVJdaaoQD2E1MqjJOjHoRFQRu1YEOUXK0QyQxq5
	 e6VFNblY9LhpHmiW6sPumwajBVELquIYVnWugaquCfRHcgO9lZZl6Us7PaYLwReVhskyK
	 +XSjNmcUq6hlTaGE5YQmVvWQjXKgoqYuKyXWs46/BzYifhlUL+Oh4qsjlkxazss5v9lfM
	 HJFzmh9jio0Z4RLtdgbtyiinU9GxBSUFCeeBBQKCBd63mSihEYGwXj7jfarVbl3IlIF1o
	 +Wwxh12Qm97DaBpkhzi9jxEB9s6kzB0xY6efSm25KUfsh5b/srvzWtBJ5AreFi7458g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KOFJKeHE;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DF606A8AB;
	Wed, 18 Nov 2026 03:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75DF606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KOFJKeHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972245; x=1826508245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2bFkLeLWbnxGbTD2lWxXFetnLo4PewDp+rFImXuk44U=;
  b=KOFJKeHE/891Xux7tyP0R54bd5sGtGXCnsmFkjAgTpA29FLSK8H4G5R8
   /SqrVAmNsFk9LLjpgTp/rn/3YrNBxctgr2zHLK7dsc1A6gi0H/C81aRwR
   Z18x2Q6+Je8DYFCwavxCJyu8Uog6jPGCiKnU0k73MMibVYBSs9uRIbeQC
   tkIOJcqjWFlFjEGOeTNor80LLKMaNJcLhPx0c7A7YHE7E5YpD5uYRtQPh
   WPo4tu4xA0T57V2TTuoIFdzZcXTHBJiaVgC28VUJObG0v4RSPWFbJk7O5
   7+wqkUy4dOh/7NSYi6Y/OhAij9aBv2xh6CQ2jtF/0ESQWAUjv+0xnbgt/
   Q==;
X-CSE-ConnectionGUID: TSPKiKB7Q6e4vnYzJfC/Rw==
X-CSE-MsgGUID: ikfT1d18RNCHDYgKbWZesA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629963"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629963"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:05 -0800
X-CSE-ConnectionGUID: s+J2mvpnTr6Ieu/RqOZIVw==
X-CSE-MsgGUID: ghCTCAoxTZ+pZb/oFlK5uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894315"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:00 -0800
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
Subject: [Patch v7 16/24] perf/x86/intel: Account LBR user counts for pure branch counter events
Date: Wed, 18 Nov 2026 11:14:45 +0800
Message-Id: <20261118031453.1353625-17-dapeng1.mi@linux.intel.com>
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

intel_pmu_hw_config() clears PERF_X86_EVENT_NEEDS_BRANCH_STACK for pure
branch counter events. As a result, intel_pmu_add_event() and
intel_pmu_del_event() do not account lbr_users and lbr_pebs_users
correctly for these events.

Add intel_pmu_account_pure_branch_counter() to adjust the LBR user counts
when pure branch counter events are added or removed.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fd4de141ef28..5491cd4f4c6f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3168,10 +3168,47 @@ static __always_inline bool intel_pmu_needs_branch_stack(struct perf_event *even
 	return event->hw.flags & PERF_X86_EVENT_NEEDS_BRANCH_STACK;
 }
 
+static inline bool is_pure_branch_counter(struct perf_event *event)
+{
+	return is_sampling_event(event) &&
+	       has_branch_stack(event) &&
+	       branch_sample_counters(event) &&
+	       !intel_pmu_needs_branch_stack(event);
+}
+
+/*
+ * A pure branch counter event clears PERF_X86_EVENT_NEEDS_BRANCH_STACK,
+ * so intel_pmu_lbr_add()/intel_pmu_lbr_del() do not update lbr_users
+ * and lbr_pebs_users. Handle the accounting explicitly here instead.
+ * See intel_pmu_hw_config() for details.
+ */
+static void
+intel_pmu_account_pure_branch_counter(struct perf_event *event, bool add)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!x86_pmu.lbr_nr)
+		return;
+
+	if (add) {
+		cpuc->lbr_users++;
+		if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip)
+			cpuc->lbr_pebs_users++;
+	} else {
+		cpuc->lbr_users--;
+		if (intel_pmu_has_pebs_lbr(event->pmu) && event->attr.precise_ip)
+			cpuc->lbr_pebs_users--;
+		WARN_ON_ONCE(cpuc->lbr_users < 0);
+		WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
+	}
+}
+
 static void intel_pmu_del_event(struct perf_event *event)
 {
 	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_del(event);
+	if (is_pure_branch_counter(event))
+		intel_pmu_account_pure_branch_counter(event, false);
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_del(event);
 	if (is_pebs_counter_event_group(event) ||
@@ -3734,6 +3771,8 @@ static void intel_pmu_add_event(struct perf_event *event)
 		intel_pmu_pebs_add(event);
 	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_add(event);
+	if (is_pure_branch_counter(event))
+		intel_pmu_account_pure_branch_counter(event, true);
 	if (is_pebs_counter_event_group(event) ||
 	    is_acr_event_group(event))
 		this_cpu_ptr(&cpu_hw_events)->n_late_setup++;
-- 
2.34.1


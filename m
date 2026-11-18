Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972263;
	b=PKAEvBDwhOmKqjfInksxi6UapodwUuADHx9uSIa7+e5pSF/Y9gR8b//lhkPsXrLaIyhS
	 Xd7N6iqOVLtrIMwJLvxjtLsH02UfF8uhw4azP8ZwlnRmy/ccSb/utoLkrPg6IH/WTljyX
	 uuEXLFFsqBc4QGKjwZo/DKD5DDKKCjOwCdUHJy8+CvYWzzh1lMyrNL18tMKw8S9mcRMdJ
	 cuWwg8nHZmJlvzwHcgp3dk2gEn/DoObgnm77qnKgkISFkev1YsBDd30R1s+KcNRlLo4pz
	 ULEvReGeyaXRf95aeFk4wSzx7JX4EXpY1WXzZod/FcSTtOZWMaHPZt7ytBWyv8w39JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hBR9Lue+7o52B0U+2i3GJS3cMPp6hJ5U1Az4Nkyh+v8=;
	b=HCgjzn1HkTMni8zqtHeDwbsC3o7p2cpDhc6lGLqcz+1WTGOiSzMBiowSt14p/Krp+dRE
	 CRryFT34lsHCnA+xPjcoJ8Z7A65O57HqkQDCnu8mmHdkF1DwvhWcXYVd7y4tRCllRvUcn
	 dmjRCpAk1+/0/z44+fhEldXBNMTguhXB4UHH91tEA3sC7bw0lAqc2k5M3f3WwvKjHPjVQ
	 8Fx37eu+MZEvoqvphn3DKoi4lLEXDpKWkd6s4JoYc7/PdLCS8LeSxCciYHJaUqXyYUUUA
	 E7WiaiD8GViTr61QlMUXDbZ2nucaFWbC9k+k+fh9FoMHjZfeDxDdCGupIaUdg4G9jlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U3CNOgZA;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E2606A331;
	Wed, 18 Nov 2026 03:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F5E2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U3CNOgZA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972264; x=1826508264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ICRebQTyAY3qeOutTMwoeFncm3hOB0X9j2396Ajc/I=;
  b=U3CNOgZAlC0+fE+73ytT8RmaZgtrRmWkUJT8RrO4hYQ6PdQ8MunKA4OV
   mPTq26ij0fcVl9c9Tch8X5eS6YG0PficwmnQkPUHHWVEhj9at3qgsD9Mw
   raiQjyrcxEXC5MXuRsMSeqBByRPiqsMcYozpqP+CYmBiOqwKFG3Q2j7mY
   tu+WHuyyJW81ax0bK4Giah5g1hAknzxy+BbxDwWqacF/lkLIhw53tkPSQ
   gf59i4LeCRq8t00uxR2XZj+V7xeaL+0Laud4xPoeQ3fZ66zSe1GJcLHi8
   zJzonSzaUvfijiBMAiGzA+ik1gLKnlif2JEXAPoOyqnXxvRG6tDoxlXQu
   A==;
X-CSE-ConnectionGUID: ClXMd9qYTyuOprZGdC32Mw==
X-CSE-MsgGUID: 5EUbn5BGTkauaJARAuJqwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3630014"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3630014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:24 -0800
X-CSE-ConnectionGUID: dDpenb1kQt2LjUzEY8+N3Q==
X-CSE-MsgGUID: ftLVLcpKRAiJgauQ4lSvKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894354"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:19 -0800
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
Subject: [Patch v7 20/24] perf/x86/intel: Clear raw LBR counters in the LBR stack
Date: Wed, 18 Nov 2026 11:14:49 +0800
Message-Id: <20261118031453.1353625-21-dapeng1.mi@linux.intel.com>
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

The raw branch counters are stored in the reserved field of each LBR
entry. The branch counters path clears that field after reordering
the counters, but the BPF snapshot path and the regular branch stack
path leave the raw values in place, so they leak to userspace.

Clear the raw counters on those paths too.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  1 +
 arch/x86/events/intel/lbr.c  | 13 +++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ccd2c57931b3..fc672bc69ae3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2836,6 +2836,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 
 	lbr_stack = (struct perf_branch_stack *)bpf->__lbr_stack;
 	intel_pmu_lbr_read(lbr_stack, bpf->counters);
+	intel_pmu_lbr_clear_raw_counters(lbr_stack);
 	cnt = min_t(unsigned int, cnt, lbr_stack->nr);
 
 	memcpy(entries, lbr_stack->entries,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 740d5a5ba4c3..4736debffb0b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -991,6 +991,18 @@ static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
 	}
 }
 
+void intel_pmu_lbr_clear_raw_counters(struct perf_branch_stack *lbr_stack)
+{
+	int i;
+
+	if (!(x86_pmu.flags & PMU_FL_BR_CNTR))
+		return;
+
+	/* The reserved field holds the raw branch counters. */
+	for (i = 0; i < lbr_stack->nr; i++)
+		lbr_stack->entries[i].reserved = 0;
+}
+
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event)
@@ -1001,6 +1013,7 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 		return;
 	}
 
+	intel_pmu_lbr_clear_raw_counters(cpu_lbr_stack(cpuc));
 	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4e6cf5c1e865..733123fc4ffe 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1986,6 +1986,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_pebs_init(void);
 
+void intel_pmu_lbr_clear_raw_counters(struct perf_branch_stack *lbr_stack);
+
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,
 				struct perf_event *event);
-- 
2.34.1


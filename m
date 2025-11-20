Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E742C30146E;
	Thu, 20 Nov 2025 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617054; cv=none; b=ZnPsCCPIRfzGSP7LptDmaBbNyVcbrJajnSJNkApv8Y/4/9viuS3mUFIpctZSxzKWffXaXRcE56mQ2cuOG95dKGQur1TXLFE0ac4yKDBpvRoHxyPB1Xu9/H8EdHBeclcbb6bMbwWoNkwJ66IEtSETboX3duzj6A/RTPLT2t7xUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617054; c=relaxed/simple;
	bh=ET01FWIucwbW1EkoINqz0VA9PNL+kELjKgw55gDCLD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uI2ph7RnFv6kXDA3Magbo+Z1QMpjnm9aNKQEiVtTiuhn6qWKWJyvVMKLM2tE98kq4puhKm/UheZxbFATweMVKwxvM21udBQsayGeFTjL8jCx9UWNAc10ZM1LPZomLHdyrlS5gVwOMnyP7ZumojwwmrUHByq0zpV5kr+yLj/sOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejU7Zplv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejU7Zplv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763617053; x=1795153053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ET01FWIucwbW1EkoINqz0VA9PNL+kELjKgw55gDCLD0=;
  b=ejU7ZplvHJr9/TurBvSz83pzwXNtEi4qM9Tl4WRu+yAJxuKUvuStqWYT
   xgoh1s9DoZK1WXftU3vGkYqmM54LndqqvMmxS5lDhLZtZZkL9JEVTJN2B
   Uy1ywdLvihNO0djw21OCiZ2UCfmEgP8goOck/cQCHYzoqFCgFNAt2KKB2
   iTzd1MweXWvkOliPhaGIiWQ/7WvyALDgIvH5no4A+i4ftISlmyQxEr6Fz
   5MbHcpuygp3mttW+HnUN94PZBYS0sMa1uB/cfxX21UwzEnBna6VVQvFuf
   MVTKSIDd6/k5FBbKdkf8I7bYbv1G5otiRKR1zPTQife6y5iruzsTheIbx
   A==;
X-CSE-ConnectionGUID: 6l8anKifT+icWXnALtT7tg==
X-CSE-MsgGUID: DAbVRSNqSfyGk2F56T3rAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65710211"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65710211"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:37:26 -0800
X-CSE-ConnectionGUID: FJ7cEH7CQbaxaUYIXwe4oA==
X-CSE-MsgGUID: m0tbSXxhQ8qv8mJEAmRzhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191055570"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 21:37:23 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 6/7] perf/x86: Replace magic numbers with macros for attr_rdpmc
Date: Thu, 20 Nov 2025 13:34:30 +0800
Message-Id: <20251120053431.491677-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macros to replace these attr_rdpmc magic numbers, so users are easy
to know their meaning.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 7 ++++---
 arch/x86/events/intel/p6.c   | 2 +-
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5d0d5e466c62..3d9cc1d7fcfa 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2129,7 +2129,8 @@ static int __init init_hw_perf_events(void)
 
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
 
-	x86_pmu.attr_rdpmc = 1; /* enable userspace RDPMC usage by default */
+	/* enable userspace RDPMC usage by default */
+	x86_pmu.attr_rdpmc = X86_USER_RDPMC_CONDITIONAL_ENABLE;
 
 	for (quirk = x86_pmu.quirks; quirk; quirk = quirk->next)
 		quirk->func();
@@ -2609,12 +2610,12 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
 		 */
 		if (val == 0)
 			static_branch_inc(&rdpmc_never_available_key);
-		else if (x86_pmu.attr_rdpmc == 0)
+		else if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_NEVER_ENABLE)
 			static_branch_dec(&rdpmc_never_available_key);
 
 		if (val == 2)
 			static_branch_inc(&rdpmc_always_available_key);
-		else if (x86_pmu.attr_rdpmc == 2)
+		else if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE)
 			static_branch_dec(&rdpmc_always_available_key);
 
 		on_each_cpu(cr4_update_pce, NULL, 1);
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 6e41de355bd8..fb991e0ac614 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -243,7 +243,7 @@ static __init void p6_pmu_rdpmc_quirk(void)
 		 */
 		pr_warn("Userspace RDPMC support disabled due to a CPU erratum\n");
 		x86_pmu.attr_rdpmc_broken = 1;
-		x86_pmu.attr_rdpmc = 0;
+		x86_pmu.attr_rdpmc = X86_USER_RDPMC_NEVER_ENABLE;
 	}
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f7caabc5d487..24a81d2916e9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -187,6 +187,13 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
+/* user space rdpmc control values */
+enum {
+	X86_USER_RDPMC_NEVER_ENABLE		= 0,
+	X86_USER_RDPMC_CONDITIONAL_ENABLE	= 1,
+	X86_USER_RDPMC_ALWAYS_ENABLE		= 2,
+};
+
 /*
  * Per register state.
  */
-- 
2.34.1


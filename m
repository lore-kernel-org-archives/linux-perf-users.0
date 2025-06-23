Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C42202990;
	Thu, 26 Jun 2025 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909372; cv=none; b=RXAqby7dbLlKQR8fR0YXOF5rUpOdM8tN002Ncu7qR2FmmgF0GKBQE8yut9yrvPLEnu3GZtd7ylLNNjruXYabzHxopTzThpqjd01yaRGGSigpPTNIVHhvOVHGnrZ14erqyGtCW0krwjbCdn6bsY8TIR+QedMi1pvDtXseHhLjJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909372; c=relaxed/simple;
	bh=VKPfahOKaxhI4DDzzLeX6uVPXG9eQOaTCSm/cBJ5NKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWgaJK3d3mPnpMwoKCdc8e4AMXtZ1pDZ04BjfQz0zq/3N0UCB8U8RXfTAl1nI1hBvJJ358ZFNKlxQQ1/JERtysMhSJXB2p4gc9B36d4y4kHVzuKYepSCXJaT1H3jZyI3nnDzrkPBcfqmtFzarvlcvPp9qOZtWZLMUsvDZJ45d/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeU54x2Z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeU54x2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750909371; x=1782445371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VKPfahOKaxhI4DDzzLeX6uVPXG9eQOaTCSm/cBJ5NKE=;
  b=LeU54x2Zcpm3fISelGERiq/YbduAbNN0tpU9Wn7IpBgYEQI2tk46AMvi
   aUIrcFsYAGdadu+FUs2BIkNcIqnKdQj5YnGZd/RAQ4d2KyPAq9b7H6Pvi
   qJe7yK65TpuLQ06naf2sezGKQqD2Ol7NWhVLRfdZiGuZxq5rh4hubzZwG
   4m1NQdARUDdZOsm+Q0rWLx1WtLckVaJ4F4LlRAGEJF9dhpDRhdtKP52u+
   669HvBrlEStDTR0buU4vsERiKuhENiKn/wSYs2OxGRxyB8xsD09nnHFE4
   uadOxaolcU50dqNwFow4Hb6ptY/acIE92AFgG7owLRoHJ3ESKZxXKuvPX
   A==;
X-CSE-ConnectionGUID: Pb9mNjnJStakgBwnDflaTg==
X-CSE-MsgGUID: PvigWsEZSdePomOHEkHdsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55820637"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="55820637"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:42:51 -0700
X-CSE-ConnectionGUID: yYpmQbmGQCCyYtmy6tO0Tw==
X-CSE-MsgGUID: v6vjCtTjTGyqhKvmHBfuHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="157894916"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa004.fm.intel.com with ESMTP; 25 Jun 2025 20:42:48 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 01/10] perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
Date: Mon, 23 Jun 2025 22:35:36 +0000
Message-ID: <20250623223546.112465-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
References: <20250623223546.112465-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use x86_pmu_drain_pebs static call to replace calling x86_pmu.drain_pebs
function pointer.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c2fb729c270e..df51c284cae4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3272,7 +3272,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
 		if (is_pebs_counter_event_group(event))
-			x86_pmu.drain_pebs(regs, &data);
+			static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		last_period = event->hw.last_period;
 
-- 
2.43.0


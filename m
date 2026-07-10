Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041523AFCF0;
	Fri, 10 Jul 2026 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666656; cv=none; b=Zqk2HeT32mS2LtwWKpsEeftBoPZjPcNMRa0Vm/C5GMG3qjOtA6HzY+s665OpwL89mfMNxmQX6Is5ph3MsIceE6nnMzDQDJqcMH6iUqz+K8dD6UWej1NShbQ/7hRAmV7vYB5ykXOaRuNhjJsuk4qdltSm4FevPgDqRxvYO2wiaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666656; c=relaxed/simple;
	bh=NOpvoV0D7XtZqO7wwvw/+SVas2ypaGFktFrbrTvP9OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zq8iHEN7l8I5bzfGkB+cLaHEfZ9jbInnyNgUa6slxuOBlzGNIaZpILUG25ZqDJXcxrhZfJJSr/maYCkGX9HgBetlhJyY4QRZtFccE9HHQyrfSaZX5SX4B0kUNxp3dU5xrT6Y9zn60KY52/AtrGb7RS73eIuw7zRhYBLQ1hKJoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAZ8nirQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAZ8nirQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666655; x=1815202655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOpvoV0D7XtZqO7wwvw/+SVas2ypaGFktFrbrTvP9OY=;
  b=NAZ8nirQcpsS7trcYGBAZSC5LvgZLO2oBAygpLP8uJ1b5IorAUrStsEz
   LZnIVe4Ej6rXOpiK5shu0ejOEgDEY7yB7Ag38fMnevknx5oAvhNm7Xjz2
   F97PajwHPymP3NBkSGu6YhqDhmitl+4hU2q6+C5Gs5duJV+El+aiKe2YB
   LpxdZnZIq83+nj2sTPAY+QWn+620/29veSFQflaL0UnO1KcrihgdwVTRc
   2RFttSDTPVuh4mQaQ/SeUGpx6Ts60iXCyjfuNAoLn9jiVGaNf9o3fxE+g
   3iDBCF9U6DInp45AC+qESz3/nW8x+0Gxwdpb27S6h2AjgnLBZgHyckVAX
   w==;
X-CSE-ConnectionGUID: ddktjPgMRxeNCsK7wcYLJg==
X-CSE-MsgGUID: yHdxyBWZSNqAJE+uFXg+rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554189"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554189"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:57:35 -0700
X-CSE-ConnectionGUID: UeLyRnJDST+MX6pYhCQe3w==
X-CSE-MsgGUID: saHZgZIjQcu/1pBBvQwPQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159162"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:31 -0700
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
Subject: [PATCH 1/7] perf/x86: Unregister PMI handler on PMU init failure
Date: Fri, 10 Jul 2026 14:51:22 +0800
Message-Id: <20260710065128.1799838-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an NMI handler leak in init_hw_perf_events(). When PMU
initialization fails after register_nmi_handler(), the error path
exits without calling unregister_nmi_handler(), leaving a stale
NMI_LOCAL "PMI" handler registered. Add the missing call before
clearing x86_pmu state.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index af0b67ffb43d..872d07a5fa80 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2219,7 +2219,7 @@ static int __init init_hw_perf_events(void)
 	err = cpuhp_setup_state(CPUHP_PERF_X86_PREPARE, "perf/x86:prepare",
 				x86_pmu_prepare_cpu, x86_pmu_dead_cpu);
 	if (err)
-		return err;
+		goto pmi_unregister;
 
 	err = cpuhp_setup_state(CPUHP_AP_PERF_X86_STARTING,
 				"perf/x86:starting", x86_pmu_starting_cpu,
@@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
 out:
 	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
+pmi_unregister:
+	unregister_nmi_handler(NMI_LOCAL, "PMI");
 out_bad_pmu:
 	memset(&x86_pmu, 0, sizeof(x86_pmu));
 	return err;
-- 
2.34.1


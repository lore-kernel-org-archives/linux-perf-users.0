Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163D2652BD;
	Fri, 19 Sep 2025 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248330; cv=none; b=hi6SN/i9nwsrk6PjkIX7w2BslMOM/66ktqSwQ/Hw79VmOG5TihDiN3hWsVBzJKhZhiq1vzfSQNfdwxguut/wN6rjwD4z8WLoOeYvgrOObbLIkf1XlYgfb7bGJGWpQP1aWQEJD5K8MlYry4fTU8ixwen2Y5o32x+RiWUCVsUHwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248330; c=relaxed/simple;
	bh=YCyw+MCUJeOwbPXfy98u/OedlbkyV/P1BIosFFp1ZOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mL+t3b4+6sKTEiZFDh2cOnF/6C0rCYmYUDcUq8jnXQRoZVq0Oh77em2vix/emNTmkKWbXTwiXiUGkXf7o/zikbXTdHCb2+sUY9GNLNYO2glCu7e1fe0DuOgZSaxD5jVznYDO1bE05U+fQ1ippo4MpGM5xuwQ0axJhJ1f+RxPDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=im8tz6KN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="im8tz6KN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248329; x=1789784329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YCyw+MCUJeOwbPXfy98u/OedlbkyV/P1BIosFFp1ZOY=;
  b=im8tz6KNgzxUF/UEqAIIx9vNNwQSmlgLypTmAj+Triqv7k76lEIeGnlR
   1XQGSQHhoXxQwkmJdUsLiFhtW06ACAIDmbAUqe600LOfvn/guiPnAY4Ef
   PupV6NAATKquFxN5YMn5E4sQbsxJbWjJKoQcMa+Jl3DlideRdE9+TIi9g
   D2vSjmZZJGY2lHlz9hjZt/GICk53CaacVYvx3K+HAGRDDUsZ7P7W9gEim
   70PgwTusvyBezb8SLLlxLZF+zuz8gBtXuQDq+W3bzDByPA07//RY+EkcS
   H0IIt6sAvXi0QE82Quq4MHw3W29GQMgwdyDibhHNB3+zw4U/g9aGioV1H
   g==;
X-CSE-ConnectionGUID: 5ydtPhR7SwaURCWXsZg7ig==
X-CSE-MsgGUID: pJga5NhCSnqx8nNyqa3NpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229145"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64229145"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:18:49 -0700
X-CSE-ConnectionGUID: UZbSKKBhQ3q8FzWgukufKA==
X-CSE-MsgGUID: bZr+X1nOShaYKWYozGmKlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175535620"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2025 19:18:46 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 4/6] perf tools: Add helper x86__is_intel_cpu()
Date: Fri, 19 Sep 2025 10:16:57 +0800
Message-Id: <20250919021659.1263351-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper x86__is_intel_cpu() to indicate if it's a x86 intel platform.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/env.c | 22 ++++++++++++++++++++++
 tools/perf/util/env.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index c8c248754621..f1626d2032cd 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -802,3 +802,25 @@ bool x86__is_amd_cpu(void)
 
 	return is_amd;
 }
+
+bool perf_env__is_x86_intel_cpu(struct perf_env *env)
+{
+	static int is_intel; /* 0: Uninitialized, 1: Yes, -1: No */
+
+	if (is_intel == 0)
+		is_intel = env->cpuid && strstarts(env->cpuid, "GenuineIntel") ? 1 : -1;
+
+	return is_intel >= 1 ? true : false;
+}
+
+bool x86__is_intel_cpu(void)
+{
+	struct perf_env env = { .total_mem = 0, };
+	bool is_intel;
+
+	perf_env__cpuid(&env);
+	is_intel = perf_env__is_x86_intel_cpu(&env);
+	perf_env__exit(&env);
+
+	return is_intel;
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index e00179787a34..9977b85523a8 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -201,5 +201,7 @@ void perf_env__find_br_cntr_info(struct perf_env *env,
 
 bool x86__is_amd_cpu(void);
 bool perf_env__is_x86_amd_cpu(struct perf_env *env);
+bool x86__is_intel_cpu(void);
+bool perf_env__is_x86_intel_cpu(struct perf_env *env);
 
 #endif /* __PERF_ENV_H */
-- 
2.34.1


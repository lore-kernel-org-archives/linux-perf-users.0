Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7C285C8C;
	Mon, 11 Aug 2025 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891825; cv=none; b=XIHTF/R71rDl90p3gHekpSspO6fK74JoOyeRv4vVPaxnimG0I6QP2kCz8hzDyF5MOR13d58R+Bx9L3Fsk2EpNRQijwog1Ks8DxUW3+iITw+MZkWiL90nQtLOaiPfAhB/mpZhk8KPW1zfX7HY8s5Nd/aMIhR/5g1QhqJL+s4PVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891825; c=relaxed/simple;
	bh=oeuugssJxxfYnDQBivTR+l6U2wpfEbwCtDf6j9CUFwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bNy3O0PWF1AQrYQjGQh9uGru5dD8dr1hJVko4RmOJqRzUIk5rQB3q87EaCYLACPT6Z7PWQI30HLoPFran9Vi431I6GWJ9ux3mpTwFoUhmJuv7F/NrsuD3QUeTChSBHSlr/Xj6KYMNZ97d9MH0xkoVIw8jzSF4TVH318/gky3Eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6yQEFE0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6yQEFE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754891824; x=1786427824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oeuugssJxxfYnDQBivTR+l6U2wpfEbwCtDf6j9CUFwQ=;
  b=a6yQEFE0FoYJNUlNhvwk88aiFRVu+Q7L8E6cu5nHkyV6lwwzdUI9efbi
   oXQvI7ZZPkw3YVecvXhwcZ/ZjxxylaNccFKY7MG1MehC47ow1WEBU4r41
   tPxu3sW6SrZiwvjCMDoh3+CXfZ7fa8fbsS+WViH9zom0ToedSgAKo97l2
   K0Mr38AOXgrgAYUxBiZEGYvOBnFT4Zp9rpC69w+T46kJx6+yTpJWhIem/
   Imh36hC9mJcsWIywJWnOI087xpTs1uFEESIzmGzJZ7VReYhul2pIfB6Dr
   oGCcsoCIbjeaZDITbf2nH92sp7YPGoVcibDw0lUYaXPLEZ2dGx1RdJDtr
   g==;
X-CSE-ConnectionGUID: wiPqMWqnQ6O/Pz1y+qwNSA==
X-CSE-MsgGUID: b2n3h2k+TbeiLC6O1Jfeig==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57043623"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57043623"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:57:04 -0700
X-CSE-ConnectionGUID: e8+7WmzhSViaO9NJznXg5w==
X-CSE-MsgGUID: VQsiCvJ2QCu+dz34AvhGBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171183760"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2025 22:57:01 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 4/6] perf tools: Add helper x86__is_intel_cpu()
Date: Mon, 11 Aug 2025 13:55:44 +0800
Message-Id: <20250811055546.296678-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper x86__is_intel_cpu() to indicate if it's a x86 intel platform.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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


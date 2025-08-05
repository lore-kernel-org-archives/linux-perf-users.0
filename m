Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16BD1419A9;
	Tue,  5 Aug 2025 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354861; cv=none; b=K7DcdMQPs2TPyh8LfxxGt95g08FxfXEhl8U0RfNtX2f/uLctWka//obN4FRiBo6P9p9VgRfS0cvG2BUQG4NHKEpEiLQtEyNZtERO0x/cVanDesDcRXA/+cMX4f9jnmkWZUeQsc7J0Uflw+i+2dbGNIMkvXDoO5V5+jT+Z+BI8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354861; c=relaxed/simple;
	bh=oeuugssJxxfYnDQBivTR+l6U2wpfEbwCtDf6j9CUFwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jaPRM1QdGVzCuKe7hg4s647fjmf2pkpQtOIfISpdHCfbKOMrL6FvtAbdQfc+M/CIJjyUglUbSTi1SCaAQp9oXeB1ULSVUpPx+CEgD4es6IaMsU6X376oJ9LsIb9YhjheQR9SABbYEdzggg8WPdOQP8NQ++oc8LZoz5jfvMiq2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfFDjYdZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfFDjYdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754354860; x=1785890860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oeuugssJxxfYnDQBivTR+l6U2wpfEbwCtDf6j9CUFwQ=;
  b=VfFDjYdZa79ji6gwMPidvLbXKaX5oSVtysnozUp6Lh1X9shjgeX9cBtt
   aJ0ZKhlWQ0iOGAi5PmO9TFAnDrL7IhNfArAwPNzykJp4nIw8lanxVk8PB
   1PhWNy//IBwbQJJ+tJt4kSIX5ib00uQd5TmJuzNs+F6uBXhHaMu7/1wAS
   7IZ2SCEFJrr44apOwNXjigCPwwauoeNrM8y3DAT1RrKyCyLarYPaJT5fh
   LmuKpUvMYlC/ax5L9yaiWYPrm/6dX1I0Yzi/YW92yxYsbcDVh4sZO2yPv
   Hp+IJqmn/GgblxAhqVaBOx4k2W7sg/HSt9BJVngdJvbR7rzBsSY7il2xC
   g==;
X-CSE-ConnectionGUID: iiE8PI67SF64Bnj5EvuVEg==
X-CSE-MsgGUID: R+V9obrqRJmjGKfzCKgbTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56523840"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="56523840"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:47:40 -0700
X-CSE-ConnectionGUID: b9tPrvM9TBuQwGxSu3FF7g==
X-CSE-MsgGUID: cGFrfzA1SVquE4YNsc4CuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169605458"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa004.fm.intel.com with ESMTP; 04 Aug 2025 17:47:37 -0700
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
	Kevin Tian <kevin.tian@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 3/5] perf tools: Add helper x86__is_intel_cpu()
Date: Tue,  5 Aug 2025 08:46:31 +0800
Message-Id: <20250805004633.135904-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
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


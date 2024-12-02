Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5E17C7CE;
	Mon,  2 Dec 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164117; cv=none; b=lUBlHW1aywlesDNn6aXRwPVv/mf0TWJF38mcGFvUqPV6NKBll1le1zca9CMb45USHfgDCMeUh89LPCKEGauGNnLKJek9ZvzZDrfXD1nsrGoqrxx6Me4COt2LyiUVxY161u97eenvxzMmZvICeVtvE2XKojUhlGlghC3tAGJ7TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164117; c=relaxed/simple;
	bh=OJJyk1FEEwO3mui+E9YAyMAY34U2B8d/7bsCtYORUxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BtzxveRY0gcvib9JNntG6bfwk1hNoaC4BTCtIa8DDA0PfVLVLVPQ6li2wyyzLh5tL5/52YFyvn3kvD9tBsMfubgmKshJjo6FRgjxbG2gx3XMJU4rHfdU82Ef8YIlvqrCOVf1A+orzj55WYpYHs5wUoJQIRSyHQJw2660DNise8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xampav+9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xampav+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733164116; x=1764700116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OJJyk1FEEwO3mui+E9YAyMAY34U2B8d/7bsCtYORUxM=;
  b=Xampav+9bNI3vSMPgdeDgulPd/V5IeY+YNDD8vZrnpUntxeGjUIGV9qI
   K+DZrwNSLijRsm7lPQa1HA8s36qJJR5wYnhYOAsdSm78326/fXWO1U4/g
   BQj5115UJ4XuN9NTGimC2JGYL2Zryt4+fVpUptQlwo7xjb7MT32ppr8tu
   P1J4rWIfw7lIYoRj8qrJKD6U9r/Kere9m4FYucMAi6s1Ey9N29u5z2ilX
   jeX4tFb2xff8kFy3qQyeT8WNQWB9cQ5iBzeEgAUHU6h15xjRrXpRHPySQ
   WeFJor9f4yJIcwS6/y1X7QxLi61SDEomfPCeZeRvPnVQZI9rLkYzuNrgE
   g==;
X-CSE-ConnectionGUID: kLArtikKTimpYiY2vAbxKA==
X-CSE-MsgGUID: 1JUNsRIcS/ihXCS4B0s8rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33409350"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33409350"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:28:35 -0800
X-CSE-ConnectionGUID: YPTsmHxzQfmpt9NNMSlPew==
X-CSE-MsgGUID: p8wmKMfOTqKFXeceUDbjNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93278767"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 02 Dec 2024 10:28:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 91DDD31C; Mon, 02 Dec 2024 20:28:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pref/x86/rapl: Remove unused function
Date: Mon,  2 Dec 2024 20:28:15 +0200
Message-ID: <20241202182815.639124-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_rapl_pmu_cpumask() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

  arch/x86/events/rapl.c:165:37: error: unused function 'get_rapl_pmu_cpumask' [-Werror,-Wunused-function]

Fix this by removing unused function.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Fixes: 9e9af8bbb5f9 ("perf/x86/rapl: Clean up cpumask and hotplug")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/events/rapl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a8defc813c36..3ed5ea2aa867 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -162,12 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
 					 topology_logical_die_id(cpu);
 }
 
-static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
-{
-	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
-					 topology_die_cpumask(cpu);
-}
-
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
 	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-- 
2.43.0.rc1.1336.g36b5255a03ac


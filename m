Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C5314D19;
	Fri, 12 Dec 2025 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573646; cv=none; b=GNX3VbDN4p4XyyQpiZqNnYoBSUB5fOj0jdXfXxPlDk4/5P+fO3lE/Gpz6b7OheWGSeyMej8EGsXSv/dgCYjDGgn3nE2ZUhlQ3mPhtdF4WeoucLSU35/dlhD8hOxstvy5MCnMkfNDI3RvRjkPaxA5Cz8PP+a938v3IJ5w37V6UX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573646; c=relaxed/simple;
	bh=VBqdy10pCk+nJaBK/fAok2/2dpjbD+/TS8WycG85t24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYFV7DUeYYdfuK10fSvbQlOrHQVC0eZEA6pvvk4vKMXSvzTLi5NxjD3Jg/a4bvD4oBuEI6Olr31CYcR5e+He7Fi/4tcrdhuNH4owaZ9M0luVL+t87bi7JLdioIZuNsRhF0DAQynelnDiZ0LD0Po6djlhrIU5nEnMYPJS3kL2me8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F42MdD7c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F42MdD7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765573645; x=1797109645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBqdy10pCk+nJaBK/fAok2/2dpjbD+/TS8WycG85t24=;
  b=F42MdD7cfe2W/7GUpwqX4xOhakHIxCisxrhvDu9V+2XPjf31Iq6oZWEI
   D5/FNRcyBEupNbCFF8j9x21PfFrpEo6y5DpBprEFqFAvULM2Enhaj9aug
   fEjGDZbNCgZbHxA1cNUeG+BTa+PvH7pCVBOc1k46L9YJHOX+QLzmtwRQL
   Icg8BWK0sBwkbxwwQcQF40/+zX3Mkz+eBZplWDTAIhekYVk/hdrfd6mL8
   HY4tkOyh0IA7PLG9qxQwILtXRwSfeHDzrNN1ZxDA51hS5Lmgwmn8etjyo
   4mYEmHRAeqRMesrLOREoRrqC/F115VnumUtYFoUffu4zowItWxAPKBefz
   g==;
X-CSE-ConnectionGUID: gkJlWTdDTwmQa1/HDHOq8w==
X-CSE-MsgGUID: 5aeG3tUaR/q+SnHNqJNu8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67333603"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="67333603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
X-CSE-ConnectionGUID: e3EY+N0qRA+neKyDUba7uQ==
X-CSE-MsgGUID: PNe21lXxSHG7/1Z3zYh89g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="202269537"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 13:07:17 -0800
From: Zide Chen <zide.chen@intel.com>
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH 7/7] perf pmu: Relax uncore wildcard matching to allow numeric suffix
Date: Fri, 12 Dec 2025 13:00:07 -0800
Message-ID: <20251212210007.13986-8-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212210007.13986-1-zide.chen@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diamond Rapids introduces two types of PCIe related uncore PMUs:
"uncore_pcie4_*" and "uncore_pcie6_*".

To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can match
and collect events from both PMU types, slightly relax the wildcard
matching logic in perf_pmu__match_wildcard().

This change allows a wildcard such as "pcie" to match PMU names that
include a numeric suffix, such as "pcie4_*" and "pcie6_*".

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/perf/util/pmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3d1f975e8db9..00cb72615621 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -905,6 +905,7 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
 {
 	const char *p, *suffix;
 	bool has_hex = false;
+	bool has_underscore = false;
 	size_t tok_len = strlen(tok);
 
 	/* Check start of pmu_name for equality. */
@@ -915,13 +916,14 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
 	if (*p == 0)
 		return true;
 
-	if (*p == '_') {
-		++p;
-		++suffix;
-	}
-
-	/* Ensure we end in a number */
+	/* Ensure we end in a number or a mix of number and "_". */
 	while (1) {
+		if (!has_underscore && (*p == '_')) {
+			has_underscore = true;
+			++p;
+			++suffix;
+		}
+
 		if (!isxdigit(*p))
 			return false;
 		if (!has_hex)
-- 
2.52.0


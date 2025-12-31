Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B0310762;
	Wed, 31 Dec 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767221389; cv=none; b=X9paDY0Wz1fWCsojM6AIDFjbsMaupyq/saRdQmtgvmR+ztSKN8WYrcDJ5gOEyN9nBgWKeaDV11U+8bC2yY3jas9vsn5QWuBQHjGZLdOljtSMZ084zewhgskgkjTujm4VjLNhqtS027xZ+cn8JPLnRTilaP77RIjrDdJOdDGRJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767221389; c=relaxed/simple;
	bh=TX6fzdQsUb6ZP00cCyRfjO08nNxstnxqBhxkoMh1vnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/UVJI7NzaRZRm6hJdHcrP03wgPuE1m4TTGL3HZAuNNQoxC2qPusjY7cvMiTO7kmCFMP3jD9FHtFRmIxlc7gtOkTj5cfj3euyAuhH/Phuau6DRjMxwLtaizwFdIkVfZlJcmagvof2gVABONRahj93GFPbbxGQT1zZhVoJe61XwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMK/LmbI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMK/LmbI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767221387; x=1798757387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TX6fzdQsUb6ZP00cCyRfjO08nNxstnxqBhxkoMh1vnI=;
  b=MMK/LmbIJV4/1rizLRjKJdeWO/eZ8SkrHWg5BM42744iVHfFqqbp9QM6
   aI7XTGNOCjnzTwpMdxmfF9Wszgdgk7iAEIkZKUMcesXw3qp0HkjswYZ7r
   WTHbw57G0q2Lxjs42UCRLCq6i/fps341se1zCsX/6PXg1p1xgTZhiydnM
   uCODvlVe4xatZUcHbWsD6l+e7pl1RygBO6fnPQHAVsf3yeiZMBke7XQnn
   /wFDo3JmiGETYK+q4V0p3HtguZxvVwGI/3+hfV/wXcuXxJ1T2+rzuQKuJ
   cMhPrAtwXcEqyAYKqpNhjjhlyohR55XNz/b5AYKZ9AOOEKEAt++o8DdFx
   w==;
X-CSE-ConnectionGUID: OZKQs7rHS7G1NQSNNMUNrw==
X-CSE-MsgGUID: YWPxTVF8TFuAUo0t7b/PLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68816654"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68816654"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:42 -0800
X-CSE-ConnectionGUID: caigQKaJQ8i8nV+oYcvJkA==
X-CSE-MsgGUID: VeaOIuhGQQ+ff07OUT1yMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="232611034"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 14:49:42 -0800
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
Subject: [PATCH V2 11/13] perf pmu: Relax uncore wildcard matching to allow numeric suffix
Date: Wed, 31 Dec 2025 14:42:28 -0800
Message-ID: <20251231224233.113839-12-zide.chen@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251231224233.113839-1-zide.chen@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/perf/util/pmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 956ea273c2c7..01a21b6aa031 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
 {
 	const char *p, *suffix;
 	bool has_hex = false;
+	bool has_underscore = false;
 	size_t tok_len = strlen(tok);
 
 	/* Check start of pmu_name for equality. */
@@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const char *pmu_name, const char *tok)
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


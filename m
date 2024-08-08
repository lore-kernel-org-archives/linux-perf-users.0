Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886F13E032;
	Thu,  8 Aug 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145574; cv=none; b=Oo2q6DSEbwR9PZ1AxevpTsHUkHq7YfP4jW0ThScpIujvsBxBj1/fHH+seSyOFB0EXgC8WJZ4zCB5E4Kh1wOSzOBlqE5pfGmXE5XwN78fr9VUnb3mCyOnGAxAKjIlKb6Pv+zGFJFljTnnqEAHWkEdhVUhhIxGnQYhKA7dQm98hYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145574; c=relaxed/simple;
	bh=7pLKnvHMK8oM3IFZf3l13sipR+dirpfsjlql8/Wn4yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WO12u6abuBHRwEoyIcKVf8juihKI1/Pse3lj/kbNY9AS4s+79IXQWn4eA9R//VJ3CxG42joQ5pM8RHU9845Zdnm9Bo14FaoRk452Ppyj8aZtDK/tTAPzJ5YZXZTZKjMZnGlD/ffBslpekXXHTZoY3u916a8jp+wjFF4r+RkcS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTGfAEkK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTGfAEkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723145574; x=1754681574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7pLKnvHMK8oM3IFZf3l13sipR+dirpfsjlql8/Wn4yY=;
  b=mTGfAEkKfLvfN5O+39Vu2iRXqFaw6s7bXwQOSfMobzN278vOZId+bRfJ
   eRLTYVMeOAkzKXYu64H7HKYIyzerqrs/aJpELWFYxvaNZekzYMAk39tZa
   uLS+xOpWWe6qlkhdpxdN0yPp8FZSoPFsN54s0eAv779n67ssL9rE6Ffj/
   WkyBHea6gJjH2QglREq34xkO+6MJrimSqvzCzAqLriwQW8R+UDs1Lhf5/
   vnlFpvRnSb4qzmPlk+W9WSoRrpq2Gyn2hqUoR3l7kpLWXtuGiuVim/AgR
   6h95azCa9UD3HKrXBBf2o75WIhqmfcnkHXYWn8WG5nSTwkgcp+6zPDljT
   Q==;
X-CSE-ConnectionGUID: 2AVDn2nCR8m0d1zRkqd9uA==
X-CSE-MsgGUID: MQwiHj5NQgarAptoiWNdSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25091695"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25091695"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 12:32:51 -0700
X-CSE-ConnectionGUID: 0P5NfmMhQOy42S/V4Ee93w==
X-CSE-MsgGUID: 92jxCo34S6e1OcKVzLO5NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57402581"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 12:32:51 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/9] perf report: Remove the first overflow check for branch counters
Date: Thu,  8 Aug 2024 12:33:17 -0700
Message-Id: <20240808193324.2027665-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240808193324.2027665-1-kan.liang@linux.intel.com>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

A false overflow warning is triggered if a sample doesn't have any LBRs
recorded and the branch counters feature is enabled.

The current code does OVERFLOW_CHECK_u64() at the very beginning when
reading the information of branch counters. It assumes that there is at
least one LBR in the PEBS record. But it is a valid case that 0 LBR is
recorded especially in a high context switch.

Remove the OVERFLOW_CHECK_u64(). The later OVERFLOW_CHECK() should be
good enough to check the overflow when reading the information of the
branch counters.

Fixes: 9fbb4b02302b ("perf tools: Add branch counter knob")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d607056b73c9..f22f402d54cc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2884,8 +2884,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 
 		if (evsel__has_branch_counters(evsel)) {
-			OVERFLOW_CHECK_u64(array);
-
 			data->branch_stack_cntr = (u64 *)array;
 			sz = data->branch_stack->nr * sizeof(u64);
 
-- 
2.38.1


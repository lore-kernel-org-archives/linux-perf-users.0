Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B151A0AFB;
	Tue, 13 Aug 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564900; cv=none; b=DQ902Yu3sgZIVYWpqQQFg0B37N5ECeTGmZQHS1ZAxAa1cfDse4XL9us48zXNbRli9kdJ96k6qRkyYCWFWH4GV2ESLaPhhEuFhjrrDRurJq7qCpqKGL8KDUC/6PKW+6/r4umgJnByZel7d7+PKM5hipOf3JhDVp9u91USLYzMtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564900; c=relaxed/simple;
	bh=FDjqNGvQWk2iGBvMXFfIW/8LAWoDEIsvar4aK8Z6710=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/OtkD8bOLnh7cyUz/+ss5qriimSAbNVpJFTie0M8uFZiae5BIvYQkl5aypbZV64SMrkVSJWgg72FGvWAdBteLTR3RQxGAGBWos9YHIf2BA7ieKfFehWxI8YIcf4GT8F8EC+HJDAfqLvj6AOREqCStEwKYqTT8o8H3TrkmqRGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3SIjKEM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3SIjKEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723564899; x=1755100899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FDjqNGvQWk2iGBvMXFfIW/8LAWoDEIsvar4aK8Z6710=;
  b=A3SIjKEMnG6fdYgM98+FGlQHj9bidKbcfJoq8uaAFKL8fs5sA4n6j/vL
   Qdk8x0Ol5oBLGTWr0QqLACGuS79f4J2ToFkP8SaRTmv6hwKivIAzNWnr/
   DpYU9OknCBccpe/sWerVB7QO9qGVQxOK9rDSeq/m9dOSWhqLgmVylBy+n
   8FaHOgmEnonEymBZoy4ULD54GkVmLBj3/phe9/lp7Oiwl2srOj7tTKTL/
   2TeSbVTGVHGdLGJuNV+LmWLKOHpJJQqtc685Q5Cc+X1KR1tzw+vw2UMkP
   5BKj1YxcUIomoKIeZKcQa6O9KGL4PrHLcswBYd4r1KpQ2qBg3dK4zM7fT
   g==;
X-CSE-ConnectionGUID: 5XkOPQEuQFycb6DcZbFLSA==
X-CSE-MsgGUID: wM1OgvvBQZafRO0GUKgcVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21383203"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21383203"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 09:01:36 -0700
X-CSE-ConnectionGUID: 04XYeosvQ9Ovfc6/eRseTQ==
X-CSE-MsgGUID: bzAvRzlkSMG4o8nNdChdYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59479741"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 09:01:36 -0700
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
Subject: [PATCH V3 2/9] perf report: Remove the first overflow check for branch counters
Date: Tue, 13 Aug 2024 09:02:01 -0700
Message-Id: <20240813160208.2493643-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240813160208.2493643-1-kan.liang@linux.intel.com>
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
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
Reviewed-by: Andi Kleen <ak@linux.intel.com>
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


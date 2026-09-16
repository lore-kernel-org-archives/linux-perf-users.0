Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057BE58038A;
	Wed, 16 Sep 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576322; cv=none; b=F3PBwCy2rGsA9nYvS8d9qi8POeBhXq2ULQkPXzZLYX9zf1mBVD65prgje8zWTaPMuvquJBGGm9EFfA4ZAxkdPZX+gi+DAd+X+RCBwCPrsAvxJEPNENfIPAdRP/iSxD7TfRiR+QtAv5xvx5TrArUg8iaVU3G2VJG0M1g4S7iCCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576322; c=relaxed/simple;
	bh=61Cbk8gWAylO7hZbbTWJcmxc7IPxOUBDw4qLi05zMv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgWqYLnlrSu8RQyhYfDOFU2wDIy66abHaFgNFpYRxGt9cFlN67NjP0Km/uEioqG/emdmokZ4TO0etvAP+MLBS2cYEgm5RdGLyo/s4dJsueb95iGOoFKE0g8CksNqMLFCNtxj83OzGxHNs5Jv5Y1J2two7nAYSKGQhIDa5cIuEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCtW2sZO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCtW2sZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789576311; x=1821112311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=61Cbk8gWAylO7hZbbTWJcmxc7IPxOUBDw4qLi05zMv0=;
  b=SCtW2sZOMzYcvJ7FN7SQNpuXh4+DHTlFkKR09RkW46BIKJyTmlaAB1bT
   zsLapSyCc42H90pCM4yUmoFbUed4B4fLkRtPJfhjg5ucHotOuJDSXzXUh
   5eVUeYHaUX5FGfNmaaZlhK5MA5dEnIAYs5LPjfbmluU/uxv1BlOVlOE8I
   r6OgQHekYiq8hyQ0leuZJLECDmLedpG8cXuFzWX6kFxp2rh9LCYVJEIP5
   P5+L4D5OkAjbUcB7eLtoGCuFRykX26+74CUA5VjCdW6bVtgWbfyENPxtH
   dlyPSqPH4J8RvM33ntqmJqCGojGeQTB05++Q2NWCUHctNQnRBYsTcL9qG
   Q==;
X-CSE-ConnectionGUID: YFfo+nfkRU6pPYjIVPcyEA==
X-CSE-MsgGUID: qEH5VL4/TSmcfqXzIa+/Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90093396"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90093396"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:31:47 -0700
X-CSE-ConnectionGUID: 9rAskK/HQUKHJdnkoKmKQw==
X-CSE-MsgGUID: u20xWZxdQouf30jdvMFYZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273363821"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:31:45 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v10 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Wed, 16 Sep 2026 11:31:22 -0500
Message-ID: <20260916163127.318885-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916163127.318885-1-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

This issue was detected by sashiko during an internal code review.

Assisted-by: Sashiko:gemini-3.1-pro-preview
Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/mem-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0b49fce251fc..4e490f9cd348 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 	i += scnprintf(out, sz, "|OP ");
 	i += perf_mem__op_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|LVL ");
-	i += perf_mem__lvl_scnprintf(out + i, sz, mem_info);
+	i += perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|SNP ");
 	i += perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|TLB ");
-- 
2.43.0


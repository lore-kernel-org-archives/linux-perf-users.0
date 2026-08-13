Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0425771
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657314; cv=none; b=Np4PREh2+sIMQ1BcvdA1qv85g1biNrbhrKVJRz5dwKDjQqV0IynDb3LYCrtGinx6CLUkbK9DCQsk5pv7ez0bY+ptUV0CJanfmsOJHUwsomgqRIQqsBdBoFHH5tc2Zwh5MBOeYOueU8kEa8J5n0IFv0Q8kuh8DB5Hm3pmKy1ymyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657314; c=relaxed/simple;
	bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs6Oyn0pCor+e99nGCD9c4QsHIXDhXz9CdZceNnOLqrkHEI28G8/d6FF/mt+LNX5/+BGuK3XKPS7DcpIB4m0sge3bmj1LfVyKZCZGA6tnhHaKfMwDJRAeb38RzIwMNLMb9Ra1m9YL2At6cmi7c8uFclAtlNtEfvYIm9lqjvMZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxfpLVHb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxfpLVHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786657312; x=1818193312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
  b=YxfpLVHbLRuEq37xFLfpNGpMHTYHTPBdB92pMGoSnQL4xquulszU2PZk
   bmC0UUBwE6ZfrwU8KDIFAi2eVjg8lXxZHgfu9LSUK0Reh72C+PRUUgdlo
   LIg0aGSSvbN9NwqSIaYM6pvSS+k4ratPgBs5BCx65iCvnaD9lPILf4dHD
   EfI9XG+BV84HAj4nuzShVnVEcUHaODzLdSSJ9tvk2/t5Z7vzltoI6pZxW
   OojFFNDGiUICgwPFOtDj6Lh5rcZBZrW15yO7NhVtFNipBWlKy1h0PnCl7
   ustK/kGwX5ykfKb3mOIjAS1icNMp3i+BfHC0SWrXosy+olK9dBLdGcfak
   g==;
X-CSE-ConnectionGUID: JXlCY9WKTMeDYPDEwcnRCg==
X-CSE-MsgGUID: 2oA5CiGdSbCbZEt2YRS2pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89761873"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="89761873"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:49 -0700
X-CSE-ConnectionGUID: BJHg696sSSKJ7w5B5ocDhQ==
X-CSE-MsgGUID: GhSxcv1PQGaoJtSUx7eDww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="267909910"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 14:41:50 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 2/4] perf tools top: Add --weight option
Date: Thu, 13 Aug 2026 14:40:57 -0700
Message-ID: <20260813214143.253418-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813214143.253418-1-ak@linux.intel.com>
References: <20260813214143.253418-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a -W/--weight option to perf top to collect weights too. Useful with
follow on patches.

Assisted-by: omp:GPT-5.6-Luna
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-top.txt | 6 ++++++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index af3e4230c72f..2da2a16bbf26 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -25,6 +25,12 @@ OPTIONS
 --count=<count>::
 	Event period to sample.
 
+-W::
+--weight::
+Enable weighted sampling. One or more additional weights can be recorded per sample
+and can be displayed with the weight, weight2, weight3 and local_weight sort keys.
+Possible uses for weights are memory or instruction retirement latencies.
+
 -C <cpu-list>::
 --cpu=<cpu>::
 Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 570410599f1b..2888ac3b7b92 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1493,6 +1493,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
 		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
+	OPT_BOOLEAN('W', "weight", &opts->sample_weight,
+		    "sample by weight (on special events only)"),
 	OPT_STRING('p', "pid", &target->pid, "pid",
 		    "profile events on existing process id"),
 	OPT_STRING('t', "tid", &target->tid, "tid",
-- 
2.55.0


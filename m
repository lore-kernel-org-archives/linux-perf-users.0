Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45935192B75
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788118513; cv=none; b=fo56lviynWvbyhWhXb8vcMdZd4i1FP6oPfsi6ulEZmmdfqWr3M5I1jn21+ARrcs28KU2DftPegCRutVxkw1AXcZ6W8OqtmdU7v7mJmimvAICLzw/K3Jp2WR28O8NNSSfdSFBBIN9qgfI48BrQgF1eQYbITBXSoD6ovfdFNJ7r7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788118513; c=relaxed/simple;
	bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGBmjTlXKfAlBait6AWA7OKQAzZ4qmB7vdOsspnbDSaRd72T4tq0W01VdCmB77FFYwVbTOs0iLkUhaxISr1oRiHgkSGSu8vWyw4vtr2wyME0DhNQa7xz8aezBXDqW8OKLqAGWW4Trx1YuIjBKxd5wFoC3z/Em7tu3h74hWnGKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFvHvC2B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFvHvC2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788118512; x=1819654512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wgz9ttw+P9cRA8Csd2hTJOvx98uIuT5zF8yBYalng/Q=;
  b=NFvHvC2B+OS48sBdAr6nMN01lgXNmolf6X72HnH6Y+vEyvC6W7zqmpUg
   dNfoqrJGj+IRw1RdK+q1xsDKMNJdvfoKkCrKEJogfqDGpM59us6f5e5jd
   cbqAmQfU8JGP+SpIQBvEU0Zop3P67VpM2ckKCxlbI3iRthGWP1VSYYdSY
   VHOdj6GwrCGK4Hshnr1GEqC99p4v9WLxLqGA8uLfNEGvs43pf6DIBKdXG
   9ZV3RPWvvJlOx4QElMqZkbxQohg4z124pp1GR7VAIwnZaj9W2hAks1e+7
   vgopN+pu0kJm8cQlPaaPkt3j3sPoiyaoIuWHa6q73m2a821nIofUtvMRf
   A==;
X-CSE-ConnectionGUID: EYHRm992SOST7mj3AMjPeg==
X-CSE-MsgGUID: Giz5D6u3RBGY06IAKGU1zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87667336"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="87667336"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:08 -0700
X-CSE-ConnectionGUID: 5y7Fwp93Q9C3Q5AKJd8fsA==
X-CSE-MsgGUID: 4+TDOGa8SvmiHxL7HTkHRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="292118655"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:07 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 2/4] perf tools top: Add --weight option
Date: Sun, 30 Aug 2026 12:34:38 -0700
Message-ID: <20260830193459.2840519-3-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830193459.2840519-1-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
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


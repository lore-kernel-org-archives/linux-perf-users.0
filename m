Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CA1F0995;
	Tue, 14 Jul 2026 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989852; cv=none; b=aFH0hyTtR//NyKYssNExLraUBU6gIRHJ8pJwuXlSWGzEWx1iaE5fqx+4SHnMuMkrQbtNZB73Je4vZy3TqUpdcIAksXpuU6rSu17feZOUxtW5eHlDK78JnB90qT+drfUMS3GhUPBZTOExpHj+me2K7cvAvuHYGZtLyrBvTv9F9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989852; c=relaxed/simple;
	bh=7K+mVOAfd7O7mBrvuCC+ocZBM74EZhw605+3UoxF3Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfWpiblyXqLW0y+mbSBUFa9oLrhMzhDtJdtEF2mlf1Hsd/kLhYGrXggfZpHolemcWPMdC2ebloJfzHdsbBY+3m04O+p/jv/M/rIGsWKaNPidk9GbF3XdZOX+rZ5UwYHe1kZ8Dpe9oSlRvap5b4Rnmf7+rNgBP95O+KfKs58Pbv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eb+JFn7g; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eb+JFn7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783989850; x=1815525850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7K+mVOAfd7O7mBrvuCC+ocZBM74EZhw605+3UoxF3Sg=;
  b=Eb+JFn7g/I3URuOTvI8fQEIqpPxmtk+g4UEhcfhYMVjTsValX7h7+B9m
   T2IFWT59ZX7QATchiGi1/ghG046z4LBcEr4kuBbk2aI7XYoJ2l6RC4aC8
   Ocp/1/SZQUBlBpGP4gVC4Ao45NIgyv3Z06f3Ns4XBSyWcuQXAjOFQiacv
   V7ma9gcqegPwPN73mdDpIKRGMXbXGz/EvWbXABYn8lfiX6kb7XkMIB1GQ
   hIG3O3XTrpG958XFr3zbHU9y9cnbCbYZTJU1UV6uTDVv9af1B8jdaV9Ie
   eldaIgdJREVo5835yNvFcoaXP1EJmdM5BWvGeCsFPkmKJZT3/iVUAY8VT
   Q==;
X-CSE-ConnectionGUID: I65hdH9MR7SjXbqW14Khfw==
X-CSE-MsgGUID: BFsOsyUiRI2o498vUSI8Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72130633"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72130633"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:10 -0700
X-CSE-ConnectionGUID: 6phinN0KSYSqEIXX3odJcg==
X-CSE-MsgGUID: 4ZyhoFBHTneRZsWvhqCSZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260582114"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.48])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:09 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Mon, 13 Jul 2026 19:43:54 -0500
Message-ID: <20260714004359.179451-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714004359.179451-1-thomas.falcon@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
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


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D233EC2F8;
	Wed, 23 Sep 2026 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183363; cv=none; b=B4e0SnW+m7ffJE/rf+ycaq6L2kKrSoCkfakhjfmOksAPbASGp96iJTuLE+uXlWeIm584tGqGCiW9nnfuptLtyCUfRE7j8Yk0dOVM/upn83IN7EaCL0vmZ5vKBS/SZ5kSjg4PJtqSa50j2BlpuZi/AFUS+LyiIVKthliWcIzSlHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183363; c=relaxed/simple;
	bh=61Cbk8gWAylO7hZbbTWJcmxc7IPxOUBDw4qLi05zMv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSWuV9yD/tNqwCcyf7njXhH1GJ5gMZl+EMkyYaVxoSwLA0g0cT5WR/IULEYAjYRh+p7WSaVwHegcQW3+1OSJWn4TGS6nFR9XM9MtMuP5if2IFkqDNaRMr1WqQFGp/mdZD2FokUMrtKiBk3BHz/zw70Wec/lPlkrpontrxMDmfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQ91g0zv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQ91g0zv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790183358; x=1821719358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=61Cbk8gWAylO7hZbbTWJcmxc7IPxOUBDw4qLi05zMv0=;
  b=EQ91g0zvm8wuRveLhK09AdBA5kneYJmfavJc9MByVYfrC+SYsUcZWgh7
   tUW74wlIgN6q4EsE+vbYB7IrDVqlGMHWV1FquDQuw8yEhYoNdoB+zTKEW
   vjhMvLZKaIClLZwOdez7JC7f6s5+UnVnE6eyvT8OcLJxQ981YDuyiQ9NJ
   7PUKxPbYvPE9PGLBUgr8Wem2k+H07n0XrKBeyAbMMf9pGU/JW74VSo3oX
   +jctS6J+k6lgwsDsaKPnfDUKNZ/N5/++QcDC9nQIe/cMN/FH5ZyFBdj1Y
   NfUBGa0kkD1FKdLnI4+0M1BeDCBHZkNuTsIScNWNpti4GL0YEyffSHdWE
   g==;
X-CSE-ConnectionGUID: lE3/C3jLSF2uYYGmyCXebw==
X-CSE-MsgGUID: +qBYK4gwSme1RYR6levYbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89820259"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="89820259"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:09:16 -0700
X-CSE-ConnectionGUID: 8LntGDbdTvy+GA+k9rxRew==
X-CSE-MsgGUID: xey6fpiBRymW8JfAdk+emQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="301631613"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:09:15 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: sashiko-bot@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v12 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Wed, 23 Sep 2026 12:08:58 -0500
Message-ID: <20260923170903.48388-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923170903.48388-1-thomas.falcon@intel.com>
References: <20260923161043.95C171F000FF@smtp.kernel.org>
 <20260923170903.48388-1-thomas.falcon@intel.com>
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


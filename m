Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4386D39E191;
	Mon,  3 Aug 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789958; cv=none; b=JT3YHDy2KkulfURmFz/VkdmRGWVgGtm0TqyEESWPLIOJspPtEKNlGJhdYNNph/NDbWwbxvvNx6O1DI8RycCuww1+f+UkblJBb0/x3MaTAKjk1kGyNtJ2nebiTUekR2VSH+BPLvsfuOFpvMp/phWgYRuTtqEE8BXze5j3tz7VOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789958; c=relaxed/simple;
	bh=B4MuTUdhC3EllZcVqMauZHoRywzHrlzMHRYm5m56Tlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT2xhQmJH+eJjVkU/dR4L6OkGm/l5KN+xcrQLSwQDjr4hmWAaoBUfAGaKTEIHz+sis0lRwtr/6xeAm7jIfi1QaBfWFfXJRAyFLm75J8qOwEBTaH3f1Ru7CpJ0WCYwm16qlfMHjee4+YHkTWmSqFDxzjvqXsX5pMtetcRG7ODQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGJopVXb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGJopVXb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785789957; x=1817325957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4MuTUdhC3EllZcVqMauZHoRywzHrlzMHRYm5m56Tlw=;
  b=XGJopVXb6N94jWrZ1h3VrI+fmVSz8SM9QawNbPUztSshEifMkF79FpW7
   M2Siqs0DaAOc89o5Myh79vB+NIKDhKUabacIwhLDyTWHpyNSgYTFUV9UM
   PjAUBP59TrWo7la1LZXzg4HyYFH7HvXiXGiQ1TYlyyGSZqCrRF/iXJbvV
   vTbYP8YlSVUVLCW90eQnu1SE/mkwRrxzu/9G6H2gX0GvVhjS9RrMnNebx
   mK6GuSfHqLFaVk+G+AU7CjQPUyQsyjEpAj4ldwrOas3eES7Fa55TxzI/c
   2qNsE7YYkC9WWuH6x1YSzp8rOxprUIkDuQNgGWCBFWTmVRaJ7Jw9ejss7
   g==;
X-CSE-ConnectionGUID: C0QhpbdkTn2WLD/FvpgNog==
X-CSE-MsgGUID: ltWMWXzJSV6X50RCXpsdfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96927254"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="96927254"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:45:57 -0700
X-CSE-ConnectionGUID: K2WEcsM8TPOWXrXX4pDqJw==
X-CSE-MsgGUID: E2rGFutgTUCQG8wRup5jyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="284702350"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:45:55 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v3 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Mon,  3 Aug 2026 15:45:35 -0500
Message-ID: <20260803204540.100348-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803204540.100348-1-thomas.falcon@intel.com>
References: <20260803204540.100348-1-thomas.falcon@intel.com>
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
2.55.0


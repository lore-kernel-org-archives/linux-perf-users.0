Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5935057ED81;
	Wed,  9 Sep 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969754; cv=none; b=flsYP2o3D4xu/ubjEyMnWp44DIOL6WxHRN5BtZlA1SDwbCEvIAMGPLZt/DvHXHWQkCJHRtIJv0JCezOA1mK+ra0OWWxy8cBUG9TGJBogdfGd8Eg7MbLgwHe7E18mC28lIwriSV/RpNSUD/+37ReGwtTHgySVHrQxBJ1OL4h1mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969754; c=relaxed/simple;
	bh=mLejFowYm2X6VHgkPdi17Jgt/N1ot0OaV91zeWDUK4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEihr1JBcrt+gduxUY74omzmwsDtTqbGQQRncrYrfBxWyQ3UhBhXALXltZAiQJrf9nCmZtIlbCPu2ozmO6s3EnongKRCjBatDLOkmYtia4pYudIetvvPZKO5JoTJZeuPa8Ck3NCbjIskHZgKPq2XYKmbrg0SdsLmEyxet5o2z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hm8pJMjL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hm8pJMjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788969754; x=1820505754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mLejFowYm2X6VHgkPdi17Jgt/N1ot0OaV91zeWDUK4M=;
  b=Hm8pJMjLXnDkkJl4CJosuoLVrXI7w1c3JLZhICSQA5vPqj8oOIW5lg9i
   VF1ySE7X1tWZG5TyvWXLvuI3ILjUVv9nMe9AYGsbw/yegzlVQmJANsy8R
   oBfoGe3qF/u2L2TV3Ju7Y7Ac2f2IuoHqmoiIvwCHHOp8TqG9SLCDL0hmU
   Mq3/4dsxJIfIAtrqIxkOsqvdVG26zj/zFSOY9qG01zn/rZT/GCkMpn+2a
   Nq4xXML/QpRGliAzEnqLF53z2G8QzNX9S+cIFEuOKMBWpFTcRwynhVmfB
   +Vh3R2i07DveeLY/pVqKladptJRsvEbuUJBvnogodNZbnwekkZazf4NG+
   w==;
X-CSE-ConnectionGUID: f1COMEP+TBedVLV3zgnnVQ==
X-CSE-MsgGUID: udRbnjVUQ+qYvnJCLoNd0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100564463"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100564463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:02:32 -0700
X-CSE-ConnectionGUID: s65PrPKXSyuR0H3l2Mq1Og==
X-CSE-MsgGUID: o0rZ4AHsTRWpgT9uPYslZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="267072934"
Received: from iweiny-desk3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.48])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:02:31 -0700
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
Subject: [PATCH v7 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Wed,  9 Sep 2026 11:02:13 -0500
Message-ID: <20260909160218.174928-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909160218.174928-1-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
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


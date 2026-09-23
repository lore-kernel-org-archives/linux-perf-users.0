Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735B535FCC;
	Wed, 23 Sep 2026 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179034; cv=none; b=MugJbBSL4apnBwwppciTf2WZROSlq/V8nA1L0MSJ5J0qIQauM0IHlyjdSsMQ+SpeCOft+RfA0yVJzwR2rdJn3qBEcHTFNq6ybxEiZ+rHMY2QoG50+KUpVsvS2hWFLJALzn7MnaQTFFlQtBV5uPigkRtos8w+nrkHHdb9OvUeGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179034; c=relaxed/simple;
	bh=61Cbk8gWAylO7hZbbTWJcmxc7IPxOUBDw4qLi05zMv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NV1rR32NhAlMPLZ2wHZPHCASDEX6TNXdVNO4L6N7UxPM/J3AzuMsKu9SFBi1k0ZRik1sL4+9VBwssOlW+pKj01aixFenmURPeFcVbYqKTAgnPoE2exlbWkpQH5yhQuYUzVFKv5EdR760/b6cjYmRcp9/DgqQbyk/bMbIdFORWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQDjQAgi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQDjQAgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790179031; x=1821715031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=61Cbk8gWAylO7hZbbTWJcmxc7IPxOUBDw4qLi05zMv0=;
  b=IQDjQAgiV9GZrdI6fL4VpOAhJ6lzUT+ofjgzqZdJZfeJtybKNxduyMPj
   hByDQ+CkpdVmTada+wbkBjcst4lESzATXfFhHyU+MwjVBDYI+qGGDUn5S
   izMct80Rt4Gli222oBPqIUkAxuSRWCo8yvAISus+JmQ4zi7C9gBKRRCd5
   KWROK/0eKS/FiUsou+sdSgoQKUf1mwxnhKt5Jk08ZRydtVZlGcdPqZvcW
   GeoSvdqpD33EaHgLq3UuDL/dg5aZCIUnIahgRYwqiWypjvfm4vLyv85d+
   BpLoshuNm1wxu7hL0TjJdYYyf8tcunU9+0LM4ymwY5UOEat12MjPRkfnK
   Q==;
X-CSE-ConnectionGUID: xyKrwinkQB+9iSCjl6yIoQ==
X-CSE-MsgGUID: iJqtPQQVTmqV2j9Jw2X8nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78445927"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78445927"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:10 -0700
X-CSE-ConnectionGUID: NuCw23jXTtydLB9t6+aY4w==
X-CSE-MsgGUID: OnrXhBeHQvaFjqeerHIIZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4935303"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:09 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v11 1/6] perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
Date: Wed, 23 Sep 2026 10:56:58 -0500
Message-ID: <20260923155703.34814-2-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923155703.34814-1-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
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


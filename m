Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC753D0D7;
	Wed, 23 Sep 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179042; cv=none; b=Jh2pxMr+9geomRO6C0UkD4U71YGhWebA0a4njowKuj/jBgQ7Acqd7AZcIXi1GpGLIbCWjEQ+2iRTbmXel1ktCbzSFMQRU6S+NlQMKrLthhTSPqA0szSCdr7BYwEzwrsfNZ/elMfZCpD5Df4UF7SCrslRwWjbc2+fESxZ5GOzAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179042; c=relaxed/simple;
	bh=Z/w/kI/X4tXR/s2nUyxfG2V8PK+h36DMzF53LKcUUqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCohl5G7q0uE0GGRO8drv75qQbsSFACWCDa1tWzxS3V7YQ9TgxCQoyx6J6GwYOLgfSo7FaPqkjD90Gbr1dVHuzLVl36CQ6VnsHLWlncTOwIHZ8xFf9Mp65gRWQ+GW6wL7rOe65HyeATSLac60Z5RhZ2++ygPBJqYShq7Us3+dME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgTAekkr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgTAekkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790179039; x=1821715039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z/w/kI/X4tXR/s2nUyxfG2V8PK+h36DMzF53LKcUUqE=;
  b=fgTAekkrIcSragk8z4KuFKX5wAfmXDIEj6CNrUORsfvOfQk/D/gd/J7g
   zCa1a/efF4d3gksHxZYWnm68937wAkqkuSURo2egSRXQKrbXXIhYCQZzg
   F5Wv0HOqpya7NvQ/B44c17/jV540lSK6T8sc1jQMFg0/Sq1Zb5DR6cfMK
   lJBquxzHkR65pgIlAkh2hdrr4YtAq0OMgNCgCI2oiJARu2lkSdA3fN6e9
   mkSYbtLcZv1tIY61DwhxzHzzWPe07Fo58CkTgq7wLvIAdfuvukORJk5L4
   fMlehqTdI+vfXOC1WqWU2rAmvYPznrh1Tnfdt/+3Xt1smqf7pgXxcHsfH
   Q==;
X-CSE-ConnectionGUID: VDA8cshyRQyeIVZp4d9jaw==
X-CSE-MsgGUID: mVERw9rrSF2Jx5rULKluYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78445987"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78445987"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:14 -0700
X-CSE-ConnectionGUID: g6YnwgaVSEKxZW1sNlvnYw==
X-CSE-MsgGUID: vTX+ZWzyTyy5EGoSyHStpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4935342"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:14 -0700
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
Subject: [PATCH v11 6/6] perf c2c: print memory region data with stdio output
Date: Wed, 23 Sep 2026 10:57:03 -0500
Message-ID: <20260923155703.34814-7-thomas.falcon@intel.com>
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

Print memory range data in perf-c2c subcommand. Only available in stdio
mode currently. If memory ranges are not supported or present, print
nothing.

Example output of perf c2c report --stdio:

=================================================
                  Memory Ranges
=================================================
Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id 0, remote region id 255
Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id 0, remote region id 255
Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id 1, remote region id 255
Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id 1, remote region id 255
Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id 1, remote region id 255

Assisted-by: Sashiko:gemini-3.1-pro-preview
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v10: Fixup double blank line before print_memory_ranges_info() define
---
 tools/perf/builtin-c2c.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a42423ca990d..2c8e1c7adedd 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2597,6 +2597,33 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
 
+static void print_memory_ranges_info(FILE *out, struct perf_session *session)
+{
+	struct perf_env *env = perf_session__env(session);
+	int nr_ranges = 0;
+
+	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
+		return;
+	nr_ranges = env->nr_memory_ranges;
+	if (nr_ranges == 0) {
+		pr_debug("No memory ranges found, skipping\n");
+		return;
+	}
+
+	fprintf(out, "\n");
+	fprintf(out, "=================================================\n");
+	fprintf(out, "                  Memory Ranges                  \n");
+	fprintf(out, "=================================================\n");
+
+	for (int i = 0; i < nr_ranges; i++) {
+		struct memory_range *r = &env->memory_ranges[i];
+
+		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, local region id %u, remote region id %u\n",
+			i, r->base, r->base + r->length - 1, r->node,
+			r->local_region_id, r->remote_region_id);
+	}
+}
+
 static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 {
 	setup_pager();
@@ -2610,6 +2637,8 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	if (c2c.stats_only)
 		return;
 
+	print_memory_ranges_info(out, session);
+
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
 	fprintf(out, "           Shared Data Cache Line Table          \n");
-- 
2.43.0


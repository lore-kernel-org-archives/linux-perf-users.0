Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8975AA673;
	Thu, 10 Sep 2026 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069474; cv=none; b=RrVA5aHhvXmnz17MVysaFKvWuB7su/GGhl3H5352bquRUXdCIBhDfoGrm6rCxzvBhvf32vtNGbvJAoZupnAsM4uSskgkujUIcsOKePszDXwjpisWz++ylhRyLtud1ft8v8yPdruGkQtHrCgjpH2HQC/e6O2FJNp2PJ4nlyc0b1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069474; c=relaxed/simple;
	bh=aQEhXcK4hhUXDklQG94Qb9RQL4322c8Aahlb9xZ8t3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JONvCWn0K6XbnIvw/cTamEvDcE2MerDR/QTMw8gKmLKut//hnrx3dHrmIEkvjruFoQ2u7DbEAlLCDAqwVmQtCSY3xfAztGK4/W7sjSe9QSZK0b3r3/e/ga8HV65T16OK4D8WvkBvXCcqfqoeKdm0vBWo06tKQn2Z2Zl23QD8Tq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky+0NQ8U; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky+0NQ8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789069472; x=1820605472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQEhXcK4hhUXDklQG94Qb9RQL4322c8Aahlb9xZ8t3s=;
  b=ky+0NQ8Uwy2Q3Q+GmTPRdt8c5h2ViaZcg8rTjoK7pmBLNItGQDgaSBVW
   GYPMJSl7adEdj9QgK9M7qP94HPETRkqm8ITGd2HbR5QAa840TcA6BA8sS
   g73jLZn5xcUBwvKQUUCA5tdBSEN7kilK5nz53j8dec/3owLUZYGAplPwL
   2A+N4gk3uk+jy5LUeaWFYdRpFcGTylbbPOU5BWhMe7bXPFoiZq1OkYSnl
   Uci2oMcyJvWIi+e3lM9AESTifGh4L4c+DGLF1CtpyB1zo+6scOBqhzRCf
   mE0JBmk2hSAItRXBYUd7AQFsovmBX7Tx9cN/HdQ+XMGkz7XlOpzCSX3z3
   g==;
X-CSE-ConnectionGUID: Xe+TjCK6RzauVWujgQ2dig==
X-CSE-MsgGUID: /OvmS6iJQ3S6Q4bmr0JVuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89402931"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89402931"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:55 -0700
X-CSE-ConnectionGUID: DDXZLWOqQIS57lM8EvYe6w==
X-CSE-MsgGUID: 53FVsWXkQGyURtwrRKWyQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="295206801"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.222.113])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:54 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v8 6/6] perf c2c: print memory region data with stdio output
Date: Thu, 10 Sep 2026 14:43:24 -0500
Message-ID: <20260910194324.98002-7-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910194324.98002-1-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
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
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v3: Included examples of memory range output in commit message
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e37c1a3a4ca5..9d0182a7d4d5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2580,6 +2580,34 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
 
+
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
@@ -2593,6 +2621,8 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	if (c2c.stats_only)
 		return;
 
+	print_memory_ranges_info(out, session);
+
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
 	fprintf(out, "           Shared Data Cache Line Table          \n");
-- 
2.43.0


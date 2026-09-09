Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CE5803AB;
	Wed,  9 Sep 2026 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969759; cv=none; b=JnoL3UEXb1w/hjeqB25L9Jgzr8RCCc3rOYEvgIpCgp+82zJhnwoyjTrLX7T2pyFHjZqxVWYVq8gwSk1U+vAtTRJFNIim1LYUbeANp1VNC5W0DzX/X2Hpb8uQmuwUQ6xN6EtPApb3y8r95QrnSCLILKlA1bDuOwuNuOLq4gix1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969759; c=relaxed/simple;
	bh=aQEhXcK4hhUXDklQG94Qb9RQL4322c8Aahlb9xZ8t3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlPeztEIfU8bcXqButXqWnP5bU5RHaWSnXQExC0sldrMpRM7ETpnPHbXeSA+NxLETcHlQFxHsHo1qPW13yG8cj9UztsmcNTKLlK/43JM4E4YepLYbbtZu7JIbZ9+yIrZXAUtjwhPauyL2RfEziYcYgU2DRHI7hLxXIH2kHyaYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5UZMYY5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5UZMYY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788969758; x=1820505758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQEhXcK4hhUXDklQG94Qb9RQL4322c8Aahlb9xZ8t3s=;
  b=G5UZMYY5wMSQdrhTvqKiYCXi4DJmNNmL3ZTtE6eccuhJOfLh6S+f4IDt
   YAzdCxALT8LxlYVfyPfn7WiBpHxsAvpcrBXCJiDHrs+yEn2+b8bRr5Rij
   esP9IaPuzEIHyWUKhfEtVLMbECu47MntPhR4dUP+Ff/2r6z3JHU2Hba3z
   /wIxuOiQjvhU9M5TfDllFkpdgG4Bs4m/FKypfxi6P69GZF0N/d16e7oWt
   U47l5DKBAyPYl/uZuocQ0AgRKeZUZXTHS8Pe/WnVyDCQxQsj25nfADZRu
   FXZAnf/BWZjtCM5Rse5aiKLFEs7xMU1Kdz6otbJQjmp+P6l6Y5CLv/PiN
   A==;
X-CSE-ConnectionGUID: xNzAXXm0T8iE/y4B0rvQmA==
X-CSE-MsgGUID: wPKlJC8BQyOSngmLkOcvtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100564507"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100564507"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:02:37 -0700
X-CSE-ConnectionGUID: RFul9G2tQ4WUpYOpxo4qcg==
X-CSE-MsgGUID: PMjFfL4qQj+oDXdpASTzUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="267072988"
Received: from iweiny-desk3.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.48])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 09:02:35 -0700
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
Subject: [PATCH v7 6/6] perf c2c: print memory region data with stdio output
Date: Wed,  9 Sep 2026 11:02:18 -0500
Message-ID: <20260909160218.174928-7-thomas.falcon@intel.com>
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


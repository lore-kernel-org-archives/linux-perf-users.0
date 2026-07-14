Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400C260580;
	Tue, 14 Jul 2026 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989859; cv=none; b=COu/I7OHZKBKgvyN/0NRsoRJH/CEyC80dQf/yQnqCm0aRBQlMVKRQ8awV62FMraauZzDVCFXzhAdDzkkKH9t50SD0UaTeuYZrgD+qBS/VTkeTNza6k8TFX2YMMIjoynFEqsnuNr67L8ZlCAXReuzuiNgbsdLTEcpPH8Wt4z/W18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989859; c=relaxed/simple;
	bh=Bh6Hd/6Tr/rdn7/BQvUzup7mOhIilucPf3EoQ2zTfW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI7VdEpFP2+ws6MwvZXJ4fXkrZ6bxQLaa7FvevSY3DnFLCGkGpa0tM9buFDaNyXfjic3t3SjYyeEYtd0ZakPAkYgS77crHlumftjhAi7cEG/A0udIeNNfkmQOU5jEipcTzVYzCQcZo4g0WQ1GaMOhuOw6LJ9fQLvZPChQAuUZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUZgCELC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUZgCELC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783989858; x=1815525858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bh6Hd/6Tr/rdn7/BQvUzup7mOhIilucPf3EoQ2zTfW4=;
  b=bUZgCELCKCDuM16Q7ULv5Urn303MGtsAb6ntN8vDuMbyY4LFK+1pJ7LP
   41q0M61+HJbSxxialJDl8PZaTFwGAESOplS4vKFxT23WqdKH6VOeOm/wq
   GQu539iRQT2+TW3EjPQgCJGXQ3hZX0DSWWdyiEzqtfKveSsmYYmS7Zxp5
   dEo5U0kVLAGR2Yy5vXs7o6D9QbzzTrPGsc9+LWIW5PpreypDdr6ZpA/yd
   6oZPrK0an00nSASIY4D774nnoz/EXJu1ETP/LAGPCk0BDUtdKInzXrUvk
   rDT38owVbqTvr7LFuJT4ZCIa9fwwH+BfF22ds3eXXkIeUfktVnbVv8vZZ
   g==;
X-CSE-ConnectionGUID: jjgR+3vpStqDVsWtWEZiWQ==
X-CSE-MsgGUID: Qupf1DfRT8+8Havx90y3hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="72130675"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="72130675"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:17 -0700
X-CSE-ConnectionGUID: HIFMr7PlSUOI9zF2/KNV4g==
X-CSE-MsgGUID: 8MFnqKGaS1amCqLoPvx4Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="260582159"
Received: from rodrigoa-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.220.48])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 17:44:16 -0700
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
Subject: [PATCH v2 6/6] perf c2c: print memory region data with stdio output
Date: Mon, 13 Jul 2026 19:43:59 -0500
Message-ID: <20260714004359.179451-7-thomas.falcon@intel.com>
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

Print memory range data in perf-c2c subcommand. Only available in stdio
mode currently. If memory ranges are not supported or present, print
nothing.

Assisted-by: Sashiko:gemini-3.1-pro-preview
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index cba2e9f21ae7..68348a93bd33 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2634,6 +2634,34 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
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
@@ -2647,6 +2675,8 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
 	if (c2c.stats_only)
 		return;
 
+	print_memory_ranges_info(out, session);
+
 	fprintf(out, "\n");
 	fprintf(out, "=================================================\n");
 	fprintf(out, "           Shared Data Cache Line Table          \n");
-- 
2.43.0


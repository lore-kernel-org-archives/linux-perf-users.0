Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C43CB56B;
	Mon, 14 Sep 2026 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426026; cv=none; b=gwv8Qb/6dFSLDA7SX0cCjpfCONBusBJ++PVVRljERPzu7XWEBHcbgnTOMCJeWlZDTnTgo2n+ouQw5g1liOhm+KzJWPMQg0WqgOUFfIbXLLGIhlSHuwNRhyJhKdvTcIVvYDFerg8Fu4KTF2yyr39v04fDlR5poAZHwXYH3gm6UYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426026; c=relaxed/simple;
	bh=BNgXZTIPrUrxI4CV5asnEbE3cBlYOveVWiMeVwlg3W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue+/XfXiy5A4iofSqQovKm5T6yvDHsfb9n9qS7mXF3Gj8I3VQ08jzM7SYX0XoLMmmsLkUbW3QkEJNseaeIxnXjnFxyoaze3+LhyZ3XdK+HIqB/zSYEF0O7CUHL/UDjiwUrXHsgMLHNW9xIMAwadDw6Kdqxrn7vM8Eo3w92UYx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjRRW9KW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjRRW9KW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789426024; x=1820962024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BNgXZTIPrUrxI4CV5asnEbE3cBlYOveVWiMeVwlg3W4=;
  b=kjRRW9KWLV0tE1gR+9AXxAw17Ysg1KpE5q4IownqFP9P13JHT5E/vxMv
   xLgKNfQIymjkRchXAREmWZKwPfxmUXqE/IzqhodGDXSoKr56ZzJA78/xf
   hDWXiIea8thgN8Blcm8FNjFs8AjB2fk7qzXVVCD7MVcxxhypH+yzny0M3
   DIzrkwoK8DLj6dIXp5iiW4nqqk2umeKAVNfg8wEqEYbTLO39jLW4rgC1b
   pWwKFBZZYZXTu1v32a7oJxjhB2oXZQqbI6goSleFFvNaj8cO+Vi5Z+YEl
   TmbXdEn6rtmqk+7Cum+JUagDUI3R94YGuVFioL2X3E/di8sx5Qmf9ebgC
   Q==;
X-CSE-ConnectionGUID: yd0loaTKS6+dXVe8x+nw/A==
X-CSE-MsgGUID: cyyJ7IiESM25od+mYpk8YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93483234"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93483234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:47:04 -0700
X-CSE-ConnectionGUID: SjdsXzm6QrKzAh8LZ3/ltg==
X-CSE-MsgGUID: vxT2Z/fcT6GuNWfDztFFGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="268480106"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.56])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 15:47:03 -0700
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
Subject: [PATCH v9 4/6] perf tools: Show memory region in perf-c2c subcommand
Date: Mon, 14 Sep 2026 17:46:48 -0500
Message-ID: <20260914224650.52982-5-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914224650.52982-1-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add memory region field to the cacheline list view to help users
identify the memory region to which the cacheline belongs. The memory
region field was included with the introduction of support for the
Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
Nova Lake architectures.

An example of the new perf c2c output including the memory region
field is shown below:

Shared Data Cache Line Table     (176 entries, sorted on Total HITMs)
       ------------------------ Cacheline -----------------------      Tot  ------- Load Hitm -------    Total    Total    Total
Index             Address                    Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores
    0  0xffffffff98c58ec0                       N/A     0    1208    4.06%       97       97        0     1602     1602        0
...
  145  0xff332b267b5b3880                     Mem-0     0       1    0.13%        3        3        0       12       12        0
  146  0xff332b267b6b3880        Local-shared-cache     0       1    0.13%        3        3        0       11       11        0
  147  0xff332b267b9b3880                       N/A     0       1    0.13%        3        3        0        8        8        0
  148  0xff332b267ba33880        Other-shared-cache     0       1    0.13%        3        3        0        7        7        0
  149  0xff332b267bab3880        Local-shared-cache     0       1    0.13%        3        3        0        6        6        0
  150  0xff332b267bbb3880                       N/A     0       1    0.13%        3        3        0        8        8        0
  151  0xff332b267bd33880    Local-non-shared-cache     0       1    0.13%        3        3        0       11       11        0
  152  0xff332b267be33880                       N/A     0       3    0.13%        3        3        0       10       10        1
  153  0xff332b267bf33880    Local-non-shared-cache     0       1    0.13%        3        3        0       10       10        0

[1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/

Assisted-by: Sashiko:gemini-3.1-pro-preview
Assisted-by: GitHub-Copilot:claude-opus-4-8
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v9: Update perf-c2c to include cache region reporting (Dapeng Mi)

v8: Update developer tags and commit message with real example
    output (Dapeng Mi)

v7: fix output_str allocation error handling which introduced
    a memory leak (Sashiko)

v6: rebased onto 7.3-rc1

v5: make the cacheline header span and ui_quirks() width
    fixup depend on memory-region availability (Namhyung Kim)

v4: correctly handle output_str memory allocation failure

v3: make memory region reporting conditional on feature bit
---
 tools/perf/builtin-c2c.c | 126 +++++++++++++++++++++++++++++++++++----
 tools/perf/util/c2c.h    |   1 +
 2 files changed, 116 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6b64c0d6b24f..3b7437906a65 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -72,6 +72,7 @@ struct perf_c2c {
 
 	bool			 show_src;
 	bool			 show_all;
+	bool			 show_mem_region;
 	bool			 use_stdio;
 	bool			 stats_only;
 	bool			 symbol_full;
@@ -248,6 +249,16 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
 	}
 }
 
+static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
+				   unsigned int mem_region)
+{
+	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
+		      "WARNING: invalid memory region ID\n"))
+		return;
+
+	c2c_he->mem_region = mem_region;
+}
+
 static void compute_stats(struct c2c_hist_entry *c2c_he,
 			  struct c2c_stats *stats,
 			  u64 weight)
@@ -306,6 +317,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	struct addr_location al;
 	struct mem_info *mi = NULL;
 	struct callchain_cursor *cursor;
+	unsigned int mem_region;
 	int ret;
 
 	addr_location__init(&al);
@@ -333,6 +345,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 	c2c_decode_stats(&stats, mi);
+	mem_region = mem_info__data_src(mi)->mem_region;
 
 	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 				  &al, NULL, NULL, mi, NULL,
@@ -349,6 +362,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	c2c_he__set_cpu(c2c_he, sample);
 	c2c_he__set_node(c2c_he, sample);
 	c2c_he__set_evsel(c2c_he, evsel);
+	c2c_he__set_mem_region(c2c_he, mem_region);
 
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 
@@ -402,6 +416,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		c2c_he__set_cpu(c2c_he, sample);
 		c2c_he__set_node(c2c_he, sample);
 		c2c_he__set_evsel(c2c_he, evsel);
+		c2c_he__set_mem_region(c2c_he, mem_region);
 
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 		ret = hist_entry__append_callchain(he, sample);
@@ -540,6 +555,60 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->paddr_cnt);
 }
 
+static int
+dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	struct c2c_hist_entry *c2c_he;
+	unsigned int mem_region;
+	char buf[30];
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	mem_region = c2c_he->mem_region;
+
+	switch (mem_region) {
+	case PERF_MEM_REGION_NA:
+	case PERF_MEM_REGION_RSVD:
+		scnprintf(buf, sizeof(buf), "N/A");
+		break;
+	case PERF_MEM_REGION_L_SHARE:
+		scnprintf(buf, sizeof(buf), "Local-shared-cache");
+		break;
+	case PERF_MEM_REGION_L_NON_SHARE:
+		scnprintf(buf, sizeof(buf), "Local-non-shared-cache");
+		break;
+	case PERF_MEM_REGION_O_IO:
+		scnprintf(buf, sizeof(buf), "Other-IO");
+		break;
+	case PERF_MEM_REGION_O_SHARE:
+		scnprintf(buf, sizeof(buf), "Other-shared-cache");
+		break;
+	case PERF_MEM_REGION_O_NON_SHARE:
+		scnprintf(buf, sizeof(buf), "Other-non-shared-cache");
+		break;
+	case PERF_MEM_REGION_MMIO:
+		scnprintf(buf, sizeof(buf), "MMIO");
+		break;
+	case PERF_MEM_REGION_MEM0:
+	case PERF_MEM_REGION_MEM1:
+	case PERF_MEM_REGION_MEM2:
+	case PERF_MEM_REGION_MEM3:
+	case PERF_MEM_REGION_MEM4:
+	case PERF_MEM_REGION_MEM5:
+	case PERF_MEM_REGION_MEM6:
+	case PERF_MEM_REGION_MEM7:
+		scnprintf(buf, sizeof(buf), "Mem-%d",
+			  mem_region - PERF_MEM_REGION_MEM0);
+		break;
+	default:
+		scnprintf(buf, sizeof(buf), "N/A");
+		break;
+	}
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			struct hist_entry *he)
 {
@@ -1360,6 +1429,14 @@ static struct c2c_dimension dim_dcacheline_node = {
 	.width		= 4,
 };
 
+static struct c2c_dimension dim_dcacheline_mem_region = {
+	.header		= HEADER_LOW("Region"),
+	.name		= "dcacheline_mem_region",
+	.cmp		= empty_cmp,
+	.entry		= dcacheline_node_mem_region,
+	.width		= 24,
+};
+
 static struct c2c_dimension dim_dcacheline_count = {
 	.header		= HEADER_LOW("PA cnt"),
 	.name		= "dcacheline_count",
@@ -1791,6 +1868,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
+	&dim_dcacheline_mem_region,
 	&dim_dcacheline_node,
 	&dim_dcacheline_count,
 	&dim_offset,
@@ -2854,8 +2932,11 @@ static int ui_quirks(void)
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
 				dim_dcacheline.width +
+				(c2c.show_mem_region ?
+					dim_dcacheline_mem_region.width : 0) +
 				dim_dcacheline_node.width +
-				dim_dcacheline_count.width + 4);
+				dim_dcacheline_count.width +
+				(c2c.show_mem_region ? 6 : 4));
 	if (!buf)
 		return -ENOMEM;
 
@@ -3107,7 +3188,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
-	const char *output_str, *sort_str = NULL;
+	const char *sort_str = NULL;
+	char *output_str = NULL;
 	struct perf_env *env;
 
 	annotation_options__init();
@@ -3272,9 +3354,16 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	if (c2c.display != DISPLAY_SNP_PEER)
-		output_str = "cl_idx,"
+	c2c.show_mem_region = perf_header__has_feat(&session->header,
+						HEADER_MEMORY_RANGES);
+	if (c2c.show_mem_region)
+		dim_dcacheline.header.line[0].span = 3;
+
+	if (c2c.display != DISPLAY_SNP_PEER) {
+		if (asprintf(&output_str,
+			     "cl_idx,"
 			     "dcacheline,"
+			     "%s"
 			     "dcacheline_node,"
 			     "dcacheline_count,"
 			     "percent_costly_snoop,"
@@ -3286,10 +3375,17 @@ static int perf_c2c__report(int argc, const char **argv)
 			     "ld_fbhit,ld_l1hit,ld_l2hit,"
 			     "ld_lclhit,lcl_hitm,"
 			     "ld_rmthit,rmt_hitm,"
-			     "dram_lcl,dram_rmt";
-	else
-		output_str = "cl_idx,"
+			     "dram_lcl,dram_rmt",
+			     c2c.show_mem_region ?
+			     "dcacheline_mem_region," : "") < 0) {
+			err = -ENOMEM;
+			goto out_mem2node;
+		}
+	} else {
+		if (asprintf(&output_str,
+			     "cl_idx,"
 			     "dcacheline,"
+			     "%s"
 			     "dcacheline_node,"
 			     "dcacheline_count,"
 			     "percent_costly_snoop,"
@@ -3301,7 +3397,13 @@ static int perf_c2c__report(int argc, const char **argv)
 			     "ld_fbhit,ld_l1hit,ld_l2hit,"
 			     "ld_lclhit,lcl_hitm,"
 			     "ld_rmthit,rmt_hitm,"
-			     "dram_lcl,dram_rmt";
+			     "dram_lcl,dram_rmt",
+			     c2c.show_mem_region ?
+			     "dcacheline_mem_region," : "") < 0) {
+			err = -ENOMEM;
+			goto out_mem2node;
+		}
+	}
 
 	if (c2c.display == DISPLAY_TOT_HITM)
 		sort_str = "tot_hitm";
@@ -3315,7 +3417,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
 	if (err) {
 		pr_err("Failed to reinitialize hists\n");
-		goto out_mem2node;
+		goto out_str;
 	}
 
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
@@ -3324,17 +3426,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
 	err = hists__iterate_cb(&c2c.hists.hists, resort_cl_cb, perf_session__env(session));
 	if (err)
-		goto out_mem2node;
+		goto out_str;
 
 	ui_progress__finish();
 
 	if (ui_quirks()) {
 		pr_err("failed to setup UI\n");
-		goto out_mem2node;
+		goto out_str;
 	}
 
 	perf_c2c_display(session);
 
+out_str:
+	free(output_str);
 out_mem2node:
 	mem2node__exit(&c2c.mem2node);
 out_session:
diff --git a/tools/perf/util/c2c.h b/tools/perf/util/c2c.h
index 53f024e25d99..f04e78e1a2e3 100644
--- a/tools/perf/util/c2c.h
+++ b/tools/perf/util/c2c.h
@@ -33,6 +33,7 @@ struct c2c_hist_entry {
 	unsigned long		*nodeset;
 	struct c2c_stats	*node_stats;
 	unsigned int		 cacheline_idx;
+	unsigned int		 mem_region;
 
 	struct compute_stats	 cstats;
 
-- 
2.55.0


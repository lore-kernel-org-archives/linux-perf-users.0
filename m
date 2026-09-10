Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7FE5A5125;
	Thu, 10 Sep 2026 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069471; cv=none; b=VODBo0Vzc90uIg+MjwVtEzGjD3eNIknFJlq8fOV/1UjTtU71fGTAT7RviLUf5DFS6cBsyLy9hWSOnkpP6FPK3Ts+lPMUWEM2TGDyo+6RTFP1cjcpIZpSPUqKxKkhqWWfbMv/62B35I0LD0zcFRE/4v2Tqgg2wSegcZ7x361jiHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069471; c=relaxed/simple;
	bh=mEIpB1Q7KEN8H89voCfeJ7foqtGgwXTrGMqC3wS3SOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0nXE0cY5bw+puLsSqsv2M1jdATqy6HPLWi6Oe8TPmR8uODVess2mw4ZNEDN2vSRznEjb/DjyhYmC37vgH7rA3jTh058DoeZNyKAYigyMXW0cOjCJYbsuH87Vl/j6BW8MNfPsKZlRupu84gp+7XVoHXQyi32tPqCcXXSEIRLeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoNmrsTn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoNmrsTn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789069470; x=1820605470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mEIpB1Q7KEN8H89voCfeJ7foqtGgwXTrGMqC3wS3SOQ=;
  b=eoNmrsTnW/819O5/lLNAhzEoO7e21p0XFiogEAe1YX+YHVl7geymm/oy
   hLcbQM1/4jH44jMpw3KGaXPlhb7IlCG8lJup8WTnq+xFihSHf5uMbxF5+
   NkihAGgVHdX69ybrgo4t0807xSQsS/gpQm99ukfh37jOrNiX1ghpdKxUD
   aFsyAGDWMQnuVt32/PVxGOt9VNyww2UHDuawB81tkqyu/i9LWyt91zscl
   W39FEhiwrJM5111HpeCh/AgwLGsxlcTB6ILxo+35JZ5SgI2cFD3+XEgNZ
   EO0ce1IsVDT/LDs81lU2BodDV7qetJoB3yV6F4NsiQwSrx3+3jiOcUeua
   Q==;
X-CSE-ConnectionGUID: vQGPASE2Q3qklV68Ljy5pg==
X-CSE-MsgGUID: W92NlloySiqJnz4r8SkpSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89402914"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89402914"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:53 -0700
X-CSE-ConnectionGUID: PW05aVOfSyeuOs8VQY711g==
X-CSE-MsgGUID: zWzhpUd5S96IyyJ/ukLzKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="295206786"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO tfalcon-desk.intel.com) ([10.124.222.113])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 12:43:52 -0700
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
Subject: [PATCH v8 4/6] perf tools: Show memory region in perf-c2c subcommand
Date: Thu, 10 Sep 2026 14:43:22 -0500
Message-ID: <20260910194324.98002-5-thomas.falcon@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add memory region field to the cacheline list view to help users
identify the memory region to which the cacheline belongs. The memory
region field was included with the introduction of support for the
Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
Nova Lake architectures.

An example of the new perf c2c output including the memory region
field is shown below:

Shared Data Cache Line Table     (181 entries, sorted on Total HITMs)
       --------------- Cacheline --------------      Tot  ------- Load Hitm -------    Total    Total    Total
Index             Address  Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores
    0  0xffffffffa1658ec0     0x0     0    1302    4.13%      103      103        0     1707     1707        0
    1  0xffffffffa16a9100     0x0     0     991    3.73%       93       93        0     1580     1580       19
    2  0xffffffffa16a91c0     0x0     0      37    3.05%       76       76        0      384      384        4
    3  0xffffffffa0607a00     0x0     0       1    2.65%       66       66        0     1146     1146        5
    4  0xffffffffa16a9200     0x0     0       1    1.72%       43       43        0      174      174        3
    5  0xffffffffa0607a80     0x0     0       1    1.16%       29       29        0      439      439       12
    6  0xffffffffa16aadc0     0x0     0       1    0.72%       18       18        0      158      158        3
    7  0xff30ea3c37934640     N/A     0      51    0.64%       16       16        0       60       60        8
    8  0xff30ea3c373b4640     N/A     0      64    0.48%       12       12        0       69       69       11
    9  0xff30ea3c387b4640     0x0     0      56    0.48%       12       12        0       59       59        9
   10  0xff30ea3c37db4640     N/A     0      49    0.44%       11       11        0       50       50       10

[1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/

Assisted-by: Sashiko:gemini-3.1-pro-preview
Assisted-by: GitHub-Copilot:claude-opus-4-8
Codeveloped-by: Thomas Falcon <thomas.falcon@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v8: Update developer tags and commit message with real example output

v7: fix output_str allocation error handling which introduced
    a memory leak (Sashiko)

v6: rebased onto 7.3-rc1

v5: make the cacheline header span and ui_quirks() width
    fixup depend on memory-region availability (Namhyung Kim)

v4: correctly handle output_str memory allocation failure

v3: make memory region reporting conditional on feature bit
---
 tools/perf/builtin-c2c.c | 98 +++++++++++++++++++++++++++++++++++-----
 tools/perf/util/c2c.h    |  1 +
 2 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 715b75d42f2a..e37c1a3a4ca5 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -71,6 +71,7 @@ struct perf_c2c {
 
 	bool			 show_src;
 	bool			 show_all;
+	bool			 show_mem_region;
 	bool			 use_stdio;
 	bool			 stats_only;
 	bool			 symbol_full;
@@ -247,6 +248,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
 	}
 }
 
+static void c2c_he__set_mem_region(struct c2c_hist_entry *c2c_he,
+				   unsigned int mem_region)
+{
+	if (WARN_ONCE(mem_region > PERF_MEM_REGION_MEM7,
+		      "WARNING: invalid memory region ID\n"))
+		return;
+
+	/* Update mem_region only if it really accesses memory */
+	if (mem_region >= PERF_MEM_REGION_MMIO)
+		c2c_he->mem_region = mem_region;
+}
+
 static void compute_stats(struct c2c_hist_entry *c2c_he,
 			  struct c2c_stats *stats,
 			  u64 weight)
@@ -305,6 +318,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	struct addr_location al;
 	struct mem_info *mi = NULL;
 	struct callchain_cursor *cursor;
+	unsigned int mem_region;
 	int ret;
 
 	addr_location__init(&al);
@@ -332,6 +346,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 	c2c_decode_stats(&stats, mi);
+	mem_region = mem_info__data_src(mi)->mem_region;
 
 	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 				  &al, NULL, NULL, mi, NULL,
@@ -348,6 +363,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	c2c_he__set_cpu(c2c_he, sample);
 	c2c_he__set_node(c2c_he, sample);
 	c2c_he__set_evsel(c2c_he, evsel);
+	c2c_he__set_mem_region(c2c_he, mem_region);
 
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 
@@ -401,6 +417,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		c2c_he__set_cpu(c2c_he, sample);
 		c2c_he__set_node(c2c_he, sample);
 		c2c_he__set_evsel(c2c_he, evsel);
+		c2c_he__set_mem_region(c2c_he, mem_region);
 
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 		ret = hist_entry__append_callchain(he, sample);
@@ -539,6 +556,30 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*lu", width, c2c_he->paddr_cnt);
 }
 
+static int
+dcacheline_node_mem_region(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	struct c2c_hist_entry *c2c_he;
+	unsigned int mem_region;
+	char buf[20];
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	mem_region = c2c_he->mem_region;
+
+	if (mem_region == PERF_MEM_REGION_NA)
+		scnprintf(buf, sizeof(buf),  "N/A");
+	/* mem_region could only be >= PERF_MEM_REGION_MMIO */
+	else if (mem_region == PERF_MEM_REGION_MMIO)
+		scnprintf(buf, sizeof(buf), "MMIO");
+	else
+		scnprintf(buf, sizeof(buf), "0x%x",
+			  mem_region - PERF_MEM_REGION_MEM0);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			struct hist_entry *he)
 {
@@ -1359,6 +1400,14 @@ static struct c2c_dimension dim_dcacheline_node = {
 	.width		= 4,
 };
 
+static struct c2c_dimension dim_dcacheline_mem_region = {
+	.header		= HEADER_LOW("Region"),
+	.name		= "dcacheline_mem_region",
+	.cmp		= empty_cmp,
+	.entry		= dcacheline_node_mem_region,
+	.width		= 6,
+};
+
 static struct c2c_dimension dim_dcacheline_count = {
 	.header		= HEADER_LOW("PA cnt"),
 	.name		= "dcacheline_count",
@@ -1790,6 +1839,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
+	&dim_dcacheline_mem_region,
 	&dim_dcacheline_node,
 	&dim_dcacheline_count,
 	&dim_offset,
@@ -2853,8 +2903,11 @@ static int ui_quirks(void)
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
 
@@ -3106,7 +3159,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
-	const char *output_str, *sort_str = NULL;
+	const char *sort_str = NULL;
+	char *output_str = NULL;
 	struct perf_env *env;
 
 	annotation_options__init();
@@ -3271,9 +3325,16 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3285,10 +3346,17 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3300,7 +3368,13 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3314,7 +3388,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
 	if (err) {
 		pr_err("Failed to reinitialize hists\n");
-		goto out_mem2node;
+		goto out_str;
 	}
 
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
@@ -3323,17 +3397,19 @@ static int perf_c2c__report(int argc, const char **argv)
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
2.43.0


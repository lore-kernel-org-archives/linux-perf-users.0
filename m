Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B74334A4;
	Mon,  3 Aug 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789969; cv=none; b=rjEeliKaIkYoPK9rQZtT0UbkUCLx0ufUhbVvPgaosAEzNvTx3JGFuB6a2Lg6mV4R/wcJLdmkzrfQLRu7HZZZN2Mcis3craLAiXUjsMDpN890M37X0oCuj/nv5ZX/MSU6AGdTAqARMNbJrBiTB1DnnhiUG8ekr+N20J9tfOXf4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789969; c=relaxed/simple;
	bh=QUvAd/XSA5yo5YC800S9sGexjSNzwQjNMeAWQS0dHyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFTb+ffeCo2CdJ2DRCmHseNBLZNMvvnUA+h68MWs5CgABDU9mvStT7uIzkVOIFTx2FAH25wJIE0Sik+mzGwNfKBBaKEMdpfJzmdzoE+7mjRE9WhLOVecdMSfnW3xkIi+KHd391klXn6FRubdUakExUdx7BJ735jRjITlanY7Sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vay5T4a5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vay5T4a5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785789968; x=1817325968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QUvAd/XSA5yo5YC800S9sGexjSNzwQjNMeAWQS0dHyw=;
  b=Vay5T4a5wI2NrbeLoiVAZfrMqzgveQiVVxv9oXyEbSO6JJSdvXbtaZsW
   4fJqgVXj4u+VJXEtnqF90ve70nUEjIBBXXL7f51gBy7VLW9jnyBNNglHZ
   rQ8UoYX97X8hcpKtJF/roxabdudrW1awT9ybaC0WUgWUiXrfjJ0phufC7
   Nx2nNnAQQYWdOsMNy7hQIcVp926Q/g3nvDfAUYoC3TNdyLlVMbc06r8kz
   MPKKyhzYEXb9Y/iNb88vQP12FgwgLq6ZDnJSlLiIrwoSmjRXx41UWI2GB
   sQurRO/5yBJl6ZSgTfRTNPk007o+/0XVsXlg03lc1T+b68znhGaXSQ8px
   g==;
X-CSE-ConnectionGUID: G0cq84NWRcWFJQpbRosB7w==
X-CSE-MsgGUID: Lg8piYfNQjuDrMxRLVZ9VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96927288"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="96927288"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:46:05 -0700
X-CSE-ConnectionGUID: V6MhSYcUQsmb7mNADI9qfg==
X-CSE-MsgGUID: pAPw89lXTbCGLO51sOU2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="284702388"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:46:01 -0700
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
Subject: [PATCH v3 4/6] perf tools: Show memory region in perf-c2c subcommand
Date: Mon,  3 Aug 2026 15:45:38 -0500
Message-ID: <20260803204540.100348-5-thomas.falcon@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add memory region field to the cacheline list view to help users
identify the memory region to which the cacheline belongs. The memory
region field was included with the introduction of support for the
Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
Nova Lake architectures.

An example of the new perf c2c output including the memory region
field is shown below:

Shared Data Cache Line Table     (112 entries, sorted on Total HITMs)
       --------------- Cacheline --------------      Tot  ------- Load Hitm -------    Total    Total    Total
Index             Address  Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads   Stores
    0  0xff1b7032a1e8c5c0  N/A        1      47    2.25%       50       44        6     1024     1023        1
    1  0xff1b6ff3255bb880  N/A        0      11    1.62%       36       34        2       96       93        4
    2  0xff1b70328e3b9880  N/A        1      13    1.49%       33       33        0      100       91        9
    3  0xff1b70328b023800  N/A        1       1    1.40%       31       14       17       52       48        4
    4  0xff1b70328e3b9c00  N/A        1       1    1.31%       29       27        2       67       33       34
    5  0xff1b70328b0237c0  N/A        1       1    1.26%       28       10       18      154      150        4
    6  0xff1b6ff3255bbc00  N/A        0       1    1.13%       25       25        0       48       25       23
    7  0xff1b6ff3255bba40  N/A        0       1    0.99%       22       22        0       46       23       23
    8  0xff3ab9ba50255c80  N/A      N/A       0    0.77%       17       15        2       35       35        0
    9  0xff3ab9ba503e3040  N/A      N/A       0    0.77%       17       11        6       37       37        1
   10  0xff1b703289e88f40  N/A        1      33    0.72%       16        9        7       69       63        6
   11  0xff1b70328e3b9a40  N/A        1       1    0.68%       15       15        0       43       17       26
   12  0xff1b7032c9fd6a40  N/A        1      15    0.68%       15       15        0       57       54        4
   13  0xff1b7032a1e8c980  N/A        1      27    0.54%       12       11        1      761      761        0
   14  0xff1b70727ffd57c0  N/A        1       7    0.54%       12       12        0      219      218        1
   15  0xffffffffaefe2380  N/A        1       1    0.50%       11        8        3       14       14        0

Note: DMR simics does not support memory regions. Since the output is
captured on SPR, the memory region field shows "N/A" for all cachelines.

[1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/

Assisted-by: Sashiko:gemini-3.1-pro-preview
Assisted-by: GitHub-Copilot:claude-opus-4-8
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/
---
v3: make memory region reporting conditional on feature bit
---
 tools/perf/builtin-c2c.c | 140 +++++++++++++++++++++++++++++----------
 1 file changed, 105 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c9584dbedf77..6954a48c60e4 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -74,6 +74,7 @@ struct c2c_hist_entry {
 	unsigned long		*nodeset;
 	struct c2c_stats	*node_stats;
 	unsigned int		 cacheline_idx;
+	unsigned int		 mem_region;
 
 	struct compute_stats	 cstats;
 
@@ -281,6 +282,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
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
@@ -339,6 +352,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	struct addr_location al;
 	struct mem_info *mi = NULL;
 	struct callchain_cursor *cursor;
+	unsigned int mem_region;
 	int ret;
 
 	addr_location__init(&al);
@@ -366,6 +380,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 	c2c_decode_stats(&stats, mi);
+	mem_region = mem_info__data_src(mi)->mem_region;
 
 	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 				  &al, NULL, NULL, mi, NULL,
@@ -382,6 +397,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	c2c_he__set_cpu(c2c_he, sample);
 	c2c_he__set_node(c2c_he, sample);
 	c2c_he__set_evsel(c2c_he, evsel);
+	c2c_he__set_mem_region(c2c_he, mem_region);
 
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 
@@ -435,6 +451,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		c2c_he__set_cpu(c2c_he, sample);
 		c2c_he__set_node(c2c_he, sample);
 		c2c_he__set_evsel(c2c_he, evsel);
+		c2c_he__set_mem_region(c2c_he, mem_region);
 
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 		ret = hist_entry__append_callchain(he, sample);
@@ -603,6 +620,30 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
@@ -1425,7 +1466,7 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	}
 
 static struct c2c_dimension dim_dcacheline = {
-	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 2),
+	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 3),
 	.name		= "dcacheline",
 	.cmp		= dcacheline_cmp,
 	.entry		= dcacheline_entry,
@@ -1440,6 +1481,14 @@ static struct c2c_dimension dim_dcacheline_node = {
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
@@ -1871,6 +1920,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
+	&dim_dcacheline_mem_region,
 	&dim_dcacheline_node,
 	&dim_dcacheline_count,
 	&dim_offset,
@@ -2898,8 +2948,9 @@ static int ui_quirks(void)
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
 				dim_dcacheline.width +
+				dim_dcacheline_mem_region.width +
 				dim_dcacheline_node.width +
-				dim_dcacheline_count.width + 4);
+				dim_dcacheline_count.width + 6);
 	if (!buf)
 		return -ENOMEM;
 
@@ -3151,8 +3202,11 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
-	const char *output_str, *sort_str = NULL;
+	const char *sort_str = NULL;
+	char *output_str = NULL;
 	struct perf_env *env;
+	bool has_mem_regions;
+	int ret;
 
 	annotation_options__init();
 
@@ -3278,7 +3332,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	 * implementation.
 	 */
 	if (perf_c2c__has_annotation(NULL)) {
-		int ret = symbol__annotation_init();
+		ret = symbol__annotation_init();
 
 		if (ret < 0)
 			goto out_mem2node;
@@ -3316,36 +3370,50 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	if (c2c.display != DISPLAY_SNP_PEER)
-		output_str = "cl_idx,"
-			     "dcacheline,"
-			     "dcacheline_node,"
-			     "dcacheline_count,"
-			     "percent_costly_snoop,"
-			     "tot_hitm,lcl_hitm,rmt_hitm,"
-			     "tot_recs,"
-			     "tot_loads,"
-			     "tot_stores,"
-			     "stores_l1hit,stores_l1miss,stores_na,"
-			     "ld_fbhit,ld_l1hit,ld_l2hit,"
-			     "ld_lclhit,lcl_hitm,"
-			     "ld_rmthit,rmt_hitm,"
-			     "dram_lcl,dram_rmt";
-	else
-		output_str = "cl_idx,"
-			     "dcacheline,"
-			     "dcacheline_node,"
-			     "dcacheline_count,"
-			     "percent_costly_snoop,"
-			     "tot_peer,lcl_peer,rmt_peer,"
-			     "tot_recs,"
-			     "tot_loads,"
-			     "tot_stores,"
-			     "stores_l1hit,stores_l1miss,stores_na,"
-			     "ld_fbhit,ld_l1hit,ld_l2hit,"
-			     "ld_lclhit,lcl_hitm,"
-			     "ld_rmthit,rmt_hitm,"
-			     "dram_lcl,dram_rmt";
+	has_mem_regions = perf_header__has_feat(&session->header,
+						HEADER_MEMORY_RANGES);
+
+	if (c2c.display != DISPLAY_SNP_PEER) {
+		ret = asprintf(&output_str,
+			       "cl_idx,"
+			       "dcacheline,"
+			       "%s"
+			       "dcacheline_node,"
+			       "dcacheline_count,"
+			       "percent_costly_snoop,"
+			       "tot_hitm,lcl_hitm,rmt_hitm,"
+			       "tot_recs,"
+			       "tot_loads,"
+			       "tot_stores,"
+			       "stores_l1hit,stores_l1miss,stores_na,"
+			       "ld_fbhit,ld_l1hit,ld_l2hit,"
+			       "ld_lclhit,lcl_hitm,"
+			       "ld_rmthit,rmt_hitm,"
+			       "dram_lcl,dram_rmt",
+			       has_mem_regions ? "dcacheline_mem_region," : "");
+		if (ret < 0)
+			goto out_mem2node;
+	} else {
+		ret = asprintf(&output_str,
+			       "cl_idx,"
+			       "dcacheline,"
+			       "%s"
+			       "dcacheline_node,"
+			       "dcacheline_count,"
+			       "percent_costly_snoop,"
+			       "tot_peer,lcl_peer,rmt_peer,"
+			       "tot_recs,"
+			       "tot_loads,"
+			       "tot_stores,"
+			       "stores_l1hit,stores_l1miss,stores_na,"
+			       "ld_fbhit,ld_l1hit,ld_l2hit,"
+			       "ld_lclhit,lcl_hitm,"
+			       "ld_rmthit,rmt_hitm,"
+			       "dram_lcl,dram_rmt",
+			       has_mem_regions ? "dcacheline_mem_region," : "");
+		if (ret < 0)
+			goto out_mem2node;
+	}
 
 	if (c2c.display == DISPLAY_TOT_HITM)
 		sort_str = "tot_hitm";
@@ -3368,11 +3436,13 @@ static int perf_c2c__report(int argc, const char **argv)
 
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
-- 
2.55.0


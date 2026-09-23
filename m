Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ADD519DE7;
	Wed, 23 Sep 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179038; cv=none; b=CuJC6Q97bO30Jyzuus3Q/72kZWqugiF/aOqNpAwZN00wQ6tQRBkkTrjSQEx5qxrJg+YLfkUG/OAUQgo1y9gbGXA/YlBAQdzvlE145/eHgAkwu7GGQxYhrW/ZJ/WC9cMbrk2M63G/ns8gWxdcfPMhm3wSrlGYYdcQ9esawUFeH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179038; c=relaxed/simple;
	bh=w8TbIiOpQ7bE19y47kGM0xVJA3lsoPU/laYEfHXkYCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qp9sZ8E4OqWWnqZreXdBQxlSVzZ8NI5iL1ISiZ2OcNtsnJ5xIcoykfjVoLNhgNdr/kSTO4B+goutYuxabLs3Ydk9JIx32dt+1slw+OQJHz5As3r93MqeGvuPVUyUxAnLALefPVZqgnmi//9/kW14azWSY7nTlB+Jz1gpA/rZs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQyQmZxi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQyQmZxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790179034; x=1821715034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8TbIiOpQ7bE19y47kGM0xVJA3lsoPU/laYEfHXkYCw=;
  b=mQyQmZxiUxr/uSLEUpEYSaoYZcdvtTc7Va4h6AFpCeWXxrFj/LWpS9Ig
   Ybe/NS35hfDPsFwRePMXWNDWd7Cusywsh0ex3ZQL/VpVKeKwiWQzzRfzS
   n/EcYEltP1+wIcDKnYGxW7cmDA7iXrS7oIxMGD7aWquMoWMpN63C8r3EK
   R/rZ/AYwqq00vbkw0gkmbF5IxPKaB9KcDWpreqKsg75F3oMd7SSRLvLgL
   a8UWoSuISy5QGLiNqgnZ+tkQF+2WvIWnjlHf2JtmOgUfSs2pRNqIck14o
   VGLcWB6qP9Vo/WHuLWOojP/xcwVwNu+mKYlraRk75vKyMXG89iENZttuS
   g==;
X-CSE-ConnectionGUID: 032twSy+Q+Cwj0Yi1e3UzQ==
X-CSE-MsgGUID: sDOqhqbbSaSvs6YgBFdtog==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="78445954"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="78445954"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:13 -0700
X-CSE-ConnectionGUID: O5ZFs3UvR5KsiuLK0tu5Gg==
X-CSE-MsgGUID: 5epTutgBQS++SDUak7zeAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4935333"
Received: from rosenzwe-mobl1.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.221.119])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 08:57:12 -0700
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
Subject: [PATCH v11 4/6] perf tools: Show memory region in perf-c2c subcommand
Date: Wed, 23 Sep 2026 10:57:01 -0500
Message-ID: <20260923155703.34814-5-thomas.falcon@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add memory region field to the cacheline list view to help users
identify the memory region to which the cacheline belongs. The memory
region field was included with the introduction of support for the
Off-module Response facility (OMR) [1] in Intel's Diamond Rapids and
Nova Lake architectures.

An example of the new perf c2c output including the memory region
field is shown below:

# Index             Address  Region  Node  PA cnt     Hitm    Total  LclHitm  RmtHitm  records    Loads
# .....  ..................  ......  ....  ......  .......  .......  .......  .......  .......  .......
#
      0  0xffffffff84eb0040     N/A     0    1205   23.25%      544      544        0     1677     1677
      1  0xffffffff84f03a80     N/A     0       1   18.12%      424      424        0      585      585
[...]
     19  0xffffffff845bc840   Mem-0     0      13    0.30%        7        7        0       31       31
     20  0xff3bbba284520a00     N/A     0      10    0.26%        6        6        0       11       11
     21  0xff3bbbe0bc833500     N/A     0      24    0.26%        6        6        0       30       30

[1]: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.intel.com/

Assisted-by: Sashiko:gemini-3.1-pro-preview
Assisted-by: GitHub-Copilot:claude-opus-4-8
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
v11: perf-c2c: revert to only recording a real memory region for a
     cacheline
v10: only update mem_region for real cache/memory regions so N/A samples
     don't overwrite a valid region; add #include <stdio.h> for asprintf
     (Sashiko)
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
 tools/perf/builtin-c2c.c | 114 +++++++++++++++++++++++++++++++++++----
 tools/perf/util/c2c.h    |   1 +
 2 files changed, 104 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 6b64c0d6b24f..a42423ca990d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -14,6 +14,7 @@
 #include <inttypes.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdio.h>
 
 #include <asm/bug.h>
 #include <linux/compiler.h>
@@ -72,6 +73,7 @@ struct perf_c2c {
 
 	bool			 show_src;
 	bool			 show_all;
+	bool			 show_mem_region;
 	bool			 use_stdio;
 	bool			 stats_only;
 	bool			 symbol_full;
@@ -248,6 +250,18 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
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
@@ -306,6 +320,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	struct addr_location al;
 	struct mem_info *mi = NULL;
 	struct callchain_cursor *cursor;
+	unsigned int mem_region;
 	int ret;
 
 	addr_location__init(&al);
@@ -333,6 +348,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 	c2c_decode_stats(&stats, mi);
+	mem_region = mem_info__data_src(mi)->mem_region;
 
 	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 				  &al, NULL, NULL, mi, NULL,
@@ -349,6 +365,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	c2c_he__set_cpu(c2c_he, sample);
 	c2c_he__set_node(c2c_he, sample);
 	c2c_he__set_evsel(c2c_he, evsel);
+	c2c_he__set_mem_region(c2c_he, mem_region);
 
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 
@@ -402,6 +419,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		c2c_he__set_cpu(c2c_he, sample);
 		c2c_he__set_node(c2c_he, sample);
 		c2c_he__set_evsel(c2c_he, evsel);
+		c2c_he__set_mem_region(c2c_he, mem_region);
 
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
 		ret = hist_entry__append_callchain(he, sample);
@@ -540,6 +558,45 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
+	switch (mem_region) {
+	case PERF_MEM_REGION_NA:
+	case PERF_MEM_REGION_RSVD:
+		scnprintf(buf, sizeof(buf), "N/A");
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
@@ -1360,6 +1417,14 @@ static struct c2c_dimension dim_dcacheline_node = {
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
@@ -1791,6 +1856,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
+	&dim_dcacheline_mem_region,
 	&dim_dcacheline_node,
 	&dim_dcacheline_count,
 	&dim_offset,
@@ -2854,8 +2920,11 @@ static int ui_quirks(void)
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
 
@@ -3107,7 +3176,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
-	const char *output_str, *sort_str = NULL;
+	const char *sort_str = NULL;
+	char *output_str = NULL;
 	struct perf_env *env;
 
 	annotation_options__init();
@@ -3272,9 +3342,16 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3286,10 +3363,17 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3301,7 +3385,13 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3315,7 +3405,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	err = c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
 	if (err) {
 		pr_err("Failed to reinitialize hists\n");
-		goto out_mem2node;
+		goto out_str;
 	}
 
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
@@ -3324,17 +3414,19 @@ static int perf_c2c__report(int argc, const char **argv)
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


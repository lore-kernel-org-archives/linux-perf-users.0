Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964B4499AA;
	Thu,  9 Jul 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635478; cv=none; b=KjG/ENMPYG8laQXcMCRDqnZ6M/+1BOueuulNfSAwpZTACtzqBI93o4q3bvtL383Gx0xySLehIdR7J8PawvoskDajJJwx4W4ASBOJdgUnqNd7YrOkhJN4n5B4U0aRkqSWBr15l+1fvBlPxuQ1mkV1ZuiSFW3PAeTsiSIMCK7SdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635478; c=relaxed/simple;
	bh=jiuF6CmoBw5k//pwnwV0KiyTscSt/1nSutOdyoPmtqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpcB7ngVb6/H+nr0zGv5oeY8AhVTp+HDZBHK92jJoL3OjUT+/LFRYwHrEVFxW1VlDQxilOVjZBGq0nSjwgX0G801gxQsYuxs/F3mo1oK8z/rr6gfCjlFVT4Mh2KHJTBODw6N0JAxy8Ob7VvVY5Q0U6XIPHAWP8kfYOlGT0ouPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAMgc9B6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAMgc9B6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635476; x=1815171476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jiuF6CmoBw5k//pwnwV0KiyTscSt/1nSutOdyoPmtqo=;
  b=NAMgc9B6hb4NNx50kYk1wOT7wbzJBOuZ9e/1oyoq8FejVoXROCQzvMfw
   r593z8KNWZUi59q7++ySy86jeJWcRvh6sg+1F+0s2LcxPWH/gcgzafL2h
   kPd+A8FVWrsoBMcsXa/zCe48r26btDAxpb9WvEcyAaXmUAWIxckLsbbDC
   p8S+hUhEIJARKHzNJkjzVLDbo2UJ5sed53iDdjHFQjqGpB1VzSqS8XUvJ
   vsj0+pPs6aOZC0gxv5oW0TF0dWVU05JMy0gykVqwiEqYEy55pnQ/9rKcB
   Givko4EhgkzjSEQKDTYFdM+1yZ3scFuAAto2Q8yt75ZmdtlZjLIKzGd84
   Q==;
X-CSE-ConnectionGUID: 7jvcTfcTT3yQmUxxvcFgwA==
X-CSE-MsgGUID: Dv4jz0A1QsGB+UTOk2448Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88163382"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88163382"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:53 -0700
X-CSE-ConnectionGUID: XQkE4R9RTxu66XeEClKyHQ==
X-CSE-MsgGUID: RrcRJ1cRRy+1xezaldJGbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259620896"
Received: from khuang2-desk.gar.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.223.97])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:17:51 -0700
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
Subject: [PATCH 3/6] perf tools: Show memory region in perf-c2c subcommand
Date: Thu,  9 Jul 2026 17:17:33 -0500
Message-ID: <20260709221736.33446-4-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709221736.33446-1-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
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
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/builtin-c2c.c | 56 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c9584dbedf77..57e822dbd2d4 100644
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
+		      "WARNING: invalid memory region ID"))
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
@@ -603,6 +620,29 @@ dcacheline_node_count(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
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
+		scnprintf(buf, sizeof(buf), "0x%x", mem_region - 0x8);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			struct hist_entry *he)
 {
@@ -1425,7 +1465,7 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	}
 
 static struct c2c_dimension dim_dcacheline = {
-	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 2),
+	.header		= HEADER_SPAN("--- Cacheline ----", "Address", 3),
 	.name		= "dcacheline",
 	.cmp		= dcacheline_cmp,
 	.entry		= dcacheline_entry,
@@ -1440,6 +1480,14 @@ static struct c2c_dimension dim_dcacheline_node = {
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
@@ -1871,6 +1919,7 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
+	&dim_dcacheline_mem_region,
 	&dim_dcacheline_node,
 	&dim_dcacheline_count,
 	&dim_offset,
@@ -2898,8 +2947,9 @@ static int ui_quirks(void)
 	/* Fix the zero line for dcacheline column. */
 	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
 				dim_dcacheline.width +
+				dim_dcacheline_mem_region.width +
 				dim_dcacheline_node.width +
-				dim_dcacheline_count.width + 4);
+				dim_dcacheline_count.width + 6);
 	if (!buf)
 		return -ENOMEM;
 
@@ -3319,6 +3369,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (c2c.display != DISPLAY_SNP_PEER)
 		output_str = "cl_idx,"
 			     "dcacheline,"
+			     "dcacheline_mem_region,"
 			     "dcacheline_node,"
 			     "dcacheline_count,"
 			     "percent_costly_snoop,"
@@ -3334,6 +3385,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	else
 		output_str = "cl_idx,"
 			     "dcacheline,"
+			     "dcacheline_mem_region,"
 			     "dcacheline_node,"
 			     "dcacheline_count,"
 			     "percent_costly_snoop,"
-- 
2.43.0


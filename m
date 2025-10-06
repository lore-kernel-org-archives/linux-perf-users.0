Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5D27A135
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773466; cv=none; b=hNSZo6keSVvfAjuxJCRUNw9km6NFcaTR469Pc3jiLKx1TmYc+MIcc8LrTAyHl/utkfKu0J9nuHSMeTzfa2qw3kp5S/Ws8BXpHuvjUrgbYxyJPaur0T6gvzM8ixXfKywu2gXgnLsC5Dgi7fGDmyDsxd77nTUz0cWMj1AZXEbMKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773466; c=relaxed/simple;
	bh=S/BxESrMan0JtxrHPW8i7Xc7hE31fx5zX6z9oUT9nuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1vQ8lsA4WvlapAJZFhtyCfaCyi4f0Dt3D3OtX2xXK/Ro69C7oKzzq9V0mJ27IGWsHwIw1+tiiheJDHEjWjqZWOH51DRSxkZ/yxOrUf2X9JfQT0ADhFiBA+51m1tGyB7Qcx7VZVhCB6aTVwFyWXVF4lpiiZyzMbKTdMZ2ZYzBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYRhT4Vj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYRhT4Vj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759773463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTk30EwMlyNqVl6drCXBMH0LUsPA1PftNYV98ikqf3k=;
	b=RYRhT4Vj7zulch+e5UhEB9OrayKP/+o08tMQnbhERwc1plK534BCRN6w+0nj5jCVPvGG0d
	vC4c8ShKlTfrt6bjUi4nE6IBvKvZGdQyM+VbEmwO5IauI/6hpprzaYQyeW++2Tx7Mt/VbZ
	d7MVm9FcfsTK2nOZf8FntoxWjmkyuhA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-Kjc5x7-dN7CW_9yIMZYz9Q-1; Mon,
 06 Oct 2025 13:57:39 -0400
X-MC-Unique: Kjc5x7-dN7CW_9yIMZYz9Q-1
X-Mimecast-MFC-AGG-ID: Kjc5x7-dN7CW_9yIMZYz9Q_1759773458
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC17A1800607;
	Mon,  6 Oct 2025 17:57:32 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.22.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFC5519560A2;
	Mon,  6 Oct 2025 17:57:29 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	irogers@google.com,
	namhyung@kernel.org
Cc: jmario@redhat.com,
	jolsa@kernel.org
Subject: [PATCH 4/4] perf c2c report: Add --detect-shm option
Date: Mon,  6 Oct 2025 19:57:10 +0200
Message-ID: <20251006175710.1179040-5-mpetlan@redhat.com>
In-Reply-To: <20251006175710.1179040-1-mpetlan@redhat.com>
References: <20251006175710.1179040-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add an option that allows merging shared cachelines. In order to
better understand the problem, another column with physical memory
address is added to the Cacheline dimension.

Since the "PA Cnt" column contains obviously incorrect data, remove
it from Shared Data Cache Line Table to save space.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Joe Mario <jmario@redhat.com>

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-c2c.c | 102 +++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 78bcc18b7891..6f9a65528654 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -111,6 +111,7 @@ struct perf_c2c {
 	bool			 stats_only;
 	bool			 symbol_full;
 	bool			 stitch_lbr;
+	bool			 phys;
 
 	/* Shared cache line stats */
 	struct c2c_stats	shared_clines_stats;
@@ -329,6 +330,13 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		goto out;
 	}
 
+	/* Keep only accesses to shared memory for --phys mode. */
+	if (c2c.phys && !map_is_shared_memory(mi->daddr.ms.map)) {
+		mem_info__put(mi);
+		ret = 0;
+		goto out;
+	}
+
 	/*
 	 * The mi object is released in hists__add_entry_ops,
 	 * if it gets sorted out into existing data, so we need
@@ -515,11 +523,20 @@ static int c2c_header(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	__s;						\
 })
 
+static int64_t
+sort__dcacheline_phys_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return left->mem_info->daddr.phys_addr - right->mem_info->daddr.phys_addr;
+}
+
 static int64_t
 dcacheline_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	       struct hist_entry *left, struct hist_entry *right)
 {
-	return sort__dcacheline_cmp(left, right);
+	if (c2c.phys)
+		return sort__dcacheline_phys_cmp(left, right);
+	else
+		return sort__dcacheline_cmp(left, right);
 }
 
 static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
@@ -535,6 +552,20 @@ static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
 }
 
+static int
+dcacheline_phys_addr_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			   struct hist_entry *he)
+{
+	uint64_t addr = 0;
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[20];
+
+	if (he->mem_info)
+		addr = cl_address(mem_info__daddr(he->mem_info)->phys_addr, chk_double_cl);
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
+}
+
 static int
 dcacheline_node_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 		      struct hist_entry *he)
@@ -1433,6 +1464,14 @@ static struct c2c_dimension dim_dcacheline = {
 	.width		= 18,
 };
 
+static struct c2c_dimension dim_dcacheline_phys_addr = {
+	.header		= HEADER_LOW("Phys Address"),
+	.name		= "dcacheline_phys_addr",
+	.cmp		= empty_cmp,
+	.entry		= dcacheline_phys_addr_entry,
+	.width		= 18,
+};
+
 static struct c2c_dimension dim_dcacheline_node = {
 	.header		= HEADER_LOW("Node"),
 	.name		= "dcacheline_node",
@@ -1888,6 +1927,7 @@ static struct c2c_dimension dim_dcacheline_map = {
 
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
+	&dim_dcacheline_phys_addr,
 	&dim_dcacheline_node,
 	&dim_dcacheline_count,
 	&dim_offset,
@@ -2869,7 +2909,7 @@ static int ui_quirks(void)
 	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
 				dim_dcacheline.width +
 				dim_dcacheline_node.width +
-				dim_dcacheline_count.width + 4);
+				(c2c.phys ? dim_dcacheline_phys_addr.width : dim_dcacheline_count.width) + 4);
 	if (!buf)
 		return -ENOMEM;
 
@@ -2878,6 +2918,7 @@ static int ui_quirks(void)
 	/* Fix the zero line for offset column. */
 	buf = fill_line(nodestr, dim_offset.width +
 			         dim_offset_node.width +
+			         (c2c.phys ? dim_dcacheline_phys_addr.width + 2 : 0) +
 				 dim_dcacheline_count.width + 4);
 	if (!buf)
 		return -ENOMEM;
@@ -3004,7 +3045,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	}
 
 	if (asprintf(&c2c.cl_output,
-		"%s%s%s%s%s%s%s%s%s%s%s%s",
+		"%s%s%s%s%s%s%s%s%s%s%s%s%s",
 		c2c.use_stdio ? "cl_num_empty," : "",
 		c2c.display == DISPLAY_SNP_PEER ? "percent_rmt_peer,"
 						  "percent_lcl_peer," :
@@ -3014,6 +3055,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		"percent_stores_l1miss,"
 		"percent_stores_na,"
 		"offset,offset_node,dcacheline_count,",
+		c2c.phys ? "dcacheline_phys_addr," : "",
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
 		add_iaddr ? "iaddr," : "",
@@ -3100,6 +3142,7 @@ static int perf_c2c__report(int argc, const char **argv)
 		    "Do not display Source Line column"),
 	OPT_BOOLEAN(0, "show-all", &c2c.show_all,
 		    "Show all captured HITM lines."),
+	OPT_BOOLEAN(0, "detect-shm", &c2c.phys, "Merge shared cachelines"),
 	OPT_CALLBACK_DEFAULT('g', "call-graph", &callchain_param,
 			     "print_type,threshold[,print_limit],order,sort_key[,branch],value",
 			     callchain_help, &parse_callchain_opt,
@@ -3115,7 +3158,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_END()
 	};
 	int err = 0;
-	const char *output_str, *sort_str = NULL;
+	char *output_str;
+	const char *sort_str = NULL;
 	struct perf_env *env;
 
 	argc = parse_options(argc, argv, options, report_c2c_usage,
@@ -3226,38 +3270,22 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	if (c2c.display != DISPLAY_SNP_PEER)
-		output_str = "cl_idx,"
-			     "cl_shared,"
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
-			     "dram_lcl,dram_rmt,cl_map";
-	else
-		output_str = "cl_idx,"
-			     "cl_shared,"
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
-			     "dram_lcl,dram_rmt,cl_map";
+	if (asprintf(&output_str, "%s%s%s%s%s",
+				"cl_idx,"
+				"cl_shared,"
+				"dcacheline,",
+				c2c.phys ? "dcacheline_phys_addr,dcacheline_node," : "dcacheline_node,dcacheline_count,",
+				"percent_costly_snoop,",
+				(c2c.display == DISPLAY_SNP_PEER) ? "tot_peer,lcl_peer,rmt_peer," : "tot_hitm,lcl_hitm,rmt_hitm,",
+				"tot_recs,"
+				"tot_loads,"
+				"tot_stores,"
+				"stores_l1hit,stores_l1miss,stores_na,"
+				"ld_fbhit,ld_l1hit,ld_l2hit,"
+				"ld_lclhit,lcl_hitm,"
+				"ld_rmthit,rmt_hitm,"
+				"dram_lcl,dram_rmt,cl_map") < 0)
+		goto out_mem2node;
 
 	if (c2c.display == DISPLAY_TOT_HITM)
 		sort_str = "tot_hitm";
@@ -3270,6 +3298,8 @@ static int perf_c2c__report(int argc, const char **argv)
 
 	c2c_hists__reinit(&c2c.hists, output_str, sort_str, perf_session__env(session));
 
+	free(output_str);
+
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
 	hists__collapse_resort(&c2c.hists.hists, NULL);
-- 
2.47.3


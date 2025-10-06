Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724F242D6F
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773474; cv=none; b=QhEez8GMuDz8uqTDrAlKZGl/R65o8bRxwfcjLfRa853ixrTaq/LKw83AX4fOlOJAhZ3IOBCOOAlYDgCvfNXOuGlqO3fL3HUCAyRgZyqMZQlh6/624ILOzJfsG8MXUBEIGzFJ5XKsmhE9r4eeW7zYmDyjfQcTyiJbbjbqhzrRIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773474; c=relaxed/simple;
	bh=0TDZ6raYXIioMbP08miDANxT5nZ4ypROR4TPYpMELo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdJAJRvaU+ZUyPAdmC3fo+F1QOlbQryEyoqdljFHWzR5lytIzOvA01F0PrVi6Mi/roHog/o6bHkB9k/IwL50Hqd1Bx8kQH+MnGuGtkiiYp+++cjoJv5Eo4rtN5or99KwV7ztCiBLaC2aP9pN2JqzJ/l7zmaEtyH72UyQjn+alr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnN0oxMx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnN0oxMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759773472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDuwNjFjIGZCW6tq82OT7HjAU6QpB4bvnBBXAWkcXc0=;
	b=LnN0oxMx0WgjFF0M/cYy5kBnnCJDCrIsoriFOhVXaQ2/ugKQ869DUkDybcaUJZpTXesPSv
	ChsmAlohsJLnGX8IjHKFsuu/2OiASDlJxC7M3Mu6TaenTeXV5tSlbiRD1gJd9iWHNxyHVq
	ShXtP/dFnZkOpay0vbiSlHyEUP3neCY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-Q2FaibzfN-yo6E5d7w1nzw-1; Mon,
 06 Oct 2025 13:57:43 -0400
X-MC-Unique: Q2FaibzfN-yo6E5d7w1nzw-1
X-Mimecast-MFC-AGG-ID: Q2FaibzfN-yo6E5d7w1nzw_1759773457
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07AF01805A22;
	Mon,  6 Oct 2025 17:57:29 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.22.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E261419560A2;
	Mon,  6 Oct 2025 17:57:25 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	irogers@google.com,
	namhyung@kernel.org
Cc: jmario@redhat.com,
	jolsa@kernel.org
Subject: [PATCH 3/4] perf c2c: Add map name for cacheline
Date: Mon,  6 Oct 2025 19:57:09 +0200
Message-ID: <20251006175710.1179040-4-mpetlan@redhat.com>
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

Add column showing address range of the entries in Shared Data Cache
Line Table.

Suggested-by: Joe Mario <jmario@redhat.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-c2c.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index ab77ea7b188c..78bcc18b7891 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1368,6 +1368,28 @@ cl_shared_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
 }
 
+static int
+cl_map_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+			 struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[100];
+	struct map *map = he->mem_info->daddr.ms.map;
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	c2c_he__resolve_shared_mem(c2c_he);
+
+	if (map) {
+		scnprintf(buf, 100, "%lx-%lx %s", map->start, map->end,
+				  map->dso ? map->dso->name : "N/A");
+	} else {
+		scnprintf(buf, 100, "N/A");
+	}
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 #define HEADER_LOW(__h)			\
 	{				\
 		.line[1] = {		\
@@ -1856,6 +1878,14 @@ static struct c2c_dimension dim_dcacheline_shared = {
 	.width		= 1,
 };
 
+static struct c2c_dimension dim_dcacheline_map = {
+	.header		= HEADER_LOW("Map"),
+	.name		= "cl_map",
+	.cmp		= empty_cmp,
+	.entry		= cl_map_entry,
+	.width		= 3,
+};
+
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
 	&dim_dcacheline_node,
@@ -1913,6 +1943,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline_num,
 	&dim_dcacheline_num_empty,
 	&dim_dcacheline_shared,
+	&dim_dcacheline_map,
 	NULL,
 };
 
@@ -3210,7 +3241,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			     "ld_fbhit,ld_l1hit,ld_l2hit,"
 			     "ld_lclhit,lcl_hitm,"
 			     "ld_rmthit,rmt_hitm,"
-			     "dram_lcl,dram_rmt";
+			     "dram_lcl,dram_rmt,cl_map";
 	else
 		output_str = "cl_idx,"
 			     "cl_shared,"
@@ -3226,7 +3257,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			     "ld_fbhit,ld_l1hit,ld_l2hit,"
 			     "ld_lclhit,lcl_hitm,"
 			     "ld_rmthit,rmt_hitm,"
-			     "dram_lcl,dram_rmt";
+			     "dram_lcl,dram_rmt,cl_map";
 
 	if (c2c.display == DISPLAY_TOT_HITM)
 		sort_str = "tot_hitm";
-- 
2.47.3


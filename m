Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734D27A135
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773463; cv=none; b=Cmnj2k4ZcmtXHZmqKL/XHVAeMKcaryXnUAwo9a7e6BQApwSODpnNbapGBy7UbyvLNhaGus5cKdi/qFmKfcakGcP28viQ2UsJK0DAhmsPCVrL6dz7c68CXIEZ0tc/xfvZNJy6og/bR+O701k94ZkgZv612Z3mhR0t25i8dQidSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773463; c=relaxed/simple;
	bh=yM9WMVlEWmkCR9xre9UdunssF/fmkKugJiD2i4rSqss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlBUd7cayz7VcXKraCzs4Tt0j4JPSBjtyAV7gqppwW7bNNwj5iKrE5AKG8zT7gzOacGcn4BmEHhFGv0ItmeO5r3Lzq6bpSMphPod4Vqs1EuIwx4Jcl8SZ6xjb8jnpitfOtY98pw0hu86m8U8GAuWzdwGJw5BSzG0X5HoLeU3ix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNH36T/o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNH36T/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759773461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy0BNnlTgInjvYgYZPqU7dgZ/NLoIjWHwZ8cWFP7qbc=;
	b=KNH36T/ofmmxbLVSd8gkl3Vr6bF5c5JCqXOJrF+ZEQeTYEAXaziTTt7pfKxxTpwjTtzs7R
	IkNCrAiIWNKMP2w0qjSZEm2GcY4l80B+BHTK7+4n1Na2lAv/ilosIRqlQpx5pXIXzfqrlK
	+ntCzvkDAZUAEf59PnDxkhAU2DYlzBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-a_-xQRZcOEiHfOqdiXjw3w-1; Mon,
 06 Oct 2025 13:57:38 -0400
X-MC-Unique: a_-xQRZcOEiHfOqdiXjw3w-1
X-Mimecast-MFC-AGG-ID: a_-xQRZcOEiHfOqdiXjw3w_1759773457
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E444518005A0;
	Mon,  6 Oct 2025 17:57:24 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.22.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A40B719560A2;
	Mon,  6 Oct 2025 17:57:21 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	irogers@google.com,
	namhyung@kernel.org
Cc: jmario@redhat.com,
	jolsa@kernel.org
Subject: [PATCH 2/4] perf c2c: Add shared mem flag
Date: Mon,  6 Oct 2025 19:57:08 +0200
Message-ID: <20251006175710.1179040-3-mpetlan@redhat.com>
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

In perf-c2c report, it was impossible to detect shared memory. That
may hide important facts about the cache-line usage.

Add an "S" flag to the Shared Data Cache Line Table marking entries
using shared memory.

Suggested-by: Joe Mario <jmario@redhat.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-c2c.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 9e9ff471ddd1..ab77ea7b188c 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -19,6 +19,7 @@
 #include <linux/zalloc.h>
 #include <asm/bug.h>
 #include <sys/param.h>
+#include <sys/mman.h>
 #include "debug.h"
 #include "builtin.h"
 #include <perf/cpumap.h>
@@ -45,6 +46,14 @@
 #include "pmus.h"
 #include "string2.h"
 #include "util/util.h"
+#include "dso.h"
+#include "map.h"
+
+enum shared_mem {
+	SHARED_MEM__UNKNOWN	= -1,
+	SHARED_MEM__NO		=  0,
+	SHARED_MEM__YES		=  1,
+};
 
 struct c2c_hists {
 	struct hists		hists;
@@ -74,6 +83,7 @@ struct c2c_hist_entry {
 	unsigned long		 paddr_cnt;
 	bool			 paddr_zero;
 	char			*nodestr;
+	enum shared_mem		 shared_mem;
 
 	/*
 	 * must be at the end,
@@ -275,6 +285,12 @@ static void compute_stats(struct c2c_hist_entry *c2c_he,
 		update_stats(&cstats->load, weight);
 }
 
+static bool map_is_shared_memory(struct map *map)
+{
+	return map && map->flags & MAP_SHARED && map->dso &&
+		!strncmp(map->dso->name, "/SYSV", sizeof("/SYSV") - 1);
+}
+
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -1330,6 +1346,28 @@ cl_idx_empty_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, "");
 }
 
+static void
+c2c_he__resolve_shared_mem(struct c2c_hist_entry *c2c_he)
+{
+	if (c2c_he->shared_mem != SHARED_MEM__UNKNOWN)
+		c2c_he->shared_mem = map_is_shared_memory(c2c_he->he.mem_info->daddr.ms.map);
+}
+
+static int
+cl_shared_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+				struct hist_entry *he)
+{
+	struct c2c_hist_entry *c2c_he;
+	int width = c2c_width(fmt, hpp, he->hists);
+	char buf[10];
+
+	c2c_he = container_of(he, struct c2c_hist_entry, he);
+	c2c_he__resolve_shared_mem(c2c_he);
+
+	scnprintf(buf, 10, c2c_he->shared_mem == SHARED_MEM__YES ? "S" : " ");
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
+}
+
 #define HEADER_LOW(__h)			\
 	{				\
 		.line[1] = {		\
@@ -1810,6 +1848,14 @@ static struct c2c_dimension dim_dcacheline_num_empty = {
 	.width		= 5,
 };
 
+static struct c2c_dimension dim_dcacheline_shared = {
+	.header		= HEADER_LOW(""),
+	.name		= "cl_shared",
+	.cmp		= empty_cmp,
+	.entry		= cl_shared_entry,
+	.width		= 1,
+};
+
 static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline,
 	&dim_dcacheline_node,
@@ -1866,6 +1912,7 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_dcacheline_idx,
 	&dim_dcacheline_num,
 	&dim_dcacheline_num_empty,
+	&dim_dcacheline_shared,
 	NULL,
 };
 
@@ -3150,6 +3197,7 @@ static int perf_c2c__report(int argc, const char **argv)
 
 	if (c2c.display != DISPLAY_SNP_PEER)
 		output_str = "cl_idx,"
+			     "cl_shared,"
 			     "dcacheline,"
 			     "dcacheline_node,"
 			     "dcacheline_count,"
@@ -3165,6 +3213,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			     "dram_lcl,dram_rmt";
 	else
 		output_str = "cl_idx,"
+			     "cl_shared,"
 			     "dcacheline,"
 			     "dcacheline_node,"
 			     "dcacheline_count,"
-- 
2.47.3


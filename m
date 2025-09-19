Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5E25A626;
	Fri, 19 Sep 2025 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248323; cv=none; b=rdrMbxfJCESvYPQstPZwMb5++3woDprh2cGposLN3J+i1DLNvetMPiBR25TlaMXDzhxN5M6Ipb4QZqzJUsBNY7EfBOL7h1PHFj8YApe4DJaV34zPRAHHH9c+5s8oIu6h0NKzQqqzOtQpwA1y/KkMUwA+CKDB8EU1XOr7EiY62p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248323; c=relaxed/simple;
	bh=5otLIvgribi/H89sXWTHdrjVv3hyG9Xes4ulCNTnrO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUC5lAYGC603jmLIVY2BREqHKkaTnxQQXp0FqY8aa7h5ngrkMr0eOKhPnwBxWeG3WuNazE2hVrNDqHl7+UXfLxoXB3KV3Sz+/A9AhicODYEle+lhXogyeRNfxRKgSjYTDoQ2m7vuSF6exH5LtGfcMcxfSerfQH9NqtYUqXmCsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6DlzQGh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6DlzQGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248323; x=1789784323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5otLIvgribi/H89sXWTHdrjVv3hyG9Xes4ulCNTnrO0=;
  b=k6DlzQGhrYyxyXmXQqHKCNPTPgnZlAZNpDwBAaP/ONmISlRDW9Y8acIy
   /by/pytffVCb0H+rjj32ItBef4AYVDYJQb82Mj3txF/jusk+nEE1gImkm
   iOeI/nbYDYVT6whlB9Eu5L2Se+EN3/CozFuqZL1cOwOx2DPv8t0fJdwXW
   tCc3lF+1qPvnuYuGvBeMKp50zPUcFCZhLLTJYI8UJy2bh+zWLe0GutI8v
   RJjLIhtam348G2emEOBCjHdGix7+ruLfObjRW8HvoUlW2fPHkvH5kHZSr
   SXR+bWOqlvJm2sznQUG7ivr7a8EhROyL+HT6PInxWmzoMRuPTrckqIJiz
   A==;
X-CSE-ConnectionGUID: XvSXJDGbTFS3vzQXzUsN8Q==
X-CSE-MsgGUID: WyG/0SlUTIeYt+9pF/TRRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229125"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64229125"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:18:42 -0700
X-CSE-ConnectionGUID: uLM+hOqASY+4McPPOpqRqg==
X-CSE-MsgGUID: q5Bt265+Rq64lIId70jYrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175535604"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2025 19:18:39 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 2/6] perf tools kwork: Add missed memory allocation check and free
Date: Fri, 19 Sep 2025 10:16:55 +0800
Message-Id: <20250919021659.1263351-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same with previous builtin-kvm code, perf_kwork__record() doesn't check
the memory allocation and explicitly free the allocated memory. Just fix
it.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kwork.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index d2e08de5976d..7f3068264568 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2273,12 +2273,23 @@ static void setup_event_list(struct perf_kwork *kwork,
 	pr_debug("\n");
 }
 
+#define STRDUP_FAIL_EXIT(s)		\
+	({	char *_p;		\
+		_p = strdup(s);		\
+		if (!_p) {		\
+			ret = -ENOMEM;	\
+			goto EXIT;	\
+		}			\
+		_p;			\
+	})
+
 static int perf_kwork__record(struct perf_kwork *kwork,
 			      int argc, const char **argv)
 {
 	const char **rec_argv;
 	unsigned int rec_argc, i, j;
 	struct kwork_class *class;
+	int ret;
 
 	const char *const record_args[] = {
 		"record",
@@ -2298,17 +2309,17 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = strdup(record_args[i]);
+		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
 
 	list_for_each_entry(class, &kwork->class_list, list) {
 		for (j = 0; j < class->nr_tracepoints; j++) {
-			rec_argv[i++] = strdup("-e");
-			rec_argv[i++] = strdup(class->tp_handlers[j].name);
+			rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
+			rec_argv[i++] = STRDUP_FAIL_EXIT(class->tp_handlers[j].name);
 		}
 	}
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
@@ -2317,7 +2328,13 @@ static int perf_kwork__record(struct perf_kwork *kwork,
 		pr_debug("%s ", rec_argv[j]);
 	pr_debug("\n");
 
-	return cmd_record(i, rec_argv);
+	ret = cmd_record(i, rec_argv);
+
+EXIT:
+	for (i = 0; i < rec_argc; i++)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
 }
 
 int cmd_kwork(int argc, const char **argv)
-- 
2.34.1


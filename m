Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FD03C345D;
	Tue,  2 Jun 2026 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388063; cv=none; b=e/wM3PllYHjLKjcw9w2QmyQfFZdQ8txtC+fUX2qqE+Y6CCOQs0Qx0gTWQy2YT1s8518qzkXMf37Y7kXoSudXlj71I4AANvLdpFzdghDKRRK0nNMZdZpppmw0RM0mKqmzTpoCfeRU3qsDtaoylz7D/F+h1WvSHUVp8dA07QbhWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388063; c=relaxed/simple;
	bh=QdbX22xd+haeiusHEINSiP8KFo9O8JZSuw3FqevaJ3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LMzbPwTtpBAG55kpRlzRLrdUBE5AA+GLR39DBHBRdnuAqS6WzBae7U5twKI6NTp3A1FmjeItjnpToADCBAAozqB9YXGTkash1uAACRbd7J3YppubK8utBmKsXDT3B3ShX8a5URLi5H67uTP9TLNLqwLw0HGj2paNlDYcYNvejH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0ba655105e5b11f1aa26b74ffac11d73-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:385cf79b-e49a-412f-bcc1-7330d5b28554,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c2bd1ce71ba216685f154bf36bc00dd7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ba655105e5b11f1aa26b74ffac11d73-20260602
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 832459926; Tue, 02 Jun 2026 16:14:15 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: perf metricgroup: Fix metric expression copy leaks
Date: Tue,  2 Jun 2026 16:11:04 +0800
Message-Id: <20260602081104.271325-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

metricgroup__copy_metric_events() allocates a new metric expression and
duplicates metric_name before linking the expression into the destination
metric event.

Free new_expr when strdup() fails, and free the duplicated metric_name on
the later error paths.

Fixes: b85a4d61d302 ("perf metric: Allow modifiers on metrics")
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 tools/perf/util/metricgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4db9578efd811..1ed66773c6f0f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1687,8 +1687,10 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 			new_expr->metric_expr = old_expr->metric_expr;
 			new_expr->metric_threshold = old_expr->metric_threshold;
 			new_expr->metric_name = strdup(old_expr->metric_name);
-			if (!new_expr->metric_name)
+			if (!new_expr->metric_name) {
+				free(new_expr);
 				return -ENOMEM;
+			}
 
 			new_expr->metric_unit = old_expr->metric_unit;
 			new_expr->runtime = old_expr->runtime;
@@ -1701,6 +1703,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				alloc_size = sizeof(*new_expr->metric_refs);
 				new_expr->metric_refs = calloc(nr + 1, alloc_size);
 				if (!new_expr->metric_refs) {
+					zfree(&new_expr->metric_name);
 					free(new_expr);
 					return -ENOMEM;
 				}
@@ -1717,6 +1720,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 			alloc_size = sizeof(*new_expr->metric_events);
 			new_expr->metric_events = calloc(nr + 1, alloc_size);
 			if (!new_expr->metric_events) {
+				zfree(&new_expr->metric_name);
 				zfree(&new_expr->metric_refs);
 				free(new_expr);
 				return -ENOMEM;
@@ -1727,6 +1731,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				evsel = old_expr->metric_events[idx];
 				evsel = evlist__find_evsel(evlist, evsel->core.idx);
 				if (evsel == NULL) {
+					zfree(&new_expr->metric_name);
 					zfree(&new_expr->metric_events);
 					zfree(&new_expr->metric_refs);
 					free(new_expr);
-- 
2.43.0

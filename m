Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C2367287;
	Fri, 10 Jul 2026 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653774; cv=none; b=KHe/Ah7kr6lTZi7dl6PS+EsCRwriq1U/hpAiQdgCozYckbFzmLi3kifz4aCaETV9sw2RRyq3xRWd82GsI15EIMW8tPxJHjv7lSTRrMHkycXCqMu4FjN4f+p7Bka40pMjDOst+U+Ub15OQD/1yB+87gVEHV5pMlkEXvy881YTyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653774; c=relaxed/simple;
	bh=tQGQmTYQOW2EOERRw4Q9NtImUqij+puMg2E4xB2s2jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nWPmLHfPznun/RkTI0pHDWkWGEIX7vuob+xFEnx2E4PlHJKFPlanijI/EPQNBRfAX7PrAQishsdxjKC24wMsGYFwRH6/+1J/BnorgLE2+sSxsmWojla7V6WwwVq0iaezL8vL2MADBxmCbxh26McD7yXt7UbGoWY8O9Hlhjl1Uso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9ea9d1d67c0e11f1aa26b74ffac11d73-20260710
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b9d6356d-ac7f-48a0-9149-0ce5902c244a,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:b9d6356d-ac7f-48a0-9149-0ce5902c244a,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:2bdd40dd227cc0c47f60b4fa5608d219,BulkI
	D:260710111547XSWKYOFA,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9ea9d1d67c0e11f1aa26b74ffac11d73-20260710
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(39.144.190.24)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1787203181; Fri, 10 Jul 2026 11:22:45 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org
Cc: leo.yan@arm.com,
	wangyan01@kylinos.cn,
	xiaqinxin@huawei.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf metricgroup: Fix memory leak of metric_name in metricgroup__copy_metric_events
Date: Fri, 10 Jul 2026 11:22:41 +0800
Message-Id: <20260710032241.119031-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In metricgroup__copy_metric_events(), new_expr->metric_name is allocated
via strdup() but is not freed in all error paths, leading to a memory
leak when subsequent allocations or evsel lookups fail.

Add the missing zfree() calls:

  - On strdup() failure, free the already allocated new_expr.
  - On metric_refs allocation failure, free metric_name before freeing
    new_expr.
  - On metric_events allocation failure, free metric_name in addition
    to existing freeing of metric_refs and new_expr.
  - On evsel lookup failure, free metric_name along with the other
    resources already freed.

Fixes: b214ba8c4275 ("perf tools: Copy metric events properly when expand cgroups")
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/perf/util/metricgroup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 69bfa2a723b2..96dd780a5601 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1693,8 +1693,10 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
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
@@ -1707,6 +1709,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				alloc_size = sizeof(*new_expr->metric_refs);
 				new_expr->metric_refs = calloc(nr + 1, alloc_size);
 				if (!new_expr->metric_refs) {
+					zfree(&new_expr->metric_name);
 					free(new_expr);
 					return -ENOMEM;
 				}
@@ -1724,6 +1727,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 			new_expr->metric_events = calloc(nr + 1, alloc_size);
 			if (!new_expr->metric_events) {
 				zfree(&new_expr->metric_refs);
+				zfree(&new_expr->metric_name);
 				free(new_expr);
 				return -ENOMEM;
 			}
@@ -1735,6 +1739,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				if (evsel == NULL) {
 					zfree(&new_expr->metric_events);
 					zfree(&new_expr->metric_refs);
+					zfree(&new_expr->metric_name);
 					free(new_expr);
 					return -EINVAL;
 				}
-- 
2.25.1


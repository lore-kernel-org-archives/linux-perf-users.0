Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E8368D46;
	Thu, 21 May 2026 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332273; cv=none; b=QJLCMX+AhaYZW3gMCwEQCtdXSACHNlPuZ6TifTxq/qmh8PSV4mVfaAOaQhwlJFdYphPqEtlf9G+9XRCXVxXreHbN4OGM3GmtGJmz4GSWxEx9VcYayGPZIk/3sL+3XB6PmPZd2w5K7Ax/HENRNIQMQIk9Fy44kFopkjTFzh22WnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332273; c=relaxed/simple;
	bh=BcyMzFHs2CZuCLhQkiQSw7Aj7jkE4V678WKmCthggUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YlbszlFTGejYf/qpMTO3jdvAP5xyBPpgF8AEIVfAHajg2fXUef8ZuUForVhC7mBalCaxRqi+MOlFU3eokbbCx0uN95UKRL/j8A/Tg3Va7H1i519Zrz3AAihncakSY3UBO9xRt/62Z4t89cmPrWUR6sHycl1dVlknwhvbODixFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d639743c54c011f1aa26b74ffac11d73-20260521
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f2dd0df6-48aa-4c11-8efc-1a0711ca8790,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a71d0b093bf17ff626bd6ce8af797cd7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d639743c54c011f1aa26b74ffac11d73-20260521
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2135940198; Thu, 21 May 2026 10:57:42 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	thomas.falcon@intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] perf: evsel: Fix error handling in tp_format lookup
Date: Thu, 21 May 2026 10:57:38 +0800
Message-Id: <20260521025738.17867-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In evsel__tp_format(), when trace_event__tp_format*() returns an error,
IS_ERR() checks the local variable 'tp_format', but PTR_ERR() incorrectly
uses 'evsel->tp_format' which hasn't been assigned yet.

Fix this by using PTR_ERR(tp_format) to extract the error code from the
correct variable.

Fixes: 6c8310e8380d ("perf evsel: Allow evsel__newtp without libtraceevent")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..0cefeba41236 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -647,7 +647,7 @@ struct tep_event *evsel__tp_format(struct evsel *evsel)
 		tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
 
 	if (IS_ERR(tp_format)) {
-		int err = -PTR_ERR(evsel->tp_format);
+		int err = -PTR_ERR(tp_format);
 
 		errno = err;
 		pr_err("Error getting tracepoint format '%s': %m\n",
-- 
2.25.1


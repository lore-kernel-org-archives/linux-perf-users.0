Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F73E44E5;
	Fri, 10 Jul 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670513; cv=none; b=Nazco0YPrH4fgprgBbHuOSVbIUzvTpgD2J82mysyDT1iOeK8KgTMWrGXr4zyCF2B3VvAoqgnb89Mh2lMWR8Xqh8KXdyR/+NM/J7Rxl/JWuoafHdSCq3Tk4Vt/e9aph+dbSqN7zWWuYn1GR1ANP9oU/XhTa9D+lbyYu3p/lEIiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670513; c=relaxed/simple;
	bh=BcyMzFHs2CZuCLhQkiQSw7Aj7jkE4V678WKmCthggUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7fXjps6kbuWhYjVNRPUDxoQCX4XuB2Gk4PPVgXxfBgDzBlL0tGOAvjVovG7nOntPS4kSBjRDuN8XLL/gFQYbIxlmdQWWC1ofhyuhDs7HKpDfTccSyFFda6kYz7Nao1HycjSTZymjff9jEhBvbedVnuvZlpjJw8HutmUhfOd81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 97ca11f67c3511f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cfc05532-5145-4068-904b-204e7a1a8fba,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:4681c6c22390f50ec850d42735901ec5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 97ca11f67c3511f1aa26b74ffac11d73-20260710
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2069103290; Fri, 10 Jul 2026 16:01:44 +0800
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
Date: Fri, 10 Jul 2026 16:01:40 +0800
Message-Id: <20260710080140.186199-1-zenghongling@kylinos.cn>
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


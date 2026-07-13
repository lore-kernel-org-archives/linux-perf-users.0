Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624033DDDB1;
	Mon, 13 Jul 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935434; cv=none; b=RgGsbCFlvQlRRKx1Wv+nxe0MCF8K49ZDwyaNYoaovE/H1hpGWJgSW/7+QkI471S3W+2wZn652zSor2oSu9JTKjjxBZzABahhlvAZuqN0mQbzo4AamUqBoGHkrkvziAsHe/pS+++ICpL2R5iyCHUNUWPFPUs8bWeXwxsH2Lks0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935434; c=relaxed/simple;
	bh=2Yr7RXSaPvo7tOCzezDgY/runQK1vgIe5hy8eLHSdAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KuVOMlfiB5tz9/qSwokMGnltgZoMQacgYTFV54n6cGI4q1I90Fj5Bt8yDfPOM/WjL4Bqy6SgtMyngaCNQ0MxadGYN+9t1pbCR94Q2/fI3UbcfEM3iwpHGM/buTI/+lg1fhMQ6vmZHg1l341P+k6IFzD7h6ubk4+/CnPsIW9GYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 63050f5a7e9e11f1aa26b74ffac11d73-20260713
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:737e3777-f411-42a7-bbc1-a3fc128e6dc5,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:737e3777-f411-42a7-bbc1-a3fc128e6dc5,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:94c11187df5fd3d362ed3d2b4bdf846f,BulkI
	D:260713173658XB6UB7LO,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 63050f5a7e9e11f1aa26b74ffac11d73-20260713
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 970018875; Mon, 13 Jul 2026 17:36:55 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
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
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hongfu.li@linux.dev,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] perf doc: Fix mmap failure checks in topdown example
Date: Mon, 13 Jul 2026 17:36:26 +0800
Message-Id: <20260713093626.492180-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use MAP_FAILED instead of NULL to detect mmap errors, and fix the
slots_p variable name typo in the sample code.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 tools/perf/Documentation/topdown.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index 5c17fff694ee..fd4214f9a7b0 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -87,7 +87,7 @@ if (slots_fd < 0)
 
 /* Memory mapping the fd permits _rdpmc calls from userspace */
 void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, slots_fd, 0);
-if (!slot_p)
+if (slots_p == MAP_FAILED)
 	.... error ...
 
 /*
@@ -107,7 +107,7 @@ if (metrics_fd < 0)
 
 /* Memory mapping the fd permits _rdpmc calls from userspace */
 void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, metrics_fd, 0);
-if (!metrics_p)
+if (metrics_p == MAP_FAILED)
 	... error ...
 
 Note: the file descriptors returned by the perf_event_open calls must be memory
-- 
2.25.1


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2451E5B68;
	Tue, 25 Aug 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651289; cv=none; b=PGupD7OoJPHkdY3KDSBh9w+atJK8tzkHY04E128FQjN62fQs1pwAd1RcygNEnYEFXPrbZ2VxpI0+gbKg6ZOICS4wKm3dLwFwddT1oys6TZkgmLuBhYoTGBARcri+cz/DIlNorZmiop5mdVrXp2C0O6aLipMMpty9yJbwN0VDnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651289; c=relaxed/simple;
	bh=rbLlHdwPywiQYcMMeuEKrlt0zCR9S9FdyCafPbmXoGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8AhpoFHOjlQh6P9P20mGhVZL6n6zntN86KQ1Uq4qbYHw7wls/LtO3xaGCo3JPKv4Q4YiEeBSxou/i7TAd9B8scw7EIIzPYMjKmLEiVexxQU9kCDNv/Xl+N4RQ7Sn6W3uQa1HhprWeStDfKMD0JB+QrLB0aeRI3Vbd7BHrROiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0d729088a06a11f19a56ed5b684f684d-20260825
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d6b01ddf-0fbf-483d-802c-104402143017,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:d6b01ddf-0fbf-483d-802c-104402143017,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:08faf8d06a1a42dd955d54dcb5d7ccb1,BulkI
	D:260825174801OEBNFIKJ,BulkQuantity:0,SF:17|19|38|66|78|102|127|850|865|89
	8,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0d729088a06a11f19a56ed5b684f684d-20260825
X-User: wangyan01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <wangyan01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1297033819; Tue, 25 Aug 2026 17:47:57 +0800
From: Wang Yan <wangyan01@kylinos.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	atrajeev@linux.ibm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yan <wangyan01@kylinos.cn>
Subject: [PATCH] perf powerpc-vpadtl: Fix raw_size of DTL samples
Date: Tue, 25 Aug 2026 17:47:33 +0800
Message-Id: <20260825094733.1031566-1-wangyan01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In powerpc_vpadtl_sample(), raw_data of the synthetic sample points to a
struct powerpc_vpadtl_entry (48 bytes), but raw_size is set to
sizeof(record).  record is a struct powerpc_vpadtl_entry pointer, so
sizeof(record) is the size of the pointer (8 bytes on 64-bit) rather
than the size of the record itself.

As a result, consumers that bound their access to raw_data by raw_size
only see or copy the first 8 bytes of each DTL entry instead of the full
record.

Use sizeof(*record) so that raw_size reflects the actual length of the
raw data.

Fixes: 8644834a482a ("perf powerpc: Process the DTL entries in queue and deliver samples")
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
---
 tools/perf/util/powerpc-vpadtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
index 710f3093f3f9..af6783cfdb53 100644
--- a/tools/perf/util/powerpc-vpadtl.c
+++ b/tools/perf/util/powerpc-vpadtl.c
@@ -196,7 +196,7 @@ static int powerpc_vpadtl_sample(struct powerpc_vpadtl_entry *record,
 	sample.cpumode = PERF_RECORD_MISC_KERNEL;
 	sample.time = save;
 	sample.raw_data = record;
-	sample.raw_size = sizeof(record);
+	sample.raw_size = sizeof(*record);
 	event.sample.header.type = PERF_RECORD_SAMPLE;
 	event.sample.header.misc = sample.cpumode;
 	event.sample.header.size = sizeof(struct perf_event_header);
-- 
2.25.1


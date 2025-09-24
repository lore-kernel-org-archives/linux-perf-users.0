Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889C1A23AF;
	Wed, 24 Sep 2025 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676371; cv=none; b=CGgYiUyAp5x0yD404xSL8O2oPBV+jUrHnJ71R+XTws8ViIsbgYObJoRro4Y6Hzsmou0ZWrRvTVkDXb4UxoQeKEMIA/MSdn5sv/naFawsH3jWekhzdtgsjvv8CSnMJfBBh0pYrRarENy9OR/H0ca2ChS+ok0Oszib7Gm27/jjbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676371; c=relaxed/simple;
	bh=ckvERna5M/VSS3unkR5kmJ0GIdvm9j9J64cn3oC7Svs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rK/DUPfym+iE3HXhEZXVUITo6YY6VAHfjbkYj2PIhavYA0wv4UKG4iIsUCteTPS2JeIae63hJtL1s25tfA+ICVsUKori1PbqvBGbFmy4c+LR/XTyQkZiPve3ZGYGeti/HLyjbGNh3tXejeiv6uUm6GGu0YgSfaFhRwYyj71zSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 92738af698e311f08b9f7d2eb6caa7cf-20250924
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:109e7b9e-5bb9-4942-bb6d-ce6d044c3aa8,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:109e7b9e-5bb9-4942-bb6d-ce6d044c3aa8,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:17ca8bbc7cf74532124dc10679389d9f,BulkI
	D:2509240912438BU4XQOZ,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 92738af698e311f08b9f7d2eb6caa7cf-20250924
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1381587426; Wed, 24 Sep 2025 09:12:43 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH RESEND] perf: make pmu_bus constant
Date: Wed, 24 Sep 2025 09:12:31 +0800
Message-Id: <20250924011231.167567-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
a const *"), the driver core can properly handle constant struct
bus_type, move the pmu_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modifie at runtime.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 872122e074e5..155bb686c8ce 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12216,7 +12216,7 @@ static const struct attribute_group *pmu_dev_groups[] = {
 };
 
 static int pmu_bus_running;
-static struct bus_type pmu_bus = {
+static const struct bus_type pmu_bus = {
 	.name		= "event_source",
 	.dev_groups	= pmu_dev_groups,
 };
-- 
2.25.1


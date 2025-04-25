Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E2188596
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745552343; cv=none; b=LweItS1YMOvHxYRsyx1OlaZoy8Pr2Af2MZeXnvPPOwIpIcSVB5IMq8xJA2gE192v4uDLZURBcnqd0peptP9jyGBrHSQOHvxwNYoew6xASqAeiNuBKZvrBZjaFPm4F9gt9K+ZVwsBD3O85U4UVbwKajcWITnWbG6jDMg6Y3dODWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745552343; c=relaxed/simple;
	bh=rTI5CzNAvu1NLpPm9UGtRO1l1oyosaLRRViXtolWrHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0BX2xyPwWQkstGRgegYp/0zxr4k6vLdCttyEjWDCg0IWaIMh5GG5XwGps4dqhpmWbAz9LrwHlrw6Pnpd/U7Ggs1ehcL/lukc3J6whxcnrgRHsYlZ2O8nu18fXkjuZ7Wso4/BuhOWyEOil0sL29jswSNlzN410jO1knsg9ekT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZkJPc71ndzQk1s;
	Fri, 25 Apr 2025 11:35:00 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C9BF1400D9;
	Fri, 25 Apr 2025 11:38:53 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 25 Apr 2025 11:38:52 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <jolsa@kernel.org>, <john.g.garry@oracle.com>,
	<james.clark@linaro.org>, <leo.yan@linux.dev>, <irogers@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>,
	<linuxarm@huawei.com>, <wangyushan12@huawei.com>, <caijingtao@huawei.com>,
	<xueshan2@huawei.com>, <prime.zeng@hisilicon.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v2 3/3] perf mem: Count L2 HITM for c2c statistic
Date: Fri, 25 Apr 2025 11:38:45 +0800
Message-ID: <20250425033845.57671-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250425033845.57671-1-yangyicong@huawei.com>
References: <20250425033845.57671-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

L2 HITM is not counted in c2c statistic decoding. Count it for lcl_hitm
like how we handle L2 Peer snoop.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/util/mem-events.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 884d9aebce91..a384a866a562 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -680,7 +680,10 @@ do {				\
 			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
 			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
 			if (lvl & P(LVL, L2)) {
-				stats->ld_l2hit++;
+				if (snoop & P(SNOOP, HITM))
+					HITM_INC(lcl_hitm);
+				else
+					stats->ld_l2hit++;
 
 				if (snoopx & P(SNOOPX, PEER))
 					PEER_INC(lcl_peer);
-- 
2.24.0


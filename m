Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE25190477;
	Fri, 14 Jun 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358373; cv=none; b=Li4xsMSJUkjxvCG+0HTNZkqScutCDh0rb8n/sY9C/IqY0QLl+3yM4hNXFSW/C/3UtHtYvjjrKw7NiBMAmK3hrmOckf7heNESEhio1CjhHsLFj3FsgWVCiKUxHIZbYvOUz1wEtqAKShZ/8rWM6/uyzgD8o9j/1HqhiuqTBy5x3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358373; c=relaxed/simple;
	bh=BUESmvx+Cq07zK8KsbYwgMGM/ijq7/n/y0539SFZ2F4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sfVrox+/gF8Tg7XuySMgI4x19hm3iWgLkNcBayjxPRsTrdpjwDwOaTnIVXM9sGsR2yzfilQwAHD+g0NkZy2RxGcKFHKJt+jMqHck1nVHtc0VszUfJHKK54CibBLz3F/en/biqiYPz9+0Fgz1VEkHytDn/7snpKrDDDsPSdrQcQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W0vSp5Vt1z2Ck6M;
	Fri, 14 Jun 2024 17:42:18 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A5BF1A0188;
	Fri, 14 Jun 2024 17:46:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 17:46:07 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <peterz@infradead.org>, <acme@redhat.com>, <irogers@google.com>
CC: <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>,
	<adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
	<cuigaosheng1@huawei.com>, <mingo@redhat.com>, <james.clark@arm.com>,
	<renyu.zj@linux.alibaba.com>, <jolsa@kernel.org>, <john.g.garry@oracle.com>,
	<kjain@linux.ibm.com>, <kan.liang@linux.intel.com>, <mark.rutland@arm.com>,
	<namhyung@kernel.org>, <ravi.bangoria@amd.com>, <robh@kernel.org>,
	<linux-perf-users@vger.kernel.org>
Subject: [PATCH] perf pmus: Fixes always false when compare duplicates aliases
Date: Fri, 14 Jun 2024 17:43:18 +0800
Message-ID: <20240614094318.11607-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)

In the previous loop, all the members in the aliases[j-1] have been freed
and set to NULL. But in this loop, the function pmu_alias_is_duplicate()
compares the aliases[j] with the aliases[j-1] that has already been
disposed, so the function will always return false and duplicate aliases
will never be discarded.

If we find duplicate aliases, it skips the zfree aliases[j], which is
accompanied by a memory leak.

We can use the next aliases[j+1] to theck for duplicate aliases to
fixes the aliases NULL pointer dereference, then goto zfree code snippet
to release it.

After patch testing:
 $ perf list --unit=hisi_sicl,cpa pmu

 uncore cpa:
   cpa_p0_rd_dat_32b
        [Number of read ops transmitted by the P0 port which size is 32 bytes.
         Unit: hisi_sicl,cpa]
   cpa_p0_rd_dat_64b
        [Number of read ops transmitted by the P0 port which size is 64 bytes.
         Unit: hisi_sicl,cpa]

Fixes: c3245d2093c1 ("perf pmu: Abstract alias/event struct")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 tools/perf/util/pmus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b9b4c5eb5002..6907e3e7fbd1 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -477,8 +477,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
 	for (int j = 0; j < len; j++) {
 		/* Skip duplicates */
-		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
-			continue;
+		if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j], &aliases[j + 1]))
+			goto free;
 
 		print_cb->print_event(print_state,
 				aliases[j].pmu_name,
@@ -491,6 +491,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 				aliases[j].desc,
 				aliases[j].long_desc,
 				aliases[j].encoding_desc);
+free:
 		zfree(&aliases[j].name);
 		zfree(&aliases[j].alias);
 		zfree(&aliases[j].scale_unit);
-- 
2.33.0


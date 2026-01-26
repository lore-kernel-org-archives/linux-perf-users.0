Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7489D306489
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430924; cv=none; b=I2VjZH1hxj7zEXYD6n+wbPyCl8mzKMGCpcIaBQBdPW7vpt5Rxua/L9xR8FzSAPWZFhLZaoO8TsutgNNYvxHh/X/4gTfQnj5lU+iVvCMJCoKJUvwnfd9S8zWuDB+Eiz30H60/dJ3krhR/+brjtzg5hj0SdS/0ZB2Eu2qaMwN+m6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430924; c=relaxed/simple;
	bh=ATFNFvkbqytvmT4XmHE4XH54X/u0t/TfPFRqUZNAMmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6LwLR2ulya+c23OrUk0udMutFu1tNK8LdLXvGywYcPFQUYSsijOEVkYn52hEOGpkNXaUAK7fFfJVEkf6glbQsXPwUUHhBw9/25F4Cx0USi7QrMLX44rCUiywFekIRP/br145qXsMV4vtogwAMjaeqPAsJ2EhzMsbgHLoHjhb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gppoXNhs; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gppoXNhs"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uOEBMquHVaIZ09UVZZ0kOEI5ZCxeb2xfXPgbFFLGy3Q=;
	b=gppoXNhsJWzDDHiRNU+ImJrG6rS2cXIqhymStqRqKOuTJAtMpUDow3nyspSyMSHXBnPZxGfCD
	rsCXbtTTA/FTTTigLuTjoyWz5za2kHwBTmTuLM1fW3Oj1anm8EF270nR49OiX6AVIyycAHakMaE
	jPbd9f5qMVRYpJZ0tccKsYs=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f07Fl2rKtz1K98G;
	Mon, 26 Jan 2026 20:31:55 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3763D4055B;
	Mon, 26 Jan 2026 20:35:20 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 20:35:20 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 20:35:19 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <mike.leach@linaro.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<john.g.garry@oracle.com>, <Jonathan.Cameron@huawei.com>,
	<shiju.jose@huawei.com>, <will@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linuxarm@huawei.com>, <liuyonglong@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH 5/7] perf-iostat: Support wilder wildcard-match for pmus
Date: Mon, 26 Jan 2026 20:35:12 +0800
Message-ID: <20260126123514.3238425-6-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260126123514.3238425-1-wangyushan12@huawei.com>
References: <20260126123514.3238425-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100008.china.huawei.com (7.202.194.111)

Current wildcard matching of pmu names only support the form of
"<pmu_name>%d", which may not be sufficient for pmus with other forms of
name (e.g. HiSilicon PCIe PMU has the name of "hisi_pcie%d_pmu%d").

To address that, change the wildcard matching function into a callback,
and add a new version of wildcard-matching function using the callback
to support more flexible pmu names.

Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/util/pmus.c | 12 +++++++++---
 tools/perf/util/pmus.h |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 98be2eb8f1f0..35184d477d07 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -402,7 +402,8 @@ struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *eve
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard)
+struct perf_pmu *perf_pmus__scan_matching(struct perf_pmu *pmu, const char *wildcard,
+					  perf_pmus_match_t match)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 
@@ -436,19 +437,24 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
 	}
 	if (use_core_pmus) {
 		list_for_each_entry_continue(pmu, &core_pmus, list) {
-			if (perf_pmu__wildcard_match(pmu, wildcard))
+			if (match(pmu, wildcard))
 				return pmu;
 		}
 		pmu = NULL;
 		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
 	list_for_each_entry_continue(pmu, &other_pmus, list) {
-		if (perf_pmu__wildcard_match(pmu, wildcard))
+		if (match(pmu, wildcard))
 			return pmu;
 	}
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard)
+{
+	return perf_pmus__scan_matching(pmu, wildcard, perf_pmu__wildcard_match);
+}
+
 static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 7cb36863711a..9308afb5a7b8 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -9,6 +9,8 @@ struct perf_event_attr;
 struct perf_pmu;
 struct print_callbacks;
 
+typedef _Bool (*perf_pmus_match_t)(const struct perf_pmu *, const char *);
+
 size_t pmu_name_len_no_suffix(const char *str);
 /* Exposed for testing only. */
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
@@ -22,6 +24,7 @@ struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
+struct perf_pmu *perf_pmus__scan_matching(struct perf_pmu *pmu, const char *wildcard, perf_pmus_match_t match);
 struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
-- 
2.33.0


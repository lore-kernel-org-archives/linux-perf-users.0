Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121630EF63
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430923; cv=none; b=RrG9JEAQFS9LZT+wZNixtNYqEGe+bsCxYX6dp4eEiEctZOWMVPEzxfUSR8RX1yMRVKAFIPKTnsSuEtqCDG5LeNNO6tP9dS3TjYqOZHNkMSG5+YJCfLUjOTDtCc3+GkReksuvoraiPp1h8uxELF10piGpRZ4c8wNhrsVbmSL4E48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430923; c=relaxed/simple;
	bh=HcZF6RirgVH+27qq4th1mvKFawSJ2gnnuhvjTE5hWo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGp3A3OY9F9f+3GsfdNr2IdNCqaiyKWjWjrRdSMO1p7bsCZ18A6ScQQXBx/bqODruWn+PDYD97GZ9TKhr8mht17eqPjrsSYB292T0hrPpI2rbyblrQgP/iwvnDV50FcmLPQbPAhKicS6sTzRIOZsPyawWNkGQO7UECsKEDCS0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2okf4cl2; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2okf4cl2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nyxGEjK43IBO809vlSyubk6zG/VpmcHMAUt9BPPqHyU=;
	b=2okf4cl24LZ2DZGjdWeM2ZtyXvXfg46WQGyT+boldFUrZbFVOT2XNyzdmYj0m7hN/waIPvVjc
	qRD/B6OCIlJmxA0u0nA5uRSqE0zdX3lWWlCyfURFMaEK+QZkjjFqjeg65/ykE5aybU4Hdy7+Pji
	E+3uv2ipUwKMNWNl/hOGeh8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f07Fg6gjlzLlXY;
	Mon, 26 Jan 2026 20:31:51 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 29AB14048B;
	Mon, 26 Jan 2026 20:35:18 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Jan 2026 20:35:17 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 26 Jan 2026 20:35:16 +0800
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
Subject: [RFT PATCH 2/7] perf stat: Save unnecessary print_metric() call
Date: Mon, 26 Jan 2026 20:35:09 +0800
Message-ID: <20260126123514.3238425-3-wangyushan12@huawei.com>
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

Patch [1] removed the second branch of iostat_run, and changed num to 0
since it is the default behavior. But during iostat_run, default value 1
of num is required to avoid print_metric() call later.

Set num as 1 to avoid redundant print_metric() call that causes
unaligned blank printed.

Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")

[1]: https://lore.kernel.org/all/20251111212206.631711-8-irogers@google.com/

Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/util/stat-shadow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 9c83f7d96caa..9439baf8002f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -319,8 +319,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	void *ctxp = out->ctx;
 	int num = 0;
 
-	if (config->iostat_run)
+	if (config->iostat_run) {
 		iostat_print_metric(config, evsel, out);
+		num = 1;
+	}
 
 	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
 						  &num, NULL, out);
-- 
2.33.0


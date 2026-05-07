Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475940DFA3;
	Thu,  7 May 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135865; cv=none; b=TlnsR7BZi0KGcarQ4EIKWzxbnFS0kbCkmLW3LDWiTymWiGfrACIJ8VoS9a7TxQfElzm0hufPQkEcbDIAwfRNy/n8X4GE2vC/dm9tX4wRZX89M229g0yOk7VeFj+ADHVEWfS0fHb/n2IY7q4vSJGGZ8yVWaIkWW1rGmuKiLVYl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135865; c=relaxed/simple;
	bh=BA3yfDoTE56T6V36c7TmPzfWAPRNU4dgZGsNcEGGPq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoUR7YoRGcql8uzfgB1tH5Ty+L+7Ivcw+ld22xDVtCOoqR/yXZBHggNANci0R4B6G0vnw0rUyMoURw4z5/3YZsTwg5pghNMlJc4mrKpmDLCT9FbizTg7rfvtfahsGzB0YBGWSAcKpkMLapwrCdzTBZKhnQSL8Suao6+KaizWA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SF/6Bwyt; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SF/6Bwyt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7vylduoRqDFT0UfMrXqN7Cq3Y6aHaFoZdwPyFBkNlNc=;
	b=SF/6BwytKNbEng1rjg9RClqKxkiniUMzMR7duX9fWb1/Z4m8nFu4+Q6D1ixRo24BKb5lmMXah
	Qfi5iqGThupAa5s9yDTunjXoN2Hz7myl89mOhD2ebidVKp/N5PWuMvjeKQnBBD5dXUXR1OIiqP5
	MgKI5fAyKsE1XgOQaSgXJ1o=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gB2ST0t05zpSx8;
	Thu,  7 May 2026 14:30:49 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D10AC40561;
	Thu,  7 May 2026 14:37:39 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 14:37:39 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 14:37:38 +0800
From: Yushan Wang <wangyushan12@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [RFT PATCH v2 2/7] perf stat: Save unnecessary print_metric() call
Date: Thu, 7 May 2026 14:37:32 +0800
Message-ID: <20260507063737.3542950-3-wangyushan12@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507063737.3542950-1-wangyushan12@huawei.com>
References: <20260507063737.3542950-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100008.china.huawei.com (7.202.194.111)

The patch listed under Fixes removed the other branch of iostat_run, and
changed num to 0 since it is the default behavior of it. But during
iostat_run, default value 1 of num is required to avoid print_metric()
call later.

Set num as 1 to avoid redundant print_metric() call that causes
unaligned blank printed.

Before this patch:

root@localhost$ ./perf stat --iostat=0000:20:0f.0 --timeout 100

 Performance counter stats for 'system wide':

    port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
0000:20:0f.0                 0.00                                      0.00                                      0.00                                      0.00                                      0.00
                            0.01

       0.100138030 seconds time elapsed

After this patch:

root@localhost$ ./perf stat --iostat=0000:20:0f.0 --timeout 100

 Performance counter stats for 'system wide':

    port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound CPL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
0000:20:0f.0                 0.00                 0.00                 0.00                 0.00                 0.00                 0.01

       0.100127590 seconds time elapsed

Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
---
 tools/perf/util/stat-shadow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index bc2d44df7baf..0056444523d6 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -326,8 +326,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
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


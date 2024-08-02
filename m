Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A0F211C
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Aug 2024 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582253; cv=none; b=ZopdHE3FHG/o2ZgKu8FEPlffBLTf2jj0uH2auzDRW/owB/nafctFDOir2Hbo/0tW6sSoVyeosHZAOR0a66n0CvHVCfh97/co08PBpRGOqA0tSMNEgfjBUdqTaHuv/7xb3WHYgKn5EeFsyhYCC0nZP2BT+JJlnYxApcPEHlqIlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582253; c=relaxed/simple;
	bh=RtHUIb3dTbiS2C1fQCHJ32OplUEwG39fQ4XUjpkkKwQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Of4cIDAH2l1/eHpdsEdtHGoW8OImGIffsSSKmc9084tc/RlgB2Q4R+C6xbq7pdvTBA9Bvx4oqenuTZeZXHiij/hRhLXH+iHKTFqgBX6aErSdXl2okYB43qgP/pvyCiFlAzo12RMF4jcEuFZu4P/At+3iFzW/fNMPH1RTK0p08+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZxdf13Lnzcd4Q;
	Fri,  2 Aug 2024 15:04:06 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id AD5D71800CD;
	Fri,  2 Aug 2024 15:04:07 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 2 Aug 2024 15:04:06 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>
CC: <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH] perf stat: Display iostat headers correctly
Date: Fri, 2 Aug 2024 14:58:00 +0800
Message-ID: <20240802065800.48774-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Currently we'll only print metric headers for metric leader in
aggregration mode. This will make `perf iostat` header not shown
since it'll aggregrated globally but don't have metric events:
root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
 Performance counter stats for 'system wide':
    port
0000:00                    0                    0                    0                    0
0000:80                    0                    0                    0                    0
[...]

Fix this by excluding the iostat in the check of printing metric
headers. Then we can see the headers:
root@ubuntu204:/home/yang/linux/tools/perf# ./perf stat --iostat --timeout 1000
 Performance counter stats for 'system wide':
    port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
0000:00                    0                    0                    0                    0
0000:80                    0                    0                    0                    0
[...]

Fixes: 193a9e30207f ("perf stat: Don't display metric header for non-leader uncore events")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/util/stat-display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index c38bcb6f4c78..ea96e4ebad8c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1237,7 +1237,8 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
-		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
+		if (!config->iostat_run &&
+		    config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
 			continue;
 
 		os.evsel = counter;
-- 
2.24.0


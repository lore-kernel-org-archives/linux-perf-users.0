Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7502116E0;
	Fri, 18 Apr 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960481; cv=none; b=oCinowcN8Ku2NiVAwQnFPjHbhxJEySyh58GUUNhi90opu1+/5PEBfFgr/0DWj4hWaTl5THMvspPSSrjPKEal7q4cFbKv0HsSRm1IYdByGqmLuYoCA/DpJTLOn9OlHiFXG/qZ0StOi9y31dWOXPaNbaZvUgb/Y1bwnB9rYAkRa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960481; c=relaxed/simple;
	bh=8nzMiHFhsEDXAXJl6okHeaYLpnZZCY4MUEh2Ho3c3iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDIFvAj3htejWL10SB92+t+jm4asqTfrGxw+T79mOMY6VCkZsEuKJcCPuZqKoUse0aH7r+/gy1r9vRfsleOGMKEFdPIDCygAWmLrJRNsO9Par5KsEqYt4X1mbulzb5VCFCesieaZ4YCsXVH5nPbE379rrsNZ82rcdU5VgHCNPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Zf5bC47Ynz1DKZJ;
	Fri, 18 Apr 2025 15:13:43 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id CBCD718006C;
	Fri, 18 Apr 2025 15:14:35 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:35 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:34 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@linaro.org>, <leo.yan@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@linaro.org>,
	<yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/3] perf vendor events arm64: Drop hip08 PublicDescription if same as BriefDescription
Date: Fri, 18 Apr 2025 15:08:11 +0800
Message-ID: <20250418070812.3771441-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250418070812.3771441-1-hejunhao3@huawei.com>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn500004.china.huawei.com (7.202.194.145)

If BriefDescription and PublicDescription are the same, only
BriefDescription is needed. It will be used for both long and
short format outputs.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json     |  8 --------
 .../arch/arm64/hisilicon/hip08/uncore-hha.json      | 10 ----------
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json      | 13 -------------
 3 files changed, 31 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
index 2b3cb55df288..014454d78293 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
@@ -3,56 +3,48 @@
 	    "ConfigCode": "0x00",
 	    "EventName": "flux_wr",
 	    "BriefDescription": "DDRC total write operations",
-	    "PublicDescription": "DDRC total write operations",
 	    "Unit": "hisi_sccl,ddrc"
    },
    {
 	    "ConfigCode": "0x01",
 	    "EventName": "flux_rd",
 	    "BriefDescription": "DDRC total read operations",
-	    "PublicDescription": "DDRC total read operations",
 	    "Unit": "hisi_sccl,ddrc"
    },
    {
 	    "ConfigCode": "0x02",
 	    "EventName": "flux_wcmd",
 	    "BriefDescription": "DDRC write commands",
-	    "PublicDescription": "DDRC write commands",
 	    "Unit": "hisi_sccl,ddrc"
    },
    {
 	    "ConfigCode": "0x03",
 	    "EventName": "flux_rcmd",
 	    "BriefDescription": "DDRC read commands",
-	    "PublicDescription": "DDRC read commands",
 	    "Unit": "hisi_sccl,ddrc"
    },
    {
 	    "ConfigCode": "0x04",
 	    "EventName": "pre_cmd",
 	    "BriefDescription": "DDRC precharge commands",
-	    "PublicDescription": "DDRC precharge commands",
 	    "Unit": "hisi_sccl,ddrc"
    },
    {
 	    "ConfigCode": "0x05",
 	    "EventName": "act_cmd",
 	    "BriefDescription": "DDRC active commands",
-	    "PublicDescription": "DDRC active commands",
 	    "Unit": "hisi_sccl,ddrc"
    },
    {
 	    "ConfigCode": "0x06",
 	    "EventName": "rnk_chg",
 	    "BriefDescription": "DDRC rank commands",
-	    "PublicDescription": "DDRC rank commands",
 	    "Unit": "hisi_sccl,ddrc"
    },
    {
 	    "ConfigCode": "0x07",
 	    "EventName": "rw_chg",
 	    "BriefDescription": "DDRC read and write changes",
-	    "PublicDescription": "DDRC read and write changes",
 	    "Unit": "hisi_sccl,ddrc"
    }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
index b52f056d0255..b2b895fa670e 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -3,28 +3,24 @@
 	    "ConfigCode": "0x00",
 	    "EventName": "rx_ops_num",
 	    "BriefDescription": "The number of all operations received by the HHA",
-	    "PublicDescription": "The number of all operations received by the HHA",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x01",
 	    "EventName": "rx_outer",
 	    "BriefDescription": "The number of all operations received by the HHA from another socket",
-	    "PublicDescription": "The number of all operations received by the HHA from another socket",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x02",
 	    "EventName": "rx_sccl",
 	    "BriefDescription": "The number of all operations received by the HHA from another SCCL in this socket",
-	    "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x03",
 	    "EventName": "rx_ccix",
 	    "BriefDescription": "Count of the number of operations that HHA has received from CCIX",
-	    "PublicDescription": "Count of the number of operations that HHA has received from CCIX",
 	    "Unit": "hisi_sccl,hha"
    },
    {
@@ -49,42 +45,36 @@
 	    "ConfigCode": "0x1c",
 	    "EventName": "rd_ddr_64b",
 	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 64 bytes",
-	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 64bytes",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x1d",
 	    "EventName": "wr_ddr_64b",
 	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
-	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x1e",
 	    "EventName": "rd_ddr_128b",
 	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
-	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x1f",
 	    "EventName": "wr_ddr_128b",
 	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
-	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x20",
 	    "EventName": "spill_num",
 	    "BriefDescription": "Count of the number of spill operations that the HHA has sent",
-	    "PublicDescription": "Count of the number of spill operations that the HHA has sent",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x21",
 	    "EventName": "spill_success",
 	    "BriefDescription": "Count of the number of successful spill operations that the HHA has sent",
-	    "PublicDescription": "Count of the number of successful spill operations that the HHA has sent",
 	    "Unit": "hisi_sccl,hha"
    },
    {
diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
index e3479b65be9a..d83c22eb1d15 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
@@ -3,91 +3,78 @@
 	    "ConfigCode": "0x00",
 	    "EventName": "rd_cpipe",
 	    "BriefDescription": "Total read accesses",
-	    "PublicDescription": "Total read accesses",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x01",
 	    "EventName": "wr_cpipe",
 	    "BriefDescription": "Total write accesses",
-	    "PublicDescription": "Total write accesses",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x02",
 	    "EventName": "rd_hit_cpipe",
 	    "BriefDescription": "Total read hits",
-	    "PublicDescription": "Total read hits",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x03",
 	    "EventName": "wr_hit_cpipe",
 	    "BriefDescription": "Total write hits",
-	    "PublicDescription": "Total write hits",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x04",
 	    "EventName": "victim_num",
 	    "BriefDescription": "l3c precharge commands",
-	    "PublicDescription": "l3c precharge commands",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x20",
 	    "EventName": "rd_spipe",
 	    "BriefDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
-	    "PublicDescription": "Count of the number of read lines that come from this cluster of CPU core in spipe",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x21",
 	    "EventName": "wr_spipe",
 	    "BriefDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
-	    "PublicDescription": "Count of the number of write lines that come from this cluster of CPU core in spipe",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x22",
 	    "EventName": "rd_hit_spipe",
 	    "BriefDescription": "Count of the number of read lines that hits in spipe of this L3C",
-	    "PublicDescription": "Count of the number of read lines that hits in spipe of this L3C",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x23",
 	    "EventName": "wr_hit_spipe",
 	    "BriefDescription": "Count of the number of write lines that hits in spipe of this L3C",
-	    "PublicDescription": "Count of the number of write lines that hits in spipe of this L3C",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x29",
 	    "EventName": "back_invalid",
 	    "BriefDescription": "Count of the number of L3C back invalid operations",
-	    "PublicDescription": "Count of the number of L3C back invalid operations",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x40",
 	    "EventName": "retry_cpu",
 	    "BriefDescription": "Count of the number of retry that L3C suppresses the CPU operations",
-	    "PublicDescription": "Count of the number of retry that L3C suppresses the CPU operations",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x41",
 	    "EventName": "retry_ring",
 	    "BriefDescription": "Count of the number of retry that L3C suppresses the ring operations",
-	    "PublicDescription": "Count of the number of retry that L3C suppresses the ring operations",
 	    "Unit": "hisi_sccl,l3c"
    },
    {
 	    "ConfigCode": "0x42",
 	    "EventName": "prefetch_drop",
 	    "BriefDescription": "Count of the number of prefetch drops from this L3C",
-	    "PublicDescription": "Count of the number of prefetch drops from this L3C",
 	    "Unit": "hisi_sccl,l3c"
    }
 ]
-- 
2.33.0


Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418626AAB7;
	Fri, 18 Apr 2025 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960485; cv=none; b=mYjBc2A5AwBHkwdj7+ouVAbu2c/COk/2c7U29MX0cU/xBp1fuiaXetpKiJDJxQZX8k1jNtS8fx1tdPdq++Bfe5NqISe8d5mkgMsEVw/d1uBgTemCW2atjI9dYuFgYlIXPDHVC7mSLxtRIdXXrSntlvG+I/fry6tv907PSgInj6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960485; c=relaxed/simple;
	bh=TXfqXhEswk5Q1AKwsmLi9EY1plg8goxgfhuNtpCkBNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0XH0nc3fQRRDQo/rLXlERS+6++iuX9tpDyRVaB9WYOwPsIIeiilpIWr7Id3mXpWXOOpuZGM7lJglrT5AoQ1k159f7TyDUxcVJ4/sdSmRqPqhqfTOpltlaPbGyE56Vc8pQ7P978cyFs5hE+bgoXsNHf03jNvSoQI4qq8uNHhySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zf5c13Xhnz1j5tc;
	Fri, 18 Apr 2025 15:14:25 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D99F18001B;
	Fri, 18 Apr 2025 15:14:35 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:34 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Apr 2025 15:14:33 +0800
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
Subject: [PATCH v2 1/3] perf vendor events arm64: Fill up Desc field for Hisi hip08 hha pmu
Date: Fri, 18 Apr 2025 15:08:10 +0800
Message-ID: <20250418070812.3771441-2-hejunhao3@huawei.com>
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

In the same PMU, when some JSON events have the "BriefDescription" field
populated while others do not, the cmp_sevent() function will split these
two types of events into separate groups. As a result, when using perf
list to display events, the two types of events cannot be grouped together
in the output.

before patch:
 $ perf list pmu
 ...
 uncore hha:
   hisi_sccl1_hha2/sdir-hit/
   hisi_sccl1_hha2/sdir-lookup/
 ...
 uncore hha:
   edir-hit
      [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
 ...

after patch:
 $ perf list pmu
 ...
 uncore hha:
   edir-hit
      [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
   sdir-hit
      [Count of The number of HHA S-Dir hit operations. Unit: hisi_sccl1_hha2]
   sdir-lookup
      [Count of the number of HHA S-Dir lookup operations. Unit: hisi_sccl1_hha2]
 ...

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 .../arch/arm64/hisilicon/hip08/uncore-hha.json   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
index 9a7ec7af2060..b52f056d0255 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -30,15 +30,18 @@
    {
 	    "ConfigCode": "0x4",
 	    "EventName": "rx_wbi",
+	    "BriefDescription": "Count of the number of WriteBackI operations that HHA has received",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x5",
 	    "EventName": "rx_wbip",
+	    "BriefDescription": "Count of the number of WriteBackIPtl operations that HHA has received",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x11",
+	    "BriefDescription": "Count of the number of WriteThruIStash operations that HHA has received",
 	    "EventName": "rx_wtistash",
 	    "Unit": "hisi_sccl,hha"
    },
@@ -87,66 +90,79 @@
    {
 	    "ConfigCode": "0x23",
 	    "EventName": "bi_num",
+	    "BriefDescription": "Count of the number of HHA BackInvalid operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x32",
 	    "EventName": "mediated_num",
+	    "BriefDescription": "Count of the number of Mediated operations that the HHA has forwarded",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x33",
 	    "EventName": "tx_snp_num",
+	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x34",
 	    "EventName": "tx_snp_outer",
+	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent to another socket",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x35",
 	    "EventName": "tx_snp_ccix",
+	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent to CCIX",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x38",
 	    "EventName": "rx_snprspdata",
+	    "BriefDescription": "Count of the number of SnprspData flit operations that HHA has received",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x3c",
 	    "EventName": "rx_snprsp_outer",
+	    "BriefDescription": "Count of the number of SnprspData operations that HHA has received from another socket",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x40",
 	    "EventName": "sdir-lookup",
+	    "BriefDescription": "Count of the number of HHA S-Dir lookup operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x41",
 	    "EventName": "edir-lookup",
+	    "BriefDescription": "Count of the number of HHA E-Dir lookup operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x42",
 	    "EventName": "sdir-hit",
+	    "BriefDescription": "Count of the number of HHA S-Dir hit operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x43",
 	    "EventName": "edir-hit",
+	    "BriefDescription": "Count of the number of HHA E-Dir hit operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x4c",
 	    "EventName": "sdir-home-migrate",
+	    "BriefDescription": "Count of the number of HHA S-Dir read home migrate operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x4d",
 	    "EventName": "edir-home-migrate",
+	    "BriefDescription": "Count of the number of HHA E-Dir read home migrate operations",
 	    "Unit": "hisi_sccl,hha"
    }
 ]
-- 
2.33.0


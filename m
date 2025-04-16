Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76416E863;
	Wed, 16 Apr 2025 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769323; cv=none; b=OfpCsEeLR8X43ikk6HEZeYQ4sgx8gzIH92j2DpeEMqZOPt0hsS3vHVYOotFeV94IHZzbdvz0ZmVYx5RK3DRTIMOHttmmyhl6ceXCkxSncxYEFZ0ldcF+rRXFCOHh4Usghfct0jeMNoue9fQ2w/7kYeKUQ4gGvu254SnurHrt/vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769323; c=relaxed/simple;
	bh=gn+OfJbFg1/2qJQuzXXe19ZPPyxAAqvNujeZaHf4t3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a05cLShV4oCESe9U7kdHNKi559dAyrvF4DbLT9m3T/ohF2jwilNIkGPblPfEVzweTD+I3nR0l8wsh7oi6hPEORzDdNxI3vfCsQjwPYmBZ5VGJR5B/THl+HyVT/dQKSxxri5W5peEOtJqQdRxfRJ6JjPSmuEEOdWwKaevo/HicXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zckv803Cxz13KdD;
	Wed, 16 Apr 2025 10:07:48 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 848C618047B;
	Wed, 16 Apr 2025 10:08:37 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Apr 2025 10:08:37 +0800
Received: from localhost.localdomain (10.90.30.45) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Apr 2025 10:08:36 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<leo.yan@arm.com>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<mike.leach@linaro.org>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>
CC: <linuxarm@huawei.com>, <hejunhao3@huawei.com>
Subject: [PATCH 1/2] perf vendor events arm64: Fill up Desc field for Hisi hip08 hha pmu
Date: Wed, 16 Apr 2025 10:02:15 +0800
Message-ID: <20250416020216.3377959-2-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250416020216.3377959-1-hejunhao3@huawei.com>
References: <20250416020216.3377959-1-hejunhao3@huawei.com>
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
 $ perf list
 ...
 uncore hha:
   hisi_sccl1_hha2/sdir-hit/
   hisi_sccl1_hha2/sdir-lookup/
 ...
 uncore hha:
   edir-hit
      [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl,hha]

after patch:
 $ perf list
 ...
 uncore hha:
   edir-hit
      [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl,hha]
   sdir-hit
      [Count of The number of HHA S-Dir hit operations. Unit: hisi_sccl,hha]
   sdir-lookup
      [Count of the number of HHA S-Dir lookup operations. Unit: hisi_sccl,hha]

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 .../arm64/hisilicon/hip08/uncore-hha.json     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
index 9a7ec7af2060..5ac8f919b498 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -30,15 +30,21 @@
    {
 	    "ConfigCode": "0x4",
 	    "EventName": "rx_wbi",
+	    "BriefDescription": "Count of the number of WriteBackI operations that HHA has received",
+	    "PublicDescription": "Count of the number of WriteBackI operations that HHA has received",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x5",
 	    "EventName": "rx_wbip",
+	    "BriefDescription": "Count of the number of WriteBackIPtl operations that HHA has received",
+	    "PublicDescription": "Count of the number of WriteBackIPtl operations that HHA has received",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x11",
+	    "BriefDescription": "Count of the number of WriteThruIStash operations that HHA has received",
+	    "PublicDescription": "Count of the number of WriteThruIStash operations that HHA has received",
 	    "EventName": "rx_wtistash",
 	    "Unit": "hisi_sccl,hha"
    },
@@ -87,66 +93,92 @@
    {
 	    "ConfigCode": "0x23",
 	    "EventName": "bi_num",
+	    "BriefDescription": "Count of the number of HHA BackInvalid operations",
+	    "PublicDescription": "Count of the number of HHA BackInvalid operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x32",
 	    "EventName": "mediated_num",
+	    "BriefDescription": "Count of the number of Mediated operations that the HHA has forwarded",
+	    "PublicDescription": "Count of the number of Mediated operations that the HHA has forwarded",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x33",
 	    "EventName": "tx_snp_num",
+	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent",
+	    "PublicDescription": "Count of the number of Snoop operations that the HHA has sent",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x34",
 	    "EventName": "tx_snp_outer",
+	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent to another socket",
+	    "PublicDescription": "Count of the number of Snoop operations that the HHA has sent to another socket",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x35",
 	    "EventName": "tx_snp_ccix",
+	    "BriefDescription": "Count of the number of Snoop operations that the HHA has sent to CCIX",
+	    "PublicDescription": "Count of the number of Snoop operations that the HHA has sent to CCIX",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x38",
 	    "EventName": "rx_snprspdata",
+	    "BriefDescription": "Count of the number of SnprspData flit operations that HHA has received",
+	    "PublicDescription": "Count of the number of SnprspData flit operations that HHA has received",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x3c",
 	    "EventName": "rx_snprsp_outer",
+	    "BriefDescription": "Count of the number of SnprspData operations that HHA has received from another socket",
+	    "PublicDescription": "Count of the number of SnprspData operations that HHA has received from another socket",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x40",
 	    "EventName": "sdir-lookup",
+	    "BriefDescription": "Count of the number of HHA S-Dir lookup operations",
+	    "PublicDescription": "Count of the number of HHA S-Dir lookup operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x41",
 	    "EventName": "edir-lookup",
+	    "BriefDescription": "Count of the number of HHA E-Dir lookup operations",
+	    "PublicDescription": "Count of the number of HHA E-Dir lookup operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x42",
 	    "EventName": "sdir-hit",
+	    "BriefDescription": "Count of the number of HHA S-Dir hit operations",
+	    "PublicDescription": "Count of the number of HHA S-Dir hit operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x43",
 	    "EventName": "edir-hit",
+	    "BriefDescription": "Count of the number of HHA E-Dir hit operations",
+	    "PublicDescription": "Count of the number of HHA E-Dir hit operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x4c",
 	    "EventName": "sdir-home-migrate",
+	    "BriefDescription": "Count of the number of HHA S-Dir read home migrate operations",
+	    "PublicDescription": "Count of the number of HHA S-Dir read home migrate operations",
 	    "Unit": "hisi_sccl,hha"
    },
    {
 	    "ConfigCode": "0x4d",
 	    "EventName": "edir-home-migrate",
+	    "BriefDescription": "Count of the number of HHA E-Dir read home migrate operations",
+	    "PublicDescription": "Count of the number of HHA E-Dir read home migrate operations",
 	    "Unit": "hisi_sccl,hha"
    }
 ]
-- 
2.33.0


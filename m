Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BE44CAE0
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033832; cv=fail; b=EkjRSohRe19kDTQxmsMYbWTPA8ZhxpMqLcs4wvvHB64LFsAI0TvcyzYVdt8DTQtbk1trVXy/T9c11jPFqowHPxOzyFsCeSxK9WNK4KSyrVq1ENdwpuAiRAWPQ37Etm4E1AH44ogErY6W+EBBIPQff1NpXQ0br62cEqPaRYgH6/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033832; c=relaxed/simple;
	bh=OPcTOZQyrHVWJn4robXbVUQukpvFBaR0Ixd5pYHB9Cc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muveyv58BoCa7hWkqVw/v/iYj2064zhWS+9E4XNTNmlA/Uo7R44EvVZ7W/o1Sq2C7VEzBqRjHM5g8pl8EbCPoxO5NoBoxDXXTmOr7VvY7CUob5dBYV5nGm3ziIW+AwR3cgDwwDmgzhbfTYRgfLPTSJzDAn+22M2iM5JwbUwP1IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VsDK3XQI; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wY/Lsz3q; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VsDK3XQI";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wY/Lsz3q"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBQA6f2106435;
	Tue, 14 Jul 2026 07:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Kcz/g9zeU0RdTtftMvQEQzK/pkytIAglhtsHeRUZq
	hs=; b=VsDK3XQIGzJljaAGf4qfJ5iR3l/DwiQ6YDweWBVn7u4ugRLVxEWW/ryjO
	v213bJE+3EZUgrbXUQ3fz14I6r/IEyMswp/PelwMJ1NPOnSYQdfI5ZuKXlJ4eFZT
	Dl6PzEbBl/VRUuUF6aHDLRa5VBa92oV747NKBtwc1HyQEoTLmLerzSrEPS5kZWZb
	I19vAkPSqcNmho75Ffozkd50tLaf+jyqvfTwkVX1aSwXtf1whnwrEDXYRiPmP4eM
	zZY/rGSuMa6OP+sAeu+T1Y3KPgC8zcF98qG6f6osldQmrxh3Yiswrh5J3SPxc3gw
	DaXLDzPh+LoTs2oqDEW6ybQFgDVgg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdm2tge48-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:56:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNhm0/TASfeh5gksNVeHffGFwiazAn5X3p99ir9Qac1HdEzQM51KQGvT5TvJDJ3Zos6Ib/5EGPw6LQkoAGqq5+AwEUYOwxF4jD59IEx8/PDMQ5RIe8Sm7LzabzxOADIo2oN0A/305+FvULrUK0C8kWYOyTvpORseTwglvxSjJINPZe/JTt/sWpvfYBtNZqPMxV7Ri15MA6/WfBJJz7ktgSFpNrXqFm1MJv9P/uiP2QetejgdWwqfkE+Xc0EuovYNle+9QjmEqpLFBanuvnAHYLNs/M6e0IjwXvWgW1W5MQhOhbLbwE6/pwZJZ5RMpcE8qUSuM6BEb2U6Z4DYwjwc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kcz/g9zeU0RdTtftMvQEQzK/pkytIAglhtsHeRUZqhs=;
 b=cWPfaKcXDc2PKM/Ae8v8o8nLU8MAwY5I+QX7L/+z1XjyYXrFdyw2l3d+8QMDHKgRD/BKyDlnS4qPJ1mpjYXihX7zAiVOTUNsGVqqwwNP33d6zMFMxDSmkm/zTdnyxX/Q9hd6HWVSYH7yovJlzk9PPawwYb8ZmVg+3Qa7pro6B63kJoEITU/p9RHu8QQgn9BCUMUDAwuxUUob7Z8XKEsbWZu/XU8DaYhv9dsrJfz3E+lCqVRynPKkZZTcdkQnNlOu4i2qhJgM2BeTnW8wH0Px6T1PcHtUXTmPdWJ3dgQS/I4TX0FWEK5WSvWYIFJ4FTU78lYBykZI87AXHWhOb/FU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kcz/g9zeU0RdTtftMvQEQzK/pkytIAglhtsHeRUZqhs=;
 b=wY/Lsz3qV4WHDQddrq7eC82bjUmpVHU0xFfS50sg73srUZiFnsK2eIek0TA2P0PxgcYaSaY0hSI+ixLHHWzaF+Q/qX0T58A7XZvd4II3jcaEZa8i53HXb6fYioRtrzWTcE9vPgbWfnmuKcwQNI7dSoEqQ6ZyU5L/ZokGuYd9RUo=
Received: from PH7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:510:339::27)
 by DSVPR10MB997796.namprd10.prod.outlook.com (2603:10b6:8:38b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 12:56:54 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::3) by PH7PR03CA0010.outlook.office365.com
 (2603:10b6:510:339::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:56:54 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:48 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:48 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECuaH24165566;
	Tue, 14 Jul 2026 07:56:46 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 20/22] perf/events: arm64: ti: Add AM62P DDR performance events
Date: Tue, 14 Jul 2026 18:26:33 +0530
Message-ID: <20260714125635.3304437-4-v-mannuru@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714125635.3304437-1-v-mannuru@ti.com>
References: <20260714125635.3304437-1-v-mannuru@ti.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DSVPR10MB997796:EE_
X-MS-Office365-Filtering-Correlation-Id: 600da2a9-8942-4c3d-a1b6-08dee1a76172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	T9PHQrPZfYQZQgqqbX6/NnSyomRYKkaaSS7y9jblZkdKmsvjm1t9+wJ71cA9ucSPto6GWdfsdDmVYatncJkGn2srLISArLdaJ3UdFBuuQMUyctaOUyNp6Izlat18WDKyQMoQt74wEVu61lPNNKv7Jk08+mHdK0nwkGMFREjsAmLn8PVc34TzhysGeciWBxNoCMxcCf/UOj/UVwx+9cuGKYWPVQWl3xpmlAiExvMDbm4dNX9gbzJuHlUFQzY9/BbJkKcyZzBSh2eDqBXruHI861mRKEOglo44cDkPaffSw0eLe0XkZyRyz3Ps8E5SgwcIT0dNYjRpvqDxAWFBIpAWp5tCs21luXz/xHFss9LRWByFVAw2nx49F2d73S3UooaUh48VGUQUSDE4ERBCc2EJNimnoqucV9KOu5DNk2nw+pnQsMUFx9rqXvPqRsYsS0ArhME8AXp94S0I4aCfI9Ntn/X6fqphihYfLYvq6/ZAFB7ONbor3DWWBrnOYH+rh4I0wZP+wR77zFWyiBSsRYRNOwwP0EHkerIlp3f9/+F85F77z+UleBUpIVOWmQ2tdyBVXQ+oKxm/mut5e/i7u/u807RM5tvhujhkiWBvVVS/4itTiS2BWm7BwN3RCrN062vYeioUAHQt21lK7rIfkwI5eTOfUAxhUqKAUED2pnTZjxu54IjWUo4t9GqepnTrlT0SdJBYLxv2+Y165bRs10WD6A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GSQvRQWJO83p03C7R8+lFNdaohY57r4+fS93esNTqVY0Mp/2HSKpdRZysI6BqznuIGoeYfWtaBUnUvMaz2karsfxt66IFmX5Gx7VViXsnXlQ2Xdo9ETlqTVbtdoO98vOb/h1Z3QI+8Ki/2Fc01vfn86hLJFB5wcFZx7uKcwIbR8TddoNRYPKBpQF+XxbsWAEahAu6qgEvdQNv4/ks9NUYMWayX28ZWR7K/db7Eyjapprby/gKPk/DX1e/YMLNtoSOR1t79l4ggYmoMnIApNmCYPCmBFmpty5VCwQmbSikOtFvw1NX22HxEU3ffb3mLm7eXY8vOFHJk6XZ6pHTKs88+NfoHSUI9TiJWRRysp4H36405FNsaV5D7ZYUYA2PHKnWpJmMQVFdc/Y+4ndmyPtRLryJKGANbiXibfuSQGpxHAeOPze4HDBWjyo9U1Ps4NN
X-Exchange-RoutingPolicyChecked:
	Szs0E7TrKk6jxeHHA8Xb+qEN0U2GcfvAgx0KY3ypjqkbjDGbfVQVUXI70CBkVak0RtFxisFCko4oTLbkP7nFJLa+UYyLbcQl8IwiE11/fMJab1B8H6gNaF99wp9W4AHCqq5WyC/0gvqI7nOY5qzf4mFPXU1mwvWDAxMyulOzmQu4/wsqu8dIBAWyTavjCu/9ZzsRJvUexHK/JxSXsVfWzkHU1g7eeM2+le356SM4kKQ3WYtonOTK3iY6iXDJeFNrHftQvg6R4llYMCbBvQ0HRqGhUKC/Cn970w5zhsr2Ltd6k44xtXh+AcIt6nwV7IU8gip6FWiNiTBRYR9+XkuW8A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:56:54.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600da2a9-8942-4c3d-a1b6-08dee1a76172
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997796
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX0AcfbWLvrC6n
 n8Q4dWBH4yhNTKPObh2Qd29LHiGRyFYxYqPXCMlCfbNduuWh8xJm0AIgLaZALq0ujicqF1XS9DW
 V4wSfe0qoOMyA/BkxUn/6cBeeWnTLaw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX2RwKF35R2lS3
 /Q8i6OHjaClik1S8M6ZlXw+XEN6cnpz4mV99uu+hRX68GJqrAvIVJt8GeK5Sp0U1o6BlQiQHUg5
 curo1v/xuokoc7FvW50sbaVgiol2r32diFDSG6YAxdCUBUX/CMZZ6VtmXuABW5UvyPFBaSi9ohR
 HREUj5LJnbOocTlY3BlU0BPXvINBwwMUDySnQ1SZ0D6S1pwZReLjHdsQ73vVN3RiAJK7CBCTPP+
 tDeXVdRPLKwRshIvGJ+M+ntuYzfib8ILyqRT4LOvTpu94Ju06C3ZfOxwt48GSkfmtBknA0k5G99
 uHX0OKbDCcsJkMS37My9gfH+ypg9aMfms+6YNpEUMJlcQbA49aJLCDLmAnR/HnVPuWKnQMtZ+D/
 iHQk3VYf927xTqMvVzTHVZSMwZWNrOMnGlkMpyI7qTYAHlui5jnqmGhzSPlA9GeQ3FBoytWYDL6
 dbwST/A3nmOu4jbKSLA==
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a56321b cx=c_pps
 a=UZSaxNdd3h1KCbY4z3Yg0Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=v80JpUPI8rrDPgMNanQA:9
X-Proofpoint-ORIG-GUID: w0gCosevRchrgqZcWStrqzjypazd7Rlb
X-Proofpoint-GUID: w0gCosevRchrgqZcWStrqzjypazd7Rlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140135

From: Aarya Chaumal <a-chaumal@ti.com>

Add perf JSON event and metric definitions for the AM62P
DDR controller PMU.

Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
---
 .../arch/arm64/ti/am62p/sys/ddrc.json         | 240 ++++++++++++++++++
 .../arch/arm64/ti/am62p/sys/metrics.json      |  34 +++
 2 files changed, 274 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62p/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62p/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/ti/am62p/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/ti/am62p/sys/ddrc.json
new file mode 100644
index 0000000000000..72ff307d6bcfb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am62p/sys/ddrc.json
@@ -0,0 +1,240 @@
+[
+   {
+       "BriefDescription": "Counts every Write command",
+       "EventCode": "0x00",
+       "EventName": "k3_ddr.write",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Read command",
+       "EventCode": "0x01",
+       "EventName": "k3_ddr.read",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every read as a result of a RMW command",
+       "EventCode": "0x02",
+       "EventName": "k3_ddr.read_rmw",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Activate command",
+       "EventCode": "0x03",
+       "EventName": "k3_ddr.activate",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Precharge command",
+       "EventCode": "0x04",
+       "EventName": "k3_ddr.precharge",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Precharge All command",
+       "EventCode": "0x05",
+       "EventName": "k3_ddr.precharge_all",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Read command",
+       "EventCode": "0x06",
+       "EventName": "k3_ddr.mode_reg_read",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Write command",
+       "EventCode": "0x07",
+       "EventName": "k3_ddr.mode_reg_write",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Per Bank Refresh command",
+       "EventCode": "0x08",
+       "EventName": "k3_ddr.per_bank_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Auto Refresh command",
+       "EventCode": "0x09",
+       "EventName": "k3_ddr.auto_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Long command",
+       "EventCode": "0x0a",
+       "EventName": "k3_ddr.zq_calib_long",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Short command",
+       "EventCode": "0x0b",
+       "EventName": "k3_ddr.zq_calib_short",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read and Read-to-Write bus-turn-around",
+       "EventCode": "0x0c",
+       "EventName": "k3_ddr.bus_turn_around",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Write address collision",
+       "EventCode": "0x0d",
+       "EventName": "k3_ddr.write_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read address collision",
+       "EventCode": "0x0e",
+       "EventName": "k3_ddr.write_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Write address collision",
+       "EventCode": "0x0f",
+       "EventName": "k3_ddr.read_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Read address collision",
+       "EventCode": "0x10",
+       "EventName": "k3_ddr.read_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down Self-Refresh mode",
+       "EventCode": "0x11",
+       "EventName": "k3_ddr.exit_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down Self-Refresh mode",
+       "EventCode": "0x12",
+       "EventName": "k3_ddr.entry_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down Self-Refresh mode",
+       "EventCode": "0x13",
+       "EventName": "k3_ddr.power_down_self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down mode",
+       "EventCode": "0x14",
+       "EventName": "k3_ddr.exit_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down mode",
+       "EventCode": "0x15",
+       "EventName": "k3_ddr.entry_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down mode",
+       "EventCode": "0x16",
+       "EventName": "k3_ddr.power_down_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every exit from Self-Refresh mode",
+       "EventCode": "0x17",
+       "EventName": "k3_ddr.exit_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every entry into Self-Refresh mode",
+       "EventCode": "0x18",
+       "EventName": "k3_ddr.entry_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Self-Refresh mode",
+       "EventCode": "0x19",
+       "EventName": "k3_ddr.self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller command queue is full",
+       "EventCode": "0x1c",
+       "EventName": "k3_ddr.command_queue_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller info FIFO is full",
+       "EventCode": "0x1d",
+       "EventName": "k3_ddr.info_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write latency FIFO is full",
+       "EventCode": "0x1e",
+       "EventName": "k3_ddr.write_latency_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port command FIFO is full",
+       "EventCode": "0x1f",
+       "EventName": "k3_ddr.port_command_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write response FIFO is full",
+       "EventCode": "0x20",
+       "EventName": "k3_ddr.write_response_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port write FIFO is full",
+       "EventCode": "0x21",
+       "EventName": "k3_ddr.port_write_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller core read FIFO is full",
+       "EventCode": "0x22",
+       "EventName": "k3_ddr.core_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port read FIFO is full",
+       "EventCode": "0x23",
+       "EventName": "k3_ddr.port_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62P"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ti/am62p/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/ti/am62p/sys/metrics.json
new file mode 100644
index 0000000000000..777d1a013632e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am62p/sys/metrics.json
@@ -0,0 +1,34 @@
+[
+    {
+        "BriefDescription": "DDR memory read bandwidth in MB/s (32-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.read * 64) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62p.read_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM62P"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth in MB/s (32-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.write * 64) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62p.write_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM62P"
+    },
+    {
+        "BriefDescription": "Average DDR read requests per second",
+        "MetricExpr": "k3_ddr.read / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62p.read_requests_per_sec",
+        "ScaleUnit": "1reads/sec",
+        "Compat": "AM62P"
+    },
+    {
+        "BriefDescription": "Average DDR write requests per second",
+        "MetricExpr": "k3_ddr.write / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62p.write_requests_per_sec",
+        "ScaleUnit": "1writes/sec",
+        "Compat": "AM62P"
+    }
+]
-- 
2.34.1


Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8134483AD
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033831; cv=fail; b=pHHSlOSBc/ZGmZ8AimkZoCUWLiDumCRgVhSvJKDc0HZOCO7qQtFwGs1z26lI/WosJeWpMaln2fI4HklaSdEIdJ8tBscjJmOsiTyOtX81yNbjW0bR6JPKH1d97Zra7ujpiQLoF4FJ107DECyfis9Q534F8ePJIjFlDobfHhIDGvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033831; c=relaxed/simple;
	bh=6+hIMJW1Dfnecoya9pP0e4oGJJCG+O782RQm/VqX454=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FL4Qb0m54UQScn9pDP3yAZxDbXeqhujYDKrdkGL/bjjmdx6DjMXLWgIN9pmgsj+21+ZC2fYVOPdONVQy3qGU8Kok1E/z9Fd9/CoW+w4MSfoTx/QZtuxQrkFvbkP7pxK/eYvmF6VVHrghDnO9CZOgadrM9SXDW9eKn74rDcDG2nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=b0Yr1Y+E; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YE2dn6QU; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="b0Yr1Y+E";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YE2dn6QU"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66EBhtit2165661;
	Tue, 14 Jul 2026 07:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Hhb/CQ0cZnt+TxMs4PQ7NMWkv5RF4aGz7Jmt5X9rs
	ic=; b=b0Yr1Y+EX6J6mDs4ATsQFShc6Fuk+DiBsgWh1RcUeapmhLY6ZWEf79rRk
	blslGTE6g1oEwNmzgGisb6xG0C+8aWSCEj+mPOnpeLmAZ72hQKzRF5r3PC2n9O4W
	WKKdslEPvHtknoQV0sUvBzEFS/xpE+EwkU4eA0veUkRlPMn6YmJc36ZpD1GrIzz+
	MZNkl/xaukWxU0QmbangT4o/rjbFYsHhRygQuisHQxOzTKTIKbojBVcvn9mt/Uiq
	iSfXwYIpnH1yTl1O3wvRdDtHdI1ffFGHnug1qq0Lc4GXmmIFoft/ZseSI0Yg07SG
	97hB/2IDwZERXye3D+eGUUCXFyerQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fdmgcgbjc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:56:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx2Yq9rFff0GQoc86ObZMPTw0pHSaQDq/h0dVrrdbK7NzhXfWEX96N1LQpSjHaKqqNMXZ+FGK4z4rU4MCoL+V4O/O44cgYUyYPCxMKSWtKRey4kILdh52nBIu5QlQOY+lNR4YM2pFV6miOAYZ/QFw9W7c0datF2s5pSfFWi9hZwiyWeUNt2LL87FwoIM4bfyPwlp8bFjuvUhqna9p52XwCpniPDkiuxCunfC2u6nZAbVWIxIex76OfmxzLH70czlgW/F82MIY9fm0Utie4tTuQeYnmr2iD2yZbDidx678MkMCpzqwI9qRR+PIFgXnPLFQ3tpudvjBEkdtTx33bfCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhb/CQ0cZnt+TxMs4PQ7NMWkv5RF4aGz7Jmt5X9rsic=;
 b=EerwNJNrEpQlbJdMz1/wGAeHnTutT0XkP3CpdIddwDru7mYeuWpEssEXj658O27d7vP8a+E4Wv1InWdEmNwpg5efpqPGe6Z9hlk9aAHQFuxmqTI0gTA/I9ZrwwW+epecbQ7a9xoX/s0xD+kvUIxPzs6VKcS0mYjNoxDrHWwqB9M+CvMM2ND12vHmxQN00Wb/Njkl0Og817RckYO2aHjGJ58lLLqANR1Gs7ge4x/OpWcxpLJlsnOHNViUGedppD1VmKjcKyJuSez9jMU4vUg9oaIKQ+nZjdviQGZ6n3E+LnL6gU0J65UMwSaOoHWvT4t6wJWm0sBYN+kOHLcVhbjQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhb/CQ0cZnt+TxMs4PQ7NMWkv5RF4aGz7Jmt5X9rsic=;
 b=YE2dn6QUjW5dPb7W3g+uwSsKNFZaNC1s8bBItpJoe7/f3ZyAHvPwuKNwcoMjKvhwt9F1n7ccjQkbD4sTc3inpzohm/SBPKEijFUsP1y3KdWcKr4Dt2WgepZjokwUmasJDS0EpN9n3pm0ENT0vPZVsSItLAvX6zoM3tvPNoSGCHc=
Received: from PH7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:510:339::19)
 by DS5PR10MB997731.namprd10.prod.outlook.com (2603:10b6:8:343::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 14 Jul
 2026 12:56:52 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::8c) by PH7PR03CA0015.outlook.office365.com
 (2603:10b6:510:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:56:51 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:42 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:42 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECuaH04165566;
	Tue, 14 Jul 2026 07:56:40 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 18/22] perf/events: arm64: ti: Add AM62 DDR performance events
Date: Tue, 14 Jul 2026 18:26:31 +0530
Message-ID: <20260714125635.3304437-2-v-mannuru@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS5PR10MB997731:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f64d181-2ee8-472d-9ad4-08dee1a75fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FJ1aLVZN3uFZIQIMNi8a+AA9WWPDReV0+7wI2S5lcE4a8pL/JuMlrs8PhQJe6WPZVFc2JZhVHiYvrAJ6j9fSOLnADnZhYEOH8YfU3wa3NV8AKE83eetSy9UbVeoNpLiCALehRDmMPeGkB58K4eaGIUsj+IgzHR1kYDCV8rou+Sj1OPrckVZBj69VeBzWZpoOTmf3RfQWbEgg/XFtc/CPwL7BRRn+mP8eyKtDiJE6YYUGXLVyI64aeJS0ttZV+2UoZpuWZBTsuxKYLTIH7OqReKV/m0YZJBFIOP2C4m9POQxe7pX6/5K+wsXGgZskmqDMbyIyR65PSH7ldAfL8szabFYJ+kg5dAO19jTbd7GWZocqSi6DncR2GA6Piv19ZBJjG9RpB+RLKiZ3qc4I1FQjeGMNaUjZENByXPh9HmUh07KbgL13n8VoYJffjFVvElSspjW57I3qkaeH5C1lodcm70m5fJCAix+0x9mhsjGwQU8Cwxr9D1gS2rX+BWJevRkmfZYFwBcGFkwqoA6XMOLo7TlE2vqMBo37Je6kpmdhK89PS9/e6ZDRS3eVhN9Zo6KCptwBJB9aVqWzI1l4S5/LTbuCOa3p60vTKFBjayNGUnC43XNCqPsKUv/4MpXTuLeH+H2j62JuH8Qqw3B04bYImAcm5VthjlbgTsKztq0+D9FSgnYu23QjWrBYBozcUiK79wpvGrdX7ZsAXDNN6K7C9A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4ZOrV/V3Hk3eBqNDqUxuloA4IntSjCZuI/MjNgCLbicw5KKKWX2IdJ2eAjfeTyBVhyfMikikfnOa/eCum8ppj4OsednI89qLk+WejB0CNXN5p5HSMkqveUddjQcjXQJGmHtBp6+alIuICLpVLFdX4ck569jbDuEX3/AXks2R59CIyZZu5OFYexGvXDiRd9CLKd1B3q4IiGhXJtRZYjS6RUZYBkoaBdX50Rhfq6jwsVMSiXYiFaoOiUSVn/16DBxd1JTCm3oXWpEluegr9R9MYP5SqyEzcvkuM4EGE3CeGmvwSrzQIQvibFEMAkk4GZIwtWTcUPz3agRI9w6HcYNcQbFgTVJEVWtrE0cexGKm6t7yhd0zXASfEkhHc9Sx3yFgg3+yGPY7Z8rqLdzZrjAzCEjs0yBWgktO4nAF0n6STe9A9Lss/QZSBRShN4A2PfKD
X-Exchange-RoutingPolicyChecked:
	XQBF+hpUXyRIz314bIKSILjiam0xxvEv9FoBCg6pYbfzvT3XOxHJqgVqSAKM78ALGchhjKAo+99DNyznhfgJndOekjlMdH45Z+RaMPEcnoz9SsDBt3yFfpEtNC0lFiSupie/w6Ks8FKVYC1nvr9B2sIjsaRAATiig75QH0r9m/aglcbiThq1fVPU3J81MKRLAqguV4ZxpwMwpSy784nLXb4WihWBGcD6eUlubU1oohN1CXVi1AIwWZWJC4rzwt4nA57ow4nxEl3RKfyDV/8LNAlqWZcNjb3IqYVxZRghDew4KSuWeDkoyxMkcmKAIZR+bODkHShV9D5QhcIUc/AImg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:56:51.6079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f64d181-2ee8-472d-9ad4-08dee1a75fd7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997731
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfXwyHpDFjGkWV1
 ZycGyqet2JSu1dnA3h/85q42FSXufHGSjS5K+Mx/S3lEae7L86iw6DJasUH5PEGA81oJ8nJpc/1
 MFNmwkRO7XtwZ2d/WLLrjn0TY4OZea4=
X-Proofpoint-GUID: XHLC-eSBF1it_DUfJuaijeNJ2-kks64y
X-Proofpoint-ORIG-GUID: XHLC-eSBF1it_DUfJuaijeNJ2-kks64y
X-Authority-Analysis: v=2.4 cv=GLo41ONK c=1 sm=1 tr=0 ts=6a563217 cx=c_pps
 a=fjiyZBo1bxGOeg3e+tCWfg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=v80JpUPI8rrDPgMNanQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX6hP5N9dSPCpl
 olkwMXIVTUI6a9ZQdav2hOhjXNeauNLlzqKn202fnpGyUykZmABsnCcRCNwGMvj/5o4qk9zuwG/
 2CI7pq/bP3LElD2euxhRLVX1k4bOqYAU6XPDSjJYyebt4NLcj+glGC8Qzyz3AGpKfhnzYlLuUbs
 KM4qbClIow6WTutKpPRGJGyH1UVgOgIkuoe83eXodiBXCxx9NxXRWTiFHisIg3PztSRvkc4t1+3
 ewz39DYZoh1OhMuY2r6ij9tIaklzshBiOcCaOesviIZf1YUPr/B1sRA5KSoSi0hvXw7G78vX4IS
 4EyN7Tnzqvh+vADEg/ve9k26qG7MATSjJVsxd+skEJ438FthsqQ2su0nX+zsgmwoZbfI4tAyJ2j
 GnR4JbgxZwQioAY7Z+Qgrmb0gHV2nSDn2kqNltOFZuiqsVmAplnxwvkviYoep5Lx+gbF4A9GtF9
 OymvjHL1DFSVCIaVtZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140135

From: Aarya Chaumal <a-chaumal@ti.com>

Add perf JSON event and metric definitions for the AM62
DDR controller PMU.

Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
---
 .../arch/arm64/ti/am62/sys/ddrc.json          | 240 ++++++++++++++++++
 .../arch/arm64/ti/am62/sys/metrics.json       |  34 +++
 2 files changed, 274 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/ti/am62/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/ti/am62/sys/ddrc.json
new file mode 100644
index 0000000000000..4cc794477d1d9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am62/sys/ddrc.json
@@ -0,0 +1,240 @@
+[
+   {
+       "BriefDescription": "Counts every Write command",
+       "EventCode": "0x00",
+       "EventName": "k3_ddr.write",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Read command",
+       "EventCode": "0x01",
+       "EventName": "k3_ddr.read",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every read as a result of a RMW command",
+       "EventCode": "0x02",
+       "EventName": "k3_ddr.read_rmw",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Activate command",
+       "EventCode": "0x03",
+       "EventName": "k3_ddr.activate",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Precharge command",
+       "EventCode": "0x04",
+       "EventName": "k3_ddr.precharge",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Precharge All command",
+       "EventCode": "0x05",
+       "EventName": "k3_ddr.precharge_all",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Read command",
+       "EventCode": "0x06",
+       "EventName": "k3_ddr.mode_reg_read",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Write command",
+       "EventCode": "0x07",
+       "EventName": "k3_ddr.mode_reg_write",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Per Bank Refresh command",
+       "EventCode": "0x08",
+       "EventName": "k3_ddr.per_bank_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Auto Refresh command",
+       "EventCode": "0x09",
+       "EventName": "k3_ddr.auto_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Long command",
+       "EventCode": "0x0a",
+       "EventName": "k3_ddr.zq_calib_long",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Short command",
+       "EventCode": "0x0b",
+       "EventName": "k3_ddr.zq_calib_short",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read and Read-to-Write bus-turn-around",
+       "EventCode": "0x0c",
+       "EventName": "k3_ddr.bus_turn_around",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Write address collision",
+       "EventCode": "0x0d",
+       "EventName": "k3_ddr.write_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read address collision",
+       "EventCode": "0x0e",
+       "EventName": "k3_ddr.write_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Write address collision",
+       "EventCode": "0x0f",
+       "EventName": "k3_ddr.read_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Read address collision",
+       "EventCode": "0x10",
+       "EventName": "k3_ddr.read_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down Self-Refresh mode",
+       "EventCode": "0x11",
+       "EventName": "k3_ddr.exit_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down Self-Refresh mode",
+       "EventCode": "0x12",
+       "EventName": "k3_ddr.entry_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down Self-Refresh mode",
+       "EventCode": "0x13",
+       "EventName": "k3_ddr.power_down_self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down mode",
+       "EventCode": "0x14",
+       "EventName": "k3_ddr.exit_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down mode",
+       "EventCode": "0x15",
+       "EventName": "k3_ddr.entry_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down mode",
+       "EventCode": "0x16",
+       "EventName": "k3_ddr.power_down_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every exit from Self-Refresh mode",
+       "EventCode": "0x17",
+       "EventName": "k3_ddr.exit_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every entry into Self-Refresh mode",
+       "EventCode": "0x18",
+       "EventName": "k3_ddr.entry_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Self-Refresh mode",
+       "EventCode": "0x19",
+       "EventName": "k3_ddr.self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller command queue is full",
+       "EventCode": "0x1c",
+       "EventName": "k3_ddr.command_queue_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller info FIFO is full",
+       "EventCode": "0x1d",
+       "EventName": "k3_ddr.info_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write latency FIFO is full",
+       "EventCode": "0x1e",
+       "EventName": "k3_ddr.write_latency_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port command FIFO is full",
+       "EventCode": "0x1f",
+       "EventName": "k3_ddr.port_command_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write response FIFO is full",
+       "EventCode": "0x20",
+       "EventName": "k3_ddr.write_response_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port write FIFO is full",
+       "EventCode": "0x21",
+       "EventName": "k3_ddr.port_write_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller core read FIFO is full",
+       "EventCode": "0x22",
+       "EventName": "k3_ddr.core_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port read FIFO is full",
+       "EventCode": "0x23",
+       "EventName": "k3_ddr.port_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "AM62"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ti/am62/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/ti/am62/sys/metrics.json
new file mode 100644
index 0000000000000..6b8431f91eee3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/am62/sys/metrics.json
@@ -0,0 +1,34 @@
+[
+    {
+        "BriefDescription": "DDR memory read bandwidth in MB/s (16-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.read * 32) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62.read_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM62"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth in MB/s (16-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.write * 32) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62.write_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "AM62"
+    },
+    {
+        "BriefDescription": "Average DDR read requests per second",
+        "MetricExpr": "k3_ddr.read / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62.read_requests_per_sec",
+        "ScaleUnit": "1reads/sec",
+        "Compat": "AM62"
+    },
+    {
+        "BriefDescription": "Average DDR write requests per second",
+        "MetricExpr": "k3_ddr.write / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_am62.write_requests_per_sec",
+        "ScaleUnit": "1writes/sec",
+        "Compat": "AM62"
+    }
+]
-- 
2.34.1


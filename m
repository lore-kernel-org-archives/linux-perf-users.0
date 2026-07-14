Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DE3E274B
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033829; cv=fail; b=rtxrBbnJ34cUglOeVDOQ/LGACR0ol1ZDIKsL5LyR3fZhpUJX023VnOjMq0RO7CDZlt3DbK56+0OLhSWAGuBku66kN+Wxmi0lz5y+CI0m5/Zk55eBA2jr/8IIM00W3tU9LNZqFLIHbHq7/f2OhEzBHwUE6kZ/eV4KaNzqrWHY0VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033829; c=relaxed/simple;
	bh=IdpTEj/puOWzFPA7ojlfI/ZRR4Y/Dz5mFt4Q2Nn2BWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S5fKmvUL+j+SEb8RE9nuuRC7bVugiKDNYLda6go29tK6lbuLbVzgRsxjOtlNuJ+CiJ2NdcoyJyclaijcGFd12fLluQVCNiywa30xQIeNbaEI3v2YeOPE8YVhHNSqV/1g7/+xsc/Q/mxMICu0HB8yZIiDFTZyquAueMqA7O5zWOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=A6QascPv; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DEfwLMXA; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="A6QascPv";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DEfwLMXA"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBQDti2106470;
	Tue, 14 Jul 2026 07:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=dr0DzK/Ird6hJ
	FiE388NpvYsswoZEmuby2E3Sj2Iztw=; b=A6QascPv78iKy5I+NtCzXxnJMyr5v
	YXSSW9RTtTy6cNZmz3UVRFXj0w7RlWp345VSI4KWYZ6pJYvNrDhIqpMAgRZxXwIw
	dHoZahrn4QNAumNb+a8EFnF5y2zXwy9b2V7Atqi7qaVbnOcYK47ZlILnuxG7mMQk
	b+Sy/EMnmzAaDdb58n7qZMoL9ZPzpUpcwzh2WohYdNYSj1WTknJWAIq6CKe5GFb7
	4xKN/HgkeHP0S342Ww36eyw98swLtL3jbauhGTlTvcGIv6QqMveBDSoC7TO6oWz7
	VzeKIzNT8w33vWNewFUMmMS8+tQFfK2XacYPuceYPCqV+DogQnjhyiQOg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdm2tge3y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:56:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flbT+ulgGRNoOaM8aE8poo75fTMTfdPfMCA17RaKU1ITtj6BxI0B1hTjhQFRIlQHd1kBDPn/8cJJm7xeiDkfWRccqiCxj3lmwYLwQYwSARIdDtsV1kegHmGqxsa1KczBQKIP+ukCFWc3xU4XWM50yULS13B4LCAnJcmCfDPEzHS2oumwXIl4Jcwg6l+UEYKMh8CIkjN87G39TQKVpvlPaFb13G7FxcCsdqAW3imFVYuIrB6AKRE2Oj6s8Q3lvMFA/4CxGy1B0jXcpK19HEnp6erKq0fVXsx3RrZax7xPo48EM1H4DxhnR06y4PSrBg2WL7eqgiznU923WWRW7VjTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr0DzK/Ird6hJFiE388NpvYsswoZEmuby2E3Sj2Iztw=;
 b=JWSPV04n7NnLdQOS8di1HRhMCDC1KP6SWjN9z6nE6pDDw930Wt/7KNREHbeiF3Tb4RtK7uXZeZiNy6JwtGWAw+zY+SfXchZhYsqihigX2HtJ8D31xcjMabk3ufNtfBKHSmHKhCwzFNNLAaS5Btmct7Pqc1sZnsPNHlJO6sKlrLb4JuOWVcD0aQnhDhbH1whBbiJ39FBj29KnhaxTSs1aW2g1hkQW6vxzTK7PeWbWuZ1db4SF1q6WNs5bktWwSbrYVCw19Bm7vdf7MvBGTe+J0WXi4UQqj/KgQjh0Knk8JoyrQUaGbxmYeyINnRZBfD2L5ii0p74TBb3qFUvW0b6JeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr0DzK/Ird6hJFiE388NpvYsswoZEmuby2E3Sj2Iztw=;
 b=DEfwLMXAjqfSV5GvgWE4/re2RbT7r+UUBxtvL2X7K/kn+UFKxYhggCh34OrPF+8sLxGT2a7qeS+XmO0HIaLUiCdfhB4zs9zdK4x5MURC8BSmyUYsAi2q3r8D7pzY9wCBGMtJgicwf1aMo5a4uUqZ5ww+3Og/8mGDdppWtVfngKI=
Received: from PH7PR03CA0018.namprd03.prod.outlook.com (2603:10b6:510:339::15)
 by MW4PR10MB6396.namprd10.prod.outlook.com (2603:10b6:303:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 12:56:51 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::41) by PH7PR03CA0018.outlook.office365.com
 (2603:10b6:510:339::15) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:56:50 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:40 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:39 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECuaGx4165566;
	Tue, 14 Jul 2026 07:56:36 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 17/22] perf/events: arm64: ti: Add J7 DDR performance events
Date: Tue, 14 Jul 2026 18:26:30 +0530
Message-ID: <20260714125635.3304437-1-v-mannuru@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MW4PR10MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc2e955-3909-407d-7743-08dee1a75f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zK+TwCsz5O4zc38peeqWgUtkyAE2yN4gioPd7JA7eLfro/hJBML8NySdXkTGJ2+DOg60ZDHaGTY3G2RPStZ8b92xxtSWWGchOmxdCHsQxH1tv+UtpMSMEdZZt+GfyGOqdmCpfnarmyCvBSLrmoZpwKR+e35OPvnjA9lNtvhBs0M1hiVeouiTyOsF1P31MyYeWUfoiY2pLSJMOFs036Gnv7CUfZY/FJmgNTiAA6nmHOqMeEM0cen01qcYxxOtdiWrpeRdWFoh+XYE9fTFFAJHXWJTJwzPG+FyFJiu+c9R2kTVRYw0OfCsa6jRPRNazf9HIYuRxdrgvUWklr4mNLKbO+CjEJz0Hojylxm/fCV4sDf0vKVv7qwDhH1I9GImN+qxUz+i/yTi895B6pNJmk8i6iV+nPbx4lWIKf3Z1OI3FqSHDSxHJdP9rAzquxsudlMOUBel7XcWfvkKQIW/iXiUXJi56uvZY+vMQrs7Pv/VOPEX4thhZJ5uhMlODXO1T987Q+di+idjMMCCUwAco0o2OabzSyIEypjhkbsNQSf2UqxTNeO/AkbXPsDNjVooPt6ME2tzgEGZhk11L1iYQbY50aDYW4Ki1by81tAqcDrWqLBmaIWGa6/bTqgfUE9aZR86Chsup6+PM4PD6yKO4wC7uZqJU71EqPDibjHeF1shT8deLpSv7Qvv+BnVRudTtbyB+F1ZE8wLNKeznLf9QeQrSQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M0eXVbXG/WJZI0wtlOOUCokMdYLF54wP7qBooEk22Ll+TPgbEwxUSuodWiu2h7vOa+uLTt073fsDr5ObDfSsYOxcQarLD38xPhHT6dae1eJ9sHE1Atkc5VLelGdZGUhECEoCckpuMiTXRpo9RJjrDlZXL8hss74fDHJDcKLaSyAAVYLv1p73vQOeVqXeE5REkdrl3Y/9A4OQBELGW0j0IQYvLpv6Uekw1Gn3tnk6CulSI2ypW75ltvEGFvQ/T4vYwAhMtHM4rTuL79z1wFYdiaUTHj6lFhLde9/W3x2K8YzQYa7jAgJvCZL8W3H8MEpFmwdnG3lP5cv1mGA3R410SopTf5/TQP6OCLPBgiQd7SKBFddZ/eoTjOc6Fg3bLHO2x040Z6TcDWUEEzFqhwM693ddFgXYAg1cIXkYoSm9e8Uf5F7m9XwnNwDxKpUOpiKi
X-Exchange-RoutingPolicyChecked:
	HJVJKFnKVvReBLOGrMrEiEsoyBaeFtQhTMKXWXpV7sXhJWLqPnN6V/sd97txhWvoUmw1ro2rgzGCA1YJ5J5IvkLmZtwGgGnnqw4Pf+jtIQR1/M9kg4EtHonuLjavjt7/MJ7GcBfIn6JoXjBD92na+bh26/t/93gO3nHkKQ7DVbeH8BuFTNLH2HrsKJTApllKZFcrFh7Xm7W1eBBGKN1tQR1bKsOXV+UNLHsOkFN+QFoVy+eR57yZNCr2wOa953j4LLBTBhofdIr8D+SA97v7FRzhj/lfw3LHWtkJXR0UG3Ek/7ohjW4srj6NWbIz7Cs6NO2X/uipeCvDyc34D1Uq/A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:56:50.5270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc2e955-3909-407d-7743-08dee1a75f32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6396
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX+n+TMdxugtbD
 1tBU8cxSYXMbClj6UYuis2OqwMvssGUYCYaJCxvR5IHBvOiVv5ikskHl7ySfhdTvVDqRVdS+oA1
 97e88RZfyw5feMyHZd4B3/O56gIAi1s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX0SOcF/X593FR
 24eOGkISdDLvY/0SGaHMr/XXpM/p2BDWjd62j2N7sF0s+DQGut23kll1LFOp2I66W4ynrKVweyr
 qsa4qgEwqAnMchGF/Tmcrb+C5IUF9l8QMDI1fDB15fvRVXaGThkqrdZh0muRfmDSL9E0Vk+yXUU
 FHdZIagDEBJUKAsp1kPlciN2S6ZGEeQKH/rFAvmAgpY7eaIfTqLnTS6cQkb04ot49uVmYH6tkc/
 13wSgzKALch4tm22BgVuYYx6wzQ2J247XYHakHtBd7rII86UmC7CkkvCUZ0ZudAODBsw4HXHGYV
 lx87FrATGfLxwWQpf6o89dAJuHzR0msH3FMloOQB5q34VbtY75fStTVb441Fzgcot5SWsD4cibA
 l07nbsVUp3lT03MV3ljaGT/WeCFWBnJN5c/1LwJA7R75WvN8DZI3O5zfslzRqwN2AeSQhgPWegJ
 G0nrLvHC3i8P89pyFsg==
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a563218 cx=c_pps
 a=NYN33YLW5Jwrh4oiy2kjMw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=CM2ZRsg8qCF2Av7Hgi4A:9
X-Proofpoint-ORIG-GUID: mtui1lx-xYvOD1sPNIf-vNuh_LX-Ti26
X-Proofpoint-GUID: mtui1lx-xYvOD1sPNIf-vNuh_LX-Ti26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140135

Add perf JSON event and metric definitions for the J7 family
DDR controller PMU covering J721E, J721S2, J7200 and J784S4.

Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
---
 .../pmu-events/arch/arm64/ti/j7/sys/ddrc.json | 240 ++++++++++++++++++
 .../arch/arm64/ti/j7/sys/metrics.json         |  34 +++
 2 files changed, 274 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json
new file mode 100644
index 0000000000000..7ed64c25500d4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json
@@ -0,0 +1,240 @@
+[
+   {
+       "BriefDescription": "Counts every Write command",
+       "EventCode": "0x00",
+       "EventName": "k3_ddr.write",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Read command",
+       "EventCode": "0x01",
+       "EventName": "k3_ddr.read",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every read as a result of a RMW command",
+       "EventCode": "0x02",
+       "EventName": "k3_ddr.read_rmw",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Activate command",
+       "EventCode": "0x03",
+       "EventName": "k3_ddr.activate",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Precharge command",
+       "EventCode": "0x04",
+       "EventName": "k3_ddr.precharge",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Precharge All command",
+       "EventCode": "0x05",
+       "EventName": "k3_ddr.precharge_all",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Read command",
+       "EventCode": "0x06",
+       "EventName": "k3_ddr.mode_reg_read",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Mode Register Write command",
+       "EventCode": "0x07",
+       "EventName": "k3_ddr.mode_reg_write",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Per Bank Refresh command",
+       "EventCode": "0x08",
+       "EventName": "k3_ddr.per_bank_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Auto Refresh command",
+       "EventCode": "0x09",
+       "EventName": "k3_ddr.auto_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Long command",
+       "EventCode": "0x0a",
+       "EventName": "k3_ddr.zq_calib_long",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every ZQ Calib Short command",
+       "EventCode": "0x0b",
+       "EventName": "k3_ddr.zq_calib_short",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read and Read-to-Write bus-turn-around",
+       "EventCode": "0x0c",
+       "EventName": "k3_ddr.bus_turn_around",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Write address collision",
+       "EventCode": "0x0d",
+       "EventName": "k3_ddr.write_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Write-to-Read address collision",
+       "EventCode": "0x0e",
+       "EventName": "k3_ddr.write_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Write address collision",
+       "EventCode": "0x0f",
+       "EventName": "k3_ddr.read_write_collision",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every Read-to-Read address collision",
+       "EventCode": "0x10",
+       "EventName": "k3_ddr.read_read_collision",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down Self-Refresh mode",
+       "EventCode": "0x11",
+       "EventName": "k3_ddr.exit_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down Self-Refresh mode",
+       "EventCode": "0x12",
+       "EventName": "k3_ddr.entry_power_down_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down Self-Refresh mode",
+       "EventCode": "0x13",
+       "EventName": "k3_ddr.power_down_self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every exit from Power-Down mode",
+       "EventCode": "0x14",
+       "EventName": "k3_ddr.exit_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every entry into Power-Down mode",
+       "EventCode": "0x15",
+       "EventName": "k3_ddr.entry_power_down",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Power-Down mode",
+       "EventCode": "0x16",
+       "EventName": "k3_ddr.power_down_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every exit from Self-Refresh mode",
+       "EventCode": "0x17",
+       "EventName": "k3_ddr.exit_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every entry into Self-Refresh mode",
+       "EventCode": "0x18",
+       "EventName": "k3_ddr.entry_self_refresh",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller stays in Self-Refresh mode",
+       "EventCode": "0x19",
+       "EventName": "k3_ddr.self_refresh_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller command queue is full",
+       "EventCode": "0x1c",
+       "EventName": "k3_ddr.command_queue_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller info FIFO is full",
+       "EventCode": "0x1d",
+       "EventName": "k3_ddr.info_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write latency FIFO is full",
+       "EventCode": "0x1e",
+       "EventName": "k3_ddr.write_latency_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port command FIFO is full",
+       "EventCode": "0x1f",
+       "EventName": "k3_ddr.port_command_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller write response FIFO is full",
+       "EventCode": "0x20",
+       "EventName": "k3_ddr.write_response_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port write FIFO is full",
+       "EventCode": "0x21",
+       "EventName": "k3_ddr.port_write_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller core read FIFO is full",
+       "EventCode": "0x22",
+       "EventName": "k3_ddr.core_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   },
+   {
+       "BriefDescription": "Counts every cycle for which the DDR Controller port read FIFO is full",
+       "EventCode": "0x23",
+       "EventName": "k3_ddr.port_read_fifo_full_cycles",
+       "Unit": "k3_ddr",
+       "Compat": "J7"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json
new file mode 100644
index 0000000000000..156b2c9dec185
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json
@@ -0,0 +1,34 @@
+[
+    {
+        "BriefDescription": "DDR memory read bandwidth in MB/s (32-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.read * 64) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_j7.read_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "J7"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth in MB/s (32-bit bus, BL16)",
+        "MetricExpr": "(k3_ddr.write * 64) / (duration_time * 1e6)",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_j7.write_bandwidth_mbytes_sec",
+        "ScaleUnit": "1MB/s",
+        "Compat": "J7"
+    },
+    {
+        "BriefDescription": "Average DDR read requests per second",
+        "MetricExpr": "k3_ddr.read / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_j7.read_requests_per_sec",
+        "ScaleUnit": "1reads/sec",
+        "Compat": "J7"
+    },
+    {
+        "BriefDescription": "Average DDR write requests per second",
+        "MetricExpr": "k3_ddr.write / duration_time",
+        "MetricGroup": "ddr",
+        "MetricName": "k3_ddr_j7.write_requests_per_sec",
+        "ScaleUnit": "1writes/sec",
+        "Compat": "J7"
+    }
+]
-- 
2.34.1


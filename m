Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261073E274B;
	Tue, 14 Jul 2026 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033787; cv=fail; b=BZ8G4nB55Gv/EDxIktvA05dSGd22KGVIbjzx+FSS4u/bWMZWN9qPo5997dAzCJKC3J5cIlEIc6DTIZ8y56B5er8Z8EqSeBODctC/1HHQc2lUvQgKSCTSlU6l2y67QEx3nlzcJ0KG4PIABOHzsr/2C/t6UztEa8KJARUgb403sK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033787; c=relaxed/simple;
	bh=dtcct/8LJSzxoYISxnielWoR3wMif8LDdu4WCZHwwvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnCl2QcF8VbH7w+5M7ZSaf9VPOInIBUfI9/8faYRzA+90dxPs313FW94cx8K91yMdnIhE0PNNdhpz7Z1BeAhGZyntClS7RP7uxq8b+4CPcaChj7OyDE3oZdXcbLqzXgyZi/F+YXrt8Td2rbcxAYuVqQUA2JpyWQXU3oPoabU/Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=fBuJtMaS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eni3mbPm; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="fBuJtMaS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eni3mbPm"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBQAM72106440;
	Tue, 14 Jul 2026 07:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=adOqY3c1xvUguwVUapTV1uE9fi7gIaVtxocLC0HRa
	GE=; b=fBuJtMaS/+RDM2OsVFsZD5FxE165ohG1NmiIWQdKsm1KDXC/r2NWNgQmv
	l9tm6emlfv3MfOcv9TzpoRC6lwuchBTTuMfEicEB7SHMbZSfdSk3YYlv+dvRqvPL
	HEPcA4yHPlkHPFY29vX7RaPKxEaBZbLEv5Z4WXD7xcnRdl/CD69gatYTPnaBn9+q
	cJb96IgC4xLwJvfaalhuKMi38IvUdHrcfSov7A4TuBlwCg7JtWJiCfKfaalcOktx
	eBS5bGMDX9sBN7rMYKpohhg2xW+0C/UNgksnoUYBgI38knMZ47VFliGj4Vo+rzmP
	k9b4/5TdyHLBIxwLZaA1pbLji4WqA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdm2tge05-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:56:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf2vjzHDc6yQKPGDNLHD2PphNmwKc/nKCAU/njCEesaHK6T9Q2tZjyvi4eJ+FCedDO/tN5US8gr60gBpi0y2mkJVEHNTpjblgywYP4CoCmtlGNBIKHMANHvihzoRbzQBuc4xY7O3ymr3rHDdM9fyqGTOoHdHNcyKSjSOltVWWlAXVtLXDGfvmhQimA+pTk2x3EUI+LGen39Qi0JkGWhqpevDadqG+iNFyNfVzR+A9Xha4Po0hQuNROucR2Y+Q4qk1KS7tgf/h6AerjYDFb0SHzoaNCBRjHTKIrthmQo5uw8rFieVMUvfPJ8sxbGai40+p8jFYjiGpzfUNyahfQL/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adOqY3c1xvUguwVUapTV1uE9fi7gIaVtxocLC0HRaGE=;
 b=QoM2iqXsCKmxrheTC8FFRF315tMhCo8nNj9rf1ccjv927P2mE4ivuPXVRqGUD6m4aaAl7RKFHbc2pxOVD5D445btSjBIMbCQ7gxbhClmg9oL5PHk22C0EP2Wrg/Yfi9n9VECbSZy7CmR8N7VyhSqxyzD7gWm/CGNnEmSlTusBAP05JC0MnnVpa+im1XISNqKluvT37sI7DRi9SbqRNSbP8Kxf2mTRBUFmNeDN6rBKccKcgI6EysMggts9J66DeKPHKe04uzzoO6wQxuecdE6P9rDwB7kYt1b5k1Ik4SyFfFqAm1tr0Ro2cwIllQ6syzDBaHRpS7KBYLe6+fyOP0pTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adOqY3c1xvUguwVUapTV1uE9fi7gIaVtxocLC0HRaGE=;
 b=eni3mbPmWf3cubD8mml1Y12qbvKQ/tjptI7Dr9tFO8B2Q6cqDtPFohQc7BA4ss35xa+ZhQ6E4VKYk9dKgKoSmKEclxkhMRFpX/2Ag/iRI72EqDVdgITHuBOhoCa7BLtK8Rr0w9xpsGuU+HbVWkM+vYZsciUoak7pqQlPsvWHiV4=
Received: from CYXPR03CA0085.namprd03.prod.outlook.com (2603:10b6:930:d3::28)
 by BN0PR10MB4998.namprd10.prod.outlook.com (2603:10b6:408:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 12:56:09 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::28) by CYXPR03CA0085.outlook.office365.com
 (2603:10b6:930:d3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:56:08 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:07 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:07 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECu10u4164761;
	Tue, 14 Jul 2026 07:56:04 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <n-francis@ti.com>, <s-k6@ti.com>,
        <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 08/22] docs: perf: Add TI K3 DDR PMU documentation
Date: Tue, 14 Jul 2026 18:26:00 +0530
Message-ID: <20260714125600.3304330-2-v-mannuru@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714125600.3304330-1-v-mannuru@ti.com>
References: <20260714125600.3304330-1-v-mannuru@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|BN0PR10MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fca33e3-f5b2-4587-5f36-08dee1a74659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	f467dyayj34um7/ejXa53oXQSvPKylAOyjRVDlDeHIp36liHtzKjU/DWKGSnQlrBCQ0aAjJUFCKIYkKFNgJcfVgwYc+lFfKTMH6nrr510cSOLoNA0txd8BqBXmekR4Tndi9W5I5ERAYze9JEAFRerp1uTQfCFTRHNSSjGwM/a2yX03m/6Uq+kW5PUZBVInRcekelalYE11FsLnajiXY1yE08My0/LsAGkm8E8R4nhLZA6a/T7GKi8sAOSf8qikKg/5cdat8r/sXOctjE717mSncwfbWkC2GbRLkHX+hnocUw0KJ6TJ9z7Di0be8c24BA+aL7bvL+BleN6coieRMV1QNBY3Gkk1C7UOWORgypugjd/elGPPHhMT97NRrf8XVuIs3R+lFWW6H7UnSFwUmwRvdOz/J+GoIZe4O7zod62WPGKyxbTgzKpfBQaiGFpOr//7s+LifnCOByBesUKk6tPoVEcjSjWj2Rmm8Mbqyj9gK/j/kibdDbOlL/mVl43O7byn8yelYyXNWlvgSmsZFt+IB/9VRCpHrOLePAMf2TR2RO10YIG6FSJguBujqcBpSxi3U3NWL+lp+7CPHIDmuEMHMSC//7l77yoHpAZki7TncLyKdHw4M/RyV2VJt5pCEL2T5fstTO5yzhy6PJrhnFLROSS5Nij3h34H1O3v2sAF0iwr5eipu9wXzLwiQPFRLDR84YRQqaqNOwvZG2iAzyfw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wuLN4B5SOgQOp7vjdESvw/LkqD5V3boun2u1VzNCc7sWyAKZ13/M3xTuw3aGSHmBzb3gGFVZsgC3xAI6r4VO/F0fqdEsJuXWJZ4ZcVZ1lHO0rjlfADClnMDpECOoU7n/y/0fuAE8NYWUi+JKRQlHB/D5lZ5GULgaRstFKWiFNm2BaGP5k4kCOQaOWAyxWDz8k7RB1EknZaOAMOzlMBQLa380BtdpYavvais3B3KtUFDwd7HHD3bqcB+2hOzEcfmY3Y8qGj6sZMQvikHCvJFClMBm9zCWE1xqxHcChRe19kDCeTcdixK6dczp76I+Djh/MFO7VCqncQZhiYQS8cn4JiR/Z3Jl5FjhT+8K2SY05YI+L2yjmotl9OROAjsY+FzEH8zI0LHmHcgPf+APu4MgjCqYN1Y22uC/B2lGQki8O8kyRgOrC04nUV42z4RbbCZm
X-Exchange-RoutingPolicyChecked:
	iIETTAfr1beHGFzG01+9G5AXFz8az8XkQGTWs9BkjqHW1ohNweKzJow9dMCFB+IRaCGIY9YPLKgc8UKTosbkztpkbBiYeA9n1HRMeUxDPm0mQPZ30vB0B7nPj877yl90VMkDErupx0v94IcNKnSpLRUgTxUMin/t8ZO2xCW35QRFBG78feSBuxou4ecc298WnClztO83JZE9sY2c17D3oXYAD9SdsTRKVyhOXW1NyILr0XSUgR/742YDxo8ltJ0XBGUVhCNjKV4ItBkzQmmsT7fdnjmVIG9k9GTNn84LI8Zm9KcgPtXpegyt58dCmgmMkMOfaRRsuyTMLAJ/xQeH8g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:56:08.8364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fca33e3-f5b2-4587-5f36-08dee1a74659
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4998
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX40rUiiWZNXrB
 P7FguNareW8mHD1dBB7zxov0MEC+/njnaZEQZWYL3pPfiCYzvdyOl3Fe4LaLcxA53R9YpMoauci
 x4vNUhgHe6z5G76ZqOIIfjHSEL5rtQw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX42fwGUGkJrpe
 I4aEzDdFYUiQF1qT40Pv8Fqm9IcxzxGBnUeFUMV01tC6Ee/fRjqCJkulbf+zWcORMWHOlsjzAdq
 MkM0bh0S9/F+rAzBXgAg/l4r9yrtves5lJQEC9An+QJ/2Ba76Jt4D02uumZmZpTDseIfoqsGsxB
 y+usIPl6Ua66ceT4/tBuCuiwYRtI9p2KedovtkloOY+l3tjMxObkkeIEXJjjuHbJ4YS+Tt0NTq0
 +xITNlCIKkWdWjcG/RjRPn2rzIeUBQ/5y1TWWQ0B7TtckMcXkfHASC8wUUDq8+ZeKX6wP7FeL05
 5ekA3M25RiJOwpqQsRyJ6XBiT7MkCtclf0MySeoEEYGZBZGRwaOn2OjBBdgEEqf95o34B8lLZJX
 qCYvXwG2gSmDnYwNqEzhHDue2pXzsXmnvaY63JNe0Nl45PHS57WeMwSzkwKAzquvGpj8gWNxllc
 K0sV1SpkI6O+o3YWasg==
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a5631ed cx=c_pps
 a=Y+Of8T+w2jezINbWzwznEQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=0gXUvC4wBaJ-Mpoy5MMA:9
X-Proofpoint-ORIG-GUID: 4I7LyfMFPHVn90GxajnEUDGjo5fivU8b
X-Proofpoint-GUID: 4I7LyfMFPHVn90GxajnEUDGjo5fivU8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140135

From: Aarya Chaumal <a-chaumal@ti.com>

Add documentation for the TI K3 DDR PMU driver describing the
counter layout, supported events and perf tool usage examples.

Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
---
 Documentation/admin-guide/perf/index.rst  |  1 +
 Documentation/admin-guide/perf/k3-ddr.rst | 57 +++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/k3-ddr.rst

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index aa12708ddb965..752384d2d050f 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -31,3 +31,4 @@ Performance monitor support
    ampere_cspmu
    mrvl-pem-pmu
    fujitsu_uncore_pmu
+   k3-ddr
diff --git a/Documentation/admin-guide/perf/k3-ddr.rst b/Documentation/admin-guide/perf/k3-ddr.rst
new file mode 100644
index 0000000000000..3788bd41d15ff
--- /dev/null
+++ b/Documentation/admin-guide/perf/k3-ddr.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================================
+Texas Instruments K3 DDR Performance Monitoring Unit (PMU)
+==========================================================
+
+TI K3 SoCs contain DDR performance counters inside the MSMC2DDR bridge within
+the DDR subsystem (SSCFG region). The PMU provides four programmable counters,
+each tracking one event type simultaneously.
+
+Counter Select Register (Base + 0x100):
+
+  - Bits [5:0]   - Event select for counter 0
+  - Bits [13:8]  - Event select for counter 1
+  - Bits [21:16] - Event select for counter 2
+  - Bits [29:24] - Event select for counter 3
+
+Writing the event ID for a given counter causes it to begin counting. Counter
+values are read as 32-bit unsigned integers; the driver accumulates overflow
+using an hrtimer set to 1-second period.
+
+The ``format`` directory describes format of the config (event ID) field of the
+``perf_event_attr`` structure:
+``/sys/bus/event_source/devices/k3_ddr0/format/``.
+
+The ``events`` directory lists the hardware events that can be used with the
+perf tool: ``/sys/bus/event_source/devices/k3_ddr0/events/``.
+
+Supported SoCs
+==============
+
+* J721E
+* J721S2 (dual DDR channels: k3_ddr0, k3_ddr1)
+* J784S4 (four DDR channels: k3_ddr0 - k3_ddr3)
+* J7200
+* AM62
+* AM62A
+* AM62P
+* AM64
+
+Examples
+========
+
+To track read and write commands during a test, run:
+
+.. code-block:: bash
+
+   perf stat -a -e k3_ddr0/read/,k3_ddr0/write/ bw_mem -N 30 8M rd
+
+To monitor memory bandwidth (metric name varies by SoC, e.g. for J7 family):
+
+.. code-block:: bash
+
+    perf stat -a \
+     -M k3_ddr_j7.read_bandwidth_mbytes_sec,k3_ddr_j7.write_bandwidth_mbytes_sec \
+     -I 1000
+
-- 
2.34.1


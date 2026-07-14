Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486693B42E9
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033841; cv=fail; b=d3YGo0gu/d0LljiAl+3/bz/6lDvpFg6UTwQWTApFN1vKZGCNXlvjJhApLphxTcSV+7n+rKY0MiagDcAE+8dNf3t9XbQDuNcGkjLZpz7dWnYwA6JbDUuRNppwGd9EG8+evO1hJsWkX0BCeGZiTO/7KWQ6RRHxPhj3wjx11HydE38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033841; c=relaxed/simple;
	bh=zTpy0AeaiEYauOLyNfYaGzwmKC66+i+dPOZZ0CrZuDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G560r49HpUaUS3JAzXoarJN7MCSZ1EKF58LMVlG7/YkfQSf55lk3IoS69SQLf6iUGi9BTHjYcBw7BDTwZFq050L/fo94FGuXGV1imPNxYunqavgfYGtWrdmMOyAAAwzsyd28+E5sMQhlKeJZgh/IiTwaKs+Z0yGeltdvWLCEe1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=UQ0LKR8x; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bjidKPAn; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="UQ0LKR8x";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bjidKPAn"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBhLKL2126925;
	Tue, 14 Jul 2026 07:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=jC7dzMY90ZRNW6ApqMEPaDoXhLzi5Py23oK0h8D6A
	DI=; b=UQ0LKR8xwKhE9bHR5rvOGT6Nhcoy8zhDOLPgtEa4w3hKnLBcoUGbXg6Je
	IIGdRCoX1fVh9BcjBNJQj0O3fE/jqLXm5/syaPRHcKAMXogbEmHekTnN6CKFg1D8
	Q8trDZqokGvF9w1BkIxHbh2aeL4PDCvPbkSF3IcviOj3VENJmPUDa+sE2n2LOwjI
	03vIAckhvU4k8P4qEWyzVZ96kjpCHomW/LFxnM9wyLKFUZFJNZKGIRGTryRGALyr
	XWUEpxa2rbAZy5vsyv+n7c4uUOsgj430YRp1HVsZ/7153ihgxNu/uEmHvpLSU678
	TxII2OTp8uRnt/1n+ESbJyvGL0Xxw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdmg30bvx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:57:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPEQeTzmZG2UtbctJRj4BVqrw8Rl4tvUxU5IfgBWenfrWAGj+2XdAn0WHmXRzc4kocsqYDGHUVWd4n+cyADDTpKH13kpRc+i4ynrcM5Y1MPVAKMOur+aMguiG5kzJY8wmqdfivT7tkdsb+fFCbNQjil01igGGwx0te4fkG39IYZu3vmvXdoMmyD5wzG7yDv8bV7Guv2SuuuYwuMm5PXGGP8rTbzjXb5ipN/Pp10O1iE01BNQmisxZRF2AFMHLnjmOesUd1tux88lfIgnbvEb7mm+UhliNhsxxyNi4VSrtCf71it1e4P8Y6XjWWHGSAmsXXb8LwF2yVYWKwoGEK4g6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC7dzMY90ZRNW6ApqMEPaDoXhLzi5Py23oK0h8D6ADI=;
 b=Bga7IP5jWrB/2S2HeSz1tejw6h9Nr7DnFGImKyYTFutZjEIDRZep+lemwD4CPX3q8/Fc89Lyd/7tk1mRnaCLWoJc8LeEZIMtL8MRGhWOOpSv/2pbRVWoCJqdMnPtGmgiDH+XR7gH6WKdCgDaFIVALql0KK2cc6R/0GiaClqnpBrahOpx47pgaoNx2OJSjqBqtQw/IA8AVl+xeIM6ET/6SArnLUwIKbU+IBslOXLHKiwul7owhIUe7jbvihcm+/JOIL1eeU+agvdk7mCczRz8ulDwlOUAL1VaaAcM+FMMtBvn0MtfbdaIGADeb89e8lVM7qmIyuHqeTUAEhn2UhoQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC7dzMY90ZRNW6ApqMEPaDoXhLzi5Py23oK0h8D6ADI=;
 b=bjidKPAnOToXwF2+8x4B0OJcSZHUavnY48zuuqCuvlfQVvAKelthRIkD+eOloXVyZSRsk4tlItG+ofxBUz+KTUK8g5Ig33C1UM7VKdZK24wr2n3xvYFhQPUtyuP9jihfI17pJwmQPrkcznwftnha79xWlSVMWSC9uQa+le0xswo=
Received: from PH7PR03CA0027.namprd03.prod.outlook.com (2603:10b6:510:339::14)
 by DM3PPF45F123D65.namprd10.prod.outlook.com (2603:10b6:f:fc00::c24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 14 Jul
 2026 12:57:02 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::48) by PH7PR03CA0027.outlook.office365.com
 (2603:10b6:510:339::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:56:57 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:54 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:54 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECuaH44165566;
	Tue, 14 Jul 2026 07:56:52 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 22/22] tools/perf: jevents: Add k3_ddr to JSON unit table
Date: Tue, 14 Jul 2026 18:26:35 +0530
Message-ID: <20260714125635.3304437-6-v-mannuru@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM3PPF45F123D65:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aac8f90-4859-42ff-7d31-08dee1a763a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	BKszTPlcCKROThW5zdOYqtoWwdT+FED6se7FRFXksWeeR8HiZvFYm1KbV/sM/Evawy+mct0SfGBQNuyLfcV21y98YXOYo0NfdN0SnGd9dlPCOy8T0DDFO67efHABgwQDbzHu2K1wGA/TIxmNAEKkcdHiPPB4VGmNFnEp0Vub7QH220x2EjItvKCfgqcfKSOnfzbCwASh7MOFi5MikB93/ElCrEcpvINnLkbM4Ds4hKXEBvQizU99/9pyLZz8F1PFRIiykdu2+AgRukgn9jv2DIsK0wzyK770SzDw8MKHS+wDwW8eLEDbTqhGtDEvDNj9xFSXfARVTaPshxSfQeYtRqfUeEcaZ1fBqCD+o2y6frgG9P7VD60SQy4TILfFZUpkR8THCQDVC4CaVUEgoIyx+kwXpn/KoqsvuQExEaNViW7dkQozOdKksPOMEBdpBGFXzz8C5n9S8dIFaRTPK7UeexDm4b1n5wPgIUso0DMVya5DiOTs4e2a9W0TqKtje48azu0ddIZhmCt9+CckqufX5v6dJYiYKNvdC5654tNRwr3km6vmg4NaTuIu/fAfLui8LBEZN7G1AgGDHGUOc0/tsJBWDmWQv0JhhiwbW96Sw7JfUu0gl9YuG2eR7abAbBF+OKR+/obaWt29xK4vm9Fo2+nXPTwKoh8mFBAnXglICDFjTiwscGCVypLgvx9jJPV3pBfi/PRO80NP2rU3xJGyWA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z9Cwc/jUpS/aN23agjUkc0W1O5Cjgw0h/075Rv8kz7oXwFwIugjenLwAVarortUh1/oFx5gJy6UfjAuyPpKTNKyEd2sZxEa6XnShBxXbdJs3dxP1aJmJum64ydwI54A4hA9LVE5VQIsm9QGKkJ1+PaZpkUUpWp9Jb79KdlatFYzVWHqMtmJDNU8Xknunh2TaBA+XyVBpBLpmfnSk95WG2JrFwaPBwgWpY0KK3/GCO/iIZ29uc+aAwv43l8aJ1g8HfMfOp/zTTecy/hwVSr1epQFk8y5uzjkoJfMIIO4bZxmlEtAu0z3KBrP5r+m+CYsJcuRTokj9yrJPVmnuDDwWy7G6lCOhCwEWfDeE1DAvNIq+I3vCf3XKfE5EwZ9In2At2rqaNsJr89Xpen3KI4yKXvXFwnlc0g290NejEVIsOb1+XAcZWRuP0FNzWLy5IS6T
X-Exchange-RoutingPolicyChecked:
	E2GetggHfrM2mUuBHA+BRIEyiIcmepLBBzyRO16SBITMT09u14E7oHLij9eCRlMWD4HjgMD6MPj3SWP5vUl7NDixLWQwtELGuThppCHfLexMvQcN20LxQKK8+DCTK6Z6sYBnhe2X86oR/wZfp2xLGXjZZyj8dDejOxCD6HfuPYXz4Batq0ZzMByObUpuOl9e/X6nZ+pRGoYrT/sD7Iu6yanYmfj1PkPB538Zuw+/aKHVwSJngN/H/V7iewYxciYno5kU4EC9jMta/tQY2chbOnd26UzVtUoneyn38PwONvxXmMjxH6J/1FDyoqErMu5+jCYHkD9XGQYMEp+0AWgCkQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:56:57.9813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aac8f90-4859-42ff-7d31-08dee1a763a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF45F123D65
X-Proofpoint-GUID: R8N7WhvSmEvBQegLgUyRq_1SyQH0BhfU
X-Proofpoint-ORIG-GUID: R8N7WhvSmEvBQegLgUyRq_1SyQH0BhfU
X-Authority-Analysis: v=2.4 cv=EMg2FVZC c=1 sm=1 tr=0 ts=6a563223 cx=c_pps
 a=P3qATxxxYOxA1bnNUqDMzg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=orehhayMgpoFKCzscBIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX4OaIbxBIY39Z
 7y9KplPSI1lxKLZyurTQiLpYQv5fjgkMyOPapI7pKDi525n+wzxRhvUcBuRiZ9GJ9+q3xK7sUHp
 hrkfL3kK9xQfN8BEatWE8oAjDqEYwbQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfXwNosiov8dRDk
 HFVuF6rLr4jHb7R2eLUiiguf2ys8umiUmB8rL4IQdm2PuBRSXDZCVoN6U21WrWa9N3Z490/1ZSj
 0jK1x6n4LiaafzKTao09Mzs9XF3nTBW6lV93XogArvSscd4cHRvuPYWu2875MKO/eW87bgXzGXD
 21NEdPQUSzhNWZIlXLhoIvmd30QntCd3Uc4rfx5hnJsLI/iXATzmIkmnVY92JRysfAvfYu5ngmS
 pKOMawoJMOaa2ZVXSO/Cznl2WSCHxepOToMlP6G9FZj8YOLJmz8CQ2CMMTL0tSS9WNr6f7lXF5p
 ezTQmgBQEqMBIR5TXOYbhab6ptNwia7HFEK49aQjZarrJ6j5xEqeiUk/vBoL+RRN+uUm8OJOugp
 UBcfs87iDg8ROx0ms+xwWdeUy36OpOL/NQKfmQXelbolhX+TRrH9hFhhkBdQShADmQpYYnN9UMu
 tbM/tBzgVw3CfB4HzkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140135

From: Aarya Chaumal <a-chaumal@ti.com>

Register k3_ddr as a known PMU unit in the jevents tool so
that the JSON event tables for TI K3 DDR controllers are picked
up correctly during the perf build.

Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
---
 tools/perf/pmu-events/jevents.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 376dc2d241621..274461e55c757 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -291,6 +291,7 @@ class JsonEvent:
           'hisi_sccl,l3c': 'hisi_sccl,l3c',
           'imx8_ddr': 'imx8_ddr',
           'imx9_ddr': 'imx9_ddr',
+          'k3_ddr': 'k3_ddr',
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
           'UMCPMC': 'amd_umc',
-- 
2.34.1


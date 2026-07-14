Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2C342CBA;
	Tue, 14 Jul 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033754; cv=fail; b=ZYqJ5BxelktaiD2KYOIvOIQ+rL8ICiRPSdp2fob3awLcMHJTDhg3+Y9/Uw6g6KpN9kAaoUFDP9VNnwkYnd73UxtrPdU3mXo2E22iipo+bANk904RFaXdbu8hAAlkOKE2dh9SMx+7TJdwtxDz3GC7LBxTzDDc/2XfFNB4mu2S0jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033754; c=relaxed/simple;
	bh=JsxNTl60JMeoIOc9iHZKkOg3u4W/a7MISX7PfY8Xb/M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MOvQNHJxSMtw8uqFEnTQZ5fr5ywVvOO5HYOaBN27V4v8LdCnMemLs7gOjMwH90VFW4QvtQSzZwXoXT6Sei3lT8BJZTL1bktq1MMKSjHngiQDN99MfkxwbIQ1obzGCmlbwnl2micLE1H4fbjo1xmTtLWvN8/qrVmtetpQtblyxLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NqRzZggS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qVwSxSXM; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NqRzZggS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qVwSxSXM"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBQAM22106440;
	Tue, 14 Jul 2026 07:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=WxopXo6ytlzxA
	9QMkBw+cDiCNVKGhV3mGExBAB2p+pQ=; b=NqRzZggSF7TFw/dQzhUFBj6IiSCQ9
	tZyk+Y3CUSMRS1toYHyXlluHezhiU+5XPOglutq25AmEcDCFMtEygOwEoPb7kEcT
	IdbA2oM2pmtifYMagyka+IZfd1PZUP96K5OHe+1CLe16lwkSx8kkNrwCFxeOVXXr
	SeRaK5DUeaXESpYcByKvjiu3qiScaVXa+kvODxGyeqLLtEvkiqJsyuoMEbuFVLmX
	Znj+rY6nLu4uwpthT27OoTt6DcDeaSZi19Nneb9YsPal4YrJ/fdpC81EIZw5MAv/
	YbLapQELwHLoAiAYRclAn+aPxgP05x+yVgNBGKN6ZXfi1A2dVoAZtMVgA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdm2tgdx6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:55:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnG7O2ArLaskbHLzo49JwOk9k+OFGwRdZ9+B5y6nRSu8VcPUmsxTlzhdKilxpzfSv4ph07hw8hEgI77Ipo44AWhIpDoEav3Z0C1F6Sc8kaiyVRjNwf/2ImoJ9bildNmhlBmujWmEdYzre331akTWAtRBFRR7NeK1YMqkrwX2bcDCVt5OEZjaSGUgzKk3VSi3j9RRuJOoAPihCgajf5rNqPZZC4R7CoElhqYxSLji+luqctdSkamtNL9bT4hw+qj6gvGLHCVfVAd3JE9f0aXZNkmz5Dtc1ZVGu2A2SJoKGrgqEMLGk6J/vrz6HAajy0jdvmS5QuFkgHhhs6BkyeDgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxopXo6ytlzxA9QMkBw+cDiCNVKGhV3mGExBAB2p+pQ=;
 b=JNeEveCkq0JZCvTDJec2bGF2veeSdS4SqGq6rqt+/FHripR5jNvDo6847Xk/so//3y2t45Wrn3N5um3IVx4Yazpg3ljB5qDpBwD2/1oucgptkgjnsaURKWXWHyv6YMi0VIiXoyQL6nCotodAaQlRD8xX+nZlrEELw+ABf1Ekcq34aZE81v5pPlCeTM5bE7gYsd5ISkVjmaKvHm3dGrvXaNRmaXq34z1o/y+ZEyC55MD6A8J5+sH5UOGIUJhhjHgZXwPHMpu3IhyP6rdAKThleC4j9uY252MstUeABCjN2Y8tLbbqbMWIAcZoLCkJTx2lt4+XcifcMa6lK7Sm0T+dLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxopXo6ytlzxA9QMkBw+cDiCNVKGhV3mGExBAB2p+pQ=;
 b=qVwSxSXMGBk4RRGWKmjQ3TZnW6E5DCzNOBbBWQu2cAjyfaropGbQrcCfxLnnVK6f2PfXayLgPWyTcn6+Aibb/wwZA1/tnGtqVwd14MPm6tfTeYal5T2s2qVGvZ8UAb3O/1LR9Rg2KwrdpmAdX8o13sF6cy8dZs3VzQvFMUAsBbU=
Received: from DS3P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::15) by
 SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 12:55:43 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:8:45e:cafe::5d) by DS3P221CA0005.outlook.office365.com
 (2603:10b6:8:45e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:55:40 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:55:37 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:55:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:55:37 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECtXOe4164177;
	Tue, 14 Jul 2026 07:55:34 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <mfd@lists.linux.dev>,
        <n-francis@ti.com>, <s-k6@ti.com>, <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 00/22] Add TI K3 DDR subsystem drivers and DT bindings
Date: Tue, 14 Jul 2026 18:25:32 +0530
Message-ID: <20260714125532.3304178-1-v-mannuru@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|SJ0PR10MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: a8987147-5a79-4102-33ec-08dee1a735ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|30052699003|82310400026|1800799024|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	v0b2x6GtJ+0amNiQOPeRQyv3HAhJqZ4zkusDSPr9xICrzymaQ2DYG0t3gUMYl1AannSx3MosAdOgSMpUan5J9pFsBmeFUXtVNrKrJyxu/DT/ON0OfYnTRxFIRi4KGB/aOXWZpDCX3+Lyvh3FsI/Ov/ez6Zjod6jU+Gsa8dVWu1JDLaUI8E4nBlIksdnuGMttXFJnb1LXa739dPc/m645Aa6bAXNZ5IV7TUPOh2qWTnWT/vMxZM7UfaFHhBwh20WM0R9pbRE3zagy6fDiUnVD2iW0xM2qqAKM3xPmm2ROjBO4P0tWmGH/pT8uxQm9waVQftDu+3Z8yOtcEuJFrLLr3cMBi2tHTmjnpfy8iy05z2Tdc9RSW5aWR2N5wgmfLF2JDC4wiDGuNRi4zyBKUTXVfoe4imjvkvU4BxVG62kmArP+0MMllhokBVtpm/FgQGtrbdSM6AlRm0mVyClYZkD2AnmR5/RELmrvXrmguWVdcTBpgVat2k40u8XpnMAFgXdT/v5CWuq7zYsPm27mq6A5iL6h+gXtwZ6RiVEDj4/jiP8JvH4x0YdU1u/yfIifxXbfGiYFh6pa/x9x2hZSwF+my1wy6zotp53bncocYa3IX9a+C2NBuMr4pmGwsi/lEGIqBNRTypKu4SXAg5ugrnotW9SKtbSNNtKOEc8KOjgJinGfBQ4sM9Ybhem1xX8t2qKYK1ZwrtvI6RtDyN8zS8beqA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(30052699003)(82310400026)(1800799024)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ekFL1ivsXIbybdPmGn3tHC6VIt/tBZDNfUrxL5cjd1DlFW8H5xeGHlF31nAxShU5rT9yFE4XTiBkCzhYnd2AKM4IZhvFYYFvyyhZflAjitxo2vFBJEPuZXZYopYXUmm+GqKdBn7VYG9t2w2iHKx8ewxYWR2gr4DH7Gh418FXFOp/7kSfOcgrVNSI2fcYBN+5fXrbMkWTF/9b7lqZEY0xwFYcR8sSfZHK5yClGPAfRPxneUvH4Sqyi/tF2B7/ZQfL3LyLqM3yWS+JEr/uKWQqGr8K6Cy4cjigOwRu9s6E/iuk9F4HBZAkKZyNpW1xJSNP6OzTNRivI+Mh+xO/VSQQl+fUyL/o7rPgzZjyemlUVIuVJ5gnd4Kd/SlIYd/V8cA3ubFVZFrXkcGjVbSskpfDxOkB/Ews4T+zUL08VEzlTGCzx/ITVhVVeDm4UEMBxCJh
X-Exchange-RoutingPolicyChecked:
	nyd2GAYA53hKDiN3+2nybrXZwSNsv8ABNMlSyyUMSffjRJQKIJxjIfuIdJdkMrU9k3LKvelNJ2O4gVonSq1VUGYoDSMn677raY41unQrtlk9QzITV2qo40OCEY0e65VyXMnGQ3L88VIpNZtsSzJEQKIyFvdOpp1KbnqP4lwBvgSV/27lUmc8dS/me7IKuWOokLcthFtkpioAcy2Pur6L51x4rGGvjCw5MWQuy1Rm5PUUpvOJhZFT6vJy3IrNAljUXUxAISiRKJznyYvre0DK24xqHQrD8aT69M/fGHtt/dGu43g2P8+9kBT1aUMZcd2aKxLsISvDcZddaxjQtP1syQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:55:40.8597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8987147-5a79-4102-33ec-08dee1a735ad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX0arkB8GOTQCZ
 5ouK6QL1ZT1SIluXG7LBhB+AYOxDwoYOHpGFH9nprvGW133L6DUwRYp7CFrqQsWYsCavNgfc0yS
 7SJfe9evimhTNzPcrds/lgY0+cZqP/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX4pMiUj66S49S
 Kw9Ue3Bi+BVs7JengcgncJL517HtdOUHMzwoBlpp+M6hPF6xeW0uXNk8B0m1JsUUfJHy4LA8jh8
 81EhAMzkE0WSQL16I+RTh9vbbH5sq1i42oqg7va70LkEMm1I8bD2E90sZGKPgL9uknGWGlTm727
 1PmyTiHJyVGMuUx028xgVbnU8ndb9oTt6/TzfvyDBB9Tx/GGWpRfTf8wB+FSLBzpZdvT2DT7V1s
 zs/9c1uxRaPy4GcKM7K2FhU0UAOvKMhBysOl1PHaamqOaLuY9wjcEZ2fWpTEiVauqfKuDbvNAQd
 JeM4SALOFroUd4IT01artLx0irpwMqZx9lOHOHZldBl1sEmJJ8nIoQgzuaDVXRMQr/ki8fZekd9
 Qzvijzk2hC9RfuWwx7XqLECZFNek3CfzStHZdGKFg0XZwqXG8ocvFw7m3c4NPi0K2DQBnJHiYwU
 r42Qp2x/M8wlnIhM7cQ==
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a5631d3 cx=c_pps
 a=QwCZ9Ep3279coiJ7nb8JBQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=zvrWtlHHRBkuNqoByXUA:9
X-Proofpoint-ORIG-GUID: OG_MDU_zDN63KVcClwp6_RwD9GgQrgsC
X-Proofpoint-GUID: OG_MDU_zDN63KVcClwp6_RwD9GgQrgsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140135

This series adds support for the DDR subsystem (DDRSS) on TI K3 SoCs,
which wraps a Cadence DDR controller. It introduces three drivers and
the associated DT bindings and DTS nodes.

The Cadence DDR controller (cdns,k3-ddr) handles the actual DRAM
interface. The TI DDRSS wrapper provides interrupt routing, subsystem
configuration registers (SSCFG), and performance counters. It is
modelled as an MFD device that instantiates two child drivers:

  ti-ddrss-mr4: Reads the LPDDR4 MR4 temperature code on every TUF
  interrupt and left-shifts the firmware-initialized baseline tRAS_MAX
  and tREF values across all three FSPs. The baseline is the 0.25x
  worst-case rate set at boot; cooler temperatures relax refresh to save
  power, hotter temperatures restore the baseline to comply with JEDEC
  LPDDR4 requirements.

  ti-k3-ddr-pmu: Exposes 34 hardware performance counters per DDR
  channel via the perf subsystem. JSON event and metric definitions are
  provided for perf stat named-event support.

SoC coverage: J721E, J7200, J721S2, J784S4, AM62x, AM62Ax, AM62Px,
AM64x.

Tested on J721S2 EVM (kernel 7.2.0-rc2-next-20260708):

  root@j721s2-evm:~# cat /sys/bus/platform/devices/ti-ddrss-mr4.*/refresh_status
  2x refresh interval
  2x refresh interval

  root@j721s2-evm:~# perf stat -a \
      -M k3_ddr_j7.read_bandwidth_mbytes_sec \
      -M k3_ddr_j7.write_bandwidth_mbytes_sec \
      stress-ng --vm 2 --vm-bytes 256M -t 10s

     143668213  k3_ddr0/k3_ddr.write/   #  912.8 MB/s  k3_ddr_j7.write_bandwidth_mbytes_sec
     142802125  k3_ddr1/k3_ddr.write/   #  907.3 MB/s  k3_ddr_j7.write_bandwidth_mbytes_sec
     142443551  k3_ddr0/k3_ddr.read/    #  905.1 MB/s  k3_ddr_j7.read_bandwidth_mbytes_sec
     141198258  k3_ddr1/k3_ddr.read/    #  897.1 MB/s  k3_ddr_j7.read_bandwidth_mbytes_sec

Aarya Chaumal (8):
  dt-bindings: perf: ti,k3-ddr-pmu: Add K3 DDR PMU binding
  perf: ti_k3_ddr: Add TI K3 DDR performance monitor driver
  docs: perf: Add TI K3 DDR PMU documentation
  perf/events: arm64: ti: Add AM62 DDR performance events
  perf/events: arm64: ti: Add AM62A DDR performance events
  perf/events: arm64: ti: Add AM62P DDR performance events
  perf/events: arm64: ti: Add AM64 DDR performance events
  tools/perf: jevents: Add k3_ddr to JSON unit table

Gandhar Deshpande (1):
  arm64: dts: ti: k3-j7200: Add DDR node for j7200

MANNURU VENKATESWARLU (5):
  dt-bindings: memory: cdns,k3-ddr: Add Cadence K3 DDR controller
    binding
  dt-bindings: memory: ti,j7-ddrss: Add TI K3 DDRSS wrapper binding
  dt-bindings: memory: ti,j721s2-msmc: Add TI K3 MSMC binding
  mfd: ti-ddrss: Add TI K3 DDR subsystem MFD core driver
  perf/events: arm64: ti: Add J7 DDR performance events

Neha Malcom Francis (4):
  arm64: dts: ti: k3-j721e: Add DDR and controller node
  arm64: dts: ti: k3-j721s2-main: Add DDR nodes for J721S2
  arm64: dts: ti: k3-j784s4-main: Add DDR nodes for J784S4
  arm64: dts: ti: k3-am64: Add DDR and controller node

Santhosh Kumar K (4):
  memory: ti-ddrss: Add MR4 temperature-driven refresh rate driver
  arm64: dts: ti: k3-am62: Add DDR and controller node
  arm64: dts: ti: k3-am62a: Add DDR and controller node
  arm64: dts: ti: k3-am62p: Add DDR and controller node

 Documentation/admin-guide/perf/index.rst      |   1 +
 Documentation/admin-guide/perf/k3-ddr.rst     |  57 ++
 .../memory-controllers/ti/cdns,k3-ddr.yaml    |  81 +++
 .../memory-controllers/ti/ti,j7-ddrss.yaml    | 186 ++++++
 .../memory-controllers/ti/ti,j721s2-msmc.yaml | 124 ++++
 .../bindings/perf/ti,k3-ddr-pmu.yaml          |  40 ++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  25 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  33 ++
 .../dts/ti/k3-am62p-j722s-common-main.dtsi    |  25 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  33 ++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  32 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  32 ++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  84 +++
 .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  |  83 +++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    |  73 +++
 drivers/memory/Kconfig                        |  19 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/ti-ddrss-mr4.c                 | 322 +++++++++++
 drivers/mfd/Kconfig                           |  13 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/ti-ddrss-core.c                   | 280 +++++++++
 drivers/perf/Kconfig                          |  11 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/ti_k3_ddr_perf.c                 | 532 ++++++++++++++++++
 include/linux/mfd/ti-ddrss.h                  |  53 ++
 .../arch/arm64/ti/am62/sys/ddrc.json          | 240 ++++++++
 .../arch/arm64/ti/am62/sys/metrics.json       |  34 ++
 .../arch/arm64/ti/am62a/sys/ddrc.json         | 240 ++++++++
 .../arch/arm64/ti/am62a/sys/metrics.json      |  34 ++
 .../arch/arm64/ti/am62p/sys/ddrc.json         | 240 ++++++++
 .../arch/arm64/ti/am62p/sys/metrics.json      |  34 ++
 .../arch/arm64/ti/am64/sys/ddrc.json          | 240 ++++++++
 .../arch/arm64/ti/am64/sys/metrics.json       |  34 ++
 .../pmu-events/arch/arm64/ti/j7/sys/ddrc.json | 240 ++++++++
 .../arch/arm64/ti/j7/sys/metrics.json         |  34 ++
 tools/perf/pmu-events/jevents.py              |   1 +
 36 files changed, 3513 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/k3-ddr.rst
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/cdns,k3-ddr.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/ti,j7-ddrss.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/ti,j721s2-msmc.yaml
 create mode 100644 Documentation/devicetree/bindings/perf/ti,k3-ddr-pmu.yaml
 create mode 100644 drivers/memory/ti-ddrss-mr4.c
 create mode 100644 drivers/mfd/ti-ddrss-core.c
 create mode 100644 drivers/perf/ti_k3_ddr_perf.c
 create mode 100644 include/linux/mfd/ti-ddrss.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62a/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62a/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62p/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am62p/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am64/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/am64/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/j7/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ti/j7/sys/metrics.json

-- 
2.34.1


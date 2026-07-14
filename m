Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B554B44DB64;
	Tue, 14 Jul 2026 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033797; cv=fail; b=S3Ep/DTdhRdtEsDXFEn7CfWpR/UBxUZNFVB/b/RQZ/uFrW+P2JPKZLtbsSIHW0jEIye0cVN5tQnwlWQremz6FiLJcLJfYCi2INj8iYYSA4fLFhNILwHe9nxP7TR52yFk6BqFYJgKbnWfrN+bKpzw1gxfphZMnK3b/gCJi2Fk3hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033797; c=relaxed/simple;
	bh=cW4hjcHFubyjmLX1c+4ZADzDGz5/6hx1Ao4xYaKUiGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IgyHZq7PCN0bmR19Lln2gbJLHYwC9GcM/LxrcFZdoVAL/MDJRu8BYNo5wbfvPRyPBLkAttQyqMR74meYdcMCGFbxjY160j+bt11n3QRb+Pw1qN2Th2eQH3SR6WQI5PXz84xzM+I+cZ/mAE1fCtgAKTvwc8JCSfU78Q4RZd9sCeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Ek+XIGeh; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JQRR4fhI; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Ek+XIGeh";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JQRR4fhI"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBQDtb2106470;
	Tue, 14 Jul 2026 07:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=Y0xUOiqLta9wY
	klQNmL7sMJ3R6Kw3BQtKh6PSv0SUmA=; b=Ek+XIGehTmcrntAqgOHRhVFrSyFtQ
	vCAlfqqp85ik3JRYkCIbNjxfgivPw+abP0kJxvVZUz4xP9aZC2R9T7HKwsht7qQ8
	VXEAzMo7nMPfXYL0fSKqtYcbci8ze9zCCD2MIvJmA8aZywQxJIK6cdqzywtD0FEF
	Q8LsmguoaERgmvzaWQw8c/zp/bT1mKrrKWnjzsPyZRB4Ci2LdJfNkJ9JW7eiKqBX
	0wwGKqQ6jMBbpl+q5b4fBIwYMkEuFnc2Pul6PD7JogNOS+nVxHaTzhsvnFRvPIzp
	A5ixobMZntigM4Y4dP+Uk+8fATz+8LxApiYp4Wamix2nYuxruZ9kLF3cg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fdm2tge1a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:56:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrSDwhvmCrCgL4El7CRPP0kB6HzuUixS/2dDdWBBqOqq8woo75fFYg9Bvbh+gpvHlJ/VtHm2NmEQHReePt3QWO+ddYlosni9k3sOQHPqXkfXtZCRWBc+dxj1Zm/uMA4+G7QxdxomRcapu386bv7hjg4ms5h/M4sTLXWI+7Nh3yK90MoweI/zZdaoxj4IJXfoPSNbgS1OgR5EBK/DXv7XU0ka6ubzNODEz9Rk9KaItxOPDWz4Ztgttz3dYDSkTZIBuH4ktZcfIBQoIw69evdvD12A9YUbYPzWI+ooI1Tn/FHcGB4iiN7O5nPP4SUAo2OQM3PJB0ENMFUZl2rXRUgK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0xUOiqLta9wYklQNmL7sMJ3R6Kw3BQtKh6PSv0SUmA=;
 b=RWG4OYcP+EmLl/ae7tDRxze8376YqGKq7eni2W0KWyMXXsBPnKkmzxn/cVXqsVBtGWgEhhY5FU0k5fpbaesjkmlo5m41HC2wgn80YRczh08FfbVHeXZms8w7uByDFT+y5UZg1TqkAvVAbxoNw7cBrhYg91Rg1YDZBZ6hzlc+L8hrt9p79AaOzGtmcnDrp/uIJRmhNPEqPF9J5S4lEezhsbLkul49HJFSL/RmvKrrFDJBoz4xrESyUXzg5bKryRS9DrQH/2L1lhJUfdT4yrLlFbMWHP5zfZIzJ1yZtjViSlBvMW9sZlSdrTFcONg+zVAmLGlwfKmhXRwaUIxk/z/Cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0xUOiqLta9wYklQNmL7sMJ3R6Kw3BQtKh6PSv0SUmA=;
 b=JQRR4fhIZm0NyZG7XVdtSi0tRKjEpBRvimlLZWcZoJ/rulz5WeyyhE4fp2Rysp1IIVbJ+1eQFcsxtOUqvVCpFlmxflh2UaThM40YOP92vFnyge799JYDXIqlnlgCIZNPO0zjadqsFMBQVOcAEZgcZfgOlldYggcOhDmKkyp1/Z4=
Received: from PH8PR05CA0009.namprd05.prod.outlook.com (2603:10b6:510:2cc::26)
 by DS7PR10MB5200.namprd10.prod.outlook.com (2603:10b6:5:3a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 12:56:21 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::54) by PH8PR05CA0009.outlook.office365.com
 (2603:10b6:510:2cc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 12:56:18 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:06 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:56:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:56:04 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECu10t4164761;
	Tue, 14 Jul 2026 07:56:01 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <n-francis@ti.com>, <s-k6@ti.com>,
        <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 07/22] perf: ti_k3_ddr: Add TI K3 DDR performance monitor driver
Date: Tue, 14 Jul 2026 18:25:59 +0530
Message-ID: <20260714125600.3304330-1-v-mannuru@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS7PR10MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f6ef8e-fd5c-4736-1d71-08dee1a74c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|13003099007|56012099006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	Io6m24kRe4qBev2OzI/MZi+TvBTjuR7gv7qDi6u8Ox3CvevUA3ZjILG5UwwlTECWNZ1Z8pmmQ6nm937Q7QA1kBYKpR6ZPR5CqITgOpxg0AFdGWRC7U9vE70qS3BjxNaUcApx4v2zkxRrRhkx+knJblBKps6hMgIpkt2orrc309AoMTCQ29WqH0i4vRFzqldFgQNFNiFq7Ou3MBopk/gKVl3MPC9rW7eZ0YHOF6eqmgwJW7yxuZ9aouF73zITLstmg8yJBEV6YwcrykT2Fl9l7t/TZOxzk0mgIyjSalbvGFl07ApS0JSbeTmIRHxdTtGv+Bu34OQbR9YC6L3C9gSzpVN5MX/spPaObKOFV34h/TuOw1DdTpaZI8wA+eaitSulEaXxe9MsIK/cadSli+x9d9vltEfElX8SyHS2M5+Ea/7mhO/1if7wS1BQcBN9+JjSzOSv8BXbOzxqljbjtk/l5F4dC+KfVjwyn3GA9syh/AZ4CfqLveCafMOW7cXhgYCRRknsLEAqKrrpcX+9KTphlMM6H4Gznla6GWRaL1SSNl946wWny/yREDKWy4YGVPKPx0xmvS4anjmLRfNmuhUe339g9Mi2Fi+IuCwc3wFEaC/KnbjtW5BaTaAZos/ehdoCZluZ7z81B+hKQfb42EMO1A==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(13003099007)(56012099006)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mrsOnXC4YVLov02WO+KsDlV/pYzGt2Dnx6o9HTXt9BqvpCB9sLumuDc0LeyUCxznDPxUPU1ZIDKLN0gMdusVjpm0zHbDrFXvYSbRhb+kcBE9whE+mAHXDdLYT5LAF6couUTelCl6E+UBOy9FiuVbApjTcqAT0a0ZL1+ou4+b6TzSb8SHF/Ppv5VPZsdrirslY/iKheSb+/WO63JfmDzaPqxB3Bz9q1W6++ZCMvrTr6fQQVJTFswA25s24QO1KQruOQv2tDMVb/i7v8YWW1zS+Om3FQSgJgjUQqDa0MwgMT/bKhcBaD+Jt2Te2XM29z1yoOrMGOPCMDneCKRG8OU47FOq5dakeK5WaokMF28K95C6hApxGKE7ugYBFr4c7tKb9ZveF9w0/vQswFSHCGlVpJE4XKI61QuIIIsAfy3WZPE3R49fpDDI4s2WyWZAQAvn
X-Exchange-RoutingPolicyChecked:
	U5RMwRa7Vl0RJKG9C7mZcAUbmBiZYnIWLVickrEnV3mCOraeBuNrHoe3XLDQRVc0R82n3OW2yeaFVMNrmxb1Ge4gDBt53qsaT3nDRTWo+/5WgaMcAFwDiQ6TvtxKYTbmFHfW8Mi1vXgDNhA1jofXJgYmctfVXQRYM+pTs1DJ1kOh+hzToWZZStpltnzaqSE0bmv93CTJHFMHW19UbsRk4VGXGupQ/I1RyoI5A5jI7U3JVPN585EeWiBX4cGa07vY5Uw89sXTsDog6+urNx6tKoKPw1tnjermAJVqX1CoL6J/I0/0N9c3Fym2oT064DgbEg+hPQLcifCDO8uCW2tLbw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:56:18.8541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f6ef8e-fd5c-4736-1d71-08dee1a74c51
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfXzmbP+zbIeQC3
 /QEL/XpX5b9qEnN/Ub5psh9/Z5pV6QIpz1XxVzaSZzVyyqIOtS9I9afI22+BigLkCeaNC0oEvJN
 79yKFYEhYlyCmds8Rw2v2/KgWYaxF0g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX98LHNt6AuoKt
 XoYPNTjVL5z4KpWWV2vnaU06ykPwTjK3xzm2u8Z4fF1Rrj4jUBq4JVR+UalxWtc+CXoAsyozFOE
 i3rfKIvat7MA58NvQXCIZTr/0pvAcxGqQQJg1EqrgTBGsHaoB91ePntrkA4zKrZTPZctnuzErwq
 GhHi5ZmpzWcsgNTkLUK3/Bv0psNZJ6FikGSTXo/WmmYyD2LkHvwRnEg73yvBVHnLPL10NJvNBAL
 AlmfhPapTscte7dMXpO81HtCseJdDpPnPf57B2tQ/qxj+QJJcInjH2PcKOccCegrRA2xLm8ZiJc
 c0GdNrTrRqTbTBmav/BKt4IOeUklavj27EbZrTd7nclCsO2AurNo6BTZkUfkxH2mQenSUSlPTKi
 2YT7snLW96asCJqUAZw79KpfkcGIxvNj4gxXE1KYh/oFFbAUYT221UNmnVmWqGynZX1fGttlmjG
 F02vEySQe8b0DdG5Ojg==
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a5631fb cx=c_pps
 a=QQ0Rro+ZityDt3mHPSrFtQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=oC2elNMeS7aHqF0AyykA:9
X-Proofpoint-ORIG-GUID: DQzwq3-lSRbxtpop2kT_1riwrsKU8AbA
X-Proofpoint-GUID: DQzwq3-lSRbxtpop2kT_1riwrsKU8AbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140135

From: Aarya Chaumal <a-chaumal@ti.com>

Add a PMU driver for the DDR subsystem performance counters on TI K3
SoCs (J721E, J721S2, J7200, J784S4, AM62, AM62A, AM62P, AM64).

The Cadence DDR controller provides 4 hardware counters, each
programmable to count one of 36 events: read/write commands, activates,
refreshes, precharges, power-down/self-refresh cycles, bus turnarounds,
address collisions, and FIFO utilization cycles.

Each DDR controller registers as a separate PMU named k3_ddr<N> and
exposes an identifier sysfs attribute that jevents uses to select the
correct JSON event table for the SoC.

Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
---
 drivers/perf/Kconfig          |  11 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/ti_k3_ddr_perf.c | 532 ++++++++++++++++++++++++++++++++++
 3 files changed, 544 insertions(+)
 create mode 100644 drivers/perf/ti_k3_ddr_perf.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 245e7bb763b99..821fc6f81bef0 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -273,6 +273,17 @@ config ALIBABA_UNCORE_DRW_PMU
 
 source "drivers/perf/hisilicon/Kconfig"
 
+config TI_K3_DDR_PMU
+	tristate "Texas Instruments K3 DDR perf monitor"
+	depends on MFD_TI_DDRSS
+	help
+	  Say Y here to enable the DDR performance monitor on TI K3 SoCs.
+	  Exposes DDR read/write and other memory throughput events via perf.
+	  Supports J721E, J721S2, J7200, J784S4, AM62, AM62A, AM62P, AM64.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ti_k3_ddr_perf.
+
 config MARVELL_CN10K_DDR_PMU
 	tristate "Enable MARVELL CN10K DRAM Subsystem(DSS) PMU Support"
 	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a7..c11c0013cbfd9 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
 obj-$(CONFIG_MARVELL_PEM_PMU) += marvell_pem_pmu.o
+obj-$(CONFIG_TI_K3_DDR_PMU) += ti_k3_ddr_perf.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
diff --git a/drivers/perf/ti_k3_ddr_perf.c b/drivers/perf/ti_k3_ddr_perf.c
new file mode 100644
index 0000000000000..3be4e40adf46f
--- /dev/null
+++ b/drivers/perf/ti_k3_ddr_perf.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TI DDR pmu driver
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/device.h>
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/mfd/ti-ddrss.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#define NUM_COUNTERS		4
+#define TIMER_PERIOD		1000000000u
+#define to_k3_ddr_pmu(p)	container_of(p, struct k3_ddr_pmu, pmu)
+
+/* Maximum event config value from the hardware event table */
+#define K3_DDR_PMU_MAX_EVENT	0x23
+
+#define DDR_PERF_DEV_NAME	"k3_ddr"
+#define DDR_CPUHP_CB_NAME	DDR_PERF_DEV_NAME "_perf_pmu"
+
+static DEFINE_IDA(k3_ddr_ida);
+
+/**
+ * struct k3_ddr_pmu - a struct containing all information needed by pmu driver
+ * @pmu: pmu instance
+ * @cntrl_base: base address of the control register for the counters
+ * @counter_base: base address of the first counter
+ * @cpu: cpu to which pmu is attached to
+ * @dev: reference to the struct device
+ * @events: array of perf events registered by the driver
+ * @active_events: number of active perf events
+ * @cpuhp_state: cpu hotplug state
+ * @node: node for the cpu hotplug state
+ * @identifier: SoC identifier string for /sys/.../identifier
+ * @hrtimer: hrtimer for sampling events accurately
+ * @id: driver id
+ *
+ * PMU driver related information
+ */
+struct k3_ddr_pmu {
+	struct pmu pmu;
+	void __iomem *cntrl_base;
+	void __iomem *counter_base;
+	unsigned int cpu;
+	struct device *dev;
+	struct perf_event *events[NUM_COUNTERS];
+	unsigned int active_events;
+	enum cpuhp_state cpuhp_state;
+	struct hlist_node node;
+	const char *identifier;
+	struct hrtimer hrtimer;
+	int id;
+};
+
+static ssize_t k3_ddr_perf_identifier_show(struct device *dev,
+					   struct device_attribute *attr,
+					    char *page)
+{
+	struct k3_ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	if (!pmu || !pmu->identifier)
+		return 0;
+
+	return sysfs_emit(page, "%s\n", pmu->identifier);
+}
+
+static umode_t k3_ddr_perf_identifier_attr_visible(struct kobject *kobj,
+						   struct attribute *attr,
+						    int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct k3_ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	if (!pmu->identifier)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct device_attribute k3_ddr_perf_identifier_attr =
+	__ATTR(identifier, 0444, k3_ddr_perf_identifier_show, NULL);
+
+static struct attribute *k3_ddr_perf_identifier_attrs[] = {
+	&k3_ddr_perf_identifier_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group k3_ddr_perf_identifier_attr_group = {
+	.attrs = k3_ddr_perf_identifier_attrs,
+	.is_visible = k3_ddr_perf_identifier_attr_visible,
+};
+
+static ssize_t k3_ddr_perf_cpumask_show(struct device *dev,
+					struct device_attribute *attr,
+					 char *buf)
+{
+	struct k3_ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(pmu->cpu)));
+}
+
+static struct device_attribute k3_ddr_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, k3_ddr_perf_cpumask_show, NULL);
+
+static struct attribute *k3_ddr_perf_cpumask_attrs[] = {
+	&k3_ddr_perf_cpumask_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group k3_ddr_perf_cpumask_attr_group = {
+	.attrs = k3_ddr_perf_cpumask_attrs,
+};
+
+static ssize_t
+k3_ddr_pmu_event_show(struct device *dev, struct device_attribute *attr,
+		      char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define K3_DDR_PMU_EVENT_ATTR(_name, _id)		\
+	PMU_EVENT_ATTR_ID(_name, k3_ddr_pmu_event_show, _id)
+
+static struct attribute *k3_ddr_perf_events_attrs[] = {
+	K3_DDR_PMU_EVENT_ATTR(write, 0x00),
+	K3_DDR_PMU_EVENT_ATTR(read, 0x01),
+	K3_DDR_PMU_EVENT_ATTR(read_rmw, 0x02),
+	K3_DDR_PMU_EVENT_ATTR(activate, 0x03),
+	K3_DDR_PMU_EVENT_ATTR(precharge, 0x04),
+	K3_DDR_PMU_EVENT_ATTR(precharge_all, 0x05),
+	K3_DDR_PMU_EVENT_ATTR(mode_reg_read, 0x06),
+	K3_DDR_PMU_EVENT_ATTR(mode_reg_write, 0x07),
+	K3_DDR_PMU_EVENT_ATTR(per_bank_refresh, 0x08),
+	K3_DDR_PMU_EVENT_ATTR(auto_refresh, 0x09),
+	K3_DDR_PMU_EVENT_ATTR(zq_calib_long, 0x0a),
+	K3_DDR_PMU_EVENT_ATTR(zq_calib_short, 0x0b),
+	K3_DDR_PMU_EVENT_ATTR(bus_turn_around, 0x0c),
+	K3_DDR_PMU_EVENT_ATTR(write_write_collision, 0x0d),
+	K3_DDR_PMU_EVENT_ATTR(write_read_collision, 0x0e),
+	K3_DDR_PMU_EVENT_ATTR(read_write_collision, 0x0f),
+	K3_DDR_PMU_EVENT_ATTR(read_read_collision, 0x10),
+	K3_DDR_PMU_EVENT_ATTR(exit_power_down_self_refresh, 0x11),
+	K3_DDR_PMU_EVENT_ATTR(entry_power_down_self_refresh, 0x12),
+	K3_DDR_PMU_EVENT_ATTR(power_down_self_refresh_cycles, 0x13),
+	K3_DDR_PMU_EVENT_ATTR(exit_power_down, 0x14),
+	K3_DDR_PMU_EVENT_ATTR(entry_power_down, 0x15),
+	K3_DDR_PMU_EVENT_ATTR(power_down_cycles, 0x16),
+	K3_DDR_PMU_EVENT_ATTR(exit_self_refresh, 0x17),
+	K3_DDR_PMU_EVENT_ATTR(entry_self_refresh, 0x18),
+	K3_DDR_PMU_EVENT_ATTR(self_refresh_cycles, 0x19),
+	/* 0x1a and 0x1b are reserved in the hardware event table */
+	K3_DDR_PMU_EVENT_ATTR(command_queue_full_cycles, 0x1c),
+	K3_DDR_PMU_EVENT_ATTR(info_fifo_full_cycles, 0x1d),
+	K3_DDR_PMU_EVENT_ATTR(write_latency_fifo_full_cycles, 0x1e),
+	K3_DDR_PMU_EVENT_ATTR(port_command_fifo_full_cycles, 0x1f),
+	K3_DDR_PMU_EVENT_ATTR(write_response_fifo_full_cycles, 0x20),
+	K3_DDR_PMU_EVENT_ATTR(port_write_fifo_full_cycles, 0x21),
+	K3_DDR_PMU_EVENT_ATTR(core_read_fifo_full_cycles, 0x22),
+	K3_DDR_PMU_EVENT_ATTR(port_read_fifo_full_cycles, 0x23),
+	NULL,
+};
+
+static const struct attribute_group k3_ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = k3_ddr_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-5");
+
+static struct attribute *k3_ddr_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group k3_ddr_perf_format_attr_group = {
+	.name = "format",
+	.attrs = k3_ddr_perf_format_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&k3_ddr_perf_events_attr_group,
+	&k3_ddr_perf_format_attr_group,
+	&k3_ddr_perf_cpumask_attr_group,
+	&k3_ddr_perf_identifier_attr_group,
+	NULL,
+};
+
+static int k3_ddr_perf_alloc_counter(struct k3_ddr_pmu *pmu)
+{
+	for (int i = 0; i < NUM_COUNTERS; i++) {
+		if (!pmu->events[i]) {
+			pmu->active_events++;
+			return i;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static void k3_ddr_perf_free_counter(struct k3_ddr_pmu *pmu, int counter)
+{
+	pmu->active_events--;
+	pmu->events[counter] = NULL;
+}
+
+static u32 k3_ddr_perf_read_counter(struct k3_ddr_pmu *pmu, int counter)
+{
+	void __iomem *base = pmu->counter_base;
+
+	return readl_relaxed(base + counter * 4);
+}
+
+static int k3_ddr_perf_event_init(struct perf_event *event)
+{
+	struct k3_ddr_pmu *pmu = to_k3_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->attr.config > K3_DDR_PMU_MAX_EVENT)
+		return -EINVAL;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0)
+		return -EOPNOTSUPP;
+
+	if (event->group_leader->pmu != event->pmu &&
+	    !is_software_event(event->group_leader))
+		return -EINVAL;
+
+	event->cpu = pmu->cpu;
+	hwc->idx = -1;
+
+	return 0;
+}
+
+static void k3_ddr_perf_counter_enable(struct k3_ddr_pmu *pmu, int config,
+				       int counter, bool enable)
+{
+	u32 val;
+	u8 pos = counter * 8;
+
+	/*
+	 * Each CNT_SEL field is 6 bits wide with 2 reserved bits above it.
+	 * Bit layout: CNT1[5:0], rsvd[7:6], CNT2[13:8], rsvd[15:14], ...
+	 * There is no hardware enable/disable - writing config=0 counts writes.
+	 */
+	val = readl_relaxed(pmu->cntrl_base);
+	val &= ~(0x3FU << pos);
+	if (enable)
+		val |= ((u32)(config & 0x3F)) << pos;
+	writel_relaxed(val, pmu->cntrl_base);
+}
+
+static void k3_ddr_perf_event_update(struct perf_event *event)
+{
+	struct k3_ddr_pmu *pmu = to_k3_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 new_raw_count, old_raw_count, actual_count;
+	int counter = hwc->idx;
+
+	do {
+		old_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = k3_ddr_perf_read_counter(pmu, counter);
+	} while (local64_cmpxchg(&hwc->prev_count, old_raw_count,
+				 new_raw_count) != old_raw_count);
+
+	actual_count = (new_raw_count - old_raw_count) & 0xffffffff;
+
+	local64_add(actual_count, &event->count);
+}
+
+static void k3_ddr_perf_event_start(struct perf_event *event, int flags)
+{
+	struct k3_ddr_pmu *pmu = to_k3_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+	u64 initial_raw_count;
+
+	k3_ddr_perf_counter_enable(pmu, event->attr.config, counter, true);
+	initial_raw_count = k3_ddr_perf_read_counter(pmu, counter);
+	local64_set(&hwc->prev_count, initial_raw_count);
+
+	/* Only arm the timer when the first event becomes active */
+	if (pmu->active_events == 1)
+		hrtimer_start(&pmu->hrtimer, ns_to_ktime(TIMER_PERIOD),
+			      HRTIMER_MODE_REL_PINNED);
+
+	hwc->state = 0;
+}
+
+static int k3_ddr_perf_event_add(struct perf_event *event, int flags)
+{
+	struct k3_ddr_pmu *pmu = to_k3_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter;
+
+	counter = k3_ddr_perf_alloc_counter(pmu);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
+
+	pmu->events[counter] = event;
+
+	hwc->idx = counter;
+	local64_set(&hwc->prev_count, k3_ddr_perf_read_counter(pmu, counter));
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		k3_ddr_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void k3_ddr_perf_event_stop(struct perf_event *event, int flags)
+{
+	struct k3_ddr_pmu *pmu = to_k3_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	k3_ddr_perf_counter_enable(pmu, event->attr.config, counter, false);
+	k3_ddr_perf_event_update(event);
+
+	hwc->state |= PERF_HES_STOPPED;
+}
+
+static void k3_ddr_perf_event_del(struct perf_event *event, int flags)
+{
+	struct k3_ddr_pmu *pmu = to_k3_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	k3_ddr_perf_event_stop(event, PERF_EF_UPDATE);
+
+	k3_ddr_perf_free_counter(pmu, counter);
+
+	if (!pmu->active_events)
+		hrtimer_cancel(&pmu->hrtimer);
+
+	hwc->idx = -1;
+}
+
+static void k3_ddr_perf_overflow_handler(struct k3_ddr_pmu *pmu)
+{
+	for (int i = 0; i < NUM_COUNTERS; i++) {
+		struct perf_event *event = pmu->events[i];
+
+		if (event)
+			k3_ddr_perf_event_update(event);
+	}
+}
+
+static enum hrtimer_restart k3_ddr_perf_timer_handler(struct hrtimer *hrtimer)
+{
+	struct k3_ddr_pmu *pmu = container_of(hrtimer, struct k3_ddr_pmu, hrtimer);
+
+	k3_ddr_perf_overflow_handler(pmu);
+	hrtimer_forward_now(hrtimer, ns_to_ktime(TIMER_PERIOD));
+
+	return HRTIMER_RESTART;
+}
+
+static int k3_ddr_perf_init(struct k3_ddr_pmu *pmu, void __iomem *base,
+			    struct device *dev)
+{
+	*pmu = (struct k3_ddr_pmu) {
+		.pmu = (struct pmu) {
+			.module		 = THIS_MODULE,
+			.capabilities	 = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr	 = perf_invalid_context,
+			.attr_groups	 = attr_groups,
+			.event_init	 = k3_ddr_perf_event_init,
+			.add		 = k3_ddr_perf_event_add,
+			.del		 = k3_ddr_perf_event_del,
+			.start		 = k3_ddr_perf_event_start,
+			.stop		 = k3_ddr_perf_event_stop,
+			.read		 = k3_ddr_perf_event_update,
+		},
+		.cntrl_base = base,
+		.counter_base = base + 4,
+		.dev = dev,
+	};
+
+	pmu->id = ida_alloc(&k3_ddr_ida, GFP_KERNEL);
+	return pmu->id;
+}
+
+static int k3_ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct k3_ddr_pmu *pmu = hlist_entry_safe(node, struct k3_ddr_pmu, node);
+	int target;
+
+	if (cpu != pmu->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+	pmu->cpu = target;
+
+	return 0;
+}
+
+static int k3_ddr_perf_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ti_ddrss_dev *parent_dev = dev_get_drvdata(dev->parent);
+	u32 pmu_offset = 0x100;
+	struct k3_ddr_pmu *pmu;
+	void __iomem *base;
+	char *name;
+	int num;
+	int ret;
+
+	if (!parent_dev)
+		return dev_err_probe(dev, -ENODEV, "Parent DDR subsystem not found\n");
+
+	if (!parent_dev->sscfg)
+		return dev_err_probe(dev, -EINVAL, "Parent SSCFG not mapped\n");
+
+	/*
+	 * PMU registers are in SSCFG space. The pmu DT node uses 2-cell
+	 * addressing (#address-cells = 2), so cell index 1 is the low word
+	 * of the 64-bit address, which is the byte offset within SSCFG.
+	 */
+	of_property_read_u32_index(dev->of_node, "reg", 1, &pmu_offset);
+	base = parent_dev->sscfg + pmu_offset;
+
+	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	num = k3_ddr_perf_init(pmu, base, dev);
+	if (num < 0)
+		return dev_err_probe(dev, num, "Failed to allocate PMU id\n");
+
+	name = devm_kasprintf(dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d", num);
+	if (!name) {
+		ret = -ENOMEM;
+		goto cpuhp_state_err;
+	}
+
+	pmu->identifier = parent_dev->cfg->identifier;
+	platform_set_drvdata(pdev, pmu);
+
+	hrtimer_setup(&pmu->hrtimer, k3_ddr_perf_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+
+	pmu->cpu = raw_smp_processor_id();
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      DDR_CPUHP_CB_NAME,
+				      NULL,
+				      k3_ddr_perf_offline_cpu);
+	if (ret < 0) {
+		dev_err(dev, "cpuhp_setup_state_multi failed: %d\n", ret);
+		goto cpuhp_state_err;
+	}
+
+	pmu->cpuhp_state = ret;
+
+	ret = cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	if (ret)
+		goto cpuhp_instance_err;
+
+	ret = perf_pmu_register(&pmu->pmu, name, -1);
+	if (ret)
+		goto k3_ddr_perf_err;
+
+	return 0;
+
+k3_ddr_perf_err:
+	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+cpuhp_instance_err:
+	cpuhp_remove_multi_state(pmu->cpuhp_state);
+cpuhp_state_err:
+	ida_free(&k3_ddr_ida, pmu->id);
+
+	return ret;
+}
+
+static void k3_ddr_perf_remove(struct platform_device *pdev)
+{
+	struct k3_ddr_pmu *pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&pmu->pmu);
+
+	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	cpuhp_remove_multi_state(pmu->cpuhp_state);
+
+	hrtimer_cancel(&pmu->hrtimer);
+
+	ida_free(&k3_ddr_ida, pmu->id);
+}
+
+static const struct of_device_id ti_k3_ddr_pmu_of_match[] = {
+	{ .compatible = "ti,k3-ddr-pmu" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ti_k3_ddr_pmu_of_match);
+
+static struct platform_driver ti_k3_ddr_pmu_driver = {
+	.driver = {
+		.name = "ti-k3-ddr-pmu",
+		.of_match_table = ti_k3_ddr_pmu_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = k3_ddr_perf_probe,
+	.remove = k3_ddr_perf_remove,
+};
+module_platform_driver(ti_k3_ddr_pmu_driver);
+
+MODULE_DESCRIPTION("PMU driver for TI K3 DDR Controller");
+MODULE_AUTHOR("Texas Instruments Inc");
+MODULE_LICENSE("GPL");
-- 
2.34.1


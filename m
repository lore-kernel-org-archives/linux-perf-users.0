Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED8353A91;
	Tue, 14 Jul 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033765; cv=fail; b=OEymkPM+eJRvOVeDAIRxaI4MUHrNxLtPkj9v0Kcmpa/iguF1GXyn1TmCexYyZU8nc7eW43E1WF+9eGeiHjwYpuCQoeLBP3dXru9UQPCDJuImRKlg6F4Ks9dx2KPBbbIo9xUIyXTLy3AYUMau7EutH/GQ19Ouy1afR4lzorRFfZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033765; c=relaxed/simple;
	bh=aD9psgrDiipJo7iSdcY5vy3TwPs+tM7SEUbtWw5k0EA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JcuFNYLscPO9Uv7M+av20rIsULGqrwfmDS+4TZaPBXu7e7y2epyczzbZJrw1CrKb4yDdlnpL0Rdvjwd2wBGHfuZgBSn3YEUBp8RbM6J/vLQBql3OjdVMg086PjUQClhraEyNc339WAWeXOs50nXLR7saTzFkvcWFJuAZalTav8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Ov/zMbri; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i+rHsp79; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Ov/zMbri";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+rHsp79"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66EBi1Pq2165773;
	Tue, 14 Jul 2026 07:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=kh1uhgqI0piX9
	RnX7EqtcVYhWFU9lDKV1jeMDdrIN/Y=; b=Ov/zMbriFqCoE0p3RwrdgCpUqIIcC
	vsifhtHTBApRY5ioPZuPqqlWnXMQJCIzIhJQeZOxFioT+Yr7355UC6B5/vmYjVDa
	AKPv9ZC74rtQVPrE2ijIKgvNZvmPKmpIKkwyc8nLEzkoxs2An1lzkojDp3L+k3NU
	EK6O+5OQd3bfQ/Yy1llUnVeR4/Xa4TYyBLT9X7I22J2iQR6Pzj/gUIFQCo4BOpTR
	c+E1T0+hjzd3397Cvc0PkKumB4fNDObEOJY4xlGRD/NDBaPUJJYYot+VyiPYkbN/
	U78+NMqMnwqi1X2vnR+MD3xOZhtnD7pluSvWf6JixEZc2ATZiNC4eFXDg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fdmgcgbdu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 07:55:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsSd3fdWFsMoT+ycoB1o7Cx+ESXTKfha79X2P66cBT392sKH0eq//UVmP2kYOvpogArFCMWd+TopbUHMIvIqm36Xh0nCl/2bNDAO8tjDtdSsgEmVAyTCsFNgBWI17j3Wyvl3RZ2YHaZrTi6cMfN/UO7rWI0LKxsxKqpKemzHs6L2z0/Y51qpy4LTNhux78vkBvEp75vrqjhuzJYv4jM1HQbu9UoxViGM+7lwr0meVlt7qmzmd0qTdudfJFlytIHKSZRb5J77KTY03qnhWXSdGyn6FHWDGl7ATzPpMOiYpWvjES08lAYB2t6FV9QSbOHkuuZbXvuHzpBmJqexbKYaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh1uhgqI0piX9RnX7EqtcVYhWFU9lDKV1jeMDdrIN/Y=;
 b=f7hiuAoY4yznnuiLqt9MHarbnT1VOhoFtUB0CHCgShkGLQUyq8HQvNGg0wg4iQHz0vWLPnyZCD8J0oqsAxapNO7Hp5ffMhxK4+pXJy02eo184nQYaHHTjYGKnXryilNvEGzt10JwKPuu1NdzXcqoe00b4as4nhbPNcUcZCM5R5v1wbjo9lQN8lr2yV3DGRJGNfroDU4sIApe/JDUIFGnPd8YPx8RMaDLARpBTvUXitRNyZmr+kloeiO2V6H/4x0MmUSfZ1GowLjN897TuNcadqmccsMUAslBgvr+52UkfQEUgUm41H9cHZhkLdQ3KCJeYvA6NjcFjo7K6aV4G6RWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh1uhgqI0piX9RnX7EqtcVYhWFU9lDKV1jeMDdrIN/Y=;
 b=i+rHsp79+QtBoGg184W8wbwfYNFMj7lAyJFxzyf6DiUONgVSNsJirTbhPBM5WxIbgAOw/8IVbAgtBZrG1Aljq0lFg2fOm5Fn1XF4w7h4u6X+NxdeKf2siM9UACaBEbJt1Is+5kchvywYGCKb883I03BmBSO32CW+Fa+TczkSWX4=
Received: from MW4PR04CA0363.namprd04.prod.outlook.com (2603:10b6:303:81::8)
 by LV2PR10MB997776.namprd10.prod.outlook.com (2603:10b6:408:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 12:55:54 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:303:81:cafe::37) by MW4PR04CA0363.outlook.office365.com
 (2603:10b6:303:81::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 12:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 12:55:53 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:55:53 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 07:55:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 07:55:52 -0500
Received: from venkey.dhcp.ti.com (venkey.dhcp.ti.com [10.24.53.161])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ECtnKm545752;
	Tue, 14 Jul 2026 07:55:49 -0500
From: MANNURU VENKATESWARLU <v-mannuru@ti.com>
To: <will@kernel.org>, <mark.rutland@arm.com>, <krzk+dt@kernel.org>,
        <robh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <n-francis@ti.com>, <s-k6@ti.com>,
        <bb@ti.com>, <v-mannuru@ti.com>
Subject: [RFC PATCH 04/22] dt-bindings: perf: ti,k3-ddr-pmu: Add K3 DDR PMU binding
Date: Tue, 14 Jul 2026 18:25:48 +0530
Message-ID: <20260714125548.3304257-1-v-mannuru@ti.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|LV2PR10MB997776:EE_
X-MS-Office365-Filtering-Correlation-Id: be6d1b67-0661-4722-8e45-08dee1a73d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|13003099007|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qB0WvDh+2B0/GIZeyXq1qVnMFFs6f9Yorm2OR7SRAV3ntwnJv9iYcWaMhufiTPS7NAsePyyFmstKy30j6SulnfG6gdoBVaWvmWU0jxX05cGpMEmVB7DanAsafaxRXW8ZTswouaA/ZyoiHGduCL0i5QfhiWmnihJXHmRDzE0if60IL7J/Sb+M4wjlKLAQ95uZa+IkS8Ok8DrvdrJEj6rqbqWKr446QNp6KjSpRDcjea1BPadNwsKI9UFoUuv0ncpLYDBVWoIu8C8Q91gJ1lWhpcSYLrXuwXjld874/aZI9qGZ8D+znE7SzJ1QkoLUxxIDP/3jOqULIh1oMUCe4NgoiqHhv7D49DSBNT42RCpsUdw54PfGVTcFiDLSLArKs6kjzo2oYzL75bY7OO0syZ3i3zzsqgCWNCYXeAs7d4fHG1TbzYjbSGgu/8WqZlOwZ9GABDgO+A10l+vpJM8VwyOH3MkA4myH9yQPrsykus1tv3GvCF0JlzoH2GCIzuKKA44iPcGRyYm0d8H7KXBR2KD+q88NC/QqKaeNTyHV+Ji1aDJMem08dfnN+Z6EyMsGxuORwREYtTIQnfllAqys7jLZ5lnofnf2APAsYpK3Ja0XvrZVajMAq/eZcb3wNLYfPkehamuQkMo6EB20DGuFoGGY5A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(13003099007)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EOKhPyuWavpipHa4M0u2kZO4BROBECcdRX8lIK29OQb7OfAO6gVooMnRTqK2YT/i4BxXpXTUoUU1D4m+UBd9mhRReqbXqqk2/JFojuW+itOMzR44eHspAzXo+rFQEgkZV6JGY2yl/OcM1FKrXTbDL5TP7Qb9Y88Oqhfy/LkmslbcMgvFzmpeAWbRrNZdEAepyxx5hLSh8CbB7xZhfrxpd0pb4ezBpQC6cjD54URHPR4prQyWykxDeEXFbdWI1R3Qn4D4lCoNRfvC2CZmjMVICOUwhB2KAc17xRP2ky8u0n/lvb68xjHcK70IeNkcjPvYLAp5pFGMigG+aKGh0rixH+XyzsuJL0nYiso0gMbwZ8tGE0krvHgbP9IPBDGb6BMd5JK8xxW80FJkBOi7njHixmJm4qvSbcsTi6iWiBQlGRBQynCnjGm09aM8LhUAbUh6
X-Exchange-RoutingPolicyChecked:
	Lk/SW5ZUCZjWlizWCoZoQfy2gEoQAycboskyYEleHTRZw63rVkU9d/siWWFKc9OAtJCVE3OycSrJhwOH3YLMrn6sAKPiNUzynCHVSDLr89dEClYbL4irZzwXE8H5Uh4VTXvvzn3Gf6hOCQjzRCWeL0k2OSs+MkFfEiYD0CN4wKPd/rzhVTLXyTDK0AtzlnZQ7/ObGfq5coty/E01cLbWHQH6dnSGfniqZGWJbtjSqO7v50BUdvWh4jlLi2FX+UFtGs01Zsnc/RsHwhIr24bdpOKlu7suy6X0ZdAQiERhci3EhYCwBT+PHW27GP53AeM0OifFMd26w78xSCnNZYYICQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:55:53.9254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6d1b67-0661-4722-8e45-08dee1a73d7c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR10MB997776
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX+SIoHMqsD3zM
 pa/3R58L6eRXdaEkLHA7w206IcIjWZH4wDtiNqjZZcrxx4Lpr59HfiQUQC8IpvkDx/Fxhy6fisp
 XuOIeN4emJ4Q5MwER+KQ6TJf/2NRsx8=
X-Proofpoint-GUID: l5ZxlLWWWvNqbFMz4YhHIgdxNWeNe0kB
X-Proofpoint-ORIG-GUID: l5ZxlLWWWvNqbFMz4YhHIgdxNWeNe0kB
X-Authority-Analysis: v=2.4 cv=GLo41ONK c=1 sm=1 tr=0 ts=6a5631dd cx=c_pps
 a=ucUdQIQ8V72PEv2waZrxmA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=gEfo2CItAAAA:8 a=sozttTNsAAAA:8
 a=PB_QMljaQIw0YKTxuscA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzNSBTYWx0ZWRfX7wq/1EQEmpAu
 CMV9OQevxuBVsvZgMBKVL/tJw76PaShDIbhgZ9I5srQDlmKZW5SxvLaEKXHz3s+JQj+32SUxwpC
 oQxMwzg7zKFM/utXjiHQ75x6dHuKZeDYEoC9OeYzTlE2GUOFoXV5fADZ5ETg9XEL+oBWwTdNqwv
 kqFX8NwV4nlI8UsKlnbMikuCE8scBtcq2Ye+OzLxAC1j6KvzBirnf8XVwSL7ExMyDO+pLCGwJAH
 UugpcLZKAIYwIv+K7KnxZM0YjtEs9LxbsnQfYGgVS8iaYq9hiOve0hzfMyr6sFP7NvGsAMEFNpt
 OzeNzO089x2l5Ma/PYKI4fhWCYDZk8x6+5b/zc21iXXj2Ujh+1RZdA5w15qJE0W4q9YZ3X/5Pxj
 8ppp6VbucYyHOVyUg4Z9uXfQQxUvh6MeNjVLTQxPJJyi5IC08XIP7vgLNL/+R8cJ3ZKqSx+t4bH
 gF5i8rN/nIrNsI/EE0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140135

From: Aarya Chaumal <a-chaumal@ti.com>

Add device tree binding for the DDR performance monitoring unit in TI K3
SoCs.

Signed-off-by: Aarya Chaumal <a-chaumal@ti.com>
Signed-off-by: MANNURU VENKATESWARLU <v-mannuru@ti.com>
---
 .../bindings/perf/ti,k3-ddr-pmu.yaml          | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/ti,k3-ddr-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/ti,k3-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/ti,k3-ddr-pmu.yaml
new file mode 100644
index 0000000000000..575a51e406001
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/ti,k3-ddr-pmu.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/ti,k3-ddr-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 DDR performance monitor
+
+maintainers:
+  - Bryan Brattlof <bb@ti.com>
+
+description: |
+  TI K3 SoCs contain DDR performance counters inside the VBUSM to
+  Cadence AXI bridge within the DDR subsystem (SSCFG region). There
+  are four counters, each programmed independently via a 6-bit field
+  in a single control register. Each counter can track one of the
+  hardware events listed in the SoC Technical Reference Manual (e.g.
+  read commands, write commands, refresh cycles).
+
+properties:
+  compatible:
+    const: ti,k3-ddr-pmu
+
+  reg:
+    maxItems: 1
+    description: Counter select register and counter registers within
+      the DDR subsystem SSCFG address space.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ddr_pmu0: ddr-pmu@100 {
+        compatible = "ti,k3-ddr-pmu";
+        reg = <0x00 0x100 0x00 0x14>;
+    };
-- 
2.34.1


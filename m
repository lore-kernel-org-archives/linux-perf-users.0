Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344E386438;
	Wed,  8 Apr 2026 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634598; cv=fail; b=Zde5hgSiH+KaCVUPo/ESr8dBR3mFB2kY0SPHZkmPhV3TFEBtsWxlu+Ln7uDcu2mMT5eiNTQs5t2WKkztPf+Pufj7Ig0wywAa/ExpFamWz6ANraCLoU/T87hqPQVnHwo/S6Jpz+PL9HuVle7rtgeiraNivbJQ7sdKq9gx5pZgTOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634598; c=relaxed/simple;
	bh=ksvgyD4xtAbql9hRGLq3QlBTEA9epf2lamTkRbqtN3k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KIgt8qI9g7XNA/Kikdopoz4Nd7QFeEk6qS447Qp3cEvVYV1tIcG0+dNQ8w/dznQE/aogpNZtX3kkrJ56kRMTaUGrWL3Nqx4AUm5ShTe7e7AjiXsdtyDQEeiUIgGqXVPQcScc539XjC602kvJocVo4fQGKTqYXpLK/OhXtYRpDGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rPNpf2Mp; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rPNpf2Mp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFuogMPs4plt26Mcs8NXgfC+tgTqkOGJ4zO/336RBETZqAGUi4oB/mVAoQbG0DgOd27DDC3S2GBdafllt+vMP8GBino40duS8Z/z7RjzJQnJqPmTcImBPsz1Hgsk4vMcqNAQzvkyQu65ctvYFxBYnIUVbpl5Fi4xTj6Ii6NLzlAuebrEIbTC3PrnBP357NhemHVTOrG9ARRmvZMhpPxod2tkBVOPlQlktZJKIp45ia7Vh1j9B+GxCsrLstO9TqI1LlhG4ptqyUVT9npSaYbnjQDXV0GFgO7BkSOs38GPa2Zf3uJYl2u42Y5wAYteL1ll6on9BffrUU9oaVfZUmiMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy5dkWuGNpB7OIuxGdp8gXKCKM+6dst3+AWzATQyjN0=;
 b=WTF24BORvON44qeyqd1iGbMO8cSBv/YtfCK4blet1eye82XRZdoy+DhZNaPV9aoAbc3SKy0GoAPXjqVkTVdilea5h/NnXJ01v5hZg3cPKZUy54NbfAy68tfRUlGNDRKJxSZ19vF/An87NjUMYoQm8vCQYGsfs+ug8i2nf6mmK3cX1EgDxcDf1lxPZjnm63bcMSRaE3ra7RUYllz9Clig0B8FLA8q1jZ9gJJzhrZP1v6wG/uCJTYeXbt3mUJL/qCx38svviOVLTsL8pqAUWiBKe94XmFHSeQGfN4XwItPfNTsnUWlyaAh6OFpzmVBtkx72MdO4+NcUfCwK4lg+zPFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy5dkWuGNpB7OIuxGdp8gXKCKM+6dst3+AWzATQyjN0=;
 b=rPNpf2MpiCD/ioQnqSWSNKwzp9mlfxoYktJWf4FNWiaMU1hHT3z99nPPLnNOreODdjA3/gtC/yBf6cFYcNoNe+NlTjtMgCgKg7lYZLGFDB9nNgEOeCXmKzWB9tWa0uEpseT64frWek1j0Uo3WOFn3yTkMf5mK7yztDhMYT6hvdyqXI5EhlLfKjcN704W7LCr0qznxyFH/9mfn1V9BnZvOfzYa8lCNcR3a0LjWWkwyK/mL18U3NSedIJblT7KcXJLZLs2ieeU+YHZWa8Mcu2DF4xz/EiAbNPuJ9pCaNYlx+ev6CEZmKrFn4Qe/avzPXhFKtAopxIOEsCiYrYvDbf/eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6864.eurprd04.prod.outlook.com (2603:10a6:803:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 07:49:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 8 Apr 2026
 07:49:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 08 Apr 2026 15:51:15 +0800
Subject: [PATCH 1/3] dt-bindings: iommu: arm-smmu-v3: Allow PMU child nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-smmu-perf-v1-1-d75dac96e828@nxp.com>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
In-Reply-To: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef96e25-6473-4e3a-30d2-08de95436be5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|19092799006|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DBHNIeoyocTJEudic5idI6lLQfCbXcNOPeQ2MDmJHNTReqq99OYSYIfY0TQHtiPVW9/ftgVhSY/dIwlF62oXfuBQ5/I+T9URKmZT5FVL23ETM3LDu1dAR7/F7pj6yy5rXbiRpRMT3eyKTSu5mQhQqS/8OSqzL8c1tYDI/KOnHu8kWvbRsZ6RBFjy5MXyHa7iFoI4frS/szFh3AITH1VWWm+vEwi0dSkj4DKvNLqZ1bApe6XUo2MYm5whi7aCxXHfNNn3G/Wg1LU/6oO636yiqEErRk3SDNjMlM1nuM1CjqDOwt4475n1Gs7FegABBJvgdPZnBo31+1/bzFDmzyva8P6RiX+XW2FgFnySMAGWUY6pg9DymGeyKAswC9cB+Hl5zaGgHvOP3wPmxnKKpCeXKpxzkj9xRmnNxZurHvumaLfOWLXkm5ErFV/qUQMhA7dCC7UDlH69E7dVZ2S0zHPQ+ifsOx0LfWbVVk6x6UT/BleNleoVkYzuQEzDgI4bFNdFkM4VHTG1PjV1dpKiJgTcssEyTCVsGkgbmh2sRkkX5jzuOG5nj8cnhGPbSrVpa0X0Didp+p58iqgjvOKe2J0iDWvwebgGh2EnIK4CWnUcOYlyUeX2hBks8nFbxIQ5E4fJmXpFLcBN+fv+aypvKm+WZukF06Eisw2PawgHDo/eeZm302AOoXkkUOEFpFzZXGeMQMSl2Yc0A4mOyNNPNVHm3H7ImeOvta2/UwVb8cG11YUdR4hdUzdJ90fTv9iC0S153lsYv4L23HwpFDfvCKd/Ufj92yr4vxlCVC/yppcSxow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(19092799006)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNRak1GNkJLUnJVVGloN3EwVjhrSC83UitlbDJqT2lnc2xEdDlYTWloWXJj?=
 =?utf-8?B?Ylg2VS9jZUswSEZHYVI3MzN1aUJsSFRVNTFEMEhoanZ4U3UvU25mMjFBMG1D?=
 =?utf-8?B?a05sV0ViMnlrUllNZXY4cHYrRTVTMTFIWVZjL1BqNWpjVnNPSGpGM1hIR3hM?=
 =?utf-8?B?Q2hKWW5yeVV0M3pRZTZualpPOTlkbEVtTUxDc3lzMXUwN3hVRW9pUUY2Y2RB?=
 =?utf-8?B?WE1DMFZ5am4wQjIyR1hsalA4alBSOEVmK3BNVDJnZlJqNVkzNnhpKzFEOTdH?=
 =?utf-8?B?L3Q1ZlYxQkprSWFodVR2RTc3RitTS2UzZlp1azdhWmQ0VjZnNkx4NmZOTlli?=
 =?utf-8?B?R0dGdTN2TEZQWHlCeXNZUWxLR1d4Z2NMeXVmWWxra2pjd2N5U2E1RzlZbFUv?=
 =?utf-8?B?eW1VV0ViOUJMQVpXcm1MbUVIV2sxRHFta1ZibjNkK2FPeWhQRW5zWUo4eC93?=
 =?utf-8?B?ZjE5UXVmeDFQSW5qZFowWjErYk1heWZSVkxxU1FJb0VVQjZ0R2F0clQwTkVF?=
 =?utf-8?B?ZUUwNUN3bEYzalJ3aUhNSnBOTENSWUlrd0M3U1JTWW9JT2dlTjJBOFlLS2pI?=
 =?utf-8?B?c3ZnTTJ2SHJQbnBRWmpObFhRZEhZSUF4T1o4ZnJDMUpkYjZWTmtkc2JWc1ll?=
 =?utf-8?B?TlBwelYzZStGLzdENW5NYmM3ZWhpY2ZBd0R5Z1dQVVg4VGZ2TFNsaUZ5UDhS?=
 =?utf-8?B?ZWJEUHF3dktSdUpseitMeENFUGdrOFFTNHUxT0xuVjBBQ2ZnT3V6QytpUTIv?=
 =?utf-8?B?UWpHVjJHRWJkK0NaTE1aTWlxbkJVdnlwdmFnNlUvT3Y4bmVoN01Kb1g1RjJ6?=
 =?utf-8?B?WTRObEJITVduaWFvdktYemtoSjVQdjk4d0E3R3dOdDBmTFRqOElSMkVsbHls?=
 =?utf-8?B?cXpNVE94VTFyVnhrR3pwOWYvMFpEQkp5Y2cxU3A5SkoyWTdHUFpXYWdYbito?=
 =?utf-8?B?NGxGb1BwL0hvVlJpSTVzUUM2UHNzNDY5TVdjVWJIaUxxdVA5MXRnWW5YK29p?=
 =?utf-8?B?bFMyd2N2QkRtQXdCZUZzRExuM2tjNklqUUtUdGdRZGs2S25PV2dlWm8ySW9s?=
 =?utf-8?B?dmdnQ2tvT3UxMFlUQ3VhWVNEVjYwN3NGaHBNRFZhTE5aUmJNbzlReE1ybG5q?=
 =?utf-8?B?WXMySlVnMDUwSG9rZWs4SWE3N1VzeTNrVXAzelZvMTZEamwvVEtjVWQ1Y0Zn?=
 =?utf-8?B?WStBeXRFUnBndWNnQWo1NExLN20yeUpMRnhHamZvbWFiY3pxanRtK3E0VWx3?=
 =?utf-8?B?TjBhOWJ5RFpLSFdKbHN2L0N0bHBTSFA5Vm1Pd2RSZHhabm5sU0RjeDZ1M2ZL?=
 =?utf-8?B?dnE1c0Jkb0tDQWFOTVlINllKWmx5cjlYNkMwYVlaTTFGMk4yQWdLdFFGa3Ey?=
 =?utf-8?B?bFBuYkJjRnk2cTk5cVhlQTlURzR1dEREMWY3ck1XclBtK2dZcEZlREMzYkF4?=
 =?utf-8?B?NFVrQVBUc3NDT2pQRzhod2Zud09zR3BSMUE2cFgrUDAzWmJVQlgvbzZQbElT?=
 =?utf-8?B?bFlza2JrZCtPREo2ZXhYUXREV1kxdTNYV2xQemN6R094VTdLS0EzVkx1NFVS?=
 =?utf-8?B?OTVxbFhoZFR1Yjd4eEJvZ01rYnB1OWgwZkNlN2JLUWhkV3Nyekt6TU1LNmVv?=
 =?utf-8?B?eGdtQUxmY0xSckYyYkNlb1o5cmY0SzE4K3R1NWZZQUVHUEltcm15R0NiZ2c2?=
 =?utf-8?B?M0J2TGoyTUFvVGZ0ZW52SENieHB3TFYvYlBOL2E2TGxHRk5meWJneFB4V2Zx?=
 =?utf-8?B?RnQ1MmlTVWRVR1JXUG8yUEd1YXBUU0dkT2hBc084dUltSnRMMkZUT0tKM2wr?=
 =?utf-8?B?emsyTllmUVcvY2l1V3lmaU9uUGNUMGY1MXhPVVpTcExrQVFJdDM3U2RPUE5i?=
 =?utf-8?B?WXYyRWJCV2NBSkZVNklEejkwa0xNUWVrY1U5b3dPR0dJb0c0My9FZHM0M2th?=
 =?utf-8?B?NktKVWRIS1Zrc3luYis2cjN5R25HYW90WmR4aEdNZWdHOTBQbStkZUZrQ2hH?=
 =?utf-8?B?WGxxRUYyNDBocnVXQTFibS9tM1cvc25PTWdEUVR3NEpabVE2V2I4eFN3bDY4?=
 =?utf-8?B?ZkpCM3p1dDBpbFJnbGlkN2ZYNTNDWmhaUmorRkNRalN0cWlCbnFmRCtLcHQw?=
 =?utf-8?B?S2lOd3IrcExYR3RDT2k0UTRuUUUyRUVVQXhZaHRPUzFKU0RKM1B1SkJEY0ZB?=
 =?utf-8?B?MmdvTG41TkljSkJTMXJ4bDcwSkF6OTg3aHBzdmhpSWg3TEhaMFMreDRER04r?=
 =?utf-8?B?VktXQVhYOHNRYTJFaWNDdFVXWXRGSmdLQytXYkJScEcrWkNpbUo5WDdTNEdo?=
 =?utf-8?B?YWVxVXJ5Z21tcWtybUlaODBoWWx1RDhlRTVXRHVmL25uZnY0c3JVQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef96e25-6473-4e3a-30d2-08de95436be5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:49:54.0516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jou86xHxgQOPe2oaoFPq9CSNGuU9wGfygqNWjJwnzQdsJWYf0eeiYpJX5ymIHuvbqdhjyOn1erb8qpbFK3r4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864

From: Peng Fan <peng.fan@nxp.com>

The Arm SMMU v3 specification defines an optional PMCG (Performance
Monitor Control Group) block. Per MMU-700 TRM, it has three 64KB pages,
with TCU Performance Monitor Counter Group (PMCG) registers starting at
offset 0x02000 in page 0. So PMCG could be described as a child node of the
SMMU in Devicetree.

Add a patternProperties entry to the arm,smmu-v3 binding to allow child
nodes matching "pmu@<addr>" and reference the existing
arm,smmu-v3-pmcg.yaml schema.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 82957334bea24402b583e47eb61b5724c91e4378..1d09c5476e5f1a7c3e5c935b677641ee6cc9897e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -50,6 +50,10 @@ properties:
             - cmdq-sync   # CMD_SYNC complete
             - priq        # PRI Queue not empty
 
+  '#address-cells': true
+  '#size-cells': true
+  ranges: true
+
   '#iommu-cells':
     const: 1
 
@@ -83,6 +87,12 @@ properties:
       register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
       doesn't support SMMU page1 register space.
 
+patternProperties:
+  '^pmu@[0-9a-f]+$':
+    type: object
+    $ref: /schemas/perf/arm,smmu-v3-pmcg.yaml#
+    unevaluatedProperties: false
+
 allOf:
   - if:
       not:

-- 
2.37.1


Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04373932F2;
	Wed,  8 Apr 2026 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634597; cv=fail; b=Zume1GC/d8t9f930lZbzp5R/w8WD1X6u4s03uv1fiIbc2R94h5Ga5bfHaYhyJUN3VA7X8NV5bH2iDg4Q2qAZnsBvNqBcvSzPiEwvpVq8/KffH5m4RNfugj3Ek1Du5qI1nzAhSf7sRnanTCUQYBcifToWWWU8Ae/+7uj9plHnPJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634597; c=relaxed/simple;
	bh=D6K8HuJsVtvxH9elSQoxNrs//WefdXTlEopFQGuNVCA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=O7Uzd354kwEn5ub4ev0OInoQCRBKHBPI9pIelP/agNdm8FsFbpR/nk/JUSDvvHYetND8CeBdE25thIUHe4lgutKTaHQvNH3xR+VWAcWEbkwpGm9p8WrRyeYQHVhfd2aY/DHZbaI/aXfZWlAIf4tL8N0dVgNyUK6BpAgglbgtsag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Mrp119Bs; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mrp119Bs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMAG63M0H3NPQv/U/MFJbATuXrQODrTl/NgW8IkTtgsEy744hugZ4AbltAKJesXMCoD5hIBt3lqzDJiTRYircOG0eC+aWVYw2ubIsaoG/KvLZsSEMp2ZmdmQL3X32Cs5g/FDmWZ1mYZwl3p9sxooqi0/MziAd44RUlix12+IAxJn4jF2HcpUoOS/29mZkV0liDa5nj+8SSxaZVCR8hDOpbHGgiqr2mY2tFy2Rr9snni9ziXbY506gYhPHDzXDkDY+m3taQDuoGbC5An4n1hEI6Qrf75LYsgLkI2fw++pEWSV8PgxsrclOHEF77NMP+BigyQmtHl16oQ2ONpmDdp7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u57JLvYYKZlmgSB474f4FHiGZ8/mmsMHTxBklFNNm0I=;
 b=lAK2feITtyaMehgU7C1wzqCn/YMSswBfIuHSRS+HppmBepOO3Vu6YzgMCZd7cWoPwSm1cOE4o92rtRAdVZh2QarxZmXX/X8QkVDSrcG0O4whbY3Tf7HFCR1/dIjqCt/NC+np9zqJQHAfn8+9H+DdKxt5snpJDtY6kGGoGdsl+q4w0W/LwAR/9MDwzd1ikgJuqQp1lBTjWmQ0YWmFY4b3b3TqqzJHb+7QNP9FGZyzSPmWRT4wKzf/hzH8XMzrWMLdBqDn5u73+QaPuys3BlioG4BdNJBkbuKpruKhzSapQNXa7nAf/9DivY5MJt+UDXlrE3MN9AQC9Z0VdHF0iyfHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u57JLvYYKZlmgSB474f4FHiGZ8/mmsMHTxBklFNNm0I=;
 b=Mrp119BsHEwB+9YcgNSn4/4LKSi+mzFL14xWDsKCXlt9x4ArqODjUF40jbBa9fXMDEnnkmqm5XGgD27cDQR46xq5oPxl4nJVFsJDKfBL6Rs+hGJBU7GtD3F8KMxErbsLqr7fk9QjuxHtwWFgU/OU2d3vLRaOJRFlxkTt7gRd7cmOpPOiTNyl0V1fA1cZnQQJQ362w8bzVFv3wp9Gj9oKd+S2C8Bvi0bGYKiRytd9c1ib2kp/XMwxNnyu2GM1EWbgaSIlGRxzi9vWbXc51IgqmEUpg09riYX2HS3y3hm6VXHuZnojJ2kJLmflgsyElhYbM1lzHRq1UPUVz6AIHai0Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6864.eurprd04.prod.outlook.com (2603:10a6:803:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 07:49:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 8 Apr 2026
 07:49:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] arm-smmu-v3: Add PMCG child support and update PMU
 MMIO mapping
Date: Wed, 08 Apr 2026 15:51:14 +0800
Message-Id: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPII1mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwML3eLc3FLdgtSiNF1zUxNjM/O0VDOzZAsloPqCotS0zAqwWdGxtbU
 AeaFaf1sAAAA=
X-Change-ID: 20260408-smmu-perf-754367fe66c8
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
X-MS-Office365-Filtering-Correlation-Id: 1ca6e2fc-e048-42ed-1414-08de9543698c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|19092799006|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v0n9XfvIjrpT5o1u50HDyp3MD67oLGzin3IUMcnSYmECaq3H5Xy2rGRW0grhv6D56tAFDycktUzSo4/5n/7+t51XkYJprJiu4VJfUAWuoi+pvPIgtDPEyYi5Dpwik1XzQzg8Y8sXE2h2XvZjFLAmD9wSD4Asv4BifbtGQHlUnPS29q1ZxStXSdDXPuPVQ13pzTKzQieaKovwca1yVJ3R7tsVX79OLwiv5Ps59+dCCr4ql9hRlULf8wo6bKmXBxbbrrPkTCTJnTZ+jHt9HI7P3e7FjkcbjxLia4a2L36ofKMJh4va6Je8pJ5lQ6yCPnOCrAs4fa4GTc6J7NSJVER5BHXPxAYGiHnwlQbDOatXRYmVeqLKX4BQHv26FO2ZVAUZoWsVICm90ZIERAJ2LG/V9YCVOyhQfgmr1Z9XEc6ULjEjiiHOOKIqTJdKY0czOU2JUWfg3wHmsJviKJPFmh9iXAh3plncAJNlzqGB16/ue67RB/dOPWsUixMPf5pJl2X7dpHXgwyy5YmikCHyf2nZvxX0DA1II5HnHGlACXczrXX+59QROijSpS+xgHx3tEAubQMaR0mUeTDxilrXNBFGJrFqSD/vyUVgRCy/RsX2v7GqzOzGKhVtpJNqrIUq+el+cG2/4JZRpUW/RX1b6fZvHePM7uFRvco39kGk0th+9lS9yOjwbheHMWUiQ4CoyULiT60b2QbuqhQmGS9fctlCSXcPa9/W2zfZ2HOvj2EEFNQL5OwfKFGzYn8oOOKt3nn3JXJt209w1tcAXSicvfgjrI4nMaXm4cAnXLe4OZD6JuY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(19092799006)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjc3U01mYk11Mmsya0QvZDNCUm42THMveldDOVQ5TTNicUx1Uk9rNDY5aFRU?=
 =?utf-8?B?dlRwR2tYR2dneTkyT1lGSW5NdU95RXZ3cWV1UmlKcUcxcWJ6dkhra0phT3c2?=
 =?utf-8?B?RnMvdGFSdTIxbHRRczNZa3Bkb0x5U0dvd2NKc2V2SGptV2tLVUFaU0tYbFpn?=
 =?utf-8?B?SFVMWEhpd2VONlBOTXpEcktMOWRVS0lGNjFOZjlPdUxiaUx3YjkxYVorbTc2?=
 =?utf-8?B?TUo3a25URXV1YUVmVXpUZ1lsUWNSSS92U3hYd1VhZzRHL2RwNlF0NG4yeTR4?=
 =?utf-8?B?ZTNCYTlNMW8vRXFpMnRVSElNeUV4c1RQY0MvSlljNHJZSytiNi9NeUlIbDVS?=
 =?utf-8?B?UDF4S05LekFTdWNkdDd4M2ZuY01DelVJUUpUWWxmNEd4RldmRlRsbTVCM0ZF?=
 =?utf-8?B?Z1JXZkt0Vm14bElheEpWZndIM2dtbk45WjZqVnlnZE1aVUtYa1pNYi9IZ0lP?=
 =?utf-8?B?ZVZQcy9PdmtpbXN2T1hHMkpFcnorR1F5R3Qwb2RUK2FtNXkzNDl5T25QT0Vu?=
 =?utf-8?B?QTBVTVkzd0xRbHJ0dkhUbHUxY01rMVhtcHZqc1FmeGFtU3oyd0xMeXV0bEsz?=
 =?utf-8?B?bHhXMXQvQ0dxY3Z6WENPbmt3L2tTMFI1L0RqR0ZBUVFFZko4SFUwWGxBbjU2?=
 =?utf-8?B?eVdHaG9wajIxVWQxUkF6dGdYaDRrLzVKZytNNmpucHhvNVYrM2FhT01ObkZN?=
 =?utf-8?B?K04xK01CSFJUTmVKZHVCdCtVR3RUVXBzaUtzbG8ycUkwYVlpWGs5WkRBdUFk?=
 =?utf-8?B?Z1pnbzN5VmpnR3czTjBFN2wrL25tVGJZd29rOXJwbjlOTnZ0ZXRoZTQ3U0pj?=
 =?utf-8?B?cXVwNzdCWG9Mc0JtelNmcnVTb3JUZ0FmR0lmWU1hTFR2S3VkZWc3czJqNG1X?=
 =?utf-8?B?VS9ycmNqUlJnVmQzeXlkUlNsTWVnUXkrNys5TWx1VjR1N2tkOUpDeEhXcXVY?=
 =?utf-8?B?U1l1Y3dhL0d2Z1ZPbDhMZ2s4RXFiQ2prb2NUdmFrYllsbE54QWxTNVRKNkpQ?=
 =?utf-8?B?Nm95RjI1STlSUmFudnJqKzRCOGZZVytrd05pNit6eTBhTWcyaGZjamlmVWRq?=
 =?utf-8?B?MHRPQjRWNkozY2d6dUVVTGVyc0ZQZUtnUFNtdUhld1lHSElHbFd1ekZQQTIr?=
 =?utf-8?B?SFpnYWxRMWpkM1R5Ym1CSFpXUzM5WndZMFAwQ0hzaE5wYXFSMFlJMk1tOTd3?=
 =?utf-8?B?UWF4cFVwY3FwUHVvenlXMlpaYk5hRXphSXpySDkrSUJFYXlrU3MvZG41N1VO?=
 =?utf-8?B?N09maHFtTjFqUVNjQjRRbUczOU5iczJpazg4SXpQR25YRXNsbDlEY0t4MUdS?=
 =?utf-8?B?TVNLOXB3SEJCNForQ1pDY1NsUnVtMmtaQ0h4bDhHVnp4YVpPaER5VHBvYlBh?=
 =?utf-8?B?VEdtQ0ZXZysydmRjQXlIT3RXdGlXaG1TdkYreVR6N0phOEthWlhZdW80Uk5E?=
 =?utf-8?B?Q3NnYzJHMXhvMVRrRDhDK3F3eUQrRjJVVm1Qc2FpbFBNVGpvNGNQQmdacW5y?=
 =?utf-8?B?OWFMdlpKUzg4Y0tSYXFxTHlzRzE3QTZCV2hwQVlaL0JQcmFTUjU5eFNQeUtF?=
 =?utf-8?B?ZHhRYkRIZS9uMUZ2Y2RUcHpxTUQ2MHRxZ2Q4cVIzTDJnbTJaNHZBMldjYzI0?=
 =?utf-8?B?bUZpS0ZwcTUrYjNRMVhUeVY3Rkw5WXRtQStGT1BtcHd4MEhuV29Lai9wZkRn?=
 =?utf-8?B?M0c2a2dUSDdsY09TaS85ZFkyK0xZTWFlb2VxRVRXOFI3eDdWb2IySmRUQlVp?=
 =?utf-8?B?U0tSYnJRS29MaWR4YjdYb0ZjSGFZbHI4NU1UTGtYRFlTbEhEZUtvL2RNSUxW?=
 =?utf-8?B?MmpNTUM1TlhseUNtdS8wWnhVRFJmamNOOEVaZ2xTVk1paFZVeTVncjZjUUQw?=
 =?utf-8?B?VEFzTEtpN0tVY2Zla1BETE5RTDFQY1VGeC95djl2YmtCdXVNYUszdXRnRlI4?=
 =?utf-8?B?YzdaZFJSczBmbnVLbC9qdnZCZlNmM2liTmJsbmkwVnhtS2wzVVFJUnFPKzJW?=
 =?utf-8?B?QjFzaVJPRjRuZDdsTCtqck05SDhKbllaL0prWWQrVEFEajNnbUZvWWdiMVJt?=
 =?utf-8?B?WE5nbVI3SXFiUU55RFNtZnZqZkRuN2Y3bnFnbDBDRk1Eek5UNlZDOXVIeWtO?=
 =?utf-8?B?RlpzclRPcmZNVXVTcjRuTE5RcHZQNjdzcWlJclB1SVJuOUZZQkhUTEZraUhV?=
 =?utf-8?B?aHloV2toMVRaSGVpcVF6ZmJEYXBPYmtoK25DT2JZKy9JWTBaeTJoL25wRW9O?=
 =?utf-8?B?OEtJTlpkNUsxV3lQanRpMXlVZS9rSE1EN3Z3NjVEeWgvUVYwMC80U2crdUd6?=
 =?utf-8?B?STV2K1dNOG9YK05iT2RsWkpyMWtZVFZSVUxMTmN1cU5WQ0EvaUdmZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca6e2fc-e048-42ed-1414-08de9543698c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:49:50.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtnCwJ52La8tk13jIJRMNJDmVN48MflCh4P7lzKY6NuPKsgyq32c8E6DAI58fzBOrSllgw+BDoQH3Oxbvi0bIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864

This patch series adds proper support for describing and probing the
Arm SMMU v3 PMCG (Performance Monitor Control Group) as a child node of
the SMMU in Devicetree, and updates the relevant drivers accordingly.

The SMMU v3 architecture allows an optional PMCG block, typically
associated with TCUs, to be implemented within the SMMU register
address space. For example, mmu700 PMCG is at the offset 0x2000 of the
TCU page 0.

Patch 1 updates the SMMU v3 Devicetree binding to allow PMCG child nodes,
referencing the existing arm,smmu-v3-pmcg binding.

Patch 2 updates the arm-smmu-v3 driver to populate platform devices for
child nodes described in DT once the SMMU probe succeeds.

Patch 3 updates the SMMUv3 PMU driver to correctly handle MMIO mapping when
PMCG is described as a child node. The PMCG registers occupy a sub-region
of the parent SMMU MMIO window, which is already requested by the SMMU

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      dt-bindings: iommu: arm-smmu-v3: Allow PMU child nodes
      iommu/arm-smmu-v3: Populate PMU child devices from Devicetree
      perf/arm-smmuv3: Avoid double-requesting shared SMMU MMIO for PMCG

 .../devicetree/bindings/iommu/arm,smmu-v3.yaml        | 10 ++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           |  3 +++
 drivers/perf/arm_smmuv3_pmu.c                         | 19 ++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-smmu-perf-754367fe66c8

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF6399349;
	Wed,  8 Apr 2026 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634606; cv=fail; b=s9vuj3nsOxi45cV7/tB/JfFqgE//tBBgCLn2KwsP90EoedbFrqzCPLP/fUcJ2bgrm/eIV1YALCV5Xc88o0oWx2OtjaIUueTS/yoyqXzf/IBhdx5MViypqT5THf5K8cCouWMC027yIh4LwvqXdKTh6Ju2Y9nuelaidD7Enb1umZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634606; c=relaxed/simple;
	bh=5RWvpQgGGPHKKXY5Wp/GSqzww0P9G3NlOAsQXf7w/Pc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D0RLh7LBRuY+LIRcJhDkViu34mK1Yyi7HNKpEXXixWMerAYrCEgoaAnx6Q+nUPoUe2p3DosHscnkVQs8Nkfu3C9jf8HZMHsp/NAcLlNyo9Cw39B5Ovqto44ihThzwhPeg9mg5oj0AcRF/Nwleoye4Qz0tKAwOs/uXdibxGDYbpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SLNHE9X0; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SLNHE9X0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3ZYDfQQey0yUJJJTxEW8dQ6+x544fdf06sqzy4z0gJEnAeigw1oCh0pFd67S+RiChQM3yguSrE54XXtZhV5zoNlvwS+H6DFP+8E/GWKbEQV7Dim5SMmBYxZY3hEQOsZS0YnBCrtQJHyAgiUoXA2cBJNdOAH2KSjLQZJ0FB4lcqeUtFimZO0DC3Xy2JW8dc3uD9mrUsg0M4bgefQchMPigW7xYurHwj+mXMn5X4jPm9MgARc+he8I+Zu3hO80FOfGCjr9cpfBltyQJwTtaz7BMtfzCbWVW68LKb1BNqAQUmNHUJbqxlR0Y70WQ6qTmHM2m5ZCIUxadZmMvv3Ms5CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRFv1qhmQFeizKVkzhC1cdajvCFSbufzKnUSglQUvNo=;
 b=jNveVXhTHCgp0l25ZEaC9a9lwM8BMXxctmkOTVm+CITJkYjP1MSZ7+Efp0w3JS57YUK6PgbAOwBkgIXm1Tvjj/5znEARAQYvZXCx7e9xN3+vTTyPNp/2mPm6U+9lEVXMCOh+ZLfzTjhCN2DihswzhozYyR8x8EwHt+OQAT/1VBCyrSj9D0wDOYEsywXzUyjnmKzvQvx+clMJyPsHf9UDAIiPwqiG36rsLFCm6drT3ndwghNZeWbMZXE/6hF7c4++T1eCAf7bTCE/c8SH3aCV744b4GvvAE0uCYYnlm3VhpcXHx6xO3DEzlLpKy5Eh5B81/2KsveM8Aq4SGNFyS7Fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRFv1qhmQFeizKVkzhC1cdajvCFSbufzKnUSglQUvNo=;
 b=SLNHE9X0AurShaw/5Kq+KH8u/lrwfxmrT/9EHaNb0UiBI21eLARSv3H/bZDHUkoaJTzDROoORH3BFO7wXChB7Rl8lWQXrWG5GNz5Me1KaBoUaFeR+Hbhy2xddofmEPMoFAfFZhIqlt8xn8qTKkXk/01F0q7rIs5GcyMaMcS1fIp8Vwwlnipl/S+AWbGLrlHde1bkpDSKyR3IMeulf9msnY1+XkYCxO4fd5rpV80HoAB533nIxCZZBAuKQVnW3gImAONRXt669DvLywP/4Tkq8P4sDSIpooPcBlpEgnLSJVEy9rS1zVJBMI/R0hgdBR8gLS/wZIWFT/cDJORmFGtZBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6864.eurprd04.prod.outlook.com (2603:10a6:803:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 07:50:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 8 Apr 2026
 07:50:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 08 Apr 2026 15:51:17 +0800
Subject: [PATCH 3/3] perf/arm-smmuv3: Avoid double-requesting shared SMMU
 MMIO for PMCG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-smmu-perf-v1-3-d75dac96e828@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97625316-476f-4eb6-4450-08de95437062
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|19092799006|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wDH7ksQZdVDOXuwjOvaG4fcBpVpiFtlf6fiSrbhtpFSTWizVns2FvOrDm/r3IdvJhCISi/4joLpVAXQLgSats2xCZ2X8KVn8EdY/5RNo8MPpXJIG9AC76oSDbyuDI6hfShASrZ7iff5vj1PdgAsjLxG//ETkBN52KjLyHsULsu4SwEBsqoHLA8+8Sz+Dnrzj2k1y14lN40xksg+9ITRm2FiLs6gwhAKQcQGhzJ18HXRKX4C49ERaFmY3vZsVj5THVw994sV0q3TW7WJgfeIdt3sfQg9+8KSaGZ7ifyhLCcUmZ6237A2+mQaD6JBf7KXUzy37NKUsunNQ7pMUXh0KtyaGZKfpx1XnGEbn6KwE08AiycG30+d6AbdaduuqqlWaokTQnZ7WoGFIXZ7P55n2+lZQC2uFnlE1QlgBvw8PgHrAbj/iUpQejvHw5xm0xrF8XfETyGo/4iNz6VPrCQIwMCsteGW2wSaX3EKJogZedW3HMFOb5nu+kWRfqAF1jj7OX2rrBUuhdNEYQk8HOTxfEVqtXxUhb9aMdOZqK/szbuQUwFcvhatKa0Asb8ZgmIc0QJkUeOJDniVgUfC4TBqTK31aC0SeQdiLUR1M2lme4+ep8/G/fbzOFF/UDCQYI1b+hA8cDrSRx+Xf+1pFFH3CIIkWqm6/lM1RnV8fMpJvuyr3HjLB5f/UygBa2n6qiZsK5g3UNizI5Eu+4ovkHWBFZWv+Ib3EKN+MV70jgM3sX0wacn481/w5GJ5za92811hbta1f2Rgo6potwkPShY95RUHn0omLU3oZGfTzCsFrHDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(19092799006)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1c3b3FxdmxIZDM3UDdaK1VoQ0U2SVBBbHZnd2FocFBWMXBkRzdDbDVJR1FI?=
 =?utf-8?B?ZXlCYVdkN3hhNDNRR3BVQ1VZb21QcHBuR3BCQnB0Y2pqVWFwSVR6NFZhNVJD?=
 =?utf-8?B?bGtjb1JiSmhqbFJ1NERmYkxBd3NLUHFxU2pEcnFEYmpXb1d4M2tDcnBVZGdB?=
 =?utf-8?B?VW8vMHBaWXJMRFZWMnpGajJXL3FaUVlTUUgyK3V3dzlKbTNocjV3Ulo1ak1o?=
 =?utf-8?B?TmQwZ0k5NnJsTHd5VCtXZjltUHBDQjl3UHdLaFJDVlNWT2FudXhlZTZlRkJT?=
 =?utf-8?B?M3NsOS9XS2JuUnRFRFlsaGZQdWJJUGZNdkRZM3A3RnFTTW16V0JkSmlmQXJw?=
 =?utf-8?B?WEc1UnlGQWVIbm5yelJhYVkwNGFPT28ycTZsbisyMVJ6TkRCZUJMRE9Bbm5h?=
 =?utf-8?B?ZWRoQ2tnN3IyN2g0VmN0dXVrL0pFRmhJRytPNjkvZlFZdDlrR2I4ZXBEbmJ6?=
 =?utf-8?B?ZTQ5ai9KeEk1WTdRbkdHSVRtaEgxNndVNFlmdk0vT2t3QXRoN0pSN2dRQ1I2?=
 =?utf-8?B?ZnVtbVoxUVk0MU10Y043a1I3b1pEOVZyRTBwL2dhaFNWamxNNVJEWmo1RUxD?=
 =?utf-8?B?VWE2bXpoWXdiMlFTaXRudHgyTXc2VnBucG1hdHplMnJBY1BhNzdLMG5GN2xB?=
 =?utf-8?B?Qmsva21YYnlUSnBIWHQwSzJwSnJIUXVuNmJDV1kyOTZuOUVrNDIvK3FYRkV0?=
 =?utf-8?B?UzJwWXRPSUk4RnRNZHBYTU9kZFM1ZlB2ZCtsRXhGSVRkRTRvVGFlM1ROWktK?=
 =?utf-8?B?MFQ3ajRRV3ZtbWZVeHZTTmY4THU5TlVFTFFHUUt5NHdNeFcvOElJb09ZVUtl?=
 =?utf-8?B?TWRwZkRqaWZNeWM2ZjZYSXBOeTNmZGpHc2xEMitUL1N3Rkl2Zld0eEpPTW9h?=
 =?utf-8?B?VHd5dkErWm5wOGFsTGZVSGEzcGh3TjBhQytmWTQ3YXhjQUQ0dTNOSVZXUDFl?=
 =?utf-8?B?dXBUeUZmd00xZS9WWndoK0F4ZVNyRlExY3pVWGFnRFJ3bzRJczhDM1dUeDhP?=
 =?utf-8?B?ZVB1dTRCZTJnQUR1Z0FzMkpHc0Q5b1ovUDBVTmcyeWx2TzZnTkZwUzYvL2lp?=
 =?utf-8?B?Y0FwNmNISFZ6c1B3L1dOSUtjbDh1Ylp4ay82eHpjT2hMNEV2bjViZG5JWjFp?=
 =?utf-8?B?ZWoySSs3L3FEQmZqWHB4UmdHK2hlY2xPdkRvVnlDV0w2WHpaSGUwYitrcEFF?=
 =?utf-8?B?OUkxVE5RUHpEVnRoSEZuMnl1TTJWall4YjFtc2VCRHVkSHhUVzUwdE5MN3Y1?=
 =?utf-8?B?ZzZmZjBtZmoxT2wyNWN3QnhCM1JqM1VTaWxWZHdjN0Vmby9oU05LWE4weUYy?=
 =?utf-8?B?WnMzVW9Zb3RIT3A0UU5LVytpYXBSbDhtMTc4dzF5TnFyZHNIL0NhZnpTREk5?=
 =?utf-8?B?cFprM1VGeGphK24xYjI4Qnh5MkFEMDA0bFpNZzVUdDdVMWJZRktvNWpxd29M?=
 =?utf-8?B?QkZ2U3hicklhZ3NwaFFpRUF1Qk41UzdFRzJkbHFqckF5aXdZV0dlSkFuSFk5?=
 =?utf-8?B?VFA2bVlVZHhDdURxb056WjNkY1c0c1F6SDdJZnBvMHlmeWJ4ZE5yc1VKNXdN?=
 =?utf-8?B?dHZDeFYvQzhHTzgyMXlDK0g0aDRTbllaMWt4RmZjazc1ZVpFaVRsQ3B1T2xT?=
 =?utf-8?B?VWVXcXNsU1VHMko2d1BEK3JEMzBWaHk4TElFOGVvWXhSUHpvbWdFZE9DbSts?=
 =?utf-8?B?WnJiN1JaRWZ4d0M2NmFodWZ2R0paLzUxZDlkc0tMVENqUTNEQ3ZWSXBpck9S?=
 =?utf-8?B?eFBPNnBJR2lxRkVxU1ZkUFkxQk9vRnVOek8zMWQ3S2FMNDlCR1AvWTRFMTNq?=
 =?utf-8?B?bGw2M01CZ1YrRzBQQVVUVXR1NWxmSDZQNlA5NVJaY3owZ2lDY21GNlU0bXpB?=
 =?utf-8?B?bWthRjU5UUNZMEZnRmZIRjdFQitjZUxNZzdkRFdaeU54RVpSZ3grQzlXR0Zs?=
 =?utf-8?B?UE5adHRldysyZXdUSTBsUk50UTRFSEpwT0MzdFpjeDExTk1CMlNLZGpRT0c3?=
 =?utf-8?B?cUVkbXZneW8rTkpJUFgvVmU0TDZPYUI1MWlnc0hPT2hwa0FUSkhvK0x0eDUz?=
 =?utf-8?B?YTRKVWhSYy9HNnVOVmRkWGFWMmdqNk9pM2hNSGxEd01zUHkrNzdvOURNU3hF?=
 =?utf-8?B?dXhZMklScEtEeC9QaUVhK2YycjlsK3gzVk5VNk1tbGVQN3l0N2ROTytNSi9H?=
 =?utf-8?B?NzNGbk5RelMrNE9qYW1teWhIWFlTMGVYcXBmbnAyMk13Y1BybFR4TlBNU1pm?=
 =?utf-8?B?TjZOSWhrWERxOE1DOHY5bjg4VzBtWjMreFk0UmJONnk5aGl4djJmMmlxKzRw?=
 =?utf-8?B?aHBERWR2WkdKV0JQbkUxbXE0U21FM0E0RkNSRWppQVpLMFkvdEIxQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97625316-476f-4eb6-4450-08de95437062
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:50:01.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJF4q0tGgpzSc+Lea/JXV2p0YaXBijPmGtsOhSnAn8NTnB/VxnfiHF6q0+nxz0Zqoq9Irv9mfK/nmbS4LHrKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864

From: Peng Fan <peng.fan@nxp.com>

The PMCG is described as a child device of the SMMU in Devicetree and
its register space occupies a sub-region of the parent SMMU MMIO window.
That MMIO region is already requested by the arm-smmu-v3 driver during
SMMU probe.

Using devm_platform_get_and_ioremap_resource() or
devm_platform_ioremap_resource() for the PMCG would attempt to request
the same memory region again and fail with -EBUSY.

Switch to explicitly retrieving the PMCG memory resources and mapping
them with devm_ioremap(), avoiding double-requesting already owned SMMU
MMIO while preserving correct register offsets for both page 0 and the
optional relocated counter page.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 621f02a7f43be364e5c260fd97aa375f5e8e3404..1c9585ef2618397b59158aa18c21054ef672dc83 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -847,7 +847,7 @@ static void smmu_pmu_get_iidr(struct smmu_pmu *smmu_pmu)
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
-	struct resource *res_0;
+	struct resource *res_0, *res_1;
 	u32 cfgr, reg_size;
 	u64 ceid_64[2];
 	int irq, err;
@@ -877,7 +877,16 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
+	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_0)
+		return dev_err_probe(dev, -ENOENT, "missing PMCG page 0 MMIO resource\n");
+
+	/*
+	 * PMCG registers might be a sub-region of the parent SMMU MMIO window,
+	 * which is already requested by the SMMU driver. Do not call
+	 * devm_ioremap_resource() here to avoid double-requesting the region.
+	 */
+	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start, resource_size(res_0));
 	if (IS_ERR(smmu_pmu->reg_base))
 		return PTR_ERR(smmu_pmu->reg_base);
 
@@ -885,7 +894,11 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 
 	/* Determine if page 1 is present */
 	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
-		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
+		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res_1)
+			return dev_err_probe(dev, -ENOENT, "missing PMCG page 1 MMIO resource\n");
+
+		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start, resource_size(res_1));
 		if (IS_ERR(smmu_pmu->reloc_base))
 			return PTR_ERR(smmu_pmu->reloc_base);
 	} else {

-- 
2.37.1


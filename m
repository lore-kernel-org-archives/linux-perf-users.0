Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D84736E48B;
	Tue, 14 Apr 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152692; cv=fail; b=X/MoZe4P85L2sd/HtWJKzn43ph9OA9V9CmUqxHo0/WpZNvwxxUUdmtepd4i9A31rFajPb0Wyf2z/6EzBjDSNabKQaPVG9X5LcnEIb/NZL3HgrPiGLAY88COQjoii4lBYRCsZjMgqgtF337lz7y1N9Ja6HshoM4wb4kYc5Sd4uTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152692; c=relaxed/simple;
	bh=IfsQLPIK1wFWxxYF1EYeLHIFZpueZXC424aGYoxtAho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UxxTXibV5+Qt8+xHU3Jp2WTxJOn3isKBLo4uJ1Esz4Kwl9k6I67p/Vv/YAmIKy0KLwBREk8+jKR/IvhGKHJX8qjC8BjIUwCNtWkl2mpj8+/ZzF1ZMb5rQGLAuKHfQwpE7FZZidKsMdPZ7o7Gqbl4Aw87OpQ9bQsfggHKk31Gv0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=irbIvWk0; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="irbIvWk0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA5Z2SAU2oZASViuLhXsU2m1idpPMfb/icO95jGZt9lS8q8H6l43tfRlenPQbmXhPsDNc72Y8WSNjFi7OLoKvYyTI5mBbX4GfAPIuVMJX+S8/SPEazAVPxi1hJ/vd75Bl2rk/Xnfstgqf1XMPUCzwBi6PZq6joNI/JMdp44yQlwWcwGuQoKSaOgjwWQ0p4m6MKe3zgQvwp4/1ZDoClEahUIZ76jy0smIaYA0aEgo0C8IO9tQrJ39frL1/licWCdJ1FvDzmg7q31EtjWBRUuycGUwXi8Lg9RimcE2t10sMVUofUJHYi0q5Xl5H7bH9tNtoo7Q/DWGtcdKXWdl+Lto1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTSg/E5dWEBMouw/2txXF5He/FP3xbBtzi6zAJRDtL4=;
 b=JfVRyU04lFzD71WlNx/w5ex7f9D1B6NHfaW7QJAZQL3tj58pF2MdXOwKYHVIN7iW5s1zOSwnkwXs9kPa7Oz0/159jE/iEEty29U+aDdbwI5uF7CzFpn2b/rMCisRT0llYFoDRr3w8AGVM6IfKg1BnBPMtPGyz1bsljBA3wOUOxZDvd7dXjXMgVWmXVEGdfigRtQtefx3XuyMFj2I0YyLdAYFD6x0Uwz+WZG1i6O/mhCbmox5NFFZwJscS+sbXA01dd5ZwXM5D4B8+rzBmysfUpwtUIO9i8gRrRcMCyUnA0y1WIrTeiL9cMf9ZKS/2wJqaoCEvcCaQ1fihNyWY70K7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTSg/E5dWEBMouw/2txXF5He/FP3xbBtzi6zAJRDtL4=;
 b=irbIvWk0o4OOgJNnwdW9nY0Z0VM0LcLUJLj7ESVVdZJsQCueq/ozkniWozEzoM6C1qw+tNllCL3KSxj4GEoqUVsOEIbnWE0r3dZi0+cakuciQmDmAAUJUchHUPxwFE8HtaGdl9jTP/6Ga/7Yx/DICLEFutlFwt8CpyNTaDaT+XME+sZWu/VXvSacyrsuPF8jhiRAgy9nbF9H0zXOQoAQusCLrizTmhJGHFkRv63j/KfKMtHvMQMu7bzf70MusFgkAkbABfnkNHO/u7F1zkrkaQL2wNR5/Uq8cdnAs+scFs4uk6ri/MZaaKm5CXk2+pRMzTlP3VjqSyFnl7W0J+Cijw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMVPR04MB12649.eurprd04.prod.outlook.com (2603:10a6:20b:774::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:44:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 07:44:46 +0000
Date: Tue, 14 Apr 2026 15:47:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] arm-smmu-v3: Add PMCG child support and update PMU
 MMIO mapping
Message-ID: <ad3w/P1vA2uKsV/o@shlinux89>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
 <2c1a1694-9597-400d-b441-714225b5377b@arm.com>
 <adZcaEKm3vIYSy3N@shlinux89>
 <65629411-0e1c-4c9c-bc9f-6488097bd77f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65629411-0e1c-4c9c-bc9f-6488097bd77f@arm.com>
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AMVPR04MB12649:EE_
X-MS-Office365-Filtering-Correlation-Id: 1683ed50-8967-4135-8e5d-08de99f9b2c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|19092799006|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oWs7XtJ0SI2YO+k7/+ro3F67KqTtbjpdrpc3lK1UUm4bfJyfO54EDkD69gzMGqmlIkuNSEqvpY2PWmO1IByQzMzy1hboXicTyOXeouEDcGIMSpgf7CUOIbSiWJhLHcAJZSxj4YMmPsK8wAVKQa1FPHQy6GW8PE+hhr9sO4EeLGMXZbE8x0Kj2vJ5tQtkIJNr94vPnGkDr3aPs/STaEH+Jc9aO5EiRENQtV4HuezgYWQHT4mHq4LInSMHeZ/rJtO4tsPhYAR63P8yr1curQ4XNw4YKyHL6rSx+3xBKk8BjODFIaU08baTGECyX6zAnqQAwT6g6lbDgD656kdkvvwEihT/UzRw7T/k1Kj5tlmbSIRAVt4jW63wKnsaWl8w6hEUVGxX41uTxXqTxIkJZmqsZxk1e6pVdtpbC5IuuEYbHZcxiiDg+BaCLdDD4ScePZ22l6HUflpIhySkG7ty2KmrUm+XgrD+8HLfg2ENu0hKH1gnkdAqOrElZaPGjjlKKSPn7Kk3n0ybpZKdt0KPMuBYpyEQ5fGP75eN2K5OQh8q1yMG9X/2i+OQd+qP48Fdw8Ec0jICsQybj9ETQYzDuiHXBcj7EcS1sukXe2YUckD8DweMJASkh4ORlsTVF2p51+qugWQhBJqfwKROK7hJOgxj5FvyoEnmbdnG1SXcR5vgjxrndTex7RTWnWfbmO4kGi9mIzvOVphBokXnBddU78YN0vN/dgMaLFLORHaM5nlNy09zch6QUJ8nlYVEE2Pws9jyrJjcDYHoPkrNHDCRWCaE1Vd8ZwlXWGTe5sSNAtMSbN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?97op//zrB8gTAk2Id/77uSXmQYlNvus+Ls7Q+JcI8GsDloETaRhtP0sUlCBA?=
 =?us-ascii?Q?0YqmalC9A59Rj6RZciNng+otHJdTvs7j6pcHipY+b9abFf5yVwLp/waK1uXs?=
 =?us-ascii?Q?SvDqcs6ngB8fI6bW4JjkhUgUThWjIGfFLN7pOkhw1DK0wAgGItITyD/P2Y5t?=
 =?us-ascii?Q?w+nv4S1e/N3vB01Xxm8FacSloIUMgJInN7Y9iY8t4lkpkl1bom+VE6DhRdTh?=
 =?us-ascii?Q?8IMgLLMyUPuIdiDKbd/8p8g4qVZXJMMVABbUfm4DCPlvxaC1THD0QdU4GVLd?=
 =?us-ascii?Q?s/a4386Ny33uR8wQzWu6iaNF+xZba/rvN4WUHg4QY/R968pBRzMtZEOx86Nf?=
 =?us-ascii?Q?4OUsgez94UR3Ca2kTXlpOmhnhKlCxe/VHFhavwMWexJE8N7HfrVJn9UXZS1u?=
 =?us-ascii?Q?pt/qous82q/q9xuecXeB3qosEvzJd8djUzHMsK5Parvps+fm7HN3DYoDzSe6?=
 =?us-ascii?Q?T6lReZOhQwoccMh8nVILISlvkqKgpq0bbt1Qvh6j9MDKDshOds232Pgx6B58?=
 =?us-ascii?Q?L8uPL3dNMM8soHZ4urxYTuUJiN8udak+ApyU61qnw8iImFEFCggx+o9GRefx?=
 =?us-ascii?Q?TlavfdPvFp9DdcXW/mIdhbKYRyc1TRFSGLgCjhNfNW/Zt2IYypNxdexK5lwK?=
 =?us-ascii?Q?aMoESe/uUNdHxmW3mAErZzBrLakRnGgOnLalSNeiENuGlUssxaV5PbXOXU+i?=
 =?us-ascii?Q?dUne+nl750wci2seft1XAePl/R765AfN5nswx3UHZmkyCs1uykXeAhbSfhA5?=
 =?us-ascii?Q?SxIORkGP1PC7Ywe/8BbZ3QUZuPMHvcN6sAbzYVUwktty92Q6QEgkxzhKvbrZ?=
 =?us-ascii?Q?QpNuZ7UD6LHozCO4nP3fa50qblWsmBpVa0JXIUEK1bPhapfjc96WFMKoCB1T?=
 =?us-ascii?Q?rFnV7Q4sgXyxMEzIRP85rz8Ji1xyqMh/jFHChqmSdO2xA5EXDtBQxdo5txkf?=
 =?us-ascii?Q?iKmXsERM3MqmFIWlItrpaVTSW33Ihr2BNijwLbJ6yU/7XuZHn3V1pdVpPdhm?=
 =?us-ascii?Q?WMz6fmc+Rk80rgqqtt/mHk5rWvhQg3eiOwmGHaTwYmlury68BcYbyErjA29P?=
 =?us-ascii?Q?KCmld1wNLKCVpW+iiLIDnToAoN7K2ohcN32PLs3IcMJRcLcdvAfzQSZ/5EOg?=
 =?us-ascii?Q?h99c/M1Bksm1vNK8A80viYzNktasSxL/COb6fWXxxWOK7gqTlLVK+L4whjRW?=
 =?us-ascii?Q?32MrYAwC2mWnxHxFUq1BiAkkHtLIquHdBSUNp/C3fgYhBezUwhT2W93e9zhF?=
 =?us-ascii?Q?PSec3F7oyVtrANSsuI+pVnPlQFabNZL5aVPy0dM3RQhGTszKmSR1gAEzA2+5?=
 =?us-ascii?Q?cqII+xUg1WkcWaGANFCPRk033WlLosQralQj7ggt6sypNIutkEx9RVOfyoa6?=
 =?us-ascii?Q?cGwPFxfBKWqy17Km0yTbAE9QZJrzWyxoLKQcihuekxvFMJvPnUdKPu/12JCx?=
 =?us-ascii?Q?Ml3ag+QQZb1tbh/nOLin4RpyNxPt3B/e7exnTcWhC/ATKMrEpF+N9jsl/Ral?=
 =?us-ascii?Q?78d5UHQsIY8yU2x+VT6Pl4b/s7FGbMhS/cOYakin2UjOgyz72LNR278W/Pqy?=
 =?us-ascii?Q?/Aij6+12gawAq0u8yBkqkJe3njiFxqW0S5Fb0UWIWgFvIenjjJwVmkWl9KKx?=
 =?us-ascii?Q?xUNVekk9g9957Ej0kFm7k83sI74gQjqvXsETau2b8pJ8slOPeAmhYICz782M?=
 =?us-ascii?Q?tAOI9fKuqPUCWAd7gB/dPmKm/zoSzobBeQoMKaReX6FNWz1OOv4Rk6MjqPZR?=
 =?us-ascii?Q?/4TfCjzB/g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1683ed50-8967-4135-8e5d-08de99f9b2c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 07:44:46.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeyxDY7aJjzVTZVdJ4dOONKoXQ8RSTsXLfGvxBLejJbruZ02ZWXGfbotYArKo2psP06iIpdS9c8C/XGmDxApKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR04MB12649

Hi Robin,

On Fri, Apr 10, 2026 at 01:07:29PM +0100, Robin Murphy wrote:
>On 08/04/2026 2:47 pm, Peng Fan wrote:
>> On Wed, Apr 08, 2026 at 12:15:31PM +0100, Robin Murphy wrote:
>> > On 2026-04-08 8:51 am, Peng Fan (OSS) wrote:
>> > > This patch series adds proper support for describing and probing the
>> > > Arm SMMU v3 PMCG (Performance Monitor Control Group) as a child node of
>> > > the SMMU in Devicetree, and updates the relevant drivers accordingly.
>> > > 
>> > > The SMMU v3 architecture allows an optional PMCG block, typically
>> > > associated with TCUs, to be implemented within the SMMU register
>> > > address space. For example, mmu700 PMCG is at the offset 0x2000 of the
>> > > TCU page 0.
>> > 
>> > But what's wrong with the existing binding? Especially given that it even has
>> > an upstream user already:
>> > 
>> > https://git.kernel.org/torvalds/c/aef9703dcbf8
>> > 
>> > > Patch 1 updates the SMMU v3 Devicetree binding to allow PMCG child nodes,
>> > > referencing the existing arm,smmu-v3-pmcg binding.
>> > > 
>> > > Patch 2 updates the arm-smmu-v3 driver to populate platform devices for
>> > > child nodes described in DT once the SMMU probe succeeds.
>> > > 
>> > > Patch 3 updates the SMMUv3 PMU driver to correctly handle MMIO mapping when
>> > > PMCG is described as a child node. The PMCG registers occupy a sub-region
>> > > of the parent SMMU MMIO window, which is already requested by the SMMU
>> > 
>> > That has not been the case since 52f3fab0067d ("iommu/arm-smmu-v3: Don't
>> > reserve implementation defined register space") nearly 6 years ago, where the
>> > whole purpose was to support Arm's PMCG implementation properly. What kernel
>> > is this based on?
>> 
>> Seems I am wrong. I thought PMCG is in page 0, so there were resource
>> conflicts. I just retest without this patchset, all goes well.
>> 
>> But from dt perspective, should the TCU PMCG node be child node of
>> SMMU node?
>
>No. PMCGs can be used entirely independently of the SMMU itself, and while
>most of the events do relate to SMMU translation and thus aren't necessarily
>meaningful if it's not in use, there are still some which can be useful for
>basic traffic counting, monitoring GPT/translation activity from _other_
>security states (if observation is delegated to Non-Secure) and possibly
>other things, even if the "main" Non-Secure SMMU interface isn't advertised
>at all. It would be unreasonable to require the SMMU node to be present and
>enabled *and* have a driver to populate PMCGs, to monitor events which are
>outside the scope of that driver.

Thanks for explaining this in detail.

Just have one more question, we are using mmu-700, but MMU-700 implementation
defined TCU and TBU events are not supported.

Should we introduce a compatible string saying "arm,mmu700-tcu-pmcg" or
"arm,mmu700-tbu-pmcg"? TBH, I have not checked MMU600(AE) or else.

Thanks,
Peng

>
>Thanks,
>Robin.
>

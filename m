Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4091EE7DC;
	Fri, 15 Aug 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275210; cv=fail; b=GobJZ6JjRlbF56e58fs54VTNRbtpvcnnF6xjiM4m+ypZEQ9DSH94cQZ4bPhFsJAhqRQj6zzkXP/uqRuD8FaxqN1PuAmkYER2TGsGAQA1igIOlz28tb0v5pB3iNOingjwrYQ20Yxa53b6NZLEt+Jkq+wIIKaCwLzJFlcgEUSiB/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275210; c=relaxed/simple;
	bh=/yHtWjxgHwM/QkIhbAOKKbrj0LbdoUlKFaknk3zPJhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UKCPURnEHn5RTkz8sioGGuCaJtD6YQWlYqmiPPKnQJWT0wn40Fn1mBZcfbpKOI5AnraBboarU6mL9H7FS8Gkh2a6Eu+irW/dA+E8SQFmAiueH2iACpVsDfowZs4SBK0BN4uUHPvXIDfRHPyl6Kyi2C8ccx59o4uTb6mWymQ3cgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GunOLsdb; arc=fail smtp.client-ip=52.101.69.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GunOLsdb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2LEnmF3swPyk2CfUh7NspDjhh6hZYlr7bpy5jQEVQ/WTZ4KHubDaFUkN1noumfO+sAxJBriRumbEznZT7nRH8RHIuvxzjfFYgEbiOEDshJrcUGIhWDqXf1haiBHzESM/G9JICFkTvNVKxK5CouCF42ugUT+oF5qr6h/vUokmmqQznVcBwlLcP15QJ4z/pd18Ihe8vvSqoI9CkAf3LIR2uJQSTt3+O1hEWqLqd3BHXpxQLXsd9PNINdY9Qtaa46gJ65QPZ9pVTlmzkWRUAHQi23fYwU2wCan4IwyuFC5FFPGPACF+QITUU8bIrtA50ZJKwOZ290sDi273I8I2DSV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLH27Fe0nZURER31LpLcRKXI/0+aPK2SQSbyZEv2Sb8=;
 b=HjZfPjjS/15vB+rBIlyehgkgQGAtQ85FODavcrWqYXvxGyy55BrfduI3ZP4en7SHJQqhkZAuGYzNeLLO26YttEN376FM/jpbfYLhLtCDXQJXDw65WX0/W7UtGNR738M5yZ+h+jYgIvy7Rsod42vD4WovSkYAQLE98MhP2cixsmOF47FySMW6ciirydFDVVG15irZWaLmKbP05mKZQp8ohp7fa41TkzK12cFLS8h/sCQkYp/VvDQ20smhkQcAJIN9Pow4A/mUWSVlx6+F+M2FZ5il2DWNKPMQ6ZfZB3fFX9EPi6thlZazVrD+LBiRnECQZwsMD9y6MVD5BoXVtIA++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLH27Fe0nZURER31LpLcRKXI/0+aPK2SQSbyZEv2Sb8=;
 b=GunOLsdbt8bm9a4zryJP8if0LNGiNob0ogCHjsUcEUK2/5VJOJtdBqIVH1kALLaRs9396VWvMRANLt7Sm4uIfNa5Dzs+KgILeN+NjX5RzdXnnEjQWOpy8+MthxOS8tblj6Bg7FUh3kEfwnibPCeTItg1mzO0PcuR2lATKWLElLhWi22RynsK9/bvwRzY3sS6Pu4nZgTXtNRi8QmPKrIxA5dBAE6wuu79ggVYD3f79+gLZtPoPLAg+Wdt/VjlMJXcAC0tzmvsK3eNmyxtTUSYsrru7RugOck+7tebKToPl0MDNC5HxcBnXM6t2JhOcDY2EYzhtiEjgIT+PsfR//4B1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:26:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:26:43 +0000
Date: Fri, 15 Aug 2025 12:26:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: perf: fsl-imx-ddr: Add i.MX94 compatible
Message-ID: <aJ9ftYVhcuUsKoa3@lizhi-Precision-Tower-5810>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
 <20250815-imx94-ddr-pmu-v1-1-edb22be0b997@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx94-ddr-pmu-v1-1-edb22be0b997@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: c551c1e8-c29b-4786-c1ca-08dddc18854e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ka71OLgdDEHg9/dHldabqaxZATmABihsLFo22VcGMZ5JZTRF992t/W9bgcZ?=
 =?us-ascii?Q?ctFfL52L6MLxyImfVpIzRa2JrjKyT96/vnxUJ2OBbGTfK41uGFgKD54J8f5n?=
 =?us-ascii?Q?Hhqu3zw9obKSo9J98+UGNCdmxQncOie+NVyvEXyDO37G5VPa/Ko0K4/nnJRM?=
 =?us-ascii?Q?qGnT46ldY6v0F5p+7/fSj+LCy1vetmqR1Gp8sJRSr6eNCmLD2azJzcX6NaD8?=
 =?us-ascii?Q?XDaHQ1OGHmPM1FwCV+5exEpZxTLbebrkEodklv/R80MJVePcfDk3AyaCCIf/?=
 =?us-ascii?Q?AO2rSHa/OHS4U+5jAmQYab45wYhECseOnJCN6nUFxPRBsZ31/JHaGs7Vxele?=
 =?us-ascii?Q?43DKDxXmyEaPh0Kk3p9neMHFU7UHsUtBO2L0E5CE8bFeQ771Al6z4IoFUal1?=
 =?us-ascii?Q?9xgU17CZLKOPVNlLGs2yy8SvE6eQhM9XvnCkXifRIgDGseQTq48P+i1v+SFS?=
 =?us-ascii?Q?o9ukUni7/I4NFADqmavgAclZJj9+Mkq9CIDzlg/l/fRgYXazzEtT55YlNqvv?=
 =?us-ascii?Q?UCDjIrEyEFfRgtUoq1WH3j+7ibFPmPTeJZdPbvRBpGL4ZJQ5o4Kiu+6jRjBy?=
 =?us-ascii?Q?o+zDoiyMMQqUrezV2U83Ys03dGOm68T9c+/oMkZLWoSPeCP6BHloDa1Mfb6n?=
 =?us-ascii?Q?9SzUgV/uJs1nwg+sBHxThfRRfh34v+DUkaMBWqRve1P0ImnQSBuqiLOLqHRW?=
 =?us-ascii?Q?R/9gub5lKYdLo0faWGqsaOoa8T4NnFPg7/ORLOca47N/tGnWgL5o8QsBxHvY?=
 =?us-ascii?Q?lyzArJAyUlWZ+OcTMPoRcaSDQqqT0F8FQhqkd8XwSvxqj0EU+zw4lhbeTtdG?=
 =?us-ascii?Q?xKbpltWselzPS4PHFge45vg4MnKiSxUXbXW3v4X7pEqvWmEVOs90YXdXE256?=
 =?us-ascii?Q?3Kk2sAvFTpOBpJbWU8i/BC16IvcrQBZSz/JSpTuAn4UIwzVAIbo/EicYmXhR?=
 =?us-ascii?Q?No1Z7J4DMt3GOPtqKokInuEmpx0ZkzWbjXHViRDtRFdvlkMnyoEh/dv4Qcue?=
 =?us-ascii?Q?otbfvMVxlYKbGKJxvyTUGgEGfTHYqR495xd6SDDi951OdREWEqXW07VPkA5/?=
 =?us-ascii?Q?6+iyhnmkQPvmzwu1H8eziMDKupmxapmvOtXKxiLGKiKHdwjwbrUVrxwjrjiu?=
 =?us-ascii?Q?0TsfdBMdbvtZGpiG4RQ/BWPQoDxgLVr4iJ0eCRwYsYUeOX0JxZIxBhH65evc?=
 =?us-ascii?Q?b24u4i4Vb4GizTLpbl2pVPaLY3v35OvfDHEZN8B3hn40B96aN8nkXoZra8US?=
 =?us-ascii?Q?coJ6SsmsUQYlUUwjYExJUPu2rVfvGEyD/KKcl+38UyCDmyA5z0iN6AldfP4r?=
 =?us-ascii?Q?DmDSGFnICcdMBw4hic6rNYTKEtsIeBqx3jwvOJyzMwVl9u/u2ouImcU+i7Cc?=
 =?us-ascii?Q?/ZfWe9jZZ5k6KV5lSuFP+29d8iaHraj3pZ22CYMughk8ekCdPOF4444Vm87b?=
 =?us-ascii?Q?HuJM34hv2usNDmOKn4wp4wUuw5AvMGRswNIV8U8zZUIJ+GSfRN2uZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O3a+hTE2BjxYc6zcbkB+8WaY05BNwToxFLIPLWmul/0Gd/+UwpGtD12clEf5?=
 =?us-ascii?Q?2lqjbofhy8OtulmZxhV+FW/xFwaC6sUu4S/IY1nn8R49J9itIhRiF0480PJq?=
 =?us-ascii?Q?kbwhlqTPiOjLlk1NvjVDN5Z3rF1NIgwT9hN8LKIF6Hvz//llz9LM/7VoD0MB?=
 =?us-ascii?Q?+IlhQ34a2rw/U1JYwvjHWthTXnw34lqKnQoRySmuTPMt4oioqUO8wrWQh34S?=
 =?us-ascii?Q?ES78ymgpaKLxs2y4KjO/VphXs/j0ArwSX2DdJRUjf3Ly8pzbpFscnkBTCFjO?=
 =?us-ascii?Q?V5XVS9XX1n8DQ6cknSkjqw1zrHQP97zKVTG+PtO8CVlbGQGYtQFcoD4SBf3Y?=
 =?us-ascii?Q?9S2M6tVO79asExgXiOIEd4lVY39lEoij2Lpx6ni9HYtihrR30+evfl9H0AcR?=
 =?us-ascii?Q?DqJT9t2owVwM69GkE+e0xBpM95BCYOlhUDgmyYUk7P+qNEUtjLtorKp3rJGf?=
 =?us-ascii?Q?ez/KcgqHS0hHX2nUg+BIXrOLd7Y00MalH98ch1oS4VcpmlE99EL/Bxp8EjXi?=
 =?us-ascii?Q?yslwmxnKJbhaypn/UrM3V0sg7VSK5msObRyDtZ2zZKN9wACAjRiPaNBwpuyE?=
 =?us-ascii?Q?oVw0nlRIgx+s7dQnMowW7KAZw6f3R05SSWOkLrzVyLN8gvmXh6vDZeUSPH5q?=
 =?us-ascii?Q?/CVtqWCfDMxTSZAWHeLQF8y0HMesAKmkZNETnDuZiXV9ux5HKiUTrlKR74pQ?=
 =?us-ascii?Q?8f9Ar+KwHng6+kNMJRhJhljCzapLhVeOt8DiAtFysmofCCfmmok3inph4xrc?=
 =?us-ascii?Q?VZs0sCKqPMND785uofeHU9BEFn0uBxh3l2YXJGYoWjtnz9NeY91TF/KJWNxG?=
 =?us-ascii?Q?SkxLSE+OSoO9rVUYcEhGIx9J5A6HrI4pquFDzaWt9O1pNDpelgZP8ZbAgNEl?=
 =?us-ascii?Q?Ktj0OrQSMNfB9IBKIeOfm5ISvndbMoThi5EYZoKB0sHTtsgVvVy7o2ws4OY/?=
 =?us-ascii?Q?XzvABGrpv5jb4TJcqmpyBDXeBVyjcyZloPI7UkeJxIqh1gUkvDC0ZDtuynDu?=
 =?us-ascii?Q?J+3NWd8Rtdud3DZyXfYS6KfGsBDh15ExlGlXZUdruR5G2cgAkgidGzjeUpyy?=
 =?us-ascii?Q?zctpEHSwSwHLNuM4HZlcUHsjrN7nJmF2T4e3O4nXFa8S1u4KHHDwgrKvMxUz?=
 =?us-ascii?Q?ItAcewnkcbKQrC1Sub7n7eMEfGe0X/axaFLhlBxCcV3Nwmj3NLJrtH1jSgY3?=
 =?us-ascii?Q?KQhwsCIpLZBR55pfKe0KZsYs7jsA7W0IRHcsjtggOnVtl+S4jdvHK1hh/75B?=
 =?us-ascii?Q?GY4TFYSKKhFM/PxX62pqR8/7uQomvV7+N0oIyR+Od6O2gNo6SicqAZ+UpdSE?=
 =?us-ascii?Q?ax7wm/sXrMKmg+VKgf+QTnWNfz8siZXa0RTdYm2SkENawMF19yLFGHA73li+?=
 =?us-ascii?Q?umBakBtprR/Mq+hZVjhdeEXz5/aBXJytndGGdF6R7DnJ6AumxOVFhFNtf1s0?=
 =?us-ascii?Q?SSq7e57XVbnNHvCqlwNyYzNeMxpECParkHSctYCuhzzXy8fEFoM0IVrkUEn4?=
 =?us-ascii?Q?FfodQd7FrS8XL/9GrHJtLETDP/vdBdD321em907nsuYQ6+v33gk7YCzFmoWf?=
 =?us-ascii?Q?Doe/DP5aFOQ26mbopPLNHV2ZRyvmlpGjt+PKLIlU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c551c1e8-c29b-4786-c1ca-08dddc18854e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:26:43.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ2xCTBuPMBacwAs4ifBclZPbcdBNvcEly7D4FgqY0J8+UR/sbt4w1AzfELdciVHHMSGzhTMzPtq7abc+XHbUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:36:27PM +0800, Xu Yang wrote:
> i.MX94 has a DDR Performance Monitor Unit which is compatible with i.MX93.
> This will add a compatible for i.MX94.

Add a compatible string fsl,imx94-ddr-pmu for i.MX94

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> index 8597ea625edba5d0e2a3373ae6cd45bb1ba351cc..d2e578d6b83b8847c7a0ca9d5aeb208a90e2fa6a 100644
> --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> @@ -33,6 +33,7 @@ properties:
>        - items:
>            - enum:
>                - fsl,imx91-ddr-pmu
> +              - fsl,imx94-ddr-pmu
>                - fsl,imx95-ddr-pmu
>            - const: fsl,imx93-ddr-pmu
>
>
> --
> 2.34.1
>

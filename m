Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CA2248BD;
	Fri, 15 Aug 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275275; cv=fail; b=i6CBoqEPN5csh1Q4tDWopCLiGzQGXVK9kH7yQXR+ES11mfCOBeYfz0Uvs2NC/vQblnpaxoUTVhD+ffu9NOIoaJFQAOjHowp/kdFfVKlzpSVENtXG1K6Kb7F+vLaVC2iN8dp/YaMg2iyQgkvP11otZAEK2xN21dVG+yxA+e7Zk/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275275; c=relaxed/simple;
	bh=wYPqs4uoP9yHflnHP0901+5Q8x+eB9MNjm9BvmzAl6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i0/cuxZgs/0Aft+DiU+kQz1AM5jcM+N862+Hk+2ZdcY/tLJyvDmSqfnusm4NfsiaY7BPiX/D3nz860uag+VFEnNSEoY4ThrOgiNAYAHGNCU/+bwXlUYYmysoc3eEfsdAXo0yyTjwfsSNkhTpPYuDRuaoOn1IM0w9Grl6mTojq/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/FNamT5; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/FNamT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZUuYuUzG2kKpFS82YoqeJ1HdwJpzr8QTiKG96JJxDlmyOrSzSlI9aFBWRWhk1nw4lntV2h80BgDXTbN7MYCATFnBnKFZMZBvQ1H/TNbRq899Eet2tpwwYi2MYM07QV/YA1pGldNYSSAaOEJmTrXvxq9Dp/we3m05dajDk1YeuNJFjEefSjvIdYjQWOqYv6KH8UzwIeDUlPsFSamDm7E4JoZJzXvZt0e2WijaXm2Pvh+/FY8bxGmQ9j0jijmbMhnlSqD3lwhz3NTkcCGPpG6AOu48cyezPi0tBTBL1IiJtlvqb5Y8U2O8MKH0bZeLwJ1Ukh00hGFpJxx42QvFr/aCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV84qMRnpDFcO3Dtqqaoj2gHpGi4Fx/pQeCWnrDAzsY=;
 b=B05+GkuYxrJ8pgLGlJ6YkP/SDg/+A10UeCfMgamj906q4ey+3/NWPrS1IkmgpkcoTw9065BKS+KGb3sWgCjdzsoI99S8p2X2jVt775NLME85bZH3B6qSMp10ATCA7796UrEAmks45XKjyDz2sncmi/OYrKH26vQG9JKqwOQS7f/B2wjXYTes21PzArTvDzoMUvB2DW/hDWzAcF/2WIbN7kBBV7b+aRCOdqVC2defz/317yG0iqU7V/FMNInCblwJ1U4jcJFb8aFo9ZCak+2yYZuAZzjGqaNYASdq4ayUU+tnJH0plxz9fzGQ5IwITXm+gOSuw6U4Cfzy5cne1Gr4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV84qMRnpDFcO3Dtqqaoj2gHpGi4Fx/pQeCWnrDAzsY=;
 b=c/FNamT58YNPT0b0FOgYAUwalW2ASADck+l+qn0dzqciGWI8fy/6HXScYxSmxElpficI5sLja1FX9ZDnG60SCkwKqE+Dy6NTRwfv4EB2NzQQOg0RXWnPVUksOHnaB1QESidfIgK+/UphcRb0EWsMtH7Y6mlQodeVHljpXKgmNt7GDFLCXN++xRn4eFxuqzQbQGFGSOgvYRkCFFm+O90+ceeXv3SGfEFfVJS6E94mRM55NaJzEtge42A63EUYhp1VuoSJUA/FtW0WfUXeaD51zNwI3xJtSp2vYGH+mYxxuBh6FdL1URrDpzWvC5QVfrgln/wrBWQYld+eXwowlnQOjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:27:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:27:50 +0000
Date: Fri, 15 Aug 2025 12:27:39 -0400
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
Subject: Re: [PATCH 2/5] perf: imx_perf: add support for i.MX94 platform
Message-ID: <aJ9f+4CCbXaYCtEe@lizhi-Precision-Tower-5810>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
 <20250815-imx94-ddr-pmu-v1-2-edb22be0b997@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx94-ddr-pmu-v1-2-edb22be0b997@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7fd171-87dd-4968-1ea1-08dddc18ad46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/TTcX5N5tbMxlZd85HgJhvgEXn5D6zrToxRXqZvRSG26bCirDI0jZYvZ4Ra?=
 =?us-ascii?Q?E7UkVuEeVfBMQuXk/P0cPUlz29Vm76yQ3IdfJyAoqabJ5MeZilwODTKbZCPS?=
 =?us-ascii?Q?low9NmDH2qabVM448vN/ROt1/ldIX0tOIcUJiRjwo3JeZ3DhygjOmVneK8Vr?=
 =?us-ascii?Q?G9ZtBmtFDdMDmQ1F7Vb06WpbvDo0igqQOalFnl1DkIRqZetFpDCmJRhUl2sI?=
 =?us-ascii?Q?rOTlO72XLkN/ixrT2lrkRjDVEhdKOmnPO3qkJSS/XvAS7OtjeVy49iLil3Dn?=
 =?us-ascii?Q?5YdeD4sOkTZA6IfAkIOwMDjZlNLsZdMsSNbdGAz7u9+UdOtGagaUadDvvBhD?=
 =?us-ascii?Q?+e2IjUMe1Tjq9f1s6sPtsnogvSldwtKVQJ+g/A+qryHWGQIaHAahG5YqY8tz?=
 =?us-ascii?Q?130LhlT7/GojxgVOxrUp65L0yOqXH8YbTPhuc+GUtCMf0qla4gzR9QY/AuGD?=
 =?us-ascii?Q?M7QARuM8NMt5ns/wwr1EzvtI+C0dj9rsQCSKeD+VoRMtx6WXZ6TQBO8wRLRa?=
 =?us-ascii?Q?TEdJO5l6frW/D+H2L907vVOnGW1ongm4EGoaKTs98gM93coZwuDYf4ReDANE?=
 =?us-ascii?Q?/oUnOgS52byiY8EhE+fVZK9lhM51FOAkAz2M5I62lSxKJR46LfF6usS1ybhR?=
 =?us-ascii?Q?U5GR063sB2K3AtEvTWI5W1apIpCdQLUqb5o5wExRnQ23TGBXDEWWS19cNrHq?=
 =?us-ascii?Q?NFGKBjhUhkraBhR2sHQw6Q6GJuAaO7K1JPQZSNR6DCkNmJFFJtmMA3F+FLxh?=
 =?us-ascii?Q?jgZ7YSqT8ICz9yUH5NVLNYLafW7HhqWuCil7g/md/b0QUkyEh2h07pPFcwJo?=
 =?us-ascii?Q?kcHykwZ9CvNVjGUGrwoxNdA2MYzyYJk0BPgI2v9J81bWawYXrxUdw+GH7+cc?=
 =?us-ascii?Q?21W5pLmnuYtVT4untzv/u5Hwzzxe2vjnNG9+FNauIWn28JNR6O0M3KHuQHIC?=
 =?us-ascii?Q?91DWhcryzU4Vg71XeYMDliP7EAC+A3H/m2P3vMnAbvNjZvbfUWXvXEimUD7y?=
 =?us-ascii?Q?+DOgNvD1MV7UV1ek6JTZdReN18mLEQbKL6gV8tAbtZm+ToZ3iYR9doEfX/HL?=
 =?us-ascii?Q?dxtp78jWIk6DMG3xWiRv+x/WsClHSsAPKResVXaHj9gkilAqBHp3AJVmI6Bv?=
 =?us-ascii?Q?O98g3AzVLFr9w5xT9SDh9oeHAWwd/sric3OegTQoETT1/fL7UiD4fJgpV2m2?=
 =?us-ascii?Q?Aefiw2Y5iTN5GL6ih6IbtEQM/WY0DAMRLf9NcqO5cJ9yIeZOtQqxF7x3ZfD0?=
 =?us-ascii?Q?nHJeamG2QcB92Bs86WmfwWogBpA9MiERBXzgqwhSmvnQZjRmcsVpGiC8TOEC?=
 =?us-ascii?Q?7cMqlr8mNVHDDGh5iSTPvqplsjwICvWe1JQ8/CqNlkxryOIm84/ZslV9h7/q?=
 =?us-ascii?Q?q4Acp7qG3B3jTVYEASP8Z4hAb3e/cH3iR+kVNEQ9EJCLV1yjrl8BPHsK1VQi?=
 =?us-ascii?Q?waWKWAQCZxsTyrIyT0mJ4LTSb5+QSEBdf/xLltla96TAS1Y6lQoWgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2PUqWdHkQOgHtJ6u7A+/YrZnHpBTWBaojidGvHOL9+Lm6FXfa2L+/VqYoM9d?=
 =?us-ascii?Q?7xfXoc6OFFd/nen/MaYX7uaWcGkZ5inOiLsS86fvomfZyp2ZZW/E7EhRo5Zj?=
 =?us-ascii?Q?Kt3N61f7lgqEz59oHT544FPb2dNhVyoqMgNFXi1RUpNizVlBpMEEVQa7e/qT?=
 =?us-ascii?Q?O08MNnKr1tm3eGTBSYmyNLqFMd3fR17v6AxYMmRefbJxXzYmjgIBfd5Xk2dI?=
 =?us-ascii?Q?uL881Xig1wNXBzX1AeQuZPnkja7TLEHi6WO4XLPj6DmAouYm5z+LjHILyHKr?=
 =?us-ascii?Q?Qw3LD6yjKuqHMVgFOHVexy4Sp9Rq4yFKpi3IYcWxuMoxBUMEvCxzgr3j72Gz?=
 =?us-ascii?Q?TymdDNpFdbRz+4MouoCKaN4drdJweFezKgah6laqscfz9X0kNCG4OW9o1WGJ?=
 =?us-ascii?Q?xhUWjDBQlEccgCTafBE6xucp+tjwgaaOIUZu7g48hskzXMBFi4g55RBd0Uk1?=
 =?us-ascii?Q?HGJYPzW9ewcdT/B1Zw0Fu86E/jCjgPUoKwCabnRneTRcjmMSb9ThNXVjHjsG?=
 =?us-ascii?Q?0UH/sQuygGYQq6V5bKYT0Ahalc3XuVys7xAnLv+b+hDEBwwSLhmxl7y73/Nu?=
 =?us-ascii?Q?KyN4H3BpmbUAe4XtkFSovbzJWg3eodfrKX+/rx1y7TrEirlP+kC3TwIcMuj9?=
 =?us-ascii?Q?W7cFgHDrcjuHRTfGpgIF3eskNVfFcainFj0LB6foBZ7sBlX0awk7Ys574aCG?=
 =?us-ascii?Q?iZN/1LrOXBf97txQ2yqMrUpnM2FTKOrATezR2ES/BaOO3mxZ3F3l7vmrBAbR?=
 =?us-ascii?Q?hM86jseSm482aDxmJdg/uUzF+SHcnpLyBVC5wl4NodyZHd3wmacoPooSJCHZ?=
 =?us-ascii?Q?vcGbmsK8YbEP9VZsARmSjKfDJwMQ2ls/kpr2cYaKxcqTH3s139rK7ILqXP5y?=
 =?us-ascii?Q?FEOaFLb7C+IeelxLbiPs7b5WKfXdSVRQuA21ecG7hkaIZJaBJcNrIVFJkrik?=
 =?us-ascii?Q?Cr7QENeDARy11/OOIgd/u9jd9f/pQ+b1ekPY90lgeFpMQGMTrmavY9Hk73/c?=
 =?us-ascii?Q?sWAB1GzJZFExPS3w86CjAO3yOBCRGaUpvXnJdAkJgA31i74vX0BGzLTxKgEd?=
 =?us-ascii?Q?BVAWAo0YRgjSaNywQPq9W4FbEsDWNj8ULxDUcaoFfovW20WQ1QhHhSgToWpj?=
 =?us-ascii?Q?/ooYVkAU0HV9K6bPH1V7JiysXc6CULkMxwXih96PLw8PTnXwCB2beC32Ibjx?=
 =?us-ascii?Q?OtgdtvGaAGtfk+AXBdPWVNWGkZEwKbHGp8CUN9V8+qkUdOwbP2VMngxN50ko?=
 =?us-ascii?Q?Ie+K5WlpXuc6qgveC439ke1TPEuntDTaa8BDHrDjb9ghc57DTtwwgNBeFFu/?=
 =?us-ascii?Q?0ATv9RcoQGU+lts1WqRcqGPvVyqRILfxekx5utGiXUSy1tl5YlfuOK1oIdYb?=
 =?us-ascii?Q?ZmWwt8mpZn5mSj/uwkRPEhcQa9uFOlufpR8CmZqm4blV2shc3Dso0YV/FrI+?=
 =?us-ascii?Q?8k5PWWq8ogZmnZeHQzqqDBO2uifFNwKfnYzNCbKIOUOO3IL1wrHPqbtimPe1?=
 =?us-ascii?Q?bco/ciG6FM+8sw/sJ2aVOUrIBQGle9YuvyrNcIPQGfTVQQa+57jLV4XtmBus?=
 =?us-ascii?Q?Tq04qPeOPBh9kYzZVFVqs9//u09kmGIRx3xQPJvw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7fd171-87dd-4968-1ea1-08dddc18ad46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:27:50.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th1uYawTt4E+Nq1O2fFYqcQxLJqs2GUX8h7AGRf3SKqP43gtd26Jw3WCUMvgKeWcZfp5ftJ6b3vj3yCgziFIOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:36:28PM +0800, Xu Yang wrote:
> This will add compatible and identifier for i.MX94 platform.

Add compatible string and related devtype for i.MX94 platform.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 267754fdf581469642c4485c28a2b00050fe785f..7050b48c04671759e8cad0e93359c088a2bf342a 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -104,6 +104,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
>  	.filter_ver = DDR_PERF_AXI_FILTER_V1
>  };
>
> +static const struct imx_ddr_devtype_data imx94_devtype_data = {
> +	.identifier = "imx94",
> +	.filter_ver = DDR_PERF_AXI_FILTER_V2
> +};
> +
>  static const struct imx_ddr_devtype_data imx95_devtype_data = {
>  	.identifier = "imx95",
>  	.filter_ver = DDR_PERF_AXI_FILTER_V2
> @@ -122,6 +127,7 @@ static inline bool axi_filter_v2(struct ddr_pmu *pmu)
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
>  	{ .compatible = "fsl,imx91-ddr-pmu", .data = &imx91_devtype_data },
>  	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
> +	{ .compatible = "fsl,imx94-ddr-pmu", .data = &imx94_devtype_data },
>  	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
>  	{ /* sentinel */ }
>  };
>
> --
> 2.34.1
>

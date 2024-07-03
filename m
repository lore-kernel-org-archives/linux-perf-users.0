Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E73D0A9;
	Wed,  3 Jul 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992774; cv=fail; b=YpsNDX1PCgaD9dO2I+KbEqD7kQC2ecJE6FM1lLjLhf8IpJjYy0gbcP2A6H1a46HlkyqWkPQRBk9ZLlIYWg/hNQ8enMxfXAaPZvxGB5dbjPEGB+EwcNS4ATd2OWBJmV3JxVcGtQUd09tBhtMsCDxz1+1c8wPCEEHCOV6UqkJzZfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992774; c=relaxed/simple;
	bh=5rqs9R0bhJuq8X22wDNOWAQSuyYMib8kyD7PXnQPWh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuU7xVV2xE9Z0Lr0IAYlNvH/HMRpON3umejI3yNrEQVSi6IrmWuM3d7XYLje56uCHghK56pCgm6sTOCtfVYZreSZeWdMgq/tBZJpfAH4Brr6dAr2G6S6+/TxVSksUzw/A5hZjuW0cxZCD+0fLdyHSNiXnssQcjPlLacdg3DbLI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ied2XUNp; arc=fail smtp.client-ip=40.107.241.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ied2XUNp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdMuCPFM82oqWktKw0eqOSPeE6PwO5pCOO8df6hKCdwT9cqpyyhSJ2V8E2Dw/qNgu6rva8YXlOKMFbToe30Lmuug0gLhXicA7flDcb4ll9IyiE9p8MW9XX4UXBQ8jwG9SHI+M2jEk5pLPZ1CqqfiR5BWA/ZP7mn919rG26N186EvuJ6WyOLv93LVaZQeKrkdnRo4Z1lsotlpTPMXbRLynMCNCRl5uMRDf3Fhn8iTQKSKBg55PrubBdXdskGUEJS8HHIrz6ZcIQ03MGYDifRQF2XiQbl3d5urxKI1CMTmA77Q6p+dKuHN5hzQOjmFJftVev+eZeNioOCVLPNDy0FWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVu70dZ+zwiz7dO2dl4mFagjvqd3XaTZv+q8lFufO7w=;
 b=Yir5Ca9P8kvUF8ixR9VDQq71sWQS3unSEFu3xcN5jEk7XLq9pB+REeHsSPyyyAYGNaDt/cfmQTMN2S6SBo0IKzOK7fCCSHwcfY+Edk2Pe7ardPplCBDTNvDmHCnicZVbD94a7b/rMzdkgEKp37GITvrnxZCoLnQz7ui7BWN9SFGOpdI+SPgSrsWzQeqsLUkb+6lYNszXIhLWqDSk88rE3mpMwh2kaYUjEQDPoFSh7eI57686FcLO2nWpzbYy1q4LSoJdprYJ7xkJ60nCvd9erubFn4L7cjnnu0+D3xuxlHYcoaG/AHFkeT2lLvgmHjQ6U2tzD0OVvEnxQybtbPGFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVu70dZ+zwiz7dO2dl4mFagjvqd3XaTZv+q8lFufO7w=;
 b=Ied2XUNpK1xfilQGe4wPyyS4asRH+GHjRjA52WvLA7mcTXavKXq+v8YOnDKOht+l5nj0cyoVB0pMfl1lizWYYONQiibS/4AjYUKPQ6bkElGu/I6nWSbN5APRjAEZ1ErKnormkdNexQTJLZuUi0gofjBzC7XANLFJ7to4RSCG5iE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 07:46:09 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 07:46:09 +0000
Date: Wed, 3 Jul 2024 15:44:08 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: acme@redhat.com, frank.li@nxp.com, will@kernel.org,
	mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com
Cc: mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v12 7/8] perf vendor events arm64:: Add i.MX93 DDR
 Performance Monitor metrics
Message-ID: <20240703074408.gbsabrdy7fvxfpuc@hippo>
References: <20240529080358.703784-1-xu.yang_2@nxp.com>
 <20240529080358.703784-7-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529080358.703784-7-xu.yang_2@nxp.com>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c90fdb-7341-4e62-989b-08dc9b3433f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lX9glFJFqNsJQq+XIMgJvaombx53lLEAF51nsRMO/bVXq0QQTfOiDaHYsflP?=
 =?us-ascii?Q?UeO11n+SiMaSiN8IijtA+F50HV/ccEik9SNon7NpSUssff0Lv3yiBokDs9Ef?=
 =?us-ascii?Q?V8UWOLqQwJYEWKC8qSHBJrD2//JVUfz1D8h/T1Cj7zcha10Kg/gPxbCSVSXF?=
 =?us-ascii?Q?Fkj4PCYT3QdqyvrS2ODv4GK1Ldgl6OqYgD8kzeXIw2yVraWhfRTGgrjSMSqO?=
 =?us-ascii?Q?AEpUtr0DkJRUrpH/J8yeFwFyq2/5Inw9kQz9ebvzwkvUmKYyNUwqlUiU1+zZ?=
 =?us-ascii?Q?2Us8hWva6OCWVpNKAg/KYeS/9oE7uWcJ0i/BnB9UeZ0WENPwOZDZ8adzL7+y?=
 =?us-ascii?Q?Jh1mUdhO8QCAM1bAGk4pjXqEFKW9inwnAcFlz4ZKGy8BTLLT4SbE8KEoUoVc?=
 =?us-ascii?Q?3uXv/AweAFvJzXEAtgJeR9m/5hR88WZLLzfAhyQjfle8O+ER/Tr4NKry5WRX?=
 =?us-ascii?Q?2mtLHU96yi9U9Q2uBNuSnutVtH3hitzpJ0snPImB+GCXzU6oOD9HJZ7PFDVa?=
 =?us-ascii?Q?R+zDBL5lGPj816/DTQ+nMw6Z0Im3rPVRJLfqh61X3Cdoce4MwQ7t+ItNri+h?=
 =?us-ascii?Q?q/e2Vq0iBEucr+5QStRQ3SpaMhyQmhCWdgOwpB7M7iVf8KXFR+v6D8djE+sk?=
 =?us-ascii?Q?hMoKUbmaOwdE+LU9+BuG5k072tdEOia4/oeC+Dv6JZRVDcG+lm6el0S15Jmy?=
 =?us-ascii?Q?LYxIK7Pbk9c5FfkHLbXPnmSBgx0It3Rl9F6yxQuAPQTBbtrR4cRdFXHxGi4n?=
 =?us-ascii?Q?JJ9k2mc/eS/bPdbNWTEglSkubcXtKwZLa5iNwbSQaUfIH4eBeZLJjoY0gUie?=
 =?us-ascii?Q?Meog0USCjSuvuZzgiB/QKTBqZ2/cuD21tWzttJww+lpLNHu3/7maPzfF6HnH?=
 =?us-ascii?Q?6DhySubI9tmwpEEWcrFiKxsCV/PnFV9Z0x8PM2mWeQ25hoogzkO4Qe4CVBsi?=
 =?us-ascii?Q?7I/p0NB7b6OtA+Jol7+ja78UtpOPstoj4ePPnjUdGjo866VHk0s+MPEmKvp0?=
 =?us-ascii?Q?IVkiPIEVIq8ELhjgjbXcMiiJlr6cCDpBsgeuNPNhHII9Wzgawq22pvhfFcWb?=
 =?us-ascii?Q?aFcpY5og9udz7LAhcYE/rwmnZ+hFi/56h5QDUcJ/jOb2fCj5UvTZN2DB595d?=
 =?us-ascii?Q?0thxbl1iPVmLTeHZ3wepFrwI3bcaCra+704gT5Nne6UKQ+ZAULRGZhR0c9Hi?=
 =?us-ascii?Q?672fIicAGxHgyZNynlxdP28Fv12wKa66DsvGpUax1wpyVAU3ovBcbJmxR1Ol?=
 =?us-ascii?Q?y6iNJgCqPgAP3QRfVsUe0LQH+YYWOhbAevWJlQFVjLoUSVtFIMQs/I273J2L?=
 =?us-ascii?Q?0DW1gw2LSN0Ye3nFJWZZickIoF1XGw9PJn0GFMKuPYt+gyTE6f8HNOyU+eHI?=
 =?us-ascii?Q?jEp0Jj+hMc7g7jDFvHpvIO8kg5s8jvX+6zikE45KHIoKhKBvjlPCjGuuk/ve?=
 =?us-ascii?Q?0c0CLYimTPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxxoIzlyEMYd0EIdNA33Q7N6LfohQG2lKV6GqwIDn4cMV1FkwuG+F0+L65xE?=
 =?us-ascii?Q?F+uPXDJ0HVoKT1nhYDWvG81+7k8V/CB71qgnKc1n5N5hkKJT2TdE8bAsHh2m?=
 =?us-ascii?Q?wmY8ejQlI9Ax+clXrQzuSq3pHLU9+ZSh9LnDfVvPD9B6W3G6zSN9RjMG9on+?=
 =?us-ascii?Q?Y6OJN/Iea2kEhErYwX2L3ziQ8KZVD0Ev9F6G6Md55BNYhlL+CSiboJrwY/Ul?=
 =?us-ascii?Q?PlAaDzb3o3dot8ty5volf85NrvtkYqo5KZ40YNCwQPJ/ZwoLIFYYe7qIf32H?=
 =?us-ascii?Q?SlWOQyrNjb4cER3eYqA0192J3Q2DcRIv/f2EdMAZeBI4hOM2fxoon2VtJpyg?=
 =?us-ascii?Q?WxUksYOApXFYjykuWnF/D30rwTfvvE1f72JVK9yC9wm9ORfrhXY6icGlGDoh?=
 =?us-ascii?Q?h2ZjCpkdXkmMZKG9CgpEgB4GpN9aFz1dhsnUHHX5ogSPT5zVRKGJDIxhqmF7?=
 =?us-ascii?Q?JLIVgiKLgGYdKSPXvkleBGwkO9N5+sixWbL/fQt2YmgixNqs7/eXPpkZQxeL?=
 =?us-ascii?Q?QynGiF0XAqmU4T19pP7EsBv1DgfeELj1XtRZWr8cFeK3hoHV1C//y5s74+2Q?=
 =?us-ascii?Q?fPu/Jpvj/Edfk7H75Ik3+i8nszwyVbVJOQvSt3CZ0D0cxMaD1tD3EsEbaxun?=
 =?us-ascii?Q?E8A1LLYMbkaRugcxYDIkfLNw5aLiXthDixiasu67QldTi6Zb0HLYyB6hzs1j?=
 =?us-ascii?Q?vXkGUBaPj28AtilvHDRGrrgx66Hr2JZVEdUzWv74CwaO6XkndyN8wQTG+N9u?=
 =?us-ascii?Q?alvQfBKR/4JgiLcdt65yoCMn28j2Ow4fmgvt5LD2+TPPEwc6am6FGmfNKG3o?=
 =?us-ascii?Q?SsV9i718xUrft3d1fxrJESiUpvrLx6nmOjkKD9srYlEsz8C3fwifcUEpb0pM?=
 =?us-ascii?Q?22emChgwtkCkZhvMqk2uuB117WzersJh9q+lYbWIWviTg2iJsO0O+H44LxH+?=
 =?us-ascii?Q?WCDDRod+3UnUhRLUrDWu5qG/XC2BZmBsneRCn5gg9zsRdlEFI6+3LEwaFzFl?=
 =?us-ascii?Q?DNxdQeWni6/TjyOGD5UFc4MZ/G/iWZAfHMXX6+64nZrz1xiw5EbJwTWPI0O1?=
 =?us-ascii?Q?hrcN2hhKht7s51ZXiy4kGQ2FqLTtu3Uqu/JaF8UZejHFFkk1T0VfyHnIUCCE?=
 =?us-ascii?Q?AmZGaPHVwisvrnqq5iz76tA97A6kmLKO8i3iJhsxbETdlc3j42FmhGLHtbme?=
 =?us-ascii?Q?f4jAtppiZOtt+20V+oRwrN2VVNL8y/pFZ9v0Y8QDQZALJSLPhYMbzNsjz8r1?=
 =?us-ascii?Q?TfwlTxlghwzEYK/eDhVEUcrAvkZ+yTB/kmjt1/f6g+Qtnz3HFn/qwzBHqiTw?=
 =?us-ascii?Q?6cCPDr7DFwIWwzWb2ZxIi1o9wgB++yirNq96n7Lu6bokwP6sOud8GOvMopms?=
 =?us-ascii?Q?NzDC4kadWuyR9ysQVDsZ8yZOWQWw06b+g8GB9r66qHPExd40JVJqcMrzLSSv?=
 =?us-ascii?Q?gq4gdejWnLgt1UvI80w0OiEqjw8Lt5DAyTSiFnxbLs56XFMKVDH5v98IQnSk?=
 =?us-ascii?Q?uLodicUXstQcC/YhfDGC9BszfBsgb5AovIgdvLUjGcVYuwlKZjXDl9e8Hd21?=
 =?us-ascii?Q?AhFulXO0Pv8q9qsqMuGb8nBT2yqz9HG9QpTlXRpV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c90fdb-7341-4e62-989b-08dc9b3433f4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:46:09.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMxxX43AhuTmmHP+fIKho/QP7sKwHBr8LxD/1IiWurPgQOCCdVeFENOqoV5lDJ+m24O9vcxJDjpYqceXdC6kew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

+Arnaldo

Hi Arnaldo,

On Wed, May 29, 2024 at 04:03:57PM +0800, Xu Yang wrote:
> Add JSON metrics for i.MX93 DDR Performance Monitor.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Could you please apply patch 7/8 and 8/8 to tools/perf? They have already
been reviewed. 

Many thanks in advance!

Thanks,
Xu Yang

> 
> ---
> Changes in v7:
>  - new patch
> Changes in v8:
>  - no changes
> Changes in v9:
>  - add Rb tag
> Changes in v10:
>  - no changes
> Changes in v11:
>  - no changes
> Changes in v12:
>  - no changes
> ---
>  .../arch/arm64/freescale/imx93/sys/ddrc.json  |  9 +++++++
>  .../arm64/freescale/imx93/sys/metrics.json    | 26 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
> new file mode 100644
> index 000000000000..eeeae4d49fce
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
> @@ -0,0 +1,9 @@
> +[
> +   {
> +           "BriefDescription": "ddr cycles event",
> +           "EventCode": "0x00",
> +           "EventName": "imx93_ddr.cycles",
> +           "Unit": "imx9_ddr",
> +           "Compat": "imx93"
> +   }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
> new file mode 100644
> index 000000000000..4d2454ca1259
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
> @@ -0,0 +1,26 @@
> +[
> +   {
> +	    "BriefDescription": "bandwidth usage for lpddr4x evk board",
> +	    "MetricName": "imx93_bandwidth_usage.lpddr4x",
> +	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (3733 * 1000000 * 2)",
> +	    "ScaleUnit": "1e2%",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx93"
> +   },
> +   {
> +	    "BriefDescription": "bytes all masters read from ddr",
> +	    "MetricName": "imx93_ddr_read.all",
> +	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
> +	    "ScaleUnit": "9.765625e-4KB",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx93"
> +   },
> +   {
> +	    "BriefDescription": "bytes all masters write to ddr",
> +	    "MetricName": "imx93_ddr_write.all",
> +	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
> +	    "ScaleUnit": "9.765625e-4KB",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx93"
> +   }
> +]
> -- 
> 2.34.1
> 

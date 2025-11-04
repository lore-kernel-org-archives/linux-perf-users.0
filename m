Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290432BD03;
	Tue,  4 Nov 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238397; cv=fail; b=WW3UfhpfIlGFI7tLYp1Kfu7xOr2qwW+r78AZ+v3qowoh/7MEeUmQPEd0XYDgYlM67PSBWxjkOQDguYz7a2Kwcib+mxXMBw/OPF0RdVeb/nCnxb5AUueKkI+MReM1mRKZKxz5gpznEgy+UyQy6ZhevIdtdZ5ztzF3h94QqhQ29l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238397; c=relaxed/simple;
	bh=29nmZoi/XiLOmuZxNi1KoAR9dtHKNHsKZBVx97Tpla0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HiecRsaCHBfIHvcatY5AwVO0+rIxWoOW+aHdvmaOcX9uvMkDDo91cEiSg2vcYTj8UeFqrYQVBD8sO1CirlA8QglH6PD5zquD5nrDJH3GxrbS28kxRKrWD0bJeOwkpsSHCqlusAPfFvSygO7FP0pqK9TkFKQajsyrUfV0Iq80oNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OfTE9DS0; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OfTE9DS0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6+SAARATriZBG8gvUGmSJs2mDUeC8JUq3aSkGQCaR4fMxVzSzE0rS+YLm3oe5xfPJB/APcgqkXma/Qtc6WQArkekRNCw3/iguhIjwIGgXYiOk9M+1Ggyy93AMgLxPaZ2v56wApPKzfgyZ9c6SKnNmjBTE3vSPWp+Xga8m9tMvEIhDM02fsxeQeWhkBtfUiJknDKeKeeGnN4ElCiuMMOfqu5jmqKsb/pX0v6/PO27j53pT8uRqP0LZ9gka9Ulu26iFQTToWM7cr+xlu4MuNiOiRhO/05lHm0HCAbf8zEtEct/utYu2RN9gNbSu4aYr7xNf3Q4t+Iyx+RLYZbTkhwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACz1dhmQycq7qv7ROuyb/VjQaJwtouTfv7uA8eX3Qw4=;
 b=KH2+duD4YQpC+eHQIp2bBshUCV3OkRTH6nghJx4R7DzSB4LJA9Ugq0vXMUr9DUIzXSnM0KNxWK/rKA1SYWLxAtm0iXNGa1Hq+Pkx9Hr+U2ipUzuh8rcNMpuc5In2ajzo8jf3HrVJa90fMY02KupYf4RyVPKguf5p0umh//nhG1kNSoQAjTwHshEYxAHcm1aUYhstZJbPrR/hvToED+CGV8V3hecMuSrdm40eJ2oXDIMPpjrkB2usmiAksfu7bdo3RZKQSkYuitGhED0WjIblFOsUTgiMJJXWjdogEiQKDZUSlZ5POqyaq0AhFJxrImZjbeRKH4aSZNzca5So3cdk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACz1dhmQycq7qv7ROuyb/VjQaJwtouTfv7uA8eX3Qw4=;
 b=OfTE9DS0lwrLj8YlAd8rskmzBMaT6lJItSD10opaYJYd8SXWuhJCeitK0o/DDqa6xFdlE828RSWUn7tKCYLLNz0qDzuu4ziuL32p8Ad1ovbFo+5ghTICZQxoq+l0avynp2Giu53GDnwdQK/j5Ifjb2UV172k6xv9nNzdDFK7p1D4OLXHIjGkXukoMcoq66emR34M4YJTsS8+JvMDIqlkMtPeJbCvs8JfSOwv2dIKHMTvbt/LrpU14I51aLwreIhSEVOuKAh5KvicX/WWo+9N6KXknYpHePDEWH2SGj3tasgRv0nPxqNRc393cNPuaDBHrv1A0kmNSA+F52igfVZlXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PA4PR04MB7950.eurprd04.prod.outlook.com (2603:10a6:102:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:39:51 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 06:39:51 +0000
Date: Tue, 4 Nov 2025 14:33:08 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/5] perf vendor events arm64:: Add i.MX94 DDR
 Performance Monitor metrics
Message-ID: <wlziowwtfqbhzsltffm4l3pxntev3lgjan44wfixztnk3gw5d7@z2selm5eczsq>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
 <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
X-ClientProxiedBy: AS4P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::16) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|PA4PR04MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: c19e42e5-a6ab-467f-eb8f-08de1b6cf488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fEIYfGbBMHhTVhZP9v+FWy/T0X0aW5YEmIQQKItp5s/r8IAxmTePCY92QAyT?=
 =?us-ascii?Q?D7fhT2eYpgoxdCsclKStXp5LA0YhPcfCVlCuDOj2oAmuRmXV1IqZWHLJ49Ge?=
 =?us-ascii?Q?6kkdvaEl/1Y35BiI1YQDh2KeMnLLigcwJ0+Kau85rEaxwFYRc4OJkG5fJbjH?=
 =?us-ascii?Q?hU9ZP4CdonppwSKjxmycSzAHGhgz2UKfZXtiIV7lJujthZNh9O07G2YlnjDb?=
 =?us-ascii?Q?nW2LHqkDmNJ9CuL2qTBynVB5ZRv07Fsx2/28Oh6ZanstlbPC+ErYJQeQkjaX?=
 =?us-ascii?Q?yl3D0bdab0HRt/WdsnXSkd1H50YIRTgB9t+DE6oOso5tfCL0TH/CL1FvsTTB?=
 =?us-ascii?Q?b0Y6ceEMsDBi3BM1xPXFGAV6uF5chciqjMMp7tmxTcIq0MRStqvENS2yJ3kx?=
 =?us-ascii?Q?xVFJot59rQMhLerowv440W7tY3ivJFH6lSp3jPza02SQ5Kf+n5z4jt6J4FfS?=
 =?us-ascii?Q?8rWGCvCJQv0fp1iM/hYDbPn9syAt8i4wCqGqbANKamJ6+voTzKO8XfcT6YZy?=
 =?us-ascii?Q?55w/V21ctL1K9wNRMvQAE7fkQabpTKyg7p5/7FjC6lqto3Sr3sS1JKo9y25v?=
 =?us-ascii?Q?oyLGlXWwUXq8VLo36grc5raRW+HaNdNYxz9fwrSl1NpeK0aLw3ZkjHejVAVs?=
 =?us-ascii?Q?F9GI6H+OC3UhhQ2Ld/xwizEYXDPuJnXWkNf7OldTEZPZe9M0E/HRSN/CZWwT?=
 =?us-ascii?Q?rg1M04bDCARsAOZq1J/erqwVDuE1b54A/T1S0QutKRo1OMPPg3qRDYUFb4k1?=
 =?us-ascii?Q?QIW9AObugrFscOk7viIYuYWCvP3a+vmH6vPjoujdJDCAkvrR6BMTG8kYfU/8?=
 =?us-ascii?Q?nd2WX7FsAjOL9oVYsQYIrO9W6Nest1SRZxpX9Iq0PXJb5klNBuS2buGn+uWX?=
 =?us-ascii?Q?Y+1/I0ITfVwMPj8UVLZrTr3A9Nwb/GdQMAzEtOOJ1Ta46gaOEI6/GRrMBTqD?=
 =?us-ascii?Q?nEDrQkyXnO+D9l+qqYzWgYP7hYOsytCl2ujdepyg+mj71M5fbsuglXfQLmBP?=
 =?us-ascii?Q?9Te6gFkh4k9HDSenK/JoNL2NLtctpagb40QibLRL1wCVl3T0olP0TVXTiF4X?=
 =?us-ascii?Q?LIkKwGG5QRvqoH06VMc0Zor92IGWuqm4iKkAILT8f/l5c5/cX5oWz1bUOVWD?=
 =?us-ascii?Q?uRzdQUU2C+6b+neamXIUxs+4ce/LYLzS2B+MTifl4Kv2j8NP1HyLCJ4DVPpb?=
 =?us-ascii?Q?Yj+VEMBGtmcwTfF4G9pGCyg+cvPNznuUEo8H+NQteOTVcCxIxp9ID+C8vS++?=
 =?us-ascii?Q?W8vdUAOwesBsYmAMWAKQcMz7sjbz+aAfh/vCixZIFPmKbGKSX7p8S7TEabSN?=
 =?us-ascii?Q?4P+vf2AQXTn3jonJP6mWVDYyqP7IErctRFwZJEaymiW+oB6+vtl0ga0+QE5D?=
 =?us-ascii?Q?VTxlyS4Z3u6k4OvGqDUF2GtRGZm3I9AU1YnsLUq+WffH/x1NErn4rgWfsGCv?=
 =?us-ascii?Q?tEfnPJcBtNeLaoG+H8VelovVfmFtH1Epm6Hu4q6MILgwFoZsPXwai/pfPAGI?=
 =?us-ascii?Q?XlBRZE53uwY5EdBl+ZGPl3GVBOTHpTISRMTC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4dyZkkP1KRBzPWyJOIBMfq+DsSe3mDSShNcIZcqiqfDe2lPugzPvlqhlbQt1?=
 =?us-ascii?Q?MfepNOsxVfTRoDI9YCw9NRtRM7jfwntMQdKrRYBpKwgl9RDLw06cb6rAldnk?=
 =?us-ascii?Q?W27VAcaPgVqaTZfos60WfqxKRV/TSQlfOMcebmKe10OrvSbHnzzjCn/aSIJ4?=
 =?us-ascii?Q?MpyAe3xANwlny9e/zjnPUrOrF+VrkHsYuwYxIz3bbB6mzoIyHTfM9f6uAB6q?=
 =?us-ascii?Q?1Wij2mrIag5IlNvGVyjoxhd1FszIilKtB96cG1D7gjO1NlDr+tiCeJGO03Yl?=
 =?us-ascii?Q?QeX4BY561VeQqqUYV4if5jvPpfoR0GNhpCwUEZYHeEEz81oqnyORoU7NBIkC?=
 =?us-ascii?Q?1jfXanA/a8JqH4WFWVPysT1gw1VYbgY0Tb+rs674m0sk6fugnmRv0TYCmUGQ?=
 =?us-ascii?Q?+rCkfyzgQFdwGcNEse3iLNCQ3biU5osB7d7i9nCYiPBY/7D+amEQNZ3Jahn4?=
 =?us-ascii?Q?CI94mPflX7NIs+5GYCfghuzY8amDKubfUxvxqssTeP98Tcuo2NNxF0IrzVre?=
 =?us-ascii?Q?zJT/tlVpnftUR6vNSILcsvXksYngB/VxtsDdot1uo/CO+h1yIrMKlBQEFrL5?=
 =?us-ascii?Q?TGqh508LKoQuZ4QI+FigacrKGkTnz0D1bKtfYMuaJPioIF1blPMEZapxx+Ja?=
 =?us-ascii?Q?c126TdoAcTErjPI8KkBRddtzh7yOlVUQZqWAAZc8FGr2g5BfJYZNlg2hRvJv?=
 =?us-ascii?Q?AfUP0MhgsbtAbnPntPn6OW/QxlINWx3XUPJ0peRV3tjzc0+9+rQG0XzQm1da?=
 =?us-ascii?Q?YWjuk8BZsj9iVWjRmCfNKKw9UDfUQW37v3jSJKq+vjGhsykWP86NCHPG5tf9?=
 =?us-ascii?Q?6bBnsYVYL13quaAg8rW8sPdTLXRKTb9I2zvi2bLBesknF9VpKsrMnbM+lE9s?=
 =?us-ascii?Q?2f/9m3LKF2CaZ45wJk3SITpNTjDXD3cikEowhV03vpWpKnye7FuBtD4/U7JT?=
 =?us-ascii?Q?NFCK9schxiysWVXxfEbYJKsztG7u88lxHGcsW+42t2v3xl58NiLNlEJgNssy?=
 =?us-ascii?Q?T4QBbV2qVMq2o7tZmj7tDxGp39uIjT3n/ojAXkQKp9jL6Y6n+Q1Bvs4V3C8p?=
 =?us-ascii?Q?forGbtX1YEcoBsocHIP1HcshSQXFDlpd7fBVLzcLe6mgA8KiTlzotvokmT2T?=
 =?us-ascii?Q?t3wD9sGl9Vt5fMH/LpPDi1jMrWngQCx9enRrJen2Ob5NPyglSDVdqm4fb3/3?=
 =?us-ascii?Q?ZCAM/Mz3eZTU9P6wl0OHGEphSvqljYexhQiPgxd7kFa2SyG0xYp5TchPLikz?=
 =?us-ascii?Q?KCXkstoHTRmz1Tr8TBvUAtP3hEcmz25jIzvY+HEOH8kcX9fC3K8PeWdxG8Z6?=
 =?us-ascii?Q?Fu9lE8wnz5PAjomAOUvbXWtvX7mtA2tj0AwqR+v8mgPwabzjzwAFrgLGJbgo?=
 =?us-ascii?Q?2eqIitSOn23Fc9CkDUKA+v1tB6TbdLZ83spGnL0RCRxsEqsmiEwAsP3X/0vz?=
 =?us-ascii?Q?7qLhZ6jeSxnwZm9N+YodrniMIuoUZC5GMGkPqO1+6NoP/mDSdSFD0Oa1edFC?=
 =?us-ascii?Q?lCqgMYvlCSYUkJcrklc/WZ4MkT1lJ5doEFZlz7uF+xuBp8FFtChGklkc4aQo?=
 =?us-ascii?Q?sgvHRCeD/nceyVWWV+TdS0C3ISJePrNyxmaYeO3b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19e42e5-a6ab-467f-eb8f-08de1b6cf488
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:39:51.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNQDtx+3r73BmoloByxq33tzPH8Z2bdgjGjkJOvOMN3ErL4H4Rc9y2ykAruqrFRLDswUJR/ScbYJdfKs79JRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7950

Hi Namhyung,

Could you please take this one?

Thanks,
Xu Yang

On Thu, Aug 21, 2025 at 07:01:51PM +0800, Xu Yang wrote:
> Add JSON metrics for i.MX94 DDR Performance Monitor.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v2:
>  - add Rb tag
> ---
>  .../arch/arm64/freescale/imx94/sys/ddrc.json       |   9 +
>  .../arch/arm64/freescale/imx94/sys/metrics.json    | 450 +++++++++++++++++++++
>  2 files changed, 459 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> new file mode 100644
> index 0000000000000000000000000000000000000000..aa7b58721dc7e23dc9d9905a79e0c1778b7bbf11
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> @@ -0,0 +1,9 @@
> +[
> +   {
> +           "BriefDescription": "ddr cycles event",
> +           "EventCode": "0x00",
> +           "EventName": "imx94_ddr.cycles",
> +           "Unit": "imx9_ddr",
> +           "Compat": "imx94"
> +   }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> new file mode 100644
> index 0000000000000000000000000000000000000000..629f1f52761e2210ef43a9cbba175871817e1230
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> @@ -0,0 +1,450 @@
> +[
> +	{
> +		"BriefDescription": "bandwidth usage for lpddr5 evk board",
> +		"MetricName": "imx94_bandwidth_usage.lpddr5",
> +		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
> +		"ScaleUnit": "1e2%",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bandwidth usage for lpddr4 evk board",
> +		"MetricName": "imx94_bandwidth_usage.lpddr4",
> +		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
> +		"ScaleUnit": "1e2%",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of all masters read from ddr",
> +		"MetricName": "imx94_ddr_read.all",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of all masters write to ddr",
> +		"MetricName": "imx94_ddr_write.all",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of all a55 read from ddr",
> +		"MetricName": "imx94_ddr_read.a55_all",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of all a55 write from ddr",
> +		"MetricName": "imx94_ddr_write.a55_all",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 0 read from ddr",
> +		"MetricName": "imx94_ddr_read.a55_0",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 0 write to ddr",
> +		"MetricName": "imx94_ddr_write.a55_0",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 1 read from ddr",
> +		"MetricName": "imx94_ddr_read.a55_1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 1 write to ddr",
> +		"MetricName": "imx94_ddr_write.a55_1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 2 read from ddr",
> +		"MetricName": "imx94_ddr_read.a55_2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 2 write to ddr",
> +		"MetricName": "imx94_ddr_write.a55_2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 3 read from ddr",
> +		"MetricName": "imx94_ddr_read.a55_3",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of a55 core 3 write to ddr",
> +		"MetricName": "imx94_ddr_write.a55_3",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m7 core1 read from ddr",
> +		"MetricName": "imx94_ddr_read.m7_1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m7 core1 write to ddr",
> +		"MetricName": "imx94_ddr_write.m7_1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m33 core1 (in netc) read from ddr",
> +		"MetricName": "imx94_ddr_read.m33_1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m33 core1 (in netc) write to ddr",
> +		"MetricName": "imx94_ddr_write.m33_1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie2 read from ddr",
> +		"MetricName": "imx94_ddr_read.pcie2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie2 write to ddr",
> +		"MetricName": "imx94_ddr_write.pcie2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
> +		"MetricName": "imx94_ddr_read.cortex_a_dsu",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
> +		"MetricName": "imx94_ddr_write.cortex_a_dsu",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m33 core0 read from ddr",
> +		"MetricName": "imx94_ddr_read.m33_0",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m33 core0 write to ddr",
> +		"MetricName": "imx94_ddr_write.m33_0",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m7 core0 read from ddr",
> +		"MetricName": "imx94_ddr_read.m7_0",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of m7 core0 write to ddr",
> +		"MetricName": "imx94_ddr_write.m7_0",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of sentinel read from ddr",
> +		"MetricName": "imx94_ddr_read.sentinel",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of sentinel write to ddr",
> +		"MetricName": "imx94_ddr_write.sentinel",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma1 read from ddr",
> +		"MetricName": "imx94_ddr_read.edma1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma1 write to ddr",
> +		"MetricName": "imx94_ddr_write.edma1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma2 read from ddr",
> +		"MetricName": "imx94_ddr_read.edma2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of edma2 write to ddr",
> +		"MetricName": "imx94_ddr_write.edma2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of netc read from ddr",
> +		"MetricName": "imx94_ddr_read.netc",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of netc write to ddr",
> +		"MetricName": "imx94_ddr_write.netc",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of aonmix read from ddr",
> +		"MetricName": "imx94_ddr_read.aonmix",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of aonmix write to ddr",
> +		"MetricName": "imx94_ddr_write.aonmix",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of npumix read from ddr",
> +		"MetricName": "imx94_ddr_read.npumix",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of npumix write to ddr",
> +		"MetricName": "imx94_ddr_write.npumix",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc1 read from ddr",
> +		"MetricName": "imx94_ddr_read.usdhc1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc1 write to ddr",
> +		"MetricName": "imx94_ddr_write.usdhc1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc2 read from ddr",
> +		"MetricName": "imx94_ddr_read.usdhc2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc2 write to ddr",
> +		"MetricName": "imx94_ddr_write.usdhc2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc3 read from ddr",
> +		"MetricName": "imx94_ddr_read.usdhc3",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usdhc3 write to ddr",
> +		"MetricName": "imx94_ddr_write.usdhc3",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of xspi read from ddr",
> +		"MetricName": "imx94_ddr_read.xspi",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of xspi write to ddr",
> +		"MetricName": "imx94_ddr_write.xspi",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie1 read from ddr",
> +		"MetricName": "imx94_ddr_read.pcie1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of pcie1 write to ddr",
> +		"MetricName": "imx94_ddr_write.pcie1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb1 read from ddr",
> +		"MetricName": "imx94_ddr_read.usb1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb1 write to ddr",
> +		"MetricName": "imx94_ddr_write.usb1",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb2 read from ddr",
> +		"MetricName": "imx94_ddr_read.usb2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of usb2 write to ddr",
> +		"MetricName": "imx94_ddr_write.usb2",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of pxp read from ddr",
> +		"MetricName": "imx94_ddr_read.pxp",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of pxp write to ddr",
> +		"MetricName": "imx94_ddr_write.pxp",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of dcif read from ddr",
> +		"MetricName": "imx94_ddr_read.dcif",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	},
> +	{
> +		"BriefDescription": "bytes of dcif write to ddr",
> +		"MetricName": "imx94_ddr_write.dcif",
> +		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
> +		"ScaleUnit": "9.765625e-4KB",
> +		"Unit": "imx9_ddr",
> +		"Compat": "imx94"
> +	}
> +]
> 
> -- 
> 2.34.1
> 

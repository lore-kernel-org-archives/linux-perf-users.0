Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507553093B4;
	Fri, 15 Aug 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275418; cv=fail; b=aS23946WyK153iA2vuIFId3MlCZT2bLCdERyIhmIsvArUomBFgNaexLkEJBqDXQ3w030Wi3SlMrDUlqiNyEfj8GO8qvfIRrenxC8l4M8SutbSJEE0csmJ5x+4Cvw4UOljhyj76l5R6jvMd23UPqvP3K9hZHBm8bgTYzNQcKHwOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275418; c=relaxed/simple;
	bh=Pd+q5hTkrstUDUV28FdTzxrUkQoKxMK9z1KnuF9q2MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZU2aDYFxJgAHp1dvFjIGSU01R7ZQneBDuGaEEvNxLv67X4AVFAgCo8uLsnwMqE4JyXzUbXUph/oAc8ZQ5nIMRGRGDOSTjkSb1OeDANe0OvGIi2fz/IUP2U/OGNVyEJccKhdu4yi014G7HnKz57hkAZc+xUjtLyqR8y9tg8s7ZPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X11rD86G; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X11rD86G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTDBKyrTPNTO5dBYSo/wrS6XntD/kEJsQ0iswMWpXldnVZ7qIqyGMFJi3ZBMK21K2vDQ9iiRFVIph2BBM+aI+r5fMmY7sKYeQMK2uZvvBmUAG1sq9uzUflg1C/Dfhh5AoV0fDGCwKZtDIlPrKV0C9GYp7RaMd1DevmavkMw1h5iQRgTTXZmQnpOxOIp4UixterVkFAx8JKQFAVw+S/BvO1dbf7PzFLjALO/qljY2xWVqS9kJSflHw1xHExoHV9dE+QNnSdVCCKtEfUdvbdgi4wqHC2V2TjxEXACkh6uUuEHjw3dwE0BxyTqOEEJ4Y84TXyYNKyVeIZkxIMMxFxoCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/Rfivsp0SHYE8ihs4a5hckocurGR0WsgqpWtxsWn78=;
 b=WsR+cMpZHPVRmxJLPhXqDJcILKx3JCVk/VZU2GKtE28hlvZpBkbTAxsJsjFH2hS+3ePRCfvbRsgLWWkglS4DmRDC+SyslbpzXbm9iryU9yv8OcE/7vj+6PHDekotAt9s3n9z+y0+S6YtPW4ym0wJhMLzebzW33mWHya70HRG7o7hiEidHP4EILiAsATAo43iGlzqNVBERG3ASGKo6W2Q8GMCSi27TptsADVx/ag1EdG+Vz9KinNNhtbNrDsGG5a8SMxMe+rUZ3QzU1In2GEiXcGyBP2UdkIPqi9/3iroAdU5POzZD7SHz/iNOWTSyUTG6DzJWpGv9iQGM57RbyGi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/Rfivsp0SHYE8ihs4a5hckocurGR0WsgqpWtxsWn78=;
 b=X11rD86Gfe26JYz8LNFbydOPwbRZ7Yy9Shsmr1tfgWIj+1/eWmwSdNTAx2wOakHP80YKPKMnL/XII6COYb68OwwzEJhNGk/pN/snI+J69ElnPt48Q8n0h/XYqjLxD0XvSr+GXc16ACNd+SF31lSYwCXOQv0m88DcqsOBraO+VAQ+DxkjHtsvE9MKZIuq3W/BD8cb0mliq9+B2IvPCqkEVimM8Bs24HPwXW+xoNN1luPGfpHyNhOVNBeVVQxpd5TtuKHHZZ9lRI9Mvy+L+uHcukhdv7bMzkGrjIYvhWKQ9fmsoTiTHpk74s8w81ltQ7O80qPoQoNpdubL2Xsjne+h7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:30:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:30:13 +0000
Date: Fri, 15 Aug 2025 12:30:02 -0400
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
	imx@lists.linux.dev
Subject: Re: [PATCH 5/5] arm64: dts: imx94: add DDR Perf Monitor node
Message-ID: <aJ9gimecxBtDLhJB@lizhi-Precision-Tower-5810>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
 <20250815-imx94-ddr-pmu-v1-5-edb22be0b997@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx94-ddr-pmu-v1-5-edb22be0b997@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfab0b3-9a84-4b00-4595-08dddc19026a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KAdKDFoxWodfZb4oWY2EO5/6TM8RrwOaK6YKFnV0sfoinSJy8Ov/VcgXRoH?=
 =?us-ascii?Q?Xn3Sy0L5MdMSDatWXl9xH4xW0fdQwWYrkjl4D56UHWux4zaqi4Rk405GCTLA?=
 =?us-ascii?Q?7tqzNxYBw+vgYYZl5i7TP8Dim6nU8ZzFuj7hcTwVB3lPOvpiVLSyapAeXPhZ?=
 =?us-ascii?Q?SLn6vkwBskn5V+ISJhLf7XA89SUAt1XOOvhk/aMpiYcObElCq7QLeu//bI04?=
 =?us-ascii?Q?db9LyHDpk5rsBEBgwjPpmMGA+9IQjgUmn4HQwT5CjQrMff1GSvj7T00scSqn?=
 =?us-ascii?Q?blfg//JexQ71QYMb3KYYVH+N7aeSnvuWL9P6NClAg/0NwuD/sJiIVyebYsGM?=
 =?us-ascii?Q?uKMwbbNzk0I8hW9qWTO0aEVFhFPTdUSb5P1Ki2jVJgzW5SKsMWTV7yIvNJHq?=
 =?us-ascii?Q?QHgNecRiMLCuLga6YNikaFwxpGR5aaHcJR5ed03hmkMHV+wJtZqkVXDnMlQZ?=
 =?us-ascii?Q?RlcMd3ZOKiQ1xO5rGvQ6Qk9IJR3fYaUFA6fDbHlmMJuKmBue1WSF1/5ZIwzO?=
 =?us-ascii?Q?vuXyZ9tsQTvG2OrMonOXEtCYdSOVpNJMAEiIESaccvSIlT2zDIBOou3SjIAv?=
 =?us-ascii?Q?yl4HSQp8MaNp1LydeB7EAWm3kJyf9Yd3he0LsA2JqOVH0DlFlaOyccst269N?=
 =?us-ascii?Q?0oPrnVor/HmG8SUvJvmjy8zNhldxopFtjAw0E4evl2mO+dAn7/EMxhSyZZUv?=
 =?us-ascii?Q?pUI+Ddi9pvZjiOmO5HHczPw2+N6OSGjzzYNIgb4gxAJ3UEA5DSkYzX08c7gX?=
 =?us-ascii?Q?VNMvWTOO0ll3rf9yhAvGzEBiENYSispJfNC9pjC1pgIAffSPKYMi3xhGlNCK?=
 =?us-ascii?Q?dvWnCqwbgDVP/TUOOMQzAPOXxYyVV5D3XU2XVx0+tI1UHR1yfKahcPS4wPTx?=
 =?us-ascii?Q?cDC+zY1+Bw05xCpy2oa2nE2nnhIbRYATOoviCZXk0TP1UnE7kvU4nRjVwGo8?=
 =?us-ascii?Q?GX5/OBquEhTCXMXcUqW8nHVyd1sahuH2Tco7vEvJNzH3gdJXQZ8Ey0lQJWko?=
 =?us-ascii?Q?PvtVzACWQvZqlEGZtU/SQJhSZ1KmIYZy4J//llCLsJR0nVWGK2xoPPCPXwey?=
 =?us-ascii?Q?F+OP4PnFnlkwjCowq9vqePGmH7mgcZ8W340FLR6wI+Un9O1SAHjFwOyINUhh?=
 =?us-ascii?Q?dCF36sqrkZPkIOVb2REuYtUlstXIGScDZbZ5T/FA5250ZjkP7IXJMSPLqIbO?=
 =?us-ascii?Q?XogZHZRFAmtc2v3tGyg6CRYM8UmZzjF62R8Yzv6ItLPlSOOsqmnLTj/yrNnn?=
 =?us-ascii?Q?aIGPifs2hhHXJoYt7Bzn5Zos7+QpCGvb2k8MA5Qq5x/L9sWLo/HMpM4FABtG?=
 =?us-ascii?Q?M5wuA3AtVhxwjN+rXZjTOSU/SqX5AA4p9c5cYQjEHhFhpsULAllbKLEwgb9b?=
 =?us-ascii?Q?ALHrTFqyh/dDDRN/+g0MN3qcb3TEuvYHTmpyKm9jKV5KfEZf6lKRS/binnZL?=
 =?us-ascii?Q?/8ywpWW+dETSSE1fAyKlyqa0ySkfxtKBoZL+o9VWUW4P6t3ThkNq4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiDHBqblKbUuHrmqBAcQgCLBeyZj8s+cjMwy+Q73o/GOMVXGWvmc2tXMBVdN?=
 =?us-ascii?Q?vAUhwxBZyBQL5YKcIddcAOVeN0drE7DUYXP0/MZA5f6YIR9YxVGIKpXJm/wX?=
 =?us-ascii?Q?M3FDVn631bmzQHJrqQXkVrch2sHJn2kfQDv59oeIWHgU09S/xrlvTSlBaPRz?=
 =?us-ascii?Q?/vmwPET7+T6J3nzokOTYHI+mdT0CeAQ8eIOVZfVOA4dmwG+tvuLigpPG2TV/?=
 =?us-ascii?Q?bpOa02fEwt1Z8Ntx+Lak+eKInme8C53p/g54h4B9RIDyAxy9Ri3/sEpiFxhw?=
 =?us-ascii?Q?9UySBRGVLxSXBrqkYHe8Rc3uSZvMxMyrwrBl9ZjSOf9u/dDMNFKEBz6rdLQl?=
 =?us-ascii?Q?O6zvkhU+OCtBfVryiqvnVrJwytjs/5BunsEP5cClIveA/StoYXV2TRm3nQ7+?=
 =?us-ascii?Q?MXPgBLq/l6SQiqQZ2HhiZVZXHBO1YFWh8Y/K4PNF8W8NaRzn1XWkds2jpQWU?=
 =?us-ascii?Q?xqqcafg1wGbCuygxXKDBIIE0fs/mbkIibzipktAF8dbZTcmHireqCVZgXozu?=
 =?us-ascii?Q?BMJ/9sBYAZu8TIgMLbxQ779kzLSbGLd8RAg3xtoEMBsZ9JUK2GF19X2V0/0u?=
 =?us-ascii?Q?AUGgiemYzCwzHKP4QjPgdC6bpTI6KGAs/bKKZz0mKwayFX4U/++Y0jRcGmIp?=
 =?us-ascii?Q?bRuYsxfxUSdVDOnvC21VHHEHyEdwm3DF6xO/DipdYgawI0gC3EaCPG0c0t7a?=
 =?us-ascii?Q?/cKixmA9K8dvqmVpbX+o2xoZ2m5AbvPhm2njTO2+q0MSBf8XFLJbwuXsmH+m?=
 =?us-ascii?Q?eyscQlqUXve17MVh9yfJ4tmFi26ipOawa4j6Y9N1Rm7SInHwAst1SrTdj8cV?=
 =?us-ascii?Q?uYZVx3GK//oKfdM7SUo1VqyKvDUmskE3WOD2lj3ZfnRq8vTBdSNvp+XEiWg2?=
 =?us-ascii?Q?MdaDRj39sP+fKPHeUtRSbIuBo8jruhU80rIC/Y3iqWxdZD28FlqXx9W6gvlB?=
 =?us-ascii?Q?XU6o/JcK10DMjWye84BERG7uWEgfqI/4kKMTKxn1Y55G/VLwA0w9cFufENqA?=
 =?us-ascii?Q?0Sr2EXev0KGLIwT4V9vP/8kG1Of6jwiy7/TCgo8zhi2XIMgz9hWo8DN8ASpQ?=
 =?us-ascii?Q?uN6rl7Ugw5ZJ1WIrjoFiygGCE0bOiMHIdOzPBLxHn7cvuVmlsuRSSuTKgYbk?=
 =?us-ascii?Q?HrjNXIoAY48cDfkAHumDsvv3mjto92wu/KKqi6KQJmDOsDxBy87V3ryj7yWi?=
 =?us-ascii?Q?j1sBKz7KX2Be26AFSdaIFaYj0oTEBFwCDsIfdCtPStzi+yUKXQJ4p7ULIWsA?=
 =?us-ascii?Q?nlkXKuD1aCtxDyUlyLIgCO+Lr7/rzBjLjnnd+UqiH5ZQtqpmx++sEF5WqBDz?=
 =?us-ascii?Q?q7SSTfJN36S/OZjEq0R9UpSPKOXyop49kuDEkVjPCeKkh5rB10d5wMlszAmD?=
 =?us-ascii?Q?OMxv6nXLFnwdBVpFFIHkaq9GIYyDVgjLJkoa0u5tx8/gg2a+5zL2OA1aCnco?=
 =?us-ascii?Q?T+UlOS7ZfJ2W/76XVjFVLe9d7eYB/0nLzW9Gu9xKQycO206+iNEzb20qyTNf?=
 =?us-ascii?Q?51ncm+hOijcAtBVtE9jLTzbbG6VZMaWcuN4tnmSitvQh8LUIJW0DGMhQaBss?=
 =?us-ascii?Q?8aMofn5LXDJhImpQo5M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfab0b3-9a84-4b00-4595-08dddc19026a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:30:13.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWSBxLqJ3EEtAJEcdJ9BtgXE/hnWQ9lml90X/yQ2T5VrtQax5F3LLDgfFWqN8dicH932CT+v1pSvUpAvgWvuRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:36:31PM +0800, Xu Yang wrote:
> Add DDR Perf Monitor for i.MX95.

typo, should be i.MX94

Frank
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx94.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
> index 44dee2cbd42d4bc765c33a9ce663ceda095b6c66..6a2d86d67200facec76a7880b4a2268b4191452c 100644
> --- a/arch/arm64/boot/dts/freescale/imx94.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
> @@ -1188,5 +1188,11 @@ wdog3: watchdog@49220000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		ddr-pmu@4e090dc0 {
> +			compatible = "fsl,imx94-ddr-pmu", "fsl,imx93-ddr-pmu";
> +			reg = <0x0 0x4e090dc0 0x0 0x200>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  };
>
> --
> 2.34.1
>

Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E111185;
	Fri, 26 Sep 2025 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855729; cv=fail; b=Iro4hrKOzC70SWxxF3tafcNtOm9DtJluyOjKAddlXTvj22L/gA3fT7ZwG7LwSms6PZ/VFSL5J3SwDtIzfW2oYTO89uyq+prwv/bbPSMDshMwSpLOyVuHQM82PjhImB2EPjoQTmzC2BHZiNSux+yOyyRZxtcH74Zj2yk6JrmUL5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855729; c=relaxed/simple;
	bh=aplRxZghBXKiysVUpHdgLc/gLu3xonYbmvMTavKjBtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZcFRhY7OskJ4IO5n9ABQuuiRHnP2hBb3kk3Whp42vViOZ3q3R2Y7Xg9jyieb5WHksF1h+NJ4HWlZxGHRjE95ZAKsm2i0RbfZTMUfxBjs/0LsxfC2PJd1+J/Om7k30JiVabcceJhMTQLA6gCx16kQBVIsfdhRp065Q+iD/um1BIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FO5bTKJC; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FO5bTKJC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viIxatDxPUXy182aN5S73Z6laTM8abqG8fYZMds5h7b9Ssw8/pp8u3HhkKFsHJ7XHZLEIX3EccdF2PN6A9EU3RndyDMSVcjdgbQ5Zu/o4KRmb2FS0Tf8hKn5QAT9KBdBS76tvbwy0KvxIX13vpjLNgn54YDWLb+rQFfn4FzILyUSy1NWiDqFT68KFCoX6dkyIfZW+KGS5GUQCoyt+lezsVG2pOZMQDd103Xk/rGd2ZzGFwAABIiDf84pIZTuVoUKoozixdXvgM4mfZrV8f3MVLJnprRd0O+mS4Ye0vtTSmeCC47DE+ugScNuGI5AOdBHMlMkA2FCHaGC07L4yWUl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnNaYTF/3Sd7owCl8RuY5D6FfLuyZD80KrYKr89d1+Q=;
 b=jfVR1EcFhRvhp702D5qXyXYQkqOBmE4yL8RFEnhl+22cIzktpEgC2ejiP8ATNWj9U09ANprj8F2lZ71gud3jCh7NBoWD7gl7f9txX4QUlDTjqZm7JLzyPXd5XGn7U1qwu02+aEZdzseUg8v4XPhguY52TeXCa+PjKf0sn1Q3i9sFS6NPBepRGzQxt4oZpOhK17aGstFxALPi+kg1OSaQwIEzVa15PGrrVMaEJXdNbpwcnELi1iDbuuXj6eru168rK/zWce0cQbrG5CoRt7aXzFwceROymHcUWAHyOFZ4g6OsOn9trVtRi/RITVl3PfnsTczinD1FBDd6xxFZKCXzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnNaYTF/3Sd7owCl8RuY5D6FfLuyZD80KrYKr89d1+Q=;
 b=FO5bTKJCNaa5IIoto+dn4r0waXYc8Sp09OBYwJcUr57iF3ADBVvwN5xUczueRojqNM5dFBPL8/uVSb3xrCE2T8fSsKlSk/VQ+4jzCnm/KVzeT1D0oZcsPvVwfM9DRtx6lAaHyMwFz0d9NFdIsq4yZeo9mCMf/FuKGAG7CkLNm3awBPI+29Y0eMMR66vBV6Um3nP4Q+DYfGCkUs6DLOUh+u/5Zbyu+kQQbTE5cY8kp2Vy9vT+QEi7iUJBrvx1EmlmqMJC+/YlRn7g3bFVyWFxln0An+CKHvc0Pj7zoeTPgZhxoqE9fND4zrL/b7eg9zp1bGN1U99USVp3PW+54IiRCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 03:02:01 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 03:02:01 +0000
Date: Fri, 26 Sep 2025 10:55:51 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, catalin.marinas@arm.com, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/5] add imx94 DDR Performance Monitor support
Message-ID: <md3k463rj4ehlpnkqgfi6dkt4clkbax3der5i7xqvjqqaknrh5@iujmrwv6l6cc>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
 <175819950650.3462177.6226529699819628940.b4-ty@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175819950650.3462177.6226529699819628940.b4-ty@kernel.org>
X-ClientProxiedBy: AM0PR10CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::21) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4b90d9-6520-494c-458c-08ddfca91074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MwCZzl9w3j6B0DXZnlMjsd2X90SkjA4PKXd3K82mKrqsjvZad0cDP41Qxf0W?=
 =?us-ascii?Q?EhwgRiSKEedoEE6Ykk9BPn9Wn9cV1JE3W1Bi9xigYlC8s7xqezko3ICzrXX1?=
 =?us-ascii?Q?Laz4HAyYZHqkQ4gmzcvfK8gpWT4ZigHCuPsfVyTk9r9xtzEpJCFOb1OZ1eNr?=
 =?us-ascii?Q?kmjqeHgBX6bRJdcJbHlhNdNSg+32vk6uYqsXgw7mGxn6IvGXbGjMVNzLDVX3?=
 =?us-ascii?Q?KpaftQkEPCKS1VkOZjBmC15BiV+YrzEFU6kfvHmt0/P0Ea0TGPpPtdDUeP0P?=
 =?us-ascii?Q?7rRypDtZeijHIkMwNff9nvTN4oQj8QULwNJU+shwsP23GXReibCyyoG7RArE?=
 =?us-ascii?Q?Mb0X0XTOiDI1enddPQMEUKIO6YzsfOhnzk4Zxc237BRgGDLtfkdqyLhOehwd?=
 =?us-ascii?Q?+0nVHSydXccnpMnhFwC1l3TKUxczAdfHMOsxGNm0Z5T0GStcafzDwTbDYeaK?=
 =?us-ascii?Q?ACbQwoUl1koGsqjxV6XsmTiknbDkE3paaIMVJGpD+drsiWqC5qjDkO5iGCBF?=
 =?us-ascii?Q?xm5KRl+yq+fGs+Z2aorqI3HCcfWIRA9jjOOXytuLU6iMvqwDD+vOA6WrRuK9?=
 =?us-ascii?Q?XW2CorgKHY911Ykw2bhexGkoIIhsJTSli4JwRAdxL1EmQB29eydHAOMpCGM8?=
 =?us-ascii?Q?1gYBiy62dd0bTMVLZz2AdRh/6tJNKN4PfHvGhGWFPSpY/OSql53Mh7LDiLSE?=
 =?us-ascii?Q?IGRNrOhnFMV7gPifDYMQh/+bBKCyvOmEvgNxZZJTtegg3v0U6h+9KE9nsCtl?=
 =?us-ascii?Q?MI2rLXPN6E0+ScMTR83aOp+UbK6SWW5hoxjYAR2GjgjY3bWMHzvrKXWCpRih?=
 =?us-ascii?Q?RrG1lcR7HLfDMUL4/rqYGTRBagyWWCD2NGc0+ftPGX9+9TKaSiayU3SIEDWh?=
 =?us-ascii?Q?+m9DD4aGBPFViGi9klJ69aswgAp9AeAWe+o+IZu7ZpFj2+hEsEv2Yy7fP4lL?=
 =?us-ascii?Q?4La3Hz34cAcz9GQz/tTbvXFxdyBHAmA5gFxb4IAqCu/eT2nlGZwOauxEh6sY?=
 =?us-ascii?Q?4rAgJywn0dgRO5eRs7Dcuz+lyAarhpCnUvNvqxBI8mRtnvWJEnANZ95zCQwl?=
 =?us-ascii?Q?0jdgIgdcXr8++JtF2vrWvwc6+h9DWIE+jg6X5rQFYubNNu0n0A9kXPoTuy1J?=
 =?us-ascii?Q?8+QaAvJEKo29eJSguPlkpupm2rduEz+uL2KjjNLEfxUrpGMzBX2UyMtWCSRk?=
 =?us-ascii?Q?Wi444fGAh2VAyJZlgNy3g11jYV5VWla4lKqeGDOBVywK9vr2LBaK/rWEaVGo?=
 =?us-ascii?Q?uOOwDiWtPEmreD2QzOFbmxg4S6H+28TjkIyQ+JPUOag2TDXqvYcJhmUlgE2g?=
 =?us-ascii?Q?o4HCW7xJtOxnV82YBaqeilkfd0gT4KCA8R1Utb0E0juWuqalv5WincJDJ5le?=
 =?us-ascii?Q?aybt8wGvdumZBUGekE4dx9+oJK7v6IiSeSDKo2GsaJF0aZ2sJ0D36woQOo+f?=
 =?us-ascii?Q?Q1qAbPJmnTByzTvI5m3SBbGG0lDCFpzs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Us8+rSEsmZ9XUaFCzffwlAYtyKMBtLCY8ThxJJuDnklWfZ+eSJ47+RUx9+D5?=
 =?us-ascii?Q?qgUm2aBlHcwirFAdwLcaw638artnFhY6fmhSpEWD5wsgmKYnkUGf6DA3wFOp?=
 =?us-ascii?Q?lEpa8aiTpWke0/V7sg+hvoJN5rHIy3ww8rPMAxuZ73DPtcMRI0UllMOeE55m?=
 =?us-ascii?Q?4StFMRVx9NuY2PbG33dNdRodmV+dMKwwuFw7CZiQuoWqhrTGXuEkgjPc3phW?=
 =?us-ascii?Q?sosrtjirGW3gytKPWJAwv1breOBSQLrouSbGbNE3HyblVFfhp5hOBORNhYdq?=
 =?us-ascii?Q?r9xwhUpXR4+/jJG4cEPQQZckHX+RzcIrpQXd5gcC2dmmcUU2Dg7v5zb0IwKe?=
 =?us-ascii?Q?jxiR/JahEPKm9fcSn7Eu+sKxKuqVhZlHgx8QYTlfre1Zakc/Oo4tTg0bqJdb?=
 =?us-ascii?Q?Jq3hgiSP2LF2a4H8LUmvuV8W/idNtGSZmoTehzeZBloNWYWlMnEau4s27MvF?=
 =?us-ascii?Q?hsdYPXvv/i0NNYZl8AZsCCmNp1yux2P3McJiDSPx8GAASm0NSNU82OqTXYbA?=
 =?us-ascii?Q?9wJ9vgAWZ9OLpeiFHMa5JLZUP2DqaxuxdVETkTQPUVZ7uFgNrTRCUQQfsAdd?=
 =?us-ascii?Q?TU9TdkTvCjAMm3uxPB5n3O6Jeid6OoLFwNQ9jTJcDOxv+Ft67HaOI3XI25Sl?=
 =?us-ascii?Q?7sNZp7nDnj6JsptW7yY/m1YK6ZA4DHGZgcKjtzKMyV1vlY3d0xo+Oi/R82gQ?=
 =?us-ascii?Q?Y/+YTHdXvsj5at/V8HsVN+KgUm+iUKKd44h205mliBvqp4bUhnSGFa8b7PxT?=
 =?us-ascii?Q?61Ybdh0b0idhQ4ZCyM+wtmU4J8990ZguqSVEW7PKkOoX1hfGlWKbyfEo0nEd?=
 =?us-ascii?Q?LkEZo3xbynO7DHDPCugvVLn9je0AFKz/aSBJC0vNT7ndhtR/h6m6bWf/Ykf1?=
 =?us-ascii?Q?nevuQc9uuttpFbsLqH//cjsBQRfnm+ohzZ0TM3uS8JNfyOdKfAIldwzbCTQ6?=
 =?us-ascii?Q?m9bLWcAXlOg0MFCj6mqHrbKfouQJ/9Rx5GydSZ4+nApjFgCC7eA5ONuqwHaa?=
 =?us-ascii?Q?8LDQI0J8Fv1pIT0v8Nz1JkEoeIlXCpfPzwRZUr1bfffs9mTehf9rRvRPHw64?=
 =?us-ascii?Q?hqjcZWuE/kPzBHGnIIlqGNB0mP7Rt9Fs5GnmUzCqz5/H+0cnoKM+gbHpQIs3?=
 =?us-ascii?Q?0JqrDuJZKVgv2GhSqL7n75618EktHWj1FC8TpfeoSqxNMXmccfaeL5nzU+mh?=
 =?us-ascii?Q?SN4kXSozJXkivwzjxfxS8lFrLu20/MXCXVSbAzdHubeYbXv3kDZzd1lDXlad?=
 =?us-ascii?Q?z+eLDK7+3FmTVdXBz1Gqm0sE/vhSygaOpEh0/uvcvMBgkXW4Ss4JTXwWTJNh?=
 =?us-ascii?Q?+CPYXlO8QZHeyFWSRS/EUFEuJuOBRSfJmUVsASBl+R9jm2Nuy9szhCrrCcKC?=
 =?us-ascii?Q?ejueba0kAOLgna2L0hZ0N2sAftJD/87GbH3inU+DZu7LyYahSrYOCc6hNkPE?=
 =?us-ascii?Q?NWs+SUIQis1qv+2FPsiQvybtckm7ePg0K7deTiknI7vXtkAePjMSiJXgavrt?=
 =?us-ascii?Q?MzlAdR+h6dOtDDKFyQLMjygTIpXHjMoLI1fehbjspGDXYVvPU/VTkQEfCvq5?=
 =?us-ascii?Q?HlgeqIZfbHM2EsoLgr9vZz0k1n9boSdJhrSxZ05p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4b90d9-6520-494c-458c-08ddfca91074
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 03:02:01.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+r+R3Ca9e7Ha83ZPGyz+Nc52v57HCRk5Wd07386ZpdFBDejJSyGwrW5jicqdKWQ9x+nGTOgxdkJjsrdy/SQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311

Hi Shawn and Namhyung,

Could you pick up below two patches?

[3/5] perf vendor events arm64:: Add i.MX94 DDR Performance Monitor metrics
[5/5] arm64: dts: imx94: add DDR Perf Monitor node

On Thu, Sep 18, 2025 at 05:43:10PM +0100, Will Deacon wrote:
> On Thu, 21 Aug 2025 19:01:48 +0800, Xu Yang wrote:
> > The i.MX94 Soc has a DDR Performance Monitor Unit (PMU), this will
> > add support for it.
> > 
> 
> Applied drivers and bindings updates to will (for-next/perf), thanks!
> 
> You'll need to route the .dts and tools changes via their respective
> trees.

Thank you Will Deacon!

Thanks,
Xu Yang

> 
> [1/5] dt-bindings: perf: fsl-imx-ddr: Add a compatible string fsl,imx94-ddr-pmu for i.MX94
>       https://git.kernel.org/will/c/f8cc02321bfc
> [2/5] perf: imx_perf: add support for i.MX94 platform
>       https://git.kernel.org/will/c/e4d9e8fb406b
> 
> [4/5] MAINTAINERS: include fsl_imx9_ddr_perf.c and some perf metric files
>       https://git.kernel.org/will/c/2c599c68c43e
> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev

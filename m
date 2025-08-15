Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD50308F29;
	Fri, 15 Aug 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275355; cv=fail; b=b1cerTcj66hdFUIECfCkxego2XqfX7t208Cb5AXACfoSAqTkMa3dUnVmQKd8jyGXT47IYmjVnUphDx//mGe3ttFyoxMgvYRT3IeuL1nkI0XbTavnmyxcDWUu2zoE1LulWAeq4XC9TnXHPDqs69VR8AuD+6jR/TxbNiG4wbJC57Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275355; c=relaxed/simple;
	bh=jjCFlQFVm1s/ooD/G1crvR6PoK+BcJvPGi+uoHyA3Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vBOiKx6jdHOjKl0u0kLikDihBbXmpE0UDfNS4X+PRUFLRwJoZhSu38f7GVj9Q1PCXxoanwfdXDGCt22xtpiqsEUi3So6stChxq5v4qMYO7+rdLvsLgUAu2ZidybimTTw6Bwmw9VNNaRt0iev4pqpesXrs+vuQ1S1XDQBP+1v0G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iCuIqFWq; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCuIqFWq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN2Whkrb8OYJlkGqTiTdXmljfFi3NCKdm2uqNHsW6Qm4hw9TUiEDKfPp+Xartv+kgfu2Khw+plZoGyVHVlAU+2JSr6Z9Oqk56O9s3A8d3mhxfap6uZOK/OpDQ2Vkbwubn0VJuNUL3NtJNBvlubvy7QJP7QIHVbatOP23Ph0QJoMNmHC/H2DYHXs+4cFAURQfJFwz621yrXfdrzkvrP/iQ6AEhWgxWGpYDaND+zQksN4mC/8ZnJIzv/YVCwI5ftL5F6VnopMPkfFRRsAc9pl5ALxE2EOUZb7oP/QyA6pKxh/XU7A1QFWJbvQK3QkwwIWQdWpvUcuwIlI20jm0SF4vfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEz000P3futRk4MSdBpsPX72hBk1UEnESj8+ox0pdtY=;
 b=HPnn5PQSyRYDS7MebYrJaBIFAh9+J7Jry+g0Pk1AOhdv80Zk8TVhTa7WMQQCzHEO3XLfFzXXo2g85BR4YHWQzv7jQCJqVKbbR96UBWlCa2zipexSNVnHtLNOfsRdogfCruGQ6zT9pV8QN0vf/uzEzBoRj5jGGz4ZlIznh/Wu/FKbS9AuGAAD7rQ3NthY3L5yEz1RDIhYOuRDE+13sjY1MUz9ZqsQKJbFJY/Wc+te17JgA2RRf7nbmmE1CfhycdC6SMZLIH50IVseIsGt0W+gnAOWK6ZXKx/RHl4OgqOsWjR48s00TYFSTE5+CEEPQYi+iaKULI1tH/f+HP6Vpm05dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEz000P3futRk4MSdBpsPX72hBk1UEnESj8+ox0pdtY=;
 b=iCuIqFWqV3jPW0FNbaDKax1SDHeTu+YSFS1e8dPO9ZD1lntXdrvQUuxHqO5xXuTvi9k6Cft68oURD4gpGg+A12eo5WFVSnT4g0k1CWT5ZjeBGaig/UK0utBNQXyG1njeRGyGQ37Gv8M/IKJYGgp3TvThiNDGFioUyV3MC9fL1CFQY29m5/dtWsjVmaBaDnW4WDvA3/ziPwuQNCJhd0vbArHA+qKwwDWa3QOx3U6SrKCzQpu/oIUHhweO6OAk2oAyFH5ToQqB+bF2xOeMb+L/HS+WFYj8lUq3ulN83eMXnVO/uPIZZQS4MJikVhhheTB4RrEG66ypC12Ts/+yCsuzYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:29:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:29:11 +0000
Date: Fri, 15 Aug 2025 12:28:59 -0400
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
Subject: Re: [PATCH 4/5] MAINTAINERS: include fsl_imx9_ddr_perf.c and some
 perf metric files
Message-ID: <aJ9gS9be9SoI+DKg@lizhi-Precision-Tower-5810>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
 <20250815-imx94-ddr-pmu-v1-4-edb22be0b997@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx94-ddr-pmu-v1-4-edb22be0b997@nxp.com>
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 871a096c-e65a-4e03-2c29-08dddc18dd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RYGmuVifvOlHk6d8V26e87fIItF2FMm6E27cFTPZsxRjUHjKs+ohyDD3Hm9+?=
 =?us-ascii?Q?2XWOmemfcb0uzMebdPKGkyUmA8lIWVvYwFmLE5xZ8CmyI4UncUJ/zuO4ACXm?=
 =?us-ascii?Q?eKZgvN8L20y0dPagGN4BZbXzO9wS9BURbznU8UaUP1MxmtCbUDuKzb6EwcGD?=
 =?us-ascii?Q?QlMpWdmMiEjnE1h7avvm51yv4JCpk4m6I2y49bZQOZneDojgwfXns3IZP5R1?=
 =?us-ascii?Q?cFpPOi7yJn5glUMtSUfGylsnuaH0j0csljqnCymG7DMmSbuzEdnk+4K4JE8a?=
 =?us-ascii?Q?NJw4a94fsBeDgQaaDyueib21D2LGYDYysfD+FEljvVd5adANgFfgnbBy7xUh?=
 =?us-ascii?Q?WITbbu+jCYaLJwxcbqR++Gkloleg8yER+w0jEBOTXlF7o1iyOgLK8hhc+36Q?=
 =?us-ascii?Q?ZM6wWxN5xcVnQDt7wmsTREMge4cHa1ZPqFaFB2FWp695R15K6FewKf7TcBq0?=
 =?us-ascii?Q?qMoYQNpktXi32IjWmew/HYCn39BgRzbRf+Us+AFdRMgk1jA+RKesQ8bBmXWG?=
 =?us-ascii?Q?vVqHBtnOwqexKmTA8/1DIINunI7tIfsnKZhv9yw0I6Tf62njV59X62O5guMP?=
 =?us-ascii?Q?sFKgLU/tsShzOxDGLGMfu4cdp6tGltcBgx4Y2r22sgKkpr0wPV40KeDMhe62?=
 =?us-ascii?Q?Bm3h1N/QFmQ6rb2XtR9Vc+hHaKcPNqLyIpZKqKr9YvNRsJSHK2C1fQUmcP9r?=
 =?us-ascii?Q?oMSTmPPGEUp5S7Vhhrw7eJJcIw1fX5DAcXtFmjD2R2qsCvpi0cKzKOHQt2XF?=
 =?us-ascii?Q?+wQDdARKh/YFau6Jpww/govQNsQxiuHtN8E03wS47BrfzDn6JsFFTxYrmxqC?=
 =?us-ascii?Q?/pTBeJAQIXDqffa8rGCgfC6FTfIruj8B/4nJsg/FxS636aGwdT3Y/JYW8Puz?=
 =?us-ascii?Q?BoDU7b6m6m3WFx+xM/0724nDFGEX+Zh8pl4ocwI/ZCKMSZ18JSXjOWA5/YMg?=
 =?us-ascii?Q?srW7u3p82ZTvrvdLig14aaZ8Js7iYp1JmHxFH//U/izZWBlQfE/lHET9Fn6s?=
 =?us-ascii?Q?UWLBrebj2uhIT/xXVHncrUOCNOeJ1MoycBS68Hn6365qmEU45wPdQIbGgAzW?=
 =?us-ascii?Q?DnmO2ER9tGZu88jHyWAdlhHb8v8wTWP6c/0+WXMbg7FXULru9dQxQ+IFM6ne?=
 =?us-ascii?Q?iiHWFlPYADTSxEIPp/F2pIAQRMB7fcsRkC8456ofj2qhVz58YsZPJfrylt51?=
 =?us-ascii?Q?z5YfuuAo3hgZJsPC2lqnqYxJSonIkA/wH3Wk7uzL1+NE3hmfvjiAQHSCjVHz?=
 =?us-ascii?Q?KhmLNagz/nl/OGdHoLnrqjiKcj+nlohgTveG873++thKfMRfoXndAC+R+TJv?=
 =?us-ascii?Q?FMmCMH83bN736EONde8NnLnr5II7vi5t79gzu5lFPCeN91dcpkSashTah5vE?=
 =?us-ascii?Q?I0DfkIUeSgxNqeeMoYHyWhOLD0BeNscWxrUye6I8xtR6APDCdpC+F9+4WG7L?=
 =?us-ascii?Q?3PPn9vlVwJOgdLdnicr288QN0AlcD4axI0dgvF7B4PciFtMk+Dfofg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PXMiniOw5xKZxQDe9kz+oN97ap9Tb/QUuCGLPxr+80BF1uf6TGz69en9ovB5?=
 =?us-ascii?Q?29jWTLW70bmDmsbPdr+qxjyCBkWWcS09I3Y03TNGm6oK8+42sc6Rq/E4Wm/r?=
 =?us-ascii?Q?bLdGx/4t+f1+IMRQNT44yDEKQtL80c3443IoUN54Yul7wyYm6rAeR0Ig3pwU?=
 =?us-ascii?Q?iA4IGpjWRqyxxFsDpDdKKajmx+9ISaLzayGGHDcJDzZr9qymHtc611aIZErm?=
 =?us-ascii?Q?yUK0BL29lei+tYyLjs8wL3Ez05I9w9bjpnwcyJPvEEKgLFulJHS32ziq1ZcP?=
 =?us-ascii?Q?79ZM6X/yQcCzAcC0gbxR2n8ll8N89pCj/HaDrJS1e6OPcBlJacqJP0Rqj6ke?=
 =?us-ascii?Q?+eAd6djq3kdvH6fBTm4TGTMtRiAWJdtWsyYxK/rsNAK//eE9XteWyPpIPmj1?=
 =?us-ascii?Q?XCOiGRdFZDlSOx5Yo5abkotX9TPrgj0/dLDVeXmMvE0i7cR/Q3TLtH4IzFli?=
 =?us-ascii?Q?vc+Ylb5KEXQbbcDGVhden0j7M/lo81oGWKVIVjjWyRrUqog56CmnRb9WfyL1?=
 =?us-ascii?Q?X04UJkL+u7HFe0ivGzPq4Dq/OTbKQnaN5phWVOKK3DuW2xyRjxh/e6oG6HMx?=
 =?us-ascii?Q?R/ImsmynM1bkLuRwiyltOKJA34O2rF0FJvJjIkVI3rxW9/jC7bF3Aj1TQsix?=
 =?us-ascii?Q?TJDhfTb0JdNzZhXDYnIIPau9+HBhgi+wFmHuv08e6eXNmZ4aHvcsV6hRdiyC?=
 =?us-ascii?Q?u5JmdQOn5wO8JfyMkeGAIMicCJEw814qStp4nMfnIRFjc+GnPhEWVJ4cTTGp?=
 =?us-ascii?Q?26GUfwxWuseLXvuUta51szgo7aEVsc9eOCmmnm1gSXmof9mpg4WAEhcik0Rk?=
 =?us-ascii?Q?tXhRT99Ij8p92n9pR3KZnEptt4OMyrQGdzP7MPeUu6Wx2ryD9A7TySp2WpRp?=
 =?us-ascii?Q?LGboWtumAv7jSTOPXrrXlzyHQJ2kAKCXQc5LPIXxhObC2Ao69tkVVp7iPwPj?=
 =?us-ascii?Q?+otkPoqoU4wemUFKJzJh3nwwPbO/oRHhwYZTDV0X6qD2ulWpt6E8vbvNQijQ?=
 =?us-ascii?Q?l6o7XG6R+xU1dlfbb6dIEQliI149JHWw0i6AOcT1v4Nxm2L7vJXXD8SzZqSB?=
 =?us-ascii?Q?uuyUTy8bnlI9GpMKy38fMiiZdlLNgDxj8vmuKJhSOZGk3cdXrlwbPCWi9zd3?=
 =?us-ascii?Q?y4NqRfWHxvG58GxuchM8UhC/voixf0AW3xx2gnfJa81XLSw0i83MCJiahsjF?=
 =?us-ascii?Q?uehQwgTjv0zBAL8VcM6fhDp18GPRrfFHVj7RdEWcasLyP2ubxBSW4wIDZM6L?=
 =?us-ascii?Q?6WnxhpdAB3ggut6BS0va83+wHwCCthgG0wqU2v8OcJED6bXOIllUrGNQT8gn?=
 =?us-ascii?Q?SM05ebXsWqUPbseHp7jqc8KO2RV9aUDitSjQn8pWjSNdq1ylOcwkq6AuLDFP?=
 =?us-ascii?Q?44AUBMKTUqo28ft8TEUdvYEGb7dvO71meDJAanF8isaz7Ii5QB5eTbqfIVAV?=
 =?us-ascii?Q?wYg88mFyfbTQrNqKT/gAFdy2NEo1gf0Rc88o4oAoVb3TuzFGeStmzHWS6tcB?=
 =?us-ascii?Q?3kFv6Fn1LhLnI4p89s0gyh0ccU81OMKIIlyqk6HZjK988CPW9ZYGHiJOMOpT?=
 =?us-ascii?Q?2V5/4SJPQN26phwK+748ryqVcTwIb+mhE7Bv6bZ3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871a096c-e65a-4e03-2c29-08dddc18dd91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:29:11.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRGw1Zcsi8hjWOQcSKeud6F2+dzSvxeIESG3R+7RwzOkvHQHyn29+h2Ic0hzjkWqxgvrXoCKb1rAE4gMoygQ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:36:30PM +0800, Xu Yang wrote:
> The fsl_imx9_ddr_perf.c and some perf metric files under
> tools/perf/pmu-events/arch/arm64/freescale/ is missing in MAINTAINERS.
> Add them and add me as another maintainer.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5eeeef7bf25500987bc1a278758c82c1c68a55a0..163d6591f169d250a77c8c27cc78e0e9b25cefb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9780,11 +9780,14 @@ F:	drivers/video/fbdev/imxfb.c
>
>  FREESCALE IMX DDR PMU DRIVER
>  M:	Frank Li <Frank.li@nxp.com>
> +M:	Xu Yang <xu.yang_2@nxp.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/admin-guide/perf/imx-ddr.rst
>  F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
>  F:	drivers/perf/fsl_imx8_ddr_perf.c
> +F:	drivers/perf/fsl_imx9_ddr_perf.c
> +F:	tools/perf/pmu-events/arch/arm64/freescale/
>
>  FREESCALE IMX I2C DRIVER
>  M:	Oleksij Rempel <o.rempel@pengutronix.de>
>
> --
> 2.34.1
>

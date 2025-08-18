Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A957287274;
	Mon, 18 Aug 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504182; cv=fail; b=JW6Ya1+DiBbdWQM/A/O6nqullwvDFgP9eDSrKEdRCjsi7uQdVqmoFHdgOo9xvY68rIDnIjjwDFt6GHOgNMFNURkbtuVlP7GWekbVrEAS9iD0eV02qkgPiMccC0JilQW1UahLMPnB8WP3MQTzIeczTfAIcwoAe1gg+9VjYnONnEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504182; c=relaxed/simple;
	bh=CpVYl5LjdFU2DiadixbzYHLpaIFByMUTqmhK2V7NvJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QmsP34qk/h5ZHvOCKrH6Tz45vzgLYWuFLMeAkLVeYZ6z7EyJveqrdDAWrW+IaDN+xeEZu/DJHFP4Q380GM45BNMKofImvmrklrbFcFJ88D100sLwYewqkIpNN8SrQTSwBI5y+iC4l6Ax6H1fi0oIM7y77rlBPQft3xzKLHeybo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JNjPZjST; arc=fail smtp.client-ip=40.107.130.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JNjPZjST"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQGTpzMtiebVcXVzfpTv8j1BIvDbslMwZhTevtADU3GAw9FXT7ItYCCg1ufK7JE76Z5O0oSB9tFflcuM07/IMC0y9Qww1ekxEysMtj1CawGm1Oy0EjC4jD2FmPgbRHZhycUB4PF4cWnUWoa5jmbMKxdK/NZGnB5Vo9fPO5q2cOKwCMrlRXgtoRwsLj3iOTNpF/DO9wsxVxoUAaOtS3kqkk/OFLgGCKXVmZcG0JX64cWXorrf/xi/qjKvps3TEJgivoYfGu/vq788gb257kpMsFuajW4nFj0UXqGWjgYK2LkKZ9svEKv5iRl2NVD3hwud7TTq6lqVfIVQ8BgKq8eBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsMt9sa0c4p4Y46QXkwY0bF6a/DFw93tMYR3OKT5m3M=;
 b=C01OxRE0WC83wDZNtvWoKKcxCcE3ioIfbJDauHk4sKrywuzaciORtLoV400d3gc7gEAk36YMGaIkvcp3TdzJ92ANDBTSiYH04R0PF/hQm/Ec4cFvK7HQ0UmVNmqFehnINxgcDyoSI1SlvtmCACmchryOhiGQ2PXE0RC3LpMa0JcS8iwOEj6XEWdRDhaew3bmQYZFNr4X5FKweI59GtFyR6e7yfcVqTzVLooTEgMUzUqx1meLdS9wEB9KtKpPqf5nuWUhiifoJ16pFl+bPK/h8obhKe9BJkM6p/8mqFptxhUPwHWsf90+pupdHjtke94TwL5xj5tILebTe53yUn1v/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsMt9sa0c4p4Y46QXkwY0bF6a/DFw93tMYR3OKT5m3M=;
 b=JNjPZjSTFbUmnmMa7woUBd7LAls4ivfepkDOaBgw9ybxunO/zUDwQFlgC80M58SKhFkdV0dsplsNGXRBnQeWYzC4lKOms2cMHRe9ttc3HNivPASMjD1clcvXiPtpdUY9INpotAvILrrQ/p59IF/THQCKy07dTBlp92X5CRNXCDNf7zEBkT1ar9+gGgVa5b6eRLw9Gt6YdsTXjPJ5hFOTOSvP0RN6ndZad1/Yq44/suAatoCbR8kiArwrefNuyrbq+3XE5lyq7P525hrn0HRP5ISHytIKsbCvxZz2sFqfT/zcbLaySvLCmERrulayuVyTYQ6nGFZUu45gjqu2h35+MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9312.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 08:02:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 08:02:56 +0000
Date: Mon, 18 Aug 2025 15:57:11 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, John Garry <john.g.garry@oracle.com>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 5/5] arm64: dts: imx94: add DDR Perf Monitor node
Message-ID: <ximwiyobrfsybt5tfcygcyqadlq3sogqkskayx2ggzibal2g2n@yl45ddfy5bvu>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
 <20250815-imx94-ddr-pmu-v1-5-edb22be0b997@nxp.com>
 <aJ9gimecxBtDLhJB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ9gimecxBtDLhJB@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: AS4P189CA0047.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS1PR04MB9312:EE_
X-MS-Office365-Filtering-Correlation-Id: af056dc1-234d-4ae7-71da-08ddde2da3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F1dmvViC8CtK5pZ6qXp7m6lFrOX7crA7mldWCXTBS9cX7rJXRivp9Sc3WShk?=
 =?us-ascii?Q?qtKOui8XkmM/sZkt8OEImr3hrQWvKq5ohUevyU8sbH8IJBavDHJoslEntZw4?=
 =?us-ascii?Q?uYtI/OBEmMnGFG3eaU+waHUh4vEIslJG9JSXTi7zveSpCR1bVOl25Ibt0Apm?=
 =?us-ascii?Q?e8ME1XOahZRQC6ckNr7wsFzYb0Ntbe906mVEj7+sizvzOODx50IrMisW7b/O?=
 =?us-ascii?Q?8ssNJmpCXiWz0u1o3TnM2R7lUDJSS8/vWDGWiKf2vv6Z+8H9oMQJJ9+OOYpL?=
 =?us-ascii?Q?vnolwg/3i9C7x5XD1ynbfxapXbAktqQZ8UmDhvEPOtri5Kdl/lixt7UU15qA?=
 =?us-ascii?Q?wOEE97ZYriH5WqsGq/nruCbC5apFwFwjXpRDEh0f4i2kFeP/U2tRIv7aGjlF?=
 =?us-ascii?Q?9AIx5uKsE0C2dYn95OAZeArp895mz2/+VBOkRkuCZR3Rnaxaz3A/agCmmMGr?=
 =?us-ascii?Q?LddEjYIUwSIW5ecCbYjYRTr/Z/kRH6MsChZIpn84XHGrKvRCg6MQYSoi6y22?=
 =?us-ascii?Q?5NhesbwRN/0Xd3XqPXwDi1/IqLOsy1w7VM2J8pdAOs2aveg+RCt+17WcAw0T?=
 =?us-ascii?Q?jVOZjcZKEdxLrtlc+LMSD4i/qxFBeYpdc1/ZdkeFet9e9zt2ZIALybDLcMmm?=
 =?us-ascii?Q?gl5xB8CGXkPxg/264Q9v/kmXIMpBVKWMllH48sQAvV6Wyk/zA3LhtXSMBDbH?=
 =?us-ascii?Q?gNT5h72LhaZyv6rAFGSxsnP9i31C5aqXy9pRbTjT6BVUZcoZTxaOFrNjte+A?=
 =?us-ascii?Q?Hf7aOLxjduv6dUGQ/EPyZPz7K92b0zytF18m3j6Jz5+XwXfx5UH/XiO9W1Bt?=
 =?us-ascii?Q?F7NAKiGsGdq2AbV/ac4BHACkrhgAczfjvztk8yqFx9g4D1gmq02rnUyr8zZT?=
 =?us-ascii?Q?egNwafSrJcUCV+kM2a5TaorcinK5cfQdG48gkfAoxLxcjHjRKUIR2FTgyA9B?=
 =?us-ascii?Q?YRYcSDXhXBT6Oh9jVyerBQ7FyF/wfPE7By8jY0IuHcVhLfIXazb0hU1GdHHE?=
 =?us-ascii?Q?zdmDRkuH/MVJcvYyVSPIezaEKSoeazTQ9/PtHCBASglGRVD03oNp9IPQ8Oy2?=
 =?us-ascii?Q?Ffj+onIySP0OdJlZJeVkKVOMdVWjykQghZLB/Oxxgq+BATk1l7eHSi4/qrDV?=
 =?us-ascii?Q?QtfkzPWGcCf5cntHigirNhmVR937MB0JzFF9iUYFEtE5YQmlvKHv9/mfUPzY?=
 =?us-ascii?Q?kPQ4aSx7TLRcWaWzAUhxBwwJ1L9TP/YpSSNkOZ7dOM13Z3MjQWEyS63hS4o6?=
 =?us-ascii?Q?SJgizOZ3ydWRTWKD0cB1atE9FTy0hyQhj2Y1kJAQdGvuZ9V2NqLa03pxwYxH?=
 =?us-ascii?Q?T8UmPKMpwmNLKBvYPXmC4KokySt8HmTMBK8mPQnwZAwjZZ+8WOkkc33Jso3x?=
 =?us-ascii?Q?1/ZZlwEFuE6m8L0GHkIZ8Bo3+khOUlaHflXByAckQPraFyrRSOGBmDnUaEu/?=
 =?us-ascii?Q?1QSJXkX4ej9bJmlu4Vxd/BjEdeqqdajf3gzQBV4uww/IJBjzZU1l1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kn+QmDxNtA/W5a3NxvoiYGociMQk+wTx72uvLyLNndEiMHQDXIPZ+8C7MDR/?=
 =?us-ascii?Q?EFqXLp8JKhRtkCmzWKAfeoOsTsahYd+T/hrByKLsEvKBx9gYc3EzvjJ7XZzi?=
 =?us-ascii?Q?BzWC9gnq8h2j24c0A9Taap1v46z6wa2Bp7SB4KdGf45AF9NBG1xbUVZsTkNP?=
 =?us-ascii?Q?9htV54CEJCK4/b2YAsXyiwEHdFfh6UdMUNQT2h619fkHgHobrVNtpQGNddyO?=
 =?us-ascii?Q?nw3sWUy+afrhfIJLXavNWyeL2cjhQQ+KcvdPyMXqwTvIys3Z+Y7qCWvYyrHJ?=
 =?us-ascii?Q?xGIYI3rLsIEs3OqcV+zKK+SVYE/4SlwIdHf1tI127dHUsgKPjxpIs/lYCcKr?=
 =?us-ascii?Q?LTHS72xZK5ngseVACgKwsY4QgThDciVzIdhiXxXDUIO2UaWNa4Ir7MBOYzRI?=
 =?us-ascii?Q?KWaU8W9IsOCq0M9TZytWz2T78hYxTjpeFL6EMNwveG4CXajKg/oNDDKZ7pl1?=
 =?us-ascii?Q?qGHML7tbcYDl+EXL9wwpYXFppmTD1vsq2oeJyASm+RS/ZUarg2v2Gi6eVFlI?=
 =?us-ascii?Q?vOP7LGdwGbJ7TTmBxFDZGwmaGGWP6K5f81Elg+FSqEr2iaBegUBPS6c4Coh7?=
 =?us-ascii?Q?kS0BJs/cxOi1jC2EHRuwwGytKi1FBzfwZUe5jbXevQfwJuB8QV4NIUnl7JKQ?=
 =?us-ascii?Q?4Jp6HNIKpgxnXD1OKEJc5M55Yv1u13Z4AZnWorCN/vwBPJEUN8kA8b4adQQg?=
 =?us-ascii?Q?vrESSOfMOijwpltv8uUPI/MlZo6+BY8o2My5XPzgydUFW+QIm9Ed4MlKg6u1?=
 =?us-ascii?Q?vSNGsdppJ2OVw4AOyh5VECl3WuDiyQd+Lz1n7r2jI/fC/jE7bpiUAo8cXRZJ?=
 =?us-ascii?Q?RVjl7jDKJJxth4bfF3ygY8EHwKbSp8xxGxNSeTvoxSL+GwK1bSrz9+ILamRH?=
 =?us-ascii?Q?W1AZLZc7ndNxRP1TQ81buIk1oS3OJxSRh7tMpKoHEmp2mxqLAOTOMm8qJZ5S?=
 =?us-ascii?Q?UWcwrEN9l030iML/51j5ZnkfPw0Lt7GNsKI2tJLNSs2tiaLgiu02ii57Fm0N?=
 =?us-ascii?Q?yZD8SnlCGGYxeeyELXm16aIzum5NTcQ1H4ez9rB4RDrjFv+AWaBIllUQWQzk?=
 =?us-ascii?Q?AK0nvSKmtNwtZgqARMHkzK1UoEcCZurQTMrryAnmkHfxUFqHI9mW2IPGrfND?=
 =?us-ascii?Q?b+RIUmUPohvTTimeW8mn4zdvqDlxlug9PJHMpgReDCAUEpkoEgTtgh+fAPkN?=
 =?us-ascii?Q?RbYkiBdwynq2YH5cPxkhjUMnD9fiqcvMqSu7Rp6rwn5PRCac/j0gMkS5FTyy?=
 =?us-ascii?Q?gY/Hsgr+HRqGFYJtiWuyrfRhcUiyhcvV6rMfo1uQxKYDtyqkBZBS84oRP8LI?=
 =?us-ascii?Q?XJIEricsoy6LO2fEqgpvNOfQo/VesduEWOlvfNaSH5BOEKP7s+OgW97r5MJK?=
 =?us-ascii?Q?t4tXFvmAlvHqUVCq7OBWbJ+YehuL0LkrRcQNJNP+Ca5f9zdrsaCiWOk6SPSj?=
 =?us-ascii?Q?3yBNmrmeI6LIH1RUvmFRmX6cMklWCF3S3heT4c4cQ1RM0ooyhV9JuJD9/LCR?=
 =?us-ascii?Q?O129ZKGdczTZYhjVdV8pyDG4o5MIEI8pEB5rg5+NUUIjxaPK68Yh1lGdnv/l?=
 =?us-ascii?Q?cgoEjTvnYe1er1lrUGs0oKmpk/cB9y0dfcrrn6lF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af056dc1-234d-4ae7-71da-08ddde2da3fc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:02:56.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTLh9nwPPi49Da1pXtOlPiQw4UVUP59bq99pBTafobIRGjlDI0y7ymR6rCYq1D/yNwve6djQNXrqX0JH2zgS5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9312

On Fri, Aug 15, 2025 at 12:30:02PM -0400, Frank Li wrote:
> On Fri, Aug 15, 2025 at 05:36:31PM +0800, Xu Yang wrote:
> > Add DDR Perf Monitor for i.MX95.
> 
> typo, should be i.MX94

Thanks, I will correct it later.

Thanks,
Xu Yang

> 
> Frank
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx94.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
> > index 44dee2cbd42d4bc765c33a9ce663ceda095b6c66..6a2d86d67200facec76a7880b4a2268b4191452c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx94.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
> > @@ -1188,5 +1188,11 @@ wdog3: watchdog@49220000 {
> >  				status = "disabled";
> >  			};
> >  		};
> > +
> > +		ddr-pmu@4e090dc0 {
> > +			compatible = "fsl,imx94-ddr-pmu", "fsl,imx93-ddr-pmu";
> > +			reg = <0x0 0x4e090dc0 0x0 0x200>;
> > +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> > +		};
> >  	};
> >  };
> >
> > --
> > 2.34.1
> >

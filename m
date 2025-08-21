Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2F4315A;
	Thu, 21 Aug 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787926; cv=fail; b=i824UjBddOEXXjfzAAJkcY83hP1Cf0hWpvL9v2f96b5w9EjyJn7nR5PxGN7h9se42khbx0PmMnXmokT9cjRkkYYtkxHC3pMAjbyuJe2iFutUfhwusazvxMrb3vhTV4kFKS4TjFZsKTLWp7SNqmkfwWq7wGC0moYDIy9SJAYic48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787926; c=relaxed/simple;
	bh=inrmSUggb3ZxQeUKMCcGVgsHEn1UT5kq7wXDCGnb+00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jFcfLc/RiJLjrbUjcKJJBvpjZmflxhWbwnRn2LjdcyYJG7igbatguSxDCRVZq1Eu3xC1m9ljbY7gKzzrpBvfLp6D+PW0ZfuxnHn/t9Rpr4K4mr9sX+2cucRu037Sx3uSisrvKdCwAnw3l3vbA/5OEQxN6zFvPDGng7C3IDXgPa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=leu1o6Jb; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="leu1o6Jb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NocgLgX3eOKd+poRY/sYIUU7ZoaZAzNk1TsPwOct3PH2KrZOytqCP/3JM5//XekxrffhyfM/3eXhtnpY9uF94Sy5hy0w0srX1opmL4GNivIPHrpTzzeJSNsD3UWceBTsNk/EJlgr+9khKXbDyLJ5Dqq4YGTsPgWcpWm+w760DOcdwKO4Nm2tIGJSC+aviLLxnGgHYQyWqw/IoZfuIlXgySJs0A4CsYrbqw6ybIW8LPZ66OB+MElAAIn2U5GusHdhy6Gg6gh6uzzV6lKchbv53it5W8CLKFO3ZXY8+Ip/syN9ZscQRYnPWbMRKAEFYnbZJRHsvL6gV21WLslLWWuOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+Peo1mwJy3FAXYQzXfD7QOwpzlTJw7BfAdWjlOsskU=;
 b=XJLW5I/oC60TGdyNO+1uvLlq8uVq9RHSvarEOGFc5PPkkUIqsv462I8s7WAaCQSwWFBUTiiRQJsecQCIZC/vre2nbczw45nTrnZdUvnwYkO2PQSHbk/o+Ja+HtIEK9azDaEcaYGazbUWlq0hA9cMB655cDgBleV56WOB0aeqS16FkQ/HwA2dHhQQmfClQ0UvzjLvu+UCFCXWuaWPExFme+sGy8wlvKq+htw+wHLASGFA1aVZl0YlY0l0+NJsPWgKy5c8lLZQBcfd27NJwgzoPmN/bLGjWsEhs/o8FLRosYpTjfnMUCyckMuRrE6KRzhdJLzA5V4cEwsu0JBuOzdsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+Peo1mwJy3FAXYQzXfD7QOwpzlTJw7BfAdWjlOsskU=;
 b=leu1o6JbiLebJ5LNJVrmzZReNl9HDmCQWo1b7gDx4S6F3usx+7H3Ff1rQtldh/QsBjwmqnhjEwCbAFbhOjNmHSMvDKPm2n/2+lrJ8jI7gQnBvaEd3ZtjvhRcRhwSk0hLOT8hu+wNXaUAuY57Y9d8D/BPnYTFIpU079cVej5nn6zJrVWieDyVctqDo9QMAwJBIS3w00XURxT6gpjimMR8Qi7Lcq5WEAU4Dda4bmK7ff5CziTGpfTZN8GYb6MBsn0lwTlV6XW7qkC4pGuRAncL3uM8g1RdchM9/8bdo1KetvSCwOl01G4PR7tPkHLy+Yj5QkvwhYFhvOZNVa0MYTaB9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:52:01 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Thu, 21 Aug 2025
 14:52:01 +0000
Date: Thu, 21 Aug 2025 10:51:49 -0400
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
Subject: Re: [PATCH v2 5/5] arm64: dts: imx94: add DDR Perf Monitor node
Message-ID: <aKcyhYxVdtpJHav9@lizhi-Precision-Tower-5810>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
 <20250821-imx94-ddr-pmu-v2-5-052c6420605d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-imx94-ddr-pmu-v2-5-052c6420605d@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e66f129-2e42-4d8c-5731-08dde0c24939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1TjYSArPd6Wc2pybteDyiHtF7sRg5v7C6ksltyJJ0TcvrQa8Bgl5364PnBa6?=
 =?us-ascii?Q?7Df7sDWull66rnhD9zDwEnoXBlmVEdJv62lfTxj3NhyNP2djA6WSswI+l3xW?=
 =?us-ascii?Q?Vb79W7Uz74LDAHRY6iEIisUtmMTGzyagNimMBBQmWmMQeX4J1IfcddruKCwb?=
 =?us-ascii?Q?16sXMhdhecMynTxzkovs0zJlK/jI2m/4mvbECRAB7EQjDjiU+2zk/FrmVtEH?=
 =?us-ascii?Q?vz1K0R3VS2m9TOFFnojEcoQG3f/BwKv8TwhkS0I00sc62eI3YlzwDAYeI2iq?=
 =?us-ascii?Q?hefASs1EU13GSOZMtpRMTfirG5yBj5n6KZadAM2I4TawrrllClS5BzxD7CLj?=
 =?us-ascii?Q?rWoMGpT609i314yYLuN4ON1hqLXKRmxouTQijV+9P700pHdv7B0NhqPIcku2?=
 =?us-ascii?Q?ln7K/20q7r2+xBgWWRTL2foxNZtA0cSXieCBK0mTDUglYkSO6cOnH5exJ7t0?=
 =?us-ascii?Q?4lGzGvDJoGDOVjGwpQwP8oY5Xzfopvz4OwBsZHr2VP7Wy75ryV9ie5ao9zw6?=
 =?us-ascii?Q?4nAICyLv6SyJaxvsjbviJngPPFVcjqw4G2nNOaIGqYXhw6k6VfvCCAz/JgNA?=
 =?us-ascii?Q?jUTyZkJBDTf74mcr4GAekC7mdEwEU8QRc7mFIor30kaRNm5FD9uUUwZgCMZ2?=
 =?us-ascii?Q?Awn4M0/3qq3U7dpBz5qm/CxlBM7huJO/7D+S84DS33B4sPTLhH34O+cZtLfS?=
 =?us-ascii?Q?VgTwKkNP3Fod5faohQNXJm42924WDpESFCpw5+VPFxZgxpepscRE18ZnBDan?=
 =?us-ascii?Q?eIErGdsIPu0LjjyQEZNnlY8GmqgW7xojBtEJ44dOF3/b5+CqU8XRIm6hoI+T?=
 =?us-ascii?Q?gkewV7K3/ZTegyxvo2tfbsgE1lGZjE4nH+BBHgE8M7PSryTCih58qPjFecCB?=
 =?us-ascii?Q?xID8OHPAy+ShMewCDboKwomu2DckM8V/pddYJy3TEvxUD1hnz7fWV9CMR1vr?=
 =?us-ascii?Q?juTFyY6zpXMTI/Faxp7JCatJg+o0XChxd099IOyUSqegmXnUT1wZ55e5DBhV?=
 =?us-ascii?Q?o/xvHN6GLj8B7L/LIkO2IXJkNImB/6XAC53M+hTe/t6E68f+iqBiNqnmFF/8?=
 =?us-ascii?Q?XX1dSXxmSq2geEoliuwuQh7v3gnjH3z7TrxKWw6o4NGbb7wjhK2mkfJK2bqB?=
 =?us-ascii?Q?NS6aWxP0M8jUWOGmLnYeXXAAJlDLkg62hzRbEQza3NCl9L9y38bPFU/o4QL0?=
 =?us-ascii?Q?bVEzUuXKNcjPMkwlp99FCkT0kz4/stKC0iApXu4LbPV+GW4bsGbwm+D6NeLr?=
 =?us-ascii?Q?YBOeqagN/L+fZtnXP9X//oy2jeNudaFiCf7zmeBbFXCCix/B/PDwmOPUQ+Rk?=
 =?us-ascii?Q?bAe3vzV/n74O3DqD+LrX8ncZFM1dN0ONO/S84p7f9hJniHFZNTBbEOCeytDb?=
 =?us-ascii?Q?ot3Zg0zEmgCuxgM7V+dJFQTpdRsRqJ2PDJs3t5QjUzoOyrGPqPlrulpqLLU4?=
 =?us-ascii?Q?LuoISFbg0msqWd6WdfBHPG9LZ5NFFBV9cFr+NzTGuFjWBxg5Wf2Iqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?77PJrsFV2+ym1g6dAn/mQd86S/RHJZFuhGO+yl72Dsdkk+s2utBVExgwuZc9?=
 =?us-ascii?Q?+wltZTdLLB6BNdrzQRa60MXeFd9ktwXcuaZtEnSemUVwuq16YQUsDYfkhm3v?=
 =?us-ascii?Q?OiTHGqYH8zG6zOAEVV2kbHuilEYTNq827fPBMHi16D6WDXtoXHdEI///gZei?=
 =?us-ascii?Q?Bgulr0hFBM0Joh8TCD3zEPGfv0dg77WOVt9Bg/wtldpFcIPe5pLa3TEUcicv?=
 =?us-ascii?Q?ehdBDvnVl2UgMJXhSu7A9Qdjlqd0MuHa1pjNeFGK7JbMZLl2idKLs/CoTCs3?=
 =?us-ascii?Q?mlPGLoRxMchdGR/LDv4EYfmuyZBMLw3OwnbpoRRBWJBdZdX1PbqiQyJFhOjQ?=
 =?us-ascii?Q?IuTOdCe26Kywg9OcUiq7gb4UlKGOvIGxTUtxPIaXx+T0TsY/eouR9KyxB4WG?=
 =?us-ascii?Q?I6+tdDMxZ7EaCEF/qASbRfcHKs/69/KIwzLgkO6LgPfp2QkD9+jio8FRJSmi?=
 =?us-ascii?Q?xhn5XmdrG1ne5t5UXKirluzBdr/FyZiyWTKyZOnjAeb6c7c2SzvWgQeguAgS?=
 =?us-ascii?Q?Ca1k7C9XRioSC+wjbHcRS18ONTQ0nfx5s3asxudl9t8YDBEpKepUI3dfYzQ4?=
 =?us-ascii?Q?dyGCHrQxjkjlDvJfwRrALYYrhwzHaoS/TdYxWqL7i30nYMDIpZG8S39mQeip?=
 =?us-ascii?Q?szclhuz7zQgqkHQcoa83B3v9CSsdHpBSe5ps1o80Vay164MgazWZvkJ14jL7?=
 =?us-ascii?Q?XdbAU004S//5u4DIJ/7vB8FNv7UNhWLcFX15pZwFrfblxII1KD+F+xRVc9H8?=
 =?us-ascii?Q?DAacEihlZ/yVIK74G4GVDHXGWl81Tbk6AmSdljDXlvnRT3+DKCfBniAgaChf?=
 =?us-ascii?Q?uNHu/uPIaVmGdRZ79omupNNbUKVx1ECPqoa878vxFK1Kqcoaud+iFIFsR/ZB?=
 =?us-ascii?Q?gWuMwW/H257S5MVUYGrqjKfhzXzJaZ/PJQP/6WQUD71/1LDUo1QvZfvUNxXe?=
 =?us-ascii?Q?Jyw2QbF/a8Q44no4bRhVs1kiwqLct/zc58DiTeVf8dcXsp7Ll/7xomIvPxmN?=
 =?us-ascii?Q?Dw2LuOEosDCOaFD8W87aFt6vnrxBlk1AZjxdx85f8ny+L1v4AMXBMyl95xh6?=
 =?us-ascii?Q?98MFrSt/YROsiK+HPGRgdnmKof/BhFxyZt3aiNjxKCLN1Cw2+MGb+ORuw20t?=
 =?us-ascii?Q?p5X1UASffVEiV9n7dsA+KwKMMhfARB39u5o8QA+aj5pQRvyh+D2LjNPjHOkG?=
 =?us-ascii?Q?jPba4qYdx5Lo7OExlxv2y8MGz3iM+CvKu1gSUGnJVT8dICULiWQop3bpM5CO?=
 =?us-ascii?Q?tQ4hKX8256+zeTR5/BbD+9OxYytK6K559UVvIvI4snQ8TxEVdLnCTO+bnipn?=
 =?us-ascii?Q?UdRdWV1bYC0h3IRCEvs++5Gs6ZTZ5FtoPTHnpSI8l0iI2Uox3Ck0so4pmw0I?=
 =?us-ascii?Q?h7FLdqFbGpph8SjsNETsSgpYTJw9UvW98f4u+PgyQsDmu+mQQ8h4lAPmFfPm?=
 =?us-ascii?Q?0O84CHSY5NbP81MFRSBwYWtHP3e61wOZfsoButMOem37GFdPQOHLe1dLfu+o?=
 =?us-ascii?Q?Gr7Wof1xUOTSTJMMeWzA4sgsNze77cnC7fRjSG/+AnKzK0qfSrhLZTNGYZql?=
 =?us-ascii?Q?6gQHwydvO+VwFYNE5jxXV4cQompKzg6ioRkt308U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e66f129-2e42-4d8c-5731-08dde0c24939
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:52:01.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zyZdbLE4qJURH0CGf0XCBuAc16eFJvR90M6wurKa6i9fkn5d6XFXwreBzbCZMPPL4HnpzmW9psZK52sstc5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

On Thu, Aug 21, 2025 at 07:01:53PM +0800, Xu Yang wrote:
> Add DDR Perf Monitor for i.MX94.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> Changes in v2:
>  - fix typo
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

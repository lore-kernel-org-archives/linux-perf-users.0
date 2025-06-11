Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012008.outbound.protection.outlook.com [52.101.71.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BD1A08AB;
	Wed, 11 Jun 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655562; cv=fail; b=c6lT1nNZ9iNoP2kEC3DH4eFqqvRd19sDVW2DT0pJSpbkUdw77GNfZ4+n26GBhBaV9Uj6AGRbWLug8ZEdAgCv2nWDvYdDjDJ5Tqwb9a03lbNU9ho/i2E0DyxQ1fHJ6F2yGnxoGIdQDML6FEeBSuqtw5tIerVdNeJYRhBtYdsk8DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655562; c=relaxed/simple;
	bh=0Ya3+qvRk39tWTH61BV0mXGOq4yxsfeo+npcCzWr6nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iSiCOZuOsMhjXAz6c+YbRZllBbFHDMWrO688O0O89adzeKrwE7qcaJMcoCDPQ9vLijC0zPx7yl3xvX3jYt6LF7F/o69bWR6efB6QyI5sIzdQCdqddf12g/vKHzUISv1xls7dKGyx2J7wk8VKHSvgla648hQ5fAxddPGH8LBmp4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XjRDOHvV; arc=fail smtp.client-ip=52.101.71.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XjRDOHvV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhBWp1OR1uXZwil3Sac7uhDc7GWKmu1tg9to7/fx2Q4knnvo4Qp8aYtyINR5SGFMZJH/xGZJpK/z/9IIRR3i+EnfX8RvL5tfBLSV5bqBQeJbzoqwj1I6ar4Rns1OF7mE9kkV/YbgLxGQUFcMeD7FQv6POHxWkyQEN+3B1S2xPY4BKE48TZUU9TFQRUdzycugpGmPlhWyikxoUwdhWpAtQeqt/vmj5oLZqx8Gq9GGvPKbzrNx0R8w3HCCQQZQBoA8tSeyJ9RXt4IzoobNGC63vF+TH3zd6LQTMjqvBk2ya/dbaviyPg40P+FwtxT5BWGdp3F6FBES3g8TMgXfGGTBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBIK3cvKqAaeYjL3YEA18ixtcLPLAr+Zd6M+Klrlk4M=;
 b=t4fv6nYCfC99omm+RR3GVlnC8ypI54udr8faif1WDTkl5xpgbAN72jqHjjqoVLt/ey6GMbtPLrAoowdHIen0ykRDPuUFJeHJwPL3gyiLGm+Hm/NJqbDX4tfO4Vu0AwlcS+SmQa4X09bBFUhk/bzBCSvSl3KF7AOGSjEU3C0nstsUF3CQDBl+Y3gfYVUEdjAE65QpCk23yyX4mcgpESCBzQnmrc9Qy7SnHa6hiAP6h13oitI97huaiGXPiGFqItkSDn1vBPREZJXF96TERs14AALKAY14gIQee0lvkPli2sXKac14baRJqltD6dLKIlLFyDeA4/MGxpjGAXaE8w0OQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBIK3cvKqAaeYjL3YEA18ixtcLPLAr+Zd6M+Klrlk4M=;
 b=XjRDOHvVVWLBT1dz4MmwO4EM8fpN0G0TSUpGjRSCm7yJ2Gy2GJsIbgGfyQyEi0LR4e0+vYLKJfKTqPR2B3PIBTm+zAk6s//UyI7ZQmGlMELUqQSVTceuIOcxz1y4gV0h0F6ov0xHZm2PlaI+eWYZ/c1RGqKwOvLRI2tafO/3U4OQWDF5RzNw/cJ29fz3yPYOc+IAX09H040YgzWzSlALTT4PG5uK5V1Cyzfh67wp82BeU93CrC3K79v6M/THnIH0Q4znOpbY2zcblPVK2K9berd6qGWck5IPqSd333ikK3Ktc3TQvR8w0I+xOSGtDOz0BNPhwxqa9a8cvpypAQK+sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10676.eurprd04.prod.outlook.com (2603:10a6:102:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 15:25:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 15:25:56 +0000
Date: Wed, 11 Jun 2025 11:25:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, imx@lists.linux.dev,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf: imx9_perf: make the read-only array mask
 static const
Message-ID: <aEmf+RMzb1rZbeLn@lizhi-Precision-Tower-5810>
References: <20250611133917.170888-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611133917.170888-1-colin.i.king@gmail.com>
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10676:EE_
X-MS-Office365-Filtering-Correlation-Id: 685559aa-a55c-49a5-d350-08dda8fc42cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KP90sTrguHiGm7Gu0ea1YDnpRixBS/VscCVVa1shCPTDTEwbqnLT077qrbtW?=
 =?us-ascii?Q?mMbjaCyY9ZX/2UZxVYvDuqTh4RzWqAAGK0fETl/YSXF6uY0UG5/xQhjSYmUA?=
 =?us-ascii?Q?80T9ilf2TmaIj5HBBt0PiUpGu264jxjvAyC5d8lzoygzu1kAd7yA9kTivOBe?=
 =?us-ascii?Q?rBAyKEbRMioGp9MoSqntHza3ApPd/dXdTDZAudEQQIXuJ7EqDsPquOjrKNQV?=
 =?us-ascii?Q?4rZ/U5NJZN8pJxdF0iGnn+TDAvOnkPpBdVJNdmzRBNIzdea808OgHyYU5l9Q?=
 =?us-ascii?Q?Cs1BqkexqBANBPy/HPoizorfT+iuYQUCpcP8PJsgpaCwqiCtE1A9co+CBVAx?=
 =?us-ascii?Q?tNaOd9jT9nEAGsqpdf2WerCKuH939dWKti7uM/EW1ZiIdoGKU8UF8Jv4ZWij?=
 =?us-ascii?Q?b/KMc1SQLX4VHmlw8TNW/ULDj0rk/Q9rrjW+V/yDJJM7OM15JBtlCnn/dEuU?=
 =?us-ascii?Q?+vIubBAhgrqTgkVE3G3WbSj3OxRE7wFFDkfUw8JMrkTEUMLN56owJHJEql2N?=
 =?us-ascii?Q?R10i9HOkkJMW8DbEIRYsw7dcZrorI5xP/vaTq6QiP0MAbtuNNVXLgWuhfvmm?=
 =?us-ascii?Q?EOBNfb/QoE/YBz9fyquH7O/NXA2QQFXKP4dxMrKMPC7GXDtgXxI9lAi9Axdi?=
 =?us-ascii?Q?Zx2L+lR48Gns4VHxZ8F1W48Bq3pZYH/9Mv4kZF88JhNwA3Pzoz359l1c2HOt?=
 =?us-ascii?Q?Z5vaHnMjAtZjdZX5RuCjFa3S9/0Vm3qzzd5hjTpR7HRqiLkYez/udx3U6kd+?=
 =?us-ascii?Q?mxdI3+g34CX0nyrqBkH5ekVn+TINF/QAArXYxQrfwNs790wgzkRfmzerfKp+?=
 =?us-ascii?Q?5a55rboKkyD1QV8u6ArNOFiksv4CfT2GSt+cQCBOLL7yAHMKmy7ipl+UqrjZ?=
 =?us-ascii?Q?uNqoEifz7lwasAj7VRzaAM6jxbv8BAf6T1QdNBFm4PeG+VqZnXIdMu2zfCrC?=
 =?us-ascii?Q?sXDyrPIqkgtof0OAlbzcVTQcsdHjakWoBk1UxpjwE2YVv9rKCrAtSv7xaqax?=
 =?us-ascii?Q?wEy/W7ar7HoIzkTteIca4JkmmwSLNjal/qnkfUd0zat/tRIAgGdGEZK5t6HH?=
 =?us-ascii?Q?HhNQ58wI5dN0KWsl1hUHaHJMBFrW9Vf0BJUqRPIuJjVGkchfhlkt/wI98IPa?=
 =?us-ascii?Q?Uct8BImK5cv/fwbaxldDMwxH4t33p5neyNHEUyg65sF14NEG5KTUEy3q7OZY?=
 =?us-ascii?Q?/M3ru37Mf2lXIIuvodHuyXbkC6njg0dDTIMorVUOLbrYZNes0/4aSOmeBKPB?=
 =?us-ascii?Q?GyuxX1Hhdp0t24Y/fTIRQ9nV/szMa1+s+OJPxKTAYdLCiy8VNpsaeLqB1YOE?=
 =?us-ascii?Q?IL7/Kht09oD1eQ1yJSzlIScXYykE73j9ja5fy0t5t1H92i/P07f8yIj+5Eob?=
 =?us-ascii?Q?1hY01m2Uq00NOmJQo57n6Qo+UH5TCgLa069MuTQ/dWouYHzNK5aX4JoFmfhw?=
 =?us-ascii?Q?/mZmDuj02LDhDpQaWPz/6Gytru9o7C2HIIcNuTHy+Y5PqrvzSP7ZbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iHjNJEOCk2c4d1XDqDmq2v577xtJUDfiwJtrWMil636qI3Ek6InDDlHOQFiM?=
 =?us-ascii?Q?xLwB4qSrKcXqatQi7NiAFbFJZW5LQQr7iQkvsn76UWwpiRhasa1GzJaKOUev?=
 =?us-ascii?Q?FAzyFpM5pJmLx+M+qQNwrIi34N4XXaiBcC1jlK1A9xyzBrftReIpJqaJoJHU?=
 =?us-ascii?Q?VtCGvzwknbs+zesruAGJI1JslBbFPO5AZwzQ07/NKapIZHX6Wx5qylEt4SHP?=
 =?us-ascii?Q?xL1FJb6qTb9qIqtKCO9No6IDvl8xI8xdorIV/SSer1Ckz1giyuF8a3S2Y6+R?=
 =?us-ascii?Q?m+xkjH2gg6LIhF6dymt6ixbHAZ0TPJu/kUoW84w/RxK9JaH5628xknV9WjUc?=
 =?us-ascii?Q?j9nD9Jkw0wL2j+89QIZmTi+QZfXSuF3a9mprZYJw/DnZZEETD4N9YPKerQac?=
 =?us-ascii?Q?msOzJCH2ak7HTT/9J7Bx1lPO5RXNbyMhHjiXiDRdab2V7BTbN3GSJCu3tFrV?=
 =?us-ascii?Q?NauP2ht/hN1XYcUVrLpMo0KJoLQBi2+MrIdiVp1O13gy6F7WBU4Se4MXzB+G?=
 =?us-ascii?Q?unUDvHNSeD+PdFak2QeZhNH2L5aLKX6yastpugWdf14z0q7SF4bMSOP5qzgG?=
 =?us-ascii?Q?5HClVzWF/VauEkzK0bDhuKTByzwnrzMV7myAHMZu1rUJ24O3u1ZGXi6AcDHE?=
 =?us-ascii?Q?E/nztKDgFswtbjg4fjMBhizd3QO3h76WWxq8xodgt39ono+ukj1Bcd5p3mQo?=
 =?us-ascii?Q?e9FpJuk2JpHRAviKeCW/F6eMPND/ySfMb0bn/EvwTyo4ScBKFEGyNYwGWUqH?=
 =?us-ascii?Q?fXu0KjiC+cIPPijH9wPFz0rUArK4pdXgYg6z1njd5VVLSw2z94tB+lSYOZZX?=
 =?us-ascii?Q?cXobk0zLofarED0UeJK3vJO1HXcs6aMU1FnzLIjbvRUJ/fODGsO/FPsV5+po?=
 =?us-ascii?Q?/tO0xuDsCwT0dKGv6rIhlVu4U8ENuU1UCR9PZxza3133ostWGOez3ayyfHJY?=
 =?us-ascii?Q?Ic4ZqWpN9S/GRQDCXtIQT5BSyzu7mSIVjlSyL2BkVS4Sp7aXan24cYTj24v9?=
 =?us-ascii?Q?dQVGIEkO49u9Vx7lGVGqFwpnGYNFkFmGRivW8Qy4NcQjwePhyUpRLePPCc79?=
 =?us-ascii?Q?zpCMuUa4JE5P7goqyfYzIGKbi6QJx6wMBiYtdhyKDewvXx3ObReUpJJKpdmx?=
 =?us-ascii?Q?CVorzmQ/QY1xXMpYbVZ6yHkrfvT4fnpr4lBPQnxDL+RxeXRAvrlm78lOmqJL?=
 =?us-ascii?Q?QfKFAQ9pADeC/hpxdw1FvJ1ZRq7LdnlpE+b2H+xPo7IUjLPQDMHgVBVnRL2g?=
 =?us-ascii?Q?DMrCvkzvtrYV2PTODl/WBJ5LxVspWbtvnzuRUdWE9zZ1AKu3o+EJ4/zedrrr?=
 =?us-ascii?Q?kgDvWPS/+7wglMdv1kLOVhBqDU2Cd7pKeUOlZT6QYBVPjIAjSzLk3Zdc7A8P?=
 =?us-ascii?Q?4SwkUtOQ3khhzQ65bAZcaUs99kXCoSfb4s3TmoVR2FM7TJ3Gdc8ENBXJKSbF?=
 =?us-ascii?Q?Ouf2lXcb2hR1SQ80VXLCDJoB/JTMrMP37bMDhNxyilNRfVmfmvSALMQC7SNX?=
 =?us-ascii?Q?zxLoDFWfrHENLSc8VrzSyHCReB5Slu8JpUF7zGkld86zv+iDtoTYsyes/6X2?=
 =?us-ascii?Q?/TjlhE13EAs9Q7pmmr1HOjIvpfLs0dalYx+s80oG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685559aa-a55c-49a5-d350-08dda8fc42cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:25:56.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c1MlryUbw0rb5PI3uMiJW6dKCOnAp2ADS7NYpu0ASchZ7eODo8l4ppFbkKGIg/lsVzASB0ScZnbdtbQtt/4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10676

On Wed, Jun 11, 2025 at 02:39:17PM +0100, Colin Ian King wrote:
> Don't populate the read-only array mask on the stack at run time,
> instead make it static const.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 843f163e6c33..267754fdf581 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -461,9 +461,11 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
>  					  int counter, int axi_id, int axi_mask)
>  {
>  	u32 pmcfg1, pmcfg2;
> -	u32 mask[] = {  MX93_PMCFG1_RD_TRANS_FILT_EN,
> -			MX93_PMCFG1_WR_TRANS_FILT_EN,
> -			MX93_PMCFG1_RD_BT_FILT_EN };
> +	static const u32 mask[] = {
> +		MX93_PMCFG1_RD_TRANS_FILT_EN,
> +		MX93_PMCFG1_WR_TRANS_FILT_EN,
> +		MX93_PMCFG1_RD_BT_FILT_EN
> +	};
>
>  	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
>
> --
> 2.49.0
>

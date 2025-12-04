Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023093.outbound.protection.outlook.com [40.93.196.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB72D8377
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764892114; cv=fail; b=kIp8S4KuVfznXwffGOmrm4mU7QZRSfFjAFd5qxIPxqold+lG/pryZTTV89mjwUvldJW1ohWOjmtbZe6dfW6UVriqdL97SD0tyJC7roxbo2bOJJ5R9Ob5ANSDgmJv3j4mp6BVMyfLpqgKADzPq57Sx+4AVxWdY+7mn00slPwXXvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764892114; c=relaxed/simple;
	bh=KwfSJVMmJ7s8a+rNxh2Dby+O9sf8rEwcVpW4/ta8BTE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=aqcUDv6nruugv3kweiOLS8ysKzNPPMMOhLVO6LtF8OkkjZJGhnaLDjnTGjgveK9WZduRQ7ebJCUg6Go3X1mbg3x/F9LVJqnK3e2a4NY2pFYa/kHdIFX9qz+ddghXhr33CcHQ57MqBYP1rBbaXvGw3ANNVhl6IYSDPEiUSTIUyNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bgt1r9Gn; arc=fail smtp.client-ip=40.93.196.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bgt1r9Gn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2rjEiywwkXK7zhoybEYd+stgA6o4fUBnaoXBWJXqKOgWLDgWxKxDT5oSJVzHXPzwFzAkpCbtksrzHlf31Ln6XoDxDb7u79Gw9R8NTMCzXECgunas/E4IbtP/MQ58eQ5f5tAKJVjsZM4K7gSWopCERtVVZgq3HiSNyMoQ0ntEcAW6eUaWkeCJlFiX6YsCvhH3eFt2/FfjQXklMCF72ET6QlFWzb7bDYKsdRfm4+8pNa5ngd9Wc79/XyDQdKfdA5gmGmJ2Ej/aS85lRIlKHv0UCBRtySLXgiLoc0o/jWTpURG6mbfCYU8S1Q9pstAsKVmxaR6dWJXBU5NpLMrPI04SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzrE8FTUwnCbjFS5qvXpa33THWMqZLigP5xFEUd51mI=;
 b=XIVlzU5oLwxQt9SoeyV2A9x9WV+woWM/D99O+7oIaA+vER7FgiWkPFKY6AgCTP1/gU7rJ0JQelY62BvCDdMBPRuoIJ11E2vcOgkDbU95+m+z52vlhwkWHPXwiPJsPa04qpfLsi89STrGmYrmSQyPIzBJ/WVqBkHO852VquKaMY2fiNiaOhf+8/OPFtS2UZyO47b4k0TGnbBssJM3yIzlVw37bC6IcOqIH0jYISlviBt76+vIeUqp9GSj1nSyMCE7euFb4ZAkHO/PxLgqFoiQ+wMpZje4ugbQlmV9chKbUrEgw3LkE7rrEmScM9muV0qib4PGH5Rji7NtrNcRL05qFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzrE8FTUwnCbjFS5qvXpa33THWMqZLigP5xFEUd51mI=;
 b=bgt1r9Gn7VL9xbRAVSuV1CW6h9HCbDlCLJjbuKbRQXyto8YXOL24sU/Flxoa89E3K33R8l63EN/bYpUoAzr4dKa5g3vH4H4HTzZKoqNL9871b1FPbz5aSjQwr5OO1+yylwTeiwu0l/FRTZ/qqavmQGhj8wbcCsdYWcAWahzoROo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 PH0PR01MB6214.prod.exchangelabs.com (2603:10b6:510:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 23:48:29 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 23:48:29 +0000
Date: Thu, 4 Dec 2025 15:48:25 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    michal.simek@amd.com
Subject: Re: [PATCH] perf/arm-cmn: Support CMN-600AE
In-Reply-To: <f0c6e66df6b74f073df77c00bdf9ed560ca9c703.1764002394.git.robin.murphy@arm.com>
Message-ID: <9fba2a91-af38-5af3-9209-facae7c9c255@os.amperecomputing.com>
References: <f0c6e66df6b74f073df77c00bdf9ed560ca9c703.1764002394.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|PH0PR01MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f16881-5f2a-4753-f0fb-08de338fa013
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vLgM00EYhs3tiin6h1zw75+J7EXo2MxiG0oCqR8OpqOSsrOqzhxC6LnnCIG/?=
 =?us-ascii?Q?OhbnXie7IiVx1uvHIZIv2gR7X1AOYkA69plC+SsWRkkT4kKWzq+Zz9uI8DIG?=
 =?us-ascii?Q?BkowyPkecovb0i9igtDVgNUWhPr6c18IF1vePHCvEZ5MstaNccGilLotGFaW?=
 =?us-ascii?Q?Y75vKO1SUYDRUHgiRfrUciZcc2TBj19fONlx6Nds1otcsWJpbFnsX8wYJuuJ?=
 =?us-ascii?Q?hbILJVNQWJPxP6AHzdZieR+pdaxozJxp+1X1cXDAqbXmnPwOm/wb4nwxnE5h?=
 =?us-ascii?Q?LAF0t1sbNJ08R6igoxDZcw6Jr5ic5PhNIkm0NYEOGy49N9Wd8cE92jW4IHqy?=
 =?us-ascii?Q?elLuoHZGYgIX52iyFNq+VUlJ5r8XkSwqUL6RjBQddJK5NtNFTG58VBJng87i?=
 =?us-ascii?Q?j6TjojV7GkzxTfGpZol6ZeXEaIxrcM6vQvneUvtYpiNBIh12wkW03zqekAxS?=
 =?us-ascii?Q?S3TBsit5c8OF26V4Diow5ruY7XUMgHxarAT/i+xE7wHYyMd7KhxGbIXiI7rR?=
 =?us-ascii?Q?dOYWbvYIhwbYVX24x0uArF6WOZIa93fBPbydxMpUsyKycsrHnoqGNkrXvdTL?=
 =?us-ascii?Q?YPA8brKqy6h9Ww0cZvjpS/3bX8c2wMV9dmFkwqH1vnZ9ffnmrKDjV333ZJPT?=
 =?us-ascii?Q?ATpX/KBI4h6oCjXC1liCP1NdCfdACjA6daQ1aEgTbdQiY8xXxTVhCgc160Ro?=
 =?us-ascii?Q?OX0Df+DBQW2z2BE0DtFBzcQl3sV4Yrx2f3WswUaP4/Rz4OBYV4khVAselIM6?=
 =?us-ascii?Q?OfEXdoo6e7K4XxRA5ABy49CZqvKyjI9V81jN4gb0Pjssia4UhfgymoyPzI1w?=
 =?us-ascii?Q?0rs0pwlV/ipszEbHQO/bIBbeW22nS2f6VtgdKqMKU+o63fWgFYBucqaExdeW?=
 =?us-ascii?Q?yIyd70jvdMxR4nmj3gt/4VCfh4C7oCmILoclwarswGb2MZxWlDiO3Qh+CbHg?=
 =?us-ascii?Q?URe2rc9nL7N9cI8GJeJ0gu8+CoEA9n4Q0nDgsfI9BpwGqqg+E+/r/bqe45uD?=
 =?us-ascii?Q?tV32ffJ3LyYR7T3Ht+Wuj9NaJXeAqluSkkpvZS39QDK0f4sVqurenHNSpqxo?=
 =?us-ascii?Q?LFJbiYkuA5TM0wsBTO276qT7tY6RYqhT5+BtdT/hU7GMH/HO388ikAl9iWUO?=
 =?us-ascii?Q?Hd4Onf0W1gmacZeEK58Is7loPf5IYJmtjgaBAgdzp63WjQraZIU6FRAlSj+K?=
 =?us-ascii?Q?x+SQeFEbxAqVWMBjnW5bLE4k4aJXL7Tkfyp7f7smDlwTpfJDecj3lamL3dUm?=
 =?us-ascii?Q?WEHI7RoVxJGpNJFQFmOiS1V+UoqvsnQ4KRI1Q0D2PVAeBSo0gMaM+pobCKWk?=
 =?us-ascii?Q?3iYu2hg3eDX2xDp6T/Q+8Vlje6PI4sTNFBLHELWqjQCKQ9FdcklFVNHe7bL8?=
 =?us-ascii?Q?h/hpdZ7Qfz/Q4H0He2Z+XQyEahKVEJIWECHhi7s+LgsXAxUHkrQnoYc7TExM?=
 =?us-ascii?Q?feP16pfhUph+g8V0vQ7S4dc9I3DUPNuqqIsARXpvyD9Q9xRatvXtc5taYFOL?=
 =?us-ascii?Q?0AU673Naab2RQoVsSIJ8ACBGEY1rnsFxi80G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+UDbsnlT2iYSQzb/X3DmJuJLJP3Qp0f6tjnOuMDngfocRYxY6O8RxD/iq/d?=
 =?us-ascii?Q?voXQvatOSCA1eRVfotpC7NbYztX5mQRggTaUgD90atYdpFZP+kjHrC6uEtl+?=
 =?us-ascii?Q?bBaYpIMvhrnaX65scrhD8JF/4yUIuZXgaEbjGP4aPjuMStZjeIvhCdT8yoN1?=
 =?us-ascii?Q?diavALOxOH3/9kuauy0o2rI+gBmmTnmta9sp9CX+eOBQPDWKEkTySQUyoZ6Q?=
 =?us-ascii?Q?NFG7AdIDvnojskTZQJlc2iqKA/b3F9J3LQJY20JDwB7RpyMmTGMaY6/8lkYs?=
 =?us-ascii?Q?EVYm2NFyoCsf8R+LbH2tssojfpnk9/rRWTL7FdUfQ0tmjS3XzPhWxpOX5Lpa?=
 =?us-ascii?Q?dGK34uZDQcumnxTUCCGJjCfMq69emoxL3CFy/N6G0N2DljSCypP6Tt1C0EjF?=
 =?us-ascii?Q?XwKufr1HdS6JUnm8HzOYSqwGeH4GE+c+inw01x+9Aq4cCWFrz4SE26Jqb66+?=
 =?us-ascii?Q?8TaS1qxCtP1BzaKioVUaW8JoHVDSpqhAnNM/n5cv0XZZIxTAjIESFHg/kSqF?=
 =?us-ascii?Q?HW4mEfeTgjhC1h+30tJJXpfx7PyIv4h1LYLDPHRwBnfg6eDjccl9uNk6b9I3?=
 =?us-ascii?Q?9lepnPNp6yRuP31GJXyzEjUj/8Tv0ONDvo9bFFpMtFHU1WOY907pc1GSN5Gd?=
 =?us-ascii?Q?KCXpvmGw/bToPFZ5eWsLU4d+7Mtw8dzoTtj05NGrv+vqE6hF5CqYuBWQeg4l?=
 =?us-ascii?Q?ibO3D8jbrVL9u/IadPHtoAhLmbiMFdGu7+okjKNCUIMOsGne3MZ+Gp043PCE?=
 =?us-ascii?Q?9UxTlX+Fze+Kb2Ec8ptIKR/GubAvIioJ/OpSt8/Cl/f3fK6nz7FKziFtl6D7?=
 =?us-ascii?Q?tzaIAJHa7eim7KPNOcdTxdQ7M1EfI+MbK0KyFVKzkwPcIfP4Ct3PVuCsiD7D?=
 =?us-ascii?Q?UP4UN+fH/1+fUbBjDBdMNg2KkXkwAhnyON1jmuIUI1y/Lx0WBsCuESVNzLvo?=
 =?us-ascii?Q?LArAPjZK5b0msDlBhL0jpiHq8EENDtRPSh4Ivm48pB+SsOSVF/DmB2L6Isov?=
 =?us-ascii?Q?4qadrfvyKgU0F0F9Hy/oxexiuPgH9Fea6yf/OWkY0Di/NgDbAAOVruHbeG0D?=
 =?us-ascii?Q?ucciiSYeqxvinChv54kKDWA5nFu+sm3n8zqqSISgivdx/KEH9w+1pvC6tiTl?=
 =?us-ascii?Q?yjCL+w50CSt07UtIsKSAR5slmk6MX7dORVUbhwLbmD2gPm4xhDBI/R8/7Kul?=
 =?us-ascii?Q?BnyatF7WT7Y2zDhsIXChX7too7m+IZisYP9O47Ha2eykF0073WNzy1PvKmoi?=
 =?us-ascii?Q?C+lDesggH7KtmS+udJbMKB4YCUrIKAZTlkidrUatjvzR2SAFCoEe8rAjyB4b?=
 =?us-ascii?Q?CGPae+dzaVl+0D4MWxl71uTiFTM/je52JSY+BO7bXnt4TlBpdFaDKzMfIBXL?=
 =?us-ascii?Q?MsxZoMZSxjCw8Uzdi/y7BT0MZiwZIPGY5loRSTyYIVdX91bvaBJEBYnonktn?=
 =?us-ascii?Q?o0486RugoCExnWfFspntpX5KUnEu8n5xaNwDaS+MtCVJa8gU0VeNBp3JEawy?=
 =?us-ascii?Q?xVZyso4XyCNhjbba2mIJReGqd4UJZor9vWMQJn2iA0fT1q3vMKlRbkTecSik?=
 =?us-ascii?Q?ZiqBw8ND7CBw6L5o7yvmVgV+qF6Xbw99Etx2woL84DVameJF5GL4/gLxES/k?=
 =?us-ascii?Q?qW25NhcLLP2qfb19mTYJ9Pk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f16881-5f2a-4753-f0fb-08de338fa013
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 23:48:29.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nr2sz4OwCWXr1ezSRC3b8wxXLJo2hS7nH8bTuQ7U+YhZEnETtCPPFYPvC9MMX1LHFTx3FHci34CpjKc39u9DMkh6wXPsySRKIoa61HWxifvzWw7yQDNG/9S+o77BR5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6214


On Mon, 24 Nov 2025, Robin Murphy wrote:
> The functional safety features of CMN-600AE have little to no impact on
> the PMU relative to the base CMN-600 design, so for simplicity we can
> reasonably just treat it as the same thing. The only obvious difference
> is that the revision numbers aren't aligned, so we may hide some aliases
> for events which do actually exist, but those can still be specified via
> the underlying "type,eventid" format so it's not too big a deal.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm-cmn.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 23245352a3fc..651edd73bfcb 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -210,6 +210,7 @@ enum cmn_model {
> enum cmn_part {
> 	PART_CMN600 = 0x434,
> 	PART_CMN650 = 0x436,
> +	PART_CMN600AE = 0x438,
> 	PART_CMN700 = 0x43c,
> 	PART_CI700 = 0x43a,
> 	PART_CMN_S3 = 0x43e,
> @@ -2266,6 +2267,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
> 	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
> 	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
> +	/* 600AE is close enough that it's not really worth more complexity */
> +	if (part == PART_CMN600AE)
> +		part = PART_CMN600;
> 	if (cmn->part && cmn->part != part)
> 		dev_warn(cmn->dev,
> 			 "Firmware binding mismatch: expected part number 0x%x, found 0x%x\n",
> -- 
> 2.34.1
>
>

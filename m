Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022090.outbound.protection.outlook.com [52.101.43.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F5395AC7;
	Tue,  2 Jun 2026 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379741; cv=fail; b=g9yRbvO5prVO7d2QJ4HRaTw6K9ysmiZWZxuAx9vBQISH/YfPE4KZIY7Di8xmD/bT7mOGzwZKcrKlUCoCcQe3FsCuEWimOSn7WisL2L8Hm/9BQd7k7fCCO/XunLiewG+Qrj8+vyCibouGbeF8mnMWqbop+lvcZC4liJwaMO2d/4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379741; c=relaxed/simple;
	bh=aBmN48ptCvCbXye7Oe05neV9cJA2mM+mxtopc7s7heU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=ny7XArjJKkeSfgIJw+n6DTPp/ImdoEvyjflTUxtmrzqm2dhSd6Ki8ih7O/Qs/furiPNXMMCF/INYSGJMQ3z1NNtlm3tpfGxEXm8OaLE1AKGDkQZiAlgPeLaun8dKNq7Q3xzdWwWtM0j2GoNQ8GWohIfVQy0b9u2k+ZJ602vFabM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=B14XrWWI; arc=fail smtp.client-ip=52.101.43.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="B14XrWWI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRVK3hVtXinvrVhGZGII6vNJ91MYEJznHu5/vWgsUtogYLclaCum8ou/3I5+Se0ZLz4nxiogLkRSNU1Balwd5NRZA9le2zDKq0tHY1yfuVHqR8GPa4Lgzf1kETutNMhiIHPrEPHdgLZUhTESfBDviWHLXs3rEsIzwLOcNMx07IYy3gL7rFWr3ZvztUWMexgsIIpJFKWstB1fPGipQcWQxJoT9jy7F7xpbYnLn4QgBQXTTHGjtX5UYxXhvFtTPr8BCovEXIFB6KxdCgdO2yege6jmgRFMyU7mf6SGiUtmyLKY3MFvTMTxPJpWpYHztRuKsSGg431eTYGhTAMt16nYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6VSep1YUCuXuIOJNXcuCRVuoqjA+tN4XsBP0L6L9TU=;
 b=JgIy0zMUsCAfxDFSWLQIAjkxqPVvfGXjB/Ckq+DVhm4qu85m0++hmzLC3GNn0m+HzPADNIOjly4n79fQQXv43ygWz3jDZhFrj3Fu0FSU8VnzS4Yawl/bpDja4Ti84XSsc3x7XFrF+BysjqRA1kvmb8PMywwc5AckDgcMVwScG92tcH04ce+QMoLMHg7DSapEIzpxAhCJ+tdnhK2AdsD5makUxp4mVi6y69K/yKCjrVLGBl6jw6jksgpeRXjukw/5rayTEL0cSIx6fF39cfhAMUqekfUkyBIKgYZBGtgA1+5MMy/u4MFmJX2rdcD8Ai/i5GyNayJTaYRXqkSs/AFS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6VSep1YUCuXuIOJNXcuCRVuoqjA+tN4XsBP0L6L9TU=;
 b=B14XrWWIAkEoKNKd+Hp0j0eBHzjJJhLObLrDq0PHsEITx44LFmpmcvRZv7V2lxZ7yoNgfGruldXb+nyx3OeJdyxoCc3m2RH8HCZuQKh5IGEm1ZDYl1Yt5DRuTNWe5+g1wgIVlc2fpSD/1WdBNNPLtyRK1AE9TJ1hs7OBQLftK5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 SJ2PR01MB8404.prod.exchangelabs.com (2603:10b6:a03:542::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Tue, 2 Jun 2026 05:55:35 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:55:34 +0000
Date: Mon, 1 Jun 2026 22:55:30 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Aviv Bakal <avivb@amazon.com>
cc: robin.murphy@arm.com, will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, zeev@amazon.com, blakgeof@amazon.com, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH v4 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
In-Reply-To: <20260531110447.10095-3-avivb@amazon.com>
Message-ID: <bc40f7e8-0576-de20-c5ed-59ed10beb012@os.amperecomputing.com>
References: <20260524153848.16334-1-avivb@amazon.com> <20260531110447.10095-1-avivb@amazon.com> <20260531110447.10095-3-avivb@amazon.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|SJ2PR01MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bb9fe1-9ad8-44e0-ab1a-08dec06b9018
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|4143699003|11063799006|3023799007|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	eyExJBzfBNHbLzbtENUJ0fKGylei9DymfORYDT7S8epsnoxNlW4GW8ysVLv0KtnaTHI31kidWm0T4o5Nc3SzSJ5T61lbaNWMhyxOLjjR0JCwQjfUbJXgPUBDiwR82gLZNVBBswbO3u4vsdM2feponTfWlWt32aJFad37SYLoyALdg8SloyudEwqG8hne641x700rrvCQ4BQhktzFQhPFEULie5vI8UmiMA6REQcqhGU9Mov6BsQ3n9W7wU6lVyP0TAUziVWCacvNcILK+7fUMOCLZWnE5q2heAqjsX4F331hxUVacNzj4qV8LlVAVrWJdbzDp86+8B0A1Kjqgpm8sujLzYsJkUgr3fBbX1ABfLcUEOvNGKRaj/dOQCcjniVwkKr6a/TqMTbhIylVSaVkRtmHZEUDTggZVs8297V2XqYup0sP4TAfuOdicszWBANWLzaG+fvsExvPCTXFCraT+4AKznhuO8kqS8oo/sj1yLFKHv3DFxN5hScEAB1v//hdzw6zBohev4puANj7TGUNG86tY3bQ0nDK/t/5OExeCfoWq68glK+9jVbDc4zynGlm78EnVvjODlFjxhjqHGz+Jl7o3PpFP9IdAPAFbuTWlwMtwJcJUXwhjpnnw8tMZZ0QVpMBxwCPBn9rN3ElitcKBVia3o45WPGGBLDHE4cxK0Y+hvvwBLbnRGT0fqU0T+5M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIplRIZaUHvbIF6bXXiLZJCOgL9mins5RO3Dj4kPcXJy3w6sU45L4O6giod1?=
 =?us-ascii?Q?jqh50hxHq+0rNOusAgalqfmpzDmKaf/s7Y1o262HTP7lK4wKHvUfN9RM5/vS?=
 =?us-ascii?Q?BsBRKGfd/ys1yyrq8zkuwRzyQpqkOqDUQOo5ei4nTxHx/SZ8Y1M5Noglzkoe?=
 =?us-ascii?Q?G3DaKWWVqiFqUgtEeTEPOYmCQIcVRGzgrfiHBtk0JDAioIRrsWA40dkig3KU?=
 =?us-ascii?Q?9ufSr9ecgXp6jL3mn1dm7DAFBU4hSh3MKtwfzxoGQqGFTbiCc8KJrMkRqBmq?=
 =?us-ascii?Q?gwfcLhRuJ4zzgIy/egMcje42+lDPOx+6prNPxehAz9wJHzGS/9q240SDUAmR?=
 =?us-ascii?Q?ojsZTBO2GvMIJUxON3egc/N3c/irDPE7Mem2a0PC5wrs6ScfLWD2L+lsanqR?=
 =?us-ascii?Q?CM/ILFej3Yz5FsvN5yXpV4e+gXy2qmuDv6v2SKUbrg994wn8Dy+fQUEmYDG1?=
 =?us-ascii?Q?73J9G82LZahrdYYUt2nfl9rmyibSy5b8E6lnZgAFUnh7TRRw8MJibwChgLnU?=
 =?us-ascii?Q?nb8kdEdgZz9BMt1oGlQ0XnHOcxjLS/gjIeYB7ojyFOn1/cWmTCz/NK0dbmr0?=
 =?us-ascii?Q?mgURdiqSSvikeyIMRvWo+zjoWyanyOYYp0o2NHrIXujTXtqXrZNWQQH7ZPyI?=
 =?us-ascii?Q?TFzQZJhfMpxc7UlyPieSK+XvqK7H1akwg+D901Z55oabsY9YOGcCcNrSG6VX?=
 =?us-ascii?Q?Gfto8e5JKBx4dFd9CaLWTPUlm9vWibv0bvS//3jeOW2HFwX3xYg6ufym/rrD?=
 =?us-ascii?Q?GMrZB0MoEFJB23zlQv6FBEhpVZYPqszLG9IuMGo4PdDQH3tdViADdTLsiEXl?=
 =?us-ascii?Q?tDeasB43rYmCD7XNfFZPwVLc/9gPzK4fNIMU4zbMnUf43HcWtqY678ALOr/1?=
 =?us-ascii?Q?3zwS3Wn9NMtkL6jdV3pTOH0WqqRoTCwdSTCUR8lzl+t7aIJlWwNMdjoVDzaI?=
 =?us-ascii?Q?gP/1vHb55XVNxbtwB3BmpYfbEhgpymJ4OxBZ0LrrMYuYqPXVE09J3VEd9Fwi?=
 =?us-ascii?Q?bcnp2lEgBro5KWv/oqgzz2qbhxnl8YCwRQ62FoBwECeblwzpa3K4a5XnHHyf?=
 =?us-ascii?Q?veo+/aPsgW3CPKWITDneoEzR321xEgP/YnPB5Tce8Gwr0F3ZDzdNHYLpoSPg?=
 =?us-ascii?Q?n5tXshH26A1ZdNkn8p9FSFJnbK20qftWY+PLfBawnpcz1N7eDKaKniFR5T4i?=
 =?us-ascii?Q?rPDwZAeJWI0WLoxQtO28uUup2DEfIjnILCnDEEtwHFYx87+BlecuZOqru/B5?=
 =?us-ascii?Q?L1Q8f5lpA+YSZvd12+G7Q6wzAMHJ85RnsPdcmWZpfEAGhaNwW1/Nvhatz6a3?=
 =?us-ascii?Q?6McNNsmA3DXQ7KDEV91/K8IGrguDJ8Wibfea5dJw7DzKXnFT8z0nDq2SfkAB?=
 =?us-ascii?Q?KxcNKaIlcSjT4VqCJFQI4OYr3KOtazPpF47hdzIhK5Iw8jyO6RiuAH2NYeEv?=
 =?us-ascii?Q?6+hke3XBMlqrYlavO8f6BJjBbG5rJW7fl5Y+z2NA14FlWcEGNOlZxnyTW+gC?=
 =?us-ascii?Q?CBJBSAKwTx88q8Et/JimCS56O9j80Z+RPzl1LQYGeln8rCItesNjCtV3xCaH?=
 =?us-ascii?Q?dyJHkx4AI7XIq3zleKFgUlCj9j0NwCjlsDU61rTVixA0FB38e0cTGTnfuTIK?=
 =?us-ascii?Q?Ks3e4bFdLmsPTgcDO9l32I2rdFyPH5eoK8RoLhW4j+O7Cv3lAnnFtjZP6er3?=
 =?us-ascii?Q?Y34FnzrgOj+tQ+XKqcQuIhZ2por2h05tGi74UTthYHlzY5PNuADDLJfql/f/?=
 =?us-ascii?Q?fcCcPcEgF3Enr2IrNfXaDhHkfeeXSC4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bb9fe1-9ad8-44e0-ab1a-08dec06b9018
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 05:55:34.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5MLcrKNEnNPVr0TYP0kmMGR0TmIFpVFoehJG+PilMIFgdC8Z6xcz0fGFRXkMnarXZdPcI9QuAUBWBOmAefq4yWIKUTiR5SW1V+T5LJ77Yd+IqqMhCj84Oep/1sFNYmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8404



On Sun, 31 May 2026, Aviv Bakal wrote:

> Graviton5 uses a customised CMN-S3 implementation where certain
> discovery registers report zeroed fields. Add the following workarounds:
>
> - Introduce a dedicated ACPI HID to identify the Graviton5 CMN variant.
> - Derive the DTC domain from the XP node ID, since the unit info
>   register reports it as zero.
> - Set the DTC logical ID from the XP's logical ID, since the node info
>   register's logical ID field is also zeroed.
>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>

Thanks for the patch. It seems surprisingly clean approach. And thanks to
Robin for answering to Sashiko bot!


The patch looks good to me,

 	Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 32 +++++++++++++++++++++++++++++++-
> 1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f1978a53d1c1..3fb71d9a57eb 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -31,7 +31,8 @@
> #define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
> #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>
> -#define CMN_MAX_DIMENSION		12
> +/* Some implementations use a mesh larger than the architectural max of 12 */
> +#define CMN_MAX_DIMENSION		14
> #define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
> #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
>
> @@ -214,6 +215,8 @@ enum cmn_part {
> 	PART_CMN700 = 0x43c,
> 	PART_CI700 = 0x43a,
> 	PART_CMN_S3 = 0x43e,
> +	/* Synthetic part number, overridden to PART_CMN_S3 during discovery */
> +	PART_GRAVITON5 = 0xa5,
> };
>
> /* CMN-600 r0px shouldn't exist in silicon, thankfully */
> @@ -2250,6 +2253,18 @@ static unsigned int arm_cmn_dtc_domain(struct arm_cmn *cmn, void __iomem *xp_reg
> 	return FIELD_GET(CMN_DTM_UNIT_INFO_DTC_DOMAIN, readl_relaxed(xp_region + offset));
> }
>
> +static unsigned int arm_cmn_graviton5_dtc_domain(u16 xp_id)
> +{
> +	unsigned int x = (xp_id >> 7) & 0xf;
> +	unsigned int y = (xp_id >> 3) & 0xf;
> +
> +	/*
> +	 * The unit info register reads as zero; derive the DTC domain from
> +	 * the XP's mesh coordinates over the 10x14 mesh.
> +	 */
> +	return (x / 5) + (y / 7) * 2;
> +}
> +
> static void arm_cmn_init_node_info(struct arm_cmn *cmn, u32 offset, struct arm_cmn_node *node)
> {
> 	int level;
> @@ -2295,6 +2310,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	u64 reg;
> 	int i, j;
> 	size_t sz;
> +	bool graviton5_workaround = false;
>
> 	arm_cmn_init_node_info(cmn, rgn_offset, &cfg);
> 	if (cfg.type != CMN_TYPE_CFG)
> @@ -2305,6 +2321,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
> 	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
> 	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
> +
> +	/* Graviton5 has a customised CMN-S3 which needs some fixups */
> +	if (cmn->part == PART_GRAVITON5) {
> +		cmn->part = PART_CMN_S3;
> +		graviton5_workaround = true;
> +	}
> +
> 	/* 600AE is close enough that it's not really worth more complexity */
> 	if (part == PART_CMN600AE)
> 		part = PART_CMN600;
> @@ -2394,6 +2417,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>
> 		if (cmn->part == PART_CMN600)
> 			xp->dtc = -1;
> +		else if (graviton5_workaround)
> +			xp->dtc = arm_cmn_graviton5_dtc_domain(xp->id);
> 		else
> 			xp->dtc = arm_cmn_dtc_domain(cmn, xp_region);
>
> @@ -2472,6 +2497,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>
> 			switch (dn->type) {
> 			case CMN_TYPE_DTC:
> +				if (graviton5_workaround) {
> +					/* Node info logical ID is zeroed; use the XP's */
> +					dn->logid = xp->logid;
> +				}
> 				cmn->num_dtcs++;
> 				dn++;
> 				break;
> @@ -2687,6 +2716,7 @@ static const struct acpi_device_id arm_cmn_acpi_match[] = {
> 	{ "ARMHC650" },
> 	{ "ARMHC700" },
> 	{ "ARMHC003" },
> +	{ "AMZN0070", PART_GRAVITON5 },
> 	{}
> };
> MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
> -- 
> 2.47.3
>
>

Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020076.outbound.protection.outlook.com [52.101.201.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022911DFDB8
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904390; cv=fail; b=QLtbwnnA8ea339O+/vawgH8velZY2Q4xAsGWR4YDLizA1mFjbk+FABn1QXm5oo+4hvfo+OxuMnxrQAoWQ7r/hZWqeC2eoZGzvyyqZFhcfAqUqtG6iQ94UK+ZteIv4Xqu4yKa0PmjKoXSwiKL8HMtcw8VqR2D/Qc3VXQpzS18QnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904390; c=relaxed/simple;
	bh=JPD4goQRRyrOU/5Rp7HOIurTTOSPlpyDz0fWUBs1Ous=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=IjvyC5zGzMzVIcj5GfRVbZ24hjSuzPtxCeq05noadSYr1ZXRhvQaRHji8YkDs3edk6tT6IPkyzARJIrNnPfLxAR99oadmbHPsHrVMgbuevcVeLc8NMM93ftY+XE9c42gOEbyITn5jv6vsVbhAPjP3lMyI5XQHL0zguJD+YqmJME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eA+ZQo2K; arc=fail smtp.client-ip=52.101.201.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eA+ZQo2K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXlKGGHWVSLGUO8bKiUuvQeGbSCXE92YLtgEZp6WPVnpOLtEUu1OHORYuamOxS7B57gDc0oaElLqQxscXhEllLs/aN3t2VHB7S7rPH7J3QyYnwrbyGtEzF7EJwTYAfx625sJsJVlXDM7brUoc1OPN3YfZ8/FqD/frO2qGIUfkZneU/1oEgPIX6RUbji+Uia8pi7YVcSymx82S3e3n7cYppxCwinONXyEtkll83Zvsb/EvXorYJV6jSkq2PFjgNNkTpJxxAYeUYcg3bEippuoWAmKeG/7qKqzZer5PGr7HD0ClNwcSKH7tl2S9xiaMJx5w53mppcLLEPSCJ3QC8Y3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDQZVcPTZXfe4Bz2aiUHS8/o78gGJFSpVxSNOMoIxCc=;
 b=oezIfnWluhZBmMm4i7IJmB0UMLp3vBbj6K2C8HAzXAatcRNpJk6Uw4kzUPGNmp/PLKQ+p0grFrgvIwgq3CCOy5KLUCUCPu4Hv3S0EJQhsE5YlzMYd7jbyPizl807/I/mIVsqYLBNf8zDLQRFv1WIuHY6hWpO5uvjDzafGKXD0tNMX8y7hejuhXLR8i0PYA0xgYIogYhcGE0x2DCPpco4JVIBR8XqQqhCpO2/ACeQG+q0YgHPFyhcsZm1LfXBgUdOk6DCgPjNcWYw3FZtrrByJWkY6NUGI/Ta8xLnBMd/2JaC0hBndBQgYg9WdKkY5tmnpp5t5C0S/MKKSIDXqa4xnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDQZVcPTZXfe4Bz2aiUHS8/o78gGJFSpVxSNOMoIxCc=;
 b=eA+ZQo2KfyGqOuv/lAqOZiaeb4QuDOyhPmovz+LB09IWVxsiHEoTxsd5XkUMqitfiGcvNM+FMDAiL4zXnUwRtkpjY/pzJaa5MnAOyc06NHI8XhjYbsgD0vhW5748FQ7cD5OsbA8vn0JI20RQDJmsrpUwv72hBaedsQeKdK4JR9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 SA0PR01MB6313.prod.exchangelabs.com (2603:10b6:806:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Tue, 24 Feb 2026 03:39:45 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 03:39:44 +0000
Date: Mon, 23 Feb 2026 19:39:37 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com, James Morse <james.morse@arm.com>
Subject: Re: [PATCH] perf/arm-cmn: Stop claiming entire iomem region
In-Reply-To: <b6275655818f5af7e5fb07a9e18d1451b08b7e05.1771522073.git.robin.murphy@arm.com>
Message-ID: <b3da566f-7b72-6259-a5cb-9b6e4e3e6a69@os.amperecomputing.com>
References: <b6275655818f5af7e5fb07a9e18d1451b08b7e05.1771522073.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:303:b7::13) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|SA0PR01MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 50df9c80-5fb4-4069-f9f1-08de7356583d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ecMURcv29LN7xl30m5zcEs5mu4ScWjn8lfly+Kht9J1MmMLVowsxUXYhKxV?=
 =?us-ascii?Q?vvhJyN8UGmnnm5JZwnohZnmNoDDsIXQw1ZBabuVldesr2m3ZZGtmcq7tZ2W6?=
 =?us-ascii?Q?UnN3yNqrqAALPBGlTRsbdb154MT5Sj4t0gUWPdMIE7irixLkn9MO3AUUy976?=
 =?us-ascii?Q?0zZvaJd5fbvG2BZ2rjN5r6phweCsh1YlkPX6MgUQxhHNvEwHHg6pvv04Y5nT?=
 =?us-ascii?Q?TXhv7kqoaQ0e9VKammBvNvj5eI6se96nSvs9c9gvriq+nkNgSbJ0t2xK9Cks?=
 =?us-ascii?Q?V65jm3kYLYzBleWg9sMAMaeFfwUvmfUg94oLIVkwQBdrYGQ0dki6enGiKekW?=
 =?us-ascii?Q?BbCOkKz2Tg/Dh2NJDGlYEOXCfRA2++TY1J5xKahwljxYqAZWY0aSTMjZUry8?=
 =?us-ascii?Q?XM9uO1bjywTBGp2dBSnZDB9UBDIY4zmjfGF+y995tSSVAoPsbzQ2epPZRfza?=
 =?us-ascii?Q?gvcOuDeQGYbPSCl/Mxt6MCTx/Zii88GBM5U6J9LXkStXwlVX9uQLwkftPjG0?=
 =?us-ascii?Q?AGFZlEl148XNj7OoPikzGKJ2Z+x4Gfk2p+/GIg9OYtnp9PTRAIdDWV7qv/aP?=
 =?us-ascii?Q?bJ4cXyivu+rfTA7xdUBc3wkEdznbv1sE0B6iJc7pzJrAkB3dqpL7aL2s8or3?=
 =?us-ascii?Q?kv356Su6kYj7BZPmlIbBjwdQ9m9Amxk35s6adK+7b2tsHE0vgAyH3W5r3daK?=
 =?us-ascii?Q?jw18QjoTfBbOVH0T3EyHjgnroKcjEmXTruh3t/AX0NnRJbEO3Md6TXHYnu0a?=
 =?us-ascii?Q?HFctTALYyK4sAygCOikAtZjVGPEfDdt6f/1jyKP9tkScQpT05AT7wxTI7jAu?=
 =?us-ascii?Q?YiTqe0iNTsTHKk/W9r/6TDtzvI6e/KadWfDYHpa0CzfEvuGcwk7QnwCZLdqv?=
 =?us-ascii?Q?n57YA6l4CCfLB1QEejvzsdMQULOHUk4YsalyJ1r6BGlQ6+hP0O0REtUdJHAs?=
 =?us-ascii?Q?HpC2HVdSQfhBK3zhqy6XQ/Eue41TvIcX6FYdXl94vco0IZngl9ZNcp8ehUoY?=
 =?us-ascii?Q?iJp7gIE4swT2QEdrkF/L4MuE4mk4vHExlmhtpFjIqO/ScjVTlpe7CWWqsRBJ?=
 =?us-ascii?Q?RHUCufWqp/ijNm6rt0+GOkSX8PAc55Dn3zAHS8mKzOnPwZwflX8xj/CJPv4P?=
 =?us-ascii?Q?AjE6y+n9U4RgDGWdc897rXvhAE4YqYhQ0uaHxUgX8TkABz/7jEfAHyEcORm3?=
 =?us-ascii?Q?enttUE7gxbqiJ10bJY39/wBjtL2zLGmgX4UYkVOzZNy3j4zAO0enUeXbkweH?=
 =?us-ascii?Q?eh06qOXzm7ICC9n6aMmCsDE3HIfbIxQIYA5pJ2ps1TeJUlIyiWXLnI0ozt8W?=
 =?us-ascii?Q?TdG0VCw0P/a6v43hJvhZUyIzvS8R1VWg8kA0M3cGe6GTQeihChtEbLeyaBlB?=
 =?us-ascii?Q?T9ccGD+ToVcR8oZxCeDXSegCPGFIpAVe4YGqEwwQwBEb57DSTZBhkq3qQlMi?=
 =?us-ascii?Q?4ft4GMCtxpMgeZl2AMW0XZtItItVMd5r1fKoAkBU5xHrDVP7EfdaKq5ZJDBN?=
 =?us-ascii?Q?qn77jzWPlRJCZT5wZ4ethdY35RMFp49OBPfXUhaCVBsO3qNyltu3pwqPy4V7?=
 =?us-ascii?Q?tF06fsmTWY7iMET3Cws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DNuQCnYEeYVlYVHJFNyKYVNSfoN5rz2FWIanZux3qA3uIBiINDmKPglsLDzX?=
 =?us-ascii?Q?jZDHfDcbZTk/dyCJEfPoUPd6icN/GWK2QeNZ555xirIhh/z4QsgFtnASErnV?=
 =?us-ascii?Q?5yvKPGrDMRz9kL8kyegqDq0Mbza7RoxQN+S98ED+lnikx58a31J9KH7e3VXv?=
 =?us-ascii?Q?Y5HxcFUo9clAepH+vJ673Wv8tuI/vagsddUeXoXN6d4E+3MApCEALds1Gs5H?=
 =?us-ascii?Q?vouaXhGb3FxgS9YxrhA2dp11T+6MzzlyzPhNukNjc/JBlz7irQpjxfRvF2oS?=
 =?us-ascii?Q?LGVuXjsQcms1UpLHxalWe9DTVOYLLSEJHjMVT73misUwJ0yDEP0WECil4Dj+?=
 =?us-ascii?Q?n4FQJKtxo4Xl5BmmFZMdaOsRVnY46MOvEoUbez6HdsOdCPA9l/5vPdr+v/SY?=
 =?us-ascii?Q?ANKPeHT7mfY4MBOdaSVRMYWD9RjBl6DX8A1hoZBZGPvYkiHifDWub5tdJzSV?=
 =?us-ascii?Q?4VYyF9usoxSXFlpD3QZbQj22SfiLFJKurgSKuyWVR9sxprG1tnC0e6wpN+nG?=
 =?us-ascii?Q?x5+nq4th1iE2+RKcwywcsy5xBD6GpGS/aUdDmBQq7whHDtJfU/UeFcmi3vcD?=
 =?us-ascii?Q?C1Q6orlIvTLtq8SNxcbGsJwVQuRMuNGB7GE1NmaCPO191W0WXv9+h/t4ziAX?=
 =?us-ascii?Q?deBWVWOJjMNaTdZLox3WZNbKKI9lik6YJvTFYusFV9TLz+x/lXbdafchIjW4?=
 =?us-ascii?Q?rEfeL1EMRqMytH/Q0deqlwwDlrMSJ68fwG/ViDez66IpcnN/jbfVsZYTrS9n?=
 =?us-ascii?Q?bd3dKKdxNcTqi9sVBnP7cVK1PoxCqH7Yfn57nPJA0QMUywnxfvdHhrPwC2vw?=
 =?us-ascii?Q?M1jk9ZyQ3Lm/xWHOCWNsQmICmJcySNaCogv91aHNilmPz6gRbVILYryrE3xq?=
 =?us-ascii?Q?bCc2yWDdCkKEVnRPG4/wn2ugWGPBWFQzHgWDs38mLS4fBCwNqTc3PY6obXa3?=
 =?us-ascii?Q?8U8t8wjDTovno/FFQbzddlqyps5ek/bsXiotOG+JoD2n6MxxKUlTALnn2XgS?=
 =?us-ascii?Q?ZtTYXmFhk7UNA5S5llfj01wLS3Stm5wzQUSUqiAi0lNNOkVFC06mq/8sdUnN?=
 =?us-ascii?Q?nqY+W8/kO3Y6w4X/7lNNZbslWo/gPXS0sQSTkQ7Q6tSXT3oVMP8ioD043E1D?=
 =?us-ascii?Q?4ZDFSIcMW32ePNpcg6ufhlwbUtvPAcRoYp+GsFnwlQKhqdhtgILipEZExEez?=
 =?us-ascii?Q?jZXr/GTd8CuxpRKRP+VITHB6eGZtsdbk/5i0AHXI6FtoMfTnqgAwgfFSeRgL?=
 =?us-ascii?Q?Beiz0ssS+XarBhNk9XnC3d05swxLHMxWAOtTPwOAuNyGXNPS3Ha3CFrXXhZk?=
 =?us-ascii?Q?FhOH5VlRXo2Sz9LzHrw/WUvESMl20BXsVC7fC5GVwqgufLciKfl+IZj1trNI?=
 =?us-ascii?Q?juTR4ELZ3SrOINCgq4nxTl0is+5T5W+7FXq1fxvSduxjBMK8lzBhgZ7gKBZf?=
 =?us-ascii?Q?dstyuEP5BDfEJuCtAe55RZQy+JY38yanhVl9HlETBoQLEJjZpEr4eRH4lBnr?=
 =?us-ascii?Q?/VDzb3ihsKaTQ8cj7hzSye++MSEL2nCN9GpbxN2/VZI6j3YPgwuirLkbNCC9?=
 =?us-ascii?Q?6necglHhmWUTIzRHL55ifAczMlJKrcw9Zlh9B6opqocP/aRRFVxPL0gp1rxL?=
 =?us-ascii?Q?U/3hqzrDU0ay5e8IDS7GtGraQLgSrgLPD/Bp9m7+Q1BbAcnWPvTKSOC69D5l?=
 =?us-ascii?Q?IPqtQXXCNM80vnX3wHm0O9Fi2Y8a1j0R526VMzxGE2xNmO6eWvjLmzl+SJJB?=
 =?us-ascii?Q?6JHTJeeZGnotcIcNJ3wnGFeiJdzbltI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50df9c80-5fb4-4069-f9f1-08de7356583d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 03:39:44.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPl6YcbMV53Y2+XT0cpPqyvJ72f5EJG/B7zzyseNHPKS6jSEvZQe6ZaeFmgi6M1ApOvexAMcHZucgD84gWueT9rCFk3szDWXm8YSp9LpS+f5GFGFg/ikT5vPFBfskdL7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6313


Hi Robin,

On Thu, 19 Feb 2026, Robin Murphy wrote:
> So far, the PMU has been the only thing of interest in the vast mass
> of CMN registers, so we've gotten away with simply claiming the entire
> iomem region. However, now that we can support other features like MPAM
> controllers for the system caches, the PMU driver needs to stop being
> selfish and learn to share. Similarly to arm-ni, requesting just the
> DTC node(s) should suffice for staking our exclusive claim to the PMU
> features, as requesting hundreds of tiny regions for all the individual
> pmu_event_sel registers is definitely not worth the considerable bother.

Nice. It was on my list too but never really had time to work on. I was 
actually wondering whether we should claim all the PMU regions but I agree 
that would be a lot and pretty much pointless.

>
> As a consequence, we can also streamline the annoying CMN-600 special
> cases even more. The ACPI binding has in fact always specified a strict
> order for all resources, so we can reasonably drop the ancient pretence
> of swapping base and cfg, which IIRC was more just a moment of doubt on
> my part than anything else.
>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka


> ---
> drivers/perf/arm-cmn.c | 70 +++++++++++++++++++-----------------------
> 1 file changed, 31 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 364a4fd8f2c0..6a5eba0be347 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2132,6 +2132,8 @@ static void arm_cmn_init_dtm(struct arm_cmn_dtm *dtm, struct arm_cmn_node *xp, i
> static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int idx)
> {
> 	struct arm_cmn_dtc *dtc = cmn->dtc + idx;
> +	const struct resource *cfg;
> +	resource_size_t base, size;
>
> 	dtc->pmu_base = dn->pmu_base;
> 	dtc->base = dtc->pmu_base - arm_cmn_pmu_offset(cmn, dn);
> @@ -2139,6 +2141,13 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
> 	if (dtc->irq < 0)
> 		return dtc->irq;
>
> +	cfg = platform_get_resource(to_platform_device(cmn->dev), IORESOURCE_MEM, 0);
> +	base = dtc->base - cmn->base + cfg->start;
> +	size = cmn->part == PART_CMN600 ? SZ_16K : SZ_64K;
> +	if (!devm_request_mem_region(cmn->dev, base, size, dev_name(cmn->dev)))
> +		return dev_err_probe(cmn->dev, -EBUSY,
> +				     "Failed to request DTC region 0x%llx\n", base);
> +
> 	writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
> 	writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN, CMN_DT_PMCR(dtc));
> 	writeq_relaxed(0, CMN_DT_PMCCNTR(dtc));
> @@ -2525,43 +2534,26 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	return 0;
> }
>
> -static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
> -{
> -	struct resource *cfg, *root;
> -
> -	cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!cfg)
> -		return -EINVAL;
> -
> -	root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!root)
> -		return -EINVAL;
> -
> -	if (!resource_contains(cfg, root))
> -		swap(cfg, root);
> -	/*
> -	 * Note that devm_ioremap_resource() is dumb and won't let the platform
> -	 * device claim cfg when the ACPI companion device has already claimed
> -	 * root within it. But since they *are* already both claimed in the
> -	 * appropriate name, we don't really need to do it again here anyway.
> -	 */
> -	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
> -	if (!cmn->base)
> -		return -ENOMEM;
> -
> -	return root->start - cfg->start;
> -}
> -
> -static int arm_cmn600_of_probe(struct device_node *np)
> +static int arm_cmn_get_root(struct arm_cmn *cmn, const struct resource *cfg)
> {
> +	const struct device_node *np = cmn->dev->of_node;
> +	const struct resource *root;
> 	u32 rootnode;
>
> -	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
> +	if (cmn->part != PART_CMN600)
> +		return 0;
> +
> +	if (np)
> +		return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
> +
> +	root = platform_get_resource(to_platform_device(cmn->dev), IORESOURCE_MEM, 1);
> +	return root ? root->start - cfg->start : -EINVAL;
> }
>
> static int arm_cmn_probe(struct platform_device *pdev)
> {
> 	struct arm_cmn *cmn;
> +	const struct resource *cfg;
> 	const char *name;
> 	static atomic_t id;
> 	int err, rootnode, this_id;
> @@ -2575,16 +2567,16 @@ static int arm_cmn_probe(struct platform_device *pdev)
> 	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
> 	platform_set_drvdata(pdev, cmn);
>
> -	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
> -		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
> -	} else {
> -		rootnode = 0;
> -		cmn->base = devm_platform_ioremap_resource(pdev, 0);
> -		if (IS_ERR(cmn->base))
> -			return PTR_ERR(cmn->base);
> -		if (cmn->part == PART_CMN600)
> -			rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
> -	}
> +	cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!cfg)
> +		return -EINVAL;
> +
> +	/* Map the whole region now, claim the DTCs once we've found them */
> +	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
> +	if (IS_ERR(cmn->base))
> +		return PTR_ERR(cmn->base);
> +
> +	rootnode = arm_cmn_get_root(cmn, cfg);
> 	if (rootnode < 0)
> 		return rootnode;
>
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>

Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2093.outbound.protection.outlook.com [40.107.223.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2D259C9F
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303710; cv=fail; b=L/llV+Hm14nVy80F4leXZTAv4fQF6ezbyzAQLe6GC2+K8ailnojSazKTXcZN98exc6ZyRQHhxIxdMNUVHRjkAnSoQS81gxVW5li8k7BRhsctKwm2rkHcYbiC9RXhGTVVMwZR9wal/jwc0b+Jb+aqCKDSHjT4NsMZbdQzyfWiSAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303710; c=relaxed/simple;
	bh=7iPDZwi9s0YqsqUWsRE5p8kfunx0A03Be5LNCEXrkhI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=Qa6QshKqh4oykcktjry30opyx6SWmTvddnYoxn46pXJTnnTPpS6D9Q1mpxQZL7dE66cfpLzp+qvfJHjsJnQPGRFWWuuHN1EaxHPBIodqYc3AZ203I8M7MYSredOXGDnAYdrv31leuiqO060aQl1EAEy9611gvS2nX7Spr0Xy/UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oU+eNXb0; arc=fail smtp.client-ip=40.107.223.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oU+eNXb0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWB6VcGKVV91denzWsoO6aoq+oAo0cG0SrM7j7S0PskWtbjeKz8NjzIN428TTRIu3J58GPu6Rt6MM2Kb3xavPJZvTz2Jsye2xiTOcbPuuGKYBv1t+OxyeUeN0vi4MlUtdEIyayyIkAYxBbtG4yeDd/DQTlJem5d7cx0b3wkhdbN9lFSF8YFj6NmQEtoBewzqduxyGLu5JvMF7m341nDXR+CJCfScIG3+WzCrHgDvHs6L3/9SgZF1ckGjeHXFUXmVHdjY0TrW5PoW4jJEJaxgrZSKBRo/JrIYdjbk2YyENsde1xDKqqxMW0U/VfSwlGdcrMfpeanql8zddWvjnY7SZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9G4lROuQJBmJF4JThZM5jzjcfa/wx1CK7RyQBnNUlE=;
 b=EDSDeG9eRiIfd1Qh024jX+w9eXqLi/ITmIGc4+oypA6KxmmZSqVQ+2rzPIs4ddhg/902AC+UpvEW7OnkMLZ7iCjEXqJK8uERjcD9GTk03fSUd/fao9STCMNATItbrmVN74jSMrL1bSud4/DU+O0EdJJwljd62bN3+L4AWtyuce6RBobebEArVq2+C7FizdwgzYRfKiC5TvuJKrSo9DMFPe7MaVu0HgNcAledhli6vuC06hj+WlG1s633+lmCVVJaR/BWOeqvqN5OrCe5X5wm9qkx0WHQEdB2Us6jaqAygRMWWcqTyvhGCx9+3Rx4Fy5kI/3SDbT27nyvGG7wAGr7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9G4lROuQJBmJF4JThZM5jzjcfa/wx1CK7RyQBnNUlE=;
 b=oU+eNXb068DyMO+wvs1XDyT51IE2XJXV/Q3kKq6TE1Oo8EY9YSlOFuu8tpRqefpB7nhVgRfm4FVfDCoYqvndRT9/seBdNY3as5TaHlTXvKrFD9Gw3bpvQnDyCfpWzy342Kp0qY7LRqhFd+g4P7rfjyYmBinT6rHPm5C2auNB/Jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH5PR01MB8888.prod.exchangelabs.com (2603:10b6:610:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 23:28:26 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 23:28:26 +0000
Date: Thu, 6 Mar 2025 15:28:22 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, bwicaksono@nvidia.com, 
    ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/arm_cspmu: Move register definitons to header
In-Reply-To: <5a3c796560665b51cb63fec0d473afd8f8d0a836.1741190362.git.robin.murphy@arm.com>
Message-ID: <ffd0824-cada-d454-bea8-8c45e0a13b6c@os.amperecomputing.com>
References: <cover.1741190362.git.robin.murphy@arm.com> <5a3c796560665b51cb63fec0d473afd8f8d0a836.1741190362.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CH5PR01MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: d30d42b3-1a59-41d6-eb57-08dd5d069873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c8spAqJ4lRWKmC5xuZO2CKOloGp72zpnsar+dAtvzJSXVTd0rFE7xYD6C9n6?=
 =?us-ascii?Q?AaIKyEdoRG35Y9QbdCy5cY1wmG4HIe+2QS2sTYS4Zymoyp3wcW3RBRdZajD2?=
 =?us-ascii?Q?UkTXHiUuarCJLAPnF5zgQ39/2hsLKzRFlN48cGO+B9AH1wj/uFg3vXTLm4HL?=
 =?us-ascii?Q?ejH9w7yRbuOTHjKOhpqMY5b3oZaojX+KiqsEwOU5HII7DRuYCdbay8KZJVIl?=
 =?us-ascii?Q?XUzyqYUbIUW/CLCqYqdOrpks7QQQDmGF4sfxVnjjxXeM+gUB+RCy6jIMNmRR?=
 =?us-ascii?Q?kTBlPyh9f26mny3gN3cYe/MaJSDio5vRoeeBQ+nMzSlTyrJthhZHclvnnWW7?=
 =?us-ascii?Q?fZIrCCkvVUYPjOmrm1nyNzf61cbmXeV6DhVhkNFR0g9KN70JTPF4568N1X0+?=
 =?us-ascii?Q?SJOqkNYEcyRihPHF/RjcZpqdh9xvY9w7EhZSo+Ga74/LwUYcJKTOh+L9Tkue?=
 =?us-ascii?Q?T9mCf9Cv95t3fuGH/IB3lyiSkY7eUbcsWWXrR2V0hwtkf+iUqZ4Ex4PQWnQz?=
 =?us-ascii?Q?OxpIg991xJe/HlKq2VWlbq+Wt6myHm2ehFBdgaPkZzt6/ZVXojJSrwJuPi1Z?=
 =?us-ascii?Q?etWWct//p8lvIOFq+ke5dbfkPI9AIhM0m++SC1ptbkwszaFUZ4DYUh7lBQIf?=
 =?us-ascii?Q?ho37U1S1JoO85ETrw76LvylmxsFnGApk2NUbPkV2glLzbSdkjZN4bVNmOqvA?=
 =?us-ascii?Q?CShs6yEgAkfuWHy6p9k7VU4CDFdpwh0FDXIegv1Q6yKzdpaKWK3XNpLevuAL?=
 =?us-ascii?Q?s4GQPym8VowfcQ0ewygVSNPjOBocuaDvM/6FzsTdiuIvjiV0XiQc9wKNk+vy?=
 =?us-ascii?Q?20yrzFPvx6u5Z9wUOtLOy+gWscN6yL9MCIKyNfD1TIsQ2+2RfhfwpyqH55gj?=
 =?us-ascii?Q?9PAOb9rkOdcLzbIMdiwK/xvILBA0x16hWh1A7kr5R8sDfhZE9ITxxiGdNDUw?=
 =?us-ascii?Q?hSYufmLuYuiclA2uIbUPx5TBL9G3bZClP4BDqw6wvOSy9k/aKx8jG9ieo6o6?=
 =?us-ascii?Q?UCA5Qd1RJIN+jQRVmq0iT9t5k8f+NB+yAmywRLLaM5wJgSVaEo3QwT6GHGsq?=
 =?us-ascii?Q?SeX5CKYIF2ygLvEhrWh+20z+beQlyJR+37hbZQdLmEZ727x2FgUkoOvDwQqc?=
 =?us-ascii?Q?1W3c9ulA0U9ggV76MS9U8+ze59RrPtvrYobRzPmm+TOMxyf7GYFEdudcxo9Y?=
 =?us-ascii?Q?M/LH/V3GqQynkk/LgmjEckh3ECIwcJl4ZEumspFK5YlmJL1Z4N6zq7sralyk?=
 =?us-ascii?Q?zNM1p3W/1ALGxrhedS1ABibw+VFunwJbKoFm4sBmCS9sMX8j3+h4H8w9aB07?=
 =?us-ascii?Q?xqWosTWr/IIQLJpDJXKaH8u6epmz3hCU5WYJGtvP64LZP2HcOuSZR78z3JFR?=
 =?us-ascii?Q?4fIxrvMnNHDYYQCF0SutxgHjS1FnTLvhQ4aWdgk6yIF4Ylo76L3yPff/Q7SM?=
 =?us-ascii?Q?nHuVsA2/mlThLr7/otPWHOiQW51C0Wzm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUSLMrfgQKJuBHE75NNSWNHZNv6rU/J1RsTtOVFs325sQSamHOzdE9d/4gse?=
 =?us-ascii?Q?qFHZkt5W9N2+fBUpdaO1W0L74JZW1rrL6+Fsx93O6zOaNLfnfLqOs5Sv7I4G?=
 =?us-ascii?Q?mzAuRqeLhTQdiYmKNy5nwa2ZC7pEAdcQ41RtSQ1BS8KLtBPgKpuC0D+IqHN3?=
 =?us-ascii?Q?qnBcXAdaLJ0Nq1y/vA9V3B74NqBzKpCq1rr9xnshrkM62l5T+PDV3PICE2BJ?=
 =?us-ascii?Q?oGLPC8uA1caMhmFvFTSHDpR5N7FXmpWe1F7DQU79nsCCqE2nNAvm8lAuj0fS?=
 =?us-ascii?Q?SXVPPkQHrpHNcxZdN3YXIlLv2q7AzUwAYRBxXY3LM62yvrfcHXHI4vjY8Iq7?=
 =?us-ascii?Q?DEtfFXVgJp9C0Bcx1uUVyVnAOw5ALZVs9FR7aYOQLRkK0l6KmGqelGaNlUjq?=
 =?us-ascii?Q?42GmZnzH74igKZsx6nYH4aNslrQJo5HklpRYLKlDYuc9okrCekFaX1kME1aX?=
 =?us-ascii?Q?rrWQb+TiP+VhiIzkDg+cKeTDjEQ65XPvwjqegVSH9ztbZKPGnI6SUoTRQ3ae?=
 =?us-ascii?Q?wHdz4v8NDASOxPhMeG3IZw53ORhS3BCBrJyTpHgwRtuGv7o1Q+W7nRV9FEM/?=
 =?us-ascii?Q?vY8KdwfFpnwEzQZaU/cGATojG8p78yAOK70hLSGle24ZLAihdDWgqVyDxMjv?=
 =?us-ascii?Q?+xn3BFGn7852fKTWUuFP+Oft5iG61+rrHCFSzqS9FY50Me0RemnslnfRXbIk?=
 =?us-ascii?Q?LhmY5EYaCSr9wsHquYk5M0KlCZwr+gJsuSkjPxAo7Pse2VKjGjZZ6lr5WEKU?=
 =?us-ascii?Q?OGrzeyG/rwaB+ue2MrKtgyaAb43nxZz9Aa4LbsP6ilCBkh9pX/nqbuCA+Y0D?=
 =?us-ascii?Q?IST8aESMhAHxgfnhtn4PObwkD+EQ4fnFShnSq2GLzqIC0LZK+gRBs6VzVzy2?=
 =?us-ascii?Q?4/dBeNRCqkppXgXQGdGVkM6Yadoh1UhFYW9mrP5BImS6OwxJhZTMb6J9EyLN?=
 =?us-ascii?Q?YdIjzU/BNwO6q5acn0DlMkT3TVqYzonUc/jdtd53GE++jwGCcrqs01Q4w3sD?=
 =?us-ascii?Q?tC0bmMDKoePmiFMuIO7Yz1maIfLatcxMrMDI2nz2WVdkrIO5G+S/zQSGyep6?=
 =?us-ascii?Q?Puet3z7HRHMk9Zj3vMf6WoqXHkKMC8hMlm9a6LLHKBmiDuMDmMCZqgB1P08u?=
 =?us-ascii?Q?Hy56sbR7XdiZ2Y7L8+gzZwtQsNZA6Of01BFVjAAQ1dgM0NJou9ZgwWjkAdST?=
 =?us-ascii?Q?2alBW1xjMghm1opgg5pUVSUgS07JAu4YM+vfG3o5tisHptQQ8PZ+AsZCawO1?=
 =?us-ascii?Q?k/DamxAwd/jp221ovqYotBNAsg5Gn3Hg5t5B95j//OSNkHdQUet701AFESpk?=
 =?us-ascii?Q?oi2suPP0d8bMiPRk+J8cOCttsRy9njsxFckdBBImWeOmio7n7bDGSr7GMe03?=
 =?us-ascii?Q?Tw69Q9X0AJRlmNtSvrHoQ7JCT+YMUIoZzFKCymxhas1SrY0ohv5RgojnprJA?=
 =?us-ascii?Q?WDnBzIV0CjsWxK73FqJnBjbiRlIrLgnbnCH35HNZNIUE7fvf0qLrMvCNemDh?=
 =?us-ascii?Q?UfjBmWfCEMilxvz8CtomjdgjpJ9TPFeC4giId1diWt03fokf/7LDyLuH6D/v?=
 =?us-ascii?Q?WSmFVwUAEKqJN6qNTM0qQecL/FLcpz52jPjv5QzuU9RXI3fHFlvZlQIrJOCP?=
 =?us-ascii?Q?5v+Jt4V/7M9M2MeLIOr+5sk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30d42b3-1a59-41d6-eb57-08dd5d069873
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:28:26.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZ8GY1G2s3hlbkwZ5CfPBGIFcTrDn9t57t0/PbtdMFnwX6Ik5BDifaVv/VFQ7fqlYHg1M/JivYavFIaokxUhSYZDz9JENko9l7H5EDwDeS0xIkKrAnFmBRRmK+cZWA6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8888



On Wed, 5 Mar 2025, Robin Murphy wrote:

> Implementations may occasionally want to refer to register offsets, so
> for the sake of consistency move all of the register definitions to join
> the PMIIDR fields in the private header where they can be shared. As an
> example nicety, we can then define Ampere's imp-def filters in terms of
> the architectural PMIMPDEF range rather than open-coded offsets.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


> ---
> drivers/perf/arm_cspmu/ampere_cspmu.c |  8 ++---
> drivers/perf/arm_cspmu/arm_cspmu.c    | 45 --------------------------
> drivers/perf/arm_cspmu/arm_cspmu.h    | 46 +++++++++++++++++++++++++++
> 3 files changed, 50 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
> index f72f5689923c..31cc1a4ac9df 100644
> --- a/drivers/perf/arm_cspmu/ampere_cspmu.c
> +++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
> @@ -10,10 +10,10 @@
>
> #include "arm_cspmu.h"
>
> -#define PMAUXR0		0xD80
> -#define PMAUXR1		0xD84
> -#define PMAUXR2		0xD88
> -#define PMAUXR3		0xD8C
> +#define PMAUXR0		PMIMPDEF
> +#define PMAUXR1		(PMIMPDEF + 0x4)
> +#define PMAUXR2		(PMIMPDEF + 0x8)
> +#define PMAUXR3		(PMIMPDEF + 0xC)
>
> #define to_ampere_cspmu_ctx(cspmu)	((struct ampere_cspmu_ctx *)(cspmu->impl.ctx))
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 81e8b97e9353..769466d55bea 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -40,51 +40,6 @@
> 	ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_cpumask_show,	\
> 				(unsigned long)_config)
>
> -/*
> - * CoreSight PMU Arch register offsets.
> - */
> -#define PMEVCNTR_LO					0x0
> -#define PMEVCNTR_HI					0x4
> -#define PMEVTYPER					0x400
> -#define PMCCFILTR					0x47C
> -#define PMEVFILTR					0xA00
> -#define PMCNTENSET					0xC00
> -#define PMCNTENCLR					0xC20
> -#define PMINTENSET					0xC40
> -#define PMINTENCLR					0xC60
> -#define PMOVSCLR					0xC80
> -#define PMOVSSET					0xCC0
> -#define PMCFGR						0xE00
> -#define PMCR						0xE04
> -#define PMIIDR						0xE08
> -
> -/* PMCFGR register field */
> -#define PMCFGR_NCG					GENMASK(31, 28)
> -#define PMCFGR_HDBG					BIT(24)
> -#define PMCFGR_TRO					BIT(23)
> -#define PMCFGR_SS					BIT(22)
> -#define PMCFGR_FZO					BIT(21)
> -#define PMCFGR_MSI					BIT(20)
> -#define PMCFGR_UEN					BIT(19)
> -#define PMCFGR_NA					BIT(17)
> -#define PMCFGR_EX					BIT(16)
> -#define PMCFGR_CCD					BIT(15)
> -#define PMCFGR_CC					BIT(14)
> -#define PMCFGR_SIZE					GENMASK(13, 8)
> -#define PMCFGR_N					GENMASK(7, 0)
> -
> -/* PMCR register field */
> -#define PMCR_TRO					BIT(11)
> -#define PMCR_HDBG					BIT(10)
> -#define PMCR_FZO					BIT(9)
> -#define PMCR_NA						BIT(8)
> -#define PMCR_DP						BIT(5)
> -#define PMCR_X						BIT(4)
> -#define PMCR_D						BIT(3)
> -#define PMCR_C						BIT(2)
> -#define PMCR_P						BIT(1)
> -#define PMCR_E						BIT(0)
> -
> /* Each SET/CLR register supports up to 32 counters. */
> #define ARM_CSPMU_SET_CLR_COUNTER_SHIFT		5
> #define ARM_CSPMU_SET_CLR_COUNTER_NUM		\
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 2621f3111148..576249e0deea 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -65,6 +65,52 @@
> /* The cycle counter, if implemented, is located at counter[31]. */
> #define ARM_CSPMU_CYCLE_CNTR_IDX	31
>
> +/*
> + * CoreSight PMU Arch register offsets.
> + */
> +#define PMEVCNTR_LO			0x0
> +#define PMEVCNTR_HI			0x4
> +#define PMEVTYPER			0x400
> +#define PMCCFILTR			0x47C
> +#define PMEVFILTR			0xA00
> +#define PMCNTENSET			0xC00
> +#define PMCNTENCLR			0xC20
> +#define PMINTENSET			0xC40
> +#define PMINTENCLR			0xC60
> +#define PMOVSCLR			0xC80
> +#define PMOVSSET			0xCC0
> +#define PMIMPDEF			0xD80
> +#define PMCFGR				0xE00
> +#define PMCR				0xE04
> +#define PMIIDR				0xE08
> +
> +/* PMCFGR register field */
> +#define PMCFGR_NCG			GENMASK(31, 28)
> +#define PMCFGR_HDBG			BIT(24)
> +#define PMCFGR_TRO			BIT(23)
> +#define PMCFGR_SS			BIT(22)
> +#define PMCFGR_FZO			BIT(21)
> +#define PMCFGR_MSI			BIT(20)
> +#define PMCFGR_UEN			BIT(19)
> +#define PMCFGR_NA			BIT(17)
> +#define PMCFGR_EX			BIT(16)
> +#define PMCFGR_CCD			BIT(15)
> +#define PMCFGR_CC			BIT(14)
> +#define PMCFGR_SIZE			GENMASK(13, 8)
> +#define PMCFGR_N			GENMASK(7, 0)
> +
> +/* PMCR register field */
> +#define PMCR_TRO			BIT(11)
> +#define PMCR_HDBG			BIT(10)
> +#define PMCR_FZO			BIT(9)
> +#define PMCR_NA				BIT(8)
> +#define PMCR_DP				BIT(5)
> +#define PMCR_X				BIT(4)
> +#define PMCR_D				BIT(3)
> +#define PMCR_C				BIT(2)
> +#define PMCR_P				BIT(1)
> +#define PMCR_E				BIT(0)
> +
> /* PMIIDR register field */
> #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
> #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>

Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023127.outbound.protection.outlook.com [40.93.201.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFB314B72
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434846; cv=fail; b=BGUyefOoVarP7T8NAW3GJJfwYNQptkZWS8hb3BNNrBiYS0IhQvZn4rmNiN4kyYbOeQ4npEi/OFUZp11e2pXp+RnHNoNUTJyII8zsDwQSJcy2u/VjPgUbiuF0ynX7gKgh5BvWo2sNOLwiV8CKVDDoROGOTlsXiVEH0/PDEfaViZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434846; c=relaxed/simple;
	bh=cjO1znP2Wi3LdVMteMZhaInkx+8yVVr1KXeFTMVuu/Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=TCXt/UCOA/hBN1yzOKjlGH0FAwvSBT5kBj3KZp/ixO1R6jNHurfhHgWWpDu92LuNEL3wSWv48dQNdJ5ubbLx0D6jAud1HVYZJjBbZSRCWyn/dMH2ij1pnRJ/m5gw8wBFcJHNv1r8OJCqdUnM42M07BRqiUKh0qeWB6x1/GfH5so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dQHSK4IG; arc=fail smtp.client-ip=40.93.201.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dQHSK4IG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIYpjie45PRY4bWUjkNskaajevyFJjGgSZaN+NquCH7YXmP2Gvs1MFtWe4uM/PZCzbReXBb3aclrdKVqzAnPFo/S73jN36GO6TDwh+8apAw7T9Seba+ZgLnAD7dlE2u2OgsLXyQ1K7Mr4Np7RX/HrL7nrDdmFgRnATEdIPKuPhy2KCTejH94Oy5KOqd8BiztWXPn3P0+R9wgreOXqJiR4gyfpMSeCT2oqtkb/DLq436mytOYOD0f+v/HqBte/lZpM7RNCOPVIlj3CDAsxUZP3b9EzdmDwB6dK7kfMTRKVLQnnucSIP97jZMpG/Ieai7r5EGHJWVnV7bIyDNj6Zwccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZlRUeJahORB5NAv0kJj9MobL9g2eNCQw2HB/rShhyI=;
 b=X3PPLATQjXMhQcUxPQ0LiRAwqL9FjQxCjyaDUa1QoVBxGSLAyW4GDz6ZjYFjqpNwuuXuXDIqW/WTdcx197srG3Lf9GZZw+cSRoEvBr6eEcVWpFlEoiAx05r4jUXhYw02+GQsAx7b4ABMgjTLWsTT1LS5KU2hUqq3vqhSbiVeak4DFZHb/5AkVdhKIB53fcxWVWtJ8MalXkP0tF3+GGTh22KFr90RkqkVmQz+2sp/HYENrYLgAWYBzwe4qEzTn7t3qXsFUg8pqf0gAH8oKlBTK3hSlE4pZBGRPa/+U14QfJNoWuXUYSsnEacpABY58Z2dB1c87oV8jGPLnqCzKjKKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZlRUeJahORB5NAv0kJj9MobL9g2eNCQw2HB/rShhyI=;
 b=dQHSK4IG75tYfTc2qLf1WAR9XMIKj2e0OqpCZnX/P71VNCW052TwX+ils11WZGQSt5INg5lLejLW7Bm+bA2RqJ/Ud4IQ8JQi1qxrbW61NcGGmp1pszAhIH1W7J3z8uYpP6wmb77t4dtBYjxwsEzznukKqa3EDncMBL2GAleNsdo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH3PR01MB488663.prod.exchangelabs.com (2603:10b6:610:34b::13)
 by PH9PR01MB226616.prod.exchangelabs.com (2603:10b6:510:3e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 04:47:21 +0000
Received: from CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973]) by CH3PR01MB488663.prod.exchangelabs.com
 ([fe80::117d:9e02:c9e7:5973%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 04:47:20 +0000
Date: Wed, 7 Oct 2026 21:47:17 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, linux-perf-users@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] perf/arm_cspmu: Add Arm system PMU
In-Reply-To: <222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com>
Message-ID: <d77d92fa-76ad-0692-2968-915e559fc849@os.amperecomputing.com>
References: <222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To CH3PR01MB488663.prod.exchangelabs.com
 (2603:10b6:610:34b::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR01MB488663:EE_|PH9PR01MB226616:EE_
X-MS-Office365-Filtering-Correlation-Id: 52af19f5-93c3-4fbf-51a2-08df24f73ce8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ARCAxtoObIyrP/xNpUhL7Rs1AYRDVXKTJ1NlQLc1GypmuskKDWqStob6XhABGRXwVwyjRoxN8GhC4N+DcxdaLvimXIJAnYXIjn6DqOLv0uHeepgzyZLB4f63mDh7HqhVvVDtQo8fCRLU290PNgk1b5ywlCaeyrR+kj7LT4oXBeME46D5nCoUQPJIs5KOFuI6KlMEigKLo2wXzLRX/An0GXBxJ/iQQ5z9hEGxv8a4Oy0AyZzkdgOLRzcUVpck5Z64Q3K4JnoFwOWxYqLZAA6fgh4mCPA9NAv1+bQpHSKZOh6JPAo9h+akCOXvV8WvkY8ay57HmFgRjzdqo6gUJrTCzNBGjg1bgxtBBV1PFdVWF34k/Ho6jxUeAA0goRrEHSs0F5fkw1W26NHczYTVfYAnd3Lp2iNxUSLkFcr9j8I/h68CLraXI6Nq2E6Si1wFifHva3ZmpFV4q6SWx4Fu74B7zHcYeobTkH8az3KoLYxj0cE2OgweQc+A70gGL4DCeuKQJzuG1VxcUiuChaysIua5M8OEsvX8lxK1ZOw4fglQloBFTBKkACosMHg1NIsf+oNZWzd0Y26wXpBE0xc2LAdNLMkvy51lONV4rkSP+ByRbAbbzf6iuNCCKPGhlJ15tNSD+cQRpZqxejts4EbvXuzDhnPakTA/KEBo/nUMBbudyuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR01MB488663.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Wv0SvS/j9YKZbWFxRzdnrJ22HTD12/o15LXFI/LWS/NV6fmR7IQJwqGgXJt?=
 =?us-ascii?Q?cyy4DVw0ix9gUfa7xzTaqLB20drkY1iT10tnK5yoxpfGJ4C9baK/V2nRpCDg?=
 =?us-ascii?Q?XHii8TY6xsOifW0fvAW7/2jAWsnQCBserfIP53n/GN9+GY+QsPm60cGeTcHz?=
 =?us-ascii?Q?6aZDfhd6nJejQb/W7sMvT7GJGewGZzpUsjPSuNUR+6Wyh/YaUsUhqyZZuLAM?=
 =?us-ascii?Q?Qhb6v9hmzbYF+UdlnbK+RaKcwQf1NCZ+cmjSXxK0Cr9U9nEZszwgdP9xAZhg?=
 =?us-ascii?Q?mjJkP1EWjdMqLOdqFVpyZG1jctoeMrMMmfH+mMDtbDBLAuCc5Gb+M7fN4sqD?=
 =?us-ascii?Q?vBSEVOQyyqdAPanDNf86+YYle9B6iuQS6HQLv2hPw6fsSbmb4uviWbmqfdbo?=
 =?us-ascii?Q?0/POtCPh9vwbQgZbT8vTZ4KG7ug1NiYbMd+YZfmXo1Dm27rYqeXwVVnnfJJs?=
 =?us-ascii?Q?ej/ROqGkrlkf9wSLrFRL0EsB7mw585z4Foym/0b3mG+qXvIEcsq1fQBrjWfr?=
 =?us-ascii?Q?tlTPwgL02AjX07VAytTlRjJd7GPBE6qhrY3ebIV1u6qetkJt3hnSuk1Spc8w?=
 =?us-ascii?Q?TwaE/NeLoX9U0Y0UC3UHr559dorI7vywrQLINZKmMuLz0qBxg79oYxq013K9?=
 =?us-ascii?Q?sVRd+jvQghX0TzZVN313ZKRINf700tXWVRtKHGCCjElkB1Oj1v7Sq7A7a1Jx?=
 =?us-ascii?Q?E9R3cRyyIYEBUOVi6f9TBg0KV52qY4n96rCzqmViJf0N33Y5k1Iu4IdgGv7R?=
 =?us-ascii?Q?L3n8Gs2zcEOuFm4Eu1u2tOvjYAAZNEBWGAavhQfXg4OHOlwbhW2cln22e1Rj?=
 =?us-ascii?Q?HUqgMrHy5I8olWCeRaVbz8lMs9aO0k4Luwim5qfwbSedmnDTQTAPpOLhQpAr?=
 =?us-ascii?Q?b3hYuSLQ42HdzkO4nn9FC2L+DkL3Jfl9b8pCOfxpvdtAy1TEJcdWrJwFnwd3?=
 =?us-ascii?Q?2CeETVyX/N59Mgeziw7eZgtDc3nsY1H2o2vQFVDcHwNBgb0nJ3PHWSbhCw6L?=
 =?us-ascii?Q?eAQ9dF/M2MFQkHB6mxJ9OjLJXijk5p6GbRBMLT3CH3GD/DgxsMywf+pltcNY?=
 =?us-ascii?Q?6P8D2yMGMhyFfKZQfEbfVKFWdpPPrWoxVTVd+Hn3RLOZZYRAbxCfp+H52bnI?=
 =?us-ascii?Q?W8DpzQVu/eSAJW0c15R6g9cWtUJNBYU+gZsRCGONYe1YQllea5J5/9gx3OT3?=
 =?us-ascii?Q?QNCKPfiaL/AiIyNda7pFVq0XH4s6qItJKgBQ2fES8qzu3KlC6EprFFSJE/yi?=
 =?us-ascii?Q?kgkL3PULpHNgHFnrIjbwb/m0SbR8urazKTLc3l7CvXweHvdy8BIY7Q2sOc5Y?=
 =?us-ascii?Q?xJsKD4Ejq5gn6mkDxhNsmyQu/hWldgMYc2dSsrMHWKGhuxnpvZziNO8xO/Mo?=
 =?us-ascii?Q?wEINzkpt96eguh99exFMOXSQkSvMXKhEOKyENGlMJg3vOfXwn/OWrqoCS4NA?=
 =?us-ascii?Q?yLkMi0SuLSFCwzImA1FA3p4wl0Td2fjAt/INLMhku4wmvRbI/NjLA893AHQS?=
 =?us-ascii?Q?1xkjJTz2ntb/G4HzGuOkyJtTDQTum2P8oxLTjGD8OEVeKiGAP88mSlEyvwwY?=
 =?us-ascii?Q?pR3i4EIGdIeLs1bfJVtND8fyB6Niz1PJkwzvY6nmZCn0lUewQdONpkiIRmUk?=
 =?us-ascii?Q?i7LQk7p3T5GtXgaGES6M+T/ZcsvYPrggxXpQzXLiUDBOnpnlGekMRDt3cVpz?=
 =?us-ascii?Q?maktKp7gYNeDoDCcT7qW9/MYuJOjUtkZp2UHQc2RxPhTQtDiGiqSPxodamHW?=
 =?us-ascii?Q?aM6j7iKHR9dTeXK8Oo0oqrEH/UT9RcY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52af19f5-93c3-4fbf-51a2-08df24f73ce8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR01MB488663.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 04:47:20.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZVQsonTbPdBGMCQ3Pu9IIuv+h8UYM7yQ1jGybnJbTsLvrFrL2Ois+2sMa2w/JHGyDsNJeu/4LVoyPqpAKQjZQ69rERhzV2a9p1Do+C0bq1YywDNqq3czNaJkSg99TWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR01MB226616


On Mon, 5 Oct 2026, Robin Murphy wrote:
> Arm's latest Compute Subsystems and SoCs are using a common PMU block
> in various places which can mostly just be driven as a generic 64-bit
> CoreSight PMU, but does have an IMP-DEF register for additional
> filtering. The details of event and filter encodings depend on the
> particular PMU instance, so are left to the higher level Arm Telemetry
> Solution tooling.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me,

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


> ---
>
> v3: Fix 32-bit COMPILE_TEST to match arm_cspmu.c
>
> drivers/perf/arm_cspmu/Kconfig      |  7 +++
> drivers/perf/arm_cspmu/Makefile     |  1 +
> drivers/perf/arm_cspmu/arm_cspmu.c  |  7 +++
> drivers/perf/arm_cspmu/arm_cspmu.h  |  1 +
> drivers/perf/arm_cspmu/arm_syspmu.c | 67 +++++++++++++++++++++++++++++
> 5 files changed, 83 insertions(+)
> create mode 100644 drivers/perf/arm_cspmu/arm_syspmu.c
>
> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
> index 6f4e28fc84a2..25bd55f036a4 100644
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -27,3 +27,10 @@ config AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>
> 	  In the first phase, the driver enables support on MCU PMU used in
> 	  AmpereOne SoC family.
> +
> +config ARM_SYSTEM_PMU
> +	tristate "Arm System PMU"
> +	depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> +	help
> +	  Support additional event filtering attributes for the CoreSight-based
> +	  PMU blocks found in various parts of Arm Compute Subsystems and SoCs.
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
> index 220a734efd54..90c3cd710157 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -8,3 +8,4 @@ arm_cspmu_module-y := arm_cspmu.o
>
> obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
> obj-$(CONFIG_AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += ampere_cspmu.o
> +obj-$(CONFIG_ARM_SYSTEM_PMU) += arm_syspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 912f03ce3ef5..9f298ea1a974 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -358,6 +358,13 @@ static struct arm_cspmu_impl_match impl_match[] = {
> 		.module		= NULL,
> 		.impl_init_ops	= NULL,
> 	},
> +	{
> +		.module_name	= "arm_syspmu",
> +		.pmiidr_val	= ARM_CSPMU_IMPL_ID_ARM,
> +		.pmiidr_mask	= PMIIDR_IMPLEMENTER,
> +		.module		= NULL,
> +		.impl_init_ops	= NULL,
> +	},
> 	{
> 		.module_name	= "ampere_cspmu",
> 		.pmiidr_val	= ARM_CSPMU_IMPL_ID_AMPERE,
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index c4058d602477..03e34692a965 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -149,6 +149,7 @@
>
> /* JEDEC-assigned JEP106 identification code */
> #define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
> +#define ARM_CSPMU_IMPL_ID_ARM		0x43B
> #define ARM_CSPMU_IMPL_ID_AMPERE	0xA16
>
> /* PMDEVARCH */
> diff --git a/drivers/perf/arm_cspmu/arm_syspmu.c b/drivers/perf/arm_cspmu/arm_syspmu.c
> new file mode 100644
> index 000000000000..2f5ceda5c4d1
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm_syspmu.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +
> +#include "arm_cspmu.h"
> +
> +#define PMEVFILT3R	0x200
> +
> +static struct attribute *arm_syspmu_format_attrs[] = {
> +	ARM_CSPMU_FORMAT_EVENT_ATTR,
> +	ARM_CSPMU_FORMAT_FILTER_ATTR,
> +	ARM_CSPMU_FORMAT_FILTER2_ATTR,
> +	ARM_CSPMU_FORMAT_ATTR(filter3, "config3:0-63"),
> +	NULL,
> +};
> +
> +static struct attribute **arm_syspmu_get_format_attrs(const struct arm_cspmu *cspmu)
> +{
> +	return devm_kmemdup(cspmu->dev, arm_syspmu_format_attrs,
> +			    sizeof(arm_syspmu_format_attrs), GFP_KERNEL);
> +}
> +
> +static void arm_syspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +				     const struct perf_event *event)
> +{
> +	u32 offset = 8 * event->hw.idx;
> +
> +	writeq(event->attr.config1, cspmu->base0 + PMEVFILTR + offset);
> +	writeq(event->attr.config2, cspmu->base0 + PMEVFILT2R + offset);
> +	writeq(event->attr.config3, cspmu->base0 + PMEVFILT3R + offset);
> +}
> +
> +static int arm_syspmu_init_ops(struct arm_cspmu *cspmu)
> +{
> +	switch (FIELD_GET(PMIIDR_PRODUCTID, cspmu->impl.pmiidr)) {
> +	case 0x9c3:
> +		cspmu->impl.ops.set_ev_filter = arm_syspmu_set_ev_filter;
> +		cspmu->impl.ops.get_format_attrs = arm_syspmu_get_format_attrs;
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static const struct arm_cspmu_impl_match arm_syspmu_param = {
> +	.pmiidr_val	= ARM_CSPMU_IMPL_ID_ARM,
> +	.module		= THIS_MODULE,
> +	.impl_init_ops	= arm_syspmu_init_ops
> +};
> +
> +static int __init arm_syspmu_init(void)
> +{
> +	return arm_cspmu_impl_register(&arm_syspmu_param);
> +}
> +
> +static void __exit arm_syspmu_exit(void)
> +{
> +	arm_cspmu_impl_unregister(&arm_syspmu_param);
> +}
> +
> +module_init(arm_syspmu_init);
> +module_exit(arm_syspmu_exit);
> +
> +MODULE_DESCRIPTION("Arm System PMU Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.54.0.dirty
>
>
>

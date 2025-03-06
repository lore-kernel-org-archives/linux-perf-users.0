Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2097.outbound.protection.outlook.com [40.107.236.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428527C16A
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303779; cv=fail; b=iX9m45bxNYr1uf6Sh13ZD75qHVtqtvZpZBrVB9Igpk6Ghf1L33nalBveEXwC3pgJ7rvinjee1voAgD4KEIYrqlEinJ/v0KJPmsf0x7/HiyvjOnh3sS5nv+cLXL2RrXIj8tNR8a2e5mxQH700oCGYBS222v4W0tynZcRtTzYHkHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303779; c=relaxed/simple;
	bh=JCBrdFCNXoqVkD+DUUrnsMJdobXWjNFspwIqJrj1kCU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=TEcm8p179Xf8NzmEpU+4E6uQz0Mef6/wy0tJQx4JFzME4JBw0FBTPlkwLaVLpJE45Axbjd6b85O50XK+ZjqP2EFqztJz//qC0HRsCpi1w4bK8T4C4HoML9Y/r6shH03pXOHU4nFc4kdLWdhy81b5iyfSvB4d1ZI2ITJweo8x6P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GTEWhy7L; arc=fail smtp.client-ip=40.107.236.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GTEWhy7L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZGBUys/6RiII3TQH+nvRLfhw2mCoEevGVGK1rKeikpCcKINXKjWm7EIbPC7VuicjxOVvFLh6ZrKr2khSC34kxLLUaGrjqbnqoAybsMMygpPUImk4KuzsrDQuaEYvNX7y2H6YPDtsDPQgFxn1PTBuWCz7i5sGp4NdbPvtjfX38gifzyMGY3l92lomoPXLj8wnhqXsjwvD3Q68Ihxsrh/OuWGJEq+/buZcJLVNCOqBbN7cULzGRNqhK0n+UQJrHPxK5P21NSbx2+aiukq7fPYINPY7r0SG9LOU29XbdPvLg7Dt1jFvn4hDGVagnIaNJ40yPC1GjLt1BTBTJDrC2Avlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8+K1FhSvIXaEOHEO/P6eoS74zrnp7gdZWB1WbyTM7M=;
 b=Tz4Sj4nU5vn1bm2epMaH1ys87uiTKJo70k6XXGoZffMcxSZwPsNIDV6o5d/BI96+PzqH+vUqXzmxNauuO3yzz5QcUFkhTfsT7fjwTRWp2z8tF0uDWKc0xONMgEYlZc1U5V1fNU3hxBQDerY4fuVx9DzkQZNhS+x2fZYPcRwMaO5Txo11WU0PB52dr4worF3etYR3DspzPQ+72DWRRvT3hx46wSw1CvI5Vy3BfII4VC2ZaWjJBdZU9Lqk+JnT3gFx8Uu1ZyHcrsB0MeilSdKx+5jYa1qX6DvvGHV6LuCipwR+b3mcNrQ6iPYKvvOqTWpCp4EEQnDRkTp8kUOowpjrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8+K1FhSvIXaEOHEO/P6eoS74zrnp7gdZWB1WbyTM7M=;
 b=GTEWhy7L//hW/s6IMnE/uJg7fpgaxhvlAL0GyQ2QjSvIJ5KvQD6yfcM7Bw23+f+9A7UE5HtxYOIJYRxJEReuY3jRqCI5GvrH5GDQT/ZUCfOhl5Hxngwm1XmZVzD5N4Z39fwdBUYB2+xbRv1sxbbJCB865jDNAQ8A62H1EY4+GFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CH5PR01MB8888.prod.exchangelabs.com (2603:10b6:610:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 23:29:33 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 23:29:33 +0000
Date: Thu, 6 Mar 2025 15:29:30 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, bwicaksono@nvidia.com, 
    ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf/arm_cspmu: Generalise event filtering
In-Reply-To: <c0cd4d4c12566dbf1b062ccd60241b3e0639f4cc.1741190362.git.robin.murphy@arm.com>
Message-ID: <d3e13b6f-ce6e-6e73-6d3e-7c91856665c@os.amperecomputing.com>
References: <cover.1741190362.git.robin.murphy@arm.com> <c0cd4d4c12566dbf1b062ccd60241b3e0639f4cc.1741190362.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CY5PR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:930:2::29) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CH5PR01MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab79b7c-d572-4770-4cf5-08dd5d06c06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7Is9VwQSSA0NEN15R8DxbpZbfKNHWseg8hMLClon2YE3KBc4Y3rlTNvv5xp?=
 =?us-ascii?Q?4GMMtsKUWezDA7Z8mr+6k9Dksj3sJ2TlWWTVXlZsabULQW1g6nuZQmUcFabN?=
 =?us-ascii?Q?VgzGEFiJZG3fyhopUvLxpWZroqQczzXMNGMtbsTzqx6PNl/wZsmcKgqxu0lu?=
 =?us-ascii?Q?ShtXJm8QpSby8xl3r3TpkVz9mySPYZBb3yrXOsFUzSeTwjMhIxRUjBEgrVeS?=
 =?us-ascii?Q?gLFLr2blLBNrA0etUHkTHzSOLWKM8KyBAHVUIWVyBOFZe8DbA7UU4mYG7Ojw?=
 =?us-ascii?Q?mR2GX2UtuNNEDiicPU4T9zxsnKLd7GYMCVMuGV/2sBEQnlqyO8TFTpJWCuUR?=
 =?us-ascii?Q?xkUIoPwMCMGGFVA3XuefUFNK7XnSxFxtjBLXNvehptf3DxkxWas8WARssyCQ?=
 =?us-ascii?Q?qiSWF4k0y7Bg/mv5+casmi1TcoKb9TPIrbH3EmdNwTpVQOh375trA7e7o3J/?=
 =?us-ascii?Q?+vQHdjzn15FBYeW9vtke6CxovpbpuVQciMIB7oyMwOYnbomyI22IQH8kJRiC?=
 =?us-ascii?Q?wqCTpQ3Loo3FDsvz3ha2K1Ll0AVeToU/M44jxks/vXXvFYDQWt87Oi5UFZ4M?=
 =?us-ascii?Q?a4RAia55fO5vEAmF92CNrxdyLbyTz+ey7jA9+Ioi8MAQ/QcSgeRuFeVqbyDJ?=
 =?us-ascii?Q?voqSWGcfhgdGLSyXp7y01m0ILkCyiR4OkFn0Ap9j/qk9vNlBlSXWy3Br0DYm?=
 =?us-ascii?Q?Ji/R6cT3skIxVPkM+O/xhqonIoaqnY00tljyBqT/wkun2X2L/hM4sIyzVd2i?=
 =?us-ascii?Q?5DBPMTpSoCDjPEkM8MAKzTTUabzsjlGjNQ8NeauyGTBK6alKd/WoZorJmvZs?=
 =?us-ascii?Q?lTn7G+hbJFNAYb4q8g05Pr22LccrLH/69+WLg2k6FeO5WQN18AB/abudQxaY?=
 =?us-ascii?Q?fb8gGz9MoupJewAEfj++KkW5kk0BWSvA00MGXvSVxWg6IWiQTEayrzsORiSD?=
 =?us-ascii?Q?/BRjE0YlLHyuJB/e/Kh6V13iUXuUYbpJ4RPfclP7eyavUtjTGhZAApAx55Mu?=
 =?us-ascii?Q?B63/ql0YW1WQrzN4GWGhQQyXW3BZWO/NnSaQ9vOYB89DXLh4tPwrF7IqIzlz?=
 =?us-ascii?Q?itdEDRRKzSf1ve0HxBllnfnvyuHohfGdn4ltAEu7Y7KGW94Fv5xy8HbHEq8a?=
 =?us-ascii?Q?KuQXnkXzS9qMm2dq/Mxg2+Om3Mt3M9eR6VHagf7DJFymle46w++/Th1TeZ+0?=
 =?us-ascii?Q?Ost7ZM0l1KMeww1r8xrARAh6FhRblBWc2Nn1BkkLMNXiVGBAwLp+2VcTtqEF?=
 =?us-ascii?Q?SpBSi7A9Ad3C9UR1IN0IT7rlYeun1vt9WMxUmwN7TeopbOim8G2pKqDpmo8P?=
 =?us-ascii?Q?vJv64yz7mUuA2dyuhZUdXirtyyPJvDlMZ44LY5BqC/nUU7sNhuo96mt/F/qG?=
 =?us-ascii?Q?uWgHBQJeFPutd9xlR1b1/HPK8RKkaKO1BZ9RF+gw7dS4AAIQ2Y237BEZCVj8?=
 =?us-ascii?Q?Cg8WSsZTlZ3EnBnhVJKdBCsPVYVkdd70?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ueKu3SUGU1R3+5IySlo1wzZhi2QQC1xc0YhuJIEZov8QBDQcUFDayal2eDJ?=
 =?us-ascii?Q?hldNvip+rGIRcVAZ/pUYjRtr9wduuP8uZoHp26UBsy7uvVE/cQsxy6LSpW4h?=
 =?us-ascii?Q?eahgobeT6RzAbs2dGF0s8lTUkNTEESYW9ub/JFoDCJTRadEu8e+CfeYRl+tX?=
 =?us-ascii?Q?osUWAO5nhnDcP7P6mAWLaBeBDG81cp26kswy9RTKaQCA99SRPpvjWQWFnCF2?=
 =?us-ascii?Q?3ggPSVgFQUjMdw9ejLmxDYW2m9h/DYez4TpdqtA103dREjsk29GICEKU+LZI?=
 =?us-ascii?Q?GHC6pWKdsMNE0YXY6xYwQviSjEKPUZ6Y9CmFojZPOuOcR9duvj+GsGZx4hcP?=
 =?us-ascii?Q?s4wOMEHEVNDsDEVf4QHbiJyP6uUZOuD43n0UtexSTGOo+ZUi1fy1cFXJURp9?=
 =?us-ascii?Q?K8oW8AP5OrqmdnOlYZiagV4vXK6/3KLpgfTRfNSJqWGBHicbHcBxPGxgYapc?=
 =?us-ascii?Q?pfFJJkKW7C/vAOUPaVMbdSbiegDfmBmvu9FultJeFa1sGX+kNSX409/oQyLL?=
 =?us-ascii?Q?C8HN0jZ/6bsrh7+zP2iJWAooaq50SdNPtr6c1qINq48YUR4jRwkrtmKjzjCY?=
 =?us-ascii?Q?6Z1Th9tg5WRdlUMrkmt3VzFjMPwBAu+AI7DAX9PENM/Ur2oGlYjZakDXmwrn?=
 =?us-ascii?Q?qu2GbenXcrVIx47prm9nCAX1OP1SuwSsEJzlmF5kgQQFXVo6jLmmWhqfgoYT?=
 =?us-ascii?Q?aGUOGyqnaEQ698VeNmttaIAQbsg92snwNKDFJa1WpVDvupRcgM3uuMMgFqWp?=
 =?us-ascii?Q?1FDe+Us+TyxLdHxUlFqe6U5LLwBBUlDehc2PPKm4TzPRBvS4rEOUyZytJoXq?=
 =?us-ascii?Q?GBYomI5NeY6YnHAxbbRr+cYfoMJG2tUpPxknW9jDJqdsYy4b+sGpQPYdMaZZ?=
 =?us-ascii?Q?6tdfdWqN4CXuJGfsPsLqomVT4e2aw7DI8AXNa1YJ4Nfe1ziHqHax+QQEXjX1?=
 =?us-ascii?Q?DqmzCEUM+LbVSA+zi+MAW06sQZEZencUwEcJ7W6EBM+PYCeZvhuwqZ4HLO5K?=
 =?us-ascii?Q?+B8qcW+yGQUUPxVIaAnT+KhHSXRuI//JNlLyvu/zHtmtRkUKEcZE4qCLjEUt?=
 =?us-ascii?Q?N3g76fWqcdZL4tZ9H9At5ENyRUeU9goJxNWL4raXDe5huKcI0iwMVtCCC4mG?=
 =?us-ascii?Q?9/0zamy0S00R+N39BP0Lf005kjxxcgUEmKPD/tx3aWDE4UoZEEWoibQHY1qp?=
 =?us-ascii?Q?K1ogSYdzZ71KUVeNYyATh+eTsYgVkWAQr7XJUeWC5DTSGTfALuy7UZWIgBWU?=
 =?us-ascii?Q?pXmH9FUrcGbXM78a6YBzDCpo5z4UvQa61QnE5SVPYjPxx1ZpgKsai1JPV0h9?=
 =?us-ascii?Q?J3Zcq/unaYe/Bhi7M58RTPHcpl5pFYpcH3uQ4CSSL76jeBn9O/o+J84WqebN?=
 =?us-ascii?Q?Pe1U5zXkZaQHXdlAXgpEFI0IZ1yOpAXZV1lp0F9m1xdG7fEvfMwgoS6KUABX?=
 =?us-ascii?Q?MrGC3UJMPGyUp2Cl4rlFhbcNAXCrukJkAIMv53kd257GBaswWB2gtIZQPA7O?=
 =?us-ascii?Q?wcu5KU2AGnVo68Z/rdoGTi5myE+Hyyu7KiD7AeoPUjGRb5/NbE41UGSvUEEA?=
 =?us-ascii?Q?4seq3rjfhinjOBMfFdZWEgdM54hll1DMvMrIuKf7/tOrbJPjLPYrTuPLk9BF?=
 =?us-ascii?Q?uICPwAhpYwtHTCCKVhn3oJA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab79b7c-d572-4770-4cf5-08dd5d06c06a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:29:33.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmMqwGRlPzlmhzc1xa7WidTn8dQ3gx+WtYQezWmzWEoYCBOnWNOoVvU051n+0ncaO6AhHIePQCcC63DxLUgxp1oR9QhzfvwiHX7PMpRL4LMqsUEEp6Q6oESmSaNjgZ14
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8888



On Wed, 5 Mar 2025, Robin Murphy wrote:

> The notion of a single u32 filter value for any event doesn't scale well
> when the potential architectural scope is already two 64-bit values, and
> implementations may add custom stuff on the side too. Rather than try to
> thread arbitrary filter data through the common path, let's just make
> the set_ev_filter op self-contained in terms of parsing and configuring
> any and all filtering for the given event - splitting out a distinct op
> for cycles events which inherently differ - and let implementations
> override the whole thing if they want to do something different. This
> already allows the Ampere code to stop looking a bit hacky.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm_cspmu/ampere_cspmu.c | 24 ++++++----------------
> drivers/perf/arm_cspmu/arm_cspmu.c    | 29 +++++++++++----------------
> drivers/perf/arm_cspmu/arm_cspmu.h    |  8 ++++----
> drivers/perf/arm_cspmu/nvidia_cspmu.c | 21 ++++++++++++++++++-
> 4 files changed, 42 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
> index 31cc1a4ac9df..b8ca69fd9d1d 100644
> --- a/drivers/perf/arm_cspmu/ampere_cspmu.c
> +++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
> @@ -132,32 +132,20 @@ ampere_cspmu_get_name(const struct arm_cspmu *cspmu)
> 	return ctx->name;
> }
>
> -static u32 ampere_cspmu_event_filter(const struct perf_event *event)
> +static void ampere_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
> +				       const struct perf_event *event)
> {
> 	/*
> -	 * PMEVFILTR or PMCCFILTR aren't used in Ampere SoC PMU but are marked
> -	 * as RES0. Make sure, PMCCFILTR is written zero.
> +	 * PMCCFILTR is RES0, so this is just a dummy callback to override
> +	 * the default implementation and avoid writing to it.
> 	 */
> -	return 0;
> }
>
> static void ampere_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> -				       struct hw_perf_event *hwc,
> -				       u32 filter)
> +				       const struct perf_event *event)
> {
> -	struct perf_event *event;
> -	unsigned int idx;
> 	u32 threshold, rank, bank;
>
> -	/*
> -	 * At this point, all the events have the same filter settings.
> -	 * Therefore, take the first event and use its configuration.
> -	 */
> -	idx = find_first_bit(cspmu->hw_events.used_ctrs,
> -			     cspmu->cycle_counter_logical_idx);
> -
> -	event = cspmu->hw_events.events[idx];
> -
> 	threshold	= get_threshold(event);
> 	rank		= get_rank(event);
> 	bank		= get_bank(event);
> @@ -233,7 +221,7 @@ static int ampere_cspmu_init_ops(struct arm_cspmu *cspmu)
>
> 	cspmu->impl.ctx = ctx;
>
> -	impl_ops->event_filter		= ampere_cspmu_event_filter;
> +	impl_ops->set_cc_filter		= ampere_cspmu_set_cc_filter;
> 	impl_ops->set_ev_filter		= ampere_cspmu_set_ev_filter;
> 	impl_ops->validate_event	= ampere_cspmu_validate_event;
> 	impl_ops->get_name		= ampere_cspmu_get_name;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 769466d55bea..053bb7920df6 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -66,7 +66,9 @@ static unsigned long arm_cspmu_cpuhp_state;
> static DEFINE_MUTEX(arm_cspmu_lock);
>
> static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> -				    struct hw_perf_event *hwc, u32 filter);
> +				    const struct perf_event *event);
> +static void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
> +				    const struct perf_event *event);
>
> static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
> {
> @@ -205,11 +207,6 @@ static bool arm_cspmu_is_cycle_counter_event(const struct perf_event *event)
> 	return (event->attr.config == ARM_CSPMU_EVT_CYCLES_DEFAULT);
> }
>
> -static u32 arm_cspmu_event_filter(const struct perf_event *event)
> -{
> -	return event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> -}
> -
> static ssize_t arm_cspmu_identifier_show(struct device *dev,
> 					 struct device_attribute *attr,
> 					 char *page)
> @@ -371,7 +368,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> 		DEFAULT_IMPL_OP(get_name),
> 		DEFAULT_IMPL_OP(is_cycle_counter_event),
> 		DEFAULT_IMPL_OP(event_type),
> -		DEFAULT_IMPL_OP(event_filter),
> +		DEFAULT_IMPL_OP(set_cc_filter),
> 		DEFAULT_IMPL_OP(set_ev_filter),
> 		DEFAULT_IMPL_OP(event_attr_is_visible),
> 	};
> @@ -767,26 +764,26 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
> }
>
> static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> -					struct hw_perf_event *hwc,
> -					u32 filter)
> +				    const struct perf_event *event)
> {
> +	u32 filter = event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> 	u32 offset = PMEVFILTR + (4 * hwc->idx);
>
> 	writel(filter, cspmu->base0 + offset);
> }
>
> -static inline void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu, u32 filter)
> +static void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
> +				    const struct perf_event *event)
> {
> -	u32 offset = PMCCFILTR;
> +	u32 filter = event->attr.config1 & ARM_CSPMU_FILTER_MASK;
>
> -	writel(filter, cspmu->base0 + offset);
> +	writel(filter, cspmu->base0 + PMCCFILTR);
> }
>
> static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
> {
> 	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
> 	struct hw_perf_event *hwc = &event->hw;
> -	u32 filter;
>
> 	/* We always reprogram the counter */
> 	if (pmu_flags & PERF_EF_RELOAD)
> @@ -794,13 +791,11 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
>
> 	arm_cspmu_set_event_period(event);
>
> -	filter = cspmu->impl.ops.event_filter(event);
> -
> 	if (event->hw.extra_reg.idx == cspmu->cycle_counter_logical_idx) {
> -		arm_cspmu_set_cc_filter(cspmu, filter);
> +		cspmu->impl.ops.set_cc_filter(cspmu, event);
> 	} else {
> 		arm_cspmu_set_event(cspmu, hwc);
> -		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
> +		cspmu->impl.ops.set_ev_filter(cspmu, event);
> 	}
>
> 	hwc->state = 0;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 576249e0deea..d59040d6a7e3 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -149,11 +149,11 @@ struct arm_cspmu_impl_ops {
> 	bool (*is_cycle_counter_event)(const struct perf_event *event);
> 	/* Decode event type/id from configs */
> 	u32 (*event_type)(const struct perf_event *event);
> -	/* Decode filter value from configs */
> -	u32 (*event_filter)(const struct perf_event *event);
> -	/* Set event filter */
> +	/* Set event filters */
> +	void (*set_cc_filter)(struct arm_cspmu *cspmu,
> +			      const struct perf_event *event);
> 	void (*set_ev_filter)(struct arm_cspmu *cspmu,
> -			      struct hw_perf_event *hwc, u32 filter);
> +			      const struct perf_event *event);
> 	/* Implementation specific event validation */
> 	int (*validate_event)(struct arm_cspmu *cspmu,
> 			      struct perf_event *event);
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index 8116c7846a46..9e817f120828 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -183,6 +183,24 @@ static u32 nv_cspmu_event_filter(const struct perf_event *event)
> 	return filter_val;
> }
>
> +static void nv_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +				   const struct perf_event *event)
> +{
> +	u32 filter = nv_cspmu_event_filter(event);
> +	u32 offset = PMEVFILTR + (4 * event->hw.idx);
> +
> +	writel(filter, cspmu->base0 + offset);
> +}
> +
> +static void nv_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
> +				   const struct perf_event *event)
> +{
> +	u32 filter = nv_cspmu_event_filter(event);
> +
> +	writel(filter, cspmu->base0 + PMCCFILTR);
> +}
> +
> +
> enum nv_cspmu_name_fmt {
> 	NAME_FMT_GENERIC,
> 	NAME_FMT_SOCKET
> @@ -322,7 +340,8 @@ static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> 	cspmu->impl.ctx = ctx;
>
> 	/* NVIDIA specific callbacks. */
> -	impl_ops->event_filter			= nv_cspmu_event_filter;
> +	impl_ops->set_cc_filter			= nv_cspmu_set_cc_filter;
> +	impl_ops->set_ev_filter			= nv_cspmu_set_ev_filter;
> 	impl_ops->get_event_attrs		= nv_cspmu_get_event_attrs;
> 	impl_ops->get_format_attrs		= nv_cspmu_get_format_attrs;
> 	impl_ops->get_name			= nv_cspmu_get_name;
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>

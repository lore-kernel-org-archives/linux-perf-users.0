Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3025C71B;
	Tue, 10 Jun 2025 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749522413; cv=fail; b=bv6lfmI0cOcmwqEfUjjBJ1c/z4kTH6F04XBRU8qMSzaaD7wk2kAp3A7oeuBPQDn1NtThPkjxVQpou7SswFrYeOZT1VQB9IRUbeB0BtodKWTUW6MFUbKBeXcfkzogEuvY5XGX2dDexJSub6i0N6IG8fuOVOdTAWuHn5YQjf3ur78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749522413; c=relaxed/simple;
	bh=XNYBM6FVHdwo8UJtvZdgQFKpq5IOYhVQd0hfIW9O+SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+qFB0IHCuGhFruO+bZHRtgn2ZBrHjVBdZCRDDlCo+X5MevHKOfRwPFlhP+c7V+RidC1qXLq3oGUAYV4QvyMTPHD9TMt0wE0uOJCntoBsAGmVnyoi+/uswrN6af6tIeQu1jPKzqJsPnnx3YGBw+wdVxZ84cG55dgSUEbzMkZ0ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0aAkavD; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0aAkavD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKvx9b6oxbCstTE/4mI69KI4FuzZy0Ubgj8tqYdxFTp84efh2We6Ik4M94AKYKuhjRnwmjOMLBTwOCL0Umk4DVllsPHHFdqrgaCa9Fr4QtUYcmHy2vzEJAoKywDX54BH5eNqc0w+MLaQ/kA59CRs7edHR8lNISAiw1FvKWyFaR+E7/mR6iarZbYtO5xSrob5Sri/vW/q3RsIM28aXT8svXyhcGSC8KZki1Yegq0VLthnUJglHn4GrAaSnmq2c3/4XpvH36Gvfa2YP23dq6Ph2dIzOuJoaggjiDUMO7/QubP4RIec1mJSihsQ+6bOtNMIXydvVQ5Khy7YFDpvUA10iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqZL3N3O/tFETQW7NNUVwRdO2jnz3KK4X7MNcM+HTTQ=;
 b=JKV3Cfkeu1SylCHGrFcOFI9WyyvCLeHDlGR6iKnSjkOlzvP6xije5XPOkOL+mm2Ldaex0z3nNSehojn6DHOx48qI0QlpQq4CbKUxbgC1dZ698GkGX3oDcf9gjxwnF1W+o/RV8HBi+2AobHAXXGkqpoYGswb7OmJOA2lRNq0geObmg+xIL1nWjxhnPoOXRzn+vgaCOASwIyxKZf96KvF7LtcELPfXUptcrHRLOumxi8e3VfjFfvObpNxlxR5t+5dktNpHzpCV2qP9dtmXOMUSZZGRLmQSW7IuTkH5xz/TzOS7/dGF6W80i/hC5yB1vhgnq6TG3vrOrUZGtnWMCwuXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqZL3N3O/tFETQW7NNUVwRdO2jnz3KK4X7MNcM+HTTQ=;
 b=H0aAkavDqKHIepCcW2GDr21wBnmapcWSa0sNhy81W7BYcRT2OZyuxtf5o655/x4oDZhbTCUyfGnfFEdKVx2DETk42s9S9OWQfAIk7BUvwuK/ixr5vGp2QVtVngQU7qBpeGD7ih6a0HT0lPccUj5wKq/GNo/4x7TCNpK+iaiuecN96o95DfJMxpoM+r8mKNKvqIGoNSLq20sG36mcp6NJf8tUbDkHcA2NiXvQxx0U17zqxc9HYqtCyt3TSh1GjqtRvCqaTuQL8EZaej+zc+y7p8V7gNfFq2FwG8VqS3OUKOwV5mLy/4qdS9r3P98mVdU/bYm7GTEiXPXuvMSFFSybyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 10 Jun
 2025 02:26:48 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 02:26:48 +0000
Date: Tue, 10 Jun 2025 12:26:44 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Shivank Garg <shivankg@amd.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, david@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
Message-ID: <yhmscjk4j22mi6yjqpswighh2h5phnmdc7cr2otvn43ng4w577@vheecvjlwmmr>
References: <20250609170806.447302-2-shivankg@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609170806.447302-2-shivankg@amd.com>
X-ClientProxiedBy: SY5P282CA0172.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::19) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb81e3e-ddbd-46cd-b704-08dda7c6406b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x4zRBu68SHLoVucs54q4ZfeVkvyH+wk7bf50nljpdtNaNEeGKglmeTvmsaEE?=
 =?us-ascii?Q?8HhzNfrUCk28jC+xeU4OXQOYOBxWTYhhCSdmL5VIec5hT/h1A9MjRSkcvRax?=
 =?us-ascii?Q?z1CdeewAB72lv4hlosc27g27iog0ScUjUvDIZAAnY4FgsDMVViKdDanixebO?=
 =?us-ascii?Q?GKTW4WkL65vrcdrWiYOe22dIGhmHYCQbikahs4D3q7rq5FAKebuXQWIfaIRt?=
 =?us-ascii?Q?T0waSMjXmB9/g+8d2lhCT8Qrr6HB82F9+GPfoNmOO6WupWwA/JmsE9ykhYsW?=
 =?us-ascii?Q?zPOb3HMLTjywnM0h5GZadUsIGEnChwElcQba9N4JZVwiIBWuo3TU0ebLtDII?=
 =?us-ascii?Q?rB2cGDytw+UDeBKWqJ7KpsutBP+YXd6u3V4r7b7NP7MWDQXbE7q906blCrbi?=
 =?us-ascii?Q?kjOgYyBSr6ngTENScIUFwIJ5mtWg8VJCnRU1WSnFK9ybI3jyUrXfHz9xL0/S?=
 =?us-ascii?Q?zC6OjfeF6qnxIx1bO/9ylzWCVt2plPdhuPTtnoq8AQQN4QCEOBbVinT6eVMc?=
 =?us-ascii?Q?NAya2ii2CYyyWDdnu3H3TUFHiloN43F7YnDyqFeWx76mTVdQsbKHyRXoPsUD?=
 =?us-ascii?Q?RfD689/6vR+D2iifPayBBbEh9Ie++4vz+xkw/84bhO/lSBx2Q3UqouUD55/p?=
 =?us-ascii?Q?m75RwNM/YrUs7gLWDYcCaAMj1KmvATiHzYR/vLw+8p3lZnnTcOtkl5VwjnsT?=
 =?us-ascii?Q?N05CRjYzlrghKBnGrc1/a1lITswmHnbSvDwj0lDPn5vljCGCz27BgG33914u?=
 =?us-ascii?Q?XIMosoBCYIOgocMvHlFhQNfuBx53zAVbGmjohPALM2S/vXclh2ItApIjdbW8?=
 =?us-ascii?Q?mpRJtNUiENYJuW1fFA3LeWnppIGb1jxgK0tKCljdpXweaW03C4cIPt770qO4?=
 =?us-ascii?Q?JvHA7qku8P9goZEyddrISXJNZJzjKZ68rDF+5i5bI0qHvDX01QyWc4vz8/7x?=
 =?us-ascii?Q?tZhIhDUgqwXaqi3SO6BTbJyqllPmkJ81vQlPRXygz2mvCCkynVx++U/klSkl?=
 =?us-ascii?Q?J7ZIiPLT1RLqB8U+IzIHmdrtoFit/UURFKDY2knesnXibhJWYLNiNXDI9tCM?=
 =?us-ascii?Q?EgYMTeDzMQug/ZHYYjd738iK+7YiSLDyDLLRCS9R38kpt7E4h9eOZpV1z3Rh?=
 =?us-ascii?Q?9N0BljKa5/0r9mp1cJkHpzzB2fgRglSX6YrJa40567TEUe0Oi0oHedXqb2Ch?=
 =?us-ascii?Q?6ZL9U1F/rMVyF+ueNE0RLSnNmW9BSZo7fXGzHKoRYneZKeyrknEtsJ2ZzPzO?=
 =?us-ascii?Q?mPEZXJpIkUPjp4z8rChGdOlY/NauqcezLGDRC6n83omGOFGo1Y0wJPprmyHN?=
 =?us-ascii?Q?7AOBPYuTt9l+IcB2VecyRAoezPLqxHrvTeXK7DAlA36ukDATjUWvl9xyfylx?=
 =?us-ascii?Q?mNyyFaZh1b+2T5Z06NvGvowb0/YuA6ZWxPw8YL979Qg2HdsSj233lKCdIPYA?=
 =?us-ascii?Q?r3b7wfPobELo6/AQLUsS6EeuQfWZtvT8mudn2g+/iOI4/oUu5rM8mA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9bhvD9+L4GzHX2XGdRqzZWRGHrk6uHOVFpBOz1RggPBfNK+b3YdkMW4suCz7?=
 =?us-ascii?Q?zCCJ4arbgFSWLdrqCBtnhcclVhz63Qp/bilj+wqpItCG+Lep684FKY8If0yY?=
 =?us-ascii?Q?k2gVgXXU2E2fJXFNI1oW/8Z6p5LykemW0Wyr7QeGij3pqQKx0G4SNMYhpVJJ?=
 =?us-ascii?Q?0E4k1nakFDsHkMNbgs2OWHSTK7JJGW9faNus1ICNmdRUOifh6Bc/HZ2ORWyO?=
 =?us-ascii?Q?4Leswm6+PR0fdaYk/cC73sF95UkchBw77+LgJW11d290ujCBAsXEsc6ycouD?=
 =?us-ascii?Q?zMP23VWVKvPerASd4+gO3dv4qG35Nu3/ponaZg1uxxAWjoWl3TvBabePJlgP?=
 =?us-ascii?Q?YhPSp1Mk3jHqPWOVPWppaW4sIbvxAiG4yaj9FNfNmftlhxVRnVS0yGjR9NfP?=
 =?us-ascii?Q?gJMV5O4i0L6GrnTJMn3XghCcrJgeUyUv2e8CrdYnyTe7IVPpwg2YLkjDkSEh?=
 =?us-ascii?Q?7IVxOFDT+caQEDTXxLMsmjFTgbo+wqpoMGGken/JTzdAkUQR5Fwab0yiBXJT?=
 =?us-ascii?Q?tiy5R1yQU6Y1j6GFFKYXJCyY9b3qzjs+waJjv+imQEmoxbCn8BWovpDaNsaU?=
 =?us-ascii?Q?OgBSNfsf4uBb2wR77y9bMycuJWQ69Thi2GGj8PioyKKEN9BFzrWYyu+T2woa?=
 =?us-ascii?Q?27zJFXM5NIalRDPTH4P++U/AbLgz+xs7/gSEWNMjx7P3AiC3V31GJXxBBumU?=
 =?us-ascii?Q?L8dHfgyNrxA4uXT2PQBqAeLUCXRuJWJEZtucSZtPSzgo24GxoN5VHpcx0rDv?=
 =?us-ascii?Q?uDLM21gGoQ1k0FYbzXQetqKNQzLmo8wd5OCZGTfVFOeOP3blhWmQ0rclNGw2?=
 =?us-ascii?Q?n+xiqe/rMk4dQ4Ywn/hAYpjuP5I+8R57tUrLu6rs5cUn5JiWAQri8xe3Da5B?=
 =?us-ascii?Q?EUXa9VdNaOjGrieIhLrH0RRcKpe8aEmOFXLMui4RmTA4ekeTXnqFTWyIU0dz?=
 =?us-ascii?Q?DbcdqvYYqNYvyQAMcH08OXYK/nYHJs/q71KsXjq62t1F/eFvuK6b1/Fh0unZ?=
 =?us-ascii?Q?ZaJjDmMnIsbmCBzdyu5pcc50a0BjgXoTlMCP3sCD+PonWPW9xES3A/YWMD5f?=
 =?us-ascii?Q?N90CfbEaaAu25Kt4wuFeWaDIzSAPfU4ii7bWYavaTrK6yiBiAPa0yFN+Dx9g?=
 =?us-ascii?Q?z29lkclsLoHnI3i9kvOmIgsQD14/33RR5VraWMewJH1Q8NXItT73CjzjcUbf?=
 =?us-ascii?Q?LBJnfLtkVv6hYOUEXViyIV+ZzdYxyupntylYgW2Jm7WFQp6KjFCpOwaca/28?=
 =?us-ascii?Q?g2EaVvEaNy9GOE9UjrVuTOoTC0o5wJJypxRnyKZyhzeCfWRHyvjP1rUtuu+d?=
 =?us-ascii?Q?R5RyRAsswIEVjaABkWFBlcpxFJ7KdpUDBq/sQgC2aLG145EW2YpcqFBI/fa8?=
 =?us-ascii?Q?ZTKie0ooCWzqtrnA4bOtjzxV+tRjs0N7TchZmD6yyxQ/gbll1w/hNS5X0gCv?=
 =?us-ascii?Q?WbRTeb5wxnbQKsZf7A7q6dVIFDMPxzEGJFTctCcf/5n3yyHLH7h0CzQFyQG8?=
 =?us-ascii?Q?3tPti/FR+m3EmPArBhkF9L3rzD8C/iDuWBCKfOperqADXyVom4K3/rHLH085?=
 =?us-ascii?Q?gY6SyKgmJUvLzkQYD0u+L5MEvD5wyaXGSOn4VP/q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb81e3e-ddbd-46cd-b704-08dda7c6406b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 02:26:48.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYLmN9l7pbo+IiHYBrkvZ+WdqpoNCcCqcEc4LzHMV5akdZikuzMsoa1u0LPJLMC3E3nyL4b/AMymIRUkQV5cLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:
> Replace open-coded folio reference count calculations with the
> folio_expected_ref_count() helper to improve code maintainability
> and reduce duplication.

I wonder if there is any opportunity for reducing duplication more broadly?
The migration code has similar helpers (folio_expected_refs) as does
khugepaged (is_refcount_suitable) and vmscan (is_page_cache_freeable).
do_huge_pmd_wp_page() also has an open-coded version of these checks and there
are probably others around the place to.

These could all be converted to a helper that returns all the "extra" references
after taking into account things like mapping, swapcache, etc. depending on folio.

> No functional changes intended.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  kernel/events/uprobes.c | 5 +++--
>  mm/memfd.c              | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4c965ba77f9f..c978c8c27340 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -434,10 +434,11 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
>  	/*
>  	 * When unregistering, we may only zap a PTE if uffd is disabled and
>  	 * there are no unexpected folio references ...
> +	 * Expected refs: mappings + swapcache.
> +	 * We hold one additional reference (+1).
>  	 */
>  	if (is_register || userfaultfd_missing(vma) ||
> -	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
> -	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
> +	    (folio_ref_count(folio) != folio_expected_ref_count(folio) + 1))
>  		goto remap;
>  
>  	/*
> diff --git a/mm/memfd.c b/mm/memfd.c
> index ab367e61553d..4ed5506221b7 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -32,8 +32,8 @@
>  
>  static bool memfd_folio_has_extra_refs(struct folio *folio)
>  {
> -	return folio_ref_count(folio) - folio_mapcount(folio) !=
> -	       folio_nr_pages(folio);
> +	/* Expected refs: pagecache + mappings */
> +	return folio_ref_count(folio) != folio_expected_ref_count(folio);
>  }
>  
>  static void memfd_tag_pins(struct xa_state *xas)
> -- 
> 2.43.0
> 
> 

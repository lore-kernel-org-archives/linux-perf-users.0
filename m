Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFFEE49AB
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHWHkp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjHWHkn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 03:40:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D7CDD
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692776442; x=1724312442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o8AP8q/QZPHrROoeicEnfQZvRVUDBX1lw6xJkt6dsu4=;
  b=dYDFZxmMNXinD9qYIlCLMIm4ZBC9yQ+hfk0I1busxbesTrWbJNluGmsJ
   JLBkqVoozigaB1s5SQHWFcX4aqVd+0TI8Q7Kr8sv0nlhc7YXYXeHKp9km
   8DDuDxkVNmHzRekel21ZKxyRhLSkLajiIRUPnkYBcIURNu5ho2KPHYH0W
   /HhUU9uXT3FRAfO5Yzu8yLWaYcORd1GMqWFJ8JlS7wHUAyY/9m4xMqomV
   yhDGhOzCGOp32i8lyrZIn9rBfL2KrcM3pLE1wGl9lSFj4hsBmlxIVPg4E
   Pxc7ItsmjAD4yiQ9LxZGZkwKaSD8bykH7MySQFVuNW9nMRADABqhPIzlW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="405095332"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405095332"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="686342247"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686342247"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2023 00:40:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 00:40:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 00:40:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 00:40:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 00:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4JXK1LQGAZ6JSaE7XIQx1dmDgPfCyr/OdfMOFA6yB4LJq5QvawMrTHaqfbRIfn1Qq8SGZGwpz2z5Sc5CEWGZx8Se5FX/RO3qQ4mw6j2nmSNd0l5yQRi+SqkQzT9NsySPNccDnF4AeWrmGoqe3X0Uf0YQ/boLGJinZK3WgHiaqX+Lg2kpt1zBbovBuLT9Xn2i0/D9iygD6C2FxWvt+xinfw6TifPIvVZg6Y26oZ0gY4IejQQmO5gTJMJFAzWhG0mSoTXPQFQj6r9I7Jo4yUla1nvrsztyNDexLCg0uEViePLzvv3zUy2fZ0KTiHUMir2P3lNTETcwKWw3bsZn4YdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnvNKF7WkMBVKnemDTENHcPQwE6DMXAKUQ82lZhnd7o=;
 b=ADGTn7aXkVqsAJ2oI1vyMmtxcGGAaiSqICVB/OB9uFwjGD4vLXJEsahALWLjld6ZgkSo/1dojFeOrvgVYuyjs+omCoKyg2prTxJuqMzdNjbgxOHykdEkPQ6P+lw2rlhQUVVettpfPaezf7jUCP9fo2XAwyxymf+Idg+AKLCKsKMqM2J0wnJPQko411smBZWdmzw/811SVWtNKjCBPI1LnglAJtePhP5oYJPlI7n0WJ1vkCv5ej12Avhyh5i/rNKQnsz8w511yfLc490FIqsM/uSdOQodXzN69cB0WbQV3L5iD0Z6aaGGkVNz1ByE9oNV/hPNSuTQtd9Rq9B+JyQs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Wed, 23 Aug
 2023 07:40:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 07:40:38 +0000
Message-ID: <05db7f07-2ac2-f4d5-54ea-b5f1633e8c0c@intel.com>
Date:   Wed, 23 Aug 2023 15:38:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 4/4] perf: Use folios for the aux ringbuffer &
 pagefault path
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <urezki@gmail.com>,
        <hch@infradead.org>, <lstoakes@gmail.com>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-5-willy@infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230821202016.2910321-5-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ddf504-17e1-4b67-c142-08dba3ac3e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydOeh5yLXqtl7SzaM6rNFGyaaYoa97DA31Pik6b73aAtW7tdmuVGGGKouGGwzDA4BM270OciBOsXKP0ETAWTwvBTI6CDKbOykfqZ88Bt+kFn2cqJEWr9/GleYfnR3XWLyH8pFSvK9qiM/l1R10LZMtAzq+5x/iI+4otKWHTcuPCJTB206oA9KTzNjvLKTJJupuktrMCBf3aaG/x33/WGAt7RzKqH1HK6lcCd1pwi7Chx8+XjUve4XDnWSF0RGXCwGzqZxkAHbl7/Im2Jh3jYePZm/eOWwUiRl/SheWaPmRcEewaykxjRwgpMkB32/yJDbCtX5g0yIcQLAxtRCcBQtJ3leRMRKOFYo+3Srbk0r0drO9wQKLQkrsIXVl+sY3EVzxwZ49jQe9OSsqYNidWONYpXqdoXdnpkdY0mowlzQF+88kmckSAtwUNvOlQTP8R9rXkoMV3IxToODvjmBAhwiqPUuwdr+3WcHGzmAVSeJ+dfK7wmOdWRkJ9a+VnUZxnl3CBQ2t+1DtfVJIvrCn9JRfgz9bK15DjyIB/IF+Ga+ViE2j+yR5j6zwjzod4hi6faaDtYAbqOpXqSgiuZeuIB4OWw3TCZzEtk/2YrgG9Ky93hDVYDXJHXT4k9NC1SgzKKnXodnQnnU+Vg0kccm5tq+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6666004)(53546011)(6512007)(2616005)(6506007)(6486002)(5660300002)(66556008)(41300700001)(66946007)(316002)(66476007)(31686004)(8936002)(4326008)(8676002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGxmM1h1cWtyNFdJZU1nS3M2TDExaWlFUlZIekpEZjhoaEFCWFRla2UvMUwx?=
 =?utf-8?B?eVJiZjBVWFhRTEJUaVlWeXF4T0lpcWhsdHVDVUpBU05NMUlIUXhndFM5NDNs?=
 =?utf-8?B?Ly8yMG1jN1Rwc0tNSFFydFc1QmJ2cUFvNTRRNVd2UkJXVUdEdWY3K0t5NXI0?=
 =?utf-8?B?b3hDR3h3QUpYM3lpTUNxOUcvSlluampKRUMzWmUyNktuOGd4eTNCRyt0Y1Bp?=
 =?utf-8?B?TnBpM0FZdTYxZEpaLzgzR0tkcHgxSHQzN09PcG1nZ3RkV2NUYTNLYXBWZ252?=
 =?utf-8?B?bWZHLzVnRmRzYzNwOXQ3NzdEdmp4cTFYQVhHZVF4SUVnT1B3SG90UmdRY21q?=
 =?utf-8?B?dlJVa0NLOGM3R2J1bXZTeXRkYUYwWkhjUUEzZmVNRlppcWhuODF6eEhESXZp?=
 =?utf-8?B?QmFTMzFhMURPenhvNUE2T2praXlreW5XbjVvUEo2c1FVUFViME5zRFE1dEd5?=
 =?utf-8?B?R2lJeDVQNkJwT084QmJia1I0MGtHZ3ZxL2tNcTlRd21iR0pVUnFKbDRHbDls?=
 =?utf-8?B?S2Y1ck5tTktWWUVMMHY1VlVBNkp6TnRvSFdOM2NTWDlTOHd4UmM5QURZUDRi?=
 =?utf-8?B?S3FqZUROMEU0akJ0dGI0d0dOS3Yyam1yRTBDQWxwbFdSTDNiMlNEaU5yNVRa?=
 =?utf-8?B?dVQ3S2pVRUYyZ2ZPbWRFKytMV1Q1cHlRRDk3OTBZTk1uTTM4aHNUMkZVZEo1?=
 =?utf-8?B?R0svQkE0anRjeGNHRCtHWFkwYTgyQUE1U2k1ZVVld1RiQTQyMnVLS0Q0RUFy?=
 =?utf-8?B?Y2ZLVEJoR003Mkxud0NqRkVFVlVqbXJjNWpIU2Q2bTBKRjdVWTJNd2pBRjlF?=
 =?utf-8?B?WEE2dFVzb1QxWEFsZnFUQnk0ZDFvaVV1V2FEd2tRWWlkMGVUL0J1dGpZaUFC?=
 =?utf-8?B?bGNVY2NXcU5uR0FiRXd3d0QwTy9XZEQvMGJMS3RTblo0cGthNkxtTVJuRHFG?=
 =?utf-8?B?Rkp4ZUk5NldZNWgxUzFDcXJVOVV6MWd2K0xrQUluZHBMcU01RE91c09QaWZZ?=
 =?utf-8?B?N0pyN045YUk1ejNoZnhhWW5IMEZnOGo5RVJLRkRuS3FSbG5Sb0xSL3JvNDU1?=
 =?utf-8?B?c1RER3VXTEtxRnE5clR2SDRpclRrMCt1UW4vZUh1K0I2blhPcHRhb1g0ZVdV?=
 =?utf-8?B?aGxnaG9yQmRwYmRPWklML0ROWTJya3JGYTRpOTRWU2xjS2RTdXhFMy9TQlBv?=
 =?utf-8?B?MU5UUGQ4WExScTdsbVVzczQ5SFQ1Vi9lQzNiT042bmx1QTZDTitmUkQ1NE1r?=
 =?utf-8?B?blFsS1dYcEV2aEZwekNES0Zzb3UyVVlwY3hhVHVJRmd5c1lJNXBvYzdHb1FU?=
 =?utf-8?B?NTA3OUtoZzdUaDl5bW9SdUVmTmtMVXNDTUtTYWtDR3VYbXlCa0FtN25UbUtP?=
 =?utf-8?B?WW16eG9DOGVxWkhVMWFSZXVvZndEa21KbGVaOHBzNlloOHg4R0YrczhDZnpw?=
 =?utf-8?B?ZTBnWXFBc1FmY3FKSkFhV2JnTllST0ptbTN2NkxTVk92U1lrZk84aFhNNFFl?=
 =?utf-8?B?ZmJMM2d1MG5XTkxPSm5HM1hIQVF0ZXJ2S3QwMEZnMGpKVnFHdVl5c3k1SXJ0?=
 =?utf-8?B?RDF4NVF0WDhLMWlxMnFnWSt0MnVtbjNTd1gyL0lVb3hSeURjYkZ6SndGcmZY?=
 =?utf-8?B?VE9icnBPSW5vT3ZsM1dQcEdDdlE3VmdBSzFXRnNtS1BENzdMblgwL1JWbWJR?=
 =?utf-8?B?TVBGeGVpQ0FwOUI2ZTlsRWt1UXAxZllBL0ludlpBUVRBNEptSFdyeTlqUHU4?=
 =?utf-8?B?STZETStWQUd1MVZDRTVsM1pQQnNCL1hvcnp4UEhDbk8wbUxCaEVwS3YzdUtD?=
 =?utf-8?B?dG81K2h3VFdiNWczY2VnemJ3cmhuZFBxNU1pWXBPRldkakFRRlc3NExBNzg1?=
 =?utf-8?B?akdJSlJyMzQ3TExoNkwxZTZMWkFHT0NqS24zTzlDVnhVSkRGL1dpZWZNWURR?=
 =?utf-8?B?UUdlbzFweWFkUmNPSTMvRmtwb2FTMC9yakg0UlBvQTNWbEEveHhDdWZDWUFO?=
 =?utf-8?B?Q2ZXL1JwUldYQXF6KzZqVEgrcytuakxReFYvdXFMUXAzK3BZRzA2OG1SUUVG?=
 =?utf-8?B?M2lNajBteEVPU2RqbW1FRlhRdm1qaFJWdjlvR0ZZWFlBdUs2a3FBTzNjQlNO?=
 =?utf-8?Q?CXXn3qw/XL2eD8VF1Kz4F2PZj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ddf504-17e1-4b67-c142-08dba3ac3e4d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:40:38.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nlsiN0eANNmpJzoJwtdGBVuXvdSSFpQXyvxSfF9Wdbi30C7cvlMKOLuKtpS7Cq4cf9KI6v8bEhdv8yQkfJXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/22/23 04:20, Matthew Wilcox (Oracle) wrote:
> Instead of allocating a non-compound page and splitting it, allocate
> a folio and make its refcount the count of the number of pages in it.
> That way, when we free each page in the folio, we'll only actually free
> it when the last page in the folio is freed.  Keeping the memory intact
> is better for the MM system than allocating it and splitting it.
> 
> Now, instead of setting each page->mapping, we only set folio->mapping
> which is better for our cacheline usage, as well as helping towards the
> goal of eliminating page->mapping.  We remove the setting of page->index;
> I do not believe this is needed.  And we return with the folio locked,
> which the fault handler should have been doing all along.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  kernel/events/core.c        | 13 +++++++---
>  kernel/events/ring_buffer.c | 51 ++++++++++++++++---------------------
>  2 files changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4c72a41f11af..59d4f7c48c8c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -29,6 +29,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/hardirq.h>
>  #include <linux/hugetlb.h>
> +#include <linux/pagemap.h>
>  #include <linux/rculist.h>
>  #include <linux/uaccess.h>
>  #include <linux/syscalls.h>
> @@ -6083,6 +6084,7 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
>  {
>  	struct perf_event *event = vmf->vma->vm_file->private_data;
>  	struct perf_buffer *rb;
> +	struct folio *folio;
>  	vm_fault_t ret = VM_FAULT_SIGBUS;
>  
>  	if (vmf->flags & FAULT_FLAG_MKWRITE) {
> @@ -6102,12 +6104,15 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
>  	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
>  	if (!vmf->page)
>  		goto unlock;
> +	folio = page_folio(vmf->page);
>  
> -	get_page(vmf->page);
> -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> -	vmf->page->index   = vmf->pgoff;
> +	folio_get(folio);
> +	rcu_read_unlock();
> +	folio_lock(folio);
> +	if (!folio->mapping)
> +		folio->mapping = vmf->vma->vm_file->f_mapping;
>  
> -	ret = 0;
> +	return VM_FAULT_LOCKED;
In __do_fault():

        if (unlikely(!(ret & VM_FAULT_LOCKED)))                                 
                lock_page(vmf->page);                                           
        else                                                                    
                VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page); 

As we lock folio, not sure whether !PageLocked(vmf->page) can be true
here. My understanding is yes if vmf->pgoff belongs to tail pages. Did
I can miss something here?


Regards
Yin, Fengwei

>  unlock:
>  	rcu_read_unlock();
>  
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 56939dc3bf33..0a026e5ff4f5 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -606,39 +606,28 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
>  
>  #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
>  
> -static struct page *rb_alloc_aux_page(int node, int order)
> +static struct folio *rb_alloc_aux_folio(int node, int order)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  
>  	if (order > MAX_ORDER)
>  		order = MAX_ORDER;
>  
>  	do {
> -		page = alloc_pages_node(node, PERF_AUX_GFP, order);
> -	} while (!page && order--);
> -
> -	if (page && order) {
> -		/*
> -		 * Communicate the allocation size to the driver:
> -		 * if we managed to secure a high-order allocation,
> -		 * set its first page's private to this order;
> -		 * !PagePrivate(page) means it's just a normal page.
> -		 */
> -		split_page(page, order);
> -		SetPagePrivate(page);
> -		set_page_private(page, order);
> -	}
> +		folio = __folio_alloc_node(PERF_AUX_GFP, order, node);
> +	} while (!folio && order--);
>  
> -	return page;
> +	if (order)
> +		folio_ref_add(folio, (1 << order) - 1);
> +	return folio;
>  }
>  
>  static void rb_free_aux_page(struct perf_buffer *rb, int idx)
>  {
> -	struct page *page = virt_to_page(rb->aux_pages[idx]);
> +	struct folio *folio = virt_to_folio(rb->aux_pages[idx]);
>  
> -	ClearPagePrivate(page);
> -	page->mapping = NULL;
> -	__free_page(page);
> +	folio->mapping = NULL;
> +	folio_put(folio);
>  }
>  
>  static void __rb_free_aux(struct perf_buffer *rb)
> @@ -672,7 +661,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  		 pgoff_t pgoff, int nr_pages, long watermark, int flags)
>  {
>  	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
> -	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
> +	int node = (event->cpu == -1) ? numa_mem_id() : cpu_to_node(event->cpu);
>  	int ret = -ENOMEM, max_order;
>  
>  	if (!has_aux(event))
> @@ -707,17 +696,21 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  
>  	rb->free_aux = event->pmu->free_aux;
>  	for (rb->aux_nr_pages = 0; rb->aux_nr_pages < nr_pages;) {
> -		struct page *page;
> -		int last, order;
> +		struct folio *folio;
> +		unsigned int i, nr, order;
> +		void *addr;
>  
>  		order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
> -		page = rb_alloc_aux_page(node, order);
> -		if (!page)
> +		folio = rb_alloc_aux_folio(node, order);
> +		if (!folio)
>  			goto out;
> +		addr = folio_address(folio);
> +		nr = folio_nr_pages(folio);
>  
> -		for (last = rb->aux_nr_pages + (1 << page_private(page));
> -		     last > rb->aux_nr_pages; rb->aux_nr_pages++)
> -			rb->aux_pages[rb->aux_nr_pages] = page_address(page++);
> +		for (i = 0; i < nr; i++) {
> +			rb->aux_pages[rb->aux_nr_pages++] = addr;
> +			addr += PAGE_SIZE;
> +		}
>  	}
>  
>  	/*

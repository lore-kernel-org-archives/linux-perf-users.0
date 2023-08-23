Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2BCEE49AB
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 07:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjHWHbi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjHWHbh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 03:31:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9205DE50
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692775890; x=1724311890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SkZnXfr9Wdt6nuWrspTepXLIOeKnI2LFcfXCCAJHg0E=;
  b=IWqqWpr/D6VaZK2KkIMbNyhhM4I4Qs9W9e8d+jWOz05tfEAMNHylazad
   n3hh5EBSQbswwqxdlsBEkM/pLCeuB7WkSDimHPcF2LcDFYlO9T1kfOyqN
   Zs5NVdvL7GyPvVMLGI6rvcZ6sOJuOJCh/3q+mdSThZNp3KEFiOslzAvzn
   VzU/qpOhsZaC3lg+/4skj00g1cwUwviN7bg4kL1ZvOwEo2Yit1MTDqiz6
   fQfAvA/GXApAepV69v6W+G9jpGCx3SS2ikBv5cAP5iqXZSrec1AQvyjIs
   wHjLm4c4al3HhRg8nn5/Sc96b2RYu185+6Jxa2A8U469TjRIOHHEwuru3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="359076963"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359076963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880302503"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2023 00:31:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 00:31:19 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 00:31:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 00:31:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 00:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il0+AENr6jmpK4FWzbG8sawIQ6jEE8/cxa8P2YPbXDsIBHbuUfBrU9hVcNSWBOOQNCkyuRN05z1yaPWOhB6wiuJ1ZldmTVn+94OO6HNEchGfrrdOfOV3KvJEUyAEG2JXOLHHqzoM3uFYo367A6daV9wqNFjiFfUMPJCPCIC/N+HREGR8kAZEWHlB2K8JHXKNaKA4A+6lzqrFPFvSYHc/rEp/Q8bsXbKs769trY2SaKFgIuGndFiU9RibKxsVyHmcQTgHGJRdSO3zRHdGPDUMLQPpqFCBhDpODcSHUCChh1ifK5Zdc6wUP52mZZVoy0RSh2ZF8gM65F38Xl9jYskSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgeW9msq6GhHjkp7BvFhdIIcaZjx/1RzDXT9CV4pTm4=;
 b=f1mRpEMZwVE3yLfTP2QzKa+GcCTLl4UWV8IVZMVsDMoRwpLCcmzsHjyubEBiEbdXN/nk4lKianbse9m+7epjGOM30+cliunU58jt47BSqKPAoYEhspjhE35UrLVWak+nkt45Z7FF7XAd0MeKgok1I9eUqQVgJY019jQGJDjRJKggRxw0QQN5IrMPK5U5jCKxrCKnF8+bYPSywTslE82QkxAwTzSYryeR96w35hdrqR+ETRu0EjFXQ+eS4li3VTfXO051lARdOoah0OE6mXvUWedL/1IDI+Xk2JI0dPKqq0gWhCvrkw75ab71HCKCuHz8YQJ9Ho5fiiminB7iCiJUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:31:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 07:31:16 +0000
Message-ID: <b256724e-c4be-9e01-2485-80791f82eacb@intel.com>
Date:   Wed, 23 Aug 2023 15:28:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/4] perf: Convert perf_mmap_(alloc,free)_page to
 folios
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <urezki@gmail.com>,
        <hch@infradead.org>, <lstoakes@gmail.com>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-2-willy@infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230821202016.2910321-2-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::23) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe6968c-a554-4373-4fc9-08dba3aaef44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V90EIbql47WcUuwW7Kg2J6/iFZneuhDu5dOwYy4moDiCjYmAEmNuFHQ74P2fpe58LsXXTiFf8gvdMbfdeOihv9zWidhBy8DBGC7VUIG9qqJ7hLY5TwbFAlkfz6gKvk+WU4m8BeexUf8czPX7MlwVtSF8Hk0gckGU+GwLbclhY0vXzozo1c+nvrGrzXvSoFv0Nbvw2kZaF8Q8Rd4vCNQSRDQtwQV9ulD5OqscndjxZQ6ObqMVuD5yxF7wuHYYPNkLSS43aepuanh8nCppuIqsd1TbAET0Lo/eCoVvEOi6EvnDUApAEOovjQ+I/81xch0eS3rd4RGr57bcdRESC0xBXmj85m35VpjJ/y/g1Uf3qxa57WVbFGK/AEiG8Z8rnEhvaxjNfEK5y/OcVxXvm5Ria7nEzurKZwfXXRVDeuwvbEqjOxCHf1SKscI5PEB7VMxScuFe89MYSJeGPWs8ydFiTW2tbaKGxJAve/OHg+86M/Nzw5ojX2HnLvsBy7qGRw5bluRzIewJsSa8HZ3tnnB+nF2zGQVRE6p8cC9yH0Kke7EGJK0MEm9smlzUc5vQSMkL1aotX46Val7k+c9u0hCnPCYCtoH1oSfUKzU7oOvy3B7SI6qQCtsMhxyXePGNjIsQdq1k+09IDhjlCcvW8fxO4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(31686004)(478600001)(6666004)(6486002)(83380400001)(38100700002)(36756003)(2906002)(26005)(53546011)(6506007)(2616005)(6512007)(31696002)(4326008)(82960400001)(41300700001)(316002)(66946007)(5660300002)(66556008)(8936002)(8676002)(86362001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVnTnl5SnI3Z2xXMHVtM1BJUlhLcHdlTVdOUXZYUVNHb1c4QVFvV3QyVWxq?=
 =?utf-8?B?b1d1VUtFcTZRRTRYSkxPTytsVWk5Nm9hYWswNEE5QnJNamNMMjRRZkwyZzFq?=
 =?utf-8?B?TzJyYWFqRWxFdkhDNEdOdUU5eXRUVUxKRTdyT0xMSlBlKzAyT3B1Wk11RElu?=
 =?utf-8?B?WWRhUVF4UXFjYU5NNTIyZWNrUHNabFM4NDNoajM5bHZoNThZZkNSZmEyc1dn?=
 =?utf-8?B?S3NKYWYyV0wrdUxpb041VG1UbS9wWHVHalZVVFpSdTJNZVo3M092NkVsOGox?=
 =?utf-8?B?NWdXY0VRTi9uMjZKclJWTGV0TnpUSXpyM0VzYmZUd3BuMVNXZzJiVkhGRkVl?=
 =?utf-8?B?UTFwdWpxMFB5YzUrWVU0dFJxWThucDFucXFZYVBMK3lkRitjUzBZR1lORU5z?=
 =?utf-8?B?elJIMlNmaWFaVG16RSt2aHNnYnBnbVlsTWl3Z3FtcjhBVVVERmF4eWdRMm5M?=
 =?utf-8?B?ZytZbzVOQWp5M0FmbWpiYzdHZmJKZVV4RFZDdnJ1NnBXV0t2VVA4d2s4dllS?=
 =?utf-8?B?SFUzTHdrMlJQVWY0bERoc2wwY2xsVWswRFhJcXpHTlBzRUhseHlaeEdMTkFY?=
 =?utf-8?B?OFdLMHNuSWJ6ei9qV1pLNUFqTXJHckNxQmVzbE5qdVJQL2xQOGJaWmNWL2hB?=
 =?utf-8?B?Z2s1V1NMV1B4YUxSZmpKV0FZdWlxS3F4REtua1RNZXh5MjVEbVk0d1gzdHNH?=
 =?utf-8?B?Ny9mc242UHVWZk5zaWNKcUp6dUlxUTh1WkNBMEp6T0x3QlFrNG1zY2pZYTFZ?=
 =?utf-8?B?U1BrbzBtMUdSMWZnQ0dsUTErTFJpVFNITHZPbERxNHk1NHVVU1h4b04zZU05?=
 =?utf-8?B?MUIvdGw0UGZOcWlreDl1bXR1aGxKd0txSmF2Y2x0dmU2Z0x4Z0l6REdEK0ds?=
 =?utf-8?B?QnQwbXlYN092d1ZDYlZ4cDlMZWNxS3FzUUdONlRpZFBtQ2VmSHdhOFdodGxl?=
 =?utf-8?B?SGpRWnkzUlI5eXJOeEY5dHl1REZvMXRFUXRTeU5jazB0NzVrWmYvM1JuZS9E?=
 =?utf-8?B?MTBKaWxudnZUOXE0azJ3cDhHOVhTK1FhZlRsaVVvK1g2NHArUG1wSDRxVi9s?=
 =?utf-8?B?dFdrbEt4VDE3Z0M3RldySnFHcSs2a2FoTWlLOEJFWTJiVlZYZGdteUN2REVr?=
 =?utf-8?B?aXlwMC9JOUFDU0sxN0lpZm8reEdCRkw0TWM5L3I5NUhTNHpZVm04a0owRHFr?=
 =?utf-8?B?U2F2Z0h3MVFpYkhFdGJ1eW9RNGdwTXcxTEhwbkVxeU1IdnZDSmoyV2JaSEdL?=
 =?utf-8?B?dXZSYzVnWmZsZVg4ZEQ0RGk2aUVyVlBheklVdjltWDF1WnN4MTZYRGQ0d2l5?=
 =?utf-8?B?TFE2S2g0Rld5ZGwvK2xCeTI4TEFXc0FJeHVCNU8zczNvdjAwTEV4UEdINmYx?=
 =?utf-8?B?bldPNHBIU0JmdGVqNm9rbjhMNHlGcXdCK3kwUDJpUU0xSXhpY1ZKQit4ZlhN?=
 =?utf-8?B?a0xFSmRRUGVscVdQMlp6K2svOUpWVnBpa0Z1eGhsYU5nVEJqaGhGVjNXV2Jx?=
 =?utf-8?B?K1I3OGd1TTBrZTZuRmVVcGozaDk4bkx3ejdWbDlvMFh3UnlpRkx2V2xFeWxs?=
 =?utf-8?B?OWFKUnNvaytla0ZjNWZVSzhEbnpjRktURW9IRHBtcEtBWkh3OFhCUUt2UmVy?=
 =?utf-8?B?d0FhNEltaFEwUCt5UWQ0aTlOQzZyakt4TGk4dGw0ZmwwTEY4WTJEc1NxdVYy?=
 =?utf-8?B?Q2lvNTNOeVNUTlBUbmZJMW9MR2hWQlpkU250S01EbzVSenlMNTRUNElOTUgw?=
 =?utf-8?B?RUxQTjZ2WWhscUkxWWRCOXBxREY5K2lHaDlsL1A5ZmpWUE8vRVVNYm84SVFQ?=
 =?utf-8?B?b1dvQWtqb3U4ZEdHWmVMVHZOUDFIS3pTWmsxQ25rUXdhVEw5d1lxeGxZaGk4?=
 =?utf-8?B?UTZZNlcrQlZiQklyQ0VZQkFycjhmajllWlprNTBYUWVTbFd5ZVZoY2hoanZp?=
 =?utf-8?B?aXRQLzFUWWV4V2dyVEU1aWF4ZnRvbTRZUVF3RTRLU3J2SnhQRzdGVlpkOWtn?=
 =?utf-8?B?TmNGOUMxbVpRK0tFUEVKRU4xWkpLS09HcW4zSUxuNm42SndpbnRjL2xXcEk0?=
 =?utf-8?B?ckQ3UUIvblhhQk1LcGUvd3REWFY4VDBvek9CTHZLZWhwbHg1cUE0Ykd5bEkv?=
 =?utf-8?Q?YfXznyAtlX5ySGvUSXUJDBaXm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe6968c-a554-4373-4fc9-08dba3aaef44
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:31:16.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCzZNDrmRhcxarVz8jKJ02dVzfu4QrNqJygrY9ZS1XrjzAUtiol7tkJMhDAMgOqPpIFZkYVkF+g4668/u7yA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/22/23 04:20, Matthew Wilcox (Oracle) wrote:
> Use the folio API to alloc & free memory.  Also pass in the node ID
> instead of the CPU ID since we already did that calculation in the
> caller.  And call numa_mem_id() instead of leaving the node ID as
> -1 and having the MM call numa_mem_id() each time.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

Regards
Yin, Fengwei

> ---
>  kernel/events/ring_buffer.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index fb1e180b5f0a..cc90d5299005 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -770,7 +770,7 @@ void rb_free_aux(struct perf_buffer *rb)
>  #ifndef CONFIG_PERF_USE_VMALLOC
>  
>  /*
> - * Back perf_mmap() with regular GFP_KERNEL-0 pages.
> + * Back perf_mmap() with regular GFP_KERNEL pages.
>   */
>  
>  static struct page *
> @@ -785,25 +785,23 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>  	return virt_to_page(rb->data_pages[pgoff - 1]);
>  }
>  
> -static void *perf_mmap_alloc_page(int cpu)
> +static void *perf_mmap_alloc_page(int node)
>  {
> -	struct page *page;
> -	int node;
> +	struct folio *folio;
>  
> -	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> -	page = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
> -	if (!page)
> +	folio = __folio_alloc_node(GFP_KERNEL | __GFP_ZERO, 0, node);
> +	if (!folio)
>  		return NULL;
>  
> -	return page_address(page);
> +	return folio_address(folio);
>  }
>  
>  static void perf_mmap_free_page(void *addr)
>  {
> -	struct page *page = virt_to_page(addr);
> +	struct folio *folio = virt_to_folio(addr);
>  
> -	page->mapping = NULL;
> -	__free_page(page);
> +	folio->mapping = NULL;
> +	folio_put(folio);
>  }
>  
>  struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
> @@ -818,17 +816,17 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>  	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)
>  		goto fail;
>  
> -	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> +	node = (cpu == -1) ? numa_mem_id() : cpu_to_node(cpu);
>  	rb = kzalloc_node(size, GFP_KERNEL, node);
>  	if (!rb)
>  		goto fail;
>  
> -	rb->user_page = perf_mmap_alloc_page(cpu);
> +	rb->user_page = perf_mmap_alloc_page(node);
>  	if (!rb->user_page)
>  		goto fail_user_page;
>  
>  	for (i = 0; i < nr_pages; i++) {
> -		rb->data_pages[i] = perf_mmap_alloc_page(cpu);
> +		rb->data_pages[i] = perf_mmap_alloc_page(node);
>  		if (!rb->data_pages[i])
>  			goto fail_data_pages;
>  	}

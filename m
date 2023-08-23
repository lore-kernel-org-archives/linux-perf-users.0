Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DAEE49AB
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 07:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjHWHc4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 03:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjHWHcz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 03:32:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE1E5F
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692775971; x=1724311971;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mCEtXYo3bix/cRr46qoUmIF7G5OdQFlUhUCkY+XeZt8=;
  b=JFNxnSxZmS985K3+mz6ZRVGkN7DoGCDbuwyBzwVffFkTez+YKV0TJi8s
   vEXYi6p5mrJZpLKeVPyDBHp9tW76LXoYWPRcE+pZy20ZM/3tkgxhETHyi
   0SRue6AdUDqR+5Z4mDplfh0ttj2tpAXrPNVN+iWdzdkV45Ofw2usVUCO6
   6Jlhb3D39iMh2RLALM85RGt9bAea30qrhWXzWO0thCEqNrc2IB3fnAYCD
   fllJ/O++L8AeiztHQpwsYG/Bte5Ve5z4wqprsoDC2ROM0T7+C9REEZm0c
   AqxzRAcvDYuhhp9KFZd7Roi432v/M9OkUcLklcqya5b2TB1vDgzydNZuv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="374067306"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374067306"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="766036080"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="766036080"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2023 00:32:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 00:32:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 00:32:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 00:32:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 00:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEDrgZGE31ncdL2VnaPW36H5UJmHQkMKJsZKOZi3TLGC3KQBr/uhQ8nRncwdTsBdXfXhMAXWijWGjrKfLSYd1miiLnl6EnpA5/khdnk3zVb/mXVQdpU9UK03M28WNHbKz7k7P3DxqjBIREbC87cmUAv8uPBGretTz6ES46fxQq9+Md9D8V4OW2BchcxNnRMBGratox4ei2UdoW9/85yuj7f8eT2Tn3Ui2eyBX88Lx6qJ7upw5uHz4829RGFj43CRSI6EKUEawlAhZco+p5TMXPUg0I0gzIJ74uCQFuG2qiKUQDXeV+F1geyXRub+9pktxOLBN0S0yhZbATqyrVKKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4N6nEmXmDZOMO2iPP38aFGiQRTK/eONjkDij5qXX9Q=;
 b=ACZoMt3hrtXEVaTrFOLiK6lEfpSMMfRHNaV8EpIAsEYQmikH5B2PGiBARPf3s1csLrJTg4eUAV4nV9poyc8sQ3DDCq+28+vlL8tENJXHCH1brfJremaovex3/VVGCAS73WfKzESYAGb4cbNkDl7l/k9Ymos0QaJeuUHBOqGkhBAYqnclhUy2D9VByf6qM+cqgJVaKVROTcq5+eN3JGAq0eFenokCEaFy+KZ5XKM6y1NeeLt/DeCcF0DsZpvpGqY7kwSf2DTuKk6hcInEPRjfBYrGEpSjs6qSuWfTEFrsPCzXhq9K++Jc1UpwDG2rRRQ4tNGm1kDyk2Sr13sCsNpGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 07:32:47 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 07:32:47 +0000
Message-ID: <627a43c1-048b-c6c7-62ab-28dc111a055e@intel.com>
Date:   Wed, 23 Aug 2023 15:30:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 3/4] perf: Use vmalloc_to_folio()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <urezki@gmail.com>,
        <hch@infradead.org>, <lstoakes@gmail.com>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-4-willy@infradead.org>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230821202016.2910321-4-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::35) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: cf88d8df-4403-4f2a-c481-08dba3ab2588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEJM7zuowhYI27PyxFxdC4pd/QH4C/shLZte6W4luSGyNSVduez2pGHq8s3AK5xC2C2FMS+2J9GOkGPL3xWpw8p0v9djiK+k+EWTQkRQhFaIkIPvQ1XfBonixdUwW9eTPC8W7Fp4tAfRBtsxx8BjPeBFWA4w1x16sxd+JEZtmVnaOn/S1JTNzKiIJFa5kGAU3ZVkH7BmTpnYayzRUCzHHxD/4yPm5gm6Pykud+Jo6e44ODAUTLZnuglU0Yt7oJRWLGFEa8EckIDMuDgBFJkrRd5h2FIrwnMUOLBQMxnPrgQVwJWI4XQT1boExurt7mjMRrfeP4MU9vX5Q+0ZEFNuIMDf/bT1YlT69MkTnbnBnWYafdY97sW+/EVaKK4fC5lvwYsrgpTljJJTOvBxP69RTHucEnDvp8hMgxF8LZh8StSiQ5a0V7rIYlEC3Apymf2oE5TvrSqSpmZY++7YSC1j+qrroYBYOqeDpnq39Zp92449xKTRSY3RrvW1etfwvK2rTSUOMXudl1z4YMGAW8XzKIJBG5qSigkJmqQOdS+gPf3kEjCMWr7CDtzl/AiPcNUvZpM2TZdtNE8kpru14Nwetl9LqPD2q7cd3H07o7EmnZ41j+z6PGKhoz4qHNLTaMVTRpZTBmgzNnFfFacVPITeCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(1800799009)(186009)(451199024)(478600001)(6666004)(6486002)(6506007)(6512007)(2616005)(2906002)(26005)(53546011)(5660300002)(66556008)(8936002)(66946007)(41300700001)(316002)(8676002)(86362001)(66476007)(36756003)(82960400001)(31696002)(4326008)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3N1cjhyb2wzcElsN0pYRHoveUhtQm5mT2hUdFdxMGpkT1dseVppZXFORk1U?=
 =?utf-8?B?Wk44cXdNSS85R2VhZlZSanl4WVllM1ZpTCtVZ2kwMitkVm5MZElQS2ZtdW8v?=
 =?utf-8?B?L0t4KzErWnB6N0hicHNDZCtlKy9BRUhMMmFiTm1GR1piM3FLek1qTE8xdjdF?=
 =?utf-8?B?NG52THIzaWZDVlVWZUVST1J5SnZ5VlRsbnlMS0ZiR3V2RkdmYnRkdWQrbHJU?=
 =?utf-8?B?OXBOTi83bDlPWlBPLzhLTTNoYmtlb0t0S1ZBNmpnNU9Bd3B4VER5QlZmVDhq?=
 =?utf-8?B?THZhMWE4VzhWZ3BtMUpZNG9Mdm9iQmpFbXNRSkx5RjAxR1ZpdFpsMjZCQk5m?=
 =?utf-8?B?L0VVOFFLa2EvQ0FYeTRFVHMyK2h4dzFueG1KT0U5M010dnlkblN0N2Z0bTUz?=
 =?utf-8?B?bC9QdlM0cmlVYkhGeUJ2a3FJbzYxMjg4VnBIa3N3Y3RVOUtTNGgzVDJSSFFW?=
 =?utf-8?B?M0NKcEhDVDRFdS9sbEdIZWticVEzRkFvcFB3K3dMOTE3S0tpOERsQ2hNQXdJ?=
 =?utf-8?B?VU1ISzVlSWlyN3lTNXdsSENGRzNOcXNSODNoeFhIT2pYdXZTaGRidXR1SG03?=
 =?utf-8?B?U3A3V3ZZQ0MrRTZXRnlrSTZYS255dXphbkN3Z3Q4N0dVUndtNUZ1SVRMNmlh?=
 =?utf-8?B?dTViUWlpaTN3aTdPK1lEMGVaVzc5UFFQaENXbkpBYXRtSXBOOVRqSkpLRVNz?=
 =?utf-8?B?VFVad2Nna2NQUDFBYUF5cFU2SXZBSnhuVXErQUtlMjQ2TTJTb2N0MnRNQ25X?=
 =?utf-8?B?KzBUSUNwbDYrQWk0alUzaXlPMUhqV0x2VFI1QXcvZ3ROeWpjV292SjZvMTQx?=
 =?utf-8?B?Z0trWFptNkVWN2NIaUpSOTViT0hUWENzRStxR1BMY2JRM3FNWkYzd2lVVHZ3?=
 =?utf-8?B?ZXk0OWhkL3RHUytwbmgyVlh0ZWExZG5vMXgvZ3dQMmFORFY4WUtjM21IZ3RW?=
 =?utf-8?B?elQvckVSVEhpdis4ZXZBeGQxdFVPaHRlTWFyWTRYL29MRGlBSEQ5ZTBEQjRT?=
 =?utf-8?B?eW9NMm0wRU5ubC9GNGk1YnpWaUxPcTRyTUJ6WEhUdTBwV0w4WXVXSUZEaFhL?=
 =?utf-8?B?SEFFM1hkUFpndkFwNm9jcTJoT2pUNmtpZmYrRXV1N1ZtS1hiWnd4QUFDcWVZ?=
 =?utf-8?B?cjdzd2xwaDJhYk95Q3VGZ0N3YnY0dWY5cklWWmttVFVtcE9LZ2UrQVBZVnpL?=
 =?utf-8?B?L2p0NzR0ek0vQ1VTMWRKTGRUOXFBdE9JRXVrUnp2d1p6TWdMMkdOWXhnNnFQ?=
 =?utf-8?B?d2dMc3IwNDRpQUlSVzRKMjc5RE5JRnltQ0RZclRNT2Z5TE54bFVVTXY3Y0gx?=
 =?utf-8?B?R0o0eThXY1dnNk1yNEhIbGwrSzJ0Zk1yREtFL3JTUVV0WlJhMVZ6ZWhWUEY2?=
 =?utf-8?B?clBuaXNieHRKSXVDb25vRWt0ekI4YkxFdm9hTUZoQ1BXTWdPbGp3WVc1bUVK?=
 =?utf-8?B?blVTd1BqZ3FTZDYvYkRPVlVYTnRzeVZXMG8wMnpCdUVpRUJnTU5mRTRoM2FI?=
 =?utf-8?B?RWVlT1VTamppUjZzVEM4aXFLazZFdUlhU1Fuc3VueVFQVmptYzlYT1daMnBi?=
 =?utf-8?B?Zis5NWxlOFB6ZzM0akNvaVdVdVZEZDVOOHRKeXUreEtnamdtenRrc1ZUdWtM?=
 =?utf-8?B?ZDJ6M3NtSmNWQWNVSisrMUozYnhnY1h5Q29ZZjVsM3VLUmY5Q2lKTlBYT2lM?=
 =?utf-8?B?dmdXamRvditvYU04UnM2b0JxNEIzREFDWkdEZlhiMVpVb3lMMlpaQW1Cc3dy?=
 =?utf-8?B?eWtVUkI2anZKd0FjRVhtakE5YmVJbjJZajRIUFUvck5CL0FtazZIQzdmejl1?=
 =?utf-8?B?UnBQU2F1S2RwUjYyRVg5L0hGa1grT2FFR2tnN0FkcEcyYWRqSlpvWjdPNHBP?=
 =?utf-8?B?aEJpbXRsWmJhMExTSnZqVDZOVzBPdFF3ZVRVU0cvY2ZVSlhiQzFsbjhuekpm?=
 =?utf-8?B?ZHJmNllGLzc5UW9JYmI2b2o3VjZqZ3dick9HTjR6ZnE3anhiZ1FWeFR0eHYv?=
 =?utf-8?B?UzB6L1ZlUm16RHIxQVFjaHpLV3F6S2xTbU9nQTZSNlRreDVuUDNTMFpHT0pw?=
 =?utf-8?B?UHVFRkNQNyswSHJqdnZXZlZyVG04RHJGRmp3WlhkdmtVeW5WdE9xUEF5b2FH?=
 =?utf-8?Q?98yzfoZ8+fC9uyFDGlDK2uL3e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf88d8df-4403-4f2a-c481-08dba3ab2588
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:32:47.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCTguUGmCV8i1WgoU4QpwE5/CkuCB20VH8/xE3iMY1sTSh17iDGSKZUtZzYpdmwOuWjE9vxDBtHhHB1U7DR08g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/22/23 04:20, Matthew Wilcox (Oracle) wrote:
> Eliminate a use of page->mapping by using vmalloc_to_folio() instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h          | 5 +++++
>  kernel/events/ring_buffer.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 840bae5f23b6..7d84a2843193 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1134,6 +1134,11 @@ int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
>  struct page *vmalloc_to_page(const void *addr);
>  unsigned long vmalloc_to_pfn(const void *addr);
>  
> +static inline struct folio *vmalloc_to_folio(const void *addr)
> +{
> +	return page_folio(vmalloc_to_page(addr));
I am wondering whether we should check the return value of vmalloc_to_page()?

> +}
> +
>  /*
>   * Determine if an address is within the vmalloc range
>   *
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index c73add132618..56939dc3bf33 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -873,9 +873,9 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
>  
>  static void perf_mmap_unmark_page(void *addr)
>  {
> -	struct page *page = vmalloc_to_page(addr);
> +	struct folio *folio = vmalloc_to_folio(addr);
>  
> -	page->mapping = NULL;
> +	folio->mapping = NULL;
>  }
>  
>  static void rb_free_work(struct work_struct *work)

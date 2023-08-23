Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79DBEE49A0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 12:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjHWMpm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 08:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjHWMpm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 08:45:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28CD1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692794740; x=1724330740;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hxyHmCMEOO6UeXNb7qlUEPrZcFCpRtnQXYXecKuCNFw=;
  b=VjyXJ4+qrYoquOv5RvnHbs7u/7y+ILfREyj9xjE5pFvfEGQ5SwqYztiy
   ATwAW2UR9eJ6+Rdlfcrd1d2KuDI2+qG8s6HSn4e9wCYiFNedPX1YYYe1m
   /WwjgkmxUB+koqc/fmeY5ThmH1NEolTAhyQd8YdR00vMYgwrUknCkx3Vn
   +8yMtZ6SDHDZcsgFOk9NfuTLtrttq7g42ykVjKJHx8E8fztIweLcTi0oR
   cZL6mxyJQEHXzGB7kXdbFSB5RlMQNzyvdHK7bDGtBC68i+aXgZmJ3LUcf
   Q6VMYcqMZfLRUvAQlbSiRr/QZV+fvuCKUFMDO6KC4uUMa29J7bKyvcZ6h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="377908497"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="377908497"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 05:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="1067465679"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1067465679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2023 05:45:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 05:45:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 05:45:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 05:45:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6MsH5IhAKbzRj+g64a/I8e46LBurw4ntjD9m1v4A5iB/mVlLL6zD3IzRuI4BbDEjMuMpGDoeBUlfM10pVSoCoCN5slxMtfNTwtOlZYaKdFwpV3fWSSYBq+0QuahyfQtaxM0DfjIRC3uFNskczmOVSU+veo/oN56Serqx/bDGjUi95jvyhx23HEUUeV7QAJhCgskXi5K9wXMlMfHmhK8esKymO9aiBpnIysowx+C6k8cNxdFmKTY2D01lEi0U/gl3ME+3WcCseQpyZC45EA4/lYw7kS2PmLdbgQzkput9Udiby5u2buA2UVYIrz2cah8l/KE4aiZG2U4lLimbmcUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuTJp/mC5jTeTDwsEM3OJ/SeWQyZH5u9Ra54oOOUy/o=;
 b=Ao7UJnHqyGmVQ0NOMO5qbwU2R82Z6sIuMmFIiqk/u60vKbZf9ytzLFxNxzceIw064ZFF/49AD9rcFTvd29cRS1hbR6crt5vtFrduTBadhPNJf935Qgphmfx4h0AU4fIyircXK+pWK2Ip6wirZKf+OvKO6nIErPVFfCgsbfKnnNWXFyjYSNlf2QN6pTf5XKYJaexjuaaZYLbr070P21ZDzVxAhr/ilGAeaAcf/4/jWynLUwlR9SpfpmAlAzYbSt+QjWwiAOMTTcAxU5/t/2egekvqQ6rYtohe8uU5xquWRJoYZY75wxJsZGI6noNlxMrv2GBDIhA5UyQfNcgpYtrhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 12:45:36 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 12:45:36 +0000
Message-ID: <8de1d4b0-69b1-43f1-8d63-d3c0079e4cf6@intel.com>
Date:   Wed, 23 Aug 2023 20:45:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] perf: Use folios for the aux ringbuffer &
 pagefault path
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>
References: <20230821202016.2910321-1-willy@infradead.org>
 <20230821202016.2910321-5-willy@infradead.org>
 <05db7f07-2ac2-f4d5-54ea-b5f1633e8c0c@intel.com>
 <ZOX6WXatEmIWXx7O@casper.infradead.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZOX6WXatEmIWXx7O@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM6PR11MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 14812cc1-38e2-47a3-23f4-08dba3d6d909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+azUe/oGetTLKwrOz58V+KVuOlj0YV76193/rfj60U4WrVvm9tdfSbqKAUg3iyxwVJwd3LNPujuoQjHQp6y6QfPV2Wy7UdRXud6k8zYehT4e7AN4La9kGe59HcqYDIjYOZdsfZeBX/0xcyviJGr2jbVR9v3jxx6afQHzrmx6KfBwPl2z2Ps32CQH6/HzMPPOt0dPn0JENFB7TJYRzFaggPLdK8NgFJ7/2uiqhEc9WfHlLkc0CLsthCU/K/6+4iJrVEePwFKuiDEVhUbUFIGKndwOzl1K0lvPrnK4/1kp3ZsB+bbFF4mqHYpWNu5TI5y1V0TJdPCyiS8WGr6cgdV8eA3ImJ4zvhtD6OihdMNFC11JekHUPeQKw+65I2IzdAufcY5kyMPTrGseQmUR7Q0xfTLLdIY5UecAYs4grrUqAOb3SCgzA64Nr8ugiyDKOWSBXRCOgaMxnVYgHtgMto7ZXGiRYxSUHC342ft5KCC9p+86FBjR04BjVbPx98MMBUkaj+rgnih/cxUyaKI0PE1rl7VrHOLhn0M2ZhVriW9mNBCJxUuTMacIlT/QYpjd+4Ez8Z4O+90mwFqRmqyx3JxwnOqyiZ9GNBa6BdNK5BkJdEbVUutJ0uGxE6Q7CJPKNbu06uLQdNUW1ame3tSJvcWLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(186009)(451199024)(1800799009)(31686004)(66946007)(66556008)(66476007)(6666004)(8676002)(4326008)(8936002)(53546011)(6486002)(6506007)(26005)(2616005)(478600001)(41300700001)(316002)(6512007)(5660300002)(6916009)(83380400001)(2906002)(31696002)(36756003)(38100700002)(82960400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1XTVdXUXJ2amNCV3Vyd0R1N1J3QTJpc05ZR1JXMndVdkU3YUkvTk0yd0Iy?=
 =?utf-8?B?cGxubll6RnNlTjVEcGZMRGVJYUJKS09aOW5BVWtla1FuZ0YvSy9XV2E2M0RL?=
 =?utf-8?B?Q01MV0JkSjB5Z09MWkE2aThrTmxHbFBjYmgvVm1JUURkbU9SRU56TkVRRjdK?=
 =?utf-8?B?WWZRdnhndWdXbzQwZFg4Qk51dU1yZUxwSHdwcmhGdTAvZmpHVDBiM1BFaXBx?=
 =?utf-8?B?WlU5YlBhTndjU1o1RGhtdlNzbkViVDAzb3hEdDQvTGFheFBIWElXMW82VjRU?=
 =?utf-8?B?UmpTeGRJVlpNMk1wRFZ4ejBtVWpnQ0pXcFp1OVNoRWJ1dm5tWmNBUnpobU94?=
 =?utf-8?B?aU11OGhrNmU4NCtVWXBHRGl1WkREYXJOd3dsRjM0REVjbU1yYUZkczdoOVNj?=
 =?utf-8?B?MXRGZFRyTHRIajNuaGhIcFpWS1o4Ukx6dW1VNFZqR3NaZjgwTUxrZFpvOE5O?=
 =?utf-8?B?N1kyeWtBNnFlenFUaVd1bDlWc2FWR0U0OXp2YlYxTk1pcnlsY0xIcCtvUGw2?=
 =?utf-8?B?QWpuaFJaYVdxRkZGbmhhUVZKZ1IyTWVvRzVsNjRCOWpBMC9WYWRWMnJZd3lM?=
 =?utf-8?B?c3JrNVozOGMyaldiUldFdHZtWWtMNnc5SzBmVCtWSi81Rkd4OWNFOWVWMG4y?=
 =?utf-8?B?RDA3WStubitTVnk4WDBCeVJ2OENCdmxqZTdidTdDbkJXNFEyczZLaXBlN1Nq?=
 =?utf-8?B?b2VYc2I3d1dxNXpoRVdTWFY4ZzNsejVoYUtvSmVpOUxkT2xwbzNZOEVRa0FP?=
 =?utf-8?B?Q0h2Wk56MnRWT0Ivbk5SaHBVZ1ptMDk2Z0tUNlBnSFBOSlFjZ2xNL1NSQnly?=
 =?utf-8?B?Yy9mN2ViY1JWU2REZlI1dzBwVWNSRnRjWUI4ckJ3amtLMFE4WjJUMjJBUUEr?=
 =?utf-8?B?QXdlbXRlbGFHTktIL0plK2d4ejkvc2pPYVd1K1dNQTNPM21ibXJWUWkxdDhH?=
 =?utf-8?B?YW90OCtWblNPd1VrV2VaMUJ4QnBadHZnMnlaY2ZDdFJvMFZ6dXFVRndoY0pN?=
 =?utf-8?B?cUFsUjFsWUpkd3pRN3dVK1IxenE3b2RwVER5SDdUaDVGRVE4aC91aGdUK3Rp?=
 =?utf-8?B?VFBSaWJzZWdqM1FvajU3eUo1ZnBJNjlQM1dYMFpBbHJOTHJXQUdqMEZCT0Nz?=
 =?utf-8?B?eno1OG5jZDBsVlRXaXVkYmxRdmorbHk1QmdKWkFKcTVYOXgrZUNBcWt5bVVs?=
 =?utf-8?B?Qm1TNll3OVRhTFdXUmFrdk96dzIwUWxHRFNrMm4weU9NM3grRUdORkFnNXcv?=
 =?utf-8?B?M0NyQ0JVbTd0b1VoWTh1RExOK2tXdnp1ODljRTBxZGJSRW5OeUdDR2JpWWFH?=
 =?utf-8?B?SDJTOWJzTmt6UTZmdGdDMlhLTEpXZkNWZnRBMmRuNFRHRUFHcGI2UjlxK3NP?=
 =?utf-8?B?b2dvM2h6Rmc2VFBHOFVPVTlDWGVmMFYwTWZ3S1JMUkpwOVNCK3JYcmVPd3V0?=
 =?utf-8?B?Vy92VHh1ckV3TVAzWlRhUmVLcisxcWNjakZFV09HMFNLUUY3cjV0RW5qOG9I?=
 =?utf-8?B?cHFnaWtzK212aHU4OTZycjJDZm1sZ2d5VzMxc1pkcWdBUnl0cVRzOVJEaUhn?=
 =?utf-8?B?UDIxVlo2UStJUFhqUG9ETEhXOEtCdHV2SE1VclBQTGlJTlBwcFdva1RkRFFX?=
 =?utf-8?B?b3YyUlJGSkFmY3I5VGFaQmhsbWMrWjhKM1BGazNOd1FlbVdMeFUrWVQ3Zy84?=
 =?utf-8?B?eTZORzBRcnVOdjhvVUNhMUttd0FaeGpNQWw1cjgzZ0pHcTR4RllReHJPdFlU?=
 =?utf-8?B?WHNTeUdiWEgxSElGUjJJclJQNXJXa01iZStBVGFUS2NIQUpXdzJqdkwxRnF2?=
 =?utf-8?B?Z0NNL3RJbUNrWlppRURFRGdQb3dSL21ud1hVUWprQWZCSXM2NFA0Vk5MSnhy?=
 =?utf-8?B?V1dNdjRoNC9HZitEKzNsN0ZNbS8zdFVFRnFTWm9vdEp6Z1pSZUE1VzlRUXlL?=
 =?utf-8?B?aDYyd3pBVDQyb0RsWkwrZWdCcEh3NVNtTVRLbXR1T2tMZ1JONVN0WllheTli?=
 =?utf-8?B?bUcxWW5pcW9UVGgyaUJ5Q3dRcmJBTUFWSDZGS1V0K0hIbjdHU3FFNVhVV0ps?=
 =?utf-8?B?WlNRdnk3Y1pKQ0VMS2NBUENHZmY4dVAzVEZwWTUxajJWS1hJZ0lKRzMrNmdy?=
 =?utf-8?Q?+1F6a5EuLJH5yWqAGVdUiU3xS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14812cc1-38e2-47a3-23f4-08dba3d6d909
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:45:36.4142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMCHVsFN6EDwi8H7IsduT8vw54BSmFLewzxedk6Q+v42F7M9LolULpoCW9BmJ4j0Hp3NWMW/dMDy4qGJzzlPLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/23/2023 8:23 PM, Matthew Wilcox wrote:
> On Wed, Aug 23, 2023 at 03:38:13PM +0800, Yin Fengwei wrote:
>> On 8/22/23 04:20, Matthew Wilcox (Oracle) wrote:
>>> -	get_page(vmf->page);
>>> -	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
>>> -	vmf->page->index   = vmf->pgoff;
>>> +	folio_get(folio);
>>> +	rcu_read_unlock();
>>> +	folio_lock(folio);
>>> +	if (!folio->mapping)
>>> +		folio->mapping = vmf->vma->vm_file->f_mapping;
>>>  
>>> -	ret = 0;
>>> +	return VM_FAULT_LOCKED;
>> In __do_fault():
>>
>>         if (unlikely(!(ret & VM_FAULT_LOCKED)))                                 
>>                 lock_page(vmf->page);                                           
>>         else                                                                    
>>                 VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page); 
>>
>> As we lock folio, not sure whether !PageLocked(vmf->page) can be true
>> here. My understanding is yes if vmf->pgoff belongs to tail pages. Did
>> I can miss something here?
> 
> There's only one lock bit per folio; there's no lock bit for individual
> pages.  When we check PageLocked() on a tail page, it redirects to the
> head page.
> 
> __PAGEFLAG(Locked, locked, PF_NO_TAIL)
> 
> #define PF_NO_TAIL(page, enforce) ({                                    \
>                 VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);     \
>                 PF_POISONED_CHECK(compound_head(page)); })
> 
> #define TESTPAGEFLAG(uname, lname, policy)                              \
> static __always_inline int Page##uname(struct page *page)               \
> { return test_bit(PG_##lname, &policy(page, 0)->flags); }
> 
> and that expands out to:
> 
> static __always_inline int PageLocked(struct page *page)
> { return test_bit(PG_##locked, &compound_head(page)->flags); }
> 
Ah. Here is the trick. Thanks a lot for detail explanation.


Regards
Yin, Fengwei

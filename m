Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B653C4320A
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 04:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8314960F21
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 04:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhHLEjg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 00:39:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:45052 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233944AbhHLEjg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Aug 2021 00:39:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202463615"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="202463615"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:39:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="517294469"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.174.184]) ([10.249.174.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:39:06 -0700
Subject: Re: [PATCH v4 1/2] perf pmu: Add PMU alias support
To:     Andi Kleen <ak@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210811024827.9483-1-yao.jin@linux.intel.com>
 <20210811024827.9483-2-yao.jin@linux.intel.com>
 <1d9d2f4e-ed7e-e770-066d-ef53ec31b42d@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a374557e-4347-9d27-84a5-17d22b47650f@linux.intel.com>
Date:   Thu, 12 Aug 2021 12:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1d9d2f4e-ed7e-e770-066d-ef53ec31b42d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 8/11/2021 9:27 PM, Andi Kleen wrote:
> 
>> +
>> +    dir = opendir(path);
>> +    if (!dir)
>> +        return -1;
> 
> 
> Could we cache/check the opendir result through file_available too?
> 
> 
> The rest looks good
> 
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> -Andi

Thanks Andi! Let me check how to do it.

Thanks
Jin Yao

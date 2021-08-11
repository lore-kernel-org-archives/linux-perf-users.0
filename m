Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C09C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 00:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134DF6101E
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 00:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhHKA2p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 20:28:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:62834 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235680AbhHKA2p (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 20:28:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="237040982"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="237040982"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 17:28:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="516097324"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 17:28:17 -0700
Subject: Re: [PATCH 0/6] perf events update for CascadeLake server and SkyLake
 server
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com
References: <20210810020508.31261-1-yao.jin@linux.intel.com>
 <YRLAWhHWX3oa0iyt@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <8cfa516c-af3c-49d8-90ad-1e922567a24e@linux.intel.com>
Date:   Wed, 11 Aug 2021 08:28:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRLAWhHWX3oa0iyt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On 8/11/2021 2:07 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 10, 2021 at 10:05:02AM +0800, Jin Yao escreveu:
>> - Update JSON core/uncore events and metrics for CascadeLake Server.
>> - Update JSON core/uncore events and metrics for SkyLake Server.
>>
>> The patch series can be found at (in case broken by mailing system potentially):
>> https://github.com/yaoj/perf-clx-events.git
>> branch: perf/core
> Hey, can you keep just one repository and then create branches?
> 

Oh, yes, creating too many repos. :(

I will keep just one repo and create branches for future event updates.

Thanks
Jin Yao

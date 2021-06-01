Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D3C47092
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158F9611CA
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhFAJqv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:46:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:35689 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233160AbhFAJqu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 05:46:50 -0400
IronPort-SDR: lRITwuc9Eus0Ru30hdX9YpoW0E0RiD7RBHaN/jNujtgwSXo+lhnQ6RQ4mqHELmR566FLbB+vrk
 FhDmZjaUvymA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="224786592"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="224786592"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 02:44:58 -0700
IronPort-SDR: g2+fB+JR3DhXT9ruYZpdncTPbD29JQZsnRj86xjNT71H1xcQ23sY9HKJc8szCumHNMXb1PUQlj
 ivxrAvlxcLAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="482420276"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2021 02:44:55 -0700
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with load-acquire
 and store-release
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
 <20210601063342.GB10026@leoy-ThinkPad-X240s>
 <71b0e395-0e20-fdd1-b105-0ca1706c8ed1@intel.com>
 <YLX7OhK37QmfeOwu@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4af1a96d-e03c-f1b4-ebce-ca869318c8cf@intel.com>
Date:   Tue, 1 Jun 2021 12:45:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLX7OhK37QmfeOwu@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 1/06/21 12:17 pm, Peter Zijlstra wrote:
> On Tue, Jun 01, 2021 at 12:07:31PM +0300, Adrian Hunter wrote:
>> __sync_xxx_compare_and_swap is out-of-date now. This page:
>>
>> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins
>>
>> recommends '__atomic' builtins instead.
> 
> perf doesn't seem to use that.

I guess we could drop support for the compat case; add validation:

"Error, 32-bit perf cannot record AUX area traces from a 64-bit kernel.
Please use a 64-bit version of perf instead."

> 
>> Since atomics are needed only for the "compat" case (i.e. 32-bit perf with 64-bit kernel)
>> you could try to find an elegant way to check for a 64-bit kernel, and avoid the atomics
>> for a 32-bit perf with 32-bit kernel.
> 
> Most 32bit archs cannot do 64bit atomics. I suppose the only reason this
> doesn't explode is because the aux stuff isn't supported on many
> architectures?
> 

Yes but presumably the race itself is unlikely since the upper byte changes only once every 4GiB.


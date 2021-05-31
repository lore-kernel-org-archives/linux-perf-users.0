Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065B1C47080
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 19:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB66660FDB
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 19:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhEaTE4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 May 2021 15:04:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:55930 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhEaTEz (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 May 2021 15:04:55 -0400
IronPort-SDR: 22NywMRwqklgNuss5x55CUUJgTGH8a3Cr15zyqo0rH32OgFDQ1yNK5cjS2qJJSNJ9V/REvK03+
 nfzlpnUN1cEw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="224675447"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="224675447"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 12:03:14 -0700
IronPort-SDR: T9VUXeMKnve3B5d3pzUtgVROMI93SP8hU0DR9ON6SyBl67y+iVKYkH8r9hozmo1aGPhHmcnvHI
 dQJdLxNQDx4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="482195243"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2021 12:03:12 -0700
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with load-acquire
 and store-release
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
Date:   Mon, 31 May 2021 22:03:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531151049.GE9324@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 31/05/21 6:10 pm, Leo Yan wrote:
> Hi Peter, Adrian,
> 
> On Wed, May 19, 2021 at 10:03:19PM +0800, Leo Yan wrote:
>> Load-acquire and store-release are one-way permeable barriers, which can
>> be used to guarantee the memory ordering between accessing the buffer
>> data and the buffer's head / tail.
>>
>> This patch optimizes the memory ordering with the load-acquire and
>> store-release barriers.
> 
> Is this patch okay for you?
> 
> Besides this patch, I have an extra question.  You could see for
> accessing the AUX buffer's head and tail, it also support to use
> compiler build-in functions for atomicity accessing:
> 
>   __sync_val_compare_and_swap()
>   __sync_bool_compare_and_swap()
> 
> Since now we have READ_ONCE()/WRITE_ONCE(), do you think we still need
> to support __sync_xxx_compare_and_swap() atomicity?

I don't remember, but it seems to me atomicity is needed only
for a 32-bit perf running with a 64-bit kernel.

> 
> I checked the code for updating head and tail for the perf ring buffer
> (see ring_buffer_read_head() and ring_buffer_write_tail() in the file
> tools/include/linux/ring_buffer.h), which doesn't support
> __sync_xxx_compare_and_swap() anymore.  This is why I wander if should
> drop __sync_xxx_compare_and_swap() atomicity for AUX ring buffer as
> well.
> 
> Thanks,
> Leo
> 


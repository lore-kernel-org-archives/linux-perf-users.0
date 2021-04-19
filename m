Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE55C433ED
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Apr 2021 08:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5601B6101C
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Apr 2021 08:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhDSITD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Apr 2021 04:19:03 -0400
Received: from foss.arm.com ([217.140.110.172]:37620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237632AbhDSITC (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Apr 2021 04:19:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 533D61FB;
        Mon, 19 Apr 2021 01:18:33 -0700 (PDT)
Received: from [10.57.57.205] (unknown [10.57.57.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5BEF3F85F;
        Mon, 19 Apr 2021 01:18:29 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210416105632.8771-1-james.clark@arm.com>
 <20210416150709.GA1046932@xps15> <YHmqZKGMFydbsvEy@kernel.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <c3a75731-15b4-e052-1840-a881b05862df@arm.com>
Date:   Mon, 19 Apr 2021 11:18:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YHmqZKGMFydbsvEy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 16/04/2021 18:16, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 16, 2021 at 09:07:09AM -0600, Mathieu Poirier escreveu:
>> Hi James,
>>
>> On Fri, Apr 16, 2021 at 01:56:30PM +0300, James Clark wrote:
>>> Changes since v1:
>>>  * Improved variable name from etm_timestamp -> cs_timestamp
>>>  * Fixed ordering of Signed-off-by
>>>
>>
>> You forgot to add the RB and AB you received.  Since Arnaldo is responsible for
>> the perf tools subsystem, please send another revision.
>  
> 
> 
> Yep, please collect Reported-by and Acked-by as you go sending new
> versions of a patchset, the last one I don't have a problem collecting
> myself, but if you have to resend, please collect the feedback tags.
> 
> - Arnaldo
> 

Ok thanks, I will keep that in mind for the future. I wasn't sure if they still
applied or not as it was a new version.

Thanks
James

>> Thanks,
>> Mathieu
>>
>>> James Clark (2):
>>>   perf cs-etm: Refactor timestamp variable names
>>>   perf cs-etm: Set time on synthesised samples to preserve ordering
>>>
>>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++----
>>>  tools/perf/util/cs-etm.c                      | 52 ++++++++++---------
>>>  tools/perf/util/cs-etm.h                      |  4 +-
>>>  3 files changed, 39 insertions(+), 35 deletions(-)
>>>
>>> -- 
>>> 2.28.0
>>>
> 

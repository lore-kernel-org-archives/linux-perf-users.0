Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1822BC47094
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 16:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E9660FEA
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 16:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFJQGl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:06:41 -0400
Received: from foss.arm.com ([217.140.110.172]:35554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhFJQGl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 12:06:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91672ED1;
        Thu, 10 Jun 2021 09:04:44 -0700 (PDT)
Received: from [10.57.74.218] (unknown [10.57.74.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0CB3F719;
        Thu, 10 Jun 2021 09:04:41 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] coresight: Fix for snapshot mode
To:     Denis Nikitin <denik@google.com>, Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com>
Date:   Thu, 10 Jun 2021 17:04:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Denis

On 10/06/2021 07:43, Denis Nikitin wrote:
> Hi Leo,
> 
> On Fri, May 28, 2021 at 9:16 AM Leo Yan <leo.yan@linaro.org> wrote:
>>
>> This patch series is to correct the pointer usages for the snapshot
>> mode.
>>
>> Patch 01 allows the AUX trace in the free run mode and only syncs the
>> AUX ring buffer when taking snapshot.
>>
>> Patch 02 is to polish code, it removes the redundant header maintained
>> in tmc-etr driver and directly uses pointer perf_output_handle::head.
>>
>> Patch 03 removes the callback cs_etm_find_snapshot() which wrongly
>> calculates the buffer headers; we can simply use the perf's common
>> function __auxtrace_mmap__read() for headers calculation.
>>
>> This patch can be cleanly applied on the mainline kernel with:
>>
>>    commit 97e5bf604b7a ("Merge branch 'for-5.13-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu")
>>
>> And it has been tested on Arm64 Juno board.
> 
> I have verified the patches on Chrome OS Trogdor device.
> They fixed the problem discussed in
> https://lists.linaro.org/pipermail/coresight/2021-May/006411.html.

Are you able to confirm if the patch 3 alone fixes the above issue ?
I am not convinced that Patch 1 is necessary.

Suzuki

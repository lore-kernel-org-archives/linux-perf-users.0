Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C25C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Nov 2021 11:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhKYL7d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:59:33 -0500
Received: from foss.arm.com ([217.140.110.172]:49998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239565AbhKYL5d (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 Nov 2021 06:57:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A36CA1042;
        Thu, 25 Nov 2021 03:54:21 -0800 (PST)
Received: from [10.57.59.91] (unknown [10.57.59.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC093F66F;
        Thu, 25 Nov 2021 03:54:18 -0800 (PST)
Subject: Re: [RESEND PATCH 1/1] perf arm-spe: report all SPE records as "all"
 events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211117142833.226629-1-german.gomez@arm.com>
 <20211125075358.GA1599216@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <3a84dd85-7bae-49ea-75cc-52f9a8220cc4@arm.com>
Date:   Thu, 25 Nov 2021 11:54:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211125075358.GA1599216@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On 25/11/2021 07:53, Leo Yan wrote:
> On Wed, Nov 17, 2021 at 02:28:32PM +0000, German Gomez wrote:
>> [...]
> After checked the event types, I think "other" samples would include
> below raw event types:
>
>   EV_EXCEPTION_GEN
>   EV_RETIRED
>   EV_NOT_TAKEN
>   EV_ALIGNMENT
>   EV_PARTIAL_PREDICATE
>   EV_EMPTY_PREDICATE
>
> I am just wander if we can use sample.transaction to store these event
> types, otherwise, we cannot distinguish the event type for the samples.

I'm not familiar with the meaning of transactions in this context, but
I agree giving visibility of these remaining events is a good idea. I'm
just unsure where to place them from the available --itrace options.

Regarding the "all" events, we thought having quick access to a  global
histogram of all the spe events is useful, and from all the --itrace
options it seemed to fit best under --itrace=o.

Thanks,
German

>
> And it's good fill more sample fields for complete info, like:
>
>   sample.addr = record->virt_addr;
>   sample.phys_addr = record->phys_addr;
>   sample.data_src = data_src;
>
> Thanks,
> Leo
>
>> [...]

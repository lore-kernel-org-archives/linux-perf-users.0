Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA949C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 08:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE05C61076
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 08:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhJLItc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:49:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235462AbhJLItc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Oct 2021 04:49:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86EEAED1;
        Tue, 12 Oct 2021 01:47:30 -0700 (PDT)
Received: from [10.57.21.6] (unknown [10.57.21.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A23433F694;
        Tue, 12 Oct 2021 01:47:28 -0700 (PDT)
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
To:     Will Deacon <will@kernel.org>, German Gomez <german.gomez@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211012081948.GA5156@willie-the-truck>
From:   James Clark <james.clark@arm.com>
Message-ID: <55f8978f-e656-5d5f-94e2-f4be4a70656d@arm.com>
Date:   Tue, 12 Oct 2021 09:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012081948.GA5156@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/10/2021 09:19, Will Deacon wrote:
> On Mon, Oct 11, 2021 at 04:55:37PM +0100, German Gomez wrote:
>> Hi Leo,
>>
>> On 06/10/2021 10:51, Leo Yan wrote:
>>> On Wed, Oct 06, 2021 at 10:35:20AM +0100, German Gomez wrote:
>>>
>>> [...]
>>>
>>>>> So simply say, I think the head pointer monotonically increasing is
>>>>> the right thing to do in Arm SPE driver.
>>>> I will talk to James about how we can proceed on this.
>>> Thanks!
>>
>> I took this offline with James and, though it looks possible to patch
>> the SPE driver to have a monotonically increasing head pointer in order
>> to simplify the handling in the perf tool, it could be a breaking change
>> for users of the perf_event_open syscall that currently rely on the way
>> it works now.
>>
>> An alternative way we considered to simplify the patch is to change the
>> logic inside the find_snapshot callback so that it records the entire
>> contents of the aux buffer every time.
>>
>> What do you think?
> 
> What does intel-pt do?

Intel-pt has a wrapped head, which is why it has the intel_pt_find_snapshot()
function in perf to try to not save any zeros from the buffer that haven't
been written yet. (With a wrapped head pointer it's impossible to tell).

Coresight has a monotonically increasing head pointer so it is possible to
tell. Recently, Leo removed the Coresight version of find_snapshot() for this
reason.

It would be nice to do the same for SPE because that function has a heuristic
and is also slow, but I imagine that not returning wrapped head pointers could
break anything that expects them.

James
 
> 
> Will
> 

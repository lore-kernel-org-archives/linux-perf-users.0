Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D1C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C626108E
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 12:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhJOMfv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:35:51 -0400
Received: from foss.arm.com ([217.140.110.172]:41970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234372AbhJOMfv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 08:35:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D9E1147A;
        Fri, 15 Oct 2021 05:33:44 -0700 (PDT)
Received: from [10.57.73.178] (unknown [10.57.73.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A18913F70D;
        Fri, 15 Oct 2021 05:33:41 -0700 (PDT)
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
 <20211013003916.GA130842@leoy-ThinkPad-X240s>
 <20211013075125.GA6701@willie-the-truck>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <35209d5c-6387-5248-ab61-a1e1cb0553de@arm.com>
Date:   Fri, 15 Oct 2021 13:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013075125.GA6701@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

Would you be ok with the current patch the way it is? In case it's of
any help, I'm sharing the testing steps that James and I went through
when testing this internally, if you want to add to it

- Test that only a portion of the buffer is saved until there is a wraparound

$ ./perf record -vvv -e arm_spe/period=148576/u -S -- taskset --cpu-list 0 stress --cpu 1 & while true; do sleep 0.2; killall -s USR2 perf; done

- Test snapshot mode in CPU mode

$ sudo ./perf record -vvv -C 0 -e arm_spe/period=148576/u -S -- taskset --cpu-list 0 stress --cpu 1 &

- Test that auxtrace buffers correspond to an aux record
- Test snapshot default sizes in sudo and user modes
- Test small snapshot size

$ ./perf record -vvv -e arm_spe/period=148576/u -S1000 -m16,16 -- taskset --cpu-list 0 stress --cpu 1 &

If there are any concerns with the patches, please let me know and I
will try to address them.

Thanks,
German

On 13/10/2021 08:51, Will Deacon wrote:
> On Wed, Oct 13, 2021 at 08:39:16AM +0800, Leo Yan wrote:
>> On Mon, Oct 11, 2021 at 04:55:37PM +0100, German Gomez wrote:
>>> On 06/10/2021 10:51, Leo Yan wrote:
>>>> On Wed, Oct 06, 2021 at 10:35:20AM +0100, German Gomez wrote:
>>>>
>>>> [...]
>>>>
>>>>>> So simply say, I think the head pointer monotonically increasing is
>>>>>> the right thing to do in Arm SPE driver.
>>>>> I will talk to James about how we can proceed on this.
>>>> Thanks!
>>> I took this offline with James and, though it looks possible to patch
>>> the SPE driver to have a monotonically increasing head pointer in order
>>> to simplify the handling in the perf tool, it could be a breaking change
>>> for users of the perf_event_open syscall that currently rely on the way
>>> it works now.
>> Here I cannot create the connection between AUX head pointer and the
>> breakage of calling perf_event_open().
>>
>> Could you elaborate what's the reason the monotonical increasing head
>> pointer will lead to the breakage for perf_event_open()?
> It's a user-visible change in behaviour, isn't it? Therefore we risk
> breaking applications that rely on the current behaviour if we change it
> unconditionally.
>
> Given that the driver has always worked like this and it doesn't sound like
> it's the end of the world to deal with it in userspace (after all, it's
> aligned with intel-pt), then I don't think we should change it.
>
> Will

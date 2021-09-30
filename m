Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC344C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9536136A
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 12:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349808AbhI3M2D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 08:28:03 -0400
Received: from foss.arm.com ([217.140.110.172]:53400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350160AbhI3M2C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Sep 2021 08:28:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D05A3106F;
        Thu, 30 Sep 2021 05:26:19 -0700 (PDT)
Received: from [10.57.21.68] (unknown [10.57.21.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15E733F793;
        Thu, 30 Sep 2021 05:26:16 -0700 (PDT)
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
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
From:   German Gomez <german.gomez@arm.com>
Message-ID: <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
Date:   Thu, 30 Sep 2021 13:26:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210923144048.GB603008@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On 23/09/2021 15:40, Leo Yan wrote:
> On Thu, Sep 23, 2021 at 09:50:16PM +0800, Leo Yan wrote:
>
> [...]
>
>>> @@ -336,6 +480,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
>>>   	sper->itr.pmu = arm_spe_pmu;
>>>   	sper->itr.snapshot_start = arm_spe_snapshot_start;
>>>   	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
>>> +	sper->itr.find_snapshot = arm_spe_find_snapshot;
>> If I understand correctly, this patch copies the code from cs-etm for
>> snapshot handling.  About 2 months ago, we removed the Arm cs-etm's
>> specific snapshot callback function and directly use perf's function
>> __auxtrace_mmap__read() to handle 'head' and 'tail' pointers.  Please
>> see the commit for details:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f01c200d4405c4562e45e8bb4de44a5ce37b217
>>
>> Before I review more details for snapshot enabling in patches 03 and
>> 04, could you confirm if Arm SPE can use the same way with cs-etm for
>> snapshot handling?  From my understanding, this is a better way to
>> handle AUX buffer's 'head' and 'tail'.
> In other words, if we can only apply patch 03 and can pass the testing
> in patch 05, then it would be a very neat implementation.
>
> I will try to verify these patches and will get back result.
>
> Thanks,
> Leo
The patch is indeed based on that commit. The reason behind it is that the
values for *head are being wrapped in the driver side (see the macro
PERF_IDX2OFF which is used at various points in 
/drivers/perf/arm_spe_pmu.c).

If this callback is not to be added, I believe the driver needs to be 
updated
first so that the head pointer monotonically increases like in cs-etm. 
Do you
think this makes sense for SPE?

(note that the patch will skip the wrap-around detection if this is the 
case,
in order to handle both cases in the userspace perf tool).

Thanks,
German


Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E9C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7149D61075
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhJFJhS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:37:18 -0400
Received: from foss.arm.com ([217.140.110.172]:40520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJFJhR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 05:37:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D42CA1FB;
        Wed,  6 Oct 2021 02:35:25 -0700 (PDT)
Received: from [10.1.34.161] (e127744.cambridge.arm.com [10.1.34.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7378D3F766;
        Wed,  6 Oct 2021 02:35:23 -0700 (PDT)
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
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
Date:   Wed, 6 Oct 2021 10:35:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211004122724.GC174271@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

Many thanks for your comments.

On 04/10/2021 13:27, Leo Yan wrote:

> Hi German,
>
> On Thu, Sep 30, 2021 at 01:26:15PM +0100, German Gomez wrote:
>
> [...]
>
> So simply say, I think the head pointer monotonically increasing is
> the right thing to do in Arm SPE driver.

I will talk to James about how we can proceed on this.

>> (note that the patch will skip the wrap-around detection if this is the
>> case,
>> in order to handle both cases in the userspace perf tool).
> Almost agree, I read multiple times but have no idea what's the
> "both cases" in the last sentence.

Apologies for the later part was not clear. What I meant to say was that
in the original patch for cs-etm, it seemed to handle both cases where
AUX head might be monotonically and non-monotonically increasing, so we
applied the same for the Arm SPE patch.

>
> Please let me know if anything is not clear.
>
> Thanks,
> Leo
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/auxtrace.c#n1804

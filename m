Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B48C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A5860E74
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 15:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhJKP5p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 11:57:45 -0400
Received: from foss.arm.com ([217.140.110.172]:35654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhJKP5n (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 11:57:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE100ED1;
        Mon, 11 Oct 2021 08:55:42 -0700 (PDT)
Received: from [10.1.31.146] (e127744.cambridge.arm.com [10.1.31.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F20D23F66F;
        Mon, 11 Oct 2021 08:55:39 -0700 (PDT)
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
From:   German Gomez <german.gomez@arm.com>
Message-ID: <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
Date:   Mon, 11 Oct 2021 16:55:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211006095124.GC14400@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Leo,

On 06/10/2021 10:51, Leo Yan wrote:
> On Wed, Oct 06, 2021 at 10:35:20AM +0100, German Gomez wrote:
>
> [...]
>
>>> So simply say, I think the head pointer monotonically increasing is
>>> the right thing to do in Arm SPE driver.
>> I will talk to James about how we can proceed on this.
> Thanks!

I took this offline with James and, though it looks possible to patch
the SPE driver to have a monotonically increasing head pointer in order
to simplify the handling in the perf tool, it could be a breaking change
for users of the perf_event_open syscall that currently rely on the way
it works now.

An alternative way we considered to simplify the patch is to change the
logic inside the find_snapshot callback so that it records the entire
contents of the aux buffer every time.

What do you think?

Many thanks,
German

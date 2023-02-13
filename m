Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9FBC636D4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Feb 2023 09:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBMJy6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Feb 2023 04:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMJy6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Feb 2023 04:54:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6495D902F
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 01:54:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75E474B3;
        Mon, 13 Feb 2023 01:55:38 -0800 (PST)
Received: from [10.57.50.214] (unknown [10.57.50.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B7F3F703;
        Mon, 13 Feb 2023 01:54:55 -0800 (PST)
Message-ID: <894c0e96-b450-dfc1-fc70-31e21194f10a@arm.com>
Date:   Mon, 13 Feb 2023 09:54:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: missing stack frames
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Pete Stevenson <jstevenson@pixielabs.ai>
Cc:     linux-perf-users@vger.kernel.org
References: <CAK2+a3QGJ6gJEiBwH831aWUqaBUskhmbyfz43cLk2vpSX_UT6A@mail.gmail.com>
 <CAP-5=fWNgPGO-Zx6398=6tuGzwxQm0Hz9v=GfOufxoTJEWrCWw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWNgPGO-Zx6398=6tuGzwxQm0Hz9v=GfOufxoTJEWrCWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 09/02/2023 03:36, Ian Rogers wrote:
> On Wed, Feb 8, 2023 at 5:54 PM Pete Stevenson <jstevenson@pixielabs.ai> wrote:
>>
>> We have crafted a program where with some definite expectations about
>> what stack traces we expect, but in less than 1% of the samples, we
>> see one stack frame missing.
>>
>> Roughly speaking, we see the following:
>> libc -> main -> foo -> bar (99.49%) (expected)
>> libc -> main -> bar (0.51%) (not expected)
>>
>> That is, in 0.51% +/- of the cases, the stack trace samples collected
>> by perf appear to indicate that "main" is directly calling "bar" which
>> we do not believe to be the case. We first observed this in a slightly
>> more complicated setup with a different profiler, but have been
>> chasing this down to a fairly reductive example. We ran the perf
>> profiler using a few different command line options (with and without
>> -g and --call-graph dwarf) and saw the same basic results with each
>> method.
>>
>> Curious to know if anyone understands the underlying cause of this...
>> Is it something like a non-atomic sample of the stack trace, i.e. the
>> stack frames are being manipulated while the stack trace is being
>> sampled? Something else?
> 
> It is possibly an issue with frame pointers. On x86 function entry looks like:
> push %rbp
> mov %rsp, %rbp
> 
> Stacks grow down, the x86 representation is:
> https://github.com/torvalds/linux/blob/master/arch/x86/include/asm/stacktrace.h#L101
> 
> The stack can only be walked if both of the entry instructions have
> been executed and the 0.51% may be inside these first two instructions
> (or similar in the function epilogue).
> 

On Arm we had an issue that looked like this when using --call-graph=fp,
but we managed to insert the second to last missing frame in Perf using
the dwarf as a post processing step. This was because leaf functions
don't insert a frame pointer, even with -fno-omit-frame-pointer because
there is no point.

With --call-graph=dwarf I would expect the stacks to always be complete,
even with inlining and missing frame pointers. Unless you aren't
including all the debug symbols or stripping them afterwards or
something like that? Otherwise it could be a bug in libunwind or libdw
or the dwarf generation.

James

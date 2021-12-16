Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE3C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Dec 2021 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbhLPRXy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Dec 2021 12:23:54 -0500
Received: from foss.arm.com ([217.140.110.172]:46436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240204AbhLPRXy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Dec 2021 12:23:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5CD01435;
        Thu, 16 Dec 2021 09:23:53 -0800 (PST)
Received: from [10.57.6.4] (unknown [10.57.6.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 477173F774;
        Thu, 16 Dec 2021 09:23:53 -0800 (PST)
Subject: Re: perf not showing me call graph for memcpy no matter what
To:     Timothy Miller <theosib@icloud.com>,
        linux-perf-users@vger.kernel.org
References: <55BDE53A-EF97-4EF6-80C4-11821372A842@icloud.com>
From:   James Clark <james.clark@arm.com>
Cc:     German Gomez <german.gomez@arm.com>
Message-ID: <2edea69f-f1b2-f970-75c0-99bc9ae084b9@arm.com>
Date:   Thu, 16 Dec 2021 17:23:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <55BDE53A-EF97-4EF6-80C4-11821372A842@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 16/12/2021 13:37, Timothy Miller wrote:
> Hi,
> 
> I am doing some software profiling on an aarch64 system, and I’m using the Linux perf tool. The problem I’m running into is that “__GI___memcpy_simd” keeps showing up as the function with the most CPU usage.
> 

> Unfortunately, no matter what I do, this function keeps showing up as orphaned. That is, I cannot get a stack trace for it so I can find out who is calling it.
>
Hi Timothy,

Do you have a full reproducer? Maybe one that works in a fresh docker container, and with what you expect to see vs what you actually see.

What version of perf and libunwind are you using?

 
> I have tried using dwarf mode, but it always gets overloaded.

Not sure what you mean by overloaded.

> 
> I have tried using lbr mode, but I get the following error:
>    Error:
>    PMU Hardware doesn't support sampling/overflow-interrupts.
> 
> I’ve rebuilt my application and all relevant libraries with -no-omit-frame-pointer so that I could use the default frame pointer mode. Unfortunately, I still can’t get a call graph for this function.

Even with that option the compiler will still omit frame pointers if there is absolutely no need for them,
for example for a leaf function call. Although it doesn't sound exactly like that's your issue.

You could try the patch "[PATCH v4 0/6] Fix missing leaf-function callers when recording" which is currently on
the mailing list, but that will only give you the caller of the last function. It sounds like you have more
frames missing?

> 
> I emailed the glibc mailing list about this, trying to find out how to work around this problem, perhaps adding frame pointer to the assembly implementation of memcpy. They suggested I try attaching a debugger, and I’ve found that I can get stack traces just fine. They suggest that I seem to be running into some kind of bug in perf. 
> 
> Any help/advice would be appreciated.
> 
> Thanks.
> 
> 

Thanks
James

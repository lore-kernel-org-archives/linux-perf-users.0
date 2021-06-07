Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A27C47082
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FF5611AB
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 09:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFGJQQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:16:16 -0400
Received: from foss.arm.com ([217.140.110.172]:55782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhFGJQQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 05:16:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F216C31B;
        Mon,  7 Jun 2021 02:14:24 -0700 (PDT)
Received: from [10.57.1.61] (unknown [10.57.1.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379F43F719;
        Mon,  7 Jun 2021 02:14:22 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: perf: Improve compat perf_callchain_user() for
 clang leaf functions
To:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexandre Truong <alexandre.truong@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>,
        Al Grant <Al.Grant@arm.com>
References: <20210507205513.640780-1-dianders@chromium.org>
 <20210507135509.2.Ib54050e4091679cc31b04d52d7ef200f99faaae5@changeid>
From:   James Clark <james.clark@arm.com>
Message-ID: <47a95789-ca75-70a5-9d65-a2d3e9c651bc@arm.com>
Date:   Mon, 7 Jun 2021 12:14:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210507135509.2.Ib54050e4091679cc31b04d52d7ef200f99faaae5@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 07/05/2021 23:55, Douglas Anderson wrote:
> It turns out that even when you compile code with clang with
> "-fno-omit-frame-pointer" that it won't generate a frame pointer for
> leaf functions (those that don't call any sub-functions). Presumably
> clang does this to reduce the overhead of frame pointers. In a leaf
> function you don't really need frame pointers since the Link Register
> (LR) is guaranteed to always point to the caller> 
[...]
> 
>  arch/arm64/kernel/perf_callchain.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
> index e5ce5f7965d1..b3cd9f371469 100644
> --- a/arch/arm64/kernel/perf_callchain.c
> +++ b/arch/arm64/kernel/perf_callchain.c
> @@ -326,6 +326,20 @@ static void compat_perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  	while ((entry->nr < entry->max_stack) && fp && !(fp & 0x3)) {
>  		err = compat_perf_trace_1(&fp, &pc, leaf_lr);
>  
> +		/*
> +		 * If this is the first trace and it didn't find the LR then
> +		 * let's throw it in the trace first. This isn't perfect but
> +		 * is the best we can do for handling clang leaf functions (or
> +		 * the case where we're right at the start of the function
> +		 * before the new frame has been pushed). In the worst case
> +		 * this can cause us to throw an extra entry that will be some
> +		 * location in the same function as the PC. That's not
> +		 * amazing but shouldn't really hurt. It seems better than
> +		 * throwing away the LR.
> +		 */

Hi Douglas,

I think the behaviour with GCC is also similar. We were working on this change
(https://lore.kernel.org/lkml/20210304163255.10363-4-alexandre.truong@arm.com/)
in userspace Perf which addresses the same issue.

The basic concept of our version is to record only the link register
(as in --user-regs=lr). Then use the existing dwarf based unwind
to determine if the link register is valid for that frame, and then if
it is and it doesn't already exist on the stack then insert it.

You mention that your version isn't perfect, do you think that saving the
LR and using something like libunwind in a post process could be better?

Thanks
James

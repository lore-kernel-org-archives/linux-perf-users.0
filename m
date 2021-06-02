Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7204C4708F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906EB61DA1
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFBR5t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 13:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhFBR5t (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 13:57:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5793661DA5;
        Wed,  2 Jun 2021 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622656566;
        bh=Czsuka7+HAGaSUNNQSSRfeXG6GJieqJ4DRUlmcntgAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5cJqRiURMB0mvCDuGxAQqoQaubwsosndqXFSMS4MV01Blt3guNQdVa6KgxMskLh/
         i+XoodFDYNHcDJfZPFwi2mG6UO2vAdFGvJuPRdFvR0WXkk5njxy4XZTyQMVyTVackS
         VF4gbeIEAs1034YIdmLym9QTFCge8bFpXghi1epxehKF01pD2JHU7BOgakp0zJ64PB
         iT0VSbSMOaUA7la2vkc96ulysSfE2XV2lGm9KCB8nzlSsrHQ45AMFOqxgBsUkl/pLN
         vyTpn801vbDdCAsWGnOUW/pHFTV3SV/xMl8bESrw5wcIrFTaT2xojOOvUSph92qO96
         9uEKhbqRyHkdg==
Date:   Wed, 2 Jun 2021 18:55:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: perf: Make compat tracing better
Message-ID: <20210602175559.GC31957@willie-the-truck>
References: <20210507205513.640780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507205513.640780-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Doug,

Thanks for posting this, and sorry for the delay in getting to it.

On Fri, May 07, 2021 at 01:55:10PM -0700, Douglas Anderson wrote:
> The goal for this series is to improve "perf" behavior when 32-bit
> userspace code is involved. This turns out to be fairly important for
> Chrome OS which still runs 32-bit userspace for the time being (long
> story there).

Watch out, your days are numbered! See [1].

> I won't repeat everything said in the individual patches since since
> they are wordy enough as it is.
> 
> Please enjoy and I hope this isn't too ugly/hacky for inclusion in
> mainline.
> 
> Thanks to Nick Desaulniers for his early review of these patches and
> to Ricky for the super early prototype that some of this is based on.

I can see that you've put a lot of effort into this, but I'm not thrilled
with the prospect of maintaining these heuristics in the kernel. The
callchain behaviour is directly visible to userspace, and all we'll be able
to do is throw more heuristics at it if faced with any regression reports.
Every assumption made about userspace behaviour results in diminishing
returns where some set of programs no longer fall into the "supported"
bucket and, on balance, I don't think the trade-off is worth it.

If we were to do this in the kernel, then I'd like to see a spec for how
frame-pointer based unwinding should work for Thumb and have it agreed
upon and implemented by both GCC and LLVM. That way, we can implement
the unwinder according to that spec and file bug reports against the
compiler if it goes wrong.

In lieu of that, I think we must defer to userspace to unwind using DWARF.
Perf supports this via PERF_SAMPLE_STACK_USER and PERF_SAMPLE_REGS_USER,
which allows libunwind to be used to create the callchain. You haven't
mentioned that here, so I'd be interested to know why not.

Finally, you've probably noticed that our unwinding code for compat tasks
is basically identical to the code in arch/arm/. If the functionality is
going to be extended, it should be done there first and then we will follow
to be compatible.

Cheers,

Will

[1] https://lore.kernel.org/lkml/20210602164719.31777-20-will@kernel.org/T/#u

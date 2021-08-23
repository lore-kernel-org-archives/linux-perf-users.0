Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD8C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DE761178
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 13:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhHWNkW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhHWNkW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 09:40:22 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E9C061575;
        Mon, 23 Aug 2021 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vDAwDNrs70PDBIgh6tM7DTK9SFNnj5FHLm+1BK/qmTA=; b=j3PPjl5xKUWP3vBHITYYskIxm
        9iGIA8RlWfQV0i5U4EVe61Cd68byE2j/Te/ishZPvEBDwM9iKqXwhC7ZqGdXhxeUz+vP5X8kOJu55
        fe6k/1ZBBysMwya/j49spaXzoniVoLgDdNPqxtpBydMrAFmP9H3vfLVIj6cLiG+NymWlJb8vot5cJ
        GFrmGwSJE5weKoRTeBO9KhvH8OncxES6OEd3oMKUKD5EL8kHMrnNP8O/t5PAiP/sWrNCCvwBIyLpw
        VgxvPcalVUgyPr1oaJR1LtObLCPOEar1FXKUrMbkRpGgIPW8nEcoeTvn7ug4KkYgJMswdJDK05lta
        KD+Ls+yEA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47582)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mIAAc-00033W-FT; Mon, 23 Aug 2021 14:39:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mIAAY-0006Dc-ER; Mon, 23 Aug 2021 14:39:18 +0100
Date:   Mon, 23 Aug 2021 14:39:18 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Li Huafei <lihuafei1@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf auxtrace arm: Support
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210823133918.GP22278@shell.armlinux.org.uk>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-4-leo.yan@linaro.org>
 <6ce4057a-57cf-501d-6449-2069cd00ba57@arm.com>
 <20210823133043.GF100516@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823133043.GF100516@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 23, 2021 at 09:30:43PM +0800, Leo Yan wrote:
> Hi James,
> 
> On Mon, Aug 23, 2021 at 01:23:42PM +0100, James Clark wrote:
> > 
> > 
> > On 09/08/2021 12:27, Leo Yan wrote:
> > > When the tool runs with compat mode on Arm platform, the kernel is in
> > > 64-bit mode and user space is in 32-bit mode; the user space can use
> > > instructions "ldrd" and "strd" for 64-bit value atomicity.
> > > 
> > > This patch adds compat_auxtrace_mmap__{read_head|write_tail} for arm
> > > building, it uses "ldrd" and "strd" instructions to ensure accessing
> > > atomicity for aux head and tail.  The file arch/arm/util/auxtrace.c is
> > > built for arm and arm64 building, these two functions are not needed for
> > > arm64, so check the compiler macro "__arm__" to only include them for
> > > arm building.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> > > index b187bddbd01a..c7c7ec0812d5 100644
> > > --- a/tools/perf/arch/arm/util/auxtrace.c
> > > +++ b/tools/perf/arch/arm/util/auxtrace.c
> > > @@ -107,3 +107,35 @@ struct auxtrace_record
> > >  	*err = 0;
> > >  	return NULL;
> > >  }
> > > +
> > > +#if defined(__arm__)
> > > +u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> > > +{
> > > +	struct perf_event_mmap_page *pc = mm->userpg;
> > > +	u64 result;
> > > +
> > > +	__asm__ __volatile__(
> > > +"	ldrd    %0, %H0, [%1]"
> > > +	: "=&r" (result)
> > > +	: "r" (&pc->aux_head), "Qo" (pc->aux_head)
> > > +	);
> > > +
> > > +	return result;
> > > +}
> > 
> > Hi Leo,
> > 
> > I see that this is a duplicate of the atomic read in arch/arm/include/asm/atomic.h
> 
> Exactly.
> 
> > For x86, it's possible to include tools/include/asm/atomic.h, but that doesn't
> > include arch/arm/include/asm/atomic.h and there are some other #ifdefs that might
> > make it not so easy for Arm. Just wondering if you considered trying to include the
> > existing one? Or decided that it was easier to duplicate it?
> 
> Good finding!
> 
> With you reminding, I recognized that the atomic operations for
> arm/arm64 should be improved for user space program.  So far, perf tool
> simply uses the compiler's atomic implementations (from
> asm-generic/atomic-gcc.h) for arm/arm64; but for a more reliable
> implementation, I think we should improve the user space program with
> architecture's atomic instructions.

No we should not. Sometimes, what's in the kernel is for the kernel's
use only, and not for userspace's use. That may be because what works
in kernel space does not work in userspace.

For example, the ARMv6+ atomic operations can be executed in userspace
_provided_ they are only used on memory which has an exclusive monitor.
They can't be used on anything that is not "normal memory". Prior to
ARMv6, the atomic operations rely on disabling interrupts. That
facility is simply not available to userspace, so these must not be
made available to userspace.

The same applies to bitops.

We've been here before in the past, when the kernel headers were not
separated from the user ABI headers, and people would write programs
that included e.g. bitops.h on x86 because they had optimised bitops
code. This made the userspace programs very non-portable - without
re-implementing userspace versions of this stuff in every userspace
program that did this stuff.

So no, having experienced the effects of this kind of thing in the
past, the kernel should _not_ export architecture specific code in
header files to userspace.

Also, it should be pointed out that by doing so, you create a licensing
issue. If the code is GPLv2, and you build your program such that it
incorporates GPLv2 code, then if the userspace program is not GPLv2
compliant, you have a licensing problem, and in effect the program
can be distributed.

Please do not go down this route.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

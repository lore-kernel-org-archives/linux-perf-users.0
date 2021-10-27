Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF9AC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF17260F70
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhJ0MX2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:23:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237238AbhJ0MX1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 08:23:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10D541FB;
        Wed, 27 Oct 2021 05:21:02 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.72.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 360BE3F73D;
        Wed, 27 Oct 2021 05:20:59 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:20:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 0/5] arm64 userspace counter support
Message-ID: <20211027122056.GD54628@C02TD0UTHF1T.local>
References: <20211019231907.1009567-1-robh@kernel.org>
 <20211026131039.GC34073@C02TD0UTHF1T.local>
 <CAL_Jsq+JLcWESzGzjsmrir+gCFEO88YMYdj+FOBhjZgSBNOeVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+JLcWESzGzjsmrir+gCFEO88YMYdj+FOBhjZgSBNOeVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Oct 26, 2021 at 08:34:35AM -0500, Rob Herring wrote:
> On Tue, Oct 26, 2021 at 8:10 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Oct 19, 2021 at 06:19:02PM -0500, Rob Herring wrote:
> > > Another version of arm64 userspace counter access support.
> > >
> > > The arm64 support departs from the x86 implementation by requiring the user
> > > to explicitly request user access (via attr.config1) and only enables access
> > > for task bound events. Since usage is explicitly requested, access is
> > > enabled at perf_event_open() rather than on mmap() as that greatly
> > > simplifies the implementation. Rather than trying to lock down the access
> > > as the x86 implementation has been doing, we can start with only a limited
> > > use case enabled and later expand it if needed.
> > >
> > > I've run this version thru Vince's perf tests[13] with arm64 support added.
> > > I wish I'd found these tests sooner...
> >
> > When you say "with arm64 support added", do you mean with patches not
> > yet upstreamed?
> 
> Correct.

Did that require significant changes? I'd like to be able to run the
tests locally if possible.

> > I took a look at the upstream repo, and there's some existing RDPMC
> > support even though upstream never previously supported userspace
> > access. That support code uses PMSELR_EL0, which this series adds no
> > provisions for.
> >
> > Kernel-side, we'll need to either:
> >
> > * Document that PMSELR_EL0 is unreliable, and explcitly zero it within
> >   the kernel such that it cnanot be used as a covert channel. Get the
> >   tests updated to not rely on the never-previously-supported use of
> >   PMSELR_EL0.
> >
> > * Context switch PMSELR_EL0 (which'll IIUC is unreliable for big.LITTLE,
> >   even where the registers exist on each CPU).
> 
> Whether we support userspace using PMSELR_EL0 or not, we just need to
> zero it when userspace access is enabled (like the dirty counters).

Sure; doing that in armv8pmu_enable_user_access() makes sense to me,
given it's not exposed to userspace otherwise, and the kernel itself
doesn't care.

If we do that, I think that we should document that it may be zero'd
arbitrarily from userspace's PoV. That should only need a sentence or
two in the documentation added in the final patch.

Thanks,
Mark.

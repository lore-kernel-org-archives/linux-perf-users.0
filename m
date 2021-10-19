Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE7CC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 15:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34386108E
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 15:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhJSPau (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:30:50 -0400
Received: from foss.arm.com ([217.140.110.172]:50456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhJSPat (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 11:30:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44BC32F;
        Tue, 19 Oct 2021 08:28:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE80B3F694;
        Tue, 19 Oct 2021 08:28:33 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:28:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 4/5] arm64: perf: Enable PMU counter userspace access
 for perf event
Message-ID: <20211019152831.GB4938@lakrids.cambridge.arm.com>
References: <20210914204800.3945732-1-robh@kernel.org>
 <20210914204800.3945732-5-robh@kernel.org>
 <20211014165810.GA39276@lakrids.cambridge.arm.com>
 <CAL_Jsq+OO3cbnsX6OdgKSL+3c8mn=KzanTJBePk-eA1J304uFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+OO3cbnsX6OdgKSL+3c8mn=KzanTJBePk-eA1J304uFA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Rob,

On Thu, Oct 14, 2021 at 02:24:46PM -0500, Rob Herring wrote:
> On Thu, Oct 14, 2021 at 11:58 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Sep 14, 2021 at 03:47:59PM -0500, Rob Herring wrote:
> > For the `config1 = 3` case (potentially) overriding the usual long
> > semantic, I'm struggling to understand why we need that rather than
> > forcing the use of a 64-bit counter, because in that case:
> >
> > * For a CPU_CYCLES event:
> >   __armv8_pmuv3_map_event() will always pick 64-bits
> >   get_event_idx() may fail to allocate a 64-bit counter.
> >
> > * For other events:
> >   __armv8_pmuv3_map_event() will pick 32/64 based on long counter
> >   support
> >   get_event_idx() will only fail if there are no counters free.
> >
> > Whereas if __armv8_pmuv3_map_event() returned an error for the latter
> > when long counter support is not implemented, we'd have consistent
> > `long` semantics, and the CPU_CYCLES behaviour would be identical.
> >
> > What's the rationale for `3` leaving the choice to the kernel?
> 
> It's the give me the maximum sized counter the h/w can support choice.
> That's easier for userspace to implement. Bit 1 is more of a hint that
> the user wants userspace access rather than a requirement.
> 
> > If the problem is discoverability, I'd be happy to add something to
> > sysfs to describe whether the PMU has long event support.
> 
> Checking sysfs or a try for 64-bit support then fall back to 32-bit
> support isn't much difference.
> 
> Keep in mind that x86 always succeeds here. Every userspace user will
> have to add whatever dance we create here. For example, each libperf
> test with user access (there's only 2 in my tree, but there's a series
> adding more) has to have an '#ifdef __aarch64__' for whatever we do
> here. I was seeking to minimize that. Right now, that's just a set
> config1 to 0x3. Also, note that libperf will opportunistically use a
> userspace read instead of read(). The user just has to mmap the event
> and libperf will use a userspace read when enabled which ultimately
> depends on what the mmapped page says.

I think that x86 always succeeding here is more of a legacy thing that
they're stuck with rather than a design to be copied.

I'd prefer to keep the existing meaning of the `long` flag to mean "give
me 64 bits of counter, somehow", with `rdpmc` meaning "give me a single
counter I can access from userspace", even if that means the combination
of the two can sometimes be rejected. As you say, we can probe for that
as necessary by trying `long` then falling back to a plain event, and if
that ends up being a bottleneck somehow we can figure out a way of
advertising support to userspace. Regardless, we should 

Importantly, I don't think libperf should override a user's request for
`long`, since the user may want to optimize for minimal perturbation
rather than faster access.

If we want a "please give me the longest counter that's compatible with
other constraints", I think that should be a new flag e.g. `trylong`,
and shouldn't override the existing `long`. We can add that as a
follow-up if we want it.

Thanks,
Mark.

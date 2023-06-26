Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC1EB64D7
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 16:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjFZQL4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFZQLu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 12:11:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BABE48
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 09:11:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b520329adeso251155ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687795897; x=1690387897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUpK/FesKqMENV8Lp1Bpn5fG0Rycj/A9sGOJzazt60g=;
        b=2SGAdpMYFO2GYOYhdprBSPelJ2SwI6wK7MeheKmG4Phk0C8o779XGeGAd+TzppXg3/
         xCfkO0KbZj22BBrp8j7k3h5BlzRspMUf2SOD0AtmKUDcbrF9dlLIS63pnmApdPWZIBbV
         Xk9bz39k7iciEt4fSs0D4EwQcUzzJcuWT0nNEfz4QcdbfWUERBPo6nUfPCAMJzT2qB3i
         vnRwbAOTToFM7JH8DqK6Hri8L4fX5lZaed9kTzOq554VY4iS+m0YRiPmXnXzGD/0K5+r
         DDu53xRunTc9dohT4TeuVnNiYZ8aeleAHOOxCeEjb+ULt+3wCg3d26ivdo+2ozvlbFfB
         NmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795897; x=1690387897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUpK/FesKqMENV8Lp1Bpn5fG0Rycj/A9sGOJzazt60g=;
        b=RfsDrxBOAcyAJeaJU4/mYnxFuZaECz1Pc6FpfRRz9kBG+yyAletXSFssqoUipjUpny
         H+Kw1vg6GVbNxukCWT7FOYhGxBWV0ni2s8weNQqPdOOenVt2uuB+q+e7HbA4G7qaAiK1
         258dtZCDrXUILVNvtIo7nSpyAAwofpZxgM+QkYnkpBcy8KfaysSSlDEap6P7DCCwBMbw
         dE5JXr/zJwZ+cnzVaSljhEixLe99NjYQ1Kn0ng7GbdfyfKyw+0KAwaodwxbs0suniivV
         at8LysZzNn7HWlverRcdnde8nidzdouG+djzEgR5E6Ht2kToml41WlSivSqeGS04iGfX
         IvxQ==
X-Gm-Message-State: AC+VfDzd2gqeU+z9DljjrLEJYgs8YJWet0yOOseU7wqoiuA6os17MsVb
        HCG5foUZQHJSivUTyL/u8yDyovYAWEC8lNcbVqPiJA==
X-Google-Smtp-Source: ACHHUZ4wCUwjtnjlBAP6350IJkr+7MVseDsx3rKsMgKqbhq7kdQBbTI/1dHfCcVl7ROAsuQ8/kgGGh6tkXQIXYNzbQo=
X-Received: by 2002:a17:902:c44a:b0:1a9:bb1d:64e with SMTP id
 m10-20020a170902c44a00b001a9bb1d064emr1942727plm.15.1687795896773; Mon, 26
 Jun 2023 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com> <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <20230626123249.GC19941@willie-the-truck> <57ea7d37-83bd-80ba-3342-93598a88ac20@arm.com>
 <20230626150945.GA20321@willie-the-truck>
In-Reply-To: <20230626150945.GA20321@willie-the-truck>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 26 Jun 2023 09:11:25 -0700
Message-ID: <CAP-5=fWf+Ts93StWaiaqdkcgVkjnBR9nFsR=4yKG8R9LpdUNFw@mail.gmail.com>
Subject: Re: perf-tools-next: Request for testing hybrid changes
To:     Will Deacon <will@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Namhyung Kim <namhyung@gmail.com>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 26, 2023 at 8:09=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi James,
>
> On Mon, Jun 26, 2023 at 03:39:00PM +0100, James Clark wrote:
> > On 26/06/2023 13:32, Will Deacon wrote:
> > > What does PERF_PMU_CAP_EXTENDED_HW_TYPE buy us on Arm, given that we'=
ve
> > > supported heterogeneous PMUs for years without issues? In other words=
,
> > > what is the benefit of supporting two user ABIs here?
> > >
> > Aren't there some issues around per-process perf sessions and choosing
> > which PMU to use?
> >
> > For example on Juno if I run perf on one of the big cores (1 and 2),
> > then I only get an accurate cycle count if the process I'm interested i=
n
> > also runs on a big core:
> >
> >   taskset --cpu-list 1 perf stat -e cycles -- taskset \
> >    --cpu-list 1 stress -c 1 -t 1
> >
> >   1087015046      cycles:u
> >
> > If the stress process runs on a small core (4 for example) then I get a
> > much lower count, which I think is only accounting for the taskset
> > before it finishes pinning stress to the small core:
> >
> >   taskset --cpu-list 1 perf stat -e cycles -- taskset \
> >     --cpu-list 4 stress -c 1 -t 1
> >
> >   68134032      cycles:u
> >
> > Then if perf starts on a small core it gets even worse, you never get
> > any cycle counts, even if stress runs on the same core:
> >
> >   taskset --cpu-list 0 perf stat -e cycles -- taskset \
> >     --cpu-list 0 stress -c 1 -t 1
> >
> >   <not counted>      cycles:u
> >
> > I'm not sure how many of these are just the perf tool doing the wrong
> > thing and should be fixed in other ways than using
> > PERF_PMU_CAP_EXTENDED_HW_TYPE. But there is also something to be said
> > for consistency that if PERF_PMU_CAP_EXTENDED_HW_TYPE is already
> > understood by the tool as a way to use different PMU types then
> > supporting it on Arm might make sense.
>
> I think the above is just an example of how the ABIs differ and doesn't
> reflect a limitation of either, no? In other words, if you drive it wrong=
,
> then yes, you get the wrong result. That's the same with any heterogeneou=
s
> system. I agree that consistency is great, but we've been exposing
> heterogeneous PMUs on arm for what, a decade now? It feels a little
> disingenuous to say we should be consistent with something that's this
> hot off the press.

55bcf6ef314a perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
Date:   Mon Apr 12 07:31:01 2021 -0700
https://lore.kernel.org/all/1618237865-33448-22-git-send-email-kan.liang@li=
nux.intel.com/

> Anyway, my main question is still largely unanswered: what does the new
> ABI gain us over what we have? Is it documented somewhere?

I'm not sure why you see this as a new ABI? There are 32-bits in the
perf_event_attr config that now hold the extended type information
which were unused and erroneous if used previously. These bits just
clear up ambiguity for the legacy event types about which PMU is being
requested when perf events are associated with a task. There are IIRC
62 legacy hardware/hardware-cache events with hard coded PMU type
numbers. The perf tool will use these in preference to other events
and are used when no events/metrics are requested of the perf tool.
The extended type is described in the uapi perf_event.h, it probably
also makes sense to add man page documentation.

> For example,
> how does it handle things like:
>
>   - Different number of hardware counters across CPU types

This is unchanged. If you open a legacy say "cycles" event on CPU0 and
then use the raw/dynamic type to open other events, those events will
go into a perf hardware context and can multiplex when the counters
are all used.

>   - An event that might not be supported across different CPU types

This happens but is only detected for the hardware-cache events. The
ARM PMUs are already handling this, they just are unable to handle it
in per-thread mode.

>   - Events that might collide across CPU types (e.g. raw events that have
>     the same encoding but count something different)

This happens with homogeneous PMUs too. There's nothing special in the
kernel/tool to merge such events, if you use enough of them you'll get
multiplexing. It is a case of buyer beware.

> From what I can tell, the main difference between the interfaces seems to
> be the level of resourcing that Intel and Arm have each put into the
> tooling, and I don't think that's a particularly compelling reason to
> take on the burden of maintaining both in the kernel. However, if there
> are functional benefits with PERF_PMU_CAP_EXTENDED_HW_TYPE over what we'v=
e
> been doing them I'm keen to hear about them.

The benefits are that currently the perf tool is broken* for ARM
heterogeneous PMUs. Specifically, perf will open events "instructions"
or "cycles" for a benchmark like:

$ perf stat -e cycles benchmark

and the cycles event will be opened for the PMU of the current CPU the
perf tool happens to be running on. It won't be opened on the other
PMU. This means perf is only counting some fraction of the event.

At this point adding the capability to the PMU has been in the kernel
for over 2 years. On the user side Intel hardcoded support for their
CPUs and I recently tried to make this into something generic.
Unfortunately in making this generic I've discovered the extended type
bit was never added to ARM PMUs. This means that rather than open a
single event the perf tool is opening say the cycles event twice, but
because the extended type information causes errors on ARM we don't
encode that yielding the same event opened twice on the PMU of the CPU
that perf happens to be running on. I believe users with heterogeneous
ARM PMUs aware of the problem have been avoiding the legacy events, is
this something you are expecting the tool to do too? For example:

$ perf record benchmark

Will open the cycles event for the threads of benchmark. With extended
type information we open a cycles event on each PMU, but without it
we're only sampling on a fraction of the PMUs. Should the tool turn
cycles on ARM into an ARM architecture standard event? Which event and
who will write/test the mapping code? The problem is finite (there are
only 62 events) and there are no time machines, perhaps if there were
we wouldn't have the legacy events at all. The PMU driver change looks
about as small as it can be, adding a bit to the capabilities of the
PMU. I have no way to test such a change and it doesn't resolve the
problem for older kernels on the perf tool.

Thanks,
Ian

* I don't have an ARM system with heterogeneous PMUs to confirm this,
I'm inferring from the code and some tests Arnaldo ran on a system of
his.

> Will

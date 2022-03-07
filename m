Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4E2C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Mar 2022 17:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbiCGRPU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiCGRPN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Mar 2022 12:15:13 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A38F98B
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Mar 2022 09:14:12 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i1so12058556ila.7
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Mar 2022 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PZO7BlSvQ2CMXZRxRNSrRW3q5cQaXS0t4QCakAKtxug=;
        b=PwlIMQgahOLN2AaQnTINH7mJVI6CCcdtkTiQQCb9xRushP4xEF1ODKTeJcag4CUsAP
         3dVYXrAmSb6PXJH5M6vSs/wgg/feFffHYvnzKFsaUsw+3WY4QGbraWdwH41+Yj5WNdXu
         /QWCbEzmxBPf+JUGZWiJTGoYSUF+9TiLtb2BfPLIohQ0yaNC2SW3V4Tobmq25xSVHg7j
         +oQlvRtdHiGw9fv+5YF0elfvwyEt42nLhYfQY7P+fUCiPV4SgsBGMhj6iLZn9Vafr+C6
         Lk0QGG3/Y2IvFfpNOoqJUtkG9/jzFscBRQPz913XMOAIl6OVGKD01LgQ2YS5fYdDxyKy
         ewYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZO7BlSvQ2CMXZRxRNSrRW3q5cQaXS0t4QCakAKtxug=;
        b=G7IIzQg6o6K5XjCxsQ6UgrkE8q6eOM3UBEImdHOG61ub8rHKPZu0P/8C5kwgRPvlkO
         JeVVijBatdJug7kBAqHbkErZjERoVf5ebG0Y3Hv8at9qj6GrHujT/mKikcbVaP1b0/A5
         nBTE77jG/Nu6C4bfrh5xDGAQAucu8BLBRk4k8gSjCyDEbBDlA4HiRcMiKPTqrwt4dbO4
         HwfhaQSKjeELRt1UxufvU1VWe3a8gILOlqHxqMJFy+E/mCPobS4iSglnugncT0fhMtgM
         mOwffCEnESEQiW35WH3MMnqyH8dUidNA/pKo0N40k7JXF7RaSMT3Z90f/7X2l5k+hB1w
         37NQ==
X-Gm-Message-State: AOAM533EoTK3P0NXfeIuLcf3HTWw4NPHPJaTjCdBjsfPU8YGy7mkeCqN
        NOl0AaZ3iYN9CJUmbSkj1tpqzrrr+2KNxGF9J4YBvg==
X-Google-Smtp-Source: ABdhPJxofQEFYoDiEKbewDndUjMLmy81gCcsmMiI3CRQgAcvoUKefQduUg5b2Cswuh+NFz6M4fgCBDuxnupvWhSB2oc=
X-Received: by 2002:a05:6e02:1646:b0:2c6:5059:9aaa with SMTP id
 v6-20020a056e02164600b002c650599aaamr1860386ilu.102.1646673251291; Mon, 07
 Mar 2022 09:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com> <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com>
In-Reply-To: <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 7 Mar 2022 09:14:00 -0800
Message-ID: <CABPqkBQTkfofi0-92iMRSfgZDHwCxpOD0GmhvAtOruhO=M1gKg@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Mar 6, 2022 at 6:36 AM Wen Yang <wenyang@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2022/3/4 =E4=B8=8B=E5=8D=8811:39, Peter Zijlstra =E5=86=99=E9=
=81=93:
> > On Fri, Mar 04, 2022 at 07:03:51PM +0800, Wen Yang wrote:
> >> this issue has been there for a long time, we could reproduce it as fo=
llows:
> >
> > What issue? You've not described an issue. So you cannot reference one.
> >
>
> OK, thank you for your opinion. Let's explain it.
>
>
> > This is still completely unreadable gibberish.
> >
> >> 1, run a script that periodically collects perf data, eg:
> >> while true
> >> do
> >>      perf stat -e cache-misses,cache-misses,cache-misses -c 1 sleep 2
> >>      perf stat -e cache-misses -c 1 sleep 2
> >>      sleep 1
> >> done
> >>
> >> 2, run another one to capture the ipc, eg:
> >> perf stat -e cycles:d,instructions:d  -c 1 -i 1000
> >
> > <snip line noise>
> >
> >> the reason is that the nmi watchdog permanently consumes one fp
> >> (*cycles*). therefore, when the above shell script obtains *cycles*
> >> again, only one gp can be used, and its weight is 5.
> >> but other events (like *cache-misses*) have a weight of 4,
> >> so the counter used by *cycles* will often be taken away, as in
> >> the raw data above:
> >> [1]
> >>    n_events =3D 3
> >>    assign =3D {33, 1, 32, ...}
> >> -->
> >>    n_events =3D 6
> >>    assign =3D {33, 3, 32, 0, 1, 2, ...}
> >
> > Again unreadable... what do any of those numbers mean?
> >
>
> Scenario: a monitor program will monitor the CPI on a specific CPU in
> pinned mode for a long time, such as the CPI in the original email:
>      perf stat -e cycles:D,instructions:D  -C 1 -I 1000
>
> Perf here is just an example. Our monitor program will continuously read
> the counter values of these perf events (cycles and instructions).
>
> However, it is found that CPI data will be abnormal periodically because
> PMU counter conflicts. For example, scripts in e-mail will cause
> interference:
>      perf stat -e cache-misses,cache-misses,cache-misses -C 1 sleep 2
>      perf stat -e cache-misses -C 1 sleep 2
>
>    n_events =3D 3
>    assign =3D {33, 1, 32, ...}
> -->
>    n_events =3D 6
>    assign =3D {33, 3, 32, 0, 1, 2, ...}
>
> They are some fields of cpu_hw_events structure.
> int n_events; /* the # of events in the below arrays */
> int assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
> struct perf_event *event_list[X86_PMC_IDX_MAX]; /* in enabled order */
>
> 32: intel_pmc_idx_fixed_instructions
> 33: intel_pmc_idx_fixed_cpu_cycles
> 34: intel_pmc_idx_fixed_ref_cycles
> 0,1,2,3: gp
>
>
> n_events =3D 3
> assign =3D {33, 1, 32, ...}
> event_list =3D {0xffff88bf77b85000, 0xffff88b72db82000,
> 0xffff88b72db85800, ...}
>
> =E2=80=94>
> Indicates that there are 3 perf events on CPU 1, which occupy the
> #fixed_cpu_cycles, #1 and #fixed_instruction counter one by one.
> These 3 perf events are generated by the NMI watchdog and the script A:
> perf stat -e cycles:D,instructions:D  -C 1 -I 1000
>
>
> n_events =3D 6
> assign =3D {33, 3, 32, 0, 1, 2, ...}
> event_list =3D {0xffff88bf77b85000, 0xffff88b72db82000,
> 0xffff88b72db85800, 0xffff88bf46c34000, 0xffff88bf46c35000,
> 0xffff88bf46c30000,  ...}
>
> =E2=80=94>
> Indicates that there are 6 perf events on CPU 1, which occupy the
> #fixed_cpu_cycles, #3, #fixed_instruction, #0, #1 and #2 counter one by o=
ne.
> These 6 perf events are generated by the NMI watchdog and the script A
> and B:
> perf stat -e cycles:D,instructions:D  -C 1 -I 1000
> perf stat -e cache-misses,cache-misses,cache-misses -C 1 sleep 2
>
> 0xffff88bf77b85000:
> The perf event generated by NMI watchdog, which has always occupied
> #fixed_cpu_cycles
>
> 0xffff88b72db82000:
> The perf event generated by the above script A (cycles:D), and the
> counter it used changes from #1 to #3. We use perf event in pinned mode,
> and then continuously read its value for a long time, but its PMU
> counter changes, so the counter value will also jump.
>
What you are describing here is working as expected. Pinning an event DOES =
NOT
mean pinning the event to a counter for the whole measurement. It
means the event
will always be measured on "a" counter. But that counter can change
overtime. Moving
the event to a different counter SHOULD NOT change its value assuming
you use official
API to read the counter, i.e., the read() syscall or rdpmc using the
official guideline for it.

>
>
> 0xffff88b72db85800:
> The perf event generated by the above script A (instructions:D), which
> has always occupied #fixed_instruction.
>
> 0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000:
> Theses perf events are generated by the above script B.
>
>
> >>
> >> so it will cause unnecessary pmu_stop/start and also cause abnormal cp=
i.
> >
> > How?!?
> >
>
> We may refer to the x86_pmu_enable function:
> step1: save events moving to new counters
> step2: reprogram moved events into new counters
>
> especially:
>
> static inline int match_prev_assignment(struct hw_perf_event *hwc,
>                      struct cpu_hw_events *cpuc,
>                      int i)
> {
>      return hwc->idx =3D=3D cpuc->assign[i] &&
>          hwc->last_cpu =3D=3D smp_processor_id() &&
>          hwc->last_tag =3D=3D cpuc->tags[i];
> }
>
>
>
> >> Cloud servers usually continuously monitor the cpi data of some import=
ant
> >> services. This issue affects performance and misleads monitoring.
> >>
> >> The current event scheduling algorithm is more than 10 years old:
> >> commit 1da53e023029 ("perf_events, x86: Improve x86 event scheduling")
> >
> > irrelevant
> >
>
> commit 1da53e023029 ("perf_events, x86: Improve x86 event scheduling")
>
> This commit is the basis of the perf event scheduling algorithm we
> currently use.
> The reason why the counter above changed from #1 to #3 can be found from =
it:
> The algorithm takes into account the list of counter constraints
> for each event. It assigns events to counters from the most
> constrained, i.e., works on only one counter, to the least
> constrained, i.e., works on any counter.
>
> the nmi watchdog permanently consumes one fp (*cycles*).
>   therefore, when the above shell script obtains *cycles:D*
> again, it has to use a GP, and its weight is 5.
> but other events (like *cache-misses*) have a weight of 4,
> so the counter used by *cycles:D* will often be taken away.
>
And that 's normal. Measuring cycles on a generic counter or fixed
counter does not
change what is counted or the precision of it.

>
> In addition, we also found that this problem may affect NMI watchdog in
> the production cluster.
> The NMI watchdog also uses a fixed counter in fixed mode. Usually, it is
> The first element of the event_list array, so it usually takes
> precedence and can get a fixed counter.


Not true. The NMI watchdog does not request a fixed counter. There is
no way to do this.
It just lands on the fixed counter because the scheduling algorithm
favors fixed counters whenever
possible.

>
> But if the administrator closes the watchdog first and then enables it,
> it may be at the end of the event_list array, so its expected fixed
> counter may be occupied by other perf event, and it can only use one GP.
> In this way, there is a similar issue here: the PMU counter used by the
> NMI watchdog may be disabled/enabled frequently and unnecessarily.
>
Yes, and I don't think this is a problem.
You are trying to get counter guarantee but the interface DOES NOT
give this to users
and should not in my opinion.

>
> Any advice or guidance on this would be appreciated.
>
> Best wishes,
> Wen
>
>
> >> we wish it could be optimized a bit.
> >
> > I wish for a unicorn ...
> >
> >> The fields msk_counters and msk_events are added to indicate currently
> >> used counters and events so that the used ones can be skipped
> >> in __perf_sched_find_counter and perf_sched_next_event functions to av=
oid
> >> unnecessary pmu_stop/start.
> >
> > Still not sure what your actual problem is, nor what the actual proposa=
l
> > is.
> >
> > Why should I attempt to reverse engineer your code without basic
> > understanding of what you're actually trying to achieve?
> >
>
>
>

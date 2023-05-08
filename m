Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D01C77B7F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 May 2023 15:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjEHPxE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 May 2023 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjEHPxB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 May 2023 11:53:01 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C1F6A74
        for <linux-perf-users@vger.kernel.org>; Mon,  8 May 2023 08:52:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-61b6101a166so22972986d6.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 May 2023 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683561172; x=1686153172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7an4MsU+A1D/BiDTLfn7jyyo8mReHeEE9qn6uLYEhzQ=;
        b=iev3QowJREAXZwKMJICO1a0zso2V9KUeFQ4vy/ejLkNpxaVxWp8A3fWhXxtjPv3HoS
         COXG1eyx4OodhQbKYeN3Iaky3jOuEFObCpnGIL5TU/RlDbZtrO8s8KRjFUAoGuVh9Fp6
         twFcD8XhAJF7/EkslM+xS9/68RNhljZ7fb0eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561172; x=1686153172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7an4MsU+A1D/BiDTLfn7jyyo8mReHeEE9qn6uLYEhzQ=;
        b=kPD39FMHudyn0tm+coBySyytNtiraTqmjnqS1UsAiVVuP0RU2v9IRAEfKk0crc4juH
         QU0lUAMYLUNP2uJ0c9zBxKpxN2pdMKIoVpuCSStRTwP1cIqU23VrodvJqhjH5FUSTBDi
         s3xmXQ3AtDkAuPtQJG6wRJtVweR0PjG3V+IpsrLFTd5XcXY+HRyRlkdQ9ToqEn8DNdyc
         whPifOGcltwvlR78jXzU/r06yYvtBe3+Hhed8gotu1v2CBXCKScEpC/eV3DIyZxov9MU
         BNtn5YLVWLvuS+CZAzTw3shkFOUqrE3Cob4Z9eWVyhlev5urk00Rh/qvGIdbgARjdDk9
         d37w==
X-Gm-Message-State: AC+VfDw3Zi8fjky6l+Jv1nJR4EXmU6NIp/M0UEIs4KI4rShlmrZQ3pND
        pjBiExSG0LUN3zFV+uOiovCtuvD/HiXQo+4goGo=
X-Google-Smtp-Source: ACHHUZ4iZIwd60RnyKLrd3wyp88i2WyxDxMpQtOI0fix1l2vCVJ1XBSYR7UqfIuE/ukoqeI4RK6EOw==
X-Received: by 2002:ad4:5761:0:b0:56a:d94d:6deb with SMTP id r1-20020ad45761000000b0056ad94d6debmr19266888qvx.25.1683561171305;
        Mon, 08 May 2023 08:52:51 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id ph1-20020a0562144a4100b005ed90bf69efsm54252qvb.114.2023.05.08.08.52.47
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 08:52:47 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1485071cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 May 2023 08:52:47 -0700 (PDT)
X-Received: by 2002:ac8:57c9:0:b0:3ef:3083:a437 with SMTP id
 w9-20020ac857c9000000b003ef3083a437mr518031qta.18.1683561166909; Mon, 08 May
 2023 08:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CSDZSKA38AEF.FY7J3JXBJX4I@wheely> <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
 <CSGHQJAJHWVS.1UAJOF8P5UXSK@wheely>
In-Reply-To: <CSGHQJAJHWVS.1UAJOF8P5UXSK@wheely>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 May 2023 08:52:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
Message-ID: <CAD=FV=WEp23wDm2=cFO66uSjqw1UfYSczGSrQh32DGiqHnUDkg@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, linuxppc-dev@lists.ozlabs.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Colin Cross <ccross@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Sun, May 7, 2023 at 6:05=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>
> > No, I wasn't aware of it. Interesting, it seems to basically enable
> > both types of hardlockup detectors together. If that really catches
> > more lockups, it seems like we could do the same thing for the buddy
> > system.
>
> It doesn't catch more lockups. On powerpc we don't have a reliable
> periodic NMI hence the SMP checker. But it is preferable that a CPU
> detects its own lockup because NMI IPIs can result in crashes if
> they are taken in certain critical sections.

Ah, interesting. Is the fact that NMI IPIs can crash the system
something specific to the way they're implemented in powerpc, or is
this something common in Linux? I've been assuming that IPI NMIs would
be roughly as reliable (or perhaps more reliable) than the NMI
timer/perf counter.


> > > It's all to
> > > all rather than buddy which makes it more complicated but arguably
> > > bit better functionality.
> >
> > Can you come up with an example crash where the "all to all" would
> > work better than the simple buddy system provided by this patch?
>
> CPU2                     CPU3
> spin_lock_irqsave(A)     spin_lock_irqsave(B)
> spin_lock_irqsave(B)     spin_lock_irqsave(A)
>
> CPU1 will detect the lockup on CPU2, but CPU3's lockup won't be
> detected so we don't get the trace that can diagnose the bug.

Ah, that makes sense as a benefit if
"sysctl_hardlockup_all_cpu_backtrace" is false, which you'd probably
want if you had massively SMP systems. ...of course, if you had a lot
of cores then I'd imagine the "all-to-all" might become a lot of
overhead...

Hmmm, but I don't think you really need "all-to-all" checking to get
the stacktraces you want, do you? Each CPU can be "watching" exactly
one other CPU, but then when we actually lock up we could check all of
them and dump stacks on all the ones that are locked up. I think this
would be a fairly easy improvement for the buddy system. I'll leave it
out for now just to keep things simple for the initial landing, but it
wouldn't be hard to add. Then I think the two SMP systems  (buddy vs.
all-to-all) would be equivalent in terms of functionality?


Thinking about this more, I guess you must be assuming coordination
between the "SMP" and "non-SMP" checker. Specifically I guess you'd
want some guarantee that the "SMP" checker always fires before the
non-SMP checker because that would have a higher chance of getting a
stack trace without tickling the IPI NMI crash. ...but then once the
non-SMP checker printed its own stack trace you'd like the SMP checker
running on the same CPU to check to see if any other CPUs were locked
up so you could get their stacks as well. With my simplistic solution
of just allowing the buddy detector to be enabled in parallel with a
perf-based detector then we wouldn't have this level of coordination,
but I'll assume that's OK for the initial landing.


> Another thing I actually found it useful for is you can easily
> see if a core (i.e., all threads in the core) or a chip has
> died. Maybe more useful when doing presilicon and bring up work
> or firmware hacking, but still useful.

I'm probably biased, but for bringup work and stuff like this I
usually have kdb/kgdb enabled and then I could get stack traces for
whichever CPUs I want. :-P

-Doug

Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20DFC77B73
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Apr 2023 15:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDXPYZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDXPYX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2023 11:24:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB6155B3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 08:24:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760ecf3424bso107003039f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682349856; x=1684941856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQQ0l1rf0aXXyplq/mgF2Rjc0pUjLq2PlqK5LzTpLjw=;
        b=ZalHYE3Mw4KB9R4HQ4/R0eS/U6ypyMrZZX8Bk+NtAGLVuiw8mTwBRXGh24x4OVRE94
         +Cqwldaso1X+QalH8WaoBoM+vKbdNxdxcLvm15TFO6uWP9lxv6+JbFN9PUl++39AJEzI
         RUppOt3fIFb3BjHqjSNmGQJZs+ysCdE9RfKMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349856; x=1684941856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQQ0l1rf0aXXyplq/mgF2Rjc0pUjLq2PlqK5LzTpLjw=;
        b=VsjvIgAv3GQz2iH7xvjT/BZWcvmcDtZK4l0f5e6dho+a8jpiE9sf4WmYXLbw5ViQac
         l9pvZnMkJfmPV9I3cOylK6Et4BT3N52jPVyd68odsA8pyF+VzoFQNqID0DrJ29//IdGB
         mWyBHYtlhMW64ponVAwKulQhO1pzGPDmGtuCGZeBlCz0jURsuVqC1+hVdaerOGuW0xWL
         iWQmeQ3rjqwjUlHkF/YQsWFNgmBtOykru0xrcidF5nB+dYXRJ/slEX16RC5Cak49+g3Y
         QkpJf3UCoJ5Rwm0vVDkqmKWiPhQ1+QkIUsZzK+v0hFlhYs5YGo1MX7+m3vCldZwjwMHE
         dTHg==
X-Gm-Message-State: AAQBX9doqYGZy5FtquFDkCO0taqqsRgLQmKVGyL1JyPCwclTe6aZDblM
        SJHpe+OyR7BUWNt5nKGfQVqEfp4jXAoFexeIKRo=
X-Google-Smtp-Source: AKy350aqdT9QuLdyvl6ruDKZPgH8SHCed1fIXtigT1n/2d5OV4XwERzTToLBZ2tnpXYcVTvBxKK1Kw==
X-Received: by 2002:a6b:d90b:0:b0:760:e9b6:e6da with SMTP id r11-20020a6bd90b000000b00760e9b6e6damr5272947ioc.1.1682349856602;
        Mon, 24 Apr 2023 08:24:16 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id e22-20020a5d9256000000b0076356c2d1acsm3199605iol.52.2023.04.24.08.24.13
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:24:14 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-316d901b2ecso1072925ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 08:24:13 -0700 (PDT)
X-Received: by 2002:a92:ca0a:0:b0:32a:7910:6ea6 with SMTP id
 j10-20020a92ca0a000000b0032a79106ea6mr527671ils.5.1682349853334; Mon, 24 Apr
 2023 08:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CAP-5=fUB1e=bJk-w0i8+MEo4sLOZtb_Eb7FMy4u7ky7D2AZm6A@mail.gmail.com>
In-Reply-To: <CAP-5=fUB1e=bJk-w0i8+MEo4sLOZtb_Eb7FMy4u7ky7D2AZm6A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 08:23:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xuuefi9XBQA7z7sbe+Qw0=WeZ956gLGCoFGHBg6GBftg@mail.gmail.com>
Message-ID: <CAD=FV=Xuuefi9XBQA7z7sbe+Qw0=WeZ956gLGCoFGHBg6GBftg@mail.gmail.com>
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy) cpus
To:     Ian Rogers <irogers@google.com>
Cc:     ravi.v.shankar@intel.com, Andi Kleen <ak@linux.intel.com>,
        ricardo.neri@intel.com, Stephane Eranian <eranian@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Will Deacon <will@kernel.org>, ito-yuichi@fujitsu.com,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Marco Elver <elver@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Fri, Apr 21, 2023 at 6:20=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Apr 21, 2023 at 3:54=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that can be enabled on SMP systems
> > that don't have an arch provided one or one implemented atop perf by
> > using interrupts on other cpus. Each cpu will use its softlockup
> > hrtimer to check that the next cpu is processing hrtimer interrupts by
> > verifying that a counter is increasing.
> >
> > NOTE: unlike the other hard lockup detectors, the buddy one can't
> > easily provide a backtrace on the CPU that locked up. It relies on
> > some other mechanism in the system to get information about the locked
> > up CPUs. This could be support for NMI backtraces like [1], it could
> > be a mechanism for printing the PC of locked CPUs like [2], or it
> > could be something else.
> >
> > This style of hardlockup detector originated in some downstream
> > Android trees and has been rebased on / carried in ChromeOS trees for
> > quite a long time for use on arm and arm64 boards. Historically on
> > these boards we've leveraged mechanism [2] to get information about
> > hung CPUs, but we could move to [1].
> >
> > NOTE: the buddy system is not really useful to enable on any
> > architectures that have a better mechanism. On arm64 folks have been
> > trying to get a better mechanism for years and there has even been
> > recent posts of patches adding support [3]. However, nothing about the
> > buddy system is tied to arm64 and several archs (even arm32, where it
> > was originally developed) could find it useful.
> >
> > [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.=
org
> > [2] https://issuetracker.google.com/172213129
> > [3] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lec=
opzer.chen@mediatek.com/
>
> There is another proposal to use timers for lockup detection but not
> the buddy system:
> https://lore.kernel.org/lkml/20230413035844.GA31620@ranerica-svr.sc.intel=
.com/
> It'd be very good to free up the counter used by the current NMI watchdog=
.

Thanks for the link!

Looks like that series is x86 only, so I think that ${SUBJECT} patch
should still move forward since it provides a solution that is generic
across any platform. I guess the question is: if the buddy system gets
landed then is the HPET series still worthwhile? I guess the answer to
that would depend on whether the HPET-based watchdog has any
advantages over the buddy system.

I'd imagine that there could be some cases where the HPET system could
detect lockups that the buddy system can't. If _all_ CPUs in the
system have interrupts disabled then the buddy system won't be able to
run, but the HPET system could run. That's a win for the HPET system.
That being said, I guess I could imagine that there could be lockups
that the buddy system could detect that the HPET system couldn't. The
HPET system seems to have a single CPU in charge of processing the
main NMI and then that single CPU is in charge of checking all the
others. If that single CPU goes out to lunch then the system couldn't
detect hard lockups.

In any case, I'm happy to let others debate about the HPET system. For
now, I'll take my action items to be:

1. Modify the patch description and KConfig to include some of the
same advantages that the HPET patch series talks about (freeing up
resources).

2. Increase my CC list for the next version even more to include the
people you added to this thread who have been working on the HPET
patch series.

-Doug

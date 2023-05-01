Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F9C77B73
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 May 2023 14:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjEAOFH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 May 2023 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAOFG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 May 2023 10:05:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5711B7
        for <linux-perf-users@vger.kernel.org>; Mon,  1 May 2023 07:05:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50a14564d17so39885392a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 May 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682949903; x=1685541903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz6FJXzkJkqPDcrEIjMfZPfzlnpS0r8oHDAuwuJCMM8=;
        b=dhYWbUYPPk2jVkyznNfyoYMQOnEvFsCXYywYgNl+WvGgtHMmkHQ9tp5StpFkaewAHR
         sRgjkmEDf/oaYTzoN+mFfa9YMPOvLJzUmw8U78cFcW1457uDsyanGycGgTJkf4FPJ8gs
         qhbBjZlLPxZkowA4xmaZMZUO4OmRQ3BtjuygM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682949903; x=1685541903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz6FJXzkJkqPDcrEIjMfZPfzlnpS0r8oHDAuwuJCMM8=;
        b=FlDkplTdkelqTh6eCGTt5sd2aIDM7KSIwKuNJmlWigQlxp6Q2MZ2lTMMuRPIWOdwPj
         UfWcbOqZ719hk2bQUBtWWAIzbWPiEpHN+7e2rwPAZhJxKhMEjiSyeqN/pX2d8T/tcKgN
         MXCuxBJxV5eqrL5nXV+1KcABQ7KUTG3O05SG/BONuhgpivU1DL3K3A4lOPc1HY0wSW/Y
         Xgl1MpQL2cmX6ZxrN7vrlFmiTOw+vxHqryIPqClznSQiZS6z4QLyAPeUgXIlofmWuNZ5
         leQpIokSA66BPEWYmGzcQWufKVzsjE8w5uyVpJKUlhKDGh26kOMIcpUBe4Ler0Rx1sjU
         UTWA==
X-Gm-Message-State: AC+VfDwamMbsdcC1pElYfQOvNLny6kzDEftKhyut7218tO2Vasjxf3Yi
        X0mpVltvWoD/lFZxnXZ+Kox0Ns8Oh16+rweD+ZR+Uw==
X-Google-Smtp-Source: ACHHUZ4eE1XHP3MS7Ms8caitttINZrqkYrciZKkySGwTZz6P7XQz4+oWumTIz2Fs/JYVlU1+HGFppw==
X-Received: by 2002:a17:907:988:b0:933:4d47:55b7 with SMTP id bf8-20020a170907098800b009334d4755b7mr11657929ejc.2.1682949903075;
        Mon, 01 May 2023 07:05:03 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b0094e96e46cc0sm14745987ejz.69.2023.05.01.07.04.59
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 07:04:59 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f256b84f14so277915e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 May 2023 07:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3c84:b0:3f1:9396:6fbf with SMTP id
 bg4-20020a05600c3c8400b003f193966fbfmr531828wmb.4.1682949899295; Mon, 01 May
 2023 07:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230428163507.v2.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <217e697c-ad13-96ca-3829-a046469fd86a@infradead.org>
In-Reply-To: <217e697c-ad13-96ca-3829-a046469fd86a@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 May 2023 07:04:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V0tzeqCrFUrytbe0OByYkC23i61H+jdgZRXfMKbShMcA@mail.gmail.com>
Message-ID: <CAD=FV=V0tzeqCrFUrytbe0OByYkC23i61H+jdgZRXfMKbShMcA@mail.gmail.com>
Subject: Re: [PATCH v2] hardlockup: detect hard lockups using secondary
 (buddy) CPUs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-perf-users@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        ravi.v.shankar@intel.com, Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Ian Rogers <irogers@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Gow <davidgow@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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


On Fri, Apr 28, 2023 at 5:36=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Hi--
>
> On 4/28/23 16:37, Douglas Anderson wrote:
> > From: Colin Cross <ccross@android.com>
> >
> > Implement a hardlockup detector that doesn't doesn't need any extra
> > arch-specific support code to detect lockups. Instead of using
> > something arch-specific we will use the buddy system, where each CPU
> > watches out for another one. Specifically, each CPU will use its
> > softlockup hrtimer to check that the next CPU is processing hrtimer
> > interrupts by verifying that a counter is increasing.
> >
> > NOTE: unlike the other hard lockup detectors, the buddy one can't
> > easily show what's happening on the CPU that locked up just by doing a
> > simple backtrace. It relies on some other mechanism in the system to
> > get information about the locked up CPUs. This could be support for
> > NMI backtraces like [1], it could be a mechanism for printing the PC
> > of locked CPUs at panic time like [2] / [3], or it could be something
> > else. Even though that means we still rely on arch-specific code, this
> > arch-specific code seems to often be implemented even on architectures
> > that don't have a hardlockup detector.
> >
> > This style of hardlockup detector originated in some downstream
> > Android trees and has been rebased on / carried in ChromeOS trees for
> > quite a long time for use on arm and arm64 boards. Historically on
> > these boards we've leveraged mechanism [2] / [3] to get information
> > about hung CPUs, but we could move to [1].
> >
> > Although the original motivation for the buddy system was for use on
> > systems without an arch-specific hardlockup detector, it can still be
> > useful to use even on systems that _do_ have an arch-specific
> > hardlockup detector. On x86, for instance, there is a 24-part patch
> > series [4] in progress switching the arch-specific hard lockup
> > detector from a scarce perf counter to a less-scarce hardware
> > resource. Potentially the buddy system could be a simpler alternative
> > to free up the perf counter but still get hard lockup detection.
> >
> > Overall, pros (+) and cons (-) of the buddy system compared to an
> > arch-specific hardlockup detector:
> > + Usable on systems that don't have an arch-specific hardlockup
> >   detector, like arm32 and arm64 (though it's being worked on for
> >   arm64 [5]).
> > + May free up scarce hardware resources.
> > + If a CPU totally goes out to lunch (can't process NMIs) the buddy
> >   system could still detect the problem (though it would be unlikely
> >   to be able to get a stack trace).
> > - If all CPUs are hard locked up at the same time the buddy system
> >   can't detect it.
> > - If we don't have SMP we can't use the buddy system.
> > - The buddy system needs an arch-specific mechanism (possibly NMI
> >   backtrace) to get info about the locked up CPU.
> >
> > [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.=
org
> > [2] https://issuetracker.google.com/172213129
> > [3] https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
> > [4] https://lore.kernel.org/lkml/20230301234753.28582-1-ricardo.neri-ca=
lderon@linux.intel.com/
> > [5] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lec=
opzer.chen@mediatek.com/
> >
> > Signed-off-by: Colin Cross <ccross@android.com>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This patch has been rebased in ChromeOS kernel trees many times, and
> > each time someone had to do work on it they added their
> > Signed-off-by. I've included those here. I've also left the author as
> > Colin Cross since the core code is still his.
> >
> > I'll also note that the CC list is pretty giant, but that's what
> > get_maintainers came up with (plus a few other folks I thought would
> > be interested). As far as I can tell, there's no true MAINTAINER
> > listed for the existing watchdog code. Assuming people don't hate
> > this, maybe it would go through Andrew Morton's tree?
> >
> > Changes in v2:
> > - cpu =3D> CPU.
> > - Reworked description and Kconfig based on v1 discussion.
>
> or at least some of the comments from v1. :(

Oh no! My email program confused me and I thought all of your cpu=3D>CPU
stuff was in the patch description, not in the Kconfig. I'll whip up a
quick v3.

-Doug

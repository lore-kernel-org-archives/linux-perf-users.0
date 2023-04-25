Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7850C6FD18
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Apr 2023 15:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjDYP0r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Apr 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjDYP0o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Apr 2023 11:26:44 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C315446
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Apr 2023 08:26:30 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-329518648ebso47831955ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Apr 2023 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682436388; x=1685028388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cyqk2sw07jP79tLlZQcGC2Yi7zdVZiomYulq2SQLWdw=;
        b=L/ShdrCl5+iXeDSxxnPReIrRb4W3QsHl3UH3GnAzu8m0xFYpaKfwbsqJy1gzNNpdpr
         i0qFLld8wAjbbTEASo+YvevhzL7DIURcQMxF2s4Nt9+lIJU+KanjTJyI0ka1YJzuyXzO
         rEhYpKf11b4IoD8VftCozGAGkTGdY4QYjI/0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436388; x=1685028388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cyqk2sw07jP79tLlZQcGC2Yi7zdVZiomYulq2SQLWdw=;
        b=WFV1FkkFsZaiintLUdftkd+YlOltFQP05i3exWmG7LnCFdVPME6eyl6mjyYsuYffeW
         jHD+Zt0udZF38FXk9OgXfeoNlenmuI+DFpkOQX4aSZstU8gmg+7JWV0mznLtd/2CxZHH
         f86v7j3WFDdTzBpAGO1Hz+uILPLYvhroK8jSNNCbuzJFopcWhEHYhICFO5RLRrnLkA0L
         st2uHMfAYfpwwgjtTNDh7r9jJCd0O0pBecR3q7BW7MqL362URGM8KGXr393sL6PK/7Kx
         cYZi9SU8ljsdLQh4J0FzpbiSmiL7yTtQI5t8aFnIhh6tkPSR10AmB4hhNkq5Mxe/DzU6
         th0Q==
X-Gm-Message-State: AAQBX9dSo7f2fl70Og0lJpURAQTEJkQ1WuC6ZWBg6jmq860xoLeIbtCK
        Ti1D20AC/CRzVvmPZSjuZO2oehiuG0ZzZXm7nMg=
X-Google-Smtp-Source: AKy350bHt7iOUSjVstB7+7pTuTT9YonwEGfaEjaD3RjBc+NnEohf2zGiRaw/g0S1dsgYYSmtrgQM6Q==
X-Received: by 2002:a92:c98a:0:b0:323:1869:15a1 with SMTP id y10-20020a92c98a000000b00323186915a1mr7823446iln.25.1682436388580;
        Tue, 25 Apr 2023 08:26:28 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id f6-20020a028486000000b0040bda8fa34bsm4283450jai.120.2023.04.25.08.26.27
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:26:27 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-32ec968434eso90775ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Apr 2023 08:26:27 -0700 (PDT)
X-Received: by 2002:a92:cd8b:0:b0:32b:3dd3:4c9a with SMTP id
 r11-20020a92cd8b000000b0032b3dd34c9amr264823ilb.15.1682436387051; Tue, 25 Apr
 2023 08:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <20230424125355.GA4054@aspen.lan> <CAD=FV=W2f37XUSWgSrr9AjGZ5WLBm-+6EkGx6YiOEPDsyYQn=w@mail.gmail.com>
 <CAGXv+5Gbph1r0u_NVBS7Lg8w8X4Qw0Q=yxmEkJDs4ptOJu2NVA@mail.gmail.com>
In-Reply-To: <CAGXv+5Gbph1r0u_NVBS7Lg8w8X4Qw0Q=yxmEkJDs4ptOJu2NVA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Apr 2023 08:26:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W-ftcnO+jUw9_cBOPjcpFcUGcOOKuq+XRNyRjUGNSQow@mail.gmail.com>
Message-ID: <CAD=FV=W-ftcnO+jUw9_cBOPjcpFcUGcOOKuq+XRNyRjUGNSQow@mail.gmail.com>
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy) cpus
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
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

On Mon, Apr 24, 2023 at 9:58=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Mon, Apr 24, 2023 at 11:42=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
> >
> > Hi,
> >
> > On Mon, Apr 24, 2023 at 5:54=E2=80=AFAM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Fri, Apr 21, 2023 at 03:53:30PM -0700, Douglas Anderson wrote:
> > > > From: Colin Cross <ccross@android.com>
> > > >
> > > > Implement a hardlockup detector that can be enabled on SMP systems
> > > > that don't have an arch provided one or one implemented atop perf b=
y
> > > > using interrupts on other cpus. Each cpu will use its softlockup
> > > > hrtimer to check that the next cpu is processing hrtimer interrupts=
 by
> > > > verifying that a counter is increasing.
> > > >
> > > > NOTE: unlike the other hard lockup detectors, the buddy one can't
> > > > easily provide a backtrace on the CPU that locked up. It relies on
> > > > some other mechanism in the system to get information about the loc=
ked
> > > > up CPUs. This could be support for NMI backtraces like [1], it coul=
d
> > > > be a mechanism for printing the PC of locked CPUs like [2], or it
> > > > could be something else.
> > > >
> > > > This style of hardlockup detector originated in some downstream
> > > > Android trees and has been rebased on / carried in ChromeOS trees f=
or
> > > > quite a long time for use on arm and arm64 boards. Historically on
> > > > these boards we've leveraged mechanism [2] to get information about
> > > > hung CPUs, but we could move to [1].
> > >
> > > On the Arm platforms is this code able to leverage the existing
> > > infrastructure to extract status from stuck CPUs:
> > > https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
> >
> > Yup! I wasn't explicit about this, but that's where you end up if you
> > follow the whole bug tracker item that was linked as [2].
> > Specifically, we used to have downstream patches in the ChromeOS that
> > just reached into the coresight range from a SoC specific driver and
> > printed out the CPU_DBGPCSR. When Brian was uprevving rk3399
> > Chromebooks he found that the equivalent functionality had made it
> > upstream in a generic way through the coresight framework. Brian
> > confirmed it was working on rk3399 and made all of the device tree
> > changes needed to get it all hooked up, so (at least for that SoC) it
> > should work on that SoC.
> >
> > [2] https://issuetracker.google.com/172213129
>
> IIRC with the coresight CPU debug driver enabled and the proper DT nodes
> added, the panic handler does dump out information from the hardware.
> I don't think it's wired up for hung tasks though.

Yes, that's correct. The coresight CPU debug driver doesn't work for
hung tasks because it can't get a real stack crawl. All it can get is
the PC of the last branch that the CPU took. This is why combining
${SUBJECT} patch with the ability to get stack traces via pseudo-NMI
is superior. That being said, even with just the coresight CPU debug
driver ${SUBJECT} patch is still helpful because (assuming
"hardlockup_panic" is set) we'll do a panic which will then trigger
the coresight CPU debug driver. :-)

-Doug

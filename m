Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2ABC7618E
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Apr 2023 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjDXPlu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjDXPlt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2023 11:41:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F80114
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 08:41:46 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-32b4e379000so12855205ab.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682350904; x=1684942904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxcjgeLi5mR/+Rnc6mrQlDv9TmBqIx7WXWMzAgilAKE=;
        b=R2AuErvK00/YlZzEgTsmJQF4PUmqQvnhAk17pExqc3s2YcGgRcc4fCa/aabuG4rDIK
         vrXZDej6j3ZY91srCywLuFNxFK1ehr7u9/BsWjhj3na95xBxZIFvh3W1Yw+aBcBERRvE
         OtxZrMdTSonCmpJO8Qlrm1CzZw2pi22pz5Spc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682350904; x=1684942904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxcjgeLi5mR/+Rnc6mrQlDv9TmBqIx7WXWMzAgilAKE=;
        b=HH5++f2Da6OeKZU/GGCLJ9oQZAKQ5BggW1NFb3Yy3r+nYjBShg9m/sTn9MXFidfLyB
         uCVuZwUetHmGl3lGoRuQa73ESGZmfCrMi0CQ2pISLAhGTwvf5sAIWlCVz9qsGadee+qm
         tnoM6yGDCDMhVe0Y6Y8aoPnw/u5tx91trELU+o3HPEHsM8EtzBhNQ9MJrwQIPYZPeuzh
         LXj7PWVGx/wyNYRJ+N/+l+swDN01sw4ZiQ7BSNnE3NQKnfXf54lleqFAJ0M7+iKbI/pM
         2Zgr29+v+jlMHEQD1gtsx9APt9A4AhDJRrlT5kTbBwS7KRNeGAkdUVgfEhQ8jmaHal9X
         3mxw==
X-Gm-Message-State: AAQBX9cDsrpGuTCFGtcLuKoKQyL+LA513m4V6qBaSBw3HVLXSs0CtQxX
        NogW+/jSS/wBnXyDmNM5v3fiDzgzAlpGFd3Smxw=
X-Google-Smtp-Source: AKy350YQvxZ2W6VYJGfJ1GaK1UCkZMLESfVGJPjBavg21q+XDSBUIn6A4VdB1+ptCnS0mZc8wTV7Pw==
X-Received: by 2002:a92:d20a:0:b0:32a:db9c:8044 with SMTP id y10-20020a92d20a000000b0032adb9c8044mr6305206ily.29.1682350904507;
        Mon, 24 Apr 2023 08:41:44 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id i17-20020a056e02055100b0032b6033850asm3141455ils.67.2023.04.24.08.41.41
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:41:42 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-328cb023b1dso1062895ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 08:41:41 -0700 (PDT)
X-Received: by 2002:a05:6e02:1606:b0:315:8e3a:f546 with SMTP id
 t6-20020a056e02160600b003158e3af546mr480218ilu.6.1682350901412; Mon, 24 Apr
 2023 08:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230421155255.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <20230424125355.GA4054@aspen.lan>
In-Reply-To: <20230424125355.GA4054@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 08:41:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2f37XUSWgSrr9AjGZ5WLBm-+6EkGx6YiOEPDsyYQn=w@mail.gmail.com>
Message-ID: <CAD=FV=W2f37XUSWgSrr9AjGZ5WLBm-+6EkGx6YiOEPDsyYQn=w@mail.gmail.com>
Subject: Re: [PATCH] hardlockup: detect hard lockups using secondary (buddy) cpus
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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

On Mon, Apr 24, 2023 at 5:54=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Apr 21, 2023 at 03:53:30PM -0700, Douglas Anderson wrote:
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
>
> On the Arm platforms is this code able to leverage the existing
> infrastructure to extract status from stuck CPUs:
> https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html

Yup! I wasn't explicit about this, but that's where you end up if you
follow the whole bug tracker item that was linked as [2].
Specifically, we used to have downstream patches in the ChromeOS that
just reached into the coresight range from a SoC specific driver and
printed out the CPU_DBGPCSR. When Brian was uprevving rk3399
Chromebooks he found that the equivalent functionality had made it
upstream in a generic way through the coresight framework. Brian
confirmed it was working on rk3399 and made all of the device tree
changes needed to get it all hooked up, so (at least for that SoC) it
should work on that SoC.

[2] https://issuetracker.google.com/172213129

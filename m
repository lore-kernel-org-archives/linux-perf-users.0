Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A5CC77B7C
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 22:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEDWpg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 18:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEDWpf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 18:45:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F5869A
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 15:45:30 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3313a2200a4so2808195ab.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683240329; x=1685832329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rN99MG5d6M+UabPVww+w9dMJG2WFhR6z4xfKsLbvtE=;
        b=MT/AK5TGOzqV/y3TrvC/JEKjyss83EB0Tan/DMZv05DEdL7X7E1NafYoPUH/o52qtP
         5kI+EBBTr6SJPll1zoRUjaUUpb8BXGgJX/dki8er8qyN+Pqk7aZI21ANnB9V10tm5y/g
         k4KSL2eV/xrKo5J/kVQaZdp8oqg28xK0FxYNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240329; x=1685832329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rN99MG5d6M+UabPVww+w9dMJG2WFhR6z4xfKsLbvtE=;
        b=VOMlUyA0DMg69XaxDZQRxJ1k2mu2j4XVZpJaSoVV0mN9QKdh316xU3xqAaDIYAJvCH
         6kiQkFT5OHzl7oo7iHnMRX5z0rglPvydIlNfDorLupDYgfv4WGfw2tEUkjCe4t2FGUvE
         OZ2G/97iZjVFlfq9wDNOzgyspUWUBSDnEX+GCvDygRVZ2+RzVJ1LerW3ROTDjiAf99Fi
         I2goiqj7YuoRmvj3+NV2gKaiHFo0GbJVvnbnijr8Ply1j1OTIvvIUcFPmoIspu2/vatS
         yXwC+75yT35wytc+MfLwiWyMhN0+6rAKuV06uY2lKoB7C4hyOo2Zbq216BKazOoFuX3/
         514w==
X-Gm-Message-State: AC+VfDwUsteMasakZnTNGyeYk07bI9dmcByRRUPtcjW/knWJaA8ktRnH
        R5Xd0t7FJkdHkPJKVZz65MGNV+s2ClvNTvR4Tqw=
X-Google-Smtp-Source: ACHHUZ72gQGxTfzw690ol6NzW0E+mpZX+fbsybTOmoIEc1iRaKybVFI9dJ2wC4IE5wfBrfF1DAPF1A==
X-Received: by 2002:a92:cd4c:0:b0:331:96e5:678b with SMTP id v12-20020a92cd4c000000b0033196e5678bmr233992ilq.23.1683240329466;
        Thu, 04 May 2023 15:45:29 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id v31-20020a056638359f00b004050767f779sm151708jal.164.2023.05.04.15.45.29
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 15:45:29 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-32f4e0f42a7so629245ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 15:45:29 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:3ef:3510:7c3a with SMTP id
 g5-20020ac85805000000b003ef35107c3amr17232qtg.3.1683239933101; Thu, 04 May
 2023 15:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
In-Reply-To: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 May 2023 15:38:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wz8u0+WHqiLwcE-3BhbtdVVCnSQjs7bxp=-tisyYQwWw@mail.gmail.com>
Message-ID: <CAD=FV=Wz8u0+WHqiLwcE-3BhbtdVVCnSQjs7bxp=-tisyYQwWw@mail.gmail.com>
Subject: Re: [PATCH v3] hardlockup: detect hard lockups using secondary
 (buddy) CPUs
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ian Rogers <irogers@google.com>, ravi.v.shankar@intel.com,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>, Andi Kleen <ak@linux.intel.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Borislav Petkov <bp@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
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

On Mon, May 1, 2023 at 8:25=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> From: Colin Cross <ccross@android.com>
>
> Implement a hardlockup detector that doesn't doesn't need any extra
> arch-specific support code to detect lockups. Instead of using
> something arch-specific we will use the buddy system, where each CPU
> watches out for another one. Specifically, each CPU will use its
> softlockup hrtimer to check that the next CPU is processing hrtimer
> interrupts by verifying that a counter is increasing.
>
> NOTE: unlike the other hard lockup detectors, the buddy one can't
> easily show what's happening on the CPU that locked up just by doing a
> simple backtrace. It relies on some other mechanism in the system to
> get information about the locked up CPUs. This could be support for
> NMI backtraces like [1], it could be a mechanism for printing the PC
> of locked CPUs at panic time like [2] / [3], or it could be something
> else. Even though that means we still rely on arch-specific code, this
> arch-specific code seems to often be implemented even on architectures
> that don't have a hardlockup detector.
>
> This style of hardlockup detector originated in some downstream
> Android trees and has been rebased on / carried in ChromeOS trees for
> quite a long time for use on arm and arm64 boards. Historically on
> these boards we've leveraged mechanism [2] / [3] to get information
> about hung CPUs, but we could move to [1].
>
> Although the original motivation for the buddy system was for use on
> systems without an arch-specific hardlockup detector, it can still be
> useful to use even on systems that _do_ have an arch-specific
> hardlockup detector. On x86, for instance, there is a 24-part patch
> series [4] in progress switching the arch-specific hard lockup
> detector from a scarce perf counter to a less-scarce hardware
> resource. Potentially the buddy system could be a simpler alternative
> to free up the perf counter but still get hard lockup detection.
>
> Overall, pros (+) and cons (-) of the buddy system compared to an
> arch-specific hardlockup detector:
> + The buddy system is usable on systems that don't have an
>   arch-specific hardlockup detector, like arm32 and arm64 (though it's
>   being worked on for arm64 [5]).
> + The buddy system may free up scarce hardware resources.
> + If a CPU totally goes out to lunch (can't process NMIs) the buddy
>   system could still detect the problem (though it would be unlikely
>   to be able to get a stack trace).
> + The buddy system uses the same timer function to pet the hardlockup
>   detector on the running CPU as it uses to detect hardlockups on
>   other CPUs. Compared to other hardlockup detectors, this means it
>   generates fewer interrupts and thus is likely better able to let
>   CPUs stay idle longer.
> - If all CPUs are hard locked up at the same time the buddy system
>   can't detect it.
> - If we don't have SMP we can't use the buddy system.
> - The buddy system needs an arch-specific mechanism (possibly NMI
>   backtrace) to get info about the locked up CPU.
>
> [1] https://lore.kernel.org/r/20230419225604.21204-1-dianders@chromium.or=
g
> [2] https://issuetracker.google.com/172213129
> [3] https://docs.kernel.org/trace/coresight/coresight-cpu-debug.html
> [4] https://lore.kernel.org/lkml/20230301234753.28582-1-ricardo.neri-cald=
eron@linux.intel.com/
> [5] https://lore.kernel.org/linux-arm-kernel/20220903093415.15850-1-lecop=
zer.chen@mediatek.com/
>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Tzung-Bi Shih <tzungbi@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch has been rebased in ChromeOS kernel trees many times, and
> each time someone had to do work on it they added their
> Signed-off-by. I've included those here. I've also left the author as
> Colin Cross since the core code is still his.
>
> I'll also note that the CC list is pretty giant, but that's what
> get_maintainers came up with (plus a few other folks I thought would
> be interested). As far as I can tell, there's no true MAINTAINER
> listed for the existing watchdog code. Assuming people don't hate
> this, maybe it would go through Andrew Morton's tree?
>
> Changes in v3:
> - More cpu =3D> CPU (in Kconfig and comments).
> - Added a note in commit message about the effect on idle.
> - Cleaned up commit message pros/cons to be complete sentences.
> - No code changes other than comments.
>
> Changes in v2:
> - cpu =3D> CPU (in commit message).
> - Reworked description and Kconfig based on v1 discussion.
> - No code changes.
>
>  include/linux/nmi.h         |  18 ++++-
>  kernel/Makefile             |   1 +
>  kernel/watchdog.c           |  24 ++++--
>  kernel/watchdog_buddy_cpu.c | 141 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug           |  23 +++++-
>  5 files changed, 196 insertions(+), 11 deletions(-)

To leave breadcrumbs: I've posted v4 which is now a big series

https://lore.kernel.org/r/20230504221349.1535669-1-dianders@chromium.org

I took some people off the CC list that get_maintainers had added on
v3, mostly because it was getting unbearable. I tried to copy all
relevant mailing lists, so hopefully anyone who needs v4 can find it
somewhere where it's easy for them to reply to. If you got dropped off
the CC list and want back on for future versions, please yell and I'll
add you. Unless I messed up, I've CCed anyone who replied to previous
versions.

-Doug

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA4C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 18:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiFBSIY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbiFBSIX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 14:08:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9026ADD
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Jun 2022 11:08:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t6so7452478wra.4
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2022 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HxLJgZtlHlK+K1gWFxW+a6tTn7Jn/932cs76W+wS5Q=;
        b=gXafYBazVGRnUdC1FD29atbaAVADiZ30i2Q/SVfn9cd8GZ7W0bWCWgy9yYb4jP8Oyu
         4hZmNacxn7qtAKDYOAQww+NmI4Hw7kk2P3klC22Jp8JrNyrVrHt6EtB7O+B0nWFZXw2t
         5fIy3zrAmE30DcEWfjsDrytlixzdc+lEhAJnTO/Pgu6lScO38ihATUwxB5utWsKxmcX8
         jkyCudn18LKGqzX9vJCyCtySxJo8QZeoebRRyDfu0FOin/VmtfLJWRjQtw4RUkHWf1rN
         TYZtwE+lCZ7vqpVYB7IDg4TLGvhdp0SsFsbGAfyqqC5/sg0GZpc5WFCD1Nh5jaF+2eO4
         QKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HxLJgZtlHlK+K1gWFxW+a6tTn7Jn/932cs76W+wS5Q=;
        b=LNZjmGF4mYUSV+q1WlycCs5csnLg0dWRFBGQ6v9MRjkD7NzgB1sW+oRc9JLsMo0Coe
         lWUIEgI+5/3fVsujESXQdYevSMfHcvExoKwywOwgDjaUQztmlzXG9tTkm82z7h3eFX+w
         Bp7cuYDjnJkRECXoSsy8zfrXbUI6CaobvPaw0E247lr0IRIRJN3zysnK63bFUEUfjIov
         ZPOC/NdNsfG/KaeqT1w6W5vs+w10L0DGNyVI0XCkPapq/rNbXfaVG2v+2WnHJvIafBzt
         eplpzbS6TSdEGKuksPVSAstZl6rLEuMDW/evB9wj0wnYv2N7R6Ofvv++phDVdWlO+ZQJ
         1P4w==
X-Gm-Message-State: AOAM5332ynSvNHp3HUKk9HeXZfY0YHBIb3lEVOCnFphdpnYo3R0dXUxq
        T2Y9U+UEeXz7cNfPV6LTxE6LOipY93frcnpsCSPhcg==
X-Google-Smtp-Source: ABdhPJx5VCLYk+0/TVaEONygVnf++20yjQxm00tLoQZlGTbIZHx/1Gzbn0dkLv78dOY0suJYq+GgxsJlg8zECz0C21E=
X-Received: by 2002:adf:f5c4:0:b0:210:2ac2:6aa0 with SMTP id
 k4-20020adff5c4000000b002102ac26aa0mr4671812wrp.300.1654193300494; Thu, 02
 Jun 2022 11:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220525154114.718321-1-james.clark@arm.com> <20220525154114.718321-2-james.clark@arm.com>
 <b6cf9d34-313e-6b7d-3781-a8a5af203cd6@arm.com>
In-Reply-To: <b6cf9d34-313e-6b7d-3781-a8a5af203cd6@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Jun 2022 11:08:07 -0700
Message-ID: <CAP-5=fX6r31X7HeB-H4MjqwXMcdMSkzMzTk8Nr9F2=daQYhH3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf tools: arm64: Use perf's copy of kernel headers
To:     German Gomez <german.gomez@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        broonie@kernel.org, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 25, 2022 at 8:59 AM German Gomez <german.gomez@arm.com> wrote:
>
>
> On 25/05/2022 16:41, James Clark wrote:
> > Fix this include path to use perf's copy of the kernel header
> > rather than the one from the root of the repo.
> >
> > This fixes build errors when only applying the perf tools
> > part of a patchset rather than both sides.
> >
> > Reported-by: German Gomez <german.gomez@arm.com>
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Without this change "make -C tools/perf" was failing if kernel-side changes weren't applied
>
> Tested-by: German Gomez <german.gomez@arm.com>
>
> Thanks,
> German

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/util/libunwind/arm64.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
> > index 15f60fd09424..014d82159656 100644
> > --- a/tools/perf/util/libunwind/arm64.c
> > +++ b/tools/perf/util/libunwind/arm64.c
> > @@ -24,7 +24,7 @@
> >  #include "unwind.h"
> >  #include "libunwind-aarch64.h"
> >  #define perf_event_arm_regs perf_event_arm64_regs
> > -#include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
> > +#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
> >  #undef perf_event_arm_regs
> >  #include "../../arch/arm64/util/unwind-libunwind.c"
> >

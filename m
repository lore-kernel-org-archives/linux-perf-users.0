Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E2C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 04:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiESEiw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 00:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiESEiq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 00:38:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E945BD3D
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:38:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ch13so7521506ejb.12
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 21:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0Kov6aZdluetrN4GQj4rWNqdgKSS3UrrNz8s7QqTl4=;
        b=lb+cGOwjMv7chw9bEY0403JGbt094O5Lu+PxqVnMvWCHQYuNrnR9AXrzksddK59SIX
         vv+K4FkFdVI4i9EHN05xvXKJX6/G6mYZEukCECzrLo1ktOjXOBEBO2NA0TpbSifxS3JK
         jSye133I1fxiC8Up5HjHRLeIsFv4OtLR7/kTblmRYro7xfNaNpNb/jmhdxrJ6pgw+ecw
         +cLtDZDX/mrmotv+NY4fwoomcWIvTV5WUh7FtftPMgAhDrSUwp6pkhiWgkMO4xgCHqXv
         DNtBysmq/un5ct30v8dhYXjgU+DkDGj+OpxvGLv14AvD4XpqG8SU2f2iMmo0GAi+AAWu
         u0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0Kov6aZdluetrN4GQj4rWNqdgKSS3UrrNz8s7QqTl4=;
        b=hwVtdOciFvkxPxWwumBLAshzTnQOpZB3Ma9SVG/H0506KAz4S34xpEWv7QHFr812D9
         GmPHxwcKyP7wS7grZp53zT8SQfpM6ALIWWamwZao352SVDzPtgiijIhDsd03DoPo85+Z
         xla1TV5kPoI8CRWRDaco3pT/jjJcO4++24F8kP9yrPWXR/L+aS8ztcq6/o9cqU31rHRn
         J5YIzTArC4rvIu6ngbQe8PEZmFzj1maO34hHHsWfew98rLHzL9X77KToPLLaO9Y/0snC
         k93YL3NEppMLvjTsP8JnOPHcTZyQI+88n3+/Ssvip7/i/C5appSRGYB71KQvM+5cWOds
         cJSQ==
X-Gm-Message-State: AOAM532BDiuLpQMa2TBJ8QzLQZcin061aQP+Oy5smXcE7SGa3aoSxfN/
        nqcK8w5VH+hGQZTNCD1/n0eoD4+5ZY1cTta4RVRQbAKVyU3p02qs
X-Google-Smtp-Source: ABdhPJxeEiNQJNA3d/l8Al5ft81eWo6HMUJUyxb6p+J94ov9RvTStETt94fsJB+tXQ6WvGOzqTuDiuLorNtjdFYir1E=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr2187889wrb.300.1652935112801; Wed, 18
 May 2022 21:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220518145125.1494156-1-kan.liang@linux.intel.com>
In-Reply-To: <20220518145125.1494156-1-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:38:20 -0700
Message-ID: <CAP-5=fWKmR-bDbiocSAd4qkrf7_ge+e1_gYLjQqRfGyc8FP4Sw@mail.gmail.com>
Subject: Re: [PATCH] perf regs x86: Fix arch__intr_reg_mask() for the hybrid platform
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, Ammy Yi <ammy.yi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 18, 2022 at 7:52 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The X86 specific arch__intr_reg_mask() is to check whether the kernel
> and hardware can collect XMM registers. But it doesn't work on some
> hybrid platform.
>
> Without the patch on ADL-N,
>
> $perf record -I?
> available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
> R11 R12 R13 R14 R15
>
> The config of the test event doesn't contain the PMU information. The
> kernel may fail to initialize it on the correct hybrid PMU and return
> the wrong non-supported information.
>
> Add the PMU information into the config for the hybrid platform. The
> same register set is supported among different hybrid PMUs. Checking
> the first available one is good enough.
>
> With the patch on ADL-N,
>
> $perf record -I?
> available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
> R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9
> XMM10 XMM11 XMM12 XMM13 XMM14 XMM15
>
> Fixes: 6466ec14aaf4 ("perf regs x86: Add X86 specific arch__intr_reg_mask()")
> Reported-by: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/arch/x86/util/perf_regs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
> index 207c56805c55..0ed177991ad0 100644
> --- a/tools/perf/arch/x86/util/perf_regs.c
> +++ b/tools/perf/arch/x86/util/perf_regs.c
> @@ -9,6 +9,8 @@
>  #include "../../../util/perf_regs.h"
>  #include "../../../util/debug.h"
>  #include "../../../util/event.h"
> +#include "../../../util/pmu.h"
> +#include "../../../util/pmu-hybrid.h"
>
>  const struct sample_reg sample_reg_masks[] = {
>         SMPL_REG(AX, PERF_REG_X86_AX),
> @@ -284,12 +286,22 @@ uint64_t arch__intr_reg_mask(void)
>                 .disabled               = 1,
>                 .exclude_kernel         = 1,
>         };
> +       struct perf_pmu *pmu;

nit: this could have smaller scope if just be declared in the if-block.

Thanks,
Ian

>         int fd;
>         /*
>          * In an unnamed union, init it here to build on older gcc versions
>          */
>         attr.sample_period = 1;
>
> +       if (perf_pmu__has_hybrid()) {
> +               /*
> +                * The same register set is supported among different hybrid PMUs.
> +                * Only check the first available one.
> +                */
> +               pmu = list_first_entry(&perf_pmu__hybrid_pmus, typeof(*pmu), hybrid_list);
> +               attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> +       }
> +
>         event_attr_init(&attr);
>
>         fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> --
> 2.35.1
>

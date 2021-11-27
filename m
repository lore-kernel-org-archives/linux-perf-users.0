Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B461EC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 Nov 2021 19:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355934AbhK0T2M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 Nov 2021 14:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356076AbhK0T0L (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 Nov 2021 14:26:11 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10119C06175E
        for <linux-perf-users@vger.kernel.org>; Sat, 27 Nov 2021 11:21:40 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id x32so29359481ybi.12
        for <linux-perf-users@vger.kernel.org>; Sat, 27 Nov 2021 11:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPTEsVd8L/qgtedGXg8tCxgoVeCdwj/SNLHqkRKMp1Q=;
        b=HRzdwNX78qudIyrJ0A89abuLwyl0Inc+DCkIbl2N8bFzCmhYH0nE2CK22QRmBwrncr
         uGn0BL+EJjPv7iKBWAYifS9Rtyg55MffQXiypB6mVR7dX+KIwRpR2sZ6q9q6Aa0d14Yl
         Pg748NC0LMggx/7lGaGG/avAi9B8u67S0ENIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPTEsVd8L/qgtedGXg8tCxgoVeCdwj/SNLHqkRKMp1Q=;
        b=H+wBxNI7JnYZpy3eeYbhMvQIKVrqMtNsHVfB2V4v4euFGvHJL+TRgV2796we8YByDX
         NaKTtHRBGph95fREHemSdGWLXlVJbjL/DGS8HHlai3FMavAP+l3xFa3BAVqlpfi1/4yA
         2es0GfyVcnbZ2BfhSIkwDcde2J/ErzqirBHND5HVxksmBNwF21HlbleP3qHYxheBwJGs
         xjavYBLxzQq7SlntXD1W4YgWnwPyn2w7SMsEt14dZYweglm2syDsAGgBa3Rif1lxJ1Ju
         2vpWeVPzBuyJvyW/iToplyuQMT7QoqTawIAtrXGJXs6wXWP9IOJQ3MjHJ54ru5kxKCIa
         sEQw==
X-Gm-Message-State: AOAM5300n+vqW3CG2ML/5qtfDrVI9F36pEcOFWg6Hs/617Q1h5HtWg6W
        m8v594R7MEPhk86GChPl1rRcsyvhXQbClDagBn+t
X-Google-Smtp-Source: ABdhPJyo8tW8RoKqYEawGG4QSNv0yHwoeBOkEaHHs7riL9cwzAAM/pZ7pJPUcbyLeMq2fKRhngb3JkrY0DZRB/0O7V4=
X-Received: by 2002:a25:748d:: with SMTP id p135mr25906993ybc.169.1638040899293;
 Sat, 27 Nov 2021 11:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20211126223123.1125916-1-colin.i.king@gmail.com>
In-Reply-To: <20211126223123.1125916-1-colin.i.king@gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sat, 27 Nov 2021 11:21:28 -0800
Message-ID: <CAOnJCU+QRiFYjDfDr=7v+k2Th6fTxNzec3z86x-y578+WzSSrw@mail.gmail.com>
Subject: Re: [PATCH] riscv: perf_event: Remove redundant initialization of
 variable ret
To:     colin.i.king@googlemail.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 26, 2021 at 2:31 PM Colin Ian King
<colin.i.king@googlemail.com> wrote:
>
> The variable ret is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed. Clean up the incorrectly indented following
> declaration of variable code and move to the same line as the
> declaration of variable ret.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/riscv/kernel/perf_event.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

This file will be removed in favor of a platform driver that has more
rich support for perf.
https://lkml.org/lkml/2021/10/25/1427

> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> index c835f0362d94..cf3e2ac9bbb2 100644
> --- a/arch/riscv/kernel/perf_event.c
> +++ b/arch/riscv/kernel/perf_event.c
> @@ -156,8 +156,7 @@ static int riscv_map_cache_decode(u64 config, unsigned int *type,
>  static int riscv_map_cache_event(u64 config)
>  {
>         unsigned int type, op, result;
> -       int err = -ENOENT;
> -               int code;
> +       int err, code;
>
>         err = riscv_map_cache_decode(config, &type, &op, &result);
>         if (!riscv_pmu->cache_events || err)
> --
> 2.33.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish

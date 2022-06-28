Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC5C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 13:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbiF1NRo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346208AbiF1NRM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 09:17:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B90932051
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 06:17:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so22217174lfa.6
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X57uwopXnuwAGxBJfo3nXt3MJLIDmWTaNVtJmoGBIrs=;
        b=AT2t+rTr3KgCX8AA8eDt3WrbxtMhylo4g1A8Gxq1VecJhw5AD9vpsoz/2xq2XcDZUW
         tptAB4ig8ybMBqdwhS7/u5onHQdA/cUFgW1Ek02/2U2+Gtw3+8M6eRTac5lfoAAsHvgz
         sF7cUuFbFVDR3quRsL6I5+94M/OE/UypLaxuAlAgRuKl+84iwY2kdjwtNwj/SnloBiO8
         kk/odc9q3zUdO+qVSQVt5Aex46qwxbLOO+ypHzWbk1RNAm1y5U8i4UZ6aSNKoLhC42Tu
         3hKZMpRbPk9Y7KC45eeLp7Q6lCepZHZhMUNxP/XCOKqwWXygnxUMKaLuCS5aiD3/K6PE
         Yaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X57uwopXnuwAGxBJfo3nXt3MJLIDmWTaNVtJmoGBIrs=;
        b=kLSdEnkPYhIZdcljV7VTI2PFmtJjP14m/mKunY8HbejrDKI5tDoYZunIJ52XG9fWDG
         LtiyeDiJkZNEBwiNaxzpvoouMfxbeU0V1XcfJ/CLLLCVjUm0stQDfJlxXV2A/hJ8RfGR
         tfOUfNB23fuJh4XqQzyEUFtWPmrir9WYpQ09th0AIbx5Qs3Yiz8V13Jsx3pYV5hjMxGQ
         yFtGeykKOMzz4PbP+GYuC22faizmA/FVqP9RQ4IOkPLFtQjUQ6QDhjOGMjBf1VpiJHoC
         8t5wi8DIIntnR7H2Sb4ygTU77/0VMYHbKSPolf+8ruXJZDn5YAoXhouUVgEvL8kDjNaN
         09fQ==
X-Gm-Message-State: AJIora+VdDEcQRURgSZ0kH715X3MZ2M5WjghOBBFVIJDgNDr5xC6rzUK
        +JO72S9xceX1mo1OwLyC4uGxhdtmi6i0ZgWraHIHFg==
X-Google-Smtp-Source: AGRyM1tG67YPf8p5Qp1qLNRMlMNTKwh2CzvgbvnW3zyfeM/E1CTmSMCbEimuXozCm7RVAzd+EXswJxcxpkMBCM0PW6s=
X-Received: by 2002:a05:6512:39ce:b0:481:31e4:1e06 with SMTP id
 k14-20020a05651239ce00b0048131e41e06mr1777836lfu.376.1656422220502; Tue, 28
 Jun 2022 06:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-7-elver@google.com>
In-Reply-To: <20220628095833.2579903-7-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Jun 2022 15:16:49 +0200
Message-ID: <CACT4Y+bkQNci3gOyvBAkcfJjqE9h2kPJ2nKjrD7XjQ+sg1L4kg@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
>
> Due to being a __weak function, hw_breakpoint_weight() will cause the
> compiler to always emit a call to it. This generates unnecessarily bad
> code (register spills etc.) for no good reason; in fact it appears in
> profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:
>
>     ...
>     0.70%  [kernel]       [k] hw_breakpoint_weight
>     ...
>
> While a small percentage, no architecture defines its own
> hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
> which makes the fact it is currently __weak a poor choice.
>
> Change hw_breakpoint_weight()'s definition to follow a similar protocol
> to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
> hw_breakpoint_weight(), we'll use it instead.
>
> The result is that it is inlined and no longer shows up in profiles.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  include/linux/hw_breakpoint.h | 1 -
>  kernel/events/hw_breakpoint.c | 4 +++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> index 78dd7035d1e5..9fa3547acd87 100644
> --- a/include/linux/hw_breakpoint.h
> +++ b/include/linux/hw_breakpoint.h
> @@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
>  extern int dbg_release_bp_slot(struct perf_event *bp);
>  extern int reserve_bp_slot(struct perf_event *bp);
>  extern void release_bp_slot(struct perf_event *bp);
> -int hw_breakpoint_weight(struct perf_event *bp);
>  int arch_reserve_bp_slot(struct perf_event *bp);
>  void arch_release_bp_slot(struct perf_event *bp);
>  void arch_unregister_hw_breakpoint(struct perf_event *bp);
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index a089302ddf59..a124786e3ade 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -124,10 +124,12 @@ static __init int init_breakpoint_slots(void)
>  }
>  #endif
>
> -__weak int hw_breakpoint_weight(struct perf_event *bp)
> +#ifndef hw_breakpoint_weight
> +static inline int hw_breakpoint_weight(struct perf_event *bp)
>  {
>         return 1;
>  }
> +#endif
>
>  static inline enum bp_type_idx find_slot_idx(u64 bp_type)
>  {
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3793C47089
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29AB6124C
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhE0PyR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhE0PyD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 11:54:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1443C061760
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 08:52:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso2898785wmm.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 May 2021 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlgmpzlXrGPb4adzxgTzuNIO/2YBxtpJ9xpzMiqFgFw=;
        b=XSTD9340EamIS2ZjQNaRsw5UgXNY2HMxLCvLI9bdSj8Iea3fde0JEAY3wLkLsHjV1c
         /MhBeBdeS+ie68i3NmmmB53Oz4AaJ2u8DZK5oFiW7XkmgjC/izgKLAtcur7H+36HjD6h
         ppD6WJhjpSwtyft1byckOTPuzvxG8hl9BqPdrmzHZ2+jrc2rB0y5jIi9GyItDMB/bc0s
         nHuJn0f4M6+DoOk/dOESaSKoHCsmUPbhMOAtwm9sdP2gUV0DyR1o0WevT5AT7UbC3dLF
         r0GZ0VvBf/W429+f65G7U9SPXtLnFfePvoB84Ebn7szU9lrU9K0tmm81tN5Xx71jcxuV
         NEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlgmpzlXrGPb4adzxgTzuNIO/2YBxtpJ9xpzMiqFgFw=;
        b=pzBBB9dnbEGoi/akznEJj4p44vnmB0v6g67RYbdBhbTK5oHCjFxiVLy4xKEt+Lhbpn
         lO6rgOQD6llXpgQo5JmNhWa2RalHFVOYCl20DAq44OjaCVGp9XMxwgVEAdtxofCu6ROe
         jtqARuGPq4CzKOEPajJMT65lH5ikLl7pDVo+GEvmbCKG3TqMDsY38h5J+CmYJiXVzo7I
         L2FTDi+SNrvUDEE8XGildBUXeT3PefrcOU/5YRqDZE1BQmziVB/im1UUUWZ3LjSBFCCq
         dE96M9g3LmcxIQ2TEm6BDPRRq8r0dBCCHYQiUAJXkHneT153Pu6mz8BW6VtTlrL0qccL
         b4Kw==
X-Gm-Message-State: AOAM532hLWJCd932yrV46XBTD7avBNlUBW6LvZMNUv3gh1PQS+n44d8j
        IGZL6o/D2CaXa9jRCGqn9VwsbIgMGLXWuXBkBO+63g==
X-Google-Smtp-Source: ABdhPJxecOp9yIEugWSR4DBipzJE9LPuNgsMpZ5JckoAPWek0qsw0htS6vxLt0+yoDyAJ+GoVqLA/y/ieSQqQxx2VL8=
X-Received: by 2002:a05:600c:414a:: with SMTP id h10mr1416201wmm.77.1622130747362;
 Thu, 27 May 2021 08:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210519151213.2643570-1-irogers@google.com>
In-Reply-To: <20210519151213.2643570-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 May 2021 08:52:14 -0700
Message-ID: <CAP-5=fXpibzr2Vdzy4RHPVzQbSAOLimpHeuVY_L_YsXDy-2_1Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Test 2 libpfm4 error cases
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 19, 2021 at 8:12 AM Ian Rogers <irogers@google.com> wrote:
>
> Proposed in:
> https://lore.kernel.org/lkml/20210517140931.2559364-1-tmricht@linux.ibm.com/
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks!
Ian

> ---
>  tools/perf/tests/pfm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> index d4b0ef74defc..acd50944f6af 100644
> --- a/tools/perf/tests/pfm.c
> +++ b/tools/perf/tests/pfm.c
> @@ -155,6 +155,16 @@ static int test__pfm_group(void)
>                         .nr_events = 3,
>                         .nr_groups = 1,
>                 },
> +               {
> +                       .events = "instructions}",
> +                       .nr_events = 1,
> +                       .nr_groups = 0,
> +               },
> +               {
> +                       .events = "{{instructions}}",
> +                       .nr_events = 0,
> +                       .nr_groups = 0,
> +               },
>         };
>
>         for (i = 0; i < ARRAY_SIZE(table); i++) {
> --
> 2.31.1.751.gd2f1c929bd-goog
>

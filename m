Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0B6C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 16:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiF2Qne (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiF2Qnd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 12:43:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA422B07
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 09:43:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f190so9429808wma.5
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyNdAiqX42nvqZ9JWQ/ZZaNT635XeywxS5XfMuA1CNA=;
        b=opEEI8h3+r0PCqDkmte4H0kX0dHSW0KHKiFIN9QkbQDYyw9MZk+K4YkwZZpBiNBh5o
         PHZ00wpnpy09QVuA596YHI1IXuFiGKStIGwr355sBtLqirvwyu+X+pzoba8Hvl4CeSRA
         951rV2x5tz49mFgmEZagaOIQnxeC4i8gdj/ncHjPxVj5ni2WdWP19l3dcdTgAVeh9NPn
         KWshRxNd3Tv9VpnUv4FcBVmyHC4rXb/yTMURlMZNdKCCiE7mkMm1GktD2EkgvU4BLw7M
         M1SCUkOyRIzFw7gmJnN5el0E6eFz9I1sVr3cLEt/TDOEOnh6RFLIhD9R3JEx/fNOqD++
         0Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyNdAiqX42nvqZ9JWQ/ZZaNT635XeywxS5XfMuA1CNA=;
        b=qL/MrakhWgB7WrpfaKNIr7gkEi+8TwwtGZx/Tns4ZFoHajisz7HLV6ww4Kxv04u09v
         pFMEBhfsuM2K6tJlWK6cRX/hurU0SE3MFZWFL7xlYU4xMInA0sO5YNEbKY92bokNknzE
         t2b9AZa+71B9bPdJvqkzNiU2Ot7lkQtwctNBAdu/Rng8F/TFmwDBph+n2DJWKbuB67z4
         oF2Frz6Q6XNMDDyMpoygMYshsK/CbD7vSKlbRnA49TPBzUAh68WpHsbY0IVyOhOD//hl
         AENyJCDkksT/HZkNP8MprBcyNOMC3EK4JGaeNjnICh4J+LdWtUgZHo2LtfpeRaZ9hrUJ
         3cFw==
X-Gm-Message-State: AJIora9G65PKM2y/db/T6klOxpKeL67V8E4Ip2rPIIKyCcBIaQ7WmM2f
        Q0cFvF54J383x/9LcLpomYbjPDH/Fy3bP1xGe5ZTCw==
X-Google-Smtp-Source: AGRyM1tzVMu+TvVRluK/L7Osh8Zh1JGst4FUzpq7H+X2NAYP7sSYq8BO0Hw75njUXs/skzfjKMMdQXFX07FY1+vv1dA=
X-Received: by 2002:a05:600c:4e4c:b0:3a0:53a2:48b5 with SMTP id
 e12-20020a05600c4e4c00b003a053a248b5mr4628041wmq.174.1656521010316; Wed, 29
 Jun 2022 09:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220629112717.125927-1-jolsa@kernel.org>
In-Reply-To: <20220629112717.125927-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 09:43:17 -0700
Message-ID: <CAP-5=fWm5uZYrxakCZuJtWgVFChNje2SpPgDXD+Xs=XnmB2dzA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Convert legacy map definition to BTF-defined
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 29, 2022 at 4:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The libbpf is switching off support for legacy map definitions [1],
> which will break the perf llvm tests.
>
> Moving the base source map definition to BTF-defined, so we need
> to use -g compile option for to add debug/BTF info.
>
> [1] https://lore.kernel.org/bpf/20220627211527.2245459-1-andrii@kernel.org/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/bpf-script-example.c | 15 +++++++++------
>  tools/perf/util/llvm-utils.c          |  2 +-
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
> index ab4b98b3165d..065a4ac5d8e5 100644
> --- a/tools/perf/tests/bpf-script-example.c
> +++ b/tools/perf/tests/bpf-script-example.c
> @@ -24,13 +24,16 @@ struct bpf_map_def {
>         unsigned int max_entries;
>  };
>
> +#define __uint(name, val) int (*name)[val]
> +#define __type(name, val) typeof(val) *name

This is probably worth a comment, reading it hurts :-) I expect that
libbpf provides a definition that the rest of the world uses.

Fwiw, the pre bpf counters BPF in perf needs a good overhaul. Arnaldo
mentioned switching perf trace's BPF to use BPF skeletons in another
post. The tests we have on event filters are flaky. One fewer bpf.h in
the world seems like a service to humanity (I'm looking at you
tools/perf/include/bpf/bpf.h).

Thanks,
Ian

> +
>  #define SEC(NAME) __attribute__((section(NAME), used))
> -struct bpf_map_def SEC("maps") flip_table = {
> -       .type = BPF_MAP_TYPE_ARRAY,
> -       .key_size = sizeof(int),
> -       .value_size = sizeof(int),
> -       .max_entries = 1,
> -};
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, int);
> +       __type(value, int);
> +} flip_table SEC(".maps");
>
>  SEC("func=do_epoll_wait")
>  int bpf_func__SyS_epoll_pwait(void *ctx)
> diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
> index 96c8ef60f4f8..2dc797007419 100644
> --- a/tools/perf/util/llvm-utils.c
> +++ b/tools/perf/util/llvm-utils.c
> @@ -25,7 +25,7 @@
>                 "$CLANG_OPTIONS $PERF_BPF_INC_OPTIONS $KERNEL_INC_OPTIONS " \
>                 "-Wno-unused-value -Wno-pointer-sign "          \
>                 "-working-directory $WORKING_DIR "              \
> -               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -O2 -o - $LLVM_OPTIONS_PIPE"
> +               "-c \"$CLANG_SOURCE\" -target bpf $CLANG_EMIT_LLVM -g -O2 -o - $LLVM_OPTIONS_PIPE"
>
>  struct llvm_param llvm_param = {
>         .clang_path = "clang",
> --
> 2.35.3
>

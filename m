Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA113C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Oct 2022 23:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJTXsB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTXsA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 19:48:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA44A1C4EFB
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:47:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv10so2112577wrb.4
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Fp06+6mQjxwkMOGbcbdaLiXXdLiLH/d1YiaDFPBTsk=;
        b=Y2VSj6x6IJpx1oqTEKHu91HFrj44s8bfYZ4CAqIUdG2CXcI8H27Eh07nG7oyg+oDX3
         xiseJW/kIQVTP+eBV8EtqJNihbz5aMe19JneF8NBdeLKnKcF2sFSuhU4UiKr28+Oc+Y9
         MUkaRzqhBXJiMAk/Zuadj1LR8x9EFZSb5Sw3qTji9Yn3FNEZcLkFAeHqHmXdswaJhcHM
         WHgnS9MwaNEhiAPcucV0XOHraJ+SkDK8YL3KtXYIFZ+TKhsurS6BRMcGhytM7KDIfGCL
         OvBZz/w4VQI+vWyTvJ3C/6PQDFhhdy0MlZdMjUr50x0xHrbOD5XpxXcE8JrrvTIrWvgK
         sZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Fp06+6mQjxwkMOGbcbdaLiXXdLiLH/d1YiaDFPBTsk=;
        b=MtxAy3isDD9cO1OD7mmqAg12LLHN8T97drzbfagkMMIsgvyvjaYexK+A03d2FXupP4
         urOZbuwhIqZ3ZNc5zCOBZOBod5Cj2bKtU3G0oW2qY6dqoMQBB7h5WhhYSR/Y+uwNcsNQ
         waGWexfZO2K15CFWrCJqO8ptpzquKLk0aH10rfLYz4Zc1t5XMUm/1mAcKMZaTzwi0VRs
         f1nmz4XuZLE/A0I7RJCOendIxVisY7U5xe5O6WR85tFMkPtgFjaTsMIkCjbE8bXD4VPn
         XGzhB8KDaHGF0kwswMq33tmWfPlKtFMq9n0c242nqkc6pesCMXTe7vt7/5/vGXjMut5l
         U3WA==
X-Gm-Message-State: ACrzQf38mBlfjxx054N6nSXq31h+ialdM3CEvp4/Q5Je39UBh9oPbOPy
        /0IusE85uGDImcYAvjvEt83U92jI3RoaF4oZ5PFyEM1dP88=
X-Google-Smtp-Source: AMsMyM7jL1WZO39lKYVxbhe71wEvZ0SK44dVy3hW0rkt1uiFYayLRWNYCd1UjSgrwj4e9WIBD+sAfmtPvFytMOOgSbU=
X-Received: by 2002:a5d:47a9:0:b0:22e:3beb:dc3a with SMTP id
 9-20020a5d47a9000000b0022e3bebdc3amr10418490wrb.654.1666309677281; Thu, 20
 Oct 2022 16:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-2-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:47:45 -0700
Message-ID: <CAP-5=fXpwnX1mhaV7gcycn7O4D+TSSJqQqt2Wmh-DusD1qT66g@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf test: Do not use instructions:u explicitly
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I think it's to support non-root user tests.  But perf record can handle
> the case and fall back to a software event (cpu-clock).  Practically this
> would affect when it's run on a VM, but it seems no reason to prevent running
> the test in the guest.
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 301f95427159..747c33a1ec45 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -21,18 +21,18 @@ trap trap_cleanup exit term int
>
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  if ! perf record -e instructions:u -o ${perfdata} --quiet true 2> /dev/null
> +  if ! perf record -o /dev/null --quiet true 2> /dev/null
>    then
> -    echo "Per-thread record [Skipped instructions:u not supported]"
> +    echo "Per-thread record [Skipped event not supported]"
>      if [ $err -ne 1 ]
>      then
>        err=2
>      fi
>      return
>    fi
> -  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
> +  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
>    then
> -    echo "Per-thread record of instructions:u [Failed]"
> +    echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> @@ -49,7 +49,7 @@ test_register_capture() {
>    echo "Register capture test"
>    if ! perf list | egrep -q 'br_inst_retired.near_call'
>    then
> -    echo "Register capture test [Skipped missing instruction]"
> +    echo "Register capture test [Skipped missing event]"
>      if [ $err -ne 1 ]
>      then
>        err=2
> --
> 2.38.0.135.g90850a2211-goog
>

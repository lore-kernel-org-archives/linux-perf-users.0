Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB6AC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 05:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiKWFci (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 00:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiKWFcQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 00:32:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B5F1D85
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Nov 2022 21:32:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so627839wma.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Nov 2022 21:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sh9Br3VcOC11IPNsCcRkapj0A+K8zB3Y2JaN/+M54XE=;
        b=jTMgPGrnXqjleCRFYApOwJh713ZFjF9caF+tDUdJiSg5uCTJQmwd3FXyXeCSd8D+ct
         fEtTHnrlW+LYnCLNrcCmEUFvPUQyinAHdsfT4A2IdcHcBwAIDe4eZRjvfe+0F1dBupQc
         Z9WIYjCghuKmkOE/8hXwEit6lGnx5eLP6oEeu8/3rl9bB6GhP9MynhnQoesOPJINB8LR
         tMDFO6++xx4I69f9p/QAU8V0+myV4Kylyd/L7OkKbnsWM/Y5/27yU2N3T4OICZgMMtyr
         Y+02DjcOL855eqf8goshN/ip1s6NNy9rrxWfEHU51Ck02ggmM4CFZ0iLPMYPNiUBa68h
         7Ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sh9Br3VcOC11IPNsCcRkapj0A+K8zB3Y2JaN/+M54XE=;
        b=Ud9Kyp/ik/9aTArg25oxrkJkz3O4uJDXb//Qm8sIvpc0c6oVF2717VqfKpnBlT5wn3
         uT1AMBrnOPWv0A1+3+Lr33qGRdVEQ8u5TnBNDPCZbutZTFAyP3Y0/foVxKE60H76xrlP
         0rT3z/fWf8ckqWcx3AnWSOHabWyQpcQagddUCY/w72De60oCsSPlqXcf1OKc3kZWmFMT
         F8jHfaKZznATxTJk4a1cqgqyi2UTEJhhXI+91iVxIjXY4Yk7ItEzJ3XxvlDvKnx+RQBP
         Rj2qS8133Cq4MYluXF/RWRNW9GAX2JasgPhW0VclOmAULIKu9OzhIWBUbIGCxDSdm8Zd
         MiNg==
X-Gm-Message-State: ANoB5pmmzhoEUYxPOm196YzY2gTerjv5iPFNgtJ2MgVqMDxnzfNkncty
        23ftzrWHBkgAG5IH2qR/yClRq5o8R1mUmSX2xg3qyg==
X-Google-Smtp-Source: AA0mqf7g7iDaPsQk/VQ2rS7mkS2wpr7x0FxK70oNaWnBTCq5ag9FgQ8/r4DHrjuxRBfhdjFZHZob7ZEb30aaVHJs09Q=
X-Received: by 2002:a05:600c:4fc4:b0:3c6:c109:2d9 with SMTP id
 o4-20020a05600c4fc400b003c6c10902d9mr8758975wmq.149.1669181521476; Tue, 22
 Nov 2022 21:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20221122083121.6012-1-mpetlan@redhat.com>
In-Reply-To: <20221122083121.6012-1-mpetlan@redhat.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Nov 2022 21:31:49 -0800
Message-ID: <CAP-5=fUj11rCAA8t6FUN1N+pLO4-FWE-buAVor-v41gYJ7M3hw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix record test on KVM guests
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 22, 2022 at 12:33 AM Michael Petlan <mpetlan@redhat.com> wrote:
>
> Using precise flag with br_inst_retired.near_call causes the test fail
> on KVM guests, even when the guests have PMU forwarding enabled and the
> event itself is supported.
>
> Remove the precise flag in order to make the test work on KVM guests.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index e93b3a8871fe..a796222288ec 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -134,7 +134,7 @@ test_register_capture() {
>      echo "Register capture test [Skipped missing registers]"
>      return
>    fi
> -  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
> +  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call \
>      -c 1000 --per-thread ${testprog} 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
>      | grep -q "DI:"
> --
> 2.18.4
>

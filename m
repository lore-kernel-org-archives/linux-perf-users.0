Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB4C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 00:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJUAGI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUAGE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 20:06:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6A1A0473
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 17:06:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so954814wmb.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce85l94yiE8BFGgyQ67Qv2ZpUdigC6Z2Y/3UEEckDZk=;
        b=fj5jGVyKSc3C37rbdLDK8t9VG8coEEGVeSYlX6qlvAntzOwNTYS9pnKoTCrW8jvP9y
         XySMuzbRvA5jNHjSFS5NCUzwEweQiHObKdtdym8d95EOAKOecAjx+GTJj8hbavHulntt
         PdeSWi2Fjac85iCLuTbvrnlbouy7GFEEcGGPbvtsPaseUwd/8Xk1t3Z3SEujHqtjPjsU
         01XUrSLF/UyNfafcaULSxVSTgRPuZjMnVYjTFUCVQ9xNBLUSc843gzYSFtmy5WzS+hwO
         Eb9XcVggYZn3q15j0G3hJ6p+ZtFEJYHC7If6hUDEKAWHELH54fPXhYsKDTb3x1KpT5r4
         NQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ce85l94yiE8BFGgyQ67Qv2ZpUdigC6Z2Y/3UEEckDZk=;
        b=yKvDlFi399BHArAwxpIQrbiWNi1YtFKVB4Nw/40X22nYK2yJk6H0N2WuuYVmi0AvHu
         hR9Xtm9EBF3FOMdkj1I4K9d/HYzLoP8R3ezzPW//D3SiKXD4AH26EceaOddV8hMqW7S5
         VOlTiDtnmRRDISyyGrbRWjIUrPbm/1DSuGxsWyROpt/e/FD1o+A2f9n0adFllTG417I+
         J+rVDzkRsDqdFBbv90xbLsVb6zUe75E4zWKEfHfaOmW6vUAduzvYQ5YN8839l3Bo9qON
         dLK+fUxK3t8ROZMtsX7m2Eh2O6LLXS11Pnh+Ct2Cuw5Q6EFprkuAaQYDjw2cueYpSant
         rb7Q==
X-Gm-Message-State: ACrzQf0uPVLxBs5RGkYwOAngor4+z1Nc/Tb290nZvLuuxcee3rLlEbuT
        E45Rk0WgB9j28fHfKuVMJzsqSffzeq5daXJgRCtSdA==
X-Google-Smtp-Source: AMsMyM4vULa/TG+VCjGGy62DnjKkx3iBn/H4YUcYGsO7TMbYww/ZRMQX+K+K3jz1DG7Ht5Y4pfqgB4uZYuTEzz57aW4=
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id
 u12-20020a05600c19cc00b003c6fbb9caabmr12699027wmq.182.1666310761401; Thu, 20
 Oct 2022 17:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-9-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-9-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 17:05:49 -0700
Message-ID: <CAP-5=fVRCaTJseQA_AGZ8nc0H65iNsPUfjDNtopd++JK53kYWQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf test: Do not set TEST_SKIP for record subtests
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
> It now has 4 sub tests and one of them should run at least.
> But once TEST_SKIP (= 2) return value is set, it won't be overwritten
> unless there's a failure.  I think we should return success when one
> or more tested are skipped but the remaining subtests are passed.
>
> So update the test code not to set the err variable when it skips
> the test.
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Perhaps we can have proper sub-tests in shell tests like we do for the C ones.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 01aa9531b369..e93b3a8871fe 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -81,10 +81,6 @@ test_per_thread() {
>    if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
>    then
>      echo "Per-thread record [Skipped event not supported]"
> -    if [ $err -ne 1 ]
> -    then
> -      err=2
> -    fi
>      return
>    fi
>    if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
> @@ -131,10 +127,6 @@ test_register_capture() {
>    if ! perf list | grep -q 'br_inst_retired.near_call'
>    then
>      echo "Register capture test [Skipped missing event]"
> -    if [ $err -ne 1 ]
> -    then
> -      err=2
> -    fi
>      return
>    fi
>    if ! perf record --intr-regs=\? 2>&1 | grep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> @@ -159,10 +151,6 @@ test_system_wide() {
>    if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
>    then
>      echo "System-wide record [Skipped not supported]"
> -    if [ $err -ne 1 ]
> -    then
> -      err=2
> -    fi
>      return
>    fi
>    if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> --
> 2.38.0.135.g90850a2211-goog
>

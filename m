Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B154C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Oct 2022 23:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJTX5j (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTX5i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Oct 2022 19:57:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656222C826
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:57:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so3897512wms.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Oct 2022 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H0mgUk8pHuNN2LGzO3jLHbR7my+DG/R2XSHZQG1d+tQ=;
        b=GQP6baGtP+EPBYErGgmNhObaaaVnkritMmDJdM4Chiw4675C3aPExwrW8lJmqArKFO
         vHhPgP6Ydefb6G0kK4nEB2vBfXaWk2jHV8yc3V1hSNqgT7JNSGV5Ic2pEXSxGBTP6gG1
         QZGVS2W4uYnxlkh8LKaEkklATW4UVT8KQpJ1Pyjgj+Vdm4X4z/h8HEQa9bV5nPTHIVsG
         PqYscwX1aCi7Jw2Ynh5yhD4y87bO1wfxKWUhqVC4bAa14GgOMOH/YORjFLOqRWPU5qJq
         dPAMBfkuw7yVAiUdEDmfXu9BSOUWgcospD9BExA1Ha2mVFXpONezTdVI0D+OQKncC/rP
         BXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0mgUk8pHuNN2LGzO3jLHbR7my+DG/R2XSHZQG1d+tQ=;
        b=1Mmov4OTACq3uyJvtRl/D9NDYiNkYHlpnTuPMbllsZNhnNFCy5LKi/zc/0AK6Wy7mI
         pV8f/OxQKUjEhYlS8wczPyRKiPsWBDPR3KcLcZPExx6A8GN/NY+WpDuYD88psRor7mv7
         XI4FWyVwmb6bR9H2wB66GL4Pzl/B6c7ZZjoxag62fAtm8h3twp1BYnjz9BUSmf0It/N+
         GodNJR8YZ9lVmDuGoFs4CkBj/lPmFFMatpj84NizpCcefQ0mMWPHIy1GmkamucgE21BX
         Z7tmnXD0SzJGf0D4XSxMm88+BFKx9PxD8eqiY986cw5yfNGckB5O+GjvX+vFrvi14csy
         lWWg==
X-Gm-Message-State: ACrzQf1w3mQTLL70oFqrCStKOFLtxOKWFs/vbEatiChTsKItEfZxz4XX
        8bWbaJ9yuKZ2g15v1AX8UQOW0mN02lzrdRau38jM+A==
X-Google-Smtp-Source: AMsMyM6hc+nFD36eoAsIU3qJo1l4LizrOoMMzLLozBscEo9C1W0QEzcXNpB3aExEUabqsg4p5mPSyM+XP/kv/G7M/4E=
X-Received: by 2002:a05:600c:314f:b0:3c7:87f:6c7d with SMTP id
 h15-20020a05600c314f00b003c7087f6c7dmr6576761wmo.149.1666310254928; Thu, 20
 Oct 2022 16:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221020172643.3458767-1-namhyung@kernel.org> <20221020172643.3458767-5-namhyung@kernel.org>
In-Reply-To: <20221020172643.3458767-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Oct 2022 16:57:23 -0700
Message-ID: <CAP-5=fVehUL0YtVcn46nLNfpNr1UQ1dOvz2FixatQiDJkU3Ppw@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf test: Wait for a new thread when testing
 --per-thread record
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
> Just running the target program is not enough to test multi-thread
> target because it'd be racy perf vs target startup.  I used the
> initial delay but it cannot guarantee for perf to see the thread.
>
> Instead, use wait_for_threads helper from shell/lib/waiting.sh to make
> sure it starts the sibling thread first.  Then perf record can use -p
> option to profile the target process.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record.sh | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 952981481239..d1640d1daf2e 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -4,6 +4,9 @@
>
>  set -e
>
> +shelldir=$(dirname "$0")
> +. "${shelldir}"/lib/waiting.sh
> +
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
> @@ -96,6 +99,30 @@ test_per_thread() {
>      err=1
>      return
>    fi
> +
> +  # run the test program in background (forever)
> +  ${testprog} 1 &
> +  TESTPID=$!
> +
> +  rm -f "${perfdata}"
> +
> +  wait_for_threads ${TESTPID} 2
> +  perf record -p "${TESTPID}" --per-thread -o "${perfdata}" sleep 1 2> /dev/null
> +  kill ${TESTPID}
> +
> +  if [ ! -e "${perfdata}" ]
> +  then
> +    echo "Per-thread record [Failed record -p]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> +  then
> +    echo "Per-thread record [Failed -p missing output]"
> +    err=1
> +    return
> +  fi
> +
>    echo "Basic --per-thread mode test [Success]"
>  }
>
> --
> 2.38.0.135.g90850a2211-goog
>

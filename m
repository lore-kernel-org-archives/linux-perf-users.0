Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0623FC433B4
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 May 2021 01:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3ED96139A
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 May 2021 01:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhEEByn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 May 2021 21:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhEEBym (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 May 2021 21:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A58613C7;
        Wed,  5 May 2021 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620179626;
        bh=h+KJkkXd8mm9aMbh8d9KvdLNG16dIaMH5GjC8EEFxfM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FceiQbwfECXY3Y+EDutNiwlS/sKo4nuS3ZT50JX1k09NyPiNzFCYPhunSNzzS4Zm0
         K5lacfY29Tjat1MMpMDj+zUlfzQuB8uu7elxBzFn+ilU9fH6BxUOEUBuX3cVrW8ZBl
         qv/gmWOCnk2watryY7WblKNU7FMLqIn+oWPHucPgj0CloM16DbxNnqC7CVeeBma2Q4
         xcV1QiSLJzpbGeAVelV8CV7AeCJsgNLMjpIJ2iH4UOkNe0h/AZciaFlBz9LwH4GSFx
         9p8ilb9/oW3HyIYkUPWMiCtkPnt24qk8zqMtgRQXB6yNKnAS27xH4aqLad5T2wKLQW
         YiErAnbGL9RlA==
Received: by mail-ed1-f54.google.com with SMTP id s6so23193edu.10;
        Tue, 04 May 2021 18:53:46 -0700 (PDT)
X-Gm-Message-State: AOAM532nNcZY1npp1AqkpEMJQIsxDrHeaA1FP7coriDX5LCzoYP93I+/
        xypG5mUkuxuIy6R0v5biCfCVxefYC3KC8/gJBQ==
X-Google-Smtp-Source: ABdhPJyI3c7uBpmAncs+DaVUJueY11jmoNKzsrIWp22o4ulrvOaPBluGt+ZwUnLgb/kr0bBFTzYolal3fy7xplp7OJE=
X-Received: by 2002:a05:6402:212:: with SMTP id t18mr29477685edv.165.1620179625036;
 Tue, 04 May 2021 18:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210504194329.840964-1-irogers@google.com>
In-Reply-To: <20210504194329.840964-1-irogers@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 May 2021 20:53:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUxMOF_AhtDj7KuPmBzax-ZejSC76HNOOTr-Pq5fdj7Q@mail.gmail.com>
Message-ID: <CAL_JsqLUxMOF_AhtDj7KuPmBzax-ZejSC76HNOOTr-Pq5fdj7Q@mail.gmail.com>
Subject: Re: [PATCH] libperf test: Silence printf flag warning
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 4, 2021 at 2:43 PM Ian Rogers <irogers@google.com> wrote:
>
> __u64 maybe an unsigned long, it may also differ from the format
> expected by PRIu64. Add a cast to silence the warning:
>
> tools/lib/perf/tests/test-evsel.c:176:33: error: format specifies type 'unsigned long long' but the argument has type 'unsigned long' [-Werror,-Wformat]
>                 __T_VERBOSE("count = %llu\n", end - start);
>                                      ~~~~     ^~~~~~~~~~~
>                                      %lu

Which arch/compiler did you hit this? LLVM? Would have been 64-bit
presumably. I'm wondering how I didn't...

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/tests/test-evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
> index 288b5feaefe2..558097bbbfd0 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -173,7 +173,7 @@ static int test_stat_user_read(int event)
>
>                 __T("invalid counter data", (end - start) > last);
>                 last = end - start;
> -               __T_VERBOSE("count = %llu\n", end - start);
> +               __T_VERBOSE("count = %llu\n", (unsigned long long)(end - start));

I think I'd either change end/start to uint64_t which matches the
count struct and use PRIu64, or change them to unsigned long long.

>         }
>
>         perf_evsel__munmap(evsel);
> --
> 2.31.1.607.g51e8a6a459-goog
>

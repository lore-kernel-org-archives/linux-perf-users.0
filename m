Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE6EB64DD
	for <linux-perf-users@archiver.kernel.org>; Sat,  1 Jul 2023 17:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjGAR5s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 1 Jul 2023 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAR5r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 1 Jul 2023 13:57:47 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD584E60;
        Sat,  1 Jul 2023 10:57:45 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-c4e4c258ba9so163170276.1;
        Sat, 01 Jul 2023 10:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688234265; x=1690826265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I16kxq3liK2Om7mdHj2gKyKxAgwn/RzkolhoHDHOk8g=;
        b=TWVRdLj6o/pm7Ix9OmNdsJO8oN+rE1CJwj730IA81FEo2sibq8/EHtlPjzc0pK+oSv
         v+SxlhdygAN8QnIGUXxK2XHmeo77OzBOHApk/zGtfpegXYpJ+MUo/7LeppcDgPIBqIx+
         g39ug85rjFZx27eQmr2HQFFuZHacn9MADtnLGyNB43ENpXAsii26NCk4R34zkEoP8FFr
         IXeB75T5iwkcFblckWaEVd52Gy+Q0ZPPb4IZddk6T6/cX7HPUiAMRgWKkoxGNjJmiGfS
         ITxs/HsW6Van545Ap7DX1e7L3DANcVM6JJlqkXxDzABw5QcKChLvdMWq0Y6SOlgozztE
         7ddQ==
X-Gm-Message-State: ABy/qLYuZTyEXvT7xO4ADHNGveVdRiD2e/d8mDVGM07lqimCzTDJOSuj
        ksFkRzuUt7StQPSiMrbiTERRl2+rKBasrd3Phb5tZPU+
X-Google-Smtp-Source: APBJJlGdfSHaala4PPlYpMlKxHR3rnesWu7dB72jd7aIfzNXs6BgWLCLSLYQazAgxc6Y3rcGz1J1Ds6VQ4IyHQBHPlM=
X-Received: by 2002:a25:278a:0:b0:c1b:d362:4b49 with SMTP id
 n132-20020a25278a000000b00c1bd3624b49mr5421036ybn.50.1688234264743; Sat, 01
 Jul 2023 10:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230630080029.15614-1-colin.i.king@gmail.com>
In-Reply-To: <20230630080029.15614-1-colin.i.king@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 1 Jul 2023 10:57:33 -0700
Message-ID: <CAM9d7ch8GcZUXVEtPGh2QW8-_aiObq7ybU_7gY7LMcjRfOFvxw@mail.gmail.com>
Subject: Re: [PATCH][next] perf/benchmark: Fix spelling mistake "synchronious"
 -> "synchronous"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Fri, Jun 30, 2023 at 1:00 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in an option description. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/perf/bench/sched-seccomp-notify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hmm.. strange.  I cannot see the bench/sched-seccomp-notify.c.
Which tree are you based?

Thanks,
Namhyung


>
> diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/sched-seccomp-notify.c
> index eac4ef60090f..2e8205c61141 100644
> --- a/tools/perf/bench/sched-seccomp-notify.c
> +++ b/tools/perf/bench/sched-seccomp-notify.c
> @@ -33,7 +33,7 @@ static bool sync_mode;
>  static const struct option options[] = {
>         OPT_U64('l', "loop",    &loops,         "Specify number of loops"),
>         OPT_BOOLEAN('s', "sync-mode", &sync_mode,
> -                   "Enable the synchronious mode for seccomp notifications"),
> +                   "Enable the synchronous mode for seccomp notifications"),
>         OPT_END()
>  };
>
> --
> 2.39.2
>

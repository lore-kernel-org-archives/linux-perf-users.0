Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E27C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 May 2022 23:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiEZXFY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 May 2022 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiEZXFX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 May 2022 19:05:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4E3B03D
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 16:05:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z17so1749884wmf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+I9hUAJO0j4a5c/GJGmruQaMqz4ZWAD5gZXhmzliwZk=;
        b=J8QrwSxUZ0Y7ODCts54yutQBOc73SmK5IYpXH3ICitGPXNDjHRlGpHmDf8l3SuhXKz
         SN7RxuVMpmhvcJsEqXfH3Uv0hdEaAi3AU8Nd+ilR8AGPFH2zRUnDJgFqNb/jYdNacU8q
         GpjrJ3nJL6NN2XdQHIljDtvJ62Shi4brLJOGCA5dk39AcJRYM1YINhrM7BxjOxpbyZfr
         LzXVH4kEq7JsaEqgR19tVJvGUnCYDIkHgX5no7h4kWGG14DxfW3Ust4DXew3aNK3zqgd
         u8U1ZS6Qs7azv+Qv3ErS74Bj4F7Yd26BKzsh+rtaCWpzgH5LbKD4LzcDw5Q8CFCno5gm
         DcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+I9hUAJO0j4a5c/GJGmruQaMqz4ZWAD5gZXhmzliwZk=;
        b=0As772ekOcq5+oqZLqcIwo+72EUjb6Krc9BiISXaSGG2Ra+olngf30r5PsqRDLaJLa
         EnrvgPTvQvgAzX8jt4WKmWENcaSY0TMExDm4hk/bacSeEov/z7txntF7M42PAqa8A3hN
         i1B64mqjU9ERXacSzvrCjN4Ys/4Phri0kSaNkcCL4FTgaMqlNFBevaPShIvS7m+PNKd2
         E96vx19KhuO1Uq2LF6bRXE/YAMl1siUcVdHVx7OAj4vo6d1DakdntecbUkNgQxi0zeN6
         x/GrU9Yze/+xsPML1dxsvbnZJbcRZZH5U9nrKhsHiJ8ntwlmByahrSJySFDiD9uoa+7/
         xHDA==
X-Gm-Message-State: AOAM532WIqAHehRnySeXOH8rQldr0a0ET4xhtS8R5Z1xN650oFJL6BYj
        P6BxGynL9CxETDgroUGZwxEVmpRhH6w0YEeL71pQrQRmZbQ=
X-Google-Smtp-Source: ABdhPJwO46jPvSXUkurSbGSLyLEeo/2C/lV3l3eEc34OFVXrkgIBRP8Z90Nn6u2PSBqrAbkfg9eKLzMeBT4jF7iuRws=
X-Received: by 2002:a7b:c015:0:b0:397:3685:5148 with SMTP id
 c21-20020a7bc015000000b0039736855148mr4290330wmb.174.1653606320753; Thu, 26
 May 2022 16:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220526213136.193404-1-namhyung@kernel.org>
In-Reply-To: <20220526213136.193404-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 26 May 2022 16:05:07 -0700
Message-ID: <CAP-5=fXk35KSaNOSsymx=2=Yw5CG7=Rr3X0aRCFaTggfhts7dA@mail.gmail.com>
Subject: Re: [PATCH] perf lock: Change to synthesize task events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 26, 2022 at 2:31 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> With -t/--threads option, it needs to display task names so synthesize
> task related events at the beginning.
>
> Fixes: 7c3bcbdf449f ("perf lock: Add -t/--thread option for report")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index b1200b7340a6..23a33ac15e68 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1083,7 +1083,7 @@ static int __cmd_report(bool display_info)
>  static int __cmd_record(int argc, const char **argv)
>  {
>         const char *record_args[] = {
> -               "record", "-R", "-m", "1024", "-c", "1", "--synth", "no",
> +               "record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
>         };
>         unsigned int rec_argc, i, j, ret;
>         const char **rec_argv;
> --
> 2.36.1.124.g0e6072fb45-goog
>

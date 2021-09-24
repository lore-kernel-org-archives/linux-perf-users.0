Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE5AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 15:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4281760EB4
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 15:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346973AbhIXPJ5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346921AbhIXPJ4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 11:09:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D8FC061571
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Sep 2021 08:08:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i24so12520052wrc.9
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Sep 2021 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddIdnJJQzt6KCE2sdls+EVKfN4Fpq3cgwiHva/iq2vo=;
        b=R07NzMnHXoImrOjylse2riaepm/fUDAG6H+3urNsYdy7DtyR6DQLKlKLEryebJ9hTw
         BnGIM1bREVyCNihA2LIgeARwZg0qYezxMAdT5cz6pvSPIP6mDnqhAOTTccrTbvEhx2IP
         ThaFyWXNsXx95VbGwDuF0xHXDAk8KXTCKBJoNs8tMp7BJp4g009Pc6sGt1JTtKM+Q9JQ
         2dMNua+oLsL4AwBizsawN7FfHmhVBlLAyAD9lV1rEbMXnqbOONm3q8EGzo9j8KZHLHxh
         pvzEKziLd/NvU5V2phm4PyE+FozUQH38irfN7asU0uaxV8i5RGA/FxeWS7YQnBuMAwQM
         YXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddIdnJJQzt6KCE2sdls+EVKfN4Fpq3cgwiHva/iq2vo=;
        b=24wgV6ElJ9TxD4lvVuYmGUxXADZl3gGGbIiB5z5A0HBN2c6u4CyXPd4TWothIlHXmP
         SZ6z5ppahxW0ervzElCwQXiCcf4SQAqCfNZwQHgoUu0C9jAPqp67I+O6Iul0AatIWPl/
         MdbSfs5Z02PJd3xRcASgf6I+qIdzeGwBkZf6P6g67YthYlU4v5WEZkTKriQUF7CRvJbY
         1Xil+42c0q68MdxyVVgtiaK0kyOPRSrgV+0NHWqbmyBSUYXKgXZ9J/KHeboIcyb+vlQ4
         bIDUwpWqM5ioKippEm5umCuwIy2V2+Q4Q/mB0ENQt5M0g/WJkmhPjkpuCq1IwHCXgngA
         ed3g==
X-Gm-Message-State: AOAM533oY9WCIHnIRcxFI0K792lJOcA4ReP8L3YLRbI8mVf6B+eOOeWF
        6JPI6vOVf8PakJy4Hm9/Bzlq8zUupM5vaa1dpxRFRQCNv8o=
X-Google-Smtp-Source: ABdhPJyr4VODmsi8x1Q4P6qhekNJlvK9Ik/fVMP470V1zoNi6TDT90zRMm+XDKBECfyZ8uByjbOF1JkmHjTvUKWhKtQ=
X-Received: by 2002:adf:fe08:: with SMTP id n8mr12114792wrr.246.1632496101043;
 Fri, 24 Sep 2021 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210924115817.58689-1-likexu@tencent.com>
In-Reply-To: <20210924115817.58689-1-likexu@tencent.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 24 Sep 2021 08:08:07 -0700
Message-ID: <CAP-5=fW+Wn+_OcQWR8-UHQ42CsG6koZVw-UWBptQY8oYLsW=Vg@mail.gmail.com>
Subject: Re: [PATCH] perf config: Refine error message to eliminate confusion
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 24, 2021 at 4:58 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> If there is no configuration file at first, the user can
> write any pair of "key.subkey=value" to the newly created
> configuration file, while value validation against a valid
> configurable key is *deferred* until the next execution or
> the implied execution of "perf config ... ".
>
> For example:
>
>  $ rm ~/.perfconfig
>  $ perf config call-graph.dump-size=65529
>  $ cat ~/.perfconfig
>  # this file is auto-generated.
>  [call-graph]
>         dump-size = 65529
>  $ perf config call-graph.dump-size=2048
>  callchain: Incorrect stack dump size (max 65528): 65529
>  Error: wrong config key-value pair call-graph.dump-size=65529
>
> The user might expect that the second value 2048 is valid
> and can be updated to the configuration file, but the error
> message is very confusing because the first value 65529 is
> not reported as an error during the last configuration.
>
> It is recommended not to change the current behavior of
> delayed validation (as more effort is needed), but to refine
> the original error message to *clearly indicate* that the
> cause of the error is the configuration file.
>
> Signed-off-by: Like Xu <likexu@tencent.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 4fb5e90d7a57..60ce5908c664 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -801,7 +801,7 @@ int perf_config_set(struct perf_config_set *set,
>                                   section->name, item->name);
>                         ret = fn(key, value, data);
>                         if (ret < 0) {
> -                               pr_err("Error: wrong config key-value pair %s=%s\n",
> +                               pr_err("Error in the given config file: wrong config key-value pair %s=%s\n",
>                                        key, value);
>                                 /*
>                                  * Can't be just a 'break', as perf_config_set__for_each_entry()
> --
> 2.32.0
>

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E2C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8880261152
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhKHTAZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhKHTAY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 14:00:24 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3414DC061714
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:57:40 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id v23so5127660iom.12
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGJOYis+gviqxoUcyJaqUmqXmeZAJwJoCXfZHdsHcpw=;
        b=h+kLvfOxck6zzy3NuxkqHfXUzxSxjxiZC7U9HXX9AdtnPGUzj7CmA6hUJ7IE2PLgfC
         XvntadmSbvkYojWNDfRQpr+ddOQOOTCTEODrHMfUKF1zWQ26q2nrdIk6K4QDudU3u2VQ
         8l1oFowFiXJ5Z+GQMbSR7fII0xfnhSE2+2EX7fZPWnqtJxUb5aI4JB76VE27vXP6Wxcm
         AIsRmJ9EUkf115WV2k21dnMt/8TYdI4O6jrkUnoSC3YvcxBGjM0lW2iD9rdNwWw4TCa2
         /wpwhAVPhaskFqi8OPSVEHefX2tNGryk1VGDFQe635aJ89ldjeIgPQpzjZG022cyD4vl
         nWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGJOYis+gviqxoUcyJaqUmqXmeZAJwJoCXfZHdsHcpw=;
        b=U9Df5ZqU7//nWJDy3EGCDHiOzMeTo8xGc6TLK2znhsbeCSE1t8IRLwt1zC7lR/AIs2
         /ctaBe+bBKOZHJMrhAwuK2xP0QwWUuWIGrfYJV4EUSm0HGLAP6CHnSK/CRXyVvS8kMa/
         lzYF9b/HFgUNY5LdK8wTKllo/7GAcMukuRQKoIDicOgOfyN6NHWRmRS/NXUJgxk599Sr
         ygLF4Zj1KPtGtP1toAy5yUmlUB3yl0qUqjaLsF74f0LzYYDq6VZaYCO99I4buegqcndt
         pG+Ah2QtZhznNd8NWZsDNpdHC2JjhUT+C7hB8b2c3nkCxyqn4t7l+oPgThZFfrv9DDhK
         jw+Q==
X-Gm-Message-State: AOAM533na4qTMNOJfSTOaq3dG0V2bJE60Em3MYNGIfy3rw0BJJw/rqk6
        r/ZfIVs5gvfImpKO+SWZ3zREqgykLMSwDLyEVi+J/A==
X-Google-Smtp-Source: ABdhPJy8SyUSNSSO0ev9lDHGHdIAxY1uNUr1pzWe9u/0WBlRq08HV8Laj2hnSIrsHvsO+Mv8dDRFLlo+JTLQ3eDoI8Q=
X-Received: by 2002:a02:c559:: with SMTP id g25mr1014586jaj.123.1636397859461;
 Mon, 08 Nov 2021 10:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20211108044826.138781-1-sohaib.amhmd@gmail.com>
In-Reply-To: <20211108044826.138781-1-sohaib.amhmd@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 10:57:25 -0800
Message-ID: <CAP-5=fUc1uPti1MN3BZJ1JFus=ZYU66+gjh3bW30pUkE2sUxBQ@mail.gmail.com>
Subject: Re: [PATCH] perf bench: Fix memory leaks.
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Nov 7, 2021 at 8:49 PM Sohaib Mohamed <sohaib.amhmd@gmail.com> wrote:
>
> ASan reports memory leaks while running:
>
> $ perf bench sched all
>
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

I think you can add:
Fixes: e27454cc6352c ("perf bench: Add sched-messaging.c: Benchmark
for scheduler and IPC mechanisms based on hackbench")

This will then get the fix backported to older stable perf commands.

Thanks,
Ian

> ---
>  tools/perf/bench/sched-messaging.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
> index 488f6e6ba1a5..fa0ff4ce2b74 100644
> --- a/tools/perf/bench/sched-messaging.c
> +++ b/tools/perf/bench/sched-messaging.c
> @@ -223,6 +223,8 @@ static unsigned int group(pthread_t *pth,
>                 snd_ctx->out_fds[i] = fds[1];
>                 if (!thread_mode)
>                         close(fds[0]);
> +
> +               free(ctx);
>         }
>
>         /* Now we have all the fds, fork the senders */
> @@ -239,6 +241,8 @@ static unsigned int group(pthread_t *pth,
>                 for (i = 0; i < num_fds; i++)
>                         close(snd_ctx->out_fds[i]);
>
> +       free(snd_ctx);
> +
>         /* Return number of children to reap */
>         return num_fds * 2;
>  }
> --
> 2.25.1
>

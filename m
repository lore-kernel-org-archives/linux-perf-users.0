Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9968C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 05:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FF26101D
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 05:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFVFRP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 01:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVFRO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 01:17:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD74C061574
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 22:14:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso855417wmg.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 22:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igBGOSIDZ6LxhaMTJqFN/2gXteF3yCVxKqpvV2Tb7pY=;
        b=vD7dwf/4rkdpgtOXKkGYx767Gxcjk6eeTkyEDZUnB4GqZNVnyUBIsj7SK+9C+8EZiO
         KalzugQBEFZpBmiHcrXPBAJEUXPlMYIE4+8337qG+T3wc/WK47QJW5+emCp3992hH88Q
         tIFMOpd3MqKkY/hdDhbaL93Rr3UBgKeRMRUyQFZV7uPfBDFLLMHy5BRN6dw5hX9akDDv
         ostfer+4D9LbBnrEsSen9fvQyXzlfO1feevZmx+VQYoUiLkbBAJbFenLeMQzsQuleiK8
         tfKgaJeRQKdBrftkc350XmtFnco2aBSVhdyiiVfMrY/KGXE7dZrYPaHrb6q82ejan5ck
         mF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igBGOSIDZ6LxhaMTJqFN/2gXteF3yCVxKqpvV2Tb7pY=;
        b=LRNG86Kr3LQ6nZVZLRqI1GUafMHupoVl0zkMQ7OQF3lSnYQSPcKzCx0lXXgATNLpNh
         YVziYsYD/nI82vuEsr/Y3p+14kaCk3qmSjP654YkHUCB4F2jnExoDGmQFUua9MR5kVEu
         aSRfaeyLfSWWvdQo0xHf8WD74BzuRhyLpoplvZA4xesHk2WgDbYregjuhmkmPB+Qfw+F
         PEXyZKn9yKsAUB9FICY9X6C3jYOGlgkTrv9uqCcZmh/SvpiaSqYrqNNXTNFfGgLtoxpI
         vJ2HKqnWt4Xa0GH/FjRtMpXi0/dBDbsWjnCB4wZsB6zz4LvGTb+Jf+5sSR3CbMGejj87
         mo/w==
X-Gm-Message-State: AOAM533I5Xph3Gdv3KWl7XOhsVz/VqYe9B7mfGhiXu77Qq2mY9o6zh9/
        +WyRuZIVuOPpddtE4qWLPRBY3guyGlcSIjV8+cR4uA==
X-Google-Smtp-Source: ABdhPJxj+feurhsVkQiK/14lZiavLlEBqqrgJ0pC0rPrD79zp8cVFXFjinFHqzYYF2xyQMO5E8wD5MO8Gak5cqLAWtU=
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr2316395wmi.58.1624338897557;
 Mon, 21 Jun 2021 22:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210621234317.235545-1-rickyman7@gmail.com> <20210621234317.235545-3-rickyman7@gmail.com>
In-Reply-To: <20210621234317.235545-3-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Jun 2021 22:14:46 -0700
Message-ID: <CAP-5=fUGRdj=G6=srwoATWMimK5tB4X2Sxa64tTVk_JRwMJdWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf script: delete evlist when deleting session
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 21, 2021 at 4:44 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> ASan reports a memory leak related to session->evlist never being deleted.
> The evlist member is not deleted in perf_session__delete, so it should be
> deleted separately.
> This patch adds the missing deletion in perf-script.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 1280cbfad4db..635a1d9cfc88 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3991,7 +3991,7 @@ int cmd_script(int argc, const char **argv)
>                 zfree(&script.ptime_range);
>         }
>
> -       evlist__free_stats(session->evlist);

Should this be removed?

> +       evlist__delete(session->evlist);

If the perf session "owns" the evlist, would it be cleaner to add this
to perf_session__delete?

Thanks,
Ian

>         perf_session__delete(session);
>
>         if (script_started)
> --
> 2.31.1
>

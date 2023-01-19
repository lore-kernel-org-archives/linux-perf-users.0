Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A6CC004D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 16:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjASQJr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjASQJl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 11:09:41 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B01B7
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 08:09:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g10so1943037wmo.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRlMrkR813xw68s+TrVy/K2U/XUSkpo54/blrWaVIz8=;
        b=F8Y78D/7lzBjdsiNq9oK2Aftmae0V2KIdzDV5yS2c3II/xVuoPuP9vZUsrzfVxdKRP
         3NO7XK9isDeRq4lGjY59X7D7klL/AWxqhuhSwJst4QRVPPz9wDlcoYKJvD48ghFGdOYE
         Eg8mqKHPfxxA7wSRdz2uEfqK/EgMEkVCCwmuOn4L6oFlFucegxSDQruJ/beTxqg3fGWg
         hB+dTGqwGM79sscfICtcqmWCXbwz767MyRfb03hbpgtPG7WwCrJ3C08rii/vG9ts4jBQ
         evwulTau7Wet3DMhcSPkrLQqUX6PI/0sxOz2RXdZ5bCSIizzTh0ubm2XNzqTxvEJd+Pu
         G85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRlMrkR813xw68s+TrVy/K2U/XUSkpo54/blrWaVIz8=;
        b=oZFAsk8kp2R8v9eG+c1jCy6fUp8K5XjXXet+E+eHFO7zeJSchhNTlB0vZpgGQ0F1f7
         aZCy17I2EYi2pEx7FjHQ7yow3XqhpOunG9HsQcAHlW1A6Emrm0BfQLgvN2SBq3hxyKEO
         8BirhWKITxT6zz1kYOVksDddhcSSTjp4I2TUU4uFuBSlfNOniVFbUn6eaS7hoFRGr+bJ
         YGBAY7MFz/xttqSEBSGINweVm99A1AcoJX1aOsXH3lPqajFxjs8AcDrnWqiPggJxqBuQ
         PS78sDanM+RqokKeiFw/V2tT5kKFFQ1hhtuUje0Gh4+vJ0a/NkrqqVUNPXJTP6EdH6BH
         Mo+w==
X-Gm-Message-State: AFqh2kpZNeq9S7WKtCNzJPYK6ciGZb5I8nAzCtrh7DM39oB51AwpOjFs
        gWvdsQsJCSxZK4RKoUMq4dRYgKWEg/H84O5uasAc8g==
X-Google-Smtp-Source: AMrXdXs82Lfvn39C8FUbgYvVTafPAnd33NZRzk0q5hkSRux34CNUZPOOgIn6fTLI2LgZiQwTLnCbVssAGAuKg9RyXEU=
X-Received: by 2002:a05:600c:5405:b0:3d0:50c4:432c with SMTP id
 he5-20020a05600c540500b003d050c4432cmr671355wmb.67.1674144572770; Thu, 19 Jan
 2023 08:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20230114215251.271678-1-irogers@google.com>
In-Reply-To: <20230114215251.271678-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Jan 2023 08:09:21 -0800
Message-ID: <CAP-5=fXJ3oG3GmG7puq+n9W3mQYfmdx37jq548Wf1_6hcpja2g@mail.gmail.com>
Subject: Re: [PATCH v1] perf test workload thloop: Make count increments atomic
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jan 14, 2023 at 1:53 PM Ian Rogers <irogers@google.com> wrote:
>
> The count variable is incremented by multiple threads, doing so
> without an atomic operation causes thread sanitizer warnings. Switch
> to using relaxed atomics.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/workloads/thloop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> index 29193b75717e..af05269c2eb8 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -20,7 +20,7 @@ static void sighandler(int sig __maybe_unused)
>  noinline void test_loop(void)
>  {
>         while (!done)
> -               count++;
> +               __atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);

Ping. No functional change, cleans up a lot of thread sanitizer
issues, the use of __atomic_fetch_add is consistent with other files.

Thanks,
Ian

>  }
>
>  static void *thfunc(void *arg)
> --
> 2.39.0.314.g84b9a713c41-goog
>

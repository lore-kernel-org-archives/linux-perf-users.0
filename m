Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFD8C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76857611C9
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 14:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhHXOiE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbhHXOiE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 10:38:04 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F44C061757;
        Tue, 24 Aug 2021 07:37:20 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n126so28177135ybf.6;
        Tue, 24 Aug 2021 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MRebzfdJOp7jfrcpL/FM2xLk9BBQctQ5lkdEQBZyiE=;
        b=lUnmzjsSKekeg4RrPHvJL4hAY0dkCJBUVuO/Y3K99H1Ij3PpHtzCymd2Cv54aWYVUs
         MR1ergB1cCMRNFbIAs1plvFg2CmLH5xTlzR3fTQtcQcjB5xo3Z/SPJfaWocFseERyQc6
         U4kxWzLtdbm+5KqfgFqhQPVHujjTMNyYsYmkkV5WesNTQd/cy29ypPe+1ieBK6hTcnqp
         13YjAhhHAuQuUSZa0gdedN/xLa59/qfEnLSaa9qcYkq/+oTg9bU1/efD3IQRZVDFwrBl
         7UyN6pB9zdduy5vqtb5VwMk62oOJKT3rLyraZt5n4NPWNlc/l/5eFi3PojoH3peBf6cg
         vK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MRebzfdJOp7jfrcpL/FM2xLk9BBQctQ5lkdEQBZyiE=;
        b=UNZxNV4twpPu5b7QmLFRUESu/bsB/Jh4BIkMinPKCnQinvsC5wK5AhvhDPNBGBBrqD
         FQdc/ztWxU1CFNNa4utDPAiZoHPQ6VlahiaGTzun+bPwLjG5BfVyPIn89YNueWYpqPGK
         soDwlDs2T79QABQEVWw+Xk21Z/pMIAZ8Cf/xfNeSeDO5s+h/5YJ/loJ5CpE1rdrooDqi
         R2mVr1B3btsu0w7Vt3D/ub3Bdmf1e3EVnWIedSGbB+83eY4FfNzzio9RJ3hOa1TU5u0/
         ALtgLa+KYu4SKFKFz8c8jfIdUharcvU8MH6kJyR6nW62I7Tvrpcpm77Fl1AckLWMKuEW
         yEvQ==
X-Gm-Message-State: AOAM533Vp0nWV/JV9zKkpe8oZVeGu/Ohby6rwu070LpOuNIMeIQt93Ai
        Bi9sHk3gNenNH3aXfierpDt9yaS3NqPOz6ZWgiU=
X-Google-Smtp-Source: ABdhPJwKJmy4aqa4MWNoqDJiNS836xhXqLuUfoxvfZlxGsRtGm4/gB4+91sxR70u6FjJEi3JwghTzxN4YtmwKywnuAQ=
X-Received: by 2002:a25:b948:: with SMTP id s8mr51178619ybm.281.1629815838270;
 Tue, 24 Aug 2021 07:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210824085947.224062-1-nghialm78@gmail.com>
In-Reply-To: <20210824085947.224062-1-nghialm78@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 24 Aug 2021 16:37:19 +0200
Message-ID: <CAKXUXMzbJRHyUpFLGk8SBJHrkmkwq4VtfXmgvZtUBJGiED8qxw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add missing newline at the end of file
To:     Nghia Le <nghialm78@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 24, 2021 at 11:00 AM Nghia Le <nghialm78@gmail.com> wrote:
>
> Add missing newline at the end of file parse-sublevel-options.h.
> Thus removing relevant warning reported by checkpatch.
>
> Signed-off-by: Nghia Le <nghialm78@gmail.com>

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

This addresses the only instance of a "no newline at the end of the
file" throughout the kernel tree.

This is part of a larger effort to identify all rules that checkpatch
warns about and that are never false positives (compared to the many
rules in checkpatch that are heuristics or are known to be ignored by
the current development community and hence, cause many false
positives). We could use such rules to be enforced in the submission
process.

Lukas
Lukas
> ---
>  tools/perf/util/parse-sublevel-options.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
> index 9b9efcc2aaad..578b18ef03bb 100644
> --- a/tools/perf/util/parse-sublevel-options.h
> +++ b/tools/perf/util/parse-sublevel-options.h
> @@ -8,4 +8,4 @@ struct sublevel_option {
>
>  int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
>
> -#endif
> \ No newline at end of file
> +#endif
> --
> 2.25.1
>

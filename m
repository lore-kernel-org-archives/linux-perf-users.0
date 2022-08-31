Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0035BECAAD4
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiHaQDx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiHaQDB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 12:03:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C62B2760
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 09:02:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay12so7607891wmb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1bB7tQtCppbl15pSiTQsgDbN8ntnJOFVfGoL4e77fQM=;
        b=MlISibdNRllyuJ2XZ0NiDnL5OA7Oxj3FtEBi7U3GDrhDg3Tg7juqQpBFWGw3TXRBSr
         +NbervZgo2ypCctTi9mHrQINXCWoKyrSvxM9P5fUBo8E2i8U0xVwtsPubRQixRq252TD
         vqi051fEgRvSsSeoR1DmtRNvyWYRGFjSUQUNouI5cxXw8BvzTY4D4AugObg4tJnVxYXW
         AXV23giSr6I+gnZ2AyU6tX+GFw6M25+WFpGRaxpLgB2GS84fjxIhC7NU5I3JspWVghpx
         JViNTMHE8WFO/bgnGuj/TYMnOz1BRcAQWX2Sxvf1nBmWu1032C9u7k3IzplCJscd0/vC
         zR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1bB7tQtCppbl15pSiTQsgDbN8ntnJOFVfGoL4e77fQM=;
        b=6T4pDJzHlqhRRbpwAvhFc5i2zZrBXaqNZpRFrzRDhvZnbtMZLL306Ycom88HsY50NQ
         CHmtHfkY6ZAi31lZZZpHT25ILd/L08PbR2IN91EGq3Wg/xg4K0I1qi74b6l9Vxe4AA6I
         TEkRfas4vRB27qugEXVDuHZf+q6CWSVW1CfkVMS/GpCMK3tDaE75Y0z0PvxjXuZApxbO
         fKT8gGG09E7SCrg+nMIc9Lxj/8e7g1CYQG9D8M2CCa/TG/AcChEuZ1uqBY1pZJyElxtc
         mBzCMaGyU3bUeoWgdHlMR/OtQKLoIFfXwdUv3v5fywRT7HeUfP7oHlXIYSKc4iM2I81o
         Y+1w==
X-Gm-Message-State: ACgBeo3yysVoYEGfRfxojnzA9Zz9XoQe61Fftt2B4incWoeo3YaXXQcU
        GNwrJ7ZprbgXkit1bzv/bUXvYGdHiSpuOxyzM7likw==
X-Google-Smtp-Source: AA6agR6WdXjH4ZbfUSKI+Ue/geK+PwtjHMwxl+GrSrxpX7Jk4KDVoHR8IIJumtHTPQSrrU97y4H3qhEaOM4OMWlmugU=
X-Received: by 2002:a05:600c:1d89:b0:3a5:c1db:21c6 with SMTP id
 p9-20020a05600c1d8900b003a5c1db21c6mr2337210wms.174.1661961778110; Wed, 31
 Aug 2022 09:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220831124041.219925-1-jolsa@kernel.org>
In-Reply-To: <20220831124041.219925-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 31 Aug 2022 09:02:46 -0700
Message-ID: <CAP-5=fX-=ph8g3VKbQXSRT8SiOZ3XqQLd3T9-ZTNZ5L+ye5L-A@mail.gmail.com>
Subject: Re: [PATCH] perf script: Skip dummy event attr check
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hongtao Yu <hoy@fb.com>, Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 31, 2022 at 5:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Hongtao Yu reported problem when displaying uregs in perf script
> for system wide perf.data:
>
>   # perf script -F uregs | head -10
>   Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.
>
> The problem is the extra dummy event added for system wide,
> which does not have proper sample_type setup.
>
> Skipping attr check completely for dummy event as suggested
> by Namhyung, because it does not have any samples anyway.
>
> Reported-by: Hongtao Yu <hoy@fb.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 13580a9c50b8..304d234d8e84 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -566,6 +566,8 @@ static struct evsel *find_first_output_type(struct evlist *evlist,
>         struct evsel *evsel;
>
>         evlist__for_each_entry(evlist, evsel) {
> +               if (evsel__is_dummy_event(evsel))
> +                       continue;
>                 if (output_type(evsel->core.attr.type) == (int)type)
>                         return evsel;
>         }
> --
> 2.37.2
>

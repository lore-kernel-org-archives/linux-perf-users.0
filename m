Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09336C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Jun 2022 06:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiFBGaU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Jun 2022 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiFBG36 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Jun 2022 02:29:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87295215647
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Jun 2022 23:29:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k36-20020a05600c1ca400b0039c2a3394caso548835wms.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jun 2022 23:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YelJ7CCreQmy3LEGRUSilTCgpyHs8nhPLMj9VKZiOfg=;
        b=g1Exk6v42WEZw7CNsa94Cc/XAphgpPy5Z3oPKJbm0y3WbQkDQUfuQ0KT570ApMnsuc
         HCFoPUzAAqP/rVkkSwiTpC8U9tjxuk/C7md7o7wQHAhVmppP66w9Iu0OyYcd/BuGr5Bx
         reYZ+9Sjb6aTe+eRjAKsJ9P+Qf6vr1bZ5iywSrTBgAh+w+WEZFs7nPCup2bEFP7L+xSG
         a/AM0aN1HiZYFy9oMszfEK4/jjcssTFXdELFMw/pURapsP2JBLmBXLizxdOHpVoJhxKU
         f1WMqLd4/WgNP+mDs1bSgDa9MlIQefk4E0xzJksCo5dba13LkpOEXGNfJnZp46nsOP4m
         H36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YelJ7CCreQmy3LEGRUSilTCgpyHs8nhPLMj9VKZiOfg=;
        b=qe9/ZRM/wgjPlqObc07bd1R6oBQ+xYcaOrIIuuCy2GifUXZM3H5j4HzGmv2E/tHzDK
         BjKJvjHtVtRYyH0giBtGt0m7iY3HF3Q2822eQMHEGaf1FiS3QYDOYA9xJduMIn7qvI2J
         MHEFxZqrHfMFkrt+UVtcy0KnxTJCrUn1DCPKi/Bov9ZzKNrMXaI+sIYOlHYnj/EGPRL7
         k5sUB79gp3tUUM+hwHE6MMMdMNJ6Z5VYQbSmnP+vgwOLZxRjTsyf9t/M7XH8SVp0xMWC
         4cbHOUCWABDvipd5c7j2ZK2yd9CXB9CpRCi9VS9h0UFyqhXuzsjZfFy2akQm9KiJ0+DK
         53dA==
X-Gm-Message-State: AOAM531Ax3EONtDNAwbb0blqcG5Tu8qCfeQtQbjiBiKAqYEN77W+P9Qc
        yRzCalv9/i4HA1RmMPGvn8+FY0KMWuYHu1LfRNEpqQ==
X-Google-Smtp-Source: ABdhPJyhC9IwkNaVoA/8lUhrcex3ARi3KFqnEPvZTJOvV003I0ksaI4Is5OS1GaQMFESZ3+Wah1vN0WOPPm+45Hh69I=
X-Received: by 2002:a7b:c015:0:b0:397:3685:5148 with SMTP id
 c21-20020a7bc015000000b0039736855148mr2537675wmb.174.1654151395794; Wed, 01
 Jun 2022 23:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220601065846.456965-1-namhyung@kernel.org> <20220601065846.456965-5-namhyung@kernel.org>
In-Reply-To: <20220601065846.456965-5-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 23:29:42 -0700
Message-ID: <CAP-5=fVniyi3dtvH=-0h9ugmkcanyMa7wdxwrPR4OkFdws=x_w@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf record: Allow to specify max stack depth of fp callchain
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 31, 2022 at 11:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Currently it has no interface to specify the max stack depth for perf
> record.  Extend the command line parameter to accept a number after
> 'fp' to specify the depth like '--call-graph fp,32'.

It is valid to have call-graph=fp as a modifier on an event. To
support a depth with that we couldn't use ',' as it is already the
separator between modifiers. For consistency maybe a different
separator should be used here?

Thanks,
Ian

>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-record.txt |  5 +++++
>  tools/perf/util/callchain.c              | 18 ++++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index b4e9ef7edfef..d2759e2ccf9e 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -275,6 +275,11 @@ OPTIONS
>         User can change the size by passing the size after comma like
>         "--call-graph dwarf,4096".
>
> +       When "fp" recording is used, perf tries to save stack enties
> +       up to the number specified in sysctl.kernel.perf_event_max_stack
> +       by default.  User can change the number by passing it after comma
> +       like "--call-graph fp,32".
> +
>  -q::
>  --quiet::
>         Don't print any message, useful for scripting.
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 5c27a4b2e7a7..7e663673f79f 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -31,6 +31,7 @@
>  #include "callchain.h"
>  #include "branch.h"
>  #include "symbol.h"
> +#include "util.h"
>  #include "../perf.h"
>
>  #define CALLCHAIN_PARAM_DEFAULT                        \
> @@ -266,12 +267,17 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
>         do {
>                 /* Framepointer style */
>                 if (!strncmp(name, "fp", sizeof("fp"))) {
> -                       if (!strtok_r(NULL, ",", &saveptr)) {
> -                               param->record_mode = CALLCHAIN_FP;
> -                               ret = 0;
> -                       } else
> -                               pr_err("callchain: No more arguments "
> -                                      "needed for --call-graph fp\n");
> +                       ret = 0;
> +                       param->record_mode = CALLCHAIN_FP;
> +
> +                       tok = strtok_r(NULL, ",", &saveptr);
> +                       if (tok) {
> +                               unsigned long size;
> +
> +                               size = strtoul(tok, &name, 0);
> +                               if (size < (unsigned) sysctl__max_stack())
> +                                       param->max_stack = size;
> +                       }
>                         break;
>
>                 /* Dwarf style */
> --
> 2.36.1.255.ge46751e96f-goog
>

Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312C4C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Nov 2022 17:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiKQRRV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 17 Nov 2022 12:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiKQRRV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 17 Nov 2022 12:17:21 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44353781AF
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 09:17:19 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id k67so2226094vsk.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Nov 2022 09:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+G+jefr7ymw5kyDWKXEsX2UJzRRuDh3ZeqTuoucnosI=;
        b=JkGyuBGgxo9i85kQpqZ5qcTcAXTZgX+0FucJmoLGVURLvPyw3ktPx8juDetuvyJGpP
         KnxHThmpS+6vJMTzxkmavPjHquGZRhlxtepePATfV+d+7I5rURj7vSTYRGo0Is6PaaBr
         +9MKfu80+K7LRoiN6XbLBiSyUyBfVSSymRCRP+H/A9xAnU8UeSfRmXM53GuEpQVWbIn1
         3GG4QzjC7duHxLKukZcKDyYlP3H7jIPMJ9MwWoyinM7XG78psdqigRcOt0jV9+Vu7AUX
         WjVtvGBm1DK5qj8GtXPtRs0wYoW0DknwokeCm4hclKH1ge0XZUf9x817ppsEtvLQE06K
         Hz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+G+jefr7ymw5kyDWKXEsX2UJzRRuDh3ZeqTuoucnosI=;
        b=gJW7R6kXLX1vkGszdUHFI5Yt+Q4rYy+C6XmQZpAjAAZvTcoxzuXzwjY/34axN8B3jS
         I5fbOioESGHpOaN10gzffZAkAHM5n4+ZkkdtMKkjz3km0yGOsqQJGKnih0Iga/GMqYEd
         EpyravESJ4to+va91TiqT1YkcIngqCb7TSwEX34lrdsEbJqn8hmfZ5LTEat/9IjuZTsg
         j7xrUkemj3WEPZbmr3C8jSaQt89ExOKQK8DjeY2iVodPgSbcJHEk8fZz1z2dgNMxeOpU
         2UIM0GBOM4RkAQqcB6+5FZRROfbgYtLf9e8zNd/JxXZMsns9EVsT6CdJm+z+uUE/xjIe
         7Fdg==
X-Gm-Message-State: ANoB5pmbAtz+haTnRVbl80Hv3Wu38fzvhju6x8dm1oEpcPJQMSRhcCaD
        ek/jG5uBYV0xt1yQ+2kRnwAv30vADYsnLviiTTm3xg==
X-Google-Smtp-Source: AA0mqf6o5O8WcF98p+5ZxX6+tjqqIRX8IpB/mR0JAvkF5WAWpALeNCUqSrpNVB929I1pm0qQyZJze9O0lMFdO7HygNM=
X-Received: by 2002:a05:6102:318e:b0:3ad:1459:6936 with SMTP id
 c14-20020a056102318e00b003ad14596936mr2266833vsh.23.1668705438144; Thu, 17
 Nov 2022 09:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20221116233854.1596378-1-namhyung@kernel.org> <20221116233854.1596378-6-namhyung@kernel.org>
 <Y3Zb+JChHoq+89yM@kernel.org> <Y3ZeOuNnk0xclY2x@kernel.org>
In-Reply-To: <Y3ZeOuNnk0xclY2x@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 17 Nov 2022 09:16:58 -0800
Message-ID: <CAP-5=fVh0cQDeqSgVkLHbuiZKoFAp628oggQKwN6KxfUusA01Q@mail.gmail.com>
Subject: Re: [PATCH 05/12] perf test: Add 'leafloop' test workload
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 17, 2022 at 8:15 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 17, 2022 at 01:06:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Nov 16, 2022 at 03:38:47PM -0800, Namhyung Kim escreveu:
> > > The leafloop workload is to run an infinite loop in the test_leaf
> > > function.  This is needed for the ARM fp callgraph test to verify if it
> > > gets the correct callchains.
> > >
> > >   $ perf test -w leafloop
> >
> > On fedora:36
> >
> > In file included from /usr/include/bits/libc-header-start.h:33,
> >                  from /usr/include/stdlib.h:26,
> >                  from tests/workloads/leafloop.c:2:
> > /usr/include/features.h:412:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
> >   412 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
> >       |    ^~~~~~~
> > cc1: all warnings being treated as errors
> > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/tests/workloads/leafloop.o] Error 1
> > make[5]: *** Waiting for unfinished jobs....
> >
> > I'll try removing the _FORTIFY_SOURCE
>
> Works after I added this to datasym.c, leafloop.c and brstack.c:

Is there a reason we are compiling without -O ? Perhaps we can filter
setting _FORTIFY_SOURCE so that it depends on -O being enabled.

Thanks,
Ian

> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> index 1bf5cc97649b0e23..5d72c001320e3013 100644
> --- a/tools/perf/tests/workloads/leafloop.c
> +++ b/tools/perf/tests/workloads/leafloop.c
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#undef _FORTIFY_SOURCE
>  #include <stdlib.h>
>  #include <linux/compiler.h>
>  #include "../tests.h"

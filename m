Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B406EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 17:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjFVRwH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFVRwC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 13:52:02 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD06E2119
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 10:51:59 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40079b6fc56so17101cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456319; x=1690048319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ifv1YUPmw1rjpLUO+8aVeXi33WHx57kQP10Eiyc8BEA=;
        b=pGzyPDsoR6Nbo7+IzntkkjGoXkt81sNnpQwcP3ovN6BKmelaTC1JjasVAivbsJHzaE
         C+aZurEqMUzrl0bXKj12AifXNNgcsl+LiltItThomF+er0kfWKRuFtaGRbj5AznKHq9a
         2W6rcyhOz1E4wUjUZhVoPemF4VvcSwBnJrpDF6J7tUX6GPONK2k36ghPfCeFs6er5YrE
         1w3KA0T96jOu9XktG6kdRT6EV98M+F2TmnVhjfowpUP4GNDCBQgwSAsKa03fDOAu8fbo
         Pyq2bvBvdaKXoUVwgTylOO0ZK8fqV4zwLbGQTbrlsJv62t5H3YXrXCUycjsQRxdCHGkr
         cu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456319; x=1690048319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ifv1YUPmw1rjpLUO+8aVeXi33WHx57kQP10Eiyc8BEA=;
        b=iv4rklYCrH6cbPWHjKIMn0iCpnJudvik5aLHBuyglx2MODx3mVTxvQtf11NcIFLq0z
         jhKua7N22o5FHIlIVtMcnDl9yMVIqt+rCW9rE7Eb+OxAGI5m3eDfoNhKoUgftjGw+sd6
         ZP0eXIw3D0wCG3oNGLRwK21Mjz8KgYePdQekZVtn6x9FXZ7WKkRaSuH5jvTEvqTW2h4T
         41m97WukDHAoTYvaqbkELNlWnNUKn7v6EGBRGjLMhUYHMKJ9OK6AYZC7EVNrsb72AkuL
         OKiuMyZ9eoI5gRln6GDJx1FKoeFrmV0tHGboLNU+ZkG3rTPmu9tk0vIh8i9dLeD04DwK
         C2yw==
X-Gm-Message-State: AC+VfDwvOlDnWxDwuPLIZvRwf/ph02TUtqhJiwzKANYsJI/z8aDAaAzk
        9NR1hDvvvTp8LAtg/GzJ6F0XwXECtBX6wDa+lb6ZxA==
X-Google-Smtp-Source: ACHHUZ71FvU230Se7n3GVJjL4GWx8zZOuTGUI5jfFA0uvZhPg6EGRRNpWDeLiJfUVTmaj8xi9mhdtTj2G86YUV9Sq3o=
X-Received: by 2002:a05:622a:1212:b0:3ef:302c:319e with SMTP id
 y18-20020a05622a121200b003ef302c319emr986668qtx.8.1687456318813; Thu, 22 Jun
 2023 10:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230622055832.83476-1-namhyung@kernel.org>
In-Reply-To: <20230622055832.83476-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 10:51:47 -0700
Message-ID: <CAP-5=fULkA2G7xWVH9okqEmYMFW_HhjFvtkoxid0YLngBZP4Dg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Remove x permission from lib/stat_output.sh
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 21, 2023 at 10:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The commit fc51fc87b1b8 factored out the helper functions to a library
> but the new file had execute permission.  Due to the way it detects
> the shell test scripts, it showed up in the perf test list unexpectedly.
>
>   $ ./perf test list 2>&1 | grep 86
>    76: x86 bp modify
>    77: x86 Sample parsing
>    78: x86 hybrid
>    86:                        <---- (here)
>
>   $ ./perf test -v 86
>    86:                                                                 :
>   --- start ---
>   test child forked, pid 1932207
>   test child finished with 0
>   ---- end ----
>   : Ok
>
> As it's a collection of library functions, it should not run as is.
> Let's remove the execute permission.
>
> Fixes: fc51fc87b1b8 ("perf test: Move all the check functions of stat CSV=
 output to lib")
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/stat_output.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 =3D> 100644 tools/perf/tests/shell/lib/stat_output.sh
>
> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests=
/shell/lib/stat_output.sh
> old mode 100755
> new mode 100644
> --
> 2.41.0.162.gfafddb0af9-goog
>

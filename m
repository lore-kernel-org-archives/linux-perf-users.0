Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5053C77B73
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 00:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbjD1AbO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Apr 2023 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344425AbjD1AbK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Apr 2023 20:31:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771513C17
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 17:31:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3ef31924c64so861891cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Apr 2023 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682641867; x=1685233867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy6q1Uw/rxLS8q/AocKwbxiAauTqjXmfHidYdOpgsqM=;
        b=JXKU4b+U90dgO/Ta/QdlyHd/lzn3aMWg5xXfrolixS57yjrjZMN7DkftL2lWJ11pSh
         2qGk0aH1I99gxty1TLcyPbogXp86SemMWDwvFXmJkrSLov3OrClYOUSnAzmAqLV4LyeE
         ZrZXKP1bXJZYHg6akMr58OxR09ODB8em9pFFd1QUQn1uxASsWnekxW1ncz1q6w4bLvuD
         B/dcwNTLyQvJzEghALAi1Axiw2b8OdVkZf3/4EX9uI5Ek5P3ztLpLg0dq24Nfk6RD+9q
         clxjqY2CN+vUURKMdz7wBwHTAImHtDcUNlC+9qSYxdZ+zTAkF998NxNl3NU9Aq0oePbZ
         Uj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641867; x=1685233867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy6q1Uw/rxLS8q/AocKwbxiAauTqjXmfHidYdOpgsqM=;
        b=RizwMDhGqdbBfx1sCda777DHE+qOEjMTYata3qNOYsqvKqN8+Y5tSejLZSjS7KkqKm
         pRKnoTrkrqe8iXb5PbmUB3hVtMfNd1dY/RPWDkJMBHTKnEk0mAf0lAEm/U+RLBbt6g3Y
         fJfHvO19vRAGnjo5DZCI7u1PkwgSCILHTkSxeXIkCVpXPy/ZFUOeu/XtlB9xug8YLPXV
         m161PdjuVb9KWm55Xxt/mSBOabuVsRVCWmB0LILGbzCDKQ87AOYcRP7emRbvpMQjlQtE
         wRA0lxM7+lSE15DM75R6AAJNsKGZxYlFmGjf2PS0lLoUE81gktpBwoleSaMHJGSAmMzp
         MPWw==
X-Gm-Message-State: AC+VfDxzOZ3QTinJ7h3wjYEagUKOSNEx8aZBX90L5QrY2KEeDohvTfu+
        c2BMzmQED0whk0HwB1zAoGD+EkNNTRhNBO5yDb5lZw==
X-Google-Smtp-Source: ACHHUZ6YUZq16ghUneoCyRK/P2KfDaW6PBgRcn1DMBDDClNjX9CSr3oydqzMpvQFL+dJJxuxbgd/YqNGO2XGW5nEWK8=
X-Received: by 2002:a05:622a:1447:b0:3ef:404a:b291 with SMTP id
 v7-20020a05622a144700b003ef404ab291mr65560qtx.7.1682641867235; Thu, 27 Apr
 2023 17:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230427230502.1526136-1-namhyung@kernel.org> <20230427230502.1526136-2-namhyung@kernel.org>
In-Reply-To: <20230427230502.1526136-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 17:30:56 -0700
Message-ID: <CAP-5=fWFu00PJVcfBPa_pq6cVN3UCsPr+yq303gdnKp8K_MecQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf list: Modify the warning message about scandirat(3)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 27, 2023 at 4:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It should mention scandirat() instead of scandir().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Fwiw, tracing_events__scandir_alphasort assumes scandir is present
unconditionally.

Thanks,
Ian

> ---
>  tools/perf/util/print-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index 0a97912fd894..299973876550 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -131,7 +131,7 @@ void print_tracepoint_events(const struct print_callb=
acks *print_cb __maybe_unus
>         free(sys_namelist);
>  }
>  #else
> -       printf("\nWARNING: Your libc doesn't have the scandir function, p=
lease ask its maintainers to implement it.\n"
> +       printf("\nWARNING: Your libc doesn't have the scandirat function,=
 please ask its maintainers to implement it.\n"
>                "         As a rough fallback, please do 'ls %s' to see th=
e available tracepoint events.\n", events_path);
>  #endif
>         close(events_fd);
> --
> 2.40.1.495.gc816e09b53d-goog
>

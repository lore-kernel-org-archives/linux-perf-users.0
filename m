Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D505EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 15:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjF3Ptw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjF3Pto (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 11:49:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8235B6
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:49:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40345bf4875so139881cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jun 2023 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688140180; x=1690732180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypApT2hRzaMD7zWDLfvFjlKKtvQJ4OYbQ8ZXF60dCvY=;
        b=EDUEu7W2r/7Fb6WRCuA7Q+7DxOQvO0t/y3dQETd58nysuk5gqNeelrxH/ugdRXV04b
         tugJhKUkg/6BUOt3oTh05bjX9ThbnlARx8X2mDNn6kgDBGWuuW3574AH/C4syw2FCc8e
         vmcsntztGUM16oFvJrnWAmz3DAMzosvdi3JWeoTvaMYgvMUCLv2KrNIuimYQnwMxvd14
         psu6q9z/Dq9viB+g1fiYAeFw06xQsLGA4zFmFDgvu2QcvBq++Qdv+nIikMrZs1oy4hde
         qAr2lHXOqG64ZTDU1o5/0yIiArbU/ZGuJsDYFtj5CuQHCoUsbGl7QPw2freudY41wCX2
         X0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688140180; x=1690732180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypApT2hRzaMD7zWDLfvFjlKKtvQJ4OYbQ8ZXF60dCvY=;
        b=kWmu1TS0AGR3rQui4TnkXxKhWt9IPH6HIO4QEaWUjQiT9hVJifnbgnTDJNaVgJCZxm
         r/4aA8zIq/9jXot3hmVBzusuw0SPAiRf574Oemiz/wCI5/QqtVMHqQ8yfixWlhP/VAbT
         sQTwNtBkxNVPWPHXIAu2CA25CeO1nrI1DWoYD3p6eEqnhl0kEQYf9e3qz955tHTcg/MY
         AiOYAT6XtcG4iU0mwBtKqJcyIYs3fZ2/mMCAg7K4SDiT+uiT/4l0pYAvRsqAp9/eRMgy
         /xgy7ApGTuS/Tya5v4LuXyCNRUxNGe8RCxUgvEyynKDBBhxcEZ9Yu+NGoVs9dAEC+7T4
         m5UQ==
X-Gm-Message-State: AC+VfDzTSaJY6W8wWEEi+Nk3lOZwyj8zzX5k5PHmwZFDvMqabZq4XAEe
        jATRAB8oVq1XNH2+pBsqBl7Sl8SlFpqlyQNCQ+HvXg==
X-Google-Smtp-Source: ACHHUZ41SYhbUvQSgTzG7vzBDKRiAe4qvoligE7YxGQl/rgoZByrQQPolfBYjnEPkW89+LxYTonPVVxd+YnNym5UXFk=
X-Received: by 2002:ac8:7f0a:0:b0:3f7:ff4a:eae5 with SMTP id
 f10-20020ac87f0a000000b003f7ff4aeae5mr891493qtk.12.1688140180231; Fri, 30 Jun
 2023 08:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230630153840.858668-1-james.clark@arm.com>
In-Reply-To: <20230630153840.858668-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 08:49:28 -0700
Message-ID: <CAP-5=fWMu7g9DWbBatbACV0VmThKNLLg0=Uff-oH48XEsrpJ3g@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Fix uninitialized return value in symbols__find_by_name()
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 8:39=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> found_idx and s aren't initialized, so if no symbol is found then the
> assert at the end will index off the end of the array causing a
> segfault. The function also doesn't return NULL when the symbol isn't
> found even if the assert passes. Fix it by initializing the values and
> only setting them when something is found.
>
> Fixes the following test failure:
>
>   $ perf test 1
>   1: vmlinux symtab matches kallsyms     : FAILED!
>
> Fixes: 259dce914e93 ("perf symbol: Remove symbol_name_rb_node")
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks, and thanks for the Fixes.

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/symbol.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index bc79291b9f3b..f849f9ef68e6 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -495,7 +495,10 @@ static struct symbol *symbols__find_by_name(struct s=
ymbol *symbols[],
>                                             size_t *found_idx)
>  {
>         size_t i, lower =3D 0, upper =3D symbols_len;
> -       struct symbol *s;
> +       struct symbol *s =3D NULL;
> +
> +       if (found_idx)
> +               *found_idx =3D SIZE_MAX;
>
>         if (!symbols_len)
>                 return NULL;
> @@ -504,8 +507,7 @@ static struct symbol *symbols__find_by_name(struct sy=
mbol *symbols[],
>                 int cmp;
>
>                 i =3D (lower + upper) / 2;
> -               s =3D symbols[i];
> -               cmp =3D symbol__match_symbol_name(s->name, name, includes=
);
> +               cmp =3D symbol__match_symbol_name(symbols[i]->name, name,=
 includes);
>
>                 if (cmp > 0)
>                         upper =3D i;
> @@ -514,10 +516,11 @@ static struct symbol *symbols__find_by_name(struct =
symbol *symbols[],
>                 else {
>                         if (found_idx)
>                                 *found_idx =3D i;
> +                       s =3D symbols[i];
>                         break;
>                 }
>         }
> -       if (includes !=3D SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
> +       if (s && includes !=3D SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
>                 /* return first symbol that has same name (if any) */
>                 for (; i > 0; i--) {
>                         struct symbol *tmp =3D symbols[i - 1];
> @@ -525,13 +528,12 @@ static struct symbol *symbols__find_by_name(struct =
symbol *symbols[],
>                         if (!arch__compare_symbol_names(tmp->name, s->nam=
e)) {
>                                 if (found_idx)
>                                         *found_idx =3D i - 1;
> +                               s =3D tmp;
>                         } else
>                                 break;
> -
> -                       s =3D tmp;
>                 }
>         }
> -       assert(!found_idx || s =3D=3D symbols[*found_idx]);
> +       assert(!found_idx || !s || s =3D=3D symbols[*found_idx]);
>         return s;
>  }
>
> --
> 2.34.1
>

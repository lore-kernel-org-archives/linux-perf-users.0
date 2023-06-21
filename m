Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215EEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 07:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFUHFt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 03:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUHFs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 03:05:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339D10F2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 00:05:47 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9d619103dso69341cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 00:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687331146; x=1689923146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZktZvE6CmrHUz1ssJd1p162ua5sspAxocYA1dsl2HlE=;
        b=OI23/Zi+bAK9oRtR+sK0XMD+Lom5nzB568E0Utzw3/F7f12Dy2slqGj3FgMzaa+Yx6
         LQiWSP04Pwrktrj3EdYIuM96bQVnyqVXwwZ69UeS3KGey2dRJ+qp3P34oBJECcpS4NfK
         jpMkN1tZj6FfeMYHhk8wYC6jHQuMOyyRnK0wjnPYTpN9b59X8Cwtg2AnUMHmoAEfS45t
         VnsnDjqo1HlVAy2054+utOCxLaGdotwreT+pO83xebITJPoRDJcA4seIY2CHJk8O36xo
         AkLup66FHk4QuP1BX81RCxB6zFBdiFNlOhek3IMEjyr095iFaS+YGBzLu58n12aaa/T0
         m//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687331146; x=1689923146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZktZvE6CmrHUz1ssJd1p162ua5sspAxocYA1dsl2HlE=;
        b=atN4e8m6bWWhm+cw79Q9y4BUfYnJLm4B1jqXAYY9fAtCyBZYQcxM28+MBzMvB7rY76
         eSta/v/SaCOWJZ1qTKlDSsZoPMXKsLkaSOEKYIjThWgXQ/LlyGIXKDaot9W+AeLmzFDw
         j7NPzEYibwPrwtj5JeElVeY5aaOqzQ+Yl+SMKXEoVMEcKTyw9XGun254GQ5mv1whZAGx
         7kDoZ1bTiHkgEYFitvG9G5pfLQoZ2VoldtzBow8Se9EOW6jLt6E+9lLv3qLllManIAaQ
         Drdc1jEuAQxsjarc9syPY6buz8D5KUO5jVReR6q5lfuA3E2MMDj2RG8eTMAogaCL+Kwh
         KPOg==
X-Gm-Message-State: AC+VfDxwBGB4Z+dtyMH0JmlzofXT1e3oE2jabuMViIIcuRS3AL145wvO
        //dG4bGnhrJxksBKVYkyViymGR8HsEndT6Rsf2amGg==
X-Google-Smtp-Source: ACHHUZ54puR5sOF9TlbEM+A5KYavFEiNVRKvWQ2zTVuD4DgNpmGqLh8EF2PVJsA9d05Dy7lGQJMch4FTGme9ACSY3ao=
X-Received: by 2002:a05:622a:8c:b0:3f7:ffc8:2f6f with SMTP id
 o12-20020a05622a008c00b003f7ffc82f6fmr1382541qtw.28.1687331146141; Wed, 21
 Jun 2023 00:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230525220927.3544192-1-namhyung@kernel.org>
In-Reply-To: <20230525220927.3544192-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Jun 2023 00:05:34 -0700
Message-ID: <CAP-5=fWOji8vCQfO-y4HnmFk2k+F70BtGHTjCg6XyORNfYNcww@mail.gmail.com>
Subject: Re: [PATCH] tools lib subcmd: Show parent options in help
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

On Thu, May 25, 2023 at 3:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I've just realized that help message in a subcommand didn't show one
> in the parent command.  Since the option parser understands the parent,
> display code should do the same.  For example, `perf ftrace latency -h`
> should show options in the `perf ftrace` command too.
>
> Before:
>
>   $ perf ftrace latency -h
>
>    Usage: perf ftrace [<options>] [<command>]
>       or: perf ftrace [<options>] -- [<command>] [<options>]
>       or: perf ftrace {trace|latency} [<options>] [<command>]
>       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<option=
s>]
>
>       -b, --use-bpf         Use BPF to measure function latency
>       -n, --use-nsec        Use nano-second histogram
>       -T, --trace-funcs <func>
>                             Show latency of given function
>
> After:
>
>   $ perf ftrace latency -h
>
>    Usage: perf ftrace [<options>] [<command>]
>       or: perf ftrace [<options>] -- [<command>] [<options>]
>       or: perf ftrace {trace|latency} [<options>] [<command>]
>       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<option=
s>]
>
>       -a, --all-cpus        System-wide collection from all CPUs
>       -b, --use-bpf         Use BPF to measure function latency
>       -C, --cpu <cpu>       List of cpus to monitor
>       -n, --use-nsec        Use nano-second histogram
>       -p, --pid <pid>       Trace on existing process id
>       -T, --trace-funcs <func>
>                             Show latency of given function
>       -v, --verbose         Be more verbose
>           --tid <tid>       Trace on existing thread id (exclusive to --p=
id)
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/subcmd/parse-options.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-op=
tions.c
> index 9fa75943f2ed..41de97671c72 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -806,18 +806,28 @@ static int option__cmp(const void *va, const void *=
vb)
>
>  static struct option *options__order(const struct option *opts)
>  {
> -       int nr_opts =3D 0, nr_group =3D 0, len;
> -       const struct option *o =3D opts;
> -       struct option *opt, *ordered, *group;
> +       int nr_opts =3D 0, nr_group =3D 0, nr_parent =3D 0, len;
> +       const struct option *o, *p =3D opts;
> +       struct option *opt, *ordered =3D NULL, *group;
>
> -       for (o =3D opts; o->type !=3D OPTION_END; o++)
> +retry:

Why use "goto retry" and not compute the size with the parent upfront?

> +       for (o =3D p; o->type !=3D OPTION_END; o++)
>                 ++nr_opts;
>
> -       len =3D sizeof(*o) * (nr_opts + 1);
> -       ordered =3D malloc(len);
> -       if (!ordered)
> +       len =3D sizeof(*o) * (nr_opts + !o->parent);

It'd be nice to comment on why the "!o->parent" here.

Thanks,
Ian

> +       group =3D realloc(ordered, len);
> +       if (!group)
>                 goto out;
> -       memcpy(ordered, opts, len);
> +       ordered =3D group;
> +       memcpy(&ordered[nr_parent], p, sizeof(*o) * (nr_opts - nr_parent)=
);
> +
> +       if (o->parent) {
> +               p =3D o->parent;
> +               nr_parent =3D nr_opts;
> +               goto retry;
> +       }
> +       /* copy the last OPTION_END */
> +       memcpy(&ordered[nr_opts], o, sizeof(*o));
>
>         /* sort each option group individually */
>         for (opt =3D group =3D ordered; opt->type !=3D OPTION_END; opt++)=
 {
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>

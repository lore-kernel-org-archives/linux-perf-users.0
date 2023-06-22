Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC4EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 17:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFVRXr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVRXr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 13:23:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC28199B
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 10:23:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4007b5bafceso10731cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687454625; x=1690046625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sImtbMqQzYkGHBNkAlqgrtpNozbS6ZDGSsAbNBKF2yg=;
        b=eh9P8uUt+ICiKU9A0APy2oJnRdiuwyxogTclThwgYDu5AoJTAXk173jyuveZx1raFb
         6UBXVvXrRi7azA+Btw14tntZUfWD/spOwwuLrRPbt6CtvHG/i5bV5OdQm6Rv0RwRsC6I
         op6M2wFYdRRASeG3sGLsJ6UfyOGVOOBylx0O1GDYkuwEbBOI/ubejP6t0F7lrbjR9Xs9
         +EkQozqY97NM5XYTPnYRT/uSmCNv3AH6kDKaDGYgXJGbS8aV1fuE9tgnBccg69Dgvdk1
         HmiO3JjSjc1dfeN5i3QKgvMvnMNM+Syfwja9kL8uf4TlP9kfsP6hcf7CvhgFA9w7JCVE
         hZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454625; x=1690046625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sImtbMqQzYkGHBNkAlqgrtpNozbS6ZDGSsAbNBKF2yg=;
        b=aMw8cFtOF6ovBD4SgeYv0EWbHlPlaKexooTlrGjZOLZ3tdkVFXHmuepWyH1+Vj+Lx9
         gRdIZOyGINqDpQzmlDMVrU4dDBNlfRGIzoPHpPVuevUzKoI1YBeihaFSGMt/3TnOSR7N
         hX+xwxKPEZAOdL7xn+teeG5RmEuDjCS82jnrK/HifUpU2X6hF2LBzIHqRATweRqiL4Xs
         7aWweFrYSKiisUgVbEWKVe0EqJZoWxZQ9JNiQ+bG1ULChyZRrIxUohElKsPpmBrZ3o1z
         Wyk37xrcbghfA3/opIZhhqLpWf1SgyBiXPbP1FBhiGWfvPB2Za+zmb6luxavBR4U3oju
         SCKA==
X-Gm-Message-State: AC+VfDyg+0JkYnh15F2X5twZJHnt1zKf/4hAgKnGQY4DM7AZILk1CvrX
        j3dADAckbOUBw3FUOvlwE8GyUQdFxusAcCUBOH8+qA==
X-Google-Smtp-Source: ACHHUZ6wf4wGlU0ZWkgcTSKAhQkhaUGGzLzZITiplhOIsXLw84MbXX9lbdRwraQMhTE9VRKP9kiR/D/peGAY5RrqJDs=
X-Received: by 2002:a05:622a:85:b0:3f8:5b2:aeed with SMTP id
 o5-20020a05622a008500b003f805b2aeedmr1599600qtw.21.1687454624879; Thu, 22 Jun
 2023 10:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620201818.1670753-1-namhyung@kernel.org> <20230620201818.1670753-2-namhyung@kernel.org>
In-Reply-To: <20230620201818.1670753-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 10:23:33 -0700
Message-ID: <CAP-5=fWrVh=RDEhise-gSzBfrfno8v8pyMw3QpBxio2j7QN3pA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf tools: Add kallsyms__get_symbol_start()
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

On Tue, Jun 20, 2023 at 1:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The kallsyms__get_symbol_start() to get any symbol address from
> kallsyms.  The existing kallsyms__get_function_start() only allows text
> symbols so create this to allow data symbols too.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/event.c | 30 +++++++++++++++++++++++++++---
>  tools/perf/util/event.h |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 3860b0c74829..6fdda0eb3854 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -93,8 +93,8 @@ struct process_symbol_args {
>         u64        start;
>  };
>
> -static int find_symbol_cb(void *arg, const char *name, char type,
> -                         u64 start)
> +static int find_func_symbol_cb(void *arg, const char *name, char type,
> +                              u64 start)
>  {
>         struct process_symbol_args *args =3D arg;
>
> @@ -110,12 +110,36 @@ static int find_symbol_cb(void *arg, const char *na=
me, char type,
>         return 1;
>  }
>
> +static int find_any_symbol_cb(void *arg, const char *name,
> +                             char type __maybe_unused, u64 start)
> +{
> +       struct process_symbol_args *args =3D arg;
> +
> +       if (strcmp(name, args->name))
> +               return 0;
> +
> +       args->start =3D start;
> +       return 1;
> +}
> +
>  int kallsyms__get_function_start(const char *kallsyms_filename,
>                                  const char *symbol_name, u64 *addr)
>  {
>         struct process_symbol_args args =3D { .name =3D symbol_name, };
>
> -       if (kallsyms__parse(kallsyms_filename, &args, find_symbol_cb) <=
=3D 0)
> +       if (kallsyms__parse(kallsyms_filename, &args, find_func_symbol_cb=
) <=3D 0)
> +               return -1;
> +
> +       *addr =3D args.start;
> +       return 0;
> +}
> +
> +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> +                              const char *symbol_name, u64 *addr)
> +{
> +       struct process_symbol_args args =3D { .name =3D symbol_name, };
> +
> +       if (kallsyms__parse(kallsyms_filename, &args, find_any_symbol_cb)=
 <=3D 0)
>                 return -1;
>
>         *addr =3D args.start;
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index de20e01c9d72..d8bcee2e9b93 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -360,6 +360,8 @@ size_t perf_event__fprintf(union perf_event *event, s=
truct machine *machine, FIL
>
>  int kallsyms__get_function_start(const char *kallsyms_filename,
>                                  const char *symbol_name, u64 *addr);
> +int kallsyms__get_symbol_start(const char *kallsyms_filename,
> +                              const char *symbol_name, u64 *addr);
>
>  void event_attr_init(struct perf_event_attr *attr);
>
> --
> 2.41.0.185.g7c58973941-goog
>

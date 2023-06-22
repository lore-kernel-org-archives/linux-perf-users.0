Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBEEEB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjFVRRq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjFVRRp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 13:17:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A2C195
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 10:17:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so12361cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687454262; x=1690046262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWt+gn8qnnsRd4hczLc7upMPaOxgzy9Y94xYvJKUOMY=;
        b=VUGY7kxb9VHRN6e84rBL9s4O5s181GemwpGZ/csWQatxMgRzcvcXJDAVxcxUzIZg0I
         H+4MG+NachV+DjohCPDiFYwavX6RD6Q5rSBoeDVQyNssoN2E7LaXkEgWgD61H8rWoixX
         P/Wr7eSb72CDVu8+YYinBonxp1g08JRmeNX6M42ds0jM5gxQlaQQe/eHivOl2XCzY5B0
         cMvoXD1QnPy7L9IdkQdk7YUb77cT3qTE1QvzmshJLwXVjLhocIivR2Ktk8I6Anj290hf
         rSBaEthYTg7JOneFyws9fKfonqVMZAcXDzKs7vSrtHRZPVUE2bjwr4epVzRAvLGgAx7F
         iovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454262; x=1690046262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWt+gn8qnnsRd4hczLc7upMPaOxgzy9Y94xYvJKUOMY=;
        b=kZz0UmcYbBsLOG0kUfKcqwtx5aILQRnuxJ84g2zTesdR6UCfNoKRHBwuAh9H+qOiY4
         eTI7j9fy/CrkAjILRNWg4Y/RHeOVdtwdpIfBOxlr+Z0kT93D/GdXT9z/PuNif6OOygqF
         rgEYQjTH7lfPAdaifGdvHUfXSO+4BaUDu5hOy1nSUFWBL71B+8AtgmJB50oSB5/2x9Yx
         7/w64q+U64osk8maksxiji0/LMCLkg5PL/q936HZRG8fXyxoLJ9xd01KXonpfX8TKkH0
         YroPSFB/NRUTC6tpAydOQuxb715oy1MYrXaI7HNYW4KH46teQo3vaKbBme8LUcyLpR9t
         uGYg==
X-Gm-Message-State: AC+VfDxoXwunGQs88H8EqVUnTxucU2hwX9OvfRQGbuLNaw5qPLOavhTW
        8DniT5kOA5C9BtdF8eDI0ZYArs9EE7DDwhIMgrfMDg==
X-Google-Smtp-Source: ACHHUZ5a/XjG6Gsmc3QGHSX7fE80pPs2VgMjwdGbNodKzLGk+UGp5SN/7eBjog8HoYJdXtzXhNTGI8qerEL6nwU+dZs=
X-Received: by 2002:a05:622a:110e:b0:3f8:5b2:aef5 with SMTP id
 e14-20020a05622a110e00b003f805b2aef5mr1736546qty.29.1687454261750; Thu, 22
 Jun 2023 10:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230620201818.1670753-1-namhyung@kernel.org>
In-Reply-To: <20230620201818.1670753-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Jun 2023 10:17:30 -0700
Message-ID: <CAP-5=fV1Em7fdVsSanvFr4Fj=k1sp_guSA7S-BvvVstyg9aXug@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf machine: Add machine->has_data_mmap field
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
> So that it can indicate the it needs to collect data mappings.  This is
> needed especially for kernel maps.
>
> At first, I just wanted to add it to struct machines only and to use the
> machine->machines to check the value.  But it turned out that some of
> machine didn't belong to any machines (eg. some test codes), so I just
> copied the value to individual struct machine.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/builtin-inject.c         |  2 +-
>  tools/perf/builtin-record.c         |  2 +-
>  tools/perf/tests/vmlinux-kallsyms.c |  4 ++--
>  tools/perf/util/machine.c           | 12 +++++++-----
>  tools/perf/util/machine.h           | 10 ++++++++--
>  tools/perf/util/session.c           |  4 ++--
>  tools/perf/util/session.h           |  4 ++--
>  7 files changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index c8cf2fdd9cff..481adaa97a68 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2325,7 +2325,7 @@ int cmd_inject(int argc, const char **argv)
>         }
>
>         inject.session =3D __perf_session__new(&data, repipe,
> -                                            output_fd(&inject),
> +                                            output_fd(&inject), false,
>                                              &inject.tool);
>         if (IS_ERR(inject.session)) {
>                 ret =3D PTR_ERR(inject.session);
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index aec18db7ff23..b4d0154dcb18 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2373,7 +2373,7 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>                 signal(SIGUSR2, SIG_IGN);
>         }
>
> -       session =3D perf_session__new(data, tool);
> +       session =3D __perf_session__new(data, false, -1, rec->opts.sample=
_address, tool);
>         if (IS_ERR(session)) {
>                 pr_err("Perf session creation failed.\n");
>                 return PTR_ERR(session);
> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlin=
ux-kallsyms.c
> index 1078a93b01aa..1f1ba3ae88aa 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -131,8 +131,8 @@ static int test__vmlinux_matches_kallsyms(struct test=
_suite *test __maybe_unused
>          * Init the machines that will hold kernel, modules obtained from
>          * both vmlinux + .ko files and from /proc/kallsyms split by modu=
les.
>          */
> -       machine__init(&kallsyms, "", HOST_KERNEL_ID);
> -       machine__init(&vmlinux, "", HOST_KERNEL_ID);
> +       machine__init(&kallsyms, "", HOST_KERNEL_ID, false);
> +       machine__init(&vmlinux, "", HOST_KERNEL_ID, false);
>
>         maps =3D machine__kernel_maps(&vmlinux);
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 4e62843d51b7..ddc0a2130caf 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -110,7 +110,7 @@ static void thread__set_guest_comm(struct thread *thr=
ead, pid_t pid)
>         thread__set_comm(thread, comm, 0);
>  }
>
> -int machine__init(struct machine *machine, const char *root_dir, pid_t p=
id)
> +int machine__init(struct machine *machine, const char *root_dir, pid_t p=
id, bool has_data_mmap)
>  {
>         int err =3D -ENOMEM;
>
> @@ -128,6 +128,7 @@ int machine__init(struct machine *machine, const char=
 *root_dir, pid_t pid)
>         machine->env =3D NULL;
>
>         machine->pid =3D pid;
> +       machine->has_data_mmap =3D has_data_mmap;
>
>         machine->id_hdr_size =3D 0;
>         machine->kptr_restrict_warned =3D false;
> @@ -170,7 +171,7 @@ struct machine *machine__new_host(void)
>         struct machine *machine =3D malloc(sizeof(*machine));
>
>         if (machine !=3D NULL) {
> -               machine__init(machine, "", HOST_KERNEL_ID);
> +               machine__init(machine, "", HOST_KERNEL_ID, false);

nit: when passing constants it can be nice to name the parameter, so
here "/*data_mmap=3D*/false". There are some checkers based on this
like:
https://clang.llvm.org/extra/clang-tidy/checks/bugprone/argument-comment.ht=
ml

Thanks,
Ian

>
>                 if (machine__create_kernel_maps(machine) < 0)
>                         goto out_delete;
> @@ -272,10 +273,11 @@ void machine__delete(struct machine *machine)
>         }
>  }
>
> -void machines__init(struct machines *machines)
> +void __machines__init(struct machines *machines, bool have_data_mmap)
>  {
> -       machine__init(&machines->host, "", HOST_KERNEL_ID);
> +       machine__init(&machines->host, "", HOST_KERNEL_ID, have_data_mmap=
);
>         machines->guests =3D RB_ROOT_CACHED;
> +       machines->have_data_mmaps =3D have_data_mmap;
>  }
>
>  void machines__exit(struct machines *machines)
> @@ -295,7 +297,7 @@ struct machine *machines__add(struct machines *machin=
es, pid_t pid,
>         if (machine =3D=3D NULL)
>                 return NULL;
>
> -       if (machine__init(machine, root_dir, pid) !=3D 0) {
> +       if (machine__init(machine, root_dir, pid, machines->have_data_mma=
ps) !=3D 0) {
>                 free(machine);
>                 return NULL;
>         }
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index d034ecaf89c1..f54e5c888a99 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -46,6 +46,7 @@ struct machine {
>         bool              comm_exec;
>         bool              kptr_restrict_warned;
>         bool              single_address_space;
> +       bool              has_data_mmap;
>         char              *root_dir;
>         char              *mmap_name;
>         char              *kallsyms_filename;
> @@ -160,9 +161,14 @@ typedef void (*machine__process_t)(struct machine *m=
achine, void *data);
>  struct machines {
>         struct machine host;
>         struct rb_root_cached guests;
> +       bool have_data_mmaps;
>  };
>
> -void machines__init(struct machines *machines);
> +void __machines__init(struct machines *machines, bool data_mmap);
> +static inline void machines__init(struct machines *machines)
> +{
> +       __machines__init(machines, false);
> +}
>  void machines__exit(struct machines *machines);
>
>  void machines__process_guests(struct machines *machines,
> @@ -181,7 +187,7 @@ void machines__set_comm_exec(struct machines *machine=
s, bool comm_exec);
>
>  struct machine *machine__new_host(void);
>  struct machine *machine__new_kallsyms(void);
> -int machine__init(struct machine *machine, const char *root_dir, pid_t p=
id);
> +int machine__init(struct machine *machine, const char *root_dir, pid_t p=
id, bool has_data_mmap);
>  void machine__exit(struct machine *machine);
>  void machine__delete_threads(struct machine *machine);
>  void machine__delete(struct machine *machine);
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 00d18c74c090..e09a02ec8f28 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -191,7 +191,7 @@ static int ordered_events__deliver_event(struct order=
ed_events *oe,
>  }
>
>  struct perf_session *__perf_session__new(struct perf_data *data,
> -                                        bool repipe, int repipe_fd,
> +                                        bool repipe, int repipe_fd, bool=
 data_mmap,
>                                          struct perf_tool *tool)
>  {
>         int ret =3D -ENOMEM;
> @@ -205,7 +205,7 @@ struct perf_session *__perf_session__new(struct perf_=
data *data,
>         session->decomp_data.zstd_decomp =3D &session->zstd_data;
>         session->active_decomp =3D &session->decomp_data;
>         INIT_LIST_HEAD(&session->auxtrace_index);
> -       machines__init(&session->machines);
> +       __machines__init(&session->machines, data_mmap);
>         ordered_events__init(&session->ordered_events,
>                              ordered_events__deliver_event, NULL);
>
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index ee3715e8563b..465610e81e95 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -64,13 +64,13 @@ struct decomp {
>  struct perf_tool;
>
>  struct perf_session *__perf_session__new(struct perf_data *data,
> -                                        bool repipe, int repipe_fd,
> +                                        bool repipe, int repipe_fd, bool=
 data_mmap,
>                                          struct perf_tool *tool);
>
>  static inline struct perf_session *perf_session__new(struct perf_data *d=
ata,
>                                                      struct perf_tool *to=
ol)
>  {
> -       return __perf_session__new(data, false, -1, tool);
> +       return __perf_session__new(data, false, -1, false, tool);
>  }
>
>  void perf_session__delete(struct perf_session *session);
> --
> 2.41.0.185.g7c58973941-goog
>

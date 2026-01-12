Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2792561A2
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768259756; cv=pass; b=YXa4pZU9lWnxXqiYXczZvet2I6vh2ivjYRBNrT5RgbJtbNN3t+NU7VjM49JI9xPeQ3zGLn5h9xhBckALYYU7zaUtJ6/G8lmYixzpfqLxhlJtTO0ZcTFFBB6Y7yHSRw9tyECZcbGjvAx+nzUL0xy0zNMilCGik8iwqR/Oe+VYU/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768259756; c=relaxed/simple;
	bh=hWfFh3lt7RBrd3EWPSUdoi1U/l/33jKwHSRaSuT6UNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTEB9UcIK3pzm5ofy9uU6tECDQGQ+WxbQ0f89hLWmsZn8l0EHdHW5aPCuSZoLJFLxFFctJUi1BQ8mHdtYBZiAMUCK9KwO+3Z9s7z+Uu/DpDYXScRskOGhWlrMfyCPshTOUtrQ02bcckCTzK7GRfC3mrmtiloAjTo/VZlvDagjxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B7hY5+1f; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7hY5+1f"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-121b14efcddso1657c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jan 2026 15:15:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768259753; cv=none;
        d=google.com; s=arc-20240605;
        b=MvYvR0WjIjVedknw0tid/r4SbJz6YtDsnxq49+Rg4T0ukme7Z7NkQ1E8mVd7WQQuEX
         hyFye/La+hn+nzvrhLOW70iHX7ybAF2Y+rVtBMP9ptLUmsCU+OcTzJIz2qWNMV+tUwnY
         kho8u5LnwYlX/BKwRoYJKJnVNxFPYKy6orxOfwuGXAZgmat9RhgSqGfxoVLa54Gb1CM8
         cx0FKidhDG2lRmBE7eGmr6eQvXSZWvRrodU6Jr3jtNn4X7NkjvA7gNe6+GqTz5p04wVI
         1wLJk1pAsISxU40Zghb0QjZo5Bgs/OMMvB0GoEGRvx7X7sdlPusB2lJLgbJnMmnRlEqc
         Kjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J3h86s5+KI1RaR8Q+bN5s/uBdtJeVHpUaqXs4sDVqqc=;
        fh=MAsBNi8vQ/11havcVsoCWpzB5S+fVxstU8lONgy1+Hk=;
        b=Pc593As9FRTmDNDsOKHAeHIFXmJHkVmAK7vwU+n8Cnps59k5cNaUn/0ovDRvVHFaOw
         b48KDUAUaFOEWoOBNA0OHtzmzUIHGf5dgDsSOgeAJWgIEk5CaXB+N7osMW4LBmipUrJJ
         DwX8W45QXKfzNIvEgkvZZLjYPnvjD+3QZLG1D4HyonDM5L0RAbY+zdvJLWPV8lCl1BB+
         qeQxY1l1Hijafz6l434qnXYZOvKy5hLr0yxRVxNYwQpo/QLFOqC8gsK7JQpW6PYynsP2
         cbVeA3JEtyPYYg1tRe8u5GLKWC5VLmqNVFQ0BLcFETnCIwzt3yE9gHRmvEPwaki8InDi
         MZSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768259753; x=1768864553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3h86s5+KI1RaR8Q+bN5s/uBdtJeVHpUaqXs4sDVqqc=;
        b=B7hY5+1fLRtuvvWGRi9U4li2RyFsM8Wq200pwbxYbDNEky/U3zmE9kzoSJqGt1RVKG
         7fziJRV25RzQQU1UQbkxcb3jyUFxRTzJorTAq4H09fWF3c98wzJQrQD/b7pbsJ9nf7Fn
         +qsCB3WYRvJYErszhxD6m8FmFeXxFzvJ5eLhqqNqAi2sVfaVShn/1fBY8zstIx2chj//
         CZYsHPa6Oq5VQ8Copht//GbXsOp/AYtnHgx3fyiX7w+BROnCmN0dHh/xawF9HH9YUiYS
         sXE2ICgqcBwwrW6edgH9qkjdo+jf/vmRT1QX4y426hMvn+atWws+cPn/jQ0CavLvnc0P
         DPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768259753; x=1768864553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3h86s5+KI1RaR8Q+bN5s/uBdtJeVHpUaqXs4sDVqqc=;
        b=qvgUyChWVdjqcA68T+fZMmNLEFFxyBS9fIu6k24FIiTHjiMGeMJi44Od9BFq54xuz+
         ilSnvJE67rXrOrIM2KUgATEXQwtXb6MF+QXUPxn3JHQix3n8/Gw6WsGh2Z1qjaxEpKwG
         ctcMsjCmN6UrfhgeROVd39bcMO8bJng43CAFjFMrAFZ9l/kZ4R7/7YcTQ/SiVrsCCsbz
         cO/UYndlICGeynohUO//56Y1JKgcdkDd0w9+udaV1g6mO4NJpAkSVbCtgNoBDSJUtoam
         QazDUUTjGBo+4ZStv33TdC0TdjZoyd4tj7m15thGCKT90RnkhMdUbEm09/pC3WqGKVEI
         puSA==
X-Forwarded-Encrypted: i=1; AJvYcCW7342mRJTAEqjC4kVEB/zBsG3DSmITISs6bqruNK/nP6zrWMA7wL7KfKSe7p8IY8NTimtrWHyRe4rzD5izWCAc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4FRIpxNPQ2LwNiK+yQEyav8liH6yfMKUw27U8OTSZkAp8nih
	8egzwUXNOq4R7yhJr3LgpFsZynx7qy2HOfBkbSGQkXsvYrPvBSQly1LWTHdePo/shTNk0u576hq
	Ak8BUiwpK3W9FVcrpN1A0cStpBeSB1QMvv6DLyDoU
X-Gm-Gg: AY/fxX6rr7zjiRf++AlmBTWhEPZFExgr4Ekgr+orVfYw1830Cl7/xgBsKhklcUtwrtd
	Pk1YJ9P9uGaRXmHVucH4vNb1aBuyFw8ezVx8yWJeHu3hBqYl2m50/iDIL8ySFOm1BuR2G6FgJ/+
	FcC4+ArIT4u+xiGOU0T6I6coJQ8Y7hvmASerR9tUmDXAnI3tnARjfc5JdfoWC6KyOIIicUoolBe
	sv6rnMHY9ph0PTmcr1U8tY9fp/WMUP0keUnBE93EOQfH6c2RgC5NVFIZ/thI8XSEOP8gvJCFveC
	gfQV1Miz0KbR1ccnL9uz79Gfxw==
X-Received: by 2002:a05:7022:2525:b0:120:5719:1852 with SMTP id
 a92af1059eb24-1232bed55b8mr33767c88.16.1768259752414; Mon, 12 Jan 2026
 15:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110011715.1642869-1-namhyung@kernel.org>
In-Reply-To: <20260110011715.1642869-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 15:15:40 -0800
X-Gm-Features: AZwV_QhOiec-7SV7DHH5jT6JqoUmg6xm_P_W41M9KyxbjpCTnMZoXGzyNYbBKaI
Message-ID: <CAP-5=fUvy2w57fsGxAVpQXZKXw5wv6dSa8OUHYLeTKtEUBwPjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf inject: Add --convert-callchain option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> There are applications not built with frame pointers, so DWARF is needed
> to get the stack traces.  So `perf record --call-graph dwarf` saves the
> stack and register data for each sample to get the stacktrace offline.
> But sometimes those data may have sensitive information and we don't
> want to keep them in the file.
>
> This perf inject --convert-callchain option parses the callchains and
> discard the stack and register after that.  This will save storage space
> and processing time for the new data file.  Of course, users should
> remove the original data file. :)
>
> The down side is that it cannot handle inlined callchain entries as they
> all have the same IPs.  Maybe we can add an option to perf report to
> look up inlined functions using DWARF - IIUC it won't requires stack and
> register data.
>
> This is an example.
>
>   $ perf record --call-graph dwarf -- perf test -w noploop
>
>   $ perf report --stdio --no-children --percent-limit=3D0 > output-prev
>
>   $ perf inject -i perf.data --convert-callchain -o perf.data.out
>
>   $ perf report --stdio --no-children --percent-limit=3D0 -i perf.data.ou=
t > output-next
>
>   $ diff -u output-prev output-next
>   ...
>         0.23%  perf          ld-linux-x86-64.so.2  [.] _dl_relocate_objec=
t_no_relro
>                |
>   -            ---elf_dynamic_do_Rela (inlined)
>   -               _dl_relocate_object_no_relro
>   +            ---_dl_relocate_object_no_relro
>                   _dl_relocate_object
>                   dl_main
>                   _dl_sysdep_start
>   -               _dl_start_final (inlined)
>                   _dl_start
>                   _start
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

As I mentioned in v1 I think things can be better with a delegate
tool, but this is definitely a cool new feature.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2 changes)
>  * Use machine__kernel_ip() instead  (James)
>  * Check sample types for DWARF callchains (James)
>  * Fix build errors  (James)
>  * Add a new test  (Ian)
>
>  tools/perf/Documentation/perf-inject.txt |   5 +
>  tools/perf/builtin-inject.c              | 151 +++++++++++++++++++++++
>  2 files changed, 156 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Docume=
ntation/perf-inject.txt
> index c972032f4ca0d248..95dfdf39666efe89 100644
> --- a/tools/perf/Documentation/perf-inject.txt
> +++ b/tools/perf/Documentation/perf-inject.txt
> @@ -109,6 +109,11 @@ include::itrace.txt[]
>         should be used, and also --buildid-all and --switch-events may be
>         useful.
>
> +--convert-callchain::
> +       Parse DWARF callchains and convert them to usual callchains.  Thi=
s also
> +       discards stack and register data from the samples.  This will los=
e
> +       inlined callchain entries.
> +
>  :GMEXAMPLECMD: inject
>  :GMEXAMPLESUBCMD:
>  include::guestmount.txt[]
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6080afec537d2178..02bd388d602fdd75 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -122,6 +122,7 @@ struct perf_inject {
>         bool                    in_place_update;
>         bool                    in_place_update_dry_run;
>         bool                    copy_kcore_dir;
> +       bool                    convert_callchain;
>         const char              *input_name;
>         struct perf_data        output;
>         u64                     bytes_written;
> @@ -133,6 +134,7 @@ struct perf_inject {
>         struct guest_session    guest_session;
>         struct strlist          *known_build_ids;
>         const struct evsel      *mmap_evsel;
> +       struct ip_callchain     *raw_callchain;
>  };
>
>  struct event_entry {
> @@ -383,6 +385,89 @@ static int perf_event__repipe_sample(const struct pe=
rf_tool *tool,
>         return perf_event__repipe_synth(tool, event);
>  }
>
> +static int perf_event__convert_sample_callchain(const struct perf_tool *=
tool,
> +                                               union perf_event *event,
> +                                               struct perf_sample *sampl=
e,
> +                                               struct evsel *evsel,
> +                                               struct machine *machine)
> +{
> +       struct perf_inject *inject =3D container_of(tool, struct perf_inj=
ect, tool);
> +       struct callchain_cursor *cursor =3D get_tls_callchain_cursor();
> +       union perf_event *event_copy =3D (void *)inject->event_copy;
> +       struct callchain_cursor_node *node;
> +       struct thread *thread;
> +       u64 sample_type =3D evsel->core.attr.sample_type;
> +       u32 sample_size =3D event->header.size;
> +       u64 i, k;
> +       int ret;
> +
> +       if (event_copy =3D=3D NULL) {
> +               inject->event_copy =3D malloc(PERF_SAMPLE_MAX_SIZE);
> +               if (!inject->event_copy)
> +                       return -ENOMEM;
> +
> +               event_copy =3D (void *)inject->event_copy;
> +       }
> +
> +       if (cursor =3D=3D NULL)
> +               return perf_event__repipe_synth(tool, event);
> +
> +       callchain_cursor_reset(cursor);
> +
> +       thread =3D machine__find_thread(machine, -1, sample->pid);
> +       if (thread =3D=3D NULL)
> +               return perf_event__repipe_synth(tool, event);
> +
> +       /* this will parse DWARF using stack and register data */
> +       ret =3D thread__resolve_callchain(thread, cursor, evsel, sample,
> +                                       /*parent=3D*/NULL, /*root_al=3D*/=
NULL,
> +                                       PERF_MAX_STACK_DEPTH);
> +       thread__put(thread);
> +       if (ret !=3D 0)
> +               return perf_event__repipe_synth(tool, event);
> +
> +       /* copy kernel callchain and context entries */
> +       for (i =3D 0; i < sample->callchain->nr; i++) {
> +               inject->raw_callchain->ips[i] =3D sample->callchain->ips[=
i];
> +               if (sample->callchain->ips[i] =3D=3D PERF_CONTEXT_USER) {
> +                       i++;
> +                       break;
> +               }
> +       }
> +       if (i =3D=3D 0 || inject->raw_callchain->ips[i - 1] !=3D PERF_CON=
TEXT_USER)
> +               inject->raw_callchain->ips[i++] =3D PERF_CONTEXT_USER;
> +
> +       node =3D cursor->first;
> +       for (k =3D 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
> +               if (machine__kernel_ip(machine, node->ip))
> +                       /* kernel IPs were added already */;
> +               else if (node->ms.sym && node->ms.sym->inlined)
> +                       /* we can't handle inlined callchains */;
> +               else
> +                       inject->raw_callchain->ips[i++] =3D node->ip;
> +
> +               node =3D node->next;
> +       }
> +
> +       inject->raw_callchain->nr =3D i;
> +       sample->callchain =3D inject->raw_callchain;
> +
> +       memcpy(event_copy, event, sizeof(event->header));
> +
> +       /* adjust sample size for stack and regs */
> +       sample_size -=3D sample->user_stack.size;
> +       sample_size -=3D (hweight64(evsel->core.attr.sample_regs_user) + =
1) * sizeof(u64);
> +       sample_size +=3D (sample->callchain->nr + 1) * sizeof(u64);
> +       event_copy->header.size =3D sample_size;
> +
> +       /* remove sample_type {STACK,REGS}_USER for synthesize */
> +       sample_type &=3D ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER=
);
> +
> +       perf_event__synthesize_sample(event_copy, sample_type,
> +                                     evsel->core.attr.read_format, sampl=
e);
> +       return perf_event__repipe_synth(tool, event_copy);
> +}
> +
>  static struct dso *findnew_dso(int pid, int tid, const char *filename,
>                                const struct dso_id *id, struct machine *m=
achine)
>  {
> @@ -2270,6 +2355,15 @@ static int __cmd_inject(struct perf_inject *inject=
)
>                 /* Allow space in the header for guest attributes */
>                 output_data_offset +=3D gs->session->header.data_offset;
>                 output_data_offset =3D roundup(output_data_offset, 4096);
> +       } else if (inject->convert_callchain) {
> +               inject->tool.sample     =3D perf_event__convert_sample_ca=
llchain;
> +               inject->tool.fork       =3D perf_event__repipe_fork;
> +               inject->tool.comm       =3D perf_event__repipe_comm;
> +               inject->tool.exit       =3D perf_event__repipe_exit;
> +               inject->tool.mmap       =3D perf_event__repipe_mmap;
> +               inject->tool.mmap2      =3D perf_event__repipe_mmap2;
> +               inject->tool.ordered_events =3D true;
> +               inject->tool.ordering_requires_timestamps =3D true;
>         }
>
>         if (!inject->itrace_synth_opts.set)
> @@ -2322,6 +2416,23 @@ static int __cmd_inject(struct perf_inject *inject=
)
>                                 perf_header__set_feat(&session->header,
>                                                       HEADER_BRANCH_STACK=
);
>                 }
> +
> +               /*
> +                * The converted data file won't have stack and registers=
.
> +                * Update the perf_event_attr to remove them before writi=
ng.
> +                */
> +               if (inject->convert_callchain) {
> +                       struct evsel *evsel;
> +
> +                       evlist__for_each_entry(session->evlist, evsel) {
> +                               evsel__reset_sample_bit(evsel, REGS_USER)=
;
> +                               evsel__reset_sample_bit(evsel, STACK_USER=
);
> +                               evsel->core.attr.sample_regs_user =3D 0;
> +                               evsel->core.attr.sample_stack_user =3D 0;
> +                               evsel->core.attr.exclude_callchain_user =
=3D 0;
> +                       }
> +               }
> +
>                 session->header.data_offset =3D output_data_offset;
>                 session->header.data_size =3D inject->bytes_written;
>                 perf_session__inject_header(session, session->evlist, fd,=
 &inj_fc.fc,
> @@ -2346,6 +2457,18 @@ static int __cmd_inject(struct perf_inject *inject=
)
>         return ret;
>  }
>
> +static bool evsel__has_dwarf_callchain(struct evsel *evsel)
> +{
> +       struct perf_event_attr *attr =3D &evsel->core.attr;
> +       const u64 dwarf_callchain_flags =3D
> +               PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER | PERF_SAM=
PLE_CALLCHAIN;
> +
> +       if (!attr->exclude_callchain_user)
> +               return false;
> +
> +       return (attr->sample_type & dwarf_callchain_flags) =3D=3D dwarf_c=
allchain_flags;
> +}
> +
>  int cmd_inject(int argc, const char **argv)
>  {
>         struct perf_inject inject =3D {
> @@ -2414,6 +2537,8 @@ int cmd_inject(int argc, const char **argv)
>                 OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "dir=
ectory",
>                            "guest mount directory under which every guest=
 os"
>                            " instance has a subdir"),
> +               OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callc=
hain,
> +                           "Generate callchains using DWARF and drop reg=
ister/stack data"),
>                 OPT_END()
>         };
>         const char * const inject_usage[] =3D {
> @@ -2429,6 +2554,9 @@ int cmd_inject(int argc, const char **argv)
>
>  #ifndef HAVE_JITDUMP
>         set_option_nobuild(options, 'j', "jit", "NO_LIBELF=3D1", true);
> +#endif
> +#ifndef HAVE_LIBDW_SUPPORT
> +       set_option_nobuild(options, 0, "convert-callchain", "NO_LIBDW=3D1=
", true);
>  #endif
>         argc =3D parse_options(argc, argv, options, inject_usage, 0);
>
> @@ -2588,6 +2716,28 @@ int cmd_inject(int argc, const char **argv)
>                 }
>         }
>
> +       if (inject.convert_callchain) {
> +               struct evsel *evsel;
> +
> +               if (inject.output.is_pipe || inject.session->data->is_pip=
e) {
> +                       pr_err("--convert-callchain cannot work with pipe=
\n");
> +                       goto out_delete;
> +               }
> +
> +               evlist__for_each_entry(inject.session->evlist, evsel) {
> +                       if (!evsel__has_dwarf_callchain(evsel)) {
> +                               pr_err("--convert-callchain requires DWAR=
F call graph.\n");
> +                               goto out_delete;
> +                       }
> +               }
> +
> +               inject.raw_callchain =3D calloc(PERF_MAX_STACK_DEPTH, siz=
eof(u64));
> +               if (inject.raw_callchain =3D=3D NULL) {
> +                       pr_err("callchain allocation failed\n");
> +                       goto out_delete;
> +               }
> +       }
> +
>  #ifdef HAVE_JITDUMP
>         if (inject.jit_mode) {
>                 inject.tool.mmap2          =3D perf_event__repipe_mmap2;
> @@ -2618,5 +2768,6 @@ int cmd_inject(int argc, const char **argv)
>         free(inject.itrace_synth_opts.vm_tm_corr_args);
>         free(inject.event_copy);
>         free(inject.guest_session.ev.event_buf);
> +       free(inject.raw_callchain);
>         return ret;
>  }
> --
> 2.52.0.457.g6b5491de43-goog
>

Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCA2882B2
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043639; cv=none; b=dt/a5nTJ8HqNr+LBbZShPeBq+WaNEG3uUjaUHhLAmwdt/ZUuh3vy74SiX2GtBj1FyzJIZjrhgLsUoktM+jXcM/wd6AA1cLBeu1AdENsVeWCWF0TfG3VEgKhO1ZuAsWNVRxLQab5rf/2jpHeWBHmdbq9Vf/L293UB1iz6srqfzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043639; c=relaxed/simple;
	bh=MBl3aJyGvqi1bbl4mschPuNDiETM0/jjbpseQBXm0k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKQPfVI0GJuQ8pn998FXF0KV2cjUZPOTLwQrgWTK2EcZFx3cHoV6i4piIQF6gsC8rv49FFb6v36k7OU/1nStvI1vmG+zQUXL7HD+g0pUKfk/Vb/kNdwNNCiNI7PuMZtLV1DXDk7SE4IzoE6pBInXjIamk26Kr9y6qLfRjRm7WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUI3/dUh; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUI3/dUh"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d91a45d148so1265ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746043636; x=1746648436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gM6uJVasQdHT0t3/+itYrz3KwJiQq9y4XcyhQIPkg0=;
        b=mUI3/dUhvsKB/U/2S2zusWINj0WRHaeO2l9qLGpH/5FUWK4q6s/L0S09Mm2gESOQgE
         gxHiCshqZjoItauPbrsshgybFO9sJiz8jDYCIH5KhD7WLRLamUNEsop0xA/PNYQkj3HR
         ANiuYV9fO2KPrYTlYCB4a7pCExcSrNNCo81UI5Xmu8Mxrf2foP17aATTOusEBX6o3WIB
         PswhdfqNfD+xM/dmxpTxjAIj3tHO3H+/UlXrzOZMPzPUBMggvsM6yOAOypTzMLraj8oy
         JlA4/439dOkrKLy+txUZYPaJhLwkoLzd7a6NHR3WqDtAe3xbaFaxbzmvGpRm5CMpBIjG
         sO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746043636; x=1746648436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gM6uJVasQdHT0t3/+itYrz3KwJiQq9y4XcyhQIPkg0=;
        b=uezuK91kJt8jUA4q+MHtaPykVUsfvcbZ0/ofg8agk9qrltBOBjgkB7B+uASLiu5iet
         /LZeDNsi6YRpnagDecoyt03i7rdd+8axaIjT4a6fivTx7p3wvFfl8r7MLFXEHJ0gbmUD
         UPl1X8qT4ZSkxtYUJViAtDgZvoaLo0acu2Or/bWkjlfUle+CdufTRg3j+/oNBolsFkyc
         5knAlPssEZsugXr9rgUTRv5uE8YTvXT7u8xwFaqXCqwsUS/b7yudxfiLyEDgYFSCSPna
         BPpmPsWZlwucZVPMzHSauwck9VnOzAvsXSfUoKLO/PAHlJEgUvFZtiZv9S/WZDgqBR8d
         Uscg==
X-Forwarded-Encrypted: i=1; AJvYcCW+jrD8w/sEfU8lRKTWGfB9X7Mz9Ofnk+6kGXDKAeMOz9lVjZL7D/Fl3vo041LdEkXELZNKQWOVByUWHXfIxdQh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdtbh6bJhauMwRK1Pz72cFCGeJht+PuO/8vl9osnhRyJSdwTc
	9UgDtUAzDRsfoqQZ+wHgGcNPwsrIOtEnWyFz5WjHB7FdsjO1khy5yOyUP1lLYf2mCRlP5QyDfI9
	xaH+QSFNyX/xP+zBk9ZeVDxTYpFGKkl8GEmHI
X-Gm-Gg: ASbGncuu+MzJsUwug2F/d3QW3uxrNZYH0BKj9V4HD91ieWnCLaXfH1ozFfHZGcJmSRa
	sQ0MLqDupzOAPxzj4DWdjxvRFbdm8cIp49E0WuGrZCrtVdULGuk3tqKBrhxYZh2fgNxsIn6O6iA
	bF1oBgEt6KAeqY+mxwH1dAgO6dbsWgk3dj+sPePmi8yVUSSH3qo10=
X-Google-Smtp-Source: AGHT+IHMCHJ6025Auju0HnhHOOuvaer69pbVhLadu7vGmwrKQODixWu7YQ5sTrcj0ikfzYIWgDlmf5pMaFm2qb+wKy4=
X-Received: by 2002:a05:6e02:1a04:b0:3d9:2961:f9f1 with SMTP id
 e9e14a558f8ab-3d96f30ed72mr644715ab.28.1746043636020; Wed, 30 Apr 2025
 13:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430195746.827125963@goodmis.org> <20250430200110.528523011@goodmis.org>
In-Reply-To: <20250430200110.528523011@goodmis.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Apr 2025 13:07:04 -0700
X-Gm-Features: ATxdqUGS5xfkz4cIUr21J4L1tOK-69qW8XNcC2LPpI_UIiP6z8BYQYSqjhZjJ7s
Message-ID: <CAP-5=fUn0vk-Jm2YLqjWDpVX46Y9fqpUDUEpa5YHNqY_Cja_tA@mail.gmail.com>
Subject: Re: [PATCH v7 18/18] perf tools: Merge deferred user callchains
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, 
	Sam James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones <blakejones@google.com>, 
	Beau Belgrave <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Alexander Aring <aahringo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 1:01=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> From: Namhyung Kim <namhyung@kernel.org>
>
> Save samples with deferred callchains in a separate list and deliver
> them after merging the user callchains.  If users don't want to merge
> they can set tool->merge_deferred_callchains to false to prevent the
> behavior.
>
> With previous result, now perf script will show the merged callchains.
>
>   $ perf script
>   perf     801 [000]    18.031793:          1 cycles:P:
>           ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.ka=
llsyms])
>           ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
>           ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
>           ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
>           ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
>           ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsym=
s])
>           ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
>           ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsy=
ms])
>           ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
>           ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
>           ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
>           ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
>           ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
>               7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/l=
ibc.so.6)
>   ...
>
> The old output can be get using --no-merge-callchain option.
> Also perf report can get the user callchain entry at the end.
>
>   $ perf report --no-children --percent-limit=3D0 --stdio -q -S __intel_p=
mu_enable_all.isra.0
>   # symbol: __intel_pmu_enable_all.isra.0
>        0.00%  perf     [kernel.kallsyms]
>               |
>               ---__intel_pmu_enable_all.isra.0
>                  perf_ctx_enable
>                  event_function
>                  remote_function
>                  generic_exec_single
>                  smp_call_function_single
>                  event_function_call
>                  perf_event_for_each_child
>                  _perf_ioctl
>                  perf_ioctl
>                  __x64_sys_ioctl
>                  do_syscall_64
>                  entry_SYSCALL_64
>                  __GI___ioctl
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  tools/perf/Documentation/perf-script.txt |  5 ++
>  tools/perf/builtin-script.c              |  5 +-
>  tools/perf/util/callchain.c              | 24 +++++++++
>  tools/perf/util/callchain.h              |  3 ++
>  tools/perf/util/evlist.c                 |  1 +
>  tools/perf/util/evlist.h                 |  1 +
>  tools/perf/util/session.c                | 63 +++++++++++++++++++++++-
>  tools/perf/util/tool.c                   |  1 +
>  tools/perf/util/tool.h                   |  1 +
>  9 files changed, 102 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index 28bec7e78bc8..03d112960632 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -527,6 +527,11 @@ include::itrace.txt[]
>         The known limitations include exception handing such as
>         setjmp/longjmp will have calls/returns not match.
>
> +--merge-callchains::
> +       Enable merging deferred user callchains if available.  This is th=
e
> +       default behavior.  If you want to see separate CALLCHAIN_DEFERRED
> +       records for some reason, use --no-merge-callchains explicitly.
> +
>  :GMEXAMPLECMD: script
>  :GMEXAMPLESUBCMD:
>  include::guest-files.txt[]
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 176b8f299afc..dd17c11af0c8 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3775,6 +3775,7 @@ int cmd_script(int argc, const char **argv)
>         bool header_only =3D false;
>         bool script_started =3D false;
>         bool unsorted_dump =3D false;
> +       bool merge_deferred_callchains =3D true;
>         char *rec_script_path =3D NULL;
>         char *rep_script_path =3D NULL;
>         struct perf_session *session;
> @@ -3928,6 +3929,8 @@ int cmd_script(int argc, const char **argv)
>                     "Guest code can be found in hypervisor process"),
>         OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
>                     "Enable LBR callgraph stitching approach"),
> +       OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
> +                   "Enable merge deferred user callchains"),
>         OPTS_EVSWITCH(&script.evswitch),
>         OPT_END()
>         };
> @@ -4183,7 +4186,7 @@ int cmd_script(int argc, const char **argv)
>         script.tool.throttle             =3D process_throttle_event;
>         script.tool.unthrottle           =3D process_throttle_event;
>         script.tool.ordering_requires_timestamps =3D true;
> -       script.tool.merge_deferred_callchains =3D false;
> +       script.tool.merge_deferred_callchains =3D merge_deferred_callchai=
ns;
>         session =3D perf_session__new(&data, &script.tool);
>         if (IS_ERR(session))
>                 return PTR_ERR(session);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index d7b7eef740b9..6d423d92861b 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1828,3 +1828,27 @@ int sample__for_each_callchain_node(struct thread =
*thread, struct evsel *evsel,
>         }
>         return 0;
>  }
> +
> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> +                                    struct perf_sample *sample_callchain=
)
> +{
> +       u64 nr_orig =3D sample_orig->callchain->nr - 1;
> +       u64 nr_deferred =3D sample_callchain->callchain->nr;
> +       struct ip_callchain *callchain;
> +
> +       callchain =3D calloc(1 + nr_orig + nr_deferred, sizeof(u64));
> +       if (callchain =3D=3D NULL) {
> +               sample_orig->deferred_callchain =3D false;
> +               return -ENOMEM;
> +       }
> +
> +       callchain->nr =3D nr_orig + nr_deferred;
> +       /* copy except for the last PERF_CONTEXT_USER_DEFERRED */
> +       memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * siz=
eof(u64));
> +       /* copy deferred use callchains */
> +       memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips=
,
> +              nr_deferred * sizeof(u64));
> +
> +       sample_orig->callchain =3D callchain;
> +       return 0;
> +}
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 86ed9e4d04f9..89785125ed25 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -317,4 +317,7 @@ int sample__for_each_callchain_node(struct thread *th=
read, struct evsel *evsel,
>                                     struct perf_sample *sample, int max_s=
tack,
>                                     bool symbols, callchain_iter_fn cb, v=
oid *data);
>
> +int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
> +                                    struct perf_sample *sample_callchain=
);
> +
>  #endif /* __PERF_CALLCHAIN_H */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index c1a04141aed0..d23a3f8e8649 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -82,6 +82,7 @@ void evlist__init(struct evlist *evlist, struct perf_cp=
u_map *cpus,
>         evlist->ctl_fd.ack =3D -1;
>         evlist->ctl_fd.pos =3D -1;
>         evlist->nr_br_cntr =3D -1;
> +       INIT_LIST_HEAD(&evlist->deferred_samples);
>  }
>
>  struct evlist *evlist__new(void)
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index edcbf1c10e92..a8cb5a29d55e 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -84,6 +84,7 @@ struct evlist {
>                 int     pos;    /* index at evlist core object to check s=
ignals */
>         } ctl_fd;
>         struct event_enable_timer *eet;
> +       struct list_head deferred_samples;
>  };
>
>  struct evsel_str_handler {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 30fb1d281be8..51f17bf42dd9 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1277,6 +1277,56 @@ static int evlist__deliver_sample(struct evlist *e=
vlist, const struct perf_tool
>                                             per_thread);
>  }
>
> +struct deferred_event {
> +       struct list_head list;
> +       union perf_event *event;
> +};
> +
> +static int evlist__deliver_deferred_samples(struct evlist *evlist,
> +                                           const struct perf_tool *tool,
> +                                           union  perf_event *event,
> +                                           struct perf_sample *sample,
> +                                           struct machine *machine)
> +{
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       if (!tool->merge_deferred_callchains) {
> +               evsel =3D evlist__id2evsel(evlist, sample->id);
> +               return tool->callchain_deferred(tool, event, sample,
> +                                               evsel, machine);
> +       }
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample orig_sample;
> +
> +               ret =3D evlist__parse_sample(evlist, de->event, &orig_sam=
ple);
> +               if (ret < 0) {
> +                       pr_err("failed to parse original sample\n");
> +                       break;
> +               }
> +
> +               if (sample->tid !=3D orig_sample.tid)
> +                       continue;
> +
> +               evsel =3D evlist__id2evsel(evlist, orig_sample.id);
> +               sample__merge_deferred_callchain(&orig_sample, sample);
> +               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> +                                            &orig_sample, evsel, machine=
);
> +
> +               if (orig_sample.deferred_callchain)
> +                       free(orig_sample.callchain);
> +
> +               list_del(&de->list);
> +               free(de);
> +
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
>  static int machines__deliver_event(struct machines *machines,
>                                    struct evlist *evlist,
>                                    union perf_event *event,
> @@ -1305,6 +1355,16 @@ static int machines__deliver_event(struct machines=
 *machines,
>                         return 0;
>                 }
>                 dump_sample(evsel, event, sample, perf_env__arch(machine-=
>env));
> +               if (sample->deferred_callchain && tool->merge_deferred_ca=
llchains) {
> +                       struct deferred_event *de =3D malloc(sizeof(*de))=
;
> +
> +                       if (de =3D=3D NULL)
> +                               return -ENOMEM;
> +
> +                       de->event =3D event;
> +                       list_add_tail(&de->list, &evlist->deferred_sample=
s);
> +                       return 0;
> +               }
>                 return evlist__deliver_sample(evlist, tool, event, sample=
, evsel, machine);
>         case PERF_RECORD_MMAP:
>                 return tool->mmap(tool, event, sample, machine);
> @@ -1364,7 +1424,8 @@ static int machines__deliver_event(struct machines =
*machines,
>                 return tool->aux_output_hw_id(tool, event, sample, machin=
e);
>         case PERF_RECORD_CALLCHAIN_DEFERRED:
>                 dump_deferred_callchain(evsel, event, sample);
> -               return tool->callchain_deferred(tool, event, sample, evse=
l, machine);
> +               return evlist__deliver_deferred_samples(evlist, tool, eve=
nt,
> +                                                       sample, machine);
>         default:
>                 ++evlist->stats.nr_unknown_events;
>                 return -1;
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index e78f16de912e..385043e06627 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -238,6 +238,7 @@ void perf_tool__init(struct perf_tool *tool, bool ord=
ered_events)
>         tool->cgroup_events =3D false;
>         tool->no_warn =3D false;
>         tool->show_feat_hdr =3D SHOW_FEAT_NO_HEADER;
> +       tool->merge_deferred_callchains =3D true;

I think this should be false as otherwise we're going to duplicate
callchains in the same way leader sampling duplicated the sibling
event samples and needed fixing in:
https://lore.kernel.org/r/20240729220620.2957754-1-irogers@google.com

Thanks,
Ian

>
>         tool->sample =3D process_event_sample_stub;
>         tool->mmap =3D process_event_stub;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 9987bbde6d5e..d06580478ab1 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -87,6 +87,7 @@ struct perf_tool {
>         bool            cgroup_events;
>         bool            no_warn;
>         bool            dont_split_sample_group;
> +       bool            merge_deferred_callchains;
>         enum show_feature_header show_feat_hdr;
>  };
>
> --
> 2.47.2
>
>

Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D2328B55
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467951; cv=none; b=jBe2WLrPl/6+36wamrBSl2tq4/7ZFyb0CzHjK34bDZ2b/DEYXAV2qY+xh9ZAA8Tev8/ixbP1REUleBImAFcC8ilUTk7M/Q5B08hONoihqq+9nTnsoJQIy+/FOxcVg6AIZzcogcsweaNIeWDUSsTHk8BqfBhK15Wcu4gssXe+K40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467951; c=relaxed/simple;
	bh=on8o2muLGdMs6FRYdcR5RqkBnZDr66gqc5i1jlRUaV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCOibd7Td3llpWULmWfWtY4nmTdq9E7BCX+Dsj/Y+73wJYGbLQMquEEA5kfBJlUf6aLnBlzPPl/gvRkPsSKJ2yEDO6IXh+ZQmifssz3WJW/6F6B4zT9vGIrdXsLsaw2Z08we5dHZ8+r3keZEZh0H/9dx/GQ1AwLxkcZUdHf9b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tlwMJYiI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tlwMJYiI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2959197b68eso25385ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 14:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762467948; x=1763072748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEDK1hfEcmo/680Ua+14xgaxlQ0scsDrZNbhQF8yV5U=;
        b=tlwMJYiIwcPW82k8xdqlveP9gSH2Mn/0/F4mgNN/htKKpqXVPBs0mmcXjeu18WB8al
         DXrf0woXkp0mst8f+mPChUi6E+4EU02ysdDbjAeQrVXR7ZulinOH6ODMqB6O6UUKA2gH
         ulfjE1KKpjvTR3auomATh/JL1PfFwCChkfl4YOXMiC4h9VvB23ItOQSaLt/AW+K7Shka
         JAjUYUyH4Bxrm09cBCGokdN+gg+nIYUtTQLkcdcc2o2uguYBTEhYpZ4tZgFarMGTjhOy
         sJEcPALIVcNhEjkCoMMVZf++CtJp26IOrVhpuTJOZCo8H3L6+yveweaeCoDnCe0knEIx
         dX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467948; x=1763072748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEDK1hfEcmo/680Ua+14xgaxlQ0scsDrZNbhQF8yV5U=;
        b=xQky5KCd/OznRf4R4xIXVWrdsCBiTI62b85JSeBdcAx4BzqFBuzYziJa2XjKb7nMmD
         TPuR6TweQJ9apwtM1NolUDiPoypxUfsQa9mObuVqwF+oIC1gNzc0YoPv6g4yuZZ7ThqE
         vvB7iMCFaClbH6AJVJg/DrJKMfjdL0wrXEKURVBL5QLPIx2REiwiJcn2sa9lfmm+1wKZ
         d64SrCdEAZVtFd78/TP0xSgXIHbdM/1oO9/hZA6aaJfZFn3nC2RWUnWzk8OAZkHLiG7T
         6+fUw/XNK/O63vPuUxyvx3q/mbOh1x5r8CqrByElfOLVUkcZ5P9QtddAE4TRO7rn+tbS
         VDQA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAtdVouMdlQSNyFKCm41aWjOs1PhfaKoWb5YmFsoMInI+pUXd+VLO4lxrvO8/l8SdAWnyFAtLsF4cURmFV6VU@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZ+uThu7wS9v09B6WKP35EYWOGDZ0JweKiyw+2/8DaHq6+OQg
	mGES/dE6BXAKlOsfxQfP22HFYWcgVZXK8kvO0T+/zlfKOgay4o81rhSMWZIGyr+GI0oFUX8Fc1K
	tzUz/UYhgP/OZc/kIuhReYqsuITwqpQ8BKGsOvTzp
X-Gm-Gg: ASbGnct6x+47n3jGyib7yh2tNgdaPYNkWESYLBaDB4MJqaL0tal27CnqlW9JRMx8PpE
	/g78q6rEBFUirfERkvUk/B3G8otPe0v+TDiMObqK0tTPsIrNIzHWEEd8K7OT62weTr3aua3PVMM
	oAPwclvIW/EoNowe3Nmldwdh4coUMI5Rr0ar5z0M4pAe+BwSkNB3xgfWXwnzTqp4zJEKqoCZTZU
	j4bvhIIaiiPeVD4vC9NLP8PtDUOjT9WBiL2tDBRUii0rhF6OYIUfGGGK6cEBk1DNVdnT2ONnx15
	GALIW8OhmV6pqto=
X-Google-Smtp-Source: AGHT+IF/AYoqHkE51TYAb9qQcRMzYmh7TDNjQIBJNEWOQSvtt/abJiBjf7KU6DdKI8ndDGBCQlDHlydX5BahG89yjAk=
X-Received: by 2002:a17:902:e5c1:b0:294:f745:fe7b with SMTP id
 d9443c01a7336-297c5560a37mr789565ad.6.1762467948032; Thu, 06 Nov 2025
 14:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105001103.1296863-1-irogers@google.com> <20251105001103.1296863-2-irogers@google.com>
 <aQzyPf1_vln3WoSL@google.com>
In-Reply-To: <aQzyPf1_vln3WoSL@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Nov 2025 14:25:36 -0800
X-Gm-Features: AWmQ_bmJcL3jOHwIwIKsxtxq23ueYZUAnc-0RXPRG7FUNeQOsk4g7d375GgWazY
Message-ID: <CAP-5=fWWLKDCRXR4+jV4bU13U9tV8oZy3x9iwnUhPGg9Ej1H3A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf tool: Add a delegate_tool that just delegates
 actions to another tool
To: Namhyung Kim <namhyung@kernel.org>
Cc: Gabriel Marin <gmx@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Blake Jones <blakejones@google.com>, Anubhav Shelat <ashelat@redhat.com>, Leo Yan <leo.yan@arm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Nov 04, 2025 at 04:11:03PM -0800, Ian Rogers wrote:
> > Add an ability to be able to compose perf_tools, by having one perform
> > an action and then calling a delegate. Currently the perf_tools have
> > if-then-elses setting the callback and then if-then-elses within the
> > callback. Understanding the behavior is complex as it is in two places
> > and logic for numerous operations, within things like perf inject, is
> > interwoven. By chaining perf_tools together based on command line
> > options this kind of code can be avoided.
>
> Can you please explain what the actual usecase is?  Do you plan to use
> it for perf inject?

It is mainly refactoring for new perf inject tooling that isn't ready
yet. However, changing the tool API impacts things like the python
perf session work:
https://lore.kernel.org/lkml/20251029053413.355154-12-irogers@google.com/
so it'd be nice if it could land as clean up.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/tool.c | 171 +++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/tool.h |   9 +++
> >  2 files changed, 180 insertions(+)
> >
> > diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> > index c983b526b30d..22a8a4ffe05f 100644
> > --- a/tools/perf/util/tool.c
> > +++ b/tools/perf/util/tool.c
> > @@ -321,3 +321,174 @@ bool perf_tool__compressed_is_stub(const struct p=
erf_tool *tool)
> >  {
> >       return tool->compressed =3D=3D perf_session__process_compressed_e=
vent_stub;
> >  }
> > +
> > +#define CREATE_DELEGATE_SAMPLE(name) \
> > +     static int delegate_ ## name(const struct perf_tool *tool, \
> > +                                  union perf_event *event, \
> > +                                  struct perf_sample *sample, \
> > +                                  struct evsel *evsel, \
> > +                                  struct machine *machine) \
> > +     {                                                               \
> > +             struct delegate_tool *del_tool =3D container_of(tool, str=
uct delegate_tool, tool); \
> > +             struct perf_tool *delegate =3D del_tool->delegate;       =
         \
> > +             return delegate->name(delegate, event, sample, evsel, mac=
hine); \
> > +     }
> > +CREATE_DELEGATE_SAMPLE(read);
> > +CREATE_DELEGATE_SAMPLE(sample);
> > +
> > +#define CREATE_DELEGATE_ATTR(name)                                   \
> > +     static int delegate_ ## name(const struct perf_tool *tool,      \
> > +                             union perf_event *event,                \
> > +                             struct evlist **pevlist)                \
> > +     {                                                               \
> > +             struct delegate_tool *del_tool =3D container_of(tool, str=
uct delegate_tool, tool); \
> > +             struct perf_tool *delegate =3D del_tool->delegate;       =
         \
> > +             return delegate->name(delegate, event, pevlist);        \
> > +     }
> > +CREATE_DELEGATE_ATTR(attr);
> > +CREATE_DELEGATE_ATTR(event_update);
> > +
> > +#define CREATE_DELEGATE_OE(name)                                \
> > +     static int delegate_ ## name(const struct perf_tool *tool, \
> > +                                  union perf_event *event,      \
> > +                                  struct ordered_events *oe)    \
> > +     {                                                               \
> > +             struct delegate_tool *del_tool =3D container_of(tool, str=
uct delegate_tool, tool); \
> > +             struct perf_tool *delegate =3D del_tool->delegate;       =
         \
> > +             return delegate->name(delegate, event, oe);     \
> > +     }
> > +CREATE_DELEGATE_OE(finished_round);
> > +
> > +#define CREATE_DELEGATE_OP(name)                                \
> > +     static int delegate_ ## name(const struct perf_tool *tool, \
> > +                                  union perf_event *event, \
> > +                                  struct perf_sample *sample, \
> > +                                  struct machine *machine) \
> > +     {                                                               \
> > +             struct delegate_tool *del_tool =3D container_of(tool, str=
uct delegate_tool, tool); \
> > +             struct perf_tool *delegate =3D del_tool->delegate;       =
         \
> > +             return delegate->name(delegate, event, sample, machine); =
\
> > +     }
> > +CREATE_DELEGATE_OP(aux);
> > +CREATE_DELEGATE_OP(aux_output_hw_id);
> > +CREATE_DELEGATE_OP(bpf);
> > +CREATE_DELEGATE_OP(cgroup);
> > +CREATE_DELEGATE_OP(comm);
> > +CREATE_DELEGATE_OP(context_switch);
> > +CREATE_DELEGATE_OP(exit);
> > +CREATE_DELEGATE_OP(fork);
> > +CREATE_DELEGATE_OP(itrace_start);
> > +CREATE_DELEGATE_OP(ksymbol);
> > +CREATE_DELEGATE_OP(lost);
> > +CREATE_DELEGATE_OP(lost_samples);
> > +CREATE_DELEGATE_OP(mmap);
> > +CREATE_DELEGATE_OP(mmap2);
> > +CREATE_DELEGATE_OP(namespaces);
> > +CREATE_DELEGATE_OP(text_poke);
> > +CREATE_DELEGATE_OP(throttle);
> > +CREATE_DELEGATE_OP(unthrottle);
> > +
> > +#define CREATE_DELEGATE_OP2(name)                                    \
> > +     static int delegate_ ## name(const struct perf_tool *tool,      \
> > +                                  struct perf_session *session,      \
> > +                                  union perf_event *event)           \
> > +     {                                                               \
> > +             struct delegate_tool *del_tool =3D container_of(tool, str=
uct delegate_tool, tool); \
> > +             struct perf_tool *delegate =3D del_tool->delegate;       =
         \
> > +             return delegate->name(delegate, session, event);        \
> > +     }
> > +CREATE_DELEGATE_OP2(auxtrace_error);
> > +CREATE_DELEGATE_OP2(auxtrace_info);
> > +CREATE_DELEGATE_OP2(bpf_metadata);
> > +CREATE_DELEGATE_OP2(build_id);
> > +CREATE_DELEGATE_OP2(cpu_map);
> > +CREATE_DELEGATE_OP2(feature);
> > +CREATE_DELEGATE_OP2(finished_init);
> > +CREATE_DELEGATE_OP2(id_index);
> > +CREATE_DELEGATE_OP2(stat);
> > +CREATE_DELEGATE_OP2(stat_config);
> > +CREATE_DELEGATE_OP2(stat_round);
> > +CREATE_DELEGATE_OP2(thread_map);
> > +CREATE_DELEGATE_OP2(time_conv);
> > +CREATE_DELEGATE_OP2(tracing_data);
> > +
> > +#define CREATE_DELEGATE_OP3(name)                                    \
> > +     static s64 delegate_ ## name(const struct perf_tool *tool,      \
> > +                                  struct perf_session *session,      \
> > +                                  union perf_event *event)           \
> > +     {                                                               \
> > +             struct delegate_tool *del_tool =3D container_of(tool, str=
uct delegate_tool, tool); \
> > +             struct perf_tool *delegate =3D del_tool->delegate;       =
 \
> > +             return delegate->name(delegate, session, event);        \
> > +     }
> > +CREATE_DELEGATE_OP3(auxtrace);
> > +
> > +#define CREATE_DELEGATE_OP4(name)                                    \
> > +     static int delegate_ ## name(const struct perf_tool *tool, \
> > +                     struct perf_session *session, \
> > +                     union perf_event *event, \
> > +                     u64 data, \
> > +                     const char *str) \
> > +     {                                                               \
> > +             struct delegate_tool *del_tool =3D container_of(tool, str=
uct delegate_tool, tool); \
> > +             struct perf_tool *delegate =3D del_tool->delegate;       =
         \
> > +             return delegate->name(delegate, session, event, data, str=
);     \
> > +     }
> > +CREATE_DELEGATE_OP4(compressed);
> > +
> > +void delegate_tool__init(struct delegate_tool *tool, struct perf_tool =
*delegate)
> > +{
> > +     tool->delegate =3D delegate;
> > +
> > +     tool->tool.ordered_events =3D delegate->ordered_events;
> > +     tool->tool.ordering_requires_timestamps =3D delegate->ordering_re=
quires_timestamps;
> > +     tool->tool.namespace_events =3D delegate->namespace_events;
> > +     tool->tool.cgroup_events =3D delegate->cgroup_events;
> > +     tool->tool.no_warn =3D delegate->no_warn;
> > +     tool->tool.show_feat_hdr =3D delegate->show_feat_hdr;
> > +
> > +     tool->tool.sample =3D delegate_sample;
> > +     tool->tool.read =3D delegate_read;
> > +
> > +     tool->tool.mmap =3D delegate_mmap;
> > +     tool->tool.mmap2 =3D delegate_mmap2;
> > +     tool->tool.comm =3D delegate_comm;
> > +     tool->tool.namespaces =3D delegate_namespaces;
> > +     tool->tool.cgroup =3D delegate_cgroup;
> > +     tool->tool.fork =3D delegate_fork;
> > +     tool->tool.exit =3D delegate_exit;
> > +     tool->tool.lost =3D delegate_lost;
> > +     tool->tool.lost_samples =3D delegate_lost_samples;
> > +     tool->tool.aux =3D delegate_aux;
> > +     tool->tool.itrace_start =3D delegate_itrace_start;
> > +     tool->tool.aux_output_hw_id =3D delegate_aux_output_hw_id;
> > +     tool->tool.context_switch =3D delegate_context_switch;
> > +     tool->tool.throttle =3D delegate_throttle;
> > +     tool->tool.unthrottle =3D delegate_unthrottle;
> > +     tool->tool.ksymbol =3D delegate_ksymbol;
> > +     tool->tool.bpf =3D delegate_bpf;
> > +     tool->tool.text_poke =3D delegate_text_poke;
> > +
> > +     tool->tool.attr =3D delegate_attr;
> > +     tool->tool.event_update =3D delegate_event_update;
> > +
> > +     tool->tool.tracing_data =3D delegate_tracing_data;
> > +
> > +     tool->tool.finished_round =3D delegate_finished_round;
> > +
> > +     tool->tool.build_id =3D delegate_build_id;
> > +     tool->tool.id_index =3D delegate_id_index;
> > +     tool->tool.auxtrace_info =3D delegate_auxtrace_info;
> > +     tool->tool.auxtrace_error =3D delegate_auxtrace_error;
> > +     tool->tool.time_conv =3D delegate_time_conv;
> > +     tool->tool.thread_map =3D delegate_thread_map;
> > +     tool->tool.cpu_map =3D delegate_cpu_map;
> > +     tool->tool.stat_config =3D delegate_stat_config;
> > +     tool->tool.stat =3D delegate_stat;
> > +     tool->tool.stat_round =3D delegate_stat_round;
> > +     tool->tool.feature =3D delegate_feature;
> > +     tool->tool.finished_init =3D delegate_finished_init;
> > +     tool->tool.bpf_metadata =3D delegate_bpf_metadata;
> > +     tool->tool.compressed =3D delegate_compressed;
> > +     tool->tool.auxtrace =3D delegate_auxtrace;
> > +}
> > diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> > index 1f1461808371..88337cee1e3e 100644
> > --- a/tools/perf/util/tool.h
> > +++ b/tools/perf/util/tool.h
> > @@ -102,4 +102,13 @@ int process_event_sample_stub(const struct perf_to=
ol *tool,
> >                             struct evsel *evsel,
> >                             struct machine *machine);
> >
> > +struct delegate_tool {
> > +     /** @tool: The actual tool that calls the delegate. */
> > +     struct perf_tool tool;
> > +     /** @delegate: The tool that is delegated to. */
> > +     struct perf_tool *delegate;
> > +};
> > +
> > +void delegate_tool__init(struct delegate_tool *tool, struct perf_tool =
*delegate);
> > +
> >  #endif /* __PERF_TOOL_H */
> > --
> > 2.51.2.1006.ga50a493c49-goog
> >

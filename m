Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2838449B2D
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995651; cv=pass; b=AxRuX+5+w2keqmcJj/HQ5vtTVEcXNrdRqawGSr/X6Xard7bXqE7H4xHoqQPJiu2sdmweAQG18F1jQgVVSaZ3cAZY5VSjtdpzKB7dVj3BXCrv2dHH5fLIUYmAis7BtdNc9YodSE2p/FWVj0vH9ReU+JHkk7RMGmTvQtub4Ebw87g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995651; c=relaxed/simple;
	bh=g5IVsB4QXereC1HgQlLtE+OhGwCaDPgyL+9o+C+d+ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKU0HaA2U6SfLoq0BiIXXewhcYmAYlg5lpa6u7oNzNMnd7K8v4G/RZU8iMxzExUFj0ZUaFimRcPzGF/gcutWINca3hT3OPaSSGFIaeL80/bXmbyc0Xdgn7oHZB+fGWeyK0em5lJcME+RnrGYmLm4M4u174wcexMNvTD0lEQjLzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdr9LcRb; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdr9LcRb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso24225ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 12:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786995649; cv=none;
        d=google.com; s=arc-20260327;
        b=U5N/74u1ElWNfDEkWoXL0JL6VUxGyw4sZAyNRCFHhOmVbJSN+2NgtcW+aosKsy1pfy
         O4DgYcNo9FDpdepgKmxfVTZAifzqBVFIG3uNOVhdGPyRo+SUtGF1fvTtREjqMS8IruXQ
         T0H3F21IBFn95F0hlJ97sqgC9RMNup7IpXIlliHtajxEe97Q+Ss8wt88PyqehS59tjxz
         BY+rTP2UryRXQArE5IdU5O7GyZAu+d9AQoVf3Jfrrp23X7GzJmda4+N73fBKC3ZoRJgv
         wglGR3vIUUqTsEpC+SFPMv9xbYJ24BgobhBZouYalPBM6/dUtwXdaEKk5dJ8/iD2augQ
         K+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jjWSURDRdGCJdNZ46NVW9aEIflRWQPuT5fdrLLdxz08=;
        fh=f8Fs7FU2rnNJgAFQ9oyGr3wBnGmjycUsAkOkuze9p/Q=;
        b=haqeukbmyqf6ITNFeVRhv6yZE7m6MzPyZgNwj84XbHScWmgX/8VZQi25LpMjv+JhWr
         A26zuOe5s45ryBIJC+b3qIF511v4fjpDHNpBQTtSqbYwC89XbqjX6BvUzWMj99GVi07s
         6ksPmaHlYwK8FF2KSAYxCFfsraNfDbH1WtexGHFEfZuTPT8cKyEb3OXRQlZdp7XXQVRV
         mZaL0BukzYk58SLDk2TjZ4nspCAET6uEi1B46ZgfrCTZlLbTOiss/joD3JWFctTBU2bM
         Vg6PtN0vi3zKGogKMKXJhsjL0RWgNrzoPPmuTaswRBj39Xn2OxyeFgzDcqZbI4Xc8aWB
         WF5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786995649; x=1787600449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jjWSURDRdGCJdNZ46NVW9aEIflRWQPuT5fdrLLdxz08=;
        b=kdr9LcRbD/usIzTTxfl6gnMHV4mtW9W055v5Yr79REqh7RuDISKdc1HadCN5bt+x/y
         u6ONXxXMHDoXNA3fopYF0vswymEvGxUiphGE4aIumIRvFcw2iCmBbYMspWjY3poik7CA
         VdY+VVxfxvy/zMW1KuLjXbkiB9Oyu8pHwIqRWIcPgkXUNRgtv8j5y2Xur6KTYAReY1Co
         9e8MVgC5G+GXBZSK6NkBQwUYmNjCxCl0x8NS3X/l0QinPYP3FlEvwNx0IVtc4Iq0GU8x
         enI1wScB14ag5WmW65I0g3Y7YUWaA9c9bPgQiGOat1g1PLyiVlEZSrJ6rfmtskb+Uweh
         0jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786995649; x=1787600449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjWSURDRdGCJdNZ46NVW9aEIflRWQPuT5fdrLLdxz08=;
        b=NgrLdGP1GuF+Okjh2xD2ENi+BhCwZWgz2+35iMrqwFP8c2Kz2rcvnffRSCTbbbifET
         CFvHAYY1GY8ml7/MKpIvwcgTKuTUbti+X+5QGPgFY7UBx+AwEdsgY3cia9CK5fQd/9lf
         IqbU7xN2CbBWVNaXqBdf3JiN6OieLSQL+N21t+KYnaRUaohrOrVYEiUnjd48A7nG8b1O
         s4AWnJvlG4CcThMCCAUVXgGyvyJA7iv3bPCdrCNdtNirE0qmFhMLJ6qXgwhlwWb2Nifp
         hANuk4R3ZcQQba7SZlcL45pxfNvp/e3YKrjEhXYvfddBCE16kAmUi0hd9pJxjnD8wdMc
         aa0w==
X-Forwarded-Encrypted: i=1; AHgh+Rq79TXFaiZ/08bdHX8fM1Bkq/3e9c2pkyABjb1t4L/pY715V3FBYLRpRRs/Psk86yWNWgn7DVKwrGhdSEpJ8PRf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7EWudxQvgmQVtyeBhSPphCc82jluTH2ZeinRjATHWVuFLVaW9
	B2HDqtyXIWV7MbEKui0FW2tAbyIZVx9AJpZICvEy/xHB+ifk1M5t+z948e1mvC1Jp9PHwhrCbkH
	d81vSYTD37Vh9tuw/NV3ciLQo0leiAYZUQOTTbcsQ
X-Gm-Gg: AR+sD12iw78rbo/U07fNK4zenB7b74qqs1ONGKyVHbUs21yBirGgjquv/OVnc+5+O/v
	mSe+66Q2fr5boo5S93NF4Ooa+5dfUkdrVij8nCAosmqOuy/zG0WceYdsB3sN7CAORZwsNOBEYK7
	0AlI+CQN65aCfKIpP8lJKQxolnmHWksqWA41Ijf1nwMvC8YoDa/yAulKA3hVrHv+OrzqiFQxxvq
	Lv3O8k2wJHzVP+dftHKdxnkx5HLVGnqJqlJQ+KsRC+mdJxnva6veGoFT1W+VV3M3cG6VI/aCWoK
	9w75fRDZhE2gfslehbU7ejs6+4JrQycSflmm+8tQU6qxMp4uuejzQjS8RQvHAIAgsIMho/4nXsE
	=
X-Received: by 2002:a17:903:22c2:b0:2c7:a13a:7fe6 with SMTP id
 d9443c01a7336-2d5cca06e5fmr2273125ad.10.1786995648180; Mon, 17 Aug 2026
 12:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org>
In-Reply-To: <20260813132519.4099508-1-andi@firstfloor.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 12:40:35 -0700
X-Gm-Features: AcwNN1XNUAbdN4T1rdOlLqYsYC10tASmwnQezQb4jzc5_J38l9s9TxYus5rHfpY
Message-ID: <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
To: Andi Kleen <andi@firstfloor.org>
Cc: namhyung@kernel.org, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@kernel.org>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 6:33=E2=80=AFAM Andi Kleen <andi@firstfloor.org> wr=
ote:
>
> From: Andi Kleen <ak@kernel.org>
>
> One annoyance with perf top on a hybrid system is that it requires to
> chose which hybrid PMU to sample on. Normally I want to sample the whole
> system and don't know on which cores my workload ends up.
>
> This patch automatically merges the two PMUs when the event is present
> in both PMUs. For now it only handles simple TYPE_HARDWARE cases, like
> cycles
> (could be later extended for TYPE_RAW too by checking the json name is th=
e same)
> The behavior can be disabled with --no-hybrid-merge

Thanks Andi, I agree with the frustration. For an event like
instructions I would like things merged. Does merging make sense for
cycles given the different clock frequencies of p-cores and e-cores?
Should the e-core cycles be scaled for this reason as there are fewer
cycles within a second compared to a p-core?

Perhaps we need a new json field to describe the hybrid merge-ability
of events, say enabled on events like instructions or cache misses.
Note the legacy events now have JSON descriptions:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/common/common/legacy-hardware.json?h=3Dpe=
rf-tools-next

It would be nice if this were a generic feature and not just for perf top.

Thanks,
Ian

> Assisted-by: omp:GLM-5.2
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-top.txt |  6 ++++
>  tools/perf/builtin-top.c              | 16 ++++++++++
>  tools/perf/ui/hist.c                  | 19 ++++++++++++
>  tools/perf/util/evlist.c              | 43 +++++++++++++++++++++++++++
>  tools/perf/util/evlist.h              |  1 +
>  tools/perf/util/hist.h                | 15 +++++++++-
>  tools/perf/util/top.c                 |  8 ++++-
>  tools/perf/util/top.h                 |  1 +
>  8 files changed, 107 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documenta=
tion/perf-top.txt
> index af3e4230c72f4..e560d6b1634d8 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -43,6 +43,12 @@ Default is to monitor all CPUS.
>         encoding with the layout of the event control registers as descri=
bed
>         by entries in /sys/bus/event_source/devices/cpu/format/*.
>
> +--hybrid-merge::
> +    Merge matching legacy hardware events from all hybrid core PMUs into=
 one
> +    display. This is enabled by default when the same event is available=
 on
> +    each core PMU. Use `--no-hybrid-merge` to display the existing per-e=
vent
> +    selection menu instead.
> +
>  --filter=3D<filter>::
>         Event filter.  This option should follow an event selector (-e). =
For
>         syntax see linkperf:perf-record[1].
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 1211401616ee3..19dec094683b3 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1334,6 +1334,19 @@ static int __cmd_top(struct perf_top *top)
>          */
>          if (!target__none(&opts->target))
>                 evlist__enable(top->evlist);
> +       if (top->hybrid_merge && !symbol_conf.report_hierarchy &&
> +           evlist__can_merge_hybrid(top->evlist)) {
> +               struct evsel *leader =3D evlist__first(top->evlist);
> +
> +               /*
> +                * Merged events are not true groups, but can use
> +                * the existing group display code to display them
> +                * anyways.
> +                */
> +               __perf_evlist__set_leader(&top->evlist->core.entries, &le=
ader->core);
> +               evsel__hists(leader)->merge_entries =3D true;
> +               symbol_conf.event_group =3D true;
> +       }
>
>         ret =3D -1;
>         if (pthread_create(&thread_process, NULL, process_thread, top)) {
> @@ -1457,6 +1470,7 @@ int cmd_top(int argc, const char **argv)
>         struct perf_top top =3D {
>                 .count_filter        =3D 5,
>                 .delay_secs          =3D 2,
> +               .hybrid_merge        =3D true,
>                 .record_opts =3D {
>                         .mmap_pages     =3D UINT_MAX,
>                         .user_freq      =3D UINT_MAX,
> @@ -1490,6 +1504,8 @@ int cmd_top(int argc, const char **argv)
>         OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
>                      "event selector. use 'perf list' to list available e=
vents",
>                      parse_events_option),
> +       OPT_BOOLEAN(0, "hybrid-merge", &top.hybrid_merge,
> +                   "merge the same event across hybrid core PMUs"),
>         OPT_CALLBACK(0, "filter", &top.evlist, "filter",
>                      "event filter", parse_filter),
>         OPT_U64('c', "count", &opts->user_interval, "event period to samp=
le"),
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index e58327595d37d..aee43b33e4e1e 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -287,6 +287,25 @@ static int __hpp__sort(struct hist_entry *a, struct =
hist_entry *b,
>                 return __hpp__group_sort_idx(a, b, get_field,
>                                              symbol_conf.group_sort_idx);
>         }
> +       /*
> +        * Relies on merge_entries being only enabled if there are
> +        * only matching events. If that is ever relaxed will need
> +        * more logic here.
> +        */
> +       if (a->hists->merge_entries && b->hists->merge_entries) {
> +               u64 val_a =3D get_field(a), val_b =3D get_field(b);
> +               struct hist_entry *pair;
> +
> +               list_for_each_entry(pair, &a->pairs.head, pairs.node)
> +                       val_a +=3D get_field(pair);
> +               list_for_each_entry(pair, &b->pairs.head, pairs.node)
> +                       val_b +=3D get_field(pair);
> +
> +               ret =3D field_cmp(val_a, val_b);
> +               if (ret)
> +                       return ret;
> +               /* fall through to per-member tiebreaker */
> +       }
>
>         ret =3D field_cmp(get_field(a), get_field(b));
>         if (ret || !symbol_conf.event_group)
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1a238b245b3a0..4140f998e8a9b 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -142,6 +142,49 @@ struct evlist *evlist__new_default(const struct targ=
et *target, bool sample_call
>         return NULL;
>  }
>
> +bool evlist__can_merge_hybrid(struct evlist *evlist)
> +{
> +       struct evsel *pos, *other;
> +       u64 config =3D 0;
> +       unsigned int nr =3D 0;
> +       bool first =3D true;
> +       int nr_core_pmus;
> +
> +       nr_core_pmus =3D perf_pmus__num_core_pmus();
> +       if (nr_core_pmus <=3D 1)
> +               return false;
> +
> +       evlist__for_each_entry(evlist, pos) {
> +               if (evsel__is_dummy_event(pos))
> +                       continue;
> +
> +               /* Initial support is for legacy hardware events, such as=
 cycles. */
> +               if (!pos->pmu || !pos->pmu->is_core ||
> +                   pos->core.attr.type !=3D PERF_TYPE_HARDWARE)
> +                       return false;
> +
> +               if (first) {
> +                       /*
> +                        * Filter out the PMU bits. May need something el=
se
> +                        * for other types.
> +                        */
> +                       config =3D pos->core.attr.config & UINT32_MAX;
> +                       first =3D false;
> +               } else if ((pos->core.attr.config & UINT32_MAX) !=3D conf=
ig) {
> +                       return false;
> +               }
> +
> +               evlist__for_each_entry(evlist, other) {
> +                       if (other !=3D pos && !evsel__is_dummy_event(othe=
r) &&
> +                           other->pmu =3D=3D pos->pmu)
> +                               return false;
> +               }
> +
> +               nr++;
> +       }
> +       return !first && nr =3D=3D (unsigned int)nr_core_pmus;
> +}
> +
>  struct evlist *evlist__new_dummy(void)
>  {
>         struct evlist *evlist =3D evlist__new();
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e507f5f20ef61..ad0e6e7399d2a 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -105,6 +105,7 @@ struct evsel_str_handler {
>
>  struct evlist *evlist__new(void);
>  struct evlist *evlist__new_default(const struct target *target, bool sam=
ple_callchains);
> +bool evlist__can_merge_hybrid(struct evlist *evlist);
>  struct evlist *evlist__new_dummy(void);
>  void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>                   struct perf_thread_map *threads);
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index b830cbe7f95bf..a9dd423ded5e1 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -130,6 +130,7 @@ struct hists {
>         struct hists_stats      stats;
>         u64                     event_stream;
>         u16                     col_len[HISTC_NR_COLS];
> +       bool                    merge_entries;
>         bool                    has_callchains;
>         int                     socket_filter;
>         struct perf_hpp_list    *hpp_list;
> @@ -435,14 +436,26 @@ int hists__unlink(struct hists *hists);
>
>  static inline float hist_entry__get_percent_limit(struct hist_entry *he)
>  {
> +       struct hist_entry *pair;
>         u64 period =3D he->stat.period;
>         u64 total_period =3D hists__total_period(he->hists);
>
> +       if (he->hists->merge_entries) {
> +               list_for_each_entry(pair, &he->pairs.head, pairs.node) {
> +                       period +=3D pair->stat.period;
> +                       total_period +=3D hists__total_period(pair->hists=
);
> +               }
> +       }
> +
>         if (unlikely(total_period =3D=3D 0))
>                 return 0;
>
> -       if (symbol_conf.cumulate_callchain)
> +       if (symbol_conf.cumulate_callchain) {
>                 period =3D he->stat_acc->period;
> +               if (he->hists->merge_entries)
> +                       list_for_each_entry(pair, &he->pairs.head, pairs.=
node)
> +                               period +=3D pair->stat_acc->period;
> +       }
>
>         return period * 100.0 / total_period;
>  }
> diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
> index b06e10a116bb3..b7ae51fbc9541 100644
> --- a/tools/perf/util/top.c
> +++ b/tools/perf/util/top.c
> @@ -78,7 +78,13 @@ size_t perf_top__header_snprintf(struct perf_top *top,=
 char *bf, size_t size)
>                                 opts->freq ? "Hz" : "");
>         }
>
> -       ret +=3D SNPRINTF(bf + ret, size - ret, "%s", evsel__name(top->sy=
m_evsel));
> +       if (evsel__is_group_event(top->sym_evsel)) {
> +               char buf[256];
> +               evsel__group_desc(top->sym_evsel, buf, sizeof(buf));
> +               ret +=3D SNPRINTF(bf + ret, size - ret, "%s", buf);
> +       } else {
> +               ret +=3D SNPRINTF(bf + ret, size - ret, "%s", evsel__name=
(top->sym_evsel));
> +       }
>
>         ret +=3D SNPRINTF(bf + ret, size - ret, "], ");
>
> diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> index 04ff926846be0..b42e23066fc0d 100644
> --- a/tools/perf/util/top.h
> +++ b/tools/perf/util/top.h
> @@ -32,6 +32,7 @@ struct perf_top {
>         u64                guest_us_samples, guest_kernel_samples;
>         int                print_entries, count_filter, delay_secs;
>         int                max_stack;
> +       bool               hybrid_merge;
>         bool               hide_kernel_symbols, hide_user_symbols, zero;
>  #ifdef HAVE_SLANG_SUPPORT
>         bool               use_tui;
> --
> 2.54.0
>
>

Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5B130AF6
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204566; cv=none; b=LCFPB0JQdTUx/HpsTrLTeH8MHJpHAGKTACL4yOia++EA9JJTIicMh4wtWeV4+kBzzIkIP8pkKDzrae+HnuMW7EFWbL25gY0a6F6grqjUlN9PFf08Qc+bPN2cW/7Pp4umBa56hJUYyQsv6qN7JermM2WLT9CJ1kP6f/BymvF/2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204566; c=relaxed/simple;
	bh=bsLuB140MEyfau4ECPs7vpCPvc5bgGwnlGUriRLul1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCKahDCHhn/WQWrA9g+5oJO3LO3QdopLLfrulQ5UJ4EJkyF388FUqTUltZ8e/2tP4cfYZfgToZGq7k1camZBScIhU0YCG97n/mhSRImg4ygLmozDh/b+aKBt9wMWYzRiVZAE9QNANRVXhLFwopN2KtrGUdGTXlJyq0Ateq6SZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvyhNBRR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvyhNBRR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43d361a2124so120831cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715204563; x=1715809363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skc0tIsaJcblwCFpMnFUNVX1uJdmvr0YzeYMA+qILT0=;
        b=BvyhNBRRD8jFwBGHgHJIaP3DB29FXhgR7jWuTNYf1yTjXF2bcgJM4Vq6wUWdu6bmeJ
         aCmTD0LWg/7Jl1fHFyFMoDbNpMiLbBJizgmrZKSRU3IfAkgncLDALykDRpDHZjlvhN79
         M7r7GcWCuUxAILbPenlLRi+mp2hgUg+c1kEpmVanL9+ePbKSOcQLwVuKwBi6t1n8sHEZ
         /AM6FevRzNmaWHQ4b34VE0MjizHa7RwllzCLLwr/wg7u/UFLy4zZuV+dMceS9NkGm3iM
         jcU6x5rpyNW7gyIxVDZIJPhYNkINTUpzCdFFp2lP7EyCE0fKmc3c6FAudM28bCw/FEcZ
         TvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715204563; x=1715809363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skc0tIsaJcblwCFpMnFUNVX1uJdmvr0YzeYMA+qILT0=;
        b=BH4/QTr14jSv2BHQAbyLu4wLgsWwmdBgVXkZcVPRdT5L8ftLkSGyFkWrpb08uEtcF+
         3AJfwrUbegoUuaKq4fQcNPutf9OqcTUTSBhV3qYpMYWP5f9AKLo6EJjsEGwsZnHMKvfL
         bgj409WW7XAxlZQR28sknDi7aH2nF1dafm9QqiXM87trE2s5Y0OGQgjxmKbA2smZSB/6
         EZ7s+5ZJAup4nx+3DPxs7BQkrEP99JQdeYFq/oDVHF+z81g4L7DoU3F1VHuPNLG8xx0o
         RAuOSKPfpyOjqaOSiEHdTYeYpLJffOAepfdz3jaVOa7c91J8j4AukyobbOjU5h42EcJt
         mYew==
X-Forwarded-Encrypted: i=1; AJvYcCVW1AGVM9wt5tx301DQXSkOz1P82E6wlqdApSosQ42qIQKEncyCJtWbsgjhvwGBIAjRKxxBQqcoGfNLQnFeRLOj/6NLFeWwwggcznbmA4P1xA==
X-Gm-Message-State: AOJu0Yxg3ilbtV/xtwX5FyVubPNTIk0eh27N7O72PZGjUavbmdgyLCdj
	Xry0AQpJncSTOLk1zshNv78q0Kswk8daKsUSwBhSkCqKG1KBD/IX8bvmzbhRCujrUq4dVCm4xCF
	vs8shL9L6Oa5mB+gMnu0OIhBH48O9oFXLwd0+
X-Google-Smtp-Source: AGHT+IFul7/h8r5dGa2DaJHdN9VATsV8VAfjs52cnlcWDyB7aExXa5T8d5kfEQaTb+xLLS/2B/A+DouGjNsNbWBArQ4=
X-Received: by 2002:a05:622a:5a92:b0:43b:af4:d3a with SMTP id
 d75a77b69052e-43df48246c1mr181251cf.19.1715204563034; Wed, 08 May 2024
 14:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org> <20240505-perf_digit-v2-2-6ece307fdaad@codewreck.org>
In-Reply-To: <20240505-perf_digit-v2-2-6ece307fdaad@codewreck.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 14:42:31 -0700
Message-ID: <CAP-5=fVuDXjWq85G3Q0RNQjbQE2Y7Sh+JSK_g+dBK9zEj=vjUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf parse-events: Add new 'fake_tp' parameter for tests
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:14=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> The next commit will allow tracepoints starting with digits, but most
> systems do not have any available by default so tests should skip the
> actual "check if it exists in /sys/kernel/debug/tracing" step.
>
> In order to do that, add a new boolean flag specifying if we should
> actually "format" the probe or not.
>
> Originally-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/parse-events.c |  6 ++++--
>  tools/perf/tests/pmu-events.c   |  2 +-
>  tools/perf/util/evlist.c        |  3 ++-
>  tools/perf/util/evsel.c         | 20 +++++++++++++-------
>  tools/perf/util/evsel.h         |  4 ++--
>  tools/perf/util/metricgroup.c   |  3 ++-
>  tools/perf/util/parse-events.c  |  9 ++++++---
>  tools/perf/util/parse-events.h  |  6 ++++--
>  8 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index feb5727584d1..ef056e8740fe 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2504,7 +2504,8 @@ static int test_event(const struct evlist_test *e)
>                 return TEST_FAIL;
>         }
>         parse_events_error__init(&err);
> -       ret =3D parse_events(evlist, e->name, &err);
> +       ret =3D __parse_events(evlist, e->name, /*pmu_filter=3D*/NULL, &e=
rr, /*fake_pmu=3D*/NULL,
> +                            /*warn_if_reordered=3D*/true, /*fake_tp=3D*/=
true);
>         if (ret) {
>                 pr_debug("failed to parse event '%s', err %d\n", e->name,=
 ret);
>                 parse_events_error__print(&err, e->name);
> @@ -2532,7 +2533,8 @@ static int test_event_fake_pmu(const char *str)
>
>         parse_events_error__init(&err);
>         ret =3D __parse_events(evlist, str, /*pmu_filter=3D*/NULL, &err,
> -                            &perf_pmu__fake, /*warn_if_reordered=3D*/tru=
e);
> +                            &perf_pmu__fake, /*warn_if_reordered=3D*/tru=
e,
> +                            /*fake_tp=3D*/true);
>         if (ret) {
>                 pr_debug("failed to parse event '%s', err %d\n",
>                          str, ret);
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index 47a7c3277540..0a1308d84e9e 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -842,7 +842,7 @@ static int check_parse_id(const char *id, struct pars=
e_events_error *error,
>                 *cur =3D '/';
>
>         ret =3D __parse_events(evlist, dup, /*pmu_filter=3D*/NULL, error,=
 fake_pmu,
> -                            /*warn_if_reordered=3D*/true);
> +                            /*warn_if_reordered=3D*/true, /*fake_tp=3D*/=
false);
>         free(dup);
>
>         evlist__delete(evlist);
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 55a300a0977b..3a719edafc7a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -298,7 +298,8 @@ struct evsel *evlist__add_aux_dummy(struct evlist *ev=
list, bool system_wide)
>  #ifdef HAVE_LIBTRACEEVENT
>  struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool syste=
m_wide)
>  {
> -       struct evsel *evsel =3D evsel__newtp_idx("sched", "sched_switch",=
 0);
> +       struct evsel *evsel =3D evsel__newtp_idx("sched", "sched_switch",=
 0,
> +                                              /*format=3D*/true);
>
>         if (IS_ERR(evsel))
>                 return evsel;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3536404e9447..4f818ab6b662 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -452,7 +452,7 @@ struct evsel *evsel__clone(struct evsel *orig)
>   * Returns pointer with encoded error via <linux/err.h> interface.
>   */
>  #ifdef HAVE_LIBTRACEEVENT
> -struct evsel *evsel__newtp_idx(const char *sys, const char *name, int id=
x)
> +struct evsel *evsel__newtp_idx(const char *sys, const char *name, int id=
x, bool format)
>  {
>         struct evsel *evsel =3D zalloc(perf_evsel__object.size);
>         int err =3D -ENOMEM;
> @@ -469,14 +469,20 @@ struct evsel *evsel__newtp_idx(const char *sys, con=
st char *name, int idx)
>                 if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
>                         goto out_free;
>
> -               evsel->tp_format =3D trace_event__tp_format(sys, name);
> -               if (IS_ERR(evsel->tp_format)) {
> -                       err =3D PTR_ERR(evsel->tp_format);
> -                       goto out_free;
> +               event_attr_init(&attr);
> +
> +               if (format) {
> +                       evsel->tp_format =3D trace_event__tp_format(sys, =
name);
> +                       if (IS_ERR(evsel->tp_format)) {
> +                               err =3D PTR_ERR(evsel->tp_format);
> +                               goto out_free;
> +                       }
> +                       attr.config =3D evsel->tp_format->id;
> +               } else {
> +                       attr.config =3D (__u64) -1;
>                 }
>
> -               event_attr_init(&attr);
> -               attr.config =3D evsel->tp_format->id;
> +
>                 attr.sample_period =3D 1;
>                 evsel__init(evsel, &attr, idx);
>         }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 517cff431de2..375a38e15cd9 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -234,14 +234,14 @@ void free_config_terms(struct list_head *config_ter=
ms);
>
>
>  #ifdef HAVE_LIBTRACEEVENT
> -struct evsel *evsel__newtp_idx(const char *sys, const char *name, int id=
x);
> +struct evsel *evsel__newtp_idx(const char *sys, const char *name, int id=
x, bool format);
>
>  /*
>   * Returns pointer with encoded error via <linux/err.h> interface.
>   */
>  static inline struct evsel *evsel__newtp(const char *sys, const char *na=
me)
>  {
> -       return evsel__newtp_idx(sys, name, 0);
> +       return evsel__newtp_idx(sys, name, 0, true);
>  }
>  #endif
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 79ef6095ab28..c21f05f8f255 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1502,7 +1502,8 @@ static int parse_ids(bool metric_no_merge, struct p=
erf_pmu *fake_pmu,
>         pr_debug("Parsing metric events '%s'\n", events.buf);
>         parse_events_error__init(&parse_error);
>         ret =3D __parse_events(parsed_evlist, events.buf, /*pmu_filter=3D=
*/NULL,
> -                            &parse_error, fake_pmu, /*warn_if_reordered=
=3D*/false);
> +                            &parse_error, fake_pmu, /*warn_if_reordered=
=3D*/false,
> +                            /*fake_tp=3D*/false);
>         if (ret) {
>                 parse_events_error__print(&parse_error, events.buf);
>                 goto err_out;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 6e8cba03f0ac..04508e07569d 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -526,7 +526,8 @@ static int add_tracepoint(struct parse_events_state *=
parse_state,
>                           struct parse_events_terms *head_config, void *l=
oc_)
>  {
>         YYLTYPE *loc =3D loc_;
> -       struct evsel *evsel =3D evsel__newtp_idx(sys_name, evt_name, pars=
e_state->idx++);
> +       struct evsel *evsel =3D evsel__newtp_idx(sys_name, evt_name, pars=
e_state->idx++,
> +                                              !parse_state->fake_tp);
>
>         if (IS_ERR(evsel)) {
>                 tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name,=
 loc->first_column);
> @@ -2126,7 +2127,7 @@ static int parse_events__sort_events_and_fix_groups=
(struct list_head *list)
>
>  int __parse_events(struct evlist *evlist, const char *str, const char *p=
mu_filter,
>                    struct parse_events_error *err, struct perf_pmu *fake_=
pmu,
> -                  bool warn_if_reordered)
> +                  bool warn_if_reordered, bool fake_tp)
>  {
>         struct parse_events_state parse_state =3D {
>                 .list     =3D LIST_HEAD_INIT(parse_state.list),
> @@ -2134,6 +2135,7 @@ int __parse_events(struct evlist *evlist, const cha=
r *str, const char *pmu_filte
>                 .error    =3D err,
>                 .stoken   =3D PE_START_EVENTS,
>                 .fake_pmu =3D fake_pmu,
> +               .fake_tp  =3D fake_tp,
>                 .pmu_filter =3D pmu_filter,
>                 .match_legacy_cache_terms =3D true,
>         };
> @@ -2343,7 +2345,8 @@ int parse_events_option(const struct option *opt, c=
onst char *str,
>
>         parse_events_error__init(&err);
>         ret =3D __parse_events(*args->evlistp, str, args->pmu_filter, &er=
r,
> -                            /*fake_pmu=3D*/NULL, /*warn_if_reordered=3D*=
/true);
> +                            /*fake_pmu=3D*/NULL, /*warn_if_reordered=3D*=
/true,
> +                            /*fake_tp=3D*/false);
>
>         if (ret) {
>                 parse_events_error__print(&err, str);
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index fd55a154ceff..b985a821546b 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -32,14 +32,14 @@ int parse_events_option_new_evlist(const struct optio=
n *opt, const char *str, in
>  __attribute__((nonnull(1, 2, 4)))
>  int __parse_events(struct evlist *evlist, const char *str, const char *p=
mu_filter,
>                    struct parse_events_error *error, struct perf_pmu *fak=
e_pmu,
> -                  bool warn_if_reordered);
> +                  bool warn_if_reordered, bool fake_tp);
>
>  __attribute__((nonnull(1, 2, 3)))
>  static inline int parse_events(struct evlist *evlist, const char *str,
>                                struct parse_events_error *err)
>  {
>         return __parse_events(evlist, str, /*pmu_filter=3D*/NULL, err, /*=
fake_pmu=3D*/NULL,
> -                             /*warn_if_reordered=3D*/true);
> +                             /*warn_if_reordered=3D*/true, /*fake_tp=3D*=
/false);
>  }
>
>  int parse_event(struct evlist *evlist, const char *str);
> @@ -152,6 +152,8 @@ struct parse_events_state {
>         int                        stoken;
>         /* Special fake PMU marker for testing. */
>         struct perf_pmu           *fake_pmu;
> +       /* Skip actual tracepoint processing for testing. */
> +       bool                       fake_tp;
>         /* If non-null, when wildcard matching only match the given PMU. =
*/
>         const char                *pmu_filter;
>         /* Should PE_LEGACY_NAME tokens be generated for config terms? */
>
> --
> 2.44.0
>

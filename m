Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4NaqWmWD"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFDE95
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 08:02:27 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bf09be81bso3872e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 08:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701705745; x=1702310545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ2P2DIXwhgKhhwYGyDwt80vx5OoeNcQyaY+/r8aj90=;
        b=4NaqWmWD8EDEweOrsP9IvOC5oRnT/RymNgEBkb5ubQq4RIgVh/i3lX5i5nHBZvt7lU
         Tsj44RpQJzSt/mwL/vF7EfHgL8/7qJxL5GSmtpMX3hdWTPPRALPU0z/duAL+KkNFeRj7
         LP9jJgXofMnzTpsFK16fB7UCOWUhHW+w1IGUkMIXwqNWio6eJmFI4tM9ibVJJ5z7fSwq
         X6lbvncRdIuraUxeU/DO6n638K9H2nVMQrUIQhVT8Y1mACdiJaqdrNmvdAlFmcUnetPF
         rnGDWrI7iDkottbqBtIVrARndWvnO8q25scj61+7Ix1Gfzg6MockqbXvUj3CVaa+rWwo
         LFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705745; x=1702310545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQ2P2DIXwhgKhhwYGyDwt80vx5OoeNcQyaY+/r8aj90=;
        b=XU2LM0TZzp3ao0gF0aYNE+jiWF5/h9T0kjScC4KOyXCJNt20ocqQFRR3E68LY/+R1J
         MVtBge/W23diLPN500JPg96+b2efckxkgMWCFdlCRu3LKfy3HSuojjl+S2axlx9CQ0wl
         J8KnFuDAsYBHbAWln1bTcNesbrcZ4o1rKUKrDt2HcDr4kYXiMSmwel8I45BG/XthhJ3g
         //g35h6S+JXDMpsJoZ6LS+Q8xpq7yxAsvRStVnaB73JEOZk45ode4BujY7GiukgR21kh
         OY6Rnc09oEPSsSNCqiX6EX0Y29UKy2auiQfNGibjvFQni3HG3IOlDrNVwli8WsmrtByc
         pKpw==
X-Gm-Message-State: AOJu0Yw1LUimIkkM0dsXwXX7Tegyc2H3OnKhqUAkonbz+7kiZn5ExXSj
	1AKm1CtKSqtuJqWHDPk3gGxZQN1tAWStVu/F7QstrQ==
X-Google-Smtp-Source: AGHT+IHj4uLu+WSvDvzSwDCLdQQVmw+l0i3kspCFy3QiZ95TI6mhSs5DLPr1Y974T+FrmmFSgDhQ7yinZbjI07pZc4Q=
X-Received: by 2002:a05:6512:b9f:b0:50b:cdd5:b54a with SMTP id
 b31-20020a0565120b9f00b0050bcdd5b54amr264842lfv.3.1701705745406; Mon, 04 Dec
 2023 08:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121000420.368075-1-irogers@google.com>
In-Reply-To: <20231121000420.368075-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 08:02:13 -0800
Message-ID: <CAP-5=fUTuBjF8HJZAvXHkM4FjL05gjDcevKUruEXJHYRUhXygA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] perf evsel: Fallback to task-clock when not system wide
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 4:04=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> When the cycles event isn't available evsel will fallback to the
> cpu-clock software event. task-clock is similar to cpu-clock but only
> runs when the process is running. Falling back to cpu-clock when not
> system wide leads to confusion, by falling back to task-clock it is
> hoped the confusion is less.
>
> Pass the target to determine if task-clock is more appropriate. Update
> a nearby comment and debug string for the change.
>
> ---
> v2. Use target__has_cpu as suggested by Namhyung.
> https://lpc.events/event/17/contributions/1556/
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c |  2 +-
>  tools/perf/builtin-stat.c   |  2 +-
>  tools/perf/builtin-top.c    |  2 +-
>  tools/perf/util/evsel.c     | 18 ++++++++++--------
>  tools/perf/util/evsel.h     |  3 ++-
>  5 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8ec818568662..d8bb59511fdd 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1350,7 +1350,7 @@ static int record__open(struct record *rec)
>         evlist__for_each_entry(evlist, pos) {
>  try_again:
>                 if (evsel__open(pos, pos->core.cpus, pos->core.threads) <=
 0) {
> -                       if (evsel__fallback(pos, errno, msg, sizeof(msg))=
) {
> +                       if (evsel__fallback(pos, &opts->target, errno, ms=
g, sizeof(msg))) {
>                                 if (verbose > 0)
>                                         ui__warning("%s\n", msg);
>                                 goto try_again;
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a3af805a1d57..d8e5d6f7a87a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -653,7 +653,7 @@ static enum counter_recovery stat_handle_error(struct=
 evsel *counter)
>                 if ((evsel__leader(counter) !=3D counter) ||
>                     !(counter->core.leader->nr_members > 1))
>                         return COUNTER_SKIP;
> -       } else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
> +       } else if (evsel__fallback(counter, &target, errno, msg, sizeof(m=
sg))) {
>                 if (verbose > 0)
>                         ui__warning("%s\n", msg);
>                 return COUNTER_RETRY;
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..1e42bd1c7d5a 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1044,7 +1044,7 @@ static int perf_top__start_counters(struct perf_top=
 *top)
>                             perf_top_overwrite_fallback(top, counter))
>                                 goto try_again;
>
> -                       if (evsel__fallback(counter, errno, msg, sizeof(m=
sg))) {
> +                       if (evsel__fallback(counter, &opts->target, errno=
, msg, sizeof(msg))) {
>                                 if (verbose > 0)
>                                         ui__warning("%s\n", msg);
>                                 goto try_again;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a5da74e3a517..532f34d9fcb5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2853,7 +2853,8 @@ u64 evsel__intval_common(struct evsel *evsel, struc=
t perf_sample *sample, const
>
>  #endif
>
> -bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msg=
size)
> +bool evsel__fallback(struct evsel *evsel, struct target *target, int err=
,
> +                    char *msg, size_t msgsize)
>  {
>         int paranoid;
>
> @@ -2861,18 +2862,19 @@ bool evsel__fallback(struct evsel *evsel, int err=
, char *msg, size_t msgsize)
>             evsel->core.attr.type   =3D=3D PERF_TYPE_HARDWARE &&
>             evsel->core.attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES) {
>                 /*
> -                * If it's cycles then fall back to hrtimer based
> -                * cpu-clock-tick sw counter, which is always available e=
ven if
> -                * no PMU support.
> +                * If it's cycles then fall back to hrtimer based cpu-clo=
ck sw
> +                * counter, which is always available even if no PMU supp=
ort.
>                  *
>                  * PPC returns ENXIO until 2.6.37 (behavior changed with =
commit
>                  * b0a873e).
>                  */
> -               scnprintf(msg, msgsize, "%s",
> -"The cycles event is not supported, trying to fall back to cpu-clock-tic=
ks");
> -
>                 evsel->core.attr.type   =3D PERF_TYPE_SOFTWARE;
> -               evsel->core.attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
> +               evsel->core.attr.config =3D target__has_cpu(target)
> +                       ? PERF_COUNT_SW_CPU_CLOCK
> +                       : PERF_COUNT_SW_TASK_CLOCK;
> +               scnprintf(msg, msgsize,
> +                       "The cycles event is not supported, trying to fal=
l back to %s",
> +                       target__has_cpu(target) ? "cpu-clock" : "task-clo=
ck");
>
>                 zfree(&evsel->name);
>                 return true;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index f19ac9f027ef..efbb6e848287 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -460,7 +460,8 @@ static inline bool evsel__is_clock(const struct evsel=
 *evsel)
>                evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
>  }
>
> -bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msg=
size);
> +bool evsel__fallback(struct evsel *evsel, struct target *target, int err=
,
> +                    char *msg, size_t msgsize);
>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                          int err, char *msg, size_t size);
>
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>

Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF52BD5BD
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770162104; cv=pass; b=hv7XOS2avO52FfKF08tk6JgQrYwsOw8F3uDe8pdqTIH/NWydUmKTsEDMdf7h5Ys9DTsv32stDcFIkIzxyQ1aoUZHBWPRO8y/Z5WUiJs4xKhVC8eIQf0J5+v6Ty0fQWU6+PYawogTIXsYj+gNcq4NG63omf2MzexzeZXaUdhe/gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770162104; c=relaxed/simple;
	bh=4Ssbbaz5aMGQVIR5H5Jphl7XeyJszSujm4nLgbJrtak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhHAm1zVXQt2Yr0NJGKKmOrLCo5EMWgCkIjxhU9ga4UEO1r6g6oz34p0s4VtlYIE9n2xB3lw6EJmgFJYfA5DKPERZFjCCdqR04QaTM8Y9NCm3u2UvEZFO9Yu5zeg8hsRUtfc8ckgjxUUy0rV/UBZIiPXdX+J6Vk4GqePiODdAn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3y1OoOC; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3y1OoOC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a1462573caso16635ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 15:41:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770162102; cv=none;
        d=google.com; s=arc-20240605;
        b=Ei2bhHhhtfOiZLX3AOXbBwSBS61kreND6bQaDoxHPywl7iGEaF3CSE8pCfkvs29/rY
         Lde0YQ6hyDBZQzLhA/pf4av8Bee+2iqCn0hfBdSClv3rQpp9Ei9nwfPalQgiGxNv7z2A
         1DDHSQwNnvCeMw3QfZ+aZDAi5GRl35BUcTp20ImNFcGyBtJzmtC0hzrnjlaQeqK0EMHk
         agddEPQXq5caeb3YW+cM7VqhN14ijm7t/7cOW2iblwc1RLAnVseaynBhaF3Z/zHoflxV
         sURi/KlrDemiFx5Fs7pTKZAUYcpcSq928WglNwDOFL6z7clVnrA406iHdciW7GlxtsOV
         uUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=res3ZlGkReTCu7lORiC0GVhbm/YqC5e2YPlTUao+YH8=;
        fh=kTc1l1F7MLiv4B0MKGcWfG9H62O23YuJIjJkPp53Gvk=;
        b=J0wXxNMXBrIjBgkm2el0R+8zcSrfv/ZyRUWkhSJAOlU11HVUlvGvwq8taiT7Ccckhg
         72KxJerVBUq02oDf6Wj36eNNO3N4G+eTTGBZh3zLWFA397ryUfRcXoTzaCdHooohUcvj
         ngsy3GBnt1hTiABrudNSvf1fCSUULesR0nkEIPeOwMXTdhqdZbTCliljbV7/jvMh/KqR
         aZzPEuG5YKWiHVphMeBpzcYKObvV3MqxJ0EM8lelwuI4vzlvkbBWsma9LWw89HsKH3r/
         nJFT2BRMsIUJ4tjSSs7RQ27SxwXdOi6pdYUzWCCY9CMMIpQjXbuYoDfNPbrAG0ZomdsP
         eyJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770162102; x=1770766902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=res3ZlGkReTCu7lORiC0GVhbm/YqC5e2YPlTUao+YH8=;
        b=Y3y1OoOCTgDnyR2te4E5UZVEcPnFDH958nR3hgfljG/YybBKSQyCPjDAdn1EUC8vIj
         kFz+1hF9tUu0ANju+Gq/D8yUil4Vg7/6ZI4ymKZjcru7fon5Z4nnQxOyYP2YVcJh5UBB
         DEqTMlcCFnGi2UQy46hjkDO1z0VRLVj9BCMf7tfUBWTA4uv+gC4yxSeA6zj++G/RThLH
         gSLDD01APW5mxu1d3hqn7qWOne1hHCdUIxvCYbNcvHhdRTAryB/I6AABtFvdVKNc/FaK
         VgwumXSEYIj5a/ZpHtH4yjd04f3bVk+5x7mlnsilJdm3p7IC4hIal26Gna0yz7n4CWx4
         bGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770162102; x=1770766902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=res3ZlGkReTCu7lORiC0GVhbm/YqC5e2YPlTUao+YH8=;
        b=vBX4z1ytaImSZovdDptgCj+o1uExRUtZSvCgvSz55D09WqmhV84MqQOluHdLXjCoVP
         Ier4LUfnB7Ftq+O+J+VxPerNlUQMsMBwnE0rHzWx7XxFu6StmHPkSuFABX14BFb+Pp+L
         eBoTWnkFWzcNUk16DJ0CAyfXhD4XMaB2cNqCTpTVV0FMrXnLQlDWX/fbu1q/hE1aGUQK
         PEz7UOnVTswQIQ4I43jFzWR9CeRLkTf0iIpq7NEympE7Qe/v5yna31e0VWA12Hb7ckDr
         oU2KGO1CLM8LL2PiSigGuWrvwR6apyEJPReY1pS9P5DTYySUOlxvYdxO8VTlQSRHeBX5
         y8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCV1HRN+DerhRfiBL8JGz3J/KFRjHvbth9aM5oaOUOV9MpTpuR6gQy82IqLUFxgq1gMCIb2kGnCwwmbGuueb855G@vger.kernel.org
X-Gm-Message-State: AOJu0YygJxitR7FunTwpZtvpnVr45AKHoMp41sKR5MhKFGznuDhdJzTu
	EAReqgdB5av0kGxgZ1+PfBXzZcgf6KLqIVUn8pNwFTUBgvzcPUPCgK+A6nlgvqON0T+p4wCehB1
	Y1/MtvladIthdN8DdJdL6NIFJxY0NcKrXEynJYPyR
X-Gm-Gg: AZuq6aKSuTRo9J0lKn5DUqPtENgG5tSjnAxsErZuJn67t5rYk/xWa5OMTN9H/kkVtby
	ixe4OaqkDhbYQHNxNgbh3wxQQ/968NH8jqMmjrlRTdVYPvxd5L+ljVO0ckkEcYXF6qqmbTmfSRZ
	Ik+2uAZ84kCr1yZIjzmHk7MduY7x6HvWqH/Gnbyu6zimHG4fxfcibxTHN1pSFE8vpIRaQUNkGiK
	9EXMuvEhvAH65oxShHMfhnWFcU3PhLoBTBFXEdIpHkXY39rO/pwhcl+8E/EjiHAhxkzQDgDLxwP
	KzVnmH2GHQfOKPw0PF2vMRzZtg==
X-Received: by 2002:a17:902:e543:b0:29f:f71:a3b9 with SMTP id
 d9443c01a7336-2a9357d109fmr553635ad.5.1770162101566; Tue, 03 Feb 2026
 15:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203230733.1474840-1-ctshao@google.com>
In-Reply-To: <20260203230733.1474840-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 15:41:30 -0800
X-Gm-Features: AZwV_QjPYmmjss4meWy-Mb9WxCJWpCl13J1abHe0TEACvOrWVkTeGhQPsPajIyw
Message-ID: <CAP-5=fXL0Dw5v4VoNJhQ78adCHhvPQLzyjsophXx-j-FXGwuWg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Ensure metrics are displayed even with failed events
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, kan.liang@linux.intel.com, yang.lee@linux.alibaba.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:07=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> wr=
ote:
>
> Currently, `perf stat` skips or hides metrics when the underlying
> hardware events cannot be counted (e.g., due to insufficient permissions
> or unsupported events). In `--metric-only` mode, this often results in
> missing columns or blank spaces, making the output difficult to parse.
>
> Modify the logic to ensure metrics are consistently displayed by
> propagating NAN (Not a Number) through the expression evaluator.
> Specifically:
>
> 1. Update `prepare_metric()` in stat-shadow.c to treat uncounted events
>    (where `run =3D=3D 0`) as NAN. This leverages the existing math in exp=
r.y
>    to propagate NAN through metric expressions.
> 2. Remove the early return in the display logic's `printout()` function
>    that was previously skipping metrics in `--metric-only` mode for
>    failed events.
> 3. Simplify `perf_stat__skip_metric_event()` to no longer depend on
>    event runtime.
>
> Tested:
> 1. `perf all metrics test` did not crash while paranoid is 2.
> 2. Multiple combinations with `CPUs_utilized` while paranoid is 2.
>
>   $ ./perf stat -M CPUs_utilized -a -- sleep 1
>
>    Performance counter stats for 'system wide':
>
>      <not supported> msec cpu-clock:u                      #      nan CPU=
s  CPUs_utilized
>        1,006,356,120      duration_time
>
>          1.004375550 seconds time elapsed
>
>   $ ./perf stat -M CPUs_utilized -a -j -- sleep 1
>   {"counter-value" : "<not supported>", "unit" : "msec", "event" : "cpu-c=
lock:u", "event-runtime" : 0, "pcnt-running" : 100.00, "metric-value" : "na=
n", "metric-unit" : "CPUs  CPUs_utilized"}
>   {"counter-value" : "1006642462.000000", "unit" : "", "event" : "duratio=
n_time", "event-runtime" : 1, "pcnt-running" : 100.00}
>
>   $ ./perf stat -M CPUs_utilized -a --metric-only -- sleep 1
>
>    Performance counter stats for 'system wide':
>
>     CPUs  CPUs_utilized
>                       nan
>
>          1.004424652 seconds time elapsed
>
>   $ ./perf stat -M CPUs_utilized -a --metric-only -j -- sleep 1
>   {"CPUs  CPUs_utilized" : "none"}
>
> Signed-off-by: ctshao@google.com

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/stat-display.c | 59 +++++++++++++++-------------------
>  tools/perf/util/stat-shadow.c  |  8 ++---
>  tools/perf/util/stat.h         |  2 +-
>  3 files changed, 29 insertions(+), 40 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 2ce0602974a1..dc2b66855f6c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -820,12 +820,6 @@ static void printout(struct perf_stat_config *config=
, struct outstate *os,
>         }
>
>         if (run =3D=3D 0 || ena =3D=3D 0 || counter->counts->scaled =3D=
=3D -1) {
> -               if (config->metric_only) {
> -                       pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=
=3D*/NULL,
> -                          /*unit=3D*/NULL, /*val=3D*/0);
> -                       return;
> -               }
> -
>                 ok =3D false;
>
>                 if (counter->supported) {
> @@ -848,33 +842,32 @@ static void printout(struct perf_stat_config *confi=
g, struct outstate *os,
>                 print_running(config, os, run, ena, /*before_metric=3D*/t=
rue);
>         }
>
> -       if (ok) {
> -               if (!config->metric_only && counter->default_metricgroup =
&& !counter->default_show_events) {
> -                       void *from =3D NULL;
> -
> -                       aggr_printout(config, os, os->evsel, os->id, os->=
aggr_nr);
> -                       /* Print out all the metricgroup with the same me=
tric event. */
> -                       do {
> -                               int num =3D 0;
> -
> -                               /* Print out the new line for the next ne=
w metricgroup. */
> -                               if (from) {
> -                                       if (config->json_output)
> -                                               new_line_json(config, (vo=
id *)os);
> -                                       else
> -                                               __new_line_std_csv(config=
, os);
> -                               }
> -
> -                               print_noise(config, os, counter, noise, /=
*before_metric=3D*/true);
> -                               print_running(config, os, run, ena, /*bef=
ore_metric=3D*/true);
> -                               from =3D perf_stat__print_shadow_stats_me=
tricgroup(config, counter, aggr_idx,
> -                                                                        =
        &num, from, &out);
> -                       } while (from !=3D NULL);
> -               } else {
> -                       perf_stat__print_shadow_stats(config, counter, ag=
gr_idx, &out);
> -               }
> +       if (!config->metric_only && counter->default_metricgroup &&
> +           !counter->default_show_events) {
> +               void *from =3D NULL;
> +
> +               aggr_printout(config, os, os->evsel, os->id, os->aggr_nr)=
;
> +               /* Print out all the metricgroup with the same metric eve=
nt. */
> +               do {
> +                       int num =3D 0;
> +
> +                       /* Print out the new line for the next new metric=
group. */
> +                       if (from) {
> +                               if (config->json_output)
> +                                       new_line_json(config, (void *)os)=
;
> +                               else
> +                                       __new_line_std_csv(config, os);
> +                       }
> +
> +                       print_noise(config, os, counter, noise,
> +                                   /*before_metric=3D*/true);
> +                       print_running(config, os, run, ena,
> +                                     /*before_metric=3D*/true);
> +                       from =3D perf_stat__print_shadow_stats_metricgrou=
p(
> +                               config, counter, aggr_idx, &num, from, &o=
ut);
> +               } while (from !=3D NULL);
>         } else {
> -               pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=3D*/NUL=
L, /*unit=3D*/NULL, /*val=3D*/0);
> +               perf_stat__print_shadow_stats(config, counter, aggr_idx, =
&out);
>         }
>
>         if (!config->metric_only) {
> @@ -987,7 +980,7 @@ static void print_counter_aggrdata(struct perf_stat_c=
onfig *config,
>         ena =3D aggr->counts.ena;
>         run =3D aggr->counts.run;
>
> -       if (perf_stat__skip_metric_event(counter, ena, run))
> +       if (perf_stat__skip_metric_event(counter))
>                 return;
>
>         if (val =3D=3D 0 && should_skip_zero_counter(config, counter, &id=
))
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 9c83f7d96caa..5d8d09e0e6ae 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -83,7 +83,7 @@ static int prepare_metric(struct perf_stat_config *conf=
ig,
>                 }
>                 /* Time events are always on CPU0, the first aggregation =
index. */
>                 aggr =3D &ps->aggr[is_tool_time ? tool_aggr_idx : aggr_id=
x];
> -               if (!aggr || !metric_events[i]->supported) {
> +               if (!aggr || !metric_events[i]->supported || aggr->counts=
.run =3D=3D 0) {

This will conflict with:
https://lore.kernel.org/linux-perf-users/20260203225129.4077140-3-irogers@g=
oogle.com/
but the same addition just needs adding in this place too.

Thanks,
Ian

>                         /*
>                          * Not supported events will have a count of 0, w=
hich
>                          * can be confusing in a metric. Explicitly set t=
he
> @@ -335,14 +335,10 @@ void perf_stat__print_shadow_stats(struct perf_stat=
_config *config,
>   * perf_stat__skip_metric_event - Skip the evsel in the Default metricgr=
oup,
>   *                               if it's not running or not the metric e=
vent.
>   */
> -bool perf_stat__skip_metric_event(struct evsel *evsel,
> -                                 u64 ena, u64 run)
> +bool perf_stat__skip_metric_event(struct evsel *evsel)
>  {
>         if (!evsel->default_metricgroup)
>                 return false;
>
> -       if (!ena || !run)
> -               return true;
> -
>         return !metricgroup__lookup(&evsel->evlist->metric_events, evsel,=
 false);
>  }
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index f986911c9296..4bced233d2fc 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -163,7 +163,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_c=
onfig *config,
>                                    struct evsel *evsel,
>                                    int aggr_idx,
>                                    struct perf_stat_output_ctx *out);
> -bool perf_stat__skip_metric_event(struct evsel *evsel, u64 ena, u64 run)=
;
> +bool perf_stat__skip_metric_event(struct evsel *evsel);
>  void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config =
*config,
>                                                 struct evsel *evsel,
>                                                 int aggr_idx,
> --
> 2.53.0.rc2.204.g2597b5adb4-goog
>

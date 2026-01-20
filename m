Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232337F8A2
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942545; cv=pass; b=abbL1P2B0vSR0yJV6yGdNq51n5rVTLRaTiaLlAphN6GotiicCjJSKazFMJHLS7o7d7qwslN2EPwAVabJuH6wdKdMst2yYfOCqe5ZmjUWnUxj/XIhSY3phn8HTDROxwb2LCeLLmiu2qoxVzeFR9Kq3O5JXV6EX+uooMUR12PID90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942545; c=relaxed/simple;
	bh=jEZ+E2B6pSH/KbtFI98+cpz6NGybmjK7kqRnHK7nnRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO9vYYI3xzOAsSaVgS6vTUfINNBVpnHBg8zROxiBu3g3fadEeELJYvFjhYxx52z7OoF8ECGfhKapL/CIXNkPaBbdIvYWgr5jiYhcOtlFGtAgTdIjFlFdudRIscFdSOz9VeURaoyyLfyR2lhDuG779690CDCMpIa+AYZ9sZ3kij4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YprMw2Ib; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YprMw2Ib"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a35ae38bdfso4565ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 12:55:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768942542; cv=none;
        d=google.com; s=arc-20240605;
        b=I/DEKXBMWUlvHdR6g2JadrN9l3kg85GpZlg2xVGCVTzx2RynfxWxFgkgNjGsRaBlUs
         ULZk9ESIk7jtkOjzUMIOMPQI5J/0yJDp06j/t0vCMBjBQFjchvqN+W82zKVrqWWaZgXk
         YIvXE660mtwAbTHYVicCr6MugXZooYLWxoNyEHa0lmu5MoCei7FKImwMSDyN4gdkmsgA
         jps3PvE4fWcZpeRuJQi8tnthEdIlFMqfT9UEodAvPSQwgLgBqFrAJVPJWNYdfS9mUeDR
         2VNbGXDe22gzs+vRVbcv8JIZrrd2TNDF8gORH4zj84cutlC3sfC4wfvoimm4FEoFEbEW
         aRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b0hF6zoQGorvtwAerK7wBF5E02a0KAKGBQWJG2DM+1o=;
        fh=dOc1ere2dwycmjLWL4dv1p51Q40wytOSpiPXOdOmwig=;
        b=Jv0x3VZLyQAYJvTLNIn0jqpr+3D4pyI+mXnCGWiUFmtD991Idc3ZpCxFlkFbftkVV1
         2c0IRr40aK0zPQ67/Cjlg6WtAXOQs8Fy4qE0h64lNId4TOMOwHXx94OGMJOeFhL8LCVT
         l9x8srLLdoiQ4YbHa+O4Pp/OuUZ4VmuwVVRyrIk6XNreMi335SR8AEzZ1m2qxYzOYLYQ
         Zz7x3KFXPzYnYt9q6UEKPxx97I7eizZ+OXeiYzjXb4WN5KEuX+GNnv8BCIJOt616zh4O
         +j/KfjsZb4mwbrmksfFb1HY/XDfYqCybRuFGGcRxi1nxDOI0yKvbd2QPge0JLuzgmA4L
         zyaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768942542; x=1769547342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0hF6zoQGorvtwAerK7wBF5E02a0KAKGBQWJG2DM+1o=;
        b=YprMw2IbdG9YZV56BacJXLJDB8SLj40gEd6h/8TNgZxTX+pHtvbDVYCA09d/b/e+pG
         v12drRjS4FGBj9n3isQaUg84vDHGizfw8BghJJ2pWGUTu/09/8WUH/GF23hYtVFz+AOp
         7wc/tVrZ6bTgloCFFJVzHgck90ljzUKpYSftlis2se6OeLhjCYXp3+ZQdaaWEIhi4u/I
         ATsO++Ml8wFr3tduD9AMFqdOVNlvuVFIIR0oFN+wyrZTNA1V4rOobzSp2RueAq6/0Wti
         RpZuB7vW6bID03cIL4w1mfEceeVQsrp7JDAhhsP85XRzJfSfKbkZZQX9+JvHkFS60VI5
         qdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768942542; x=1769547342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b0hF6zoQGorvtwAerK7wBF5E02a0KAKGBQWJG2DM+1o=;
        b=MxI88xi9L1Z8ym+FAnRwYeYeUStW6+GSjF3FoknBif4QijmZD+GYXdk6XVZpQ+A1hY
         IF5GljzyNNy1GS4x8zT1/VDsWvC5iFVIsLqWWU0MoBF/I8gdNCuSVhqxa0IHmNBRH5mB
         qZH4Y9BttbC2J89YLpEIwbnOFLIrhBz3Q+/IMxreG0H92GKJY82FmhGnBAXNDGXcDRP1
         UQODMk1PR37oXT0Op3ghAqqt/E3xWUKYxa2ZYa3ZdW/sTLw8VsUVy78aB3Hq6w3uxs7o
         ayYZeENWFBD6pyifgHS8XS+iL1iv8VLUIhVPZk+vUXNr0ZBDV8+S6E3C+cg6N5PHzy3h
         jxbw==
X-Forwarded-Encrypted: i=1; AJvYcCX45H9pVB6KOcTRd1+zMwNK6ffrB36q20EfrZqRvsfOmC0yuPgDzt5cW9pUrcAzMeOyGluOOgHUeMckMInzGZbR@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpqIKdRlq3LxQxNww+qn28jK5ZXdAjq+oFZe6xwNQlBKeagNN
	bkzx6b5aXAxZHbc2H/FhKY2Kn1uTNo6TCb4lGgQXKMsPhn59Aasdlp/9XnZZKBFn+K05gKl4scJ
	hKqN6yHx2/CCuMfYGEZRzFmSD+cTbKO6u7lb/XX70
X-Gm-Gg: AZuq6aK+S14ptuzRV7YJnGiPlPjQAVfYVjz3Wj2rjic4ns9VcX+qFLQ3AsA4VLQo+Bx
	Vo0vJd4eUOXHcZHAme5Pkel0d8CdFq9s9Z/6RFVkjDgZ6AE+/iSXc7YodPZvjSkTYj9g7+6lRf4
	N4VbHf/U3MKzHMayvFoujgZTCAXxM5c+8QGCsYkKYwCm3Q0Oa2cyWvYQwOfjO8rauWCVTyjyeDp
	MaanswaKxsMziaqS3pCRIM1ox7rcg9AckskDuIXLOACMQxrqa+PM7RZSS2om9Jy1Uakjp9E3DGS
	pC8lfGVEHcNAIGIYQWLVzf0kiA==
X-Received: by 2002:a17:903:acd:b0:29e:27f4:bac0 with SMTP id
 d9443c01a7336-2a79a61d716mr697395ad.16.1768942541969; Tue, 20 Jan 2026
 12:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120095058.2778834-1-xiaqinxin@huawei.com>
In-Reply-To: <20260120095058.2778834-1-xiaqinxin@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 12:55:30 -0800
X-Gm-Features: AZwV_Qgqi7_sZAxacE280ws_r8Qsfv5A3VbB-UlgLm8xZ8JIAv7iTi8PWOVx-yQ
Message-ID: <CAP-5=fVHMeWP3Ct_uOwYw4XKNdK7-eR=tbbUOFHwTdCVwBCZVg@mail.gmail.com>
Subject: Re: [RFC PATCH] perf: Add --uncorepmu option for filtering uncore PMUs
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, wangyushan12@huawei.com, hejunhao3@h-partners.com, 
	jonathan.cameron@huawei.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 1:51=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> This patch adds a new --uncorepmu option to perf-stat command to allow
> filtering events on specific uncore PMUs. This is useful when there are
> multiple uncore PMUs with the same type (e.g. hisi_sicl2_cpa0 and
> hisi_sicl0_cpa0).
>
> eg:
> [root@localhost tmp]# ./perf stat -M cpa_p0_avg_bw
>  Performance counter stats for 'system wide':
>
>     19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p=
0_avg_bw
>                  0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
>                  0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
>     19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p=
0_avg_bw
>                  0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
>                  0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
>     19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p=
0_avg_bw
>         75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
>         18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
>     19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p=
0_avg_bw
>                  0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
>                  0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
>                  0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/
>
>       19.417734480 seconds time elapsed
>
> [root@localhost tmp]# ./perf stat --uncorepmu hisi_sicl2_cpa0 -M cpa_p0_a=
vg_bw
>  Performance counter stats for 'system wide':
>
>      6,234,093,559      cpa_cycles                       #     0.60 cpa_p=
0_avg_bw
>         50,548,465      cpa_p0_wr_dat
>          7,552,182      cpa_p0_rd_dat_64b
>                  0      cpa_p0_rd_dat_32b
>
>        6.234139320 seconds time elapsed

So normally for this case the -A/--no-merge will give you a per-PMU
breakdown. It isn't restricted to a single PMU like the output here,
but we similarly don't have options to restrict per-socket, per-dir,
per-cluster and per-core. There is an option with --per-cache but that
looks like a way to avoid having many --per-cache options rather than
taking a value for a particular cache to only dump.

I did deliberate make the --cputype code generic so it could be used
in ways like this, but it'd be nice to glob match the names for
consistency with event parsing:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c#n2647
I needed to have --cputype as Intel's early hybrid patches had added
it before I cleaned things up to be more PMU oriented.

So I can see the purpose of this patch in being low overhead compared
to -A, I'm just not sure whether this is a PMU or an aggregation
option. I also think the term "uncore" is kind of confusing and so
have tried to keep it away from command line options. Why isn't is it
just a pmu filter?

Thanks,
Ian

> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  tools/perf/Documentation/perf-stat.txt |  4 ++++
>  tools/perf/builtin-stat.c              | 26 ++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
>  3 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Document=
ation/perf-stat.txt
> index 1a766d4a2233..9c0952b43a57 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -573,6 +573,10 @@ $ perf config stat.no-csv-summary=3Dtrue
>  Only enable events on applying cpu with this type for hybrid platform
>  (e.g. core or atom)"
>
> +--uncorepmu::
> +Only enable events on applying uncore pmu with specified for multiple
> +uncore pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
> +
>  EXAMPLES
>  --------
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ab40d85fb125..3f34bfc79179 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1235,6 +1235,28 @@ static int parse_cputype(const struct option *opt,
>         return 0;
>  }
>
> +static int parse_uncorepmu(const struct option *opt,
> +                          const char *str,
> +                          int unset __maybe_unused)
> +{
> +       const struct perf_pmu *pmu;
> +       struct evlist *evlist =3D *(struct evlist **)opt->value;
> +
> +       if (!list_empty(&evlist->core.entries)) {
> +               fprintf(stderr, "Must define uncorepmu before events/metr=
ics\n");
> +               return -1;
> +       }
> +
> +       pmu =3D perf_pmus__pmu_for_pmu_filter(str);
> +       if (!pmu || pmu->is_core) {
> +               fprintf(stderr, "--uncorepmu %s is not supported!\n", str=
);
> +               return -1;
> +       }
> +       parse_events_option_args.pmu_filter =3D pmu->name;
> +
> +       return 0;
> +}
> +
>  static int parse_cache_level(const struct option *opt,
>                              const char *str,
>                              int unset __maybe_unused)
> @@ -2579,6 +2601,10 @@ int cmd_stat(int argc, const char **argv)
>                         "Only enable events on applying cpu with this typ=
e "
>                         "for hybrid platform (e.g. core or atom)",
>                         parse_cputype),
> +               OPT_CALLBACK(0, "uncorepmu", &evsel_list, "uncore pmu",
> +                       "Only enable events on applying uncore pmu with s=
pecified "
> +                       "for multiple uncore pmus with same type(e.g. his=
i_sicl2_cpa0 or hisi_sicl0_cpa0)",
> +                       parse_uncorepmu),
>  #ifdef HAVE_LIBPFM
>                 OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>                         "libpfm4 event selector. use 'perf list' to list =
available events",
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 25c75fdbfc52..59ef71df20bd 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struct p=
mu_metric *pm, const char *p
>                                       const char *metric_or_groups)
>  {
>         const char *pm_pmu =3D pm->pmu ?: "cpu";
> +       struct perf_pmu *perf_pmu =3D NULL;
>
> -       if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
> +       if (pm->pmu)
> +               perf_pmu =3D perf_pmus__find(pm->pmu);
> +
> +       if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
> +          (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
>                 return false;
>
>         return match_metric_or_groups(pm->metric_group, metric_or_groups)=
 ||
> @@ -1260,7 +1265,8 @@ static int build_combined_expr_ctx(const struct lis=
t_head *metric_list,
>  static int parse_ids(bool metric_no_merge, bool fake_pmu,
>                      struct expr_parse_ctx *ids, const char *modifier,
>                      bool group_events, const bool tool_events[TOOL_PMU__=
EVENT_MAX],
> -                    struct evlist **out_evlist)
> +                    struct evlist **out_evlist,
> +                    const char *filter_pmu)
>  {
>         struct parse_events_error parse_error;
>         struct evlist *parsed_evlist;
> @@ -1314,7 +1320,7 @@ static int parse_ids(bool metric_no_merge, bool fak=
e_pmu,
>         }
>         pr_debug("Parsing metric events '%s'\n", events.buf);
>         parse_events_error__init(&parse_error);
> -       ret =3D __parse_events(parsed_evlist, events.buf, /*pmu_filter=3D=
*/NULL,
> +       ret =3D __parse_events(parsed_evlist, events.buf, filter_pmu,
>                              &parse_error, fake_pmu, /*warn_if_reordered=
=3D*/false,
>                              /*fake_tp=3D*/false);
>         if (ret) {
> @@ -1417,7 +1423,8 @@ static int parse_groups(struct evlist *perf_evlist,
>                                         /*modifier=3D*/NULL,
>                                         /*group_events=3D*/false,
>                                         tool_events,
> -                                       &combined_evlist);
> +                                       &combined_evlist,
> +                                       (pmu && strcmp(pmu, "all") =3D=3D=
 0) ? NULL : pmu);
>                 }
>                 if (combined)
>                         expr__ctx_free(combined);
> @@ -1472,7 +1479,8 @@ static int parse_groups(struct evlist *perf_evlist,
>                 }
>                 if (!metric_evlist) {
>                         ret =3D parse_ids(metric_no_merge, fake_pmu, m->p=
ctx, m->modifier,
> -                                       m->group_events, tool_events, &m-=
>evlist);
> +                                       m->group_events, tool_events, &m-=
>evlist,
> +                                       (pmu && strcmp(pmu, "all") =3D=3D=
 0) ? NULL : pmu);
>                         if (ret)
>                                 goto out;
>
> --
> 2.33.0
>

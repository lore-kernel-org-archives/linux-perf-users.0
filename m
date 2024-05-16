Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2264B
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878042; cv=none; b=SGszLdjSmsvb0/V9xh7UWVX+o2OISTiyDnpcD3YFTA5qAToVZZ+IuBpUoGGTKVQ5I7dSui1R82Vs+WtIaZYJO10PvyyeZW5XzWYJ4WBvsdNYX9QEv/X/Xr1U5JXqlCL346yQ/xEuqrOlKsi67t1wa4ZjQ2m7oHR375yrCQsVqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878042; c=relaxed/simple;
	bh=S48554Y+x9qw+f50PylKDzjC0r83xfnteAkQWTUhdpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpMS2hAFWztpLvdzHvfqS3nhZajOQuUXqlJu46gq3a2cPHjeB31p4hkQxq7T2jCZD5fv2PgDjps5Dgp7mRbuvAN4fFkgf+KBTE8xbASYUhVXuidrar646RJ18XIWwyxTz7JX1ZTrOcCl9fQt7LNHjSqQOFJB7Mf/TDwsF1XDhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2eidObp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2eidObp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec76185c0fso2145ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715878040; x=1716482840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFEJ/AR8pzNNotMkKubv8JaMk08b8Pi6V4aOhZOXlNM=;
        b=t2eidObpIbvji6ZTVepDg4Fm9nvAwxDCGE2p76QTOMlHPfHFqYiCNGyO+Mr4uID75q
         uJmbfTZHwrvemN9HxcQqjHynZc8h7+PFeHWv0vIJgNybsmbLz+arei4PINWVaNMkH3go
         Gq+ZAvQT5JbhBYWrEtPXhuQxVrfZo9i90jcMm0u6uMA+Fd+ZQLDknfkbsfMdayAueHea
         2fiv1H2fvyojLMQ110zdSreQFBzzSw49gOjshS14YG6BtNJ4Zdx4fgBSYEF4c7njbPtv
         rXUfoul9xpzJkMyePnlWTgtiyB0FulVXCKYPjqwwDBzI+xX1ELYYQzENmlRDe9L8SB40
         eBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715878040; x=1716482840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFEJ/AR8pzNNotMkKubv8JaMk08b8Pi6V4aOhZOXlNM=;
        b=Az2R6ONFeo1IeOLcPr7nK9SygOTmrqTvyAdwg+FP1XESfN7Z2fHZaR11vtriQMJMrF
         Ft6yxHAiYjqtW1lscEuBDkr+6JY2zVnjZemaQRVAPj8DVWc8WCP1xrYcpaZmrjgDm7Ug
         jdIytGKr08OKwdiJh2Yk6+bPUL3+WX/IfvwHXVu7VC4w5Wz056Z7rj/WVxgtR9Qm7na0
         Dp+c8ROZ9kBgyY2qizST7MkOMPYAMj2FYaTrqEtlWfoISwhmQR/+HSZyPnbfZhcULmLh
         uAsN9Sb+ca8UUom/RM/fYAca6saMhv0uP/lcSeMXIkwBhBZRnBMRgAd1hEUTs4s791vt
         lAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY+pCftZvWSvAWPR+pgyrNwyIgNaZ0jQ4JqM6/wM/cP1wfCNmDf5eqoezOCZSggSyjMEZXtxjnleDBC8Nr2juPFQNLcDIRSawIuF08mEgbUA==
X-Gm-Message-State: AOJu0Yw7DIFH1k8JjQaP8w1dWXI4jUWHZEJmUGOLcIi6+7JxJA7Jwfn/
	/jpejsrXYMA/zCVh8b+PL5Y4OOl/OkrXDEvgAZUbfePOpXVWde1lDJgDSoE2wwU6c0kMC1OaK1B
	lNrRs0/BlGWxvvJjbgJo3mNk8BtxvGGI/3aWV
X-Google-Smtp-Source: AGHT+IFBic9+UPmjG4SdJi5jE45J66ZqwBAVXDHZ3nTQLUNWjZo5jDH79YE3Zcgf2fBd6/uNZXXmfb6q6fhH1dt/sAk=
X-Received: by 2002:a17:902:d590:b0:1f0:9738:d52e with SMTP id
 d9443c01a7336-1f09738d7a9mr3599535ad.2.1715878039953; Thu, 16 May 2024
 09:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-6-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-6-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:47:01 -0700
Message-ID: <CAP-5=fVjpGKbQjadD0Wz11fw3OvkdTkj+YVgkgzNojnR4EpHiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 5/7] perf stat: Add retire latency print functions
 to print out at the very end of print out
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add print out functions so that users could read retire latency values.
>
> Example output:
>
>  Performance counter stats for 'system wide':
>
>             25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %  tm=
a_split_stores
>         28,365,080      CPU_CLK_UNHALTED.THREAD
>              24.00      MEM_INST_RETIRED.SPLIT_STORES:R  #       96      =
  4
>
>        2.054365083 seconds time elapsed
>
> This output of retire latency data is in format:
>  <val> <event-name:R> # <sum> <count>.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>

My usual complaint that I hate the stat-display spaghetti code. We
keep putting more spaghetti on the plate and this change does this
too. In the evsel approach:
https://lore.kernel.org/lkml/20240428053616.1125891-1-irogers@google.com/
retirement latency events just update the counts for the event and so
we don't need to special case tpebs events like this. I'd prefer we
went that route. My reviewed-by no longer stands.

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 69 ++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index bfc1d705f437..b9c3978cc99c 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -21,6 +21,7 @@
>  #include "iostat.h"
>  #include "pmu.h"
>  #include "pmus.h"
> +#include "intel-tpebs.h"
>
>  #define CNTR_NOT_SUPPORTED     "<not supported>"
>  #define CNTR_NOT_COUNTED       "<not counted>"
> @@ -34,6 +35,7 @@
>  #define COMM_LEN     16
>  #define PID_LEN       7
>  #define CPUS_LEN      4
> +#define RETIRE_LEN    8
>
>  static int aggr_header_lens[] =3D {
>         [AGGR_CORE]     =3D 18,
> @@ -426,6 +428,71 @@ static void print_metric_std(struct perf_stat_config=
 *config,
>         fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
>  }
>
> +static void print_retire_lat_std(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       bool newline =3D os->newline;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               if (newline)
> +                       do_new_line_std(config, os);
> +               fprintf(out, "%'*.2f ", COUNTS_LEN, t->val);
> +               /* For print alignment */
> +               fprintf(out, "%-*s ", config->unit_width, "");
> +               fprintf(out, "%-*s", EVNAME_LEN, t->tpebs_name);
> +               fprintf(out, " # ");
> +               fprintf(out, "%*d %*ld\n", RETIRE_LEN, t->sum,
> +                        RETIRE_LEN, t->count);
> +       }
> +}
> +
> +static void print_retire_lat_csv(struct perf_stat_config *config,
> +                                struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +       const char *sep =3D config->csv_sep;
> +
> +       list_for_each_entry(t, retire_lats, nd) {
> +               fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->=
tpebs_name, sep,
> +                       t->count, sep, t->sum);
> +       }
> +}
> +
> +static void print_retire_lat_json(struct perf_stat_config *config,
> +                                 struct outstate *os)
> +{
> +       FILE *out =3D os->fh;
> +       struct tpebs_retire_lat *t;
> +       struct list_head *retire_lats =3D &config->tpebs_results;
> +
> +       fprintf(out, "{");
> +       list_for_each_entry(t, retire_lats, nd) {
> +               fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->va=
l);
> +               fprintf(out, "\"name\" : \"%s\"", t->tpebs_name);
> +               fprintf(out, "\"sample-counts\" : \"%ld\"", t->count);
> +               fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->sum);
> +       }
> +       fprintf(out, "}");
> +}
> +
> +static void print_retire_lat(struct perf_stat_config *config,
> +                            struct outstate *os)
> +{
> +       if (!&config->tpebs_results)
> +               return;
> +       if (config->json_output)
> +               print_retire_lat_json(config, os);
> +       else if (config->csv_output)
> +               print_retire_lat_csv(config, os);
> +       else
> +               print_retire_lat_std(config, os);
> +}
> +
>  static void new_line_csv(struct perf_stat_config *config, void *ctx)
>  {
>         struct outstate *os =3D ctx;
> @@ -1609,6 +1676,8 @@ void evlist__print_counters(struct evlist *evlist, =
struct perf_stat_config *conf
>                 break;
>         }
>
> +       print_retire_lat(config, &os);
> +
>         print_footer(config);
>
>         fflush(config->output);
> --
> 2.43.0
>

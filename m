Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TVXtEU7Q"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC96D0
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 13:39:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so4153a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702503550; x=1703108350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2IQSQqMai6kuNrxSi8uGq077p2WckVFN/XXHL01ISc=;
        b=TVXtEU7Qwny1SkOLD/92UOI+zcwotio9Kleb/UehC16l/eAEea7gkwQBlv2ZQLl8bV
         FXnyyT7+8M4NcXHTDJA6ZvPZqJzPasd4m/sUHDtQ2mqkAovAVDm8kLrI0CVFlaWYd5fx
         nBaGp2MhQ8C9pJPPX42FuJV63insF4Au3JhOZTOpVkceKebIoYnhRijozVyGS+MSlMZR
         7cBLooGI0pfu9px417Rfhn44mMJYw6ungLMUZJMsneaIXWLW0whjc9ZyPYrB86Lj4315
         mCeL1Y///SMnxM2J6o33WXyIISlQbA0OBAFyXbI89Jgrl3OEH0b0Nm+PDhby8QxQ5rcf
         zT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702503550; x=1703108350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2IQSQqMai6kuNrxSi8uGq077p2WckVFN/XXHL01ISc=;
        b=QphjmdCSm96dNyso3EgVAzP1qwmR3sWnc7/ObhtobZKFhdZ3JDDXqXUqknzo33hrmD
         7dxBAUtCtjcezJB8ojNV3gCBkpjnPbm9fIzSwTFeKFEimGaNhe0E1TBsQPqzD2VORMhf
         LzKiA3b5A+sH9enKEX2ei9tTSMnv82V2XBj7AtI/+BgK6nzLqKBopKLjpBQ24Dk7qm7J
         BbzMRLox4c3HwGL216O6WAx52FrtVcOj1NjE5xM9l/0oYTAVCA2KYp/ZWW6C7Mi9Z7b5
         0P4jWjz/9jrFo1Lf01Bel2ODXvYEkcTfny7yvTQ5T95pncKzlb3eq2y4KJVXJ9D09rTn
         Y0DA==
X-Gm-Message-State: AOJu0YyInjmjWlxnOQUa7vSx6VNMSnz05eX/BZWXGpMMm23fQh54hXPj
	pK3MbYlPj7GTlrMAT9I66eeYYclOUa5PXBfIuADOKw==
X-Google-Smtp-Source: AGHT+IHJGYL0WyK+ptDzl8JGWcv27nGsQ9AtIj7VW01D7JZJbOiWn77xeuW8yHfEuXpZY87Ut38hazZQFtTL0kU+kO4=
X-Received: by 2002:a05:6402:35c5:b0:551:9870:472 with SMTP id
 z5-20020a05640235c500b0055198700472mr307896edc.1.1702503550316; Wed, 13 Dec
 2023 13:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213213633.1088026-1-kan.liang@linux.intel.com> <20231213213633.1088026-2-kan.liang@linux.intel.com>
In-Reply-To: <20231213213633.1088026-2-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 Dec 2023 13:38:58 -0800
Message-ID: <CAP-5=fVWKVV9kpZdUdTpQ+HeyfGnCYctxo_rvqq9BNRnsv-KcA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] perf top: Uniform the event name for the hybrid machine
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org, 
	marcan@marcan.st, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:36=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> It's hard to distinguish the default cycles events among hybrid PMUs.
> For example,
>
>  $perf top
> Available samples
> 385 cycles:P
> 903 cycles:P
>
> The other tool, e.g., perf record, uniforms the event name and adds the
> hybrid PMU name before opening the event. So the events can be easily
> distinguished. Apply the same methodology for the perf top as well.
>
> The record__uniquify_name() will be invoked by both record and top.
> Move it to util/record.c
>
> With the patch
>  $perf top
> Available samples
> 148 cpu_atom/cycles:P/
> 1K cpu_core/cycles:P/
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> New patch to address the display concern
> https://lore.kernel.org/lkml/e9383607-1e43-4c1a-9512-29f27784d035@linux.i=
ntel.com/
>
>  tools/perf/builtin-record.c | 28 +---------------------------
>  tools/perf/builtin-top.c    |  1 +
>  tools/perf/util/record.c    | 25 +++++++++++++++++++++++++
>  tools/perf/util/record.h    |  2 ++
>  4 files changed, 29 insertions(+), 27 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index dcf288a4fb9a..a096422a4a14 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2216,32 +2216,6 @@ static void hit_auxtrace_snapshot_trigger(struct r=
ecord *rec)
>         }
>  }
>
> -static void record__uniquify_name(struct record *rec)
> -{
> -       struct evsel *pos;
> -       struct evlist *evlist =3D rec->evlist;
> -       char *new_name;
> -       int ret;
> -
> -       if (perf_pmus__num_core_pmus() =3D=3D 1)
> -               return;
> -
> -       evlist__for_each_entry(evlist, pos) {
> -               if (!evsel__is_hybrid(pos))
> -                       continue;
> -
> -               if (strchr(pos->name, '/'))
> -                       continue;
> -
> -               ret =3D asprintf(&new_name, "%s/%s/",
> -                              pos->pmu_name, pos->name);
> -               if (ret) {
> -                       free(pos->name);
> -                       pos->name =3D new_name;
> -               }
> -       }
> -}
> -
>  static int record__terminate_thread(struct record_thread *thread_data)
>  {
>         int err;
> @@ -2475,7 +2449,7 @@ static int __cmd_record(struct record *rec, int arg=
c, const char **argv)
>         if (data->is_pipe && rec->evlist->core.nr_entries =3D=3D 1)
>                 rec->opts.sample_id =3D true;
>
> -       record__uniquify_name(rec);
> +       record__uniquify_name(rec->evlist);
>
>         /* Debug message used by test scripts */
>         pr_debug3("perf record opening and mmapping events\n");
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index cce9350177e2..4e8296654280 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1299,6 +1299,7 @@ static int __cmd_top(struct perf_top *top)
>                 }
>         }
>
> +       record__uniquify_name(top->evlist);
>         ret =3D perf_top__start_counters(top);
>         if (ret)
>                 return ret;
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index 9eb5c6a08999..5b4be3c72cbc 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -289,3 +289,28 @@ int record__parse_freq(const struct option *opt, con=
st char *str, int unset __ma
>         opts->user_freq =3D freq;
>         return 0;
>  }
> +
> +void record__uniquify_name(struct evlist *evlist)
> +{
> +       struct evsel *pos;
> +       char *new_name;
> +       int ret;
> +
> +       if (perf_pmus__num_core_pmus() =3D=3D 1)
> +               return;
> +
> +       evlist__for_each_entry(evlist, pos) {
> +               if (!evsel__is_hybrid(pos))
> +                       continue;
> +
> +               if (strchr(pos->name, '/'))
> +                       continue;
> +
> +               ret =3D asprintf(&new_name, "%s/%s/",
> +                              pos->pmu_name, pos->name);
> +               if (ret) {
> +                       free(pos->name);
> +                       pos->name =3D new_name;
> +               }
> +       }
> +}
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index a6566134e09e..9b520ab784bc 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -8,6 +8,7 @@
>  #include <linux/stddef.h>
>  #include <linux/perf_event.h>
>  #include "util/target.h"
> +#include "util/evlist.h"
>
>  struct option;
>
> @@ -85,6 +86,7 @@ extern const char * const *record_usage;
>  extern struct option *record_options;
>
>  int record__parse_freq(const struct option *opt, const char *str, int un=
set);
> +void record__uniquify_name(struct evlist *evlist);
>
>  static inline bool record_opts__no_switch_events(const struct record_opt=
s *opts)
>  {
> --
> 2.35.1
>

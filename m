Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC71A3;
	Wed, 13 Dec 2023 13:57:40 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-286d6c95b8cso7454001a91.0;
        Wed, 13 Dec 2023 13:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504660; x=1703109460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQqLwK3HU1Otv+0tZFWCB1wB5/jyhN9nnVvueoDO6UU=;
        b=lnAglBq4R68dfHPI6Hn4qOMa7KpiV7cAzaGAkH+GW0SDuFUY3xYHeA48iWzs1h+onq
         2OK9ynJM12F6qUvaGCAz9+bTyBKsbc8vqbCv0mPlXygles+QRNm6V2EQ8e6U8v8bUBn/
         k39lozrca/F700QC0DU3rIkqWAZQk+If+52sW80D0rNe6j01108O/utFiaOSImRwR55x
         uAWY8iIpamvPEf0YLM/FvIoM8jr0A9YWObxkRgW2hwbJUVOwQ2WkhlXKcZKgToRLQGVW
         JIZsmSFOrixqyUo38VEoNaTMzVYocFlPLlnJiQI4PHME58YzJVZDbAf05twL8mDA/nVf
         5tWw==
X-Gm-Message-State: AOJu0YzchGbRKzfyU/6CmLlFUc0T9Cbl4OS+IeDqy4nxAbhNW2gc9I2A
	2EWz6kMWDbGpnUod+YkIwFCh+esSAkYIuxv3Nyc=
X-Google-Smtp-Source: AGHT+IECQwrpQpcL3AmWTTOjT4MuAB4OMTgwPTOQl5k11KstHbn9nNj69ygG2ncJuQqnQv+zSNLZVSfCEzuC88sJbSo=
X-Received: by 2002:a17:90b:50c:b0:280:c98f:2090 with SMTP id
 r12-20020a17090b050c00b00280c98f2090mr7169611pjz.32.1702504660267; Wed, 13
 Dec 2023 13:57:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213213633.1088026-1-kan.liang@linux.intel.com> <20231213213633.1088026-2-kan.liang@linux.intel.com>
In-Reply-To: <20231213213633.1088026-2-kan.liang@linux.intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 13 Dec 2023 13:57:29 -0800
Message-ID: <CAM9d7ch+rHDp3E40QvBu+PGs8N+5iOP3i=HmYXKshcohs05MaQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] perf top: Uniform the event name for the hybrid machine
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, irogers@google.com, mark.rutland@arm.com, maz@kernel.org, 
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

Maybe better to rename it to evlist__uniquify_name() and move it
to util/evlist.c.

Thanks,
Namhyung

>
> With the patch
>  $perf top
> Available samples
> 148 cpu_atom/cycles:P/
> 1K cpu_core/cycles:P/
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
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

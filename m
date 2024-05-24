Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE0157A41;
	Fri, 24 May 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716592641; cv=none; b=VsIO3DdjTssVcHX4dN427PzEXmZgPaW0TLeHm1dAfX1I4mWg1fvXh2FP3873oqI0xaywnH0Yx073g0G13hiEqyl2290BYf3kWO7bX3RyzCJMQxd/ust+QhnJwY5+R5/mnlJFWHBdKWzfOFKBHoqQKuQyMbUQwKsziA/5rcnw49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716592641; c=relaxed/simple;
	bh=8ZpglXReu9jsHqF0GVWA7NWwntfDlNZkHd6/fLaVNcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmG4dawsFqcq62O++kZ35F/W56PiRx5UA8qgCOWDwmN0mevngMynMym03T5cNxZCwMrYb+YiHNLAtYWqJaK6QYAJsCdFHFnrH9Q6sSM+/h9vzv7OPtYQamnmMWONVsT+rZxW9z+e8Rf1bTMuOgWsEPbChtTyjf3wL4VZhBgELFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-68197de7400so1185217a12.3;
        Fri, 24 May 2024 16:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716592639; x=1717197439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzNlQGYnHC7S2+oFoHwAexbz5wrG29AB2zc9B41IWoc=;
        b=Z2RczcZiUQRHh4zLWidJoJOYFppLDhbi4hk1sqSjMKRU0BtVz1kgpmdzU6AR6e9mfb
         9nYcQf2QZTY3GbdS620CsTmBw/QjqLyaEk9FC+vsFDoxJkNSsZ3EC5fjXUzlDfv6Lj18
         GUc2TbAk7Bnpm15ScWKURFTVabl9lpEsDQFeiVw3nRhTNotgGRk1qbTRJuo3/TQzHsox
         W0uGTzv+IT/I5ah4GanKIx1ZfSz0yYPNMt1YbEGnYe4KaZeQHhkKx7rGEI4ksLdJ7p/R
         bbiQZSwoeKAu4YXwPMCrp4R0QP2fGCPWBPEonJuyfJeuCiXtTsy73ZMssqVaWptrdXUx
         nSgA==
X-Forwarded-Encrypted: i=1; AJvYcCX/hRRlcQzyKEbI4MBlVbf+HdWsFqjcHVMpF8r+kbYulEBsL/cOo5i+D8FgAGi4kNy4EmndVvZ6XuG765hKIzO9HytQmkMYnnReyJ8IooU4gg9G1EbKAHSaB53dqP4FQBl891R7aEOJKy72f0v6UA==
X-Gm-Message-State: AOJu0YxEmpKKXJL2rZaG11wZUTwhIlmgplKEMlPh4xnHZnouU5Z4AJv0
	jwavMisE23OPhY+SHOUqz/T3pQb7qed0QhZzkCHjzihF5D9pFYbrmksweUyQ3dfCjTmt7AgHP3k
	37jlYjJA5AF1kZzS+R8l+kKzqxp8=
X-Google-Smtp-Source: AGHT+IHhUOMqAS7k8dhN0V6qVsZ8JkLU0zsvXWs5vfw0GEWWqbjL6f5N3Z3pGBQ1imTuUbQIEaPeDpP2Ale4CK3b1rA=
X-Received: by 2002:a17:90b:14d:b0:2ad:af1c:4fc with SMTP id
 98e67ed59e1d1-2bf5e18665fmr3563672a91.25.1716592638698; Fri, 24 May 2024
 16:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521173952.3397644-1-weilin.wang@intel.com> <20240521173952.3397644-5-weilin.wang@intel.com>
In-Reply-To: <20240521173952.3397644-5-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 24 May 2024 16:17:07 -0700
Message-ID: <CAM9d7cjob_tfgN+rMRrh=0SV56+z32CmP34BRY1eoFv48RVocg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from
 sampled data to evsel
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:40=E2=80=AFAM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> In current :R parsing implementation, the parser would recognize events w=
ith
> retire_latency modifier and insert them into the evlist like a normal eve=
nt.
> Ideally, we need to avoid counting these events.
>
> In this commit, at the time when a retire_latency evsel is read, set the =
retire
> latency value processed from the sampled data to count value. This sample=
d
> retire latency value will be used for metric calculation and final event =
count
> print out.

I'm confused.  Do you mean you don't count the event with 'R' modifier
(w/ perf stat) and just print the (average) retire latency (from perf recor=
d)?

>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c |  6 +++++
>  tools/perf/util/evsel.c           | 44 +++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.h           |  5 ++++
>  3 files changed, 55 insertions(+)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index b1ce0c52d88d..cebdd483149e 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -89,6 +89,12 @@ int arch_evlist__cmp(const struct evsel *lhs, const st=
ruct evsel *rhs)
>                         return 1;
>         }
>
> +       /* Retire latency event should not be group leader*/

Hmm.. why?

> +       if (lhs->retire_lat && !rhs->retire_lat)
> +               return 1;
> +       if (!lhs->retire_lat && rhs->retire_lat)
> +               return -1;
> +
>         /* Default ordering by insertion index. */
>         return lhs->core.idx - rhs->core.idx;
>  }
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a0a8aee7d6b9..4d700338fc99 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -58,6 +58,7 @@
>  #include <internal/xyarray.h>
>  #include <internal/lib.h>
>  #include <internal/threadmap.h>
> +#include "util/intel-tpebs.h"
>
>  #include <linux/ctype.h>
>
> @@ -1523,6 +1524,40 @@ static int evsel__read_one(struct evsel *evsel, in=
t cpu_map_idx, int thread)
>         return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count)=
;
>  }
>
> +static int evsel__set_retire_lat(struct evsel *evsel, int cpu_map_idx, i=
nt thread)
> +{
> +       struct perf_counts_values *count;
> +       struct tpebs_retire_lat *t;
> +       bool found =3D false;
> +       __u64 val;
> +
> +       count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> +
> +       list_for_each_entry(t, &tpebs_results, nd) {
> +               if (!strcmp(t->tpebs_name, evsel->name)) {
> +                       found =3D true;
> +                       break;
> +               }
> +       }
> +
> +       if (!found)
> +               return -1;
> +
> +       /*
> +        * Only set retire_latency value to the first CPU and thread.
> +        */
> +       if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> +               val =3D t->val;
> +       else
> +               val =3D 0;
> +
> +       count->val =3D val;
> +       /* Set ena and run to non-zero */
> +       count->ena =3D count->run =3D 1;
> +       count->lost =3D 0;

So here it seems you discard the actual count of the events
and replace it with the retire latency.  That means you don't
need to open the event in perf stat, and probably just have a
placeholder, right?

Btw, I think it's better to move this logic to intel-tpebs.c file and
rename to tpebs_set_retire_lat().


> +       return 0;
> +}
> +
>  static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int=
 thread,
>                              u64 val, u64 ena, u64 run, u64 lost)
>  {
> @@ -1530,6 +1565,12 @@ static void evsel__set_count(struct evsel *counter=
, int cpu_map_idx, int thread,
>
>         count =3D perf_counts(counter->counts, cpu_map_idx, thread);
>
> +       if (counter->retire_lat) {

if (evsel__is_retire_lat(counter)) ?


> +               evsel__set_retire_lat(counter, cpu_map_idx, thread);
> +               perf_counts__set_loaded(counter->counts, cpu_map_idx, thr=
ead, true);
> +               return;
> +       }
> +
>         count->val    =3D val;
>         count->ena    =3D ena;
>         count->run    =3D run;
> @@ -1778,6 +1819,9 @@ int evsel__read_counter(struct evsel *evsel, int cp=
u_map_idx, int thread)
>         if (evsel__is_tool(evsel))
>                 return evsel__read_tool(evsel, cpu_map_idx, thread);
>
> +       if (evsel__is_retire_lat(evsel))
> +               return evsel__set_retire_lat(evsel, cpu_map_idx, thread);
> +

I'm not sure if it works well with group event.  Probably that's
why you wanted to prevent group leaders.  But I guess you
can just check this after the PERF_FORMAT_GROUP, no?

Thanks,
Namhyung


>         if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
>                 return evsel__read_group(evsel, cpu_map_idx, thread);
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index bd8e84954e34..aaf572317e92 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -303,6 +303,11 @@ static inline bool evsel__is_tool(const struct evsel=
 *evsel)
>         return evsel->tool_event !=3D PERF_TOOL_NONE;
>  }
>
> +static inline bool evsel__is_retire_lat(const struct evsel *evsel)
> +{
> +       return evsel->retire_lat;
> +}
> +
>  const char *evsel__group_name(struct evsel *evsel);
>  int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
>
> --
> 2.43.0
>

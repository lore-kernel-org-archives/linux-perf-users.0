Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA713AA45
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366923; cv=none; b=AYbNSOWDHmkDbiXrWDA28hj9+1eTy5RSpEpBOjeVK7nM4dfMrcYXGwKHXfnzU4xVg9n4xhhmbfkd6jcEPBoL/vI/roMy/rnPuKH4tG271rOC8QzAepn7lvtvSxVsKNwLdkDlc8TLSKvi3XkZS2/LxFeyUThNgfJ8pyNKlADlkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366923; c=relaxed/simple;
	bh=avEFguux3S9vM8mNPwIIXP3BTk6hCqea7FvB/rVtqrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIkchh1B5V0PZejTdlGqgYhf4pU6lq0+zMLStQV61WAKz94sHZKqmeDlqF7rOrxquECRCkM2Y9WuspeXUyposHrmF0sz0b8ymIwykOkK8LLn7KX0BX3SYSZ/15pxaGoyfoTj/GzTN94A2pZ050zM54kQr6G24L0YdtB9pcbHl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tn/5I3pX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tn/5I3pX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c593d6a95so48075ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Oct 2024 22:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728366921; x=1728971721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEML1acWheRJ5mGKtc1GLEU++PB7wEH7HBYQKEb9NvM=;
        b=Tn/5I3pXMEHEzBilaaN6k2jxmiddpEWN9mDH0v5LTqeZdiEIeo1GICMmKU7Oxx5yJi
         4lR/F+wAegK/k0oaMoPwfUZ6X8rgdxrVRaotyvFr3CrHUVHpFvFkPtl2yJ1p2AAPn8Si
         AA74/oNiugbj/b0LCYOl+PxaWfY3TTSiVvj/0+ylXQLnuyDp8ZJ6eDlk3F991ZVv2m13
         70Wbq7ww7qCo9CAPirzo2S3wMPTn+RC/GhRt+S30cRs3iKurzgu2EiezJDO8raQJc1k4
         7OSX2EEFS0l+wEZAc0dcKFVY3x0x6Ug3sln+QZ/Vx8W1XZ0wb4iqaYglE11M5zdoZ4Wa
         D2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728366921; x=1728971721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEML1acWheRJ5mGKtc1GLEU++PB7wEH7HBYQKEb9NvM=;
        b=PNZfEdiJuFaNA1fH5w0k5ANZseJCiMYXLYWijni4uv9XIrf4xGXmPmW7znMY7z/Mhh
         Tj6E1HVg+69k5ylkDEq4fXLc0EnLlSXM6Z5n0e+NNDGO+6yk63IvfLAWQiOj0t0GNGMe
         A4/gwubyYeOUgXLRsMYCuSCl5F+hX+kaY9ubVf3JpVrsPbAkNQN6IHcBoPWhvAhp4hjc
         FnGcquh5r9Y/4Og9ZsIE0MlH3jkfkFKhYoZb4d1Z7yogeFy/tMEelXm5TeyxrXDgvZGU
         C1qp1QAYgqgaCWkpNFPbnghcIS2YxBbwik4uzPqZdZa1ERmH96YcEh5Z9pFDbU+PX9Zr
         DWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9dKMOc1xnaj9NtfOa3u5SGFDwwzbZZTIdQCCNFVJcvcgw0wNBj9UZG8EuzgY9n/XaLA7sqkpCdA8Y0u7Vpgt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5pxrcRsd5U4DFeelbVoMFtTdSNvnCtuog+CL2H9L9OX8dCyW
	B2eDkL7Sd/TyLD119ZAOtq92p9B6WwdRGA28z0/YGoMAZ90T85kMKG3zFNPW1fta2Hen1HzB4R/
	8WjwfY/d+yDcPatdB0hH9oUuOl5/QqRDoCOmd
X-Google-Smtp-Source: AGHT+IFBqK5Obh7o1Mvkbq2D+3L4js7HVmAzdZIa1jnn8hA6ZsmChJx0GIsPZbbQH2y/mfxBtFaUIsZMvAcerar88Mk=
X-Received: by 2002:a17:902:ea06:b0:206:ae0b:bfcb with SMTP id
 d9443c01a7336-20c50243a9amr1923155ad.28.1728366920473; Mon, 07 Oct 2024
 22:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com> <20240913084712.13861-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20240913084712.13861-2-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Oct 2024 22:55:07 -0700
Message-ID: <CAP-5=fVFe30xEt6JAg6rUTsAKZpg=7LBSQJSBd=BZszwufjFFw@mail.gmail.com>
Subject: Re: [Patch v5 1/6] perf x86/topdown: Complete topdown slots/metrics
 events check
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:21=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> It's not complete to check whether an event is a topdown slots or
> topdown metrics event by only comparing the event name since user
> may assign the event by RAW format, e.g.
>
> perf stat -e '{instructions,cpu/r400/,cpu/r8300/}' sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>      <not counted>      instructions
>      <not counted>      cpu/r400/
>    <not supported>      cpu/r8300/
>
>        1.002917796 seconds time elapsed
>
>        0.002955000 seconds user
>        0.000000000 seconds sys
>
> The RAW format slots and topdown-be-bound events are not recognized and
> not regroup the events, and eventually cause error.
>
> Thus add two helpers arch_is_topdown_slots()/arch_is_topdown_metrics()
> to detect whether an event is topdown slots/metrics event by comparing
> the event config directly, and use these two helpers to replace the
> original event name comparisons.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c  |  8 ++---
>  tools/perf/arch/x86/util/evsel.c   |  3 +-
>  tools/perf/arch/x86/util/topdown.c | 48 +++++++++++++++++++++++++++++-
>  tools/perf/arch/x86/util/topdown.h |  2 ++
>  4 files changed, 55 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index cebdd483149e..79799865a62a 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -78,14 +78,14 @@ int arch_evlist__cmp(const struct evsel *lhs, const s=
truct evsel *rhs)
>         if (topdown_sys_has_perf_metrics() &&
>             (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_=
group(rhs))) {
>                 /* Ensure the topdown slots comes first. */
> -               if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->na=
me, "uops_retired.slots"))
> +               if (arch_is_topdown_slots(lhs))
>                         return -1;
> -               if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->na=
me, "uops_retired.slots"))
> +               if (arch_is_topdown_slots(rhs))
>                         return 1;
>                 /* Followed by topdown events. */
> -               if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->=
name, "topdown"))
> +               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metr=
ics(rhs))
>                         return -1;
> -               if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->=
name, "topdown"))
> +               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metr=
ics(rhs))
>                         return 1;
>         }
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/=
evsel.c
> index 090d0f371891..181f2ba0bb2a 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -6,6 +6,7 @@
>  #include "util/pmu.h"
>  #include "util/pmus.h"
>  #include "linux/string.h"
> +#include "topdown.h"
>  #include "evsel.h"
>  #include "util/debug.h"
>  #include "env.h"
> @@ -44,7 +45,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *e=
vsel)
>             strcasestr(evsel->name, "uops_retired.slots"))
>                 return false;
>
> -       return strcasestr(evsel->name, "topdown") || strcasestr(evsel->na=
me, "slots");
> +       return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(ev=
sel);
>  }
>
>  int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/uti=
l/topdown.c
> index 3f9a267d4501..49f25d67ed77 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -32,6 +32,52 @@ bool topdown_sys_has_perf_metrics(void)
>  }
>
>  #define TOPDOWN_SLOTS          0x0400
> +bool arch_is_topdown_slots(const struct evsel *evsel)
> +{

Perhaps: assert(evsel__find_pmu(evsel)->is_core);

> +       if (evsel->core.attr.config =3D=3D TOPDOWN_SLOTS)
> +               return true;
> +
> +       return false;
> +}
> +
> +static int compare_topdown_event(void *vstate, struct pmu_event_info *in=
fo)
> +{
> +       int *config =3D vstate;
> +       int event =3D 0;
> +       int umask =3D 0;
> +       char *str;
> +
> +       if (!strcasestr(info->name, "topdown"))
> +               return 0;
> +
> +       str =3D strcasestr(info->str, "event=3D");
> +       if (str)
> +               sscanf(str, "event=3D%x", &event);
> +
> +       str =3D strcasestr(info->str, "umask=3D");
> +       if (str)
> +               sscanf(str, "umask=3D%x", &umask);
> +
> +       if (event =3D=3D 0 && *config =3D=3D (event | umask << 8))
> +               return 1;
> +
> +       return 0;
> +}
> +
> +bool arch_is_topdown_metrics(const struct evsel *evsel)
> +{
> +       struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> +       int config =3D evsel->core.attr.config;
> +
> +       if (!pmu || !pmu->is_core)
> +               return false;
> +
> +       if (perf_pmu__for_each_event(pmu, false, &config,
> +                                    compare_topdown_event))
> +               return true;
> +
> +       return false;
> +}


Doing a linear search over every event is painful perf_pmu__have_event
will try to binary search. The search rejects all events without
"topdown" in their name, it then sees if the event code is 0 and the
event|umask match the sysfs/json event. Is there ever a case the
"topdown" string isn't at the beginning of the string? If it is it
should be possible to binary search to the start of the topdown
events.

Strictly you shouldn't hard code the config positions of event and
umask, they are in the format list:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.h?h=3Dperf-tools-next#n113
There is code doing similar to this here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n2285
but it avoids the scanf, uses formats...
It seems reasonable this code should reject all non-zero configs
before searching all core PMU events. It could also use
perf_pmu__name_from_config. So:
```
bool evsel__is_topdown_metric_event(const struct evsel *evsel)
{
   struct perf_pmu *pmu;
   const char *name_from_config;

   if (evsel->core.attr.config & 0xFF !=3D 0) /* All topdown events have
an event code of 0. */
     return false;

  pmu  =3D evsel__find_pmu(evsel);
  if (!pmu || !pmu->is_core)
     return false;

  name_from_config =3D perf_pmu__name_from_config(pmu, config);
  return name_from_config && !strcasestr(name_from_config, "topdown);
}
```
We could tweak perf_pmu__name_from_config to be pased a  "filter". In
this case the filter would skip events without topdown in their name,
without doing a config comparison.

If later we change perf_pmu__name_from_config to say sort events in a
list by config, then this code could take advantage of that. Perhaps
for now there should just be an optional "prefix" that can be used to
binary search to the events.
```
  name_from_config =3D perf_pmu__name_from_config(pmu, config,
/*prefix=3D*/"topdown");
```

Thanks,
Ian

>  /*
>   * Check whether a topdown group supports sample-read.
> @@ -44,7 +90,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
>         if (!evsel__sys_has_perf_metrics(leader))
>                 return false;
>
> -       if (leader->core.attr.config =3D=3D TOPDOWN_SLOTS)
> +       if (arch_is_topdown_slots(leader))
>                 return true;
>
>         return false;
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/uti=
l/topdown.h
> index 46bf9273e572..1bae9b1822d7 100644
> --- a/tools/perf/arch/x86/util/topdown.h
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -3,5 +3,7 @@
>  #define _TOPDOWN_H 1
>
>  bool topdown_sys_has_perf_metrics(void);
> +bool arch_is_topdown_slots(const struct evsel *evsel);
> +bool arch_is_topdown_metrics(const struct evsel *evsel);
>
>  #endif
> --
> 2.40.1
>

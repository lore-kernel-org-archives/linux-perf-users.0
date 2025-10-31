Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDC2E8DE9
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927041; cv=none; b=ZNdkFTkAypGikccYR/VxZA+o5Q0OEApHs51K1xGGqBif3nS1efnBEvvUsHBkHBTzsCWuLgCBrxW6MbXY1B2uKQQl/TMA4kRs92qswbdQbOe1rDu5frNzLQSa7L6ohBiIZCI0bJpAqnB+xcPnhjBkyHnBe+uRPeOvKLY0vBwusu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927041; c=relaxed/simple;
	bh=TAxzTfAH15ikAqnfTFk68QwqGL+1mN/BsZnt/ZLstuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qfVnq7d6mdaEr9WrTNyNO5+OzQCLP0sbNAWr4icexYKOZNLntc5bXod/BLSjuMHnXCZDJAgmpCxmGFDxUwfeoLwfWiPS0XJ+5f7EEgckaEsuHeIOZMAxqQz6AecM3+VsVM/Ts/yTJ1Se6/DoPw4NWp5OTLUlrir0+zAePclEZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMkebEAu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMkebEAu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d67abd215so263505ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761927038; x=1762531838; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox59yowNWyjiX1gk5+cWPDLZYRx/RstMsmczOvK3gpc=;
        b=MMkebEAu+iNPLEhYuao4kg4t3WmW4E3LR0a0Y7EZlWyUpWvnyRR/RLpw3pBWVOcIo1
         5GAEK4hCeB+6/5rIpQJU4ipHqdEkhxPwrWs7jEprLapOkXKz/+EuXDsKtxc6e0LS+lef
         1yXuB5mnxd8FXjWOylhxCmOFcpxdBAPe8uDO4f4XpZF2h7BjoLhszpELWK7V/8e4wek8
         itgW5nhjhRK4sHLUqkK2rQ3b9twYwTdyhmuZdtgdY2ktt/xLlZpWS4OI/xUwLOUiuTxa
         TS2fMOSyKs9RTWjEcqwGbEJmrOD/Br/sGFPFmSQWLpaZXUZqpRHNaaGMcHsGWxFdzS+0
         7jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927038; x=1762531838;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox59yowNWyjiX1gk5+cWPDLZYRx/RstMsmczOvK3gpc=;
        b=Zqjw+Pqd/5403jUFTl5TMJ6qE0K2dJ8pOEMG6Dg1gwCcLn5O8bsJXnQJQUsrNmTfgd
         ZyNby3nPHPLQs0+Mcb3Pk7ZCTInpDT6fOsQbzJ0dK+jowR+xv6cMOpCkviWnxqvxc2Cf
         +xuZAjEDIGLa4F+/P0VRb2hNAWiXDxXq23qraCKJnbyr1KSvztHs5RCIoCxN/qgg7Nfm
         yy2YcWv7Cfx1RBfmvlrssJbfL2j1UDnRjNghxteMBqh6mNfDSSmyiBOLT+8t/EdHiWpK
         4wUtIByUO8CSeQxnDioXfsH8osTDEYPQI4l/Gn/mrQxWpSu7mgOjsqMGJmRw+NVSXf56
         ywOw==
X-Forwarded-Encrypted: i=1; AJvYcCW3iXe4jDxOOe2GbJJiFq/56zL0tjt40r15cNXKghC5j6LC12MizZ3dYqobN0vFL+8GRnZTtwLa9eGk3vb71yWf@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4N0c+PUXW0NzTj3c/3VrM1cj54Ki7N1qwG1UM4Wm4M2KuSnQ
	FgJdupZovF0jPwaFFnRqjlLfrKrfNFY5do7BjiJL44/bfihrzNUnLp4Ht9JoIQUAgaRPCKlHFnA
	D2CPGs+cO9oc201l8XYyAiS7QWnSlEW1iASx+WHTE
X-Gm-Gg: ASbGncu8IbC4ph4kT9UahCNm9GDFHQWCThGPz2XbVTlVrt6WieVSVwqcVW/f2AwuPOT
	qliYsCvC3TFjD5wEwuRebrUwjrSBNCqRUC9Ovp5zxGVh1ZlgZxm1vJsrBb70viowalFK/GlYvh7
	SAa5TgJV3AogUFWA5pDvHfzeFXi3ZZn2/nOiHjnBTi915ILCs1ys1050ksUAN1+GdGZyGT+M6mg
	WLhJBEtB0RGjvmgDLBUEaauGxM1b5jwgXh0+HS3vjDod0+rQKVk9mGe/j1gwhGYuQdy1TcsJ6Dk
	EP2NAroOzxiseKk=
X-Google-Smtp-Source: AGHT+IFgpKfqGZMjY3OVk2+0ldI4BFAwiXgWaEbASeMv6uWptaDbA+XCFixqgI0jJ65953CGbIqkmUd14ITbU/4zts8=
X-Received: by 2002:a17:903:2f8a:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-2951e61f447mr5020115ad.4.1761927038157; Fri, 31 Oct 2025
 09:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030172140.1113556-1-irogers@google.com>
In-Reply-To: <20251030172140.1113556-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 09:10:26 -0700
X-Gm-Features: AWmQ_blD1fpniav2g4meIWSAmydK7XkPmCLw6-WavK4mFbwbHTpdGktypqvI2cI
Message-ID: <CAP-5=fXvRK6PpYctLa4UXFbr5xzGDCAUkFuc4JWCEtd0s5QRaQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf s390-sample-raw: Cache counter names
To: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:21=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Searching all event names is slower now that legacy names are
> included. Add a cache to avoid long iterative searches.
>
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877c-=
e4a64ed61d38@linux.ibm.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> --
> v2: Small tweak to the cache_key, just make it match the wanted event val=
ue.

In this thread Thomas added his Tested-by tag:
https://lore.kernel.org/linux-perf-users/0d4b605b-64ab-48a0-bd95-8465dabbba=
e3@linux.ibm.com/
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks!
Ian

> ---
>  tools/perf/util/s390-sample-raw.c | 56 ++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sam=
ple-raw.c
> index 335217bb532b..f5acf6dfa8d0 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -19,12 +19,14 @@
>
>  #include <sys/stat.h>
>  #include <linux/compiler.h>
> +#include <linux/err.h>
>  #include <asm/byteorder.h>
>
>  #include "debug.h"
>  #include "session.h"
>  #include "evlist.h"
>  #include "color.h"
> +#include "hashmap.h"
>  #include "sample-raw.h"
>  #include "s390-cpumcf-kernel.h"
>  #include "util/pmu.h"
> @@ -132,8 +134,8 @@ static int get_counterset_start(int setnr)
>  }
>
>  struct get_counter_name_data {
> -       int wanted;
> -       char *result;
> +       long wanted;
> +       const char *result;
>  };
>
>  static int get_counter_name_callback(void *vdata, struct pmu_event_info =
*info)
> @@ -151,12 +153,22 @@ static int get_counter_name_callback(void *vdata, s=
truct pmu_event_info *info)
>
>         rc =3D sscanf(event_str, "event=3D%x", &event_nr);
>         if (rc =3D=3D 1 && event_nr =3D=3D data->wanted) {
> -               data->result =3D strdup(info->name);
> +               data->result =3D info->name;
>                 return 1; /* Terminate the search. */
>         }
>         return 0;
>  }
>
> +static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unuse=
d)
> +{
> +       return key;
> +}
> +
> +static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void=
 *ctx __maybe_unused)
> +{
> +       return key1 =3D=3D key2;
> +}
> +
>  /* Scan the PMU and extract the logical name of a counter from the event=
. Input
>   * is the counter set and counter number with in the set. Construct the =
event
>   * number and use this as key. If they match return the name of this cou=
nter.
> @@ -164,17 +176,51 @@ static int get_counter_name_callback(void *vdata, s=
truct pmu_event_info *info)
>   */
>  static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
>  {
> +       static struct hashmap *cache;
> +       static struct perf_pmu *cache_pmu;
> +       long cache_key =3D get_counterset_start(set) + nr;
>         struct get_counter_name_data data =3D {
> -               .wanted =3D get_counterset_start(set) + nr,
> +               .wanted =3D cache_key,
>                 .result =3D NULL,
>         };
> +       char *result =3D NULL;
>
>         if (!pmu)
>                 return NULL;
>
> +       if (cache_pmu =3D=3D pmu && hashmap__find(cache, cache_key, &resu=
lt))
> +               return strdup(result);
> +
>         perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=3D*/ true,
>                                  &data, get_counter_name_callback);
> -       return data.result;
> +
> +       if (data.result)
> +               result =3D strdup(data.result);
> +
> +       if (cache_pmu =3D=3D NULL) {
> +               struct hashmap *tmp =3D hashmap__new(get_counter_name_has=
h_fn,
> +                                                  get_counter_name_hashm=
ap_equal_fn,
> +                                                  /*ctx=3D*/NULL);
> +
> +               if (!IS_ERR(cache)) {
> +                       cache =3D tmp;
> +                       cache_pmu =3D pmu;
> +               }
> +       }
> +
> +       if (cache_pmu =3D=3D pmu) {
> +               char *old_value =3D NULL, *new_value =3D strdup(result);
> +
> +               if (new_value) {
> +                       hashmap__set(cache, cache_key, new_value, /*old_k=
ey=3D*/NULL, &old_value);
> +                        /*
> +                         * Free in case of a race, but resizing would be=
 broken
> +                       f  * in that case.

Oh, there's a typo here. I'll send v3 with just this comment fix.

Thanks,
Ian

> +                         */
> +                       free(old_value);
> +               }
> +       }
> +       return result;
>  }
>
>  static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample =
*sample)
> --
> 2.51.1.930.gacf6e81ea2-goog
>

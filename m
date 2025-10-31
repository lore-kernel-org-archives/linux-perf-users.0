Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609A30AD19
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938501; cv=none; b=NcpqMOWltP1ijb00AMvCT0cY8HSFjcp+t7EST6uAZtHkpuc8Asyts67xo9Wcz2LzHUWm/JGEWiyGrdEI5KVhExMAbtAIXlQwQaoQQlBXDO9n08fFV5/jL8ZikYWxkIYWZN1/YSpEVHpvnz2/zxYtBtGfqDuGgQi0zjHOsEps33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938501; c=relaxed/simple;
	bh=IKykEbYZCcLlUg4KrFApgwoDlyD4UsFbAAB9qbP5KRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlxIXgglq8hsovUGij6xvuDAobE4egYOq5FzZ2hD48zKDRrZqkzLYg/agJy2GfSiuorZWj1/hlMGj70GRfjZnsPCauFxXyc82KucIHlKBNYSuvS3+gI+VmdT3cqniIApqG7q8U3Z9lAHk6EkjmKdWwXLcS8WrbVI3aPIxaoNXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/UHlTcT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/UHlTcT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eeafd4882so40085ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938499; x=1762543299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mS5w6YyvPhKniGTg9Zltau2UNMNMQ1CYb3u0bWLzUzw=;
        b=f/UHlTcTJSt0cS+xe3dWwK0cs6HoA3VZjvEh+BVu4Hzx86U2dQbY3YBz7X3tOnGmE/
         fN+EN35OYM9OFLLIa4VrK2JdEE9NdlsCjaq2FyCy+rC5k3+zFdcqwZEOb9yBtazpJ0AF
         SasZ2bs6716bH2J/K0zHICcar7PASFRE/Aaxn0WPY8XZepuqUxMHdwg8UzqUA2q2XtkM
         3n6k4ihvc+w5SPyxREbVr4WzL+ShP2tsOt0FszZoE9EAgT6zRSVRXx43VqjVnhsXge+Z
         rvTqm40jVATngzpqos4fZFkD3U1z5OUreMrOXwnfJ0FmtsfMTDFeSBimDLrQsttLHAEK
         5Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938499; x=1762543299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS5w6YyvPhKniGTg9Zltau2UNMNMQ1CYb3u0bWLzUzw=;
        b=ej804x8PBPm4ZuK8j7DXIkBZD/P1ZxCjr1RvqmvErz2HpbQCkYnk9o35YBQjP5EyN5
         GYiWscMmjo/P69bpRc8hu5mKpEABNJiV59GMS28j9dTUR4Yh0cmkiL3T9uGg2siQIEQ1
         dELgY0TtcI4BTGGc5ursgYujf2LpWjEUFUm9K+dfpYNUy07tWBvwlELZACkREFah7z9K
         wDv/U6YXxe5UYTS09d5vDOW2uqhzbMnNs2KrysNLLYz3lw2i/Sdvk6L41G4xKXO3S1vb
         l+Zz1kxOP0hg6adUWweVXY6WYw1y0si1Xta7DXB0OjE9QDW4+q27UGXvsL0/hQ6s1P/8
         cYGA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Uiom+7NYGd5NyzsQFuG+UygZcYn9t2sMCHE1cA2uAwUsHj/jczxy04fJf2FvnIhOfhjLloH41doICZYBo7Bz@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVvYdC5sAeY0G97QWzXLGHnZtGO8Nq1atUzsIsp5/K+IT/VJ9
	2x4M91kQhzfBd7HPJsPDi7OzMu2Jxr3a3z801qAk0IxkktoON5gwCs8BlUYIGR8+cpWYZhFnc4Y
	yrcKTtnKmm53SsjFwL79dTRULcwVM2TJ861IbcjKo
X-Gm-Gg: ASbGncuogGMWApx8eGESTnFYoNQMfhp3cKKeDbNI5HPjJpC9JTnU3sdi9VBZlomz69S
	PSl1uJIxXwoCR3alitor8WXkgaXzDIpNI0eVVW0Y2EX+QIkTElhb924fhr5AjqiqntBEO/u+qDM
	zGKuUY4chvFSCBxv5DcVlIFAWJwpas1xywWAy4yyKW7HpQbtEg63R5Eh+QS14rcXYv0Ny10mrai
	L3kcufEAiGr4Pj8aAmT3v9gPmsnLJ8gzRXcQuaEIkn8yLuBrynhpMMiC6hJGAoc6lGG3Ofp35R+
	3cU4DdZSMDL5nNLXixSh8FrAGg==
X-Google-Smtp-Source: AGHT+IEhfAExpGgethZEcA6bBOOjL/P1I77mpqVU3G01mbpDDGArm5Q97pVKlwIHj1kJZGc/Zj0coJ28ayizUFu26cg=
X-Received: by 2002:a17:902:ce82:b0:26a:f9c7:f335 with SMTP id
 d9443c01a7336-29554cb679emr620315ad.9.1761938498585; Fri, 31 Oct 2025
 12:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031161213.1452901-1-irogers@google.com> <aQUCVvIEC7brqaG-@google.com>
In-Reply-To: <aQUCVvIEC7brqaG-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 12:21:27 -0700
X-Gm-Features: AWmQ_blB1hhdIjnN1ryfJypIwWZzqTSFQwygC4SAtwH05uJJWpIBVzla6fxjaZ4
Message-ID: <CAP-5=fU8=-Bj7i-WUXfm8qJYDN3B=91VTmMFstEoZ2ub5MZw8w@mail.gmail.com>
Subject: Re: [PATCH v3] perf s390-sample-raw: Cache counter names
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 11:39=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Fri, Oct 31, 2025 at 09:12:13AM -0700, Ian Rogers wrote:
> > Searching all event names is slower now that legacy names are
> > included. Add a cache to avoid long iterative searches.
> >
> > Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> > Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877=
c-e4a64ed61d38@linux.ibm.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> > ---
> > v3: Fix minor comment typo, add Thomas' tag.
> > v2: Small tweak to the cache_key, just make it match the wanted event v=
alue.
> > ---
> >  tools/perf/util/s390-sample-raw.c | 56 ++++++++++++++++++++++++++++---
> >  1 file changed, 51 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-s=
ample-raw.c
> > index 335217bb532b..4f269ea7c93b 100644
> > --- a/tools/perf/util/s390-sample-raw.c
> > +++ b/tools/perf/util/s390-sample-raw.c
> > @@ -19,12 +19,14 @@
> >
> >  #include <sys/stat.h>
> >  #include <linux/compiler.h>
> > +#include <linux/err.h>
> >  #include <asm/byteorder.h>
> >
> >  #include "debug.h"
> >  #include "session.h"
> >  #include "evlist.h"
> >  #include "color.h"
> > +#include "hashmap.h"
> >  #include "sample-raw.h"
> >  #include "s390-cpumcf-kernel.h"
> >  #include "util/pmu.h"
> > @@ -132,8 +134,8 @@ static int get_counterset_start(int setnr)
> >  }
> >
> >  struct get_counter_name_data {
> > -     int wanted;
> > -     char *result;
> > +     long wanted;
> > +     const char *result;
> >  };
> >
> >  static int get_counter_name_callback(void *vdata, struct pmu_event_inf=
o *info)
> > @@ -151,12 +153,22 @@ static int get_counter_name_callback(void *vdata,=
 struct pmu_event_info *info)
> >
> >       rc =3D sscanf(event_str, "event=3D%x", &event_nr);
> >       if (rc =3D=3D 1 && event_nr =3D=3D data->wanted) {
> > -             data->result =3D strdup(info->name);
> > +             data->result =3D info->name;
> >               return 1; /* Terminate the search. */
> >       }
> >       return 0;
> >  }
> >
> > +static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unu=
sed)
> > +{
> > +     return key;
> > +}
> > +
> > +static bool get_counter_name_hashmap_equal_fn(long key1, long key2, vo=
id *ctx __maybe_unused)
> > +{
> > +     return key1 =3D=3D key2;
> > +}
> > +
> >  /* Scan the PMU and extract the logical name of a counter from the eve=
nt. Input
> >   * is the counter set and counter number with in the set. Construct th=
e event
> >   * number and use this as key. If they match return the name of this c=
ounter.
> > @@ -164,17 +176,51 @@ static int get_counter_name_callback(void *vdata,=
 struct pmu_event_info *info)
> >   */
> >  static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
> >  {
> > +     static struct hashmap *cache;
> > +     static struct perf_pmu *cache_pmu;
> > +     long cache_key =3D get_counterset_start(set) + nr;
> >       struct get_counter_name_data data =3D {
> > -             .wanted =3D get_counterset_start(set) + nr,
> > +             .wanted =3D cache_key,
> >               .result =3D NULL,
> >       };
> > +     char *result =3D NULL;
> >
> >       if (!pmu)
> >               return NULL;
> >
> > +     if (cache_pmu =3D=3D pmu && hashmap__find(cache, cache_key, &resu=
lt))
> > +             return strdup(result);
> > +
> >       perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=3D*/ true,
> >                                &data, get_counter_name_callback);
> > -     return data.result;
> > +
> > +     if (data.result)
> > +             result =3D strdup(data.result);
> > +
> > +     if (cache_pmu =3D=3D NULL) {
> > +             struct hashmap *tmp =3D hashmap__new(get_counter_name_has=
h_fn,
> > +                                                get_counter_name_hashm=
ap_equal_fn,
> > +                                                /*ctx=3D*/NULL);
> > +
> > +             if (!IS_ERR(cache)) {
>
> Shouldn't it be if (!IS_ERR(tmp)) ?

Yeah, that's me trying to make the code less racy. Will fix in v4.

> And it's not released.

It's just a global leak for the sake of performance, similar to pmus, ...

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +                     cache =3D tmp;
> > +                     cache_pmu =3D pmu;
> > +             }
> > +     }
> > +
> > +     if (cache_pmu =3D=3D pmu) {
> > +             char *old_value =3D NULL, *new_value =3D strdup(result);
> > +
> > +             if (new_value) {
> > +                     hashmap__set(cache, cache_key, new_value, /*old_k=
ey=3D*/NULL, &old_value);
> > +                     /*
> > +                      * Free in case of a race, but resizing would be =
broken
> > +                      * in that case.
> > +                      */
> > +                     free(old_value);
> > +             }
> > +     }
> > +     return result;
> >  }
> >
> >  static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sampl=
e *sample)
> > --
> > 2.51.1.930.gacf6e81ea2-goog
> >

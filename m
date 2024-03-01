Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBB101EB
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255177; cv=none; b=H5ww7rmH1O0gCAapFIhaHCPJz/uakr1tyCDoC3HEh9PYMCuC+BE6zQsbYJp2qQDw9O8W+dZOu8Lf+yWRK7UZsR5kBJOQY4NjPSxhoXjNhvgEv9AhdzNZPFEPvdP3ynyE2dDRVyJv+NoWEf7q0BYWkyHQvQW76iRXqpP1n7oL/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255177; c=relaxed/simple;
	bh=QwEN1k/cHLzvMaWPFjpg1irL60P6i8tNmytsV7QkE1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAfsCA2i41nGIpEvBLuJN+NV7gAOAWW5L2vq0JbnwTPnF2d1SRlINmv0iObJN8gvEzvYuUgXbNWAu1l9oeXwH/je9L9xtBD9juu8eOunVaPGktmXBnUHk9NknXjBS7L3hDjsElF+t4lmaHGau/dWVP7tofFQVj/ZM+16dD6Joc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxA9zho0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxA9zho0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc9f4d1106so78755ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 17:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709255175; x=1709859975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vChUkylk47jCtb99U8qi4uunBO8k+CjLWplXiyL0CXU=;
        b=AxA9zho0TGcy9WaPbfLWAUkOXFjnDfrUqoloMlHzSR28+Efe3mFw+11jbGZdLxWHo4
         z40s1HyT/CLqc+ttgvgqTL6kgmoYYZvmGUQMVnVQ8F8wB4iUARf0khmtSWwsnUR6XpKP
         hVSwmnNjoi9BDDVurZeFcesWa+AzSgDBF/+SJrsaeHOJDVF+SyHFr2y9EJaJhH11QJuZ
         G7O1FJFCrYRYCzrS4AHi3ZokD9BD7qIKYm7eu8cTCjHk6sAWN8CciBZBxOrjJk5bgpAO
         c+X3FOzFhKM+DaDsVyzjz70lQFj2Ody6sTzPRQwfKIfC0g8UJfdvC/KmfP8TFh2FYMfp
         eE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709255175; x=1709859975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vChUkylk47jCtb99U8qi4uunBO8k+CjLWplXiyL0CXU=;
        b=BUm1Kwqu7VpmZQoxJyD2+m4g/j006HjuRK7doQOaFbEzbzEWfCG89Zj8kluGlpLXZt
         znn1eNsjnQFJGXQf+0Dv0lVwiDe4+xhAZbpD6JbgGEQTCmjB/7vn8JrpiHn3sBVExIpK
         GtWqZQK3oq+bcfIz2a39TshL3Hw96OvIELF8ULP3i+T31y9gWwqZQBSkrrAKxAqfKHgI
         kIJtARwNFuLMAZ4UMkeMKvO5EYHtfpuF+Jf/VnCEPLvg+pzMGGRZ84lMF+0TgaHMuzg9
         vvC93KfI6776Ra0jsxtuTAXRfaqxGIXtXp1rb9lmTFKYmj6A2FHckD2gcUZQgjhckHCv
         oROA==
X-Forwarded-Encrypted: i=1; AJvYcCUS9wnclrd/2B28PJbfNv+GKvzBV4bb027aSPvaxCrM8T1q7vXI2cwek2Kl30WTxtx4YSvhmU7JfB2X9nZtWZf8UH+LBceOtxTdDodK52rpmg==
X-Gm-Message-State: AOJu0YzVrUVBzXgPDkisTW/Cwx7Dl8IovpsuRNgjSfEMb+jnzykRU4N6
	Tbhh+WZw/8vAE3hUY33xMaW1cbpYe2M26Khx1xy9DQK+Cx7qG/Vuk0GM4vv/qd0E6zb8bka34LA
	PfzLPZUO2eCWAa/0F4i2+KEczVGzfkTxe+HlY
X-Google-Smtp-Source: AGHT+IF6ZLpaSGpEgRZjTs852OfdqF7Oqx/Q69br0DHWr2ELtuG/uOgbhtiPHQK0QiwgtskzsqynH7v2AYDqcsKFhws=
X-Received: by 2002:a17:902:fb06:b0:1db:a356:b954 with SMTP id
 le6-20020a170902fb0600b001dba356b954mr88822plb.28.1709255175255; Thu, 29 Feb
 2024 17:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229070757.796244-1-irogers@google.com> <CAM9d7chNekmdJyPbOOzZVhR+cBWajscSg3pVFKN4A4evKwFXjg@mail.gmail.com>
In-Reply-To: <CAM9d7chNekmdJyPbOOzZVhR+cBWajscSg3pVFKN4A4evKwFXjg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 17:06:04 -0800
Message-ID: <CAP-5=fVWC+MeeUcNmofkQi766se4P0ERGz_+L+7uTFUXocwVvQ@mail.gmail.com>
Subject: Re: [PATCH v1] libperf evlist: Avoid out-of-bounds access
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 28, 2024 at 11:08=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Parallel testing appears to show a race between allocating and setting
> > evsel ids. As there is a bounds check on the xyarray it yields a segv
> > like:
> >
> > ```
> > AddressSanitizer:DEADLYSIGNAL
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > =3D=3D484408=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00=
0000000010
> >
> > =3D=3D484408=3D=3DThe signal is caused by a WRITE memory access.
> >
> > =3D=3D484408=3D=3DHint: address points to the zero page.
> >
> >     #0 0x55cef5d4eff4 in perf_evlist__id_hash tools/lib/perf/evlist.c:2=
56
> >     #1 0x55cef5d4f132 in perf_evlist__id_add tools/lib/perf/evlist.c:27=
4
> >     #2 0x55cef5d4f545 in perf_evlist__id_add_fd tools/lib/perf/evlist.c=
:315
> >     #3 0x55cef5a1923f in store_evsel_ids util/evsel.c:3130
> >     #4 0x55cef5a19400 in evsel__store_ids util/evsel.c:3147
> >     #5 0x55cef5888204 in __run_perf_stat tools/perf/builtin-stat.c:832
> >     #6 0x55cef5888c06 in run_perf_stat tools/perf/builtin-stat.c:960
> >     #7 0x55cef58932db in cmd_stat tools/perf/builtin-stat.c:2878
> > ...
> > ```
> >
> > Avoid this crash by early exiting the perf_evlist__id_add_fd and
> > perf_evlist__id_add is the access is out-of-bounds.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> While I'm ok with this change, the real fix would be changing
> evsel_store__ids() to use xyarray__max_{x,y} for fd instead
> of cpu and thread map numbers.

So I'm not sure on how to code that fix. Could you take over looking
at this? It reproduces for me with "perf test -v -p" when built with
"-fsanitize=3Daddress".

Thanks,
Ian

> Thanks,
> Namhyung
>
> > ---
> >  tools/lib/perf/evlist.c                  | 18 ++++++++++++------
> >  tools/lib/perf/include/internal/evlist.h |  4 ++--
> >  2 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 058e3ff10f9b..c6d67fc9e57e 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -248,10 +248,10 @@ u64 perf_evlist__read_format(struct perf_evlist *=
evlist)
> >
> >  static void perf_evlist__id_hash(struct perf_evlist *evlist,
> >                                  struct perf_evsel *evsel,
> > -                                int cpu, int thread, u64 id)
> > +                                int cpu_map_idx, int thread, u64 id)
> >  {
> >         int hash;
> > -       struct perf_sample_id *sid =3D SID(evsel, cpu, thread);
> > +       struct perf_sample_id *sid =3D SID(evsel, cpu_map_idx, thread);
> >
> >         sid->id =3D id;
> >         sid->evsel =3D evsel;
> > @@ -269,21 +269,27 @@ void perf_evlist__reset_id_hash(struct perf_evlis=
t *evlist)
> >
> >  void perf_evlist__id_add(struct perf_evlist *evlist,
> >                          struct perf_evsel *evsel,
> > -                        int cpu, int thread, u64 id)
> > +                        int cpu_map_idx, int thread, u64 id)
> >  {
> > -       perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
> > +       if (!SID(evsel, cpu_map_idx, thread))
> > +               return;
> > +
> > +       perf_evlist__id_hash(evlist, evsel, cpu_map_idx, thread, id);
> >         evsel->id[evsel->ids++] =3D id;
> >  }
> >
> >  int perf_evlist__id_add_fd(struct perf_evlist *evlist,
> >                            struct perf_evsel *evsel,
> > -                          int cpu, int thread, int fd)
> > +                          int cpu_map_idx, int thread, int fd)
> >  {
> >         u64 read_data[4] =3D { 0, };
> >         int id_idx =3D 1; /* The first entry is the counter value */
> >         u64 id;
> >         int ret;
> >
> > +       if (!SID(evsel, cpu_map_idx, thread))
> > +               return -1;
> > +
> >         ret =3D ioctl(fd, PERF_EVENT_IOC_ID, &id);
> >         if (!ret)
> >                 goto add;
> > @@ -312,7 +318,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evli=
st,
> >         id =3D read_data[id_idx];
> >
> >  add:
> > -       perf_evlist__id_add(evlist, evsel, cpu, thread, id);
> > +       perf_evlist__id_add(evlist, evsel, cpu_map_idx, thread, id);
> >         return 0;
> >  }
> >
> > diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/=
include/internal/evlist.h
> > index d86ffe8ed483..f43bdb9b6227 100644
> > --- a/tools/lib/perf/include/internal/evlist.h
> > +++ b/tools/lib/perf/include/internal/evlist.h
> > @@ -126,11 +126,11 @@ u64 perf_evlist__read_format(struct perf_evlist *=
evlist);
> >
> >  void perf_evlist__id_add(struct perf_evlist *evlist,
> >                          struct perf_evsel *evsel,
> > -                        int cpu, int thread, u64 id);
> > +                        int cpu_map_idx, int thread, u64 id);
> >
> >  int perf_evlist__id_add_fd(struct perf_evlist *evlist,
> >                            struct perf_evsel *evsel,
> > -                          int cpu, int thread, int fd);
> > +                          int cpu_map_idx, int thread, int fd);
> >
> >  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
> >
> > --
> > 2.44.0.278.ge034bb2e1d-goog
> >
>

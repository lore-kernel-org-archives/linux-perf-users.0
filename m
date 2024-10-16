Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA814A4C3
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090896; cv=none; b=jxIvAkKo53sU1xPBwKkjoNPWE8FUlncE8v1ifpvmFp3S9PJtboov+1rGLqKJCRDqdFe6oiWx5/ECN9eCLLpX+76AVo3QuoH3/Vc4UalgZLdwac6jpeRwMmupSICdpkIcYZp6cRzByZvJdJmexwMFHP3+8ZZvxyquUzDSsotU/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090896; c=relaxed/simple;
	bh=EASiwEmxWbPP4MBvs0Qqi46Q2WwH0kpMvssy5Z3ZXGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKN3SP15mGxsK38b3aaC04XqE8cVq9oa8/gB3P6FB3NLz4bno4zjVLI51CyzfFcEkOW9eNKN0OL3RTSqTnjZsBhBlzGjtfVzzyXCABuBUjumMl+xcn7DlKNIwkEwm+5n2/iVpO7AX+3JYZ/FVz2MSAGvP5/1xVklvUMy4ZV6IRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLakkyj9; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLakkyj9"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b3f4b2afso207965ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729090894; x=1729695694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQVvsP9whDC3OvP/j7HJi3icqyqLv6X4aMvB1K/juvI=;
        b=cLakkyj9mXODgYCXMCGeXV/q06WG/bEgLilAUpe9RvOzBeqSrENqdYHLv2UVecuP5T
         UujG3axDxIjYfOAqyBIFOHvOPEmU7xeq+H5+u7VAUk6LcA53tkk7tbIAxfSaHQuGVqob
         Y0vTf5vLONDlkraBNo2ia8LlEnesr3O6ABmR5rwo5PMH04Lz5wR7Uk8Y3jmh5htlHTKe
         lQXfO0YA9LEuFcjb0hoEXVEzvRniT+HGz1QiWKDwcwf9YDeiLaXDKFZaxVlZgRbm1u0j
         ojUQKVteCIeJ3Gk3sHWgoArhuGQwpreSxyT/RialSqMRV0UlboyUPb6Wvkx3raa3zMyx
         lB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090894; x=1729695694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQVvsP9whDC3OvP/j7HJi3icqyqLv6X4aMvB1K/juvI=;
        b=CZeYsC8vBUN0mPqjEmLucNiwETYfhk3JFIF++M0D7CeKi+AktHGPcDqmVBnBAU6UHO
         HIkh2XXd5jLQ8NrxupYtY0m60ng1hcMozzKM6tBlAPndImk16gIBqOvuaXttuoeEqQDh
         jvym+rerD1UYmYlBKSzrMv3ai+HDy6pc8CjTzZk4snhX5wl5okqboseKfUhA7zFG9Rb+
         jYVF4jF13m72Ku/SbR+U8zh+8itKMkVYbP5aHMG5BTxZuVLY3/ACA05DJ2Bv+BoKdPJI
         APDwG/5msQBpEZGmiZ/w6vhKqNIqaCDOb2+VeDbln0EmCvVrzoihwanPsZqZrEPeoEog
         f5+A==
X-Gm-Message-State: AOJu0YzXD7v2VWNRQl2LOMq2u7oZxvQUn4YDko8gzUjZdrVHvsCZJuDc
	8iuCNftSas1kGMOQ46AZKSNCl25HuVRUz9OYjTKg8isksa8wYU/7IF/MKRH4uvyGL17C8KIGTRz
	P9YsoqYqBGH6K3c+ejnGRc4Xie7MiCvQxC+Ft
X-Google-Smtp-Source: AGHT+IG8anZCN0/CCeRlvUOD0tfeFiLKUrYzimBYJ68aX0PVkL7lXkU78DsRx1E8IprGN+jmlPBGy35HuOo2Szk1TN0=
X-Received: by 2002:a05:6e02:1a66:b0:3a0:b0dc:ac0d with SMTP id
 e9e14a558f8ab-3a3de7d25f4mr2760505ab.27.1729090893261; Wed, 16 Oct 2024
 08:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015145416.583690-1-james.clark@linaro.org>
 <20241015145416.583690-2-james.clark@linaro.org> <CAP-5=fW7aERe3KHtAoYX9UWsVWrhU95RcCgabgP+DNHi1whjsQ@mail.gmail.com>
 <d9a4bebe-dde1-438f-bcf7-70b7a5e21848@linaro.org>
In-Reply-To: <d9a4bebe-dde1-438f-bcf7-70b7a5e21848@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 08:01:21 -0700
Message-ID: <CAP-5=fUi-Y408hZmPosfejOW=SkXZZTTvRm326fBz-9zrHk8ew@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid platform
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:29=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 15/10/2024 4:14 pm, Ian Rogers wrote:
> > On Tue, Oct 15, 2024 at 7:54=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> Since the linked fixes: commit, specifying a CPU on hybrid platforms
> >> results in an error because Perf tries to open an extended type event
> >> on "any" CPU which isn't valid. Extended type events can only be opene=
d
> >> on CPUs that match the type.
> >>
> >> Before (working):
> >>
> >>    $ perf record --cpu 1 -- true
> >>    [ perf record: Woken up 1 times to write data ]
> >>    [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
> >>
> >> After (not working):
> >>
> >>    $ perf record -C 1 -- true
> >>    WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' =
(CPUs 16-27) for event 'cycles:P'
> >>    Error:
> >>    The sys_perf_event_open() syscall returned with 22 (Invalid argumen=
t) for event (cpu_atom/cycles:P/).
> >>    /bin/dmesg | grep -i perf may provide additional information.
> >>
> >> (Ignore the warning message, that's expected and not particularly
> >> relevant to this issue).
> >>
> >> This is because perf_cpu_map__intersect() of the user specified CPU (1=
)
> >> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
> >> CPU map. However for the purposes of opening an event, libperf convert=
s
> >> empty CPU maps into an any CPU (-1) which the kernel rejects.
> >
> > Ugh. The cpumap API tries its best to confuse NULL =3D=3D empty but emp=
ty
> > can give you dummy, dummy is also known as 'any' or -1, 'any' sounds a
> > lot like 'all' but sometimes 'all' is only online CPUs. I tried to
> > tidy up the naming a while ago, but there is still a mess.
> >
>
> I don't know if you think this is a good opportunity for me to have a go
> at finishing separating those? Or is it a dead end?

So cpumap (and threadmap) underpin a lot of things, we also used to
routinely confuse CPU numbers with cpumap indices that are used to
densely index xyarrays with file descriptors, etc. My thought was that
we may end up doing a proper Rust libperf that can be under a more
permissive license like libbpf - currently libperf is a source of GPL
infection. The rewrite would be a good time to clear these things up.
I believe someone at RedHat has looked at doing a Rust libperf.

> >> Fix it by deleting evsels with empty CPU maps in the specific case whe=
re
> >> user requested CPU maps are evaluated.
> >
> > If we delete evsels than the indices can be broken for certain things.
> > I'm guessing asan testing is clean but the large number of side data
> > structures that are indexed by things in another data structure makes
> > the whole code base brittle and I am nervous around this change.
> >
> >> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" event=
s")
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks,
> > Ian
> >
>
> Ok if we're not completely opposed to doing it this way I will dig a bit
> more and double check everything is working.

I think it is okay to do it this way (hence the reviewed-by tag) as
propagate maps should happen before the xyarrays are set up, it'd be
nice if these things were checked at runtime, or by the compiler...

Thanks,
Ian

> >> ---
> >>   tools/lib/perf/evlist.c | 11 +++++++++--
> >>   1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> >> index c6d67fc9e57e..8fae9a157a91 100644
> >> --- a/tools/lib/perf/evlist.c
> >> +++ b/tools/lib/perf/evlist.c
> >> @@ -47,6 +47,13 @@ static void __perf_evlist__propagate_maps(struct pe=
rf_evlist *evlist,
> >>                   */
> >>                  perf_cpu_map__put(evsel->cpus);
> >>                  evsel->cpus =3D perf_cpu_map__intersect(evlist->user_=
requested_cpus, evsel->own_cpus);
> >> +
> >> +               /*
> >> +                * Empty cpu lists would eventually get opened as "any=
" so remove
> >> +                * genuinely empty ones before they're opened in the w=
rong place.
> >> +                */
> >> +               if (perf_cpu_map__is_empty(evsel->cpus))
> >> +                       perf_evlist__remove(evlist, evsel);
> >>          } else if (!evsel->own_cpus || evlist->has_user_cpus ||
> >>                  (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(ev=
list->user_requested_cpus))) {
> >>                  /*
> >> @@ -80,11 +87,11 @@ static void __perf_evlist__propagate_maps(struct p=
erf_evlist *evlist,
> >>
> >>   static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
> >>   {
> >> -       struct perf_evsel *evsel;
> >> +       struct perf_evsel *evsel, *n;
> >>
> >>          evlist->needs_map_propagation =3D true;
> >>
> >> -       perf_evlist__for_each_evsel(evlist, evsel)
> >> +       list_for_each_entry_safe(evsel, n, &evlist->entries, node)
> >>                  __perf_evlist__propagate_maps(evlist, evsel);
> >>   }
> >>
> >> --
> >> 2.34.1
> >>
>

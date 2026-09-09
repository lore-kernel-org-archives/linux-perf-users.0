Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305B33E355
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 06:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788934644; cv=pass; b=ORysY7slgKHzbVm9E9VPMNBRwJqvS2lss/Y60qQDboI1z76RpJJOTN9xDvqsdVrJ8j3rlp7yOoGgJw3mGVadBqCGVbMtArMXCvPlUv0usDiSJRwm3kYyNu/UYzDXenMswdw5q9UU2ILMXj2e9C0V8f2De0gDn9bMFkJMQnfKfw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788934644; c=relaxed/simple;
	bh=GGaEL2aW5Fv82ncM9r7KrInU490KfJ3J4TSlMpvc4Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YspezLou4AA2SL+TRzkvTWwVDPRk4nRU0kMY51JcVZrIBkJ/epbJ0E6pnmn7QdDSzT20WuWdXBerPy6GMe+N0IBSo+y0BjPsCzwaoynLK+QWmvRFAa+hgM8/BZjCuQ19aB49D8cs7prfcBXkdP8SivPKte5H9u+nZFUeG8ldJuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NYHVDZS1; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NYHVDZS1"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso4368320e0c.2
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 23:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788934642; cv=none;
        d=google.com; s=arc-20260327;
        b=V4GnXOAZjyddUAZ2sJU98nhJS1Wacv1hB7XzPtuao9ssfMPXyxmo9fTxckbOFkPbyP
         DB78sKxATwg1CiQd4vB7VMAwypma/V6VXQpW8sCyP6Jl1cfJjmZ1ofWYBiOeVz/FdIDi
         MEHWB1kTGMQMmfENF3wsmZIk+8llPD5wZcICLHECFPIO2QhyGLFN00eaEknXVpgA5PDq
         7IkooVb9T4U1rAUXi8ovNRCjM1eEQr3JgqFYH0xBp7Yr4vkPRplWfxEZpwZi79ij7m/E
         lODQfQbo8XU/ygdkpt3Isn/QWtECYmTIDULal5gPclet5GBQJDFyp8RL6KpQb1MzCI/C
         cjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nm4BfrAEtjLGzfVjtOEoKFNZWUJ+jFHQ/WoObCwKmfc=;
        fh=l5ZZ4SSNAIWgbejVM85u+azZ+KchRBaBhEL2n7nt1XY=;
        b=KtzAWPrmfVAIdlEa2PL5IG2eILw2Y3wBrXunIQcK76X5lgyIlxCWAL2i3CKAkJt1HW
         Oaehe0aLLOYHfLnFs2VXAJ6njsjtQuU7ZFYKGlJlUtUrjjfaRvpgmYy+pKRZV6SFH5x6
         4VOaHAafxPUUAChGuBoikvzohq4F/bAHsjzoWWcsD5OR7Q25REFcAOlBpnHxX7wUNx9p
         nVOj5L4YzHuA3A9Gd+5d4/qIa1SKgFAcr80uOkWW1E+NXuOELd3tSj1gRiThnmaSsDuE
         oweZjKvXYB8IDw9vN7UIeDjrIpHyjbCLwNpCMmHPUYvBSmtkQVaqOraBooYToqbg0qNd
         lIfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788934642; x=1789539442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nm4BfrAEtjLGzfVjtOEoKFNZWUJ+jFHQ/WoObCwKmfc=;
        b=NYHVDZS1GkW/Twgzt+6EyoDYDjK+LnBOl/jY6QmkAnO0b844Kqg8+d3fNhRQVtCYcp
         Z/9N3UdS6AtbzbkL/z3IiebrSCDYFGag2V8Fer8tWXwSatEqaoE7c6ZqRCcPlvwvHPVo
         Zwi5mwqX5v7/OpH1MWhqpX2PBgVJ3BZR6CiaStooBlR3fJX5Y/3BbICUblOcZw9uT4KE
         w+Cbknkt73Pm/tU72K/M/VQHS1iBQV73Xy2LvtRKjdZlnvgNIhEaGO6uNmV2mEaZTYqa
         dGzOhAey5MK0d39n+hr52ivUDk+wW3CpCYLuW9tSwxFnKCbUA3jPxWnF4wYpOfMzTy37
         ppqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788934642; x=1789539442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nm4BfrAEtjLGzfVjtOEoKFNZWUJ+jFHQ/WoObCwKmfc=;
        b=qecJnIFUlMG8wNaZLCHUJrRUmknFBCeySXYGrxTXIMD1Z0qztxOQOOuIOrp+WwyJ+x
         2yKwRW1pzAizvd59/94xuTVxyhGUMOzNi/VXzHgDnsSJOiXDsi/PbfWG8LhUhLA25BgF
         8kVjO4t2sfX45icPKBk/EpNA1qTTw9YDdqsSpaU9NZlstMI37LuhZk64m2jZGJ/PEGAY
         GkDeZroaC14WVkyDuJ3cP5ml1mx5p4oC8zxighHaYt5J/XJl4lxDhMK36jg31hvv9o7e
         fWSKyx1bBGu2AxQvp6Hw/Bx9+AwLJmcjHAiy/US9KawkZodKTYEuFbGXMOqJwGk2lxvJ
         fftg==
X-Forwarded-Encrypted: i=1; AKwUvBwlXpMQw80//nlL+VjzV0U26Wk7BbOdC2QJCzxwpVVhsfjpYJZzmMHHTRNEAVfhfzqoi3SKJwWA5c+ioMlCQ/Ho@vger.kernel.org
X-Gm-Message-State: AFuF++kcPOnPcNnXjGM9iFWswkAsaNkGT1snCt5cSqUM328oD7RZsG7T
	Rnd8lI14hyysnw2foj+QpafWKRUktg3EmNJT3NZP92PubmTwlFU8necOy3ewIojMm6o+t1ZhTFi
	T9daBwAcBVBk/hp8HVerC/KJON3ascdsJ1BUOK4nr7w==
X-Gm-Gg: AYBFou2QosBTG+PnQxQg5cjSeCEVAHRcel+bmLMxh4Pd24O4bxTqGJzsbFqjwa683oZ
	1v+t5nvUqNUp+t7u9rFDeaixgE84oJ4Mk840HsMykS8CVo7mqXh8vBkYVzy5PxUsWKNjXNIK/4S
	+6eFjl1oYrOM6iBG9ZhTWIarKagm/e9YxCkReoeD/nc+zGxG4iS5Znbi2q0+KUnJTmCwt1dMuCF
	4HtQbJVIfOszUywhSQ5hm7xH2EFRQJ+1C/hZzy3oxzre9MwvRKfgLhAZGJaa6rMWxNWphm5oTqL
	DtjtizhpqpxUfr19WniZSdHtx5fwvsEXEV52uL8zk78hWi1tNnniFzH8NQ==
X-Received: by 2002:a05:6122:3406:b0:5c8:2ad4:769f with SMTP id
 71dfb90a1353d-5c82ad491c3mr1978730e0c.8.1788934641645; Tue, 08 Sep 2026
 23:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
 <CAP-5=fX1uKg8AncsP5BVFtchgns5TquOTB10-mR5ury2CaH0sg@mail.gmail.com>
 <CACpYXwATq8nU9mB2SuNO6kAUNrj8bH3UjQiHd5X6=9VX4YZJgA@mail.gmail.com>
 <CAP-5=fVw0+Xh6Xovj_Vt1XnTT8Y0fK-+wia=oxwFmPaT06MTBg@mail.gmail.com>
 <CACpYXwBiF12==Ct1voU-0QcXzMCVqkd3vVJG+4MkYPnZ8rd=WA@mail.gmail.com> <CAP-5=fX7v5bREWoWBEf7vuhpm93XDE1Rfd8tAOZ8oxubtL4GNg@mail.gmail.com>
In-Reply-To: <CAP-5=fX7v5bREWoWBEf7vuhpm93XDE1Rfd8tAOZ8oxubtL4GNg@mail.gmail.com>
From: Nia Su <nia.su@sifive.com>
Date: Wed, 9 Sep 2026 14:17:10 +0800
X-Gm-Features: AcwNN1UNmW2jr2iCJTpcLf6aSJgDN7dDjCyOXTJVr-KLq3b85gYcZdjzMgMbgkQ
Message-ID: <CACpYXwC13hwTGy1vx4yKDcJyzYoTn8HG61wkd48un82Kz8v4hg@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: don't restrict uncore events to PMU CPUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:48=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Sep 8, 2026 at 8:57=E2=80=AFPM Nia Su <nia.su@sifive.com> wrote:
> >
> > On Wed, Sep 9, 2026 at 1:11=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Mon, Sep 7, 2026 at 8:23=E2=80=AFPM Nia Su <nia.su@sifive.com> wro=
te:
> > > >
> > > > On Fri, Sep 4, 2026 at 11:34=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > On Fri, Sep 4, 2026 at 6:45=E2=80=AFAM Nia Su <nia.su@sifive.com>=
 wrote:
> > > > > >
> > > > > > The PMU CPU map has different semantics for core and uncore PMU=
s.
> > > > > >
> > > > > > For core PMUs, pmu_cpus contains the CPUs on which the event ca=
n be
> > > > > > opened. Intersect the user-requested CPU map with the PMU CPU m=
ap to
> > > > > > reject CPUs unsupported by the PMU.
> > > > > >
> > > > > > For uncore PMUs, pmu_cpus is just the default CPU to open the e=
vent on,
> > > > > > not the set of CPUs it can only be opened on.
> > > > >
> > > > > This isn't quite true. On a dual socket Intel machine, `pmu_cpus`=
 will
> > > > > contain a CPU to open the event on per-socket.
> > > >
> > > > Yes, I agree. My description was not precise enough. What I wanted =
to say
> > > > was that pmu_cpus provides the default CPU(s) used to open an event=
. It
> > > > is not necessarily an allowlist. A user may specify another valid C=
PU,
> > > > which the PMU driver can resolve to the appropriate control CPU.
> > > >
> > > > > > The user-requested CPU may
> > > > > > override the default and be used directly, and the driver can r=
edirect
> > > > > > the event to the appropriate control CPU.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > > Currently, __perf_evlist__propagate_maps() intersects the user-=
requested
> > > > > > CPU map with pmu_cpus for all PMUs. If the user-requested CPU i=
s not in
> > > > > > pmu_cpus, the intersection becomes empty and the evsel is remov=
ed before
> > > > > > perf_event_open() is called.
> > > > >
> > > > > Could you give a command line example of the perf tool doing this=
? I
> > > > > ask because I'm surprised the uncore specifying a CPU behavior ha=
s
> > > > > been broken. As well as `perf record -C` there is also a somewhat
> > > > > newer cpu event qualifier.
> > > >
> > > > I tested both approaches, but they still fail whenever a perf event=
 is
> > > > assigned to a CPU outside the uncore PMU's sysfs cpumask. for examp=
le,
> > > > assigning the event to CPU 1 fails when the cpumask is 0:
> > > >
> > > > perf stat -C 1 -e <uncore event> -- <program>
> > > >
> > > > Here, for an uncore PMU, pmu_cpumask() reads the sysfs cpumask into
> > > > pmu->cpus. When the event is created, perf copies pmu->cpus to the
> > > > local pmu_cpus variable and then stores it in evsel->core.pmu_cpus.
> > > > In this case, evsel->core.pmu_cpus is {0}. The CPU specified with
> > > > "-C 1" is stored in evsel->core.cpus as {1}. Then, in this function=
,
> > > > __perf_evlist__propagate_maps() then intersects the two maps, resul=
ting
> > > > in an empty map, so the event is removed before reaching the PMU dr=
iver.
> > > >
> > > > > > Skip the intersection when evsel->requires_cpu is true, which i=
s set for
> > > > > > uncore PMUs. is_pmu_core is also false for other non-core PMUs,=
 so
> > > > > > gating on it would have loosened this check for them too. Core =
PMUs
> > > > > > continue to be restricted to their PMU CPU map.
> > > > > >
> > > > > > requires_cpu can also be set for BPF counters regardless of PMU=
 type,
> > > > > > but only when has_user_cpus is false, so this guard has no effe=
ct there
> > > > > > today.
> > > > >
> > > > > So the separation between libperf and perf is frustrating, and li=
bperf
> > > > > lacks the necessary PMU abstraction. Using requires_cpu as a prox=
y for
> > > > > an uncore PMU test is okay, but it would be better if we had a bo=
olean
> > > > > flag especially for this. Given this, a comment should be added s=
aying
> > > > > that requires_cpu is used as a proxy for an uncore PMU. The real
> > > > > meaning of requires_cpu is that the event doesn't support
> > > > > perf_event_open with a thread.
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > >
> > > > That makes sense. I=E2=80=99ll add a comment clarifying that requir=
es_cpu is used
> > > > as a proxy for uncore PMUs and keep the current approach for now.
> > >
> > > So I think the flag we can use is `evsel->is_pmu_core` which captures
> > > the !uncore behavior. I validated the fixes tag is correct.
> >
> > I did consider using evsel->is_pmu_core, but it is false not only for
> > uncore PMUs,
> > but also for software, breakpoint, tracepoint, and other non-core
> > events. For uncore
> > PMUs, cpumask is stored in pmu->cpus and copied to pmu_cpus; for other =
PMUs
> > without a CPU map, pmu_cpus falls back to the online CPU map.
> >
> > Thus, with perf stat -C <offline_cpu> -e task-clock -- sleep 1,
> > pmu_cpus falls back to
> > the online CPU map while evsel->cpus contains the requested offline
> > CPU. Intersecting
> > the two maps would therefore filter out the offline CPU, which seems
> > reasonable. For
> > this reason, I don=E2=80=99t think this flag is appropriate here. What =
do you think?
>
> I guess we could either add a new bool to perf_evsel or do something like=
:
> ```
> bool is_pmu_uncore =3D !evsel->is_pmu_core && evsel->requires_cpu;
> ```
> it seems this will still be wrong for BPF events that set requires_cpu
> and could do on a software event (from builtin-stat.c):
> ```
>  evlist__for_each_entry(evsel_list, counter) {
> /*
> * Setup BPF counters to require CPUs as any(-1) isn't
> * supported. evlist__create_maps below will propagate this
> * information to the evsels. Note, evsel__is_bperf isn't yet
> * set up, and this change must happen early, so directly use
> * the bpf_counter variable and target information.
> */
> if ((counter->bpf_counter || target.use_bpf) && !target__has_cpu(&target)=
)
> counter->core.requires_cpu =3D true;
> }
> ```
> So I guess the only way to go is a new bool.

I agree that adding a separate flag to identify uncore PMUs is the cleanest
approach. I=E2=80=99ll implement this in the next version.

Thanks,
Nia

> Thanks,
> Ian
>
> > Thanks,
> > Nia
> >
> > > Thanks,
> > > Ian
> > >
> > > > Thanks,
> > > > Nia
> > > >
> > > > > > Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixe=
d with threads/processes")
> > > > > >
> > > > > > Assisted-by: Claude Sonnet 5
> > > > > > Signed-off-by: Nia Su <nia.su@sifive.com>
> > > > > > ---
> > > > > >  tools/lib/perf/evlist.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > > > > > index 1f210dadd666ff818a23712ab95acaa659ccf8dc..a1064175f12ba65=
5a9f7fe42e7c7e4c49ae60423 100644
> > > > > > --- a/tools/lib/perf/evlist.c
> > > > > > +++ b/tools/lib/perf/evlist.c
> > > > > > @@ -80,7 +80,8 @@ static void __perf_evlist__propagate_maps(str=
uct perf_evlist *evlist,
> > > > > >         }
> > > > > >
> > > > > >         /* Ensure cpus only references valid PMU CPUs. */
> > > > > > -       if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > > > > > +       if (!evsel->requires_cpu &&
> > > > > > +           !perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > > > > >             !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cp=
us)) {
> > > > > >                 struct perf_cpu_map *tmp =3D perf_cpu_map__inte=
rsect(evsel->pmu_cpus, evsel->cpus);
> > > > > >
> > > > > >
> > > > > > ---
> > > > > > base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
> > > > > > change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
> > > > > >
> > > > > > --
> > > > > >
> >

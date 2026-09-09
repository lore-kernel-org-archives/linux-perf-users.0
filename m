Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B6492E53
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926274; cv=pass; b=jyXHSgDg7O2nMoAdF4pXEU+rRWtNgqSYz52CXXKSvf+go2u2c8ZPiUuxYjIxCIO8RvT56VHsdq/j1H8PnxfeZ+HwKNBldDKm4H5Bf7U5vD+QjoDOLexhkCtfKTfx3VJpvGtckKP2Yl9vP7266ByvGo8fqKFvVGRI9mG9+z2W0+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926274; c=relaxed/simple;
	bh=7xxtT/FL6qpKYeNTfwtqCOBrCCkAL1A25OTh5eI51tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2MP4pUwSsQFYKeBoy0jrvCovmDhRZstRBxNmuVOF43Z0d49Bi6Ru5oMRVCl38or7rnsLdJoG5QulH335C9yl15rFEewr4gSLrvwlb+wu0su9sYiAmFojw7Iqi0BZsA4wS1pgk/S8T4KGzTXNe0cZIIxevSk0oxdvKiH8wN6uGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ShXRUIwG; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ShXRUIwG"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bfc54558d5so6972500e0c.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 20:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788926271; cv=none;
        d=google.com; s=arc-20260327;
        b=g+80ietCg/YuopolrV6uxpEylA2Ew4GGoQmuOsSEFI87a0ya8RTyyxh1flXTmnLAfr
         YyvGUVdMHawL5vvfNL+lI1+3zZH7sKzU1cIqXDiOM+Q0A/8SG0vENDgZZiH5fAxsC3lV
         Xi9On8RwX5kA/9mfKDH0YvVmG5JFjp9CYbEjIbGPG9JkkR5FVJOl44+ImU+hSD5pq1VY
         q4gsaHuYQ77a56BpBhcUJ5ivdL/zqfhmi2n9p7xPIycsGRU/AE/nnmpnfogSfh5XBtb9
         PML2PiyHl/i8MIJ952eMJGOapL2YupQSd4PoOzo2ZvRzBmXXDytHUGRscSGBOpONRVuL
         3REQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kH0tSRloKBsA9qiF3oHk70jTIj3t7dVydxj2ubMusk=;
        fh=KnuV+fUt0Cxwta8CzjyFtHaZm+x/Vf9VzFPnfgkw7tI=;
        b=ON09ScAv8hRYjw2UzGqNGbab45kgXXXX2Laui7If9YGxNNlU0Z41QrPc8Yn1yDa1b2
         DkPDbuPR4Y2o6Ga6CEoqbZlx5ck4oqi3d2hM97oRudrtVqFT+KL7/rgzujl49lWz/15k
         L3FQZsotWGxSV9XDpz3LaJXcZ1Mr6vlYom66iXAfXMH5Lxv+XgMbOtHhMIL6iOwEoHm+
         c7UP49zGdCt5zEEpB+R0hWcFY2S8fEPCZC4r2k1jkwxtZ38stj/mMZD20IeU28djhNmL
         w6y5p6V164oyUpOS2DWrJPG6ymXJXYxmqQpptdamHR3z6EmS77KZeNliu04BD96PJ7Mi
         aqeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788926271; x=1789531071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6kH0tSRloKBsA9qiF3oHk70jTIj3t7dVydxj2ubMusk=;
        b=ShXRUIwGsC0/ed1tzX+hLKW0UIDjQenep3sHTCuPcfqk32qqVt6nF+2i3hRViU+S4S
         WEBP/sS41CSpDeZUSuPe4hwQLzIGqV+sTcQy9IcstXCtTshagCK1Um7BSWyOpkSeaxke
         jtAbEzMvveF/r5W37Kkjl8uj6W1WskJeB7L83R4SFHWcgXXC0F6hPOkwdQcsQBq5NxHV
         y69a/Igt+QZENVfKqyAyL0Gg82CPDc7+DI5xjlihq5FIqQogUE4mvDz5zABooFnKRdCj
         lAgpXj3YVi+asvdgy+FbomQUAC600AWNfQJ+HDXYhab21Xb0/STJIViCJsPe/qpMzCMz
         vh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788926271; x=1789531071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kH0tSRloKBsA9qiF3oHk70jTIj3t7dVydxj2ubMusk=;
        b=scMqawBYkY9MwMncDj58JVifJgcYpJd6MV0/mpwH6gPfAKTw0J3b1kJtX7TagGdsQA
         UZ4nuRIK50oGpFmFfYJT1juEwKuJywZpaphRh2Cr6ZsmeMwXBGD6PLazyEtGvXP0py4a
         kZRZz9Q1rdcXN7bIXsWy9moZEWzxnqU1+yCXr/SQLN9eO9o8tv9+yg3ygW7ANs8AMmx+
         zWGo4qCu4wR3Wc4GLRV0lyhe61Oj8JsIEK+I+96Fg90pUkI8/afyP3pq5R47kW7BRZib
         r5WZGPov3Mcj1eQ5Rf2fUKzMccDKxPJedw8GwCzhrKVPjg2QN+O39k5ZabZXEK6GqeqA
         kY4A==
X-Forwarded-Encrypted: i=1; AKwUvByuM6wl4b5cdyldQ4JQD5ZLWit2Y7DVELTRH+C3gzzxSkUmKB2peBjwPsdH3jTtqN0u8RW91PKhMZ1Hh/NXLW4F@vger.kernel.org
X-Gm-Message-State: AFuF++m73mZ9WNMYRwSf2f999gWHJt3b5q4Y4Mwn2CgPoWRUV7FFqOc3
	UZSWhBh/zjH3IJM7KNKJKg91PtkhuK8JBX2tkbuBSuvHyWhCV6olpfFa/KVN9qVK7BM1K/smqHZ
	6twNc0kU0bf/qbVrEoqHrvP9fjzsJiAvAzdSM4zIVMw==
X-Gm-Gg: AYBFou3hWAx5fHtJaHDPY1T82gOWHs3OWrUlIx7okZSrisZuhqK/WAmCkizZfX3+twx
	0/Pt/4Fw6G6YKbp0+To/fWf/KiozwASTNwpnZ8kpS0+SftgC+mLqIhKU84NKyMp841MTAGIW6vj
	qJhthR9/3dqkpgp5aaImNbyEI6oO2ek1fi4CjSY4ENk94BSHhF7XpV7cSLJdPQq3DMdmtImQi7o
	3nFjboU4bPhc8xojqotS3nPyesMvxpxH6LA/8miU1cNj/QfEPVEq5CLppTZU2TW2nSdY5zxPOxl
	bhiqNyC66TUgFp4s1S660k1DIrv/InnEXpNdNhcvfeKmv7m6IlfpIPpCog==
X-Received: by 2002:a05:6123:4204:20b0:5bf:6dd0:36d with SMTP id
 71dfb90a1353d-5c7dcf768e3mr8710710e0c.8.1788926266507; Tue, 08 Sep 2026
 20:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com>
 <CAP-5=fX1uKg8AncsP5BVFtchgns5TquOTB10-mR5ury2CaH0sg@mail.gmail.com>
 <CACpYXwATq8nU9mB2SuNO6kAUNrj8bH3UjQiHd5X6=9VX4YZJgA@mail.gmail.com> <CAP-5=fVw0+Xh6Xovj_Vt1XnTT8Y0fK-+wia=oxwFmPaT06MTBg@mail.gmail.com>
In-Reply-To: <CAP-5=fVw0+Xh6Xovj_Vt1XnTT8Y0fK-+wia=oxwFmPaT06MTBg@mail.gmail.com>
From: Nia Su <nia.su@sifive.com>
Date: Wed, 9 Sep 2026 11:57:35 +0800
X-Gm-Features: AcwNN1V-pmoH-l-Gdzi-F_XGEUOx1dfZ1iZtFNeHFPHBZclF60TC6XrjBJcvGDY
Message-ID: <CACpYXwBiF12==Ct1voU-0QcXzMCVqkd3vVJG+4MkYPnZ8rd=WA@mail.gmail.com>
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

On Wed, Sep 9, 2026 at 1:11=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Mon, Sep 7, 2026 at 8:23=E2=80=AFPM Nia Su <nia.su@sifive.com> wrote:
> >
> > On Fri, Sep 4, 2026 at 11:34=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Fri, Sep 4, 2026 at 6:45=E2=80=AFAM Nia Su <nia.su@sifive.com> wro=
te:
> > > >
> > > > The PMU CPU map has different semantics for core and uncore PMUs.
> > > >
> > > > For core PMUs, pmu_cpus contains the CPUs on which the event can be
> > > > opened. Intersect the user-requested CPU map with the PMU CPU map t=
o
> > > > reject CPUs unsupported by the PMU.
> > > >
> > > > For uncore PMUs, pmu_cpus is just the default CPU to open the event=
 on,
> > > > not the set of CPUs it can only be opened on.
> > >
> > > This isn't quite true. On a dual socket Intel machine, `pmu_cpus` wil=
l
> > > contain a CPU to open the event on per-socket.
> >
> > Yes, I agree. My description was not precise enough. What I wanted to s=
ay
> > was that pmu_cpus provides the default CPU(s) used to open an event. It
> > is not necessarily an allowlist. A user may specify another valid CPU,
> > which the PMU driver can resolve to the appropriate control CPU.
> >
> > > > The user-requested CPU may
> > > > override the default and be used directly, and the driver can redir=
ect
> > > > the event to the appropriate control CPU.
> > >
> > > Agreed.
> > >
> > > > Currently, __perf_evlist__propagate_maps() intersects the user-requ=
ested
> > > > CPU map with pmu_cpus for all PMUs. If the user-requested CPU is no=
t in
> > > > pmu_cpus, the intersection becomes empty and the evsel is removed b=
efore
> > > > perf_event_open() is called.
> > >
> > > Could you give a command line example of the perf tool doing this? I
> > > ask because I'm surprised the uncore specifying a CPU behavior has
> > > been broken. As well as `perf record -C` there is also a somewhat
> > > newer cpu event qualifier.
> >
> > I tested both approaches, but they still fail whenever a perf event is
> > assigned to a CPU outside the uncore PMU's sysfs cpumask. for example,
> > assigning the event to CPU 1 fails when the cpumask is 0:
> >
> > perf stat -C 1 -e <uncore event> -- <program>
> >
> > Here, for an uncore PMU, pmu_cpumask() reads the sysfs cpumask into
> > pmu->cpus. When the event is created, perf copies pmu->cpus to the
> > local pmu_cpus variable and then stores it in evsel->core.pmu_cpus.
> > In this case, evsel->core.pmu_cpus is {0}. The CPU specified with
> > "-C 1" is stored in evsel->core.cpus as {1}. Then, in this function,
> > __perf_evlist__propagate_maps() then intersects the two maps, resulting
> > in an empty map, so the event is removed before reaching the PMU driver=
.
> >
> > > > Skip the intersection when evsel->requires_cpu is true, which is se=
t for
> > > > uncore PMUs. is_pmu_core is also false for other non-core PMUs, so
> > > > gating on it would have loosened this check for them too. Core PMUs
> > > > continue to be restricted to their PMU CPU map.
> > > >
> > > > requires_cpu can also be set for BPF counters regardless of PMU typ=
e,
> > > > but only when has_user_cpus is false, so this guard has no effect t=
here
> > > > today.
> > >
> > > So the separation between libperf and perf is frustrating, and libper=
f
> > > lacks the necessary PMU abstraction. Using requires_cpu as a proxy fo=
r
> > > an uncore PMU test is okay, but it would be better if we had a boolea=
n
> > > flag especially for this. Given this, a comment should be added sayin=
g
> > > that requires_cpu is used as a proxy for an uncore PMU. The real
> > > meaning of requires_cpu is that the event doesn't support
> > > perf_event_open with a thread.
> > >
> > > Thanks,
> > > Ian
> >
> > That makes sense. I=E2=80=99ll add a comment clarifying that requires_c=
pu is used
> > as a proxy for uncore PMUs and keep the current approach for now.
>
> So I think the flag we can use is `evsel->is_pmu_core` which captures
> the !uncore behavior. I validated the fixes tag is correct.

I did consider using evsel->is_pmu_core, but it is false not only for
uncore PMUs,
but also for software, breakpoint, tracepoint, and other non-core
events. For uncore
PMUs, cpumask is stored in pmu->cpus and copied to pmu_cpus; for other PMUs
without a CPU map, pmu_cpus falls back to the online CPU map.

Thus, with perf stat -C <offline_cpu> -e task-clock -- sleep 1,
pmu_cpus falls back to
the online CPU map while evsel->cpus contains the requested offline
CPU. Intersecting
the two maps would therefore filter out the offline CPU, which seems
reasonable. For
this reason, I don=E2=80=99t think this flag is appropriate here. What do y=
ou think?

Thanks,
Nia

> Thanks,
> Ian
>
> > Thanks,
> > Nia
> >
> > > > Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed wi=
th threads/processes")
> > > >
> > > > Assisted-by: Claude Sonnet 5
> > > > Signed-off-by: Nia Su <nia.su@sifive.com>
> > > > ---
> > > >  tools/lib/perf/evlist.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > > > index 1f210dadd666ff818a23712ab95acaa659ccf8dc..a1064175f12ba655a9f=
7fe42e7c7e4c49ae60423 100644
> > > > --- a/tools/lib/perf/evlist.c
> > > > +++ b/tools/lib/perf/evlist.c
> > > > @@ -80,7 +80,8 @@ static void __perf_evlist__propagate_maps(struct =
perf_evlist *evlist,
> > > >         }
> > > >
> > > >         /* Ensure cpus only references valid PMU CPUs. */
> > > > -       if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > > > +       if (!evsel->requires_cpu &&
> > > > +           !perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > > >             !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus))=
 {
> > > >                 struct perf_cpu_map *tmp =3D perf_cpu_map__intersec=
t(evsel->pmu_cpus, evsel->cpus);
> > > >
> > > >
> > > > ---
> > > > base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
> > > > change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
> > > >
> > > > --
> > > >

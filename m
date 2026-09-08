Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0163315D5D
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837831; cv=pass; b=qmywBhfoTKwG+V+ycK8EyqUxr1hBaW7ycCn3hfqGjSGYbKZkekvWpYlCWK/LUqu3lkOwLAbY4IBaKtTD5JZ2M7tk8OqujZsi+WF+9Jrjn/nuMeGcjLvGYwFOTAeT3pO1efIoP9Ly05AaTPUu/WZlqCyC8K2vTV1S8tC7c/6zj0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837831; c=relaxed/simple;
	bh=dTMO8X3fT77XmEvpR17XvUAivp8ra8L8g5UWQFJZhOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOuWxYK78zojEpm3heE5whRARYs2Vd93/Us6LKC4X0SBENm/GI5I2bzft8NcC/XWMaRN1Gtl5Np4xyc/e5ogpbrmIXBltucvIabWV7IhWtzW5Jqu4wUrjb40EbUuT2oJlg1NxhO5wApovyyTJr5xMkA37ld93Q6V+17A06N/wqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UrwV/Fin; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UrwV/Fin"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c675de8e1dso1928353e0c.2
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Sep 2026 20:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788837829; cv=none;
        d=google.com; s=arc-20260327;
        b=EWQU+6rGchpO7Os4DvCLxvmSFWWGQTAeQtE+i1BuEuaxax9wtopytChYznIxlFgD2u
         posyUm5M8yWLLoqlYDZBHyLNpLL+b9Y7eBdx9pQXePoNFMyGEgTyjajN0YzFqUC8pfQV
         mCCQzGtaxqMzY4A1wTT6v5eJb5wj1OWvqctpzCISvMAPCCMgN8brwf7upKnC5udhN8k3
         zcN4OpFkPupsiZrJTQ2Xbb+scfN++YMfjYGLZ/d5raZmbXnbnble8RUD78TXK9kq5Hyw
         C1SHeMPs+BZ3cABlW8Uv1bBh4kqP/8kNcE5oZL752pRejWN7Na19O+cqJfmZkl3NLDug
         QhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I0fH45FSF1qmEZvohhZKdFrZ87HhjLjqiz3LMQvgcYg=;
        fh=KsJUpWo4PT2Bl8snb2wZr7nsPPrvH4nue1myht0AVvI=;
        b=ozF7e7IFdVirCd2+0wsQuGIz4PDkgT+dqylv/pPCdaDOWBtTZ/N7WHZ4/C2JzMyMiO
         mW5VEU/U6AC6V4peRVNnrwbPulcRjZadQw8FYjkm62By8a+RyjciPsRH2LHLAViwbF17
         suz0v4yD3+AwdVzZmvF75K5M5juCa/K9lSfmHmzUEme8h4ueLQ7rNXmEaMFXKS0tIBX8
         ybd6XTfzHf0zDF16VwTtwpF/PGPSeSLGsYcLrWRsIgxdCbDiAis+C4hmCVZdsJE0reTX
         GJXaKISYaGRzY94tIC9Eo+GL7SlUL7Yvx3ieyiEvc1nDPHH6rxbWPUJl4Oo0UXKmYbtz
         Lllg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788837829; x=1789442629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I0fH45FSF1qmEZvohhZKdFrZ87HhjLjqiz3LMQvgcYg=;
        b=UrwV/Fin+k0R9uPha9UjVPDGy/x7c0XSBdLJQpsO4oarfFhjv+wjkZ/ddskMMCuc36
         3II3vW4eRKGUil5hoviIKgA9P9Gw6LeBpzCda0E1RUK2yHvV4UYCzmCb8p1x8BTbsUHg
         OjWFdwSoiM8aEynTURXfT8gqxlAh5rH1uZw157UzTbEaANv9gmKeGYEm+9otP++HDpV/
         nxLfPjnBkYJd9+JepGgD7gJQh+GnmLsgvuBcBqVHc0l3GTSDh10Eh0GxipJiLXZNI4fG
         HhQAfWvxOxCOVSWXa7VRFIvBFCOh0cPLtCtPtIWGzMYfgSpJnIg2/KIsEqnmmPk72z1/
         pHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788837829; x=1789442629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0fH45FSF1qmEZvohhZKdFrZ87HhjLjqiz3LMQvgcYg=;
        b=LXr6zHVcgLllQcBg2O49cB9dtq+O6cHHOF/nS/OcH9laGntP1BmbPyxKGRtapJXgTA
         QjmFvfXYI7umrNCxJDll6coORP+qEmtZY37hDSfj71hC0K6E1EVrMoyuOciwvZCNnF4s
         NplvBFaJry17KQ5JnurSxVnaI3MG8QnBxJnFAwEVNW6GXWPsOybPHoYsy9sSWV2eqVse
         RWh7+xM940q5EqyFuy8sVm0O1MkIkFBt7KsYsFP7YZBDmwrSz+2/971DuVAm6tNjEyQj
         4ICyHm8voeDUEVYcIg7hRcWfS5GGmWB2B+Uk1MSw9S470t4DFot5RcD39omlxKsYTEWf
         CGuw==
X-Forwarded-Encrypted: i=1; AKwUvBxQ7VV7g9+u3oD2dRdyWlKK1ad3DiNraVIoYQalE5b5uLTMlBgLZaPlEbVJsOH2j0wh9cWRYgJgErPa0LbZ27KQ@vger.kernel.org
X-Gm-Message-State: AFuF++lDY7PUDNTxUYXzqeg41DjMYkCtnPdM+gEaVDVSfkQ9THwf0O5u
	ZNQm0mxLwWy0ZjRZLMBv6Ge0faz28qWSWjXzi/+0xRJnj3w4WqLUyZbdEQOxv66J1mW1P6P/Eym
	jnF1XOf77MCjeTG7qdvg9YRCtJ5MSCVr1u+tSODQECQ==
X-Gm-Gg: AYBFou1MmMquBiz9PAhEuJKfTlCDZj+C1Fy81OIfeU/LUTtK/szEBb3CDnIDzA27XQN
	HqS4d9aY3rAkFMMtZ6sQjzVxgKxCF+wkTKAQnWLlVEdYRvuedcgLXOlH6vwnxO2xxnf4is41x+d
	yvRaWAX/68QkZcZ9eU4VcokHgS27GrMX9I43nObJjVkmBs3sku5pUMrn7BnHgRUcFCO93DOZlDj
	sXJtfa3Fqtb1IT9lQFENwzUTC8CJjuauRN+5H2COxrHiSUbvdNo6aEgj6KmCOSAQlfnRLM7WAcU
	imUgFNJmVeZQI6YCcjHsXyB5BydNksryE5Fp06bRYIb3e2skco1qf4dwi7U=
X-Received: by 2002:a05:6122:6092:b0:5ab:26f:49e3 with SMTP id
 71dfb90a1353d-5c7ed3a5771mr12356391e0c.3.1788837828755; Mon, 07 Sep 2026
 20:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-perf-evlist-uncore-cpu-b4-v1-1-604b55c025ee@sifive.com> <CAP-5=fX1uKg8AncsP5BVFtchgns5TquOTB10-mR5ury2CaH0sg@mail.gmail.com>
In-Reply-To: <CAP-5=fX1uKg8AncsP5BVFtchgns5TquOTB10-mR5ury2CaH0sg@mail.gmail.com>
From: Nia Su <nia.su@sifive.com>
Date: Tue, 8 Sep 2026 11:23:37 +0800
X-Gm-Features: AcwNN1VyLxdS-2OztZ5mKyfqMTEwN3FrVqWy9nnLRvD9AyhJB7xiYACdtcqwhGk
Message-ID: <CACpYXwATq8nU9mB2SuNO6kAUNrj8bH3UjQiHd5X6=9VX4YZJgA@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 11:34=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Sep 4, 2026 at 6:45=E2=80=AFAM Nia Su <nia.su@sifive.com> wrote:
> >
> > The PMU CPU map has different semantics for core and uncore PMUs.
> >
> > For core PMUs, pmu_cpus contains the CPUs on which the event can be
> > opened. Intersect the user-requested CPU map with the PMU CPU map to
> > reject CPUs unsupported by the PMU.
> >
> > For uncore PMUs, pmu_cpus is just the default CPU to open the event on,
> > not the set of CPUs it can only be opened on.
>
> This isn't quite true. On a dual socket Intel machine, `pmu_cpus` will
> contain a CPU to open the event on per-socket.

Yes, I agree. My description was not precise enough. What I wanted to say
was that pmu_cpus provides the default CPU(s) used to open an event. It
is not necessarily an allowlist. A user may specify another valid CPU,
which the PMU driver can resolve to the appropriate control CPU.

> > The user-requested CPU may
> > override the default and be used directly, and the driver can redirect
> > the event to the appropriate control CPU.
>
> Agreed.
>
> > Currently, __perf_evlist__propagate_maps() intersects the user-requeste=
d
> > CPU map with pmu_cpus for all PMUs. If the user-requested CPU is not in
> > pmu_cpus, the intersection becomes empty and the evsel is removed befor=
e
> > perf_event_open() is called.
>
> Could you give a command line example of the perf tool doing this? I
> ask because I'm surprised the uncore specifying a CPU behavior has
> been broken. As well as `perf record -C` there is also a somewhat
> newer cpu event qualifier.

I tested both approaches, but they still fail whenever a perf event is
assigned to a CPU outside the uncore PMU's sysfs cpumask. for example,
assigning the event to CPU 1 fails when the cpumask is 0:

perf stat -C 1 -e <uncore event> -- <program>

Here, for an uncore PMU, pmu_cpumask() reads the sysfs cpumask into
pmu->cpus. When the event is created, perf copies pmu->cpus to the
local pmu_cpus variable and then stores it in evsel->core.pmu_cpus.
In this case, evsel->core.pmu_cpus is {0}. The CPU specified with
"-C 1" is stored in evsel->core.cpus as {1}. Then, in this function,
__perf_evlist__propagate_maps() then intersects the two maps, resulting
in an empty map, so the event is removed before reaching the PMU driver.

> > Skip the intersection when evsel->requires_cpu is true, which is set fo=
r
> > uncore PMUs. is_pmu_core is also false for other non-core PMUs, so
> > gating on it would have loosened this check for them too. Core PMUs
> > continue to be restricted to their PMU CPU map.
> >
> > requires_cpu can also be set for BPF counters regardless of PMU type,
> > but only when has_user_cpus is false, so this guard has no effect there
> > today.
>
> So the separation between libperf and perf is frustrating, and libperf
> lacks the necessary PMU abstraction. Using requires_cpu as a proxy for
> an uncore PMU test is okay, but it would be better if we had a boolean
> flag especially for this. Given this, a comment should be added saying
> that requires_cpu is used as a proxy for an uncore PMU. The real
> meaning of requires_cpu is that the event doesn't support
> perf_event_open with a thread.
>
> Thanks,
> Ian

That makes sense. I=E2=80=99ll add a comment clarifying that requires_cpu i=
s used
as a proxy for uncore PMUs and keep the current approach for now.

Thanks,
Nia

> > Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with t=
hreads/processes")
> >
> > Assisted-by: Claude Sonnet 5
> > Signed-off-by: Nia Su <nia.su@sifive.com>
> > ---
> >  tools/lib/perf/evlist.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 1f210dadd666ff818a23712ab95acaa659ccf8dc..a1064175f12ba655a9f7fe4=
2e7c7e4c49ae60423 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -80,7 +80,8 @@ static void __perf_evlist__propagate_maps(struct perf=
_evlist *evlist,
> >         }
> >
> >         /* Ensure cpus only references valid PMU CPUs. */
> > -       if (!perf_cpu_map__has_any_cpu(evsel->cpus) &&
> > +       if (!evsel->requires_cpu &&
> > +           !perf_cpu_map__has_any_cpu(evsel->cpus) &&
> >             !perf_cpu_map__is_subset(evsel->pmu_cpus, evsel->cpus)) {
> >                 struct perf_cpu_map *tmp =3D perf_cpu_map__intersect(ev=
sel->pmu_cpus, evsel->cpus);
> >
> >
> > ---
> > base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558
> > change-id: 20260904-perf-evlist-uncore-cpu-b4-418af0f17c80
> >
> > --
> >

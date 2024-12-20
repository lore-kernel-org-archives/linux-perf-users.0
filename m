Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C2218EB9
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716738; cv=none; b=RxTAdt46QGiQnSH1WorPSoBZPckH3qHbb9Il08KRMlw1ePLolBO+4ZZ6v4exEjhjSXu+i56k5SxYqAHi0kBspsgAjHH+iaZgGSlc25ehEgCX5HASMU+Ru4v1UgBjV8fyV2iXpCVNXaJfpUA64dPyhQBu2XqhfYuqETwWUWwuD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716738; c=relaxed/simple;
	bh=xRj8G4EjlcmKYnpMofuE05vY1j3af20AEdLsymFjdWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq7gSewkZPW8IhiiuvfRaKSHT/2UDjtec7LT0EEnh03KXlOG7YBLhiYDuCkMnoY6cqKg3cHhTscYdRfMnJdn/LxtnElk0mMiczUnkV3Cu+DSa7mdYrf0n0LtLy7A96pQx6U4I7tQJsbDyDfM9pngL4Tny4YkIE6IGaCqAMym38U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yVGH8MES; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yVGH8MES"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so167175ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 09:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734716735; x=1735321535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkcqAcacYqnvyS0wA261MKEN0iedOofRrvEiEcu4Jo8=;
        b=yVGH8MESz4MehdVS3QVHF/HFhUdluMRt9OzlpF1/Id9yCI2s4MXcvR66zzisCowSB5
         xmz53moSrcTTW0WbxkADdBqGseyB+DNSlYeFterYDIozm1BGzvznZZm8H/t8Myg08Tyn
         fyE5C36ifNeMoNPjTW6hr898e/G7B/xkUjxIipYGuewp4wZ+NqxnpKCMyZEDMs3PHCOb
         wD3+1JyBxCw4FII/Ppr19tRwfpY63tu4MENx2y/uCIHhegY4SmxdvFWXWrv4AIl19A2q
         Rz9u5/vrq6oMclKXrruDBRHj1a3m7131/x4uZV+8JUzPZMCCawU3sC3Q8rEgsFp3LZzY
         Hx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734716735; x=1735321535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkcqAcacYqnvyS0wA261MKEN0iedOofRrvEiEcu4Jo8=;
        b=DyArlrL5eROd5waPwO/HUsG2jVsGlIYTY7ylJVyBePRCJQQPSMKdCdL2ngvEsRIwFb
         jBsudyMrCxCWY7QP9z4sCZwqtLtzE3/qnvqnsUvPZ+EI26OJXzwk6KT1HX+ctyR/k0g3
         /WdSPeVOINpHsDgqXkGKfzAzECrxxqAP3Gl39Tls56LBTydZOKzaQCEVSU6A9jMLUpQm
         4C+BTdmB3vHvSN6VDJ7AnfdlMpS7Aop54o0SgpZhIl1B5qAx97mC6ItaXC7iwXZSilWc
         CLlRYF1C1RH5kPps7TWawSrl/rYk9DK3nVrf/166W7rgPpB1Wx8AVZAvLBL1Tpluqj5c
         HQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVRpSscy+ffAL6QI0Avc6s9hpNHk0HV8hRCvjqobDAAxTOMEc+JRRA8pZw0aXjuzFjDxE6l2aNaJhuwf8GCMFXL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6znamsUdCfSds/Mn/QaLINexX3lvTdvDuz5U+nDX/xkQfYkTT
	/4aTZBgZhCBC6dFV+DaLzCvPLT6r8wvlBucgbkz8i3ZAau16lW2S8wAOd+JBTY8s+0Tb2zu5qvJ
	Xb1ODTXCYuhg9P0Beb36+L89CLMfD7jxeYn+m
X-Gm-Gg: ASbGncugJReUnMKNN5IcrRuRCzUPUidxGvQR0n/4KU4z+XBn1wQhXk4YB/kzrEiYwWl
	gnapYPPvW5TkmtLet4ozLiyPEOOGEBR01f+yfBiA=
X-Google-Smtp-Source: AGHT+IFGFZvsVH9e4yHJZau82GW4QZ9dnkmslWvic9jc+oid7kJzUHrCifNkINdulLRyOLSkr41VDqRlAS1OzyUpINw=
X-Received: by 2002:a05:6e02:97:b0:3a7:91c2:c28d with SMTP id
 e9e14a558f8ab-3c2e43f2a30mr4018065ab.28.1734716735123; Fri, 20 Dec 2024
 09:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com> <20241216232459.427642-2-irogers@google.com>
 <855f50a5-f397-4a08-8298-78bd040e5328@linaro.org> <CAP-5=fVeW+XARtWtdR=XX47w-ZznKiGdhxDBy=Le_QTS=R6SQA@mail.gmail.com>
 <Z2Ov2Gy99KOtctPT@google.com> <CAP-5=fUUUZcE8D3q3iNkrym=9g6UQxgfDihC24+1J879fj4kww@mail.gmail.com>
 <Z2SV2A9C6V65YL3x@google.com> <462b0262-305b-4ed2-9c1c-2afeaec8646e@linaro.org>
In-Reply-To: <462b0262-305b-4ed2-9c1c-2afeaec8646e@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Dec 2024 09:45:23 -0800
Message-ID: <CAP-5=fV=aQs7X6ROjDP9x2-Nx0YBdpvEbzXEjur4gGHb-=a_fQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] perf cpumap: If the die_id is missing use socket/physical_package_id
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 2:28=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 19/12/2024 9:53 pm, Namhyung Kim wrote:
> > On Thu, Dec 19, 2024 at 09:20:39AM -0800, Ian Rogers wrote:
> >> On Wed, Dec 18, 2024 at 9:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> >>>
> >>> On Wed, Dec 18, 2024 at 09:42:27AM -0800, Ian Rogers wrote:
> >>>> On Wed, Dec 18, 2024 at 4:04=E2=80=AFAM James Clark <james.clark@lin=
aro.org> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 16/12/2024 11:24 pm, Ian Rogers wrote:
> >>>>>> An error value for a missing die_id may be written into things lik=
e
> >>>>>> the cpu_topology_map. As the topology needs to be fully written ou=
t,
> >>>>>> including the die_id, to allow perf.data file features to be align=
ed
> >>>>>> we can't allow error values to be written out. Instead base the
> >>>>>> missing die_id value off of the socket/physical_package_id assumin=
g
> >>>>>> they correlate 1:1.
> >>>>>>
> >>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>>>>> ---
> >>>>>>    tools/perf/util/cpumap.c | 3 ++-
> >>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> >>>>>> index 27094211edd8..d362272f8466 100644
> >>>>>> --- a/tools/perf/util/cpumap.c
> >>>>>> +++ b/tools/perf/util/cpumap.c
> >>>>>> @@ -283,7 +283,8 @@ int cpu__get_die_id(struct perf_cpu cpu)
> >>>>>>    {
> >>>>>>        int value, ret =3D cpu__get_topology_int(cpu.cpu, "die_id",=
 &value);
> >>>>>>
> >>>>>> -     return ret ?: value;
> >>>>>> +        /* If die_id is missing fallback on using the socket/phys=
ical_package_id. */
> >>>>>> +     return ret || value < 0 ? cpu__get_socket_id(cpu) : value;
> >>>>>>    }
> >>>>>>
> >>>>>>    struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *=
data)
> >>>>>
> >>>>> Hi Ian,
> >>>>>
> >>>>> I sent a fix for the same or a similar problem here [1]. For this o=
ne
> >>>>> I'm not sure why we'd want to use the socket ID for die when it's a=
lways
> >>>>> been 0 for not present. I wonder if this change is mingling two thi=
ngs:
> >>>>> fixing the negative error value appearing and replacing die with so=
cket ID.
> >>>>>
> >>>>> Personally I would prefer to keep the 0 to fix the error value, tha=
t way
> >>>>> nobody gets surprised by the change.
> >>>>>
> >>>>> Also it looks like cpu__get_cluster_id() can suffer from the same i=
ssue,
> >>>>> and if we do it this way we should drop these as they aren't valid =
anymore:
> >>>>>
> >>>>>          /* There is no die_id on legacy system. */
> >>>>>          if (die < 0)
> >>>>>                  die =3D 0;
> >>>>
> >>>> I think this breaks the assumption here:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next=
.git/tree/tools/perf/tests/expr.c?h=3Dperf-tools-next#n244
>  >>>>>> Hmm.. I'm not sure how it worked before.  The code is already
> there and
> >>> it just changed the condition from =3D=3D -1 to < 0, right?
> >>
> >> You'd need to be testing on a multi-socket machine to see the issue.
> >> If you had say a dual socket Ampere chip and the die_id was missing,
> >> does it make sense for there to be two sockets/packages but only 1
> >> die? I think it is best we assume 1 die per socket when the die_id is
> >> missing, and to some crippled extent (because of the s390 workaround)
> >> the expr test is doing the sanity check.
> >
> > AFAICS die ID is always used with socket ID already so I guess it means
> > an ID inside a socket.
> >
> > Thanks,
> > Namhyung
> >
>
> Don't we then need to update has_die_topology() to always return true if
> we're using socket ID as a placeholder? And the #num_dies expression
> should potentially become non-zero for consistency?
>
> Seems like there are two options:
>
>   - Fully support "no die reported"
>    * -errno is saved into the topology header, but it's still converted
>      to 0 for Perf stat aggregation and display
>    * #num_dies =3D=3D 0 as it currently is
>    * Anywhere else die is used it's checked for error values first
>
>   - Replace die with package
>     * #num_dies =3D=3D #num_packages
>     * has_die_topology() =3D=3D true
>     * delete code to display die as 0 in perf stat
>
> With this patch we get somewhere between the two.

Thanks James, I'll try to do a larger cleanup in this area. My purpose
for sending the patches was the unaligned feature fields such as CPU
topology cause data alignment issues in the perf.data file. When these
occur we have builds that turn undefined behavior (such as bad
alignment) into illegal instructions and we see widespread test
regressions. The extended pipe tests in v6.12 did this. So the rough
flow of what I've been going through is:
1) CPU topology has perf.data file alignment issues.
2) aligning the CPU topology breaks "old" perf.data files as the size
of the feature is used to detect whether die_id, etc. are present.
3) I've discovered a latent issue that ARM and S390 aren't exposing
die_id and falling into the "old" perf.data file case.
4) let's write out everything in the CPU topology even on ARM and S390
so that the old file test can be just that, but new files have all the
topology.
5) the CPU topology is a mish-mash of skipped tests and things working
not particularly by design.
6) we need to come up with values for die_id, etc. to fix the topology
but these things aren't well defined. I'm reminded of past discussions
of logical ids (unique per core/die/..) vs the normal ids perf users
which may be duplicated across cores.
Anyway, I'll see what I can do make this have a better API, etc.
inspired from your and Namhyung's feedback.

Thanks,
Ian

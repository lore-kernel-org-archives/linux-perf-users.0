Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E6823C3
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Oct 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976784; cv=none; b=Z+dYV1/7sHBY9pa3sz6ItzVPiFQWxDvlmQDPQARCknUoXiFqz60cBcZsYY5CTSNj4kEpIVpX2bauFCmOMVMMhizNjO+VXSXqD1xZH+8PzLcTUY/8pxaFohVlplct9h4fRPyBcphV6Nsa1su2xv+iEiXXB4g30fJS1xSKEhef4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976784; c=relaxed/simple;
	bh=RZJbOfyM7e12fahmnAiHUC68Ovt/dnzYbqXT6SgIjzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQTIkjG5Aeb0SFYlDO5odhRJ3/cY/Dz0gDT9GIn1Diz5O4l6cwWXbVm0osdfN6kExFzYjeGv8Lv9wPQ0Ui8S4rrIuDkS6AuoHIhKs+wBTQ0lOueRFhBcokS6ak2xVPrCti88hGAcyZ+LQANaIp3ctSdk7mu4U8Go4QcDtR9rBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4G1EAp/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4G1EAp/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b061b7299so10895ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Oct 2024 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727976781; x=1728581581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjHmbsVuMXGlSqQIYz/OeMH+ULn9qyDr6lLVCMiz6bg=;
        b=F4G1EAp/O9oiz+8rTRlTdmrDbvN4UmO0Ds9yPe17vtk8+Ld4j+EBunbnpNYClHxpIk
         YEAOnuYwCn7ReVFneXmOM75N57u9uS1O2+zgIk6VJoEBSAyLiB+sWB//MhyPcVDjc+v1
         FtF56RMfjJLhnDAM27be6vf7RKqBGR4NN4GTdZVurFB2a0d8iBtuv5csBs4nTxS4tQaf
         uK6w/F9F23deRapMOgeLHheEgTtohDO/7z/oRx5FJzFBpZ3+e8tV7WzRbFw9WrZl4T4r
         Z8K0iQXknoqho4kSPZFVY0eFePwdGtVp2qRn3zssSIh4Jc3S3v/KC0nQygTUE+2ZCcJZ
         hF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976781; x=1728581581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjHmbsVuMXGlSqQIYz/OeMH+ULn9qyDr6lLVCMiz6bg=;
        b=fQxuMyeETIyubpIhp7Ap88igs7TutM3mLBD+8/rp/uHBxyck1PnDOyz1nq10brbicg
         lpl/VU/gmOPHpj6q3S1GPoiHHM07ZIsS+o2YKXX4rCz22q+eztyJDku5kDqgResXOEyi
         8u4g4If6AMv7sCw4MlFrayyU13V/kJjvd9Q7tqr4axveuvvDtECnIyx0qDJyHt8VzvYB
         UL/g+iJTgBgJI5p8hPlHXpjWU0uCREE1BATET+uzs6N+d75yBe8omug73nTpvKsMidjg
         1Jgj5PjI82032hJcXM7fQLcTi3zLPWn9cX25vwnBgvkXjO3G+Kj7qeQWNS5KC/v9T8lS
         /GtA==
X-Forwarded-Encrypted: i=1; AJvYcCVQNiEt1b5kkDmN47SlQXv3Nxl+Mk0YFZ1cFjtRfO9loUc2lXXp2K6zR/6K5GCGqyTxsK0xaYWeBg1fRmRaZPMO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bLxvZCmRYw9V/j4XC8DMRYDZnyqdqsWMYNNYUBm/kJR1CaPK
	gzU1ol9QPKKOF3H9xGvadnDXPL0pXxBgdf9NGKniywhst4ET+VTVB3DoTvG7Mn1ASuaqi16Tec+
	V3Mvvijt2jPXCL0O0lwL6u36EFch4c7MFIwZ0
X-Google-Smtp-Source: AGHT+IGbMRb/ZG91Uj0x+3tNfUGF2by9OfDnxzIRAofJodPhmbqt6f04Da9OLsqsAAu0yXY1k6FuuRLZ0FTRcUMgWG0=
X-Received: by 2002:a17:902:e5c9:b0:20b:a2b8:1850 with SMTP id
 d9443c01a7336-20be76298b7mr2902095ad.15.1727976781035; Thu, 03 Oct 2024
 10:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
 <ZvxrQsHML0A1kF1P@google.com> <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
 <Zv7O_XJZcSIS9I_i@google.com>
In-Reply-To: <Zv7O_XJZcSIS9I_i@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Oct 2024 10:32:47 -0700
Message-ID: <CAP-5=fUVLEo0f5ygccnf11J2zdZbFmoGF5UatAb+E8T9vwbeAg@mail.gmail.com>
Subject: Re: [PATCH 7/8] perf tools: Check fallback error and order
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 10:06=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Oct 01, 2024 at 03:21:50PM -0700, Ian Rogers wrote:
> > On Tue, Oct 1, 2024 at 2:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Tue, Oct 01, 2024 at 11:00:20AM -0700, Ian Rogers wrote:
> > > > On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > The perf_event_open might fail due to various reasons, so blindly
> > > > > reducing precise_ip level might not be the best way to deal with =
it.
> > > > >
> > > > > It seems the kernel return -EOPNOTSUPP when PMU doesn't support t=
he
> > > > > given precise level.  Let's try again with the correct error code=
.
> > > > >
> > > > > This caused a problem on AMD, as it stops on precise_ip of 2 for =
IBS but
> > > > > user events with exclude_kernel=3D1 cannot make progress.  Let's =
add the
> > > > > evsel__handle_error_quirks() to this case specially.  I plan to w=
ork on
> > > > > the kernel side to improve this situation but it'd still need som=
e
> > > > > special handling for IBS.
> > > > >
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > ---
> > > > >  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
> > > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > > index 32e30c293d0c6198..ef8356260eea54cd 100644
> > > > > --- a/tools/perf/util/evsel.c
> > > > > +++ b/tools/perf/util/evsel.c
> > > > > @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features=
(struct evsel *evsel)
> > > > >         return false;
> > > > >  }
> > > > >
> > > > > +static bool evsel__handle_error_quirks(struct evsel *evsel, int =
error)
> > > > > +{
> > > > > +       /* AMD IBS doesn't support exclude_kernel, forward it to =
core PMU */
> > > >
> > > > Should the quirk handling be specific to evsels with the IBS PMU gi=
ven
> > > > the comment above? ie this is a PMU specific workaround rather than=
 an
> > > > AMD specific workaround, however, the PMU only exists on AMD :-)
> > > >
> > > > > +       if (error =3D=3D -EINVAL && evsel->precise_max && evsel->=
core.attr.precise_ip &&
> > > > > +           evsel->core.attr.exclude_kernel && x86__is_amd_cpu())=
 {
> > > >
> > > > So here rather than x86__is_amd_cpu it would be
> > > > !strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner to mov=
e
> > > > the logic into pmu.c.
> > >
> > > I guess the problem is that AMD driver does implicit forwarding to IB=
S
> > > if the legacy hardware events have precise_ip.  So it might have just
> > > core pmu (or no pmu) in the evsel.
> >
> > I think the no PMU case should probably have a PMU possibly similar to
> > the tool PMU in:
> > https://lore.kernel.org/all/20240912190341.919229-1-irogers@google.com/
> > But that's not in place yet. You can always use
> > perf_pmus__scan_core(NULL) or
> > perf_pmus__find_by_type(evsel->core.attr.type or PERF_TYPE_RAW).
> > evsel->pmu->is_core && x86__is_amd_cpu() would identify an AMD core
> > PMU whereas the code above could fire for IBS or other PMUs.
>
> But IBS is the only PMU on AMD that provides precise_ip IIRC.  So I
> don't think other events would have it nor have any effect on changing
> the value.  So maybe we can skip the PMU scanning and just drop to 0?

cpu supports precise_ip as it forwards it to IBS, IBS is an ambiguous
term as there are ibs_op and ibs_fetch PMUs. The code is using values
in the attribute to infer the PMU that is being used, it feels it
would be more intention revealing to do things like:
```
if (error =3D=3D ... && perf_pmu__is_ibs_op_or_fetch(evsel->pmu)) ..
```
perhaps to not burden the code this can be:
```
if (...) {
  assert(perf_pmu__is_ibs_op_or_fetch(evsel->pmu));
```

Thanks,
Ian

> >
> > > >
> > > > > +               evsel->core.attr.precise_ip =3D 0;
> > > > > +               pr_debug2_peo("removing precise_ip on AMD\n");
> > > > > +               display_attr(&evsel->core.attr);
> > > > > +               return true;
> > > > > +       }
> > > > > +
> > > > > +       return false;
> > > > > +}
> > > > > +
> > > > >  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_=
map *cpus,
> > > > >                 struct perf_thread_map *threads,
> > > > >                 int start_cpu_map_idx, int end_cpu_map_idx)
> > > > > @@ -2580,9 +2594,6 @@ static int evsel__open_cpu(struct evsel *ev=
sel, struct perf_cpu_map *cpus,
> > > > >         return 0;
> > > > >
> > > > >  try_fallback:
> > > > > -       if (evsel__precise_ip_fallback(evsel))
> > > > > -               goto retry_open;
> > > > > -
> > > > >         if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(=
cpus),
> > > > >                                          idx, threads, thread, er=
r)) {
> > > > >                 /* We just removed 1 thread, so lower the upper n=
threads limit. */
> > > > > @@ -2599,11 +2610,15 @@ static int evsel__open_cpu(struct evsel *=
evsel, struct perf_cpu_map *cpus,
> > > > >         if (err =3D=3D -EMFILE && rlimit__increase_nofile(&set_rl=
imit))
> > > > >                 goto retry_open;
> > > > >
> > > > > -       if (err !=3D -EINVAL || idx > 0 || thread > 0)
> > > > > -               goto out_close;
> > > > > +       if (err =3D=3D -EOPNOTSUPP && evsel__precise_ip_fallback(=
evsel))
> > > > > +               goto retry_open;
> > > > >
> > > > > -       if (evsel__detect_missing_features(evsel))
> > > > > +       if (err =3D=3D -EINVAL && evsel__detect_missing_features(=
evsel))
> > > > >                 goto fallback_missing_features;
> > > > > +
> > > > > +       if (evsel__handle_error_quirks(evsel, err))
> > > > > +               goto retry_open;
> > > > > +
> > > > >  out_close:
> > > > >         if (err)
> > > > >                 threads->err_thread =3D thread;
> > > > > --
> > > > > 2.46.1.824.gd892dcdcdd-goog
> > > > >

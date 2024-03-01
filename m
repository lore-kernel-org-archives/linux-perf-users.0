Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F633207
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254114; cv=none; b=DTF1xenjJ7JQEz+ckoj4VOnX3Q9GqMku5HlAxJK1nIDpD6CBm8cqKJQgzORK2Guk3arjoJW+dPkaQiyKdErqGy4eR8N33PHvT2cQa2hE8KIntTwVZUkh5pz5pxg1qOeeqQZ0DQy34u9SBYcyaua0kN2mtatk3FMksfhWfFGCQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254114; c=relaxed/simple;
	bh=SBRUs1L7SWjgoe78TnGDqNJlwRB1w1wl2d4Ujn1Z/hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEvP8ag0CX+OVjF4ojjR0Cb7+T4qEOy12xBhOKPfguUH7HSQX036PtsH3r5nM0K5mfCgzV3RxsFpEfqyUrygzYhx6DV7v4ME7h9FbI356QBY7hY1KtAtsfNKeNy5joSVQ36uz05ZmzGF0iln2aypvNEQ3Nqtqab3YTM9msFRPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aop4EUGo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aop4EUGo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc744f54d0so86965ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709254109; x=1709858909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO8hdlL58lho+cQ23ggVJcM5manEQk2nVKwT7YU6wv4=;
        b=aop4EUGoBUup4rblaRolTFgeXEYQVcPBzJX8dtP81PRWpwn87EgWdgNPU6hYRYniiF
         lfSc40LfT/1FjqgpAwURskBL6/TXv1OLo4YAWu915HX+B9g5kHOfHKOAOhkY9l2UsSex
         ppejEXlp/Pk/ZyirEjG84iaxaVZgYqsmtUtRV4O7MqsLxbqY7klMlrbiKSqL1hsbu8FD
         MiGUx9mwDmSq02YeTmlq1GUkZUuLLoBGjX+0CeTo+MOogyQG7lY/eSpL/26pvZ4SlgzL
         KsbLUthQQZtp56j10INHUHEQrQ4M3OCymlLR3hDqE6CVDIJs1q3yAD7Tbs6QAmghAoNc
         o2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709254109; x=1709858909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QO8hdlL58lho+cQ23ggVJcM5manEQk2nVKwT7YU6wv4=;
        b=pyFBwz57uels5NzmGs6wwGcpl5s7WyAqs/wIVgaq5U3OmrsOw80oYRAYxEeNqCmKd6
         hnCIZV92hUGR6yHMjquwmNBCe9DhOaN9XE2KJoEiUF2ajuxxLf3M1Xvndi5/kR+AWoLH
         nqFdQBuFI/HnzM13Xh0WWFkbzMUcF43io6LDd8tp/cl8mptzZfVgGN5T0RLiYvRskwYa
         ABKuEmbHe8g4ZFxv5GgnpMslvqbby5dNdgCzYVGaIKHHdEtM/eIWvhplFojUUSnah1EZ
         5PsKiu4vgc6H7u9TaAnoocV8UfVeP9Alppc9icKi17riK+lSMKNmllW5DBlKudFJgeFF
         7w4g==
X-Forwarded-Encrypted: i=1; AJvYcCV9KP1uCW+IvfNDIpA1zTe35ma9x1LcyRyxU3a/y9VJJeG97FHDOlvG3NsJWHgNs6BQmyuWK1HrinYkBD05J1NSYtVmpMSI7H0ZUanH+VihyA==
X-Gm-Message-State: AOJu0YyiY75J5wbhkgFiHcD36WfeMW+brjWeasKUG67+M3Qqo1FuMEQN
	x+zK31+hysaeSUKYVlRQ5bfAaDK7p3dU9NCjXD9Q+UkOlknnvCOc0Ohk6UjdgaVZCa3spQqHhe7
	AJOtIzXg7X79y5kXoqypb+UWuOHK2NwAnt91G
X-Google-Smtp-Source: AGHT+IFFxmOc6k9DBxoJkuk5vhJt6IT+2D7y4mJDPfThzu5EGp+7Q6h6dIcUN8jbDoO6uDvJHzfh91pSkyjFtw56Ilw=
X-Received: by 2002:a17:903:244b:b0:1db:e78f:4ce9 with SMTP id
 l11-20020a170903244b00b001dbe78f4ce9mr83835pls.24.1709254108425; Thu, 29 Feb
 2024 16:48:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com> <20240229001806.4158429-14-irogers@google.com>
 <b1ec1953-2df8-4987-a7d0-4758835b5392@linux.intel.com>
In-Reply-To: <b1ec1953-2df8-4987-a7d0-4758835b5392@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 16:48:17 -0800
Message-ID: <CAP-5=fWHQthKat7SZx6P8CeMpjfsgYgp8=+nxvHBMmMVZF9_vw@mail.gmail.com>
Subject: Re: [PATCH v1 13/20] perf jevents: Add cycles breakdown metric for Intel
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:30=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> > Breakdown cycles to user, kernel and guest.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/intel_metrics.py | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index dae44d296861..fef40969a4b8 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -26,6 +26,23 @@ core_cycles =3D Event("CPU_CLK_UNHALTED.THREAD_P_ANY=
",
> >  smt_cycles =3D Select(core_cycles / 2, Literal("#smt_on"), core_cycles=
)
> >
> >
> > +def Cycles() -> MetricGroup:
> > +  cyc_k =3D Event("cycles:kHh")
> > +  cyc_g =3D Event("cycles:G")
> > +  cyc_u =3D Event("cycles:uH")
> > +  cyc =3D cyc_k + cyc_g + cyc_u
> > +
> > +  return MetricGroup("cycles", [
> > +      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
> > +      Metric("cycles_user", "User cycles as a percentage of all cycles=
",
> > +             d_ratio(cyc_u, cyc), "100%"),
> > +      Metric("cycles_kernel", "Kernel cycles as a percentage of all cy=
cles",
> > +             d_ratio(cyc_k, cyc), "100%"),
> > +      Metric("cycles_guest", "Hypervisor guest cycles as a percentage =
of all cycles",
> > +             d_ratio(cyc_g, cyc), "100%"),
> > +  ], description =3D "cycles breakdown per privilege level (users, ker=
nel, guest)")
> > +
> > +
> >  def Idle() -> Metric:
> >    cyc =3D Event("msr/mperf/")
> >    tsc =3D Event("msr/tsc/")
> > @@ -770,6 +787,7 @@ def IntelLdSt() -> Optional[MetricGroup]:
> >
> >
> >  all_metrics =3D MetricGroup("", [
> > +    Cycles(),
>
> The metric group seem exactly the same on AMD and ARM. Maybe we can have
> tools/perf/pmu-events/common_metrics.py for all the common metrics.

Agreed. I think we can drop cycles in the three sets and then once
then do the common_metrics.py as a follow up.

Thanks,
Ian

> Thanks,
> Kan
>
> >      Idle(),
> >      Rapl(),
> >      Smi(),

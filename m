Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE928C00D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936121; cv=none; b=VDRBG4fAoTyfk41F/clLQFH04EaIXp8kAPATbL0F/sIfPUPwyOxLvFq5MtvkECzRGlDLK2ggD7yGqErLnPcvfxxcNmWPhaGh0bh/s1YqcPzgOWMB+piEDm8C8gD/dwZW8VVsIUz6CPhE3CFJSrM/2XqcEE7bfiqJcSL+WvGm230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936121; c=relaxed/simple;
	bh=0jgaG0UnD4RYPzbpJrP+C6lzU5NmS3WZz+jQE8vDcWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjFQR5RVr6VIPCQUwHnZHtHHasymb/fxFzU+2ASsvGUNUX7nEDy8gJIgIBpFS9c/Rml9YbebuhEmC0hU/aIUiYPK7KM7Dfq7gYH4S9cXa1peM7hVobsMobvgpBsVXvjzUn47AQyWF6kYMSyyumePkmki1pzPbvpz1RzXwaef88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGylAEVa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGylAEVa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2731ff54949so198855ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759936119; x=1760540919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10+A/Wgf9iHzcdJ56ejMI3GBStWLH8FDWnolqzz3WNY=;
        b=fGylAEVa1+rMWFxR8aIYsgd4HAFrEWuTWQ0Durw2Y1lIrlkwPDiCsARBuLbQ4Quvmq
         s1K+Q3smkBZn1xEuATIzNYrD+YaZ2TkedFkMasuYe4nHtX8I9O1xvjUowBYWoJg3uRmg
         f6RFidLAukUwKIFxL8/MixQMj6uQdY+iNwJIcaQSel2MABZ1yLTSAgO7iqfafMc/GSJs
         v3Gs9c/UXjmH9rxUvhUlivTG4fw4m0w6qNDfLgUGeqGRdEqikMcc5RkPJQvhdxbAfVKP
         ZrCvZ2IMDM8ErVCGpzDtyhvnSvRiU+pAOEPyNEU/fwHW3kW2KqcaVz5SuQHStP+LRskr
         X5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936119; x=1760540919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10+A/Wgf9iHzcdJ56ejMI3GBStWLH8FDWnolqzz3WNY=;
        b=qWXyKjIBU3xscFlLbgOSPnl5o6KYCwBxPko1M4HvMH42hhrgMaP1uaXaiFlnoSFdqt
         xGAIC8lbMOLNKTfSFxslZpVDqEr73l2xTy1gKPamKvX0qpdfvS1UTObRSjNOTCn42rJy
         m1pyqm2H467KzclSMFwmDfqA55n5yDsqGXqF0aSf5qjnDl2RiPKZBmlvmqBQx4WKQL9s
         ZpOyb8Y9vpeiJ5sTbgaWs+OrUDfmGyTZMJWs5Mi5wil7/RWPqWc1ELHxM7HfelK8ED34
         ab+141yOLqbp4ymdXAuZrqM5hRqbcTwRimBOc3DpYDTBD7BPW8+7WkkniI8UU2xGO6vn
         G0sw==
X-Forwarded-Encrypted: i=1; AJvYcCW5gltX3JfUnaS1HsmLNLLEFSjI4+Dmfx9mX9Ifby+/MKDf7NDIzuSWAgAtYRldA+oV3LGM4au4qTTFlg9pRai1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5havbMYP4k5cf/hiv5vXAUdhDIjZHulEFMq5wE8Xzrps82GG1
	++aQEtnDtMoOxQYFUlu9f6ZhEYxg/vAqF2cH9+TBNNBFIVotqFGl/f9gq7c0LLHvXpeedr8kwV2
	yawDnIGMjnRbxoq8K60uovUAgDdIn/H8tiYRZhSjN
X-Gm-Gg: ASbGncuEfhP4EM+yBCe7Kagxlbz49un0JZ3i+33lpITbjNxSVaegOqAxiBLdX1sAZ/h
	AmErFKt6cUWXE8EzyspsD0M+Fga5gBJHDWIka70rGnhu6Ig9iDnAqHqsh7KErb09wMHo4iAcr/p
	H+ELGjGEtY31IqrLVeXAeAIbG77fFfmyeJ+SQ1YrWsrZiW76fpIfTbSB5FFE/aH1mXjPte6JR2v
	IE94ykSGK+2KcoarJU4Z3jKjQjtScWBvRcFpLfdWcsJ/wUJ5u5LbNmUo/7bNKXTiWi54DsXcKZj
	8Wk=
X-Google-Smtp-Source: AGHT+IEA5bfAGEnmxgkEpgYbLlFKR6/UnvKbH6owwoQlKj5SmNQgcG1ODYv9uPu3CrB5mPkR3Em57VbOB1dHDQGAg9U=
X-Received: by 2002:a17:903:2408:b0:261:83d2:9d91 with SMTP id
 d9443c01a7336-290276de56cmr5322015ad.15.1759936118954; Wed, 08 Oct 2025
 08:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007185826.3674908-1-irogers@google.com> <aOYUPWbyQv53hrjE@google.com>
In-Reply-To: <aOYUPWbyQv53hrjE@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 08:08:27 -0700
X-Gm-Features: AS18NWBWQqG-RTUR2EkYdMU1qeQqpxuHV0_UrNufBtuGJQoxMeBwbPhE2TZXFrc
Message-ID: <CAP-5=fW946mri4wEKBzR+XYzbfBH_foV8KW+AG6bU=H=byt2_Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf bpf_counter: Fix opening of "any"(-1) CPU events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 12:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Oct 07, 2025 at 11:58:26AM -0700, Ian Rogers wrote:
> > The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
> > wanting to aggregate a count against a CPU, which avoids the need for
> > atomics. Force evsels used for BPF counters to require a CPU when not
> > in system-wide mode so that the "any"(-1) value isn't used during map
> > propagation and evsel's CPU map matches that of the PMU.
> >
> > Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing h=
ybrid")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c     | 12 ++++++++++++
> >  tools/perf/util/bpf_counter.c |  1 +
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 7006f848f87a..7fdc7f273a48 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2797,6 +2797,18 @@ int cmd_stat(int argc, const char **argv)
> >
> >       evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
> >
> > +     if (target.use_bpf && !target.system_wide) {
>
> The target.use_bpf only checks the --bpf-counters option.  But IIUC it's
> possible to use BPF only for selected events with ':b' modifier.  I
> think you need to check each evsel with evsel__is_bperf().
>
> Also system_wide might not be set for -C/--cpu option.  Probably you
> want target__has_cpu() instead of target.system_wide.

Thanks Namhyung, I'll fix in v2.

Ian

> Thanks,
> Namhyung
>
>
> > +             /*
> > +              * Setup BPF counters to require CPUs as any(-1) isn't
> > +              * supported. evlist__create_maps below will propagate th=
is
> > +              * information to the evsels.
> > +              */
> > +             struct evsel *counter;
> > +
> > +             evlist__for_each_entry(evsel_list, counter)
> > +                     counter->core.requires_cpu =3D true;
> > +     }
> > +
> >       if (evlist__create_maps(evsel_list, &target) < 0) {
> >               if (target__has_task(&target)) {
> >                       pr_err("Problems finding threads of monitor\n");
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counte=
r.c
> > index ca5d01b9017d..d3e5933b171b 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -495,6 +495,7 @@ static int bperf_reload_leader_program(struct evsel=
 *evsel, int attr_map_fd,
> >        * following evsel__open_per_cpu call
> >        */
> >       evsel->leader_skel =3D skel;
> > +     assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
> >       evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
> >
> >  out:
> > --
> > 2.51.0.710.ga91ca5db03-goog
> >

Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5940013E8B6
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314839; cv=none; b=HzDHpVLVTnBc9XAjBZ9fA3xz+8uvnN/JVsyCdZXEPUg3VGLppO7S2ZdETcPHp+dX0dIG2x/870a8beOs6euuPg/TlBW/MmAJMpmD3S5o2gUTHHXRO20QMVyruAJ4VszwoQ197C5vWS4gM+qp5Z9PyCwIux4vBv64upSst7HeOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314839; c=relaxed/simple;
	bh=QJ+SUPJoerzZDXdVhiOP0FNkBq9YNy4hHYVqXyKrmgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJJfOElsxsPSF8BJwp8Ob1v3jlDKk+7D2+vPOpIRT1wGDnnjCEEf3TwgfQ+Ch7+JCvmAfMfOmpIl3KwypTowvhn4pHvHSZP5yZtDUZQ6xF4jSPZ2H2qyzFEErVGrgynWpAY7GA4nqqOKuoTuXxwwXkVJkU9Ltq9ta2zhgNYj3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNklWeVo; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNklWeVo"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so125855ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721314835; x=1721919635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiNW0NFwDjnJNbL0EVQWR96cj20wHrygG1T/5zmPgP0=;
        b=eNklWeVoOnEgqnEwoDh9WaW2N1OCFgXPxkoA3+D0rhBaJKpuTb8umSj71MivISj+gV
         ++rDPZSn+4ArG4W1NOC9fK8oL04ouNqvcDGZWDiL6FHFZI9VhDoFyfsbVN6jq97p7L2T
         QojLgx1bMtUgTS7vrzOlgqIu1f03Cm01X0jzVnjylMoPwtdDxrLnh9+OVp+DqXfXm4KE
         RSD9u4oRZW4fLftEgNsO5lC6saxjDL1oe1xQlJb3eAHia+6i+aa4GUZAzG1GdaVi6sP0
         KxsJXZoXwWZoxAz0SdV1XhI9axMVY5lnVF7njbobDlz3nenUYtsm3d64uOzJXnnFNRoF
         MYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314835; x=1721919635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiNW0NFwDjnJNbL0EVQWR96cj20wHrygG1T/5zmPgP0=;
        b=Xx3WEv2uv3ngCAc/AUFpHg2Jsck5/YlUjmuLOhCTYmq2ICovFzsiNYMK7Ey2KZM9ZN
         XwLiKdQ9OKY+GJg+ltQEKp5yPyUZAx9Cvms4mnca9YJ0e4t3smIppP1GF1qwAPubLNJW
         X2KkuRyr4jInQzdMO6f5ENxRt3DQbEhlkDyOcVwTByvp2IA0wzzlQ8xBYpe4sRStGu1G
         EBH42ctHU8uRSRAPg0703jLD13o3yye2MnimQLlk4NFvXI6kXUpir1jcjOIfoBq26zRx
         9pKaNNkaxmhVjEq2Kr8SShtsaAZ2T8lmIBoajkK/788kh76WlCZjmecCKEtHqj1Cu5nr
         mthg==
X-Forwarded-Encrypted: i=1; AJvYcCV4zd/IwL6CU/1YnmMKZK3FBdKTT2BmhY/4t4C9RTWe8hBGP5AURWyRkqYk/3PbWY2TjX6fiiykSTn3ts3+ZCQE8PJfdyp0jg0sVp/kQKIFlg==
X-Gm-Message-State: AOJu0YzMewYNdDGrj0He4dDOjOcD9nQh4f9w+4cfzk/IfCYQfhc2mXYd
	BpCrVhv7hjtk9SXnMdLX5/kxzmmVnNLMoAeOHfaOmbEAOBDSSXavJrdnIliJm2PIpJYPgpcCZGb
	LIFYbPBtMjHgocOLweaA4IQ9ATpfF94wXTFGA
X-Google-Smtp-Source: AGHT+IFINQCdEWxgT1S6A1vaW2Yn/R5VoRcS40pYz3tledGErujD7+oRP4CLPzb45tUKK4BGzSbCl71wBzeHOhQm3H8=
X-Received: by 2002:a05:6e02:160e:b0:376:48d1:1764 with SMTP id
 e9e14a558f8ab-396a0488e89mr2503855ab.17.1721314835044; Thu, 18 Jul 2024
 08:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <94491b9a-bdf4-453a-9191-25bf431957e0@amd.com>
In-Reply-To: <94491b9a-bdf4-453a-9191-25bf431957e0@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 08:00:23 -0700
Message-ID: <CAP-5=fVv9AXJ+6UJgKYyskb7di_o+u1Cqb1iLFjXFDNQeuEzBg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Add support for sysfs event.cpus and cpu event term
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 6:42=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Hello Ian,
>
> On 7/18/2024 6:00 AM, Ian Rogers wrote:
> > The need for a sysfs event.cpus file is discussed here:
> > https://lore.kernel.org/lkml/CAP-5=3DfXXuWchzUK0n5KTH8kamr=3DDQoEni+bUo=
o8f-4j8Y+eMBg@mail.gmail.com/
> > following Dhananjay Ugwekar's work on the RAPL /sys/devices/power PMU.
> > These changes add support for the event.cpus file in sysfs and also a
> > cpu event term allowing events to have differing CPUs. This was added
> > in order to test the parsing and map propagation for the sysfs case.
>
> Tried applying the patchset on top of v6.10, torvalds/master and tip/mast=
er,
> it is failing at patch#2, what is the base commit/branch for this patchse=
t?

Hi Dhanajay,

The latest perf tool work is on the perf-tool-next branch of the
perf-tool-next.git:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/

That said, Kan isn't keen on event.cpus, so  let's have a discussion about =
it.

Thanks,
Ian

> Thanks,
> Dhananjay
>
> >
> > v2: Add support for multiple cpu terms on an event that are
> >     merged. For example, an event of "l1d-misses/cpu=3D4,cpu=3D5/" will
> >     now be opened on both CPU 4 and 5 rather than just CPU 4.
> >
> > Ian Rogers (6):
> >   perf pmu: Merge boolean sysfs event option parsing
> >   perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event
> >   perf pmu: Add support for event.cpus files in sysfs
> >   libperf cpumap: Add ability to create CPU from a single CPU number
> >   perf parse-events: Set is_pmu_core for legacy hardware events
> >   perf parse-events: Add "cpu" term to set the CPU an event is recorded
> >     on
> >
> >  .../sysfs-bus-event_source-devices-events     |  14 ++
> >  tools/lib/perf/cpumap.c                       |  10 ++
> >  tools/lib/perf/include/perf/cpumap.h          |   2 +
> >  tools/perf/Documentation/perf-list.txt        |   9 +
> >  tools/perf/util/evsel_config.h                |   1 +
> >  tools/perf/util/parse-events.c                | 162 ++++++++++++------
> >  tools/perf/util/parse-events.h                |   3 +-
> >  tools/perf/util/parse-events.l                |   1 +
> >  tools/perf/util/pmu.c                         |  92 +++++++---
> >  tools/perf/util/pmu.h                         |   1 +
> >  10 files changed, 221 insertions(+), 74 deletions(-)
> >

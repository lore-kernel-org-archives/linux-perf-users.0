Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA013AD2F
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721426587; cv=none; b=XMNB6dTquDEw2iZSyVFpteXfW1L02spza1HYXIAZ0/BhKxz7oI7oWI8CO8zrVHtmHHjcjOxOynP89MhM1noyqsoRo0yd6rthQHYHM7PZi+GIT+VYdZTXqpk7thnBqSv57fiP5kADXw1WCH+KvGAoDOhL4VF3dX9NLPjL8EN2/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721426587; c=relaxed/simple;
	bh=JByw5s8K/cWAC76Hsxlt0Kxe2R0e3zmjjg/O0j5ub9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji+C8U5ElNSoi5f/mF++7UZiLiv4FzW34lRHVRDTwzi8lbAEnJU2oIyRVG+zCszFHWfhE/sdXgsYQJ5dkas510Y0XVDMTfr1kfFFXU+12JHQ1gXNBKrVAhzKtS91cekOJFqK4F6aT8/bto/lR7+ctElTNpDs9itjbr7Ob36BSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTU1JHHx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTU1JHHx"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44f9d7cb5c5so297801cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721426585; x=1722031385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JByw5s8K/cWAC76Hsxlt0Kxe2R0e3zmjjg/O0j5ub9c=;
        b=CTU1JHHxP4XUNQTF17kfDxPQn8Xmvbt9uH91H6npLeWPK7mj0fAXeRAkdqlQgYbPNT
         j6EAYTrb2mQQCGI2xTJqV9KLS9Y5xYdB7ylgc9TjcqPaEANwPbs5JmV3Jnzp0RU8c48b
         ++t0AA/m2TOD3WplcFZRGEXprSVWShvwO79x1HFma10jb/NglZDzr8OVgagcsJlwJ5k3
         oQLpgxyDt642iggL3th2OTbEl9+9VU3mBSR7kfVlO7qFJ1+PQliNQC1q4x0imqpiBfnq
         fII5s6RWktEiUy2t1c8neLhETFsXC9mh48SmKu+S1GI/vBz6a4eO5hstMFI1uVQ+sI/z
         3v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721426585; x=1722031385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JByw5s8K/cWAC76Hsxlt0Kxe2R0e3zmjjg/O0j5ub9c=;
        b=ClZRShG3OAZP88jsp966wCXKmKNaGaJ+iPR9vttllEnb6oW0q1+GfqPAotJODpQG9x
         B6S6I6Mu7r/xkTuoImlDinRG+/mRi/cT3l81ud8ZVOCNj9z6x3snfMGNpaMm77BosSsO
         wcjc4HHVe5HMP1RRDR+rRYkJ5k415OdNxtDDQ/1IdeMx6v1p5uDDu36MpLL8hwcSPQMd
         N+ONjJRoe4bhXEMZxKTnpIlG1iZvvhQsstwillrRYbqbewZUuLa5VuJtuuZbbNV3U1D6
         MzDFgb6RM7+4rpZtMLDLIphxyaTzShjbb0F4uzlpVaWZTAw0Y7r+adYvDtlzTkJbgiyd
         mscw==
X-Forwarded-Encrypted: i=1; AJvYcCX4s2nxlUyFQEz5B8gnVLuTiDkTWAz0pYVNWgQy67HztDVDah9vFTGTW7pc4eUKALVVbYp9nEr4+U6J94HGAV8lw8sjHnz6FPtRKtnIkQwN3Q==
X-Gm-Message-State: AOJu0Yw+3cheouA2ehsSAfhdXST/A0Rj3gcbvm/StgYtfasqPC8pn9VE
	fsoPI4LxeqNQFCHLitYbqvFvc77LZ8scDHqQetAy5ivnhWc7VtK9TOvl2nBvISZEwnK1aZwzuBz
	G6ERS8GOB9yBlvshv9yAx+2IaOdyjN+Ykui24
X-Google-Smtp-Source: AGHT+IEfK5LocCBUXCh6zVAlHy6G9SzrVS1ZPrqKOJfXLOASg/ncTZEVhHAigXq8U8GCOkfdva8wNMOsHfNjX1k8VnM=
X-Received: by 2002:ac8:7d83:0:b0:447:ec33:f488 with SMTP id
 d75a77b69052e-44fa7bd3376mr260141cf.4.1721426584595; Fri, 19 Jul 2024
 15:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com> <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com> <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com> <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
 <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com>
In-Reply-To: <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jul 2024 15:02:53 -0700
Message-ID: <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in sysfs
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:35=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
> > Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
> > solely its perf event context, I want to know its core power and
> > package power as a group so I never record one without the other. That
> > grouping wouldn't be possible with 2 PMUs.
>
> For power, to be honest, I don't think it improves anything. It gives
> users a false image that perf can group these counters.
> But the truth is that perf cannot. The power counters are all
> free-running counters. It's impossible to co-schedule them (which
> requires a global mechanism to disable/enable all counters, e.g.,
> GLOBAL_CTRL for core PMU). The kernel still has to read the counters one
> by one while the counters keep running. There are no differences with or
> without a group for the power events.

Ok, so power should copy cstate with _core, _pkg, etc. I agree the
difference is small and I like the idea of being consistent. Do we
want to add "event.cpus" support to the tool anyway for potential
future uses? This would at least avoid problems with newer kernels and
older perf tools were we to find a good use for it.

> > My understanding had been that for core PMUs a "perf stat -C" option
> > would choose the particular CPU to count the event on, for an uncore
> > PMU the -C option would override the cpumask's "default" value. We
> > have code to validate this:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evlist.c?h=3Dperf-tools-next#n2522
> > But it seems now that overriding an uncore PMU's default CPU is
> > ignored.
>
> For the uncore driver, no matter what -C set, it writes the default CPU
> back.
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/arch/x86/events/intel/uncore.c#n760
>
> > If you did:
> > $ perf stat -C 1 -e data_read -a sleep 0.1
> > Then the tool thinks data_read is on CPU1 and will set its thread
> > affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
> > throw away the -C option.
> The perf tool can still read the the counter from CPU1 and no IPIs
> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
>
> Not quite sure, but it seems only the open and close may be impacted and
> silently changed to CPU0.

There's also enable/disable. Andi did the work and there were some
notable gains but likely more on core events. Ultimately it'd be nice
to be opening, closing.. everything in parallel given the calls are
slow and the work is embarrassingly parallel.
It feels like the cpumasks for uncore could still do with some cleanup
wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
tempted to rewrite evlist propagate maps as someone may look at it and
think I believe in what it is doing. The parallel stuff we should grab
Riccardo's past work.

Thanks,
Ian


> Thanks,
> Kan
> >
> >>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapsho=
t)
> >>> files parse correctly and have a corresponding event.
> >>> 3) keep adding opening events on the PMU to a group to make sure that
> >>> when counters are exhausted the perf_event_open fails (I've seen this
> >>> bug on AMD)
> >>> 4) are the values in the type file unique
> >>>
> >>
> >> The rest sounds good to me.
> >
> > Cool. Let me know if you can think of more.
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >

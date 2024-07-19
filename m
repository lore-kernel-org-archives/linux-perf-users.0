Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81117BA1
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401328; cv=none; b=k+WV6y0B5qiZUDPA/CsbftPb4aXXAWF9hjiJHnDUgi22VHQkgBrePR8SzznuV9aPVqdvUWNekV7OanJ8N9g/m+/PdmavU3g4HBEzSxR6wHxHXPRjDGuKzMJb53vdqh+rIL7px9sLh4XwcdZ1SaCk6K+hRDhksPGO9Wt4y1lafGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401328; c=relaxed/simple;
	bh=6feKD/Max3jl/b/lRMm6cPIGSpZCi4RoSPMkciJfpIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BC/2AV6v3IytilVjN8vw7YFb3QGrENJJnvEvKshsisDIU835EiR5IzU3zXytJKU0vqRmo387JM6dijZduXrgJPBj3MnyNEafJIXjUhcT3MXuvD46ymjxiSb7CnKIw0uz3wXqdFEzXc8m45tWB/QZN5Yd8Zzuw/U3buV+n+opD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vioc6Xvm; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vioc6Xvm"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so129825ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721401326; x=1722006126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcgTL/z1Zm3KDKhdMJuoH9ZuHCmTJEIzViKk2HTzpDw=;
        b=vioc6XvmyHcp3mw7/SuPDWtTNcNYIFZuDB6PNIFheoyTi2hsLMMKuFsil/p/e2krWp
         TnZhaE3auAY1omDs4lw7i+/DgCkNSVo2FLeaUG7FYdiUZ+z6RsXkqewYhVR2cyZ6iSud
         PVccVSerQPoaFt3ppJw8xcvoeNsYdBsJYHWbWMxFEbC4glZIzc6VOXg6RZVufKsaIhPd
         65Qqi8bajj+mV0LcAp2zAIZ2U1OaO1J1poUBRqD8RGV+xKSFoP0EYNdVQHbyEf3QBSAI
         FBPX510nzp7lQB94bBm4q/S2z5v8bIDN8EP/eel7vnz/i86+GwOdtPP4tf5PzkO9MDbR
         kCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721401326; x=1722006126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcgTL/z1Zm3KDKhdMJuoH9ZuHCmTJEIzViKk2HTzpDw=;
        b=XqWJW0634FZrPf9e+IkvZhgTkTjDOdrK+fW34Cf1qb3D6SuQ7pJiL+EH05mXVBGhCT
         UUzmflLg5TnoYNZxR2w132Qyi9GklkbJMO9cMvl72Kqhf9DlBLv+5+cif46lxcbqpUbd
         O9on+A49eXOPzB9692oIlrjyjzsVMf57yhBSdqfiU30yibqupuLWwYeqB9OKOVNFDaD8
         QqTFHNxX/+92sbP1ntRwMXgs3JPMsTtHZhfBl4mfG4qXfgazO5i9C4el5ysEkCfE+rQo
         z5Qsue6jjvVh5i1DZ1vC4evkIptvWS6Rv2o+iNEJYXTnVFY+etf5QJHttukNe3fjwD1J
         CZfA==
X-Forwarded-Encrypted: i=1; AJvYcCWwOQmy0wwsAwE1I9YcMco60XobgdlsvLZNXRO5iptMIAFj/2/I1bOdBCC9gFroECddOlRY5YcHsjwpRr9LX4eHfkIHd0QXJMIaxBSOFKcd9w==
X-Gm-Message-State: AOJu0YwVA/DS1anrr1pZlnsYhOoJ5CscFp2hUSf/Qvr48/Ac6ev3Dd1L
	opRuTXtKt+QOas8tLCkT8Qhoj9Zf65+wyWcwxcX40KFu1yQUyWzZXiihEnAgcqBZVtBbxl+Bm8M
	jQeOCfsahXSS2QZ5V7MFHbP1PCVtuSU0E+jWk
X-Google-Smtp-Source: AGHT+IHO08aQiRYer1ryQE1O7NX++thQZRWjktai/inshS6zlL+P83/FSDZvAAjfAQgXuc3LzJk93N4Gu+0qV8dWC4A=
X-Received: by 2002:a05:6e02:156d:b0:375:9e2b:a832 with SMTP id
 e9e14a558f8ab-397e007e7ebmr2302035ab.21.1721401325255; Fri, 19 Jul 2024
 08:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-7-irogers@google.com>
 <febefab7-7351-4bd5-a6cc-a0116248484f@linux.intel.com> <CAP-5=fUUcehu-C=ytHVVixOpeCYoW4oJkkj6p6W=M0HtQ2wrRA@mail.gmail.com>
 <2e76dd74-b702-4401-ade1-fc1fd1ff40ce@linux.intel.com> <CAP-5=fUEo=EC2iS17_2=1i76ACnHV5PCsA36c3q4TAw3QTvwTQ@mail.gmail.com>
 <803b0b0b-6250-4f63-9b80-8982f74b5ef2@linux.intel.com>
In-Reply-To: <803b0b0b-6250-4f63-9b80-8982f74b5ef2@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jul 2024 08:01:52 -0700
Message-ID: <CAP-5=fUvA5Lmk16Zs1B6bj1OLHf9NaHhAzx7yZL9S7JGwmO0uw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] perf parse-events: Add "cpu" term to set the CPU
 an event is recorded on
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

On Fri, Jul 19, 2024 at 7:14=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-18 5:06 p.m., Ian Rogers wrote:
> > On Thu, Jul 18, 2024 at 11:03=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >>
> >>
> >> On 2024-07-18 11:12 a.m., Ian Rogers wrote:
> >>> On Thu, Jul 18, 2024 at 7:41=E2=80=AFAM Liang, Kan <kan.liang@linux.i=
ntel.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> >>>>> The -C option allows the CPUs for a list of events to be specified =
but
> >>>>> its not possible to set the CPU for a single event. Add a term to
> >>>>> allow this. The term isn't a general CPU list due to ',' already be=
ing
> >>>>> a special character in event parsing instead multiple cpu=3D terms =
may
> >>>>> be provided and they will be merged/unioned together.
> >>>>>
> >>>>> An example of mixing different types of events counted on different=
 CPUs:
> >>>>> ```
> >>>>> $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=3D0/,l1d-misses/cpu=
=3D4,cpu=3D5/,inst_retired.any/cpu=3D8/,cycles" -a sleep 0.1
> >>>>>
> >>>>>  Performance counter stats for 'system wide':
> >>>>>
> >>>>> CPU0              368,647      instructions/cpu=3D0/              #=
    0.26  insn per cycle
> >>>>> CPU4        <not counted>      instructions/cpu=3D0/
> >>>>> CPU5        <not counted>      instructions/cpu=3D0/
> >>>>> CPU8        <not counted>      instructions/cpu=3D0/
> >>>>> CPU0        <not counted>      l1d-misses [cpu]
> >>>>> CPU4              203,377      l1d-misses [cpu]
> >>>>> CPU5              138,231      l1d-misses [cpu]
> >>>>> CPU8        <not counted>      l1d-misses [cpu]
> >>>>> CPU0        <not counted>      cpu/cpu=3D8/
> >>>>> CPU4        <not counted>      cpu/cpu=3D8/
> >>>>> CPU5        <not counted>      cpu/cpu=3D8/
> >>>>> CPU8              943,861      cpu/cpu=3D8/
> >>>>> CPU0            1,412,071      cycles
> >>>>> CPU4           20,362,900      cycles
> >>>>> CPU5           10,172,725      cycles
> >>>>> CPU8            2,406,081      cycles
> >>>>>
> >>>>>        0.102925309 seconds time elapsed
> >>>>> ```
> >>>>>
> >>>>> Note, the event name of inst_retired.any is missing, reported as
> >>>>> cpu/cpu=3D8/, as there are unmerged uniquify fixes:
> >>>>> https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@googl=
e.com/
> >>>>>
> >>>>> An example of spreading uncore overhead across two CPUs:
> >>>>> ```
> >>>>> $ perf stat -A -e "data_read/cpu=3D0/,data_write/cpu=3D1/" -a sleep=
 0.1
> >>>>>
> >>>>>  Performance counter stats for 'system wide':
> >>>>>
> >>>>> CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=3D0/
> >>>>> CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=3D0/
> >>>>> CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=3D1/
> >>>>> CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=3D1/
> >>>>> CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=3D1/
> >>>>> CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=3D1/
> >>>>> ```
> >>>>>
> >>>>> Manually fixing the output it should be:
> >>>>> ```
> >>>>> CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,=
cpu=3D0/
> >>>>> CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,=
cpu=3D0/
> >>>>> CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write=
,cpu=3D1/
> >>>>> CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write=
,cpu=3D1/
> >>>>> ```
> >>>>>
> >>>>> That is data_read from 2 PMUs was counted on CPU0 and data_write wa=
s
> >>>>> counted on CPU1.
> >>>>
> >>>> There was an effort to make the counter access from any CPU of the p=
ackage.
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dd6a2f9035bfc27d0e9d78b13635dda9fb017ac01
> >>>>
> >>>> But now it limits the access from specific CPUs. It sounds like a
> >>>> regression.
> >>>
> >>> Thanks Kan, I'm not sure I understand the comment.
> >>
> >> The flag is also applied for the uncore and RAPL.
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/arch/x86/events/intel/uncore.c?&id=3De64cd6f73ff5a7eb4f8f759049ee24a3fe=
55e731
> >>
> >> So specifying a CPU to an uncore event doesn't make sense. If the
> >> current CPU is in the same package as the asked CPU. The kernel will
> >> always choose the current CPU.
> >
> > Ugh, that sounds sub-optimal. If I'm monitoring uncore events with
> > cgroups CPU0 (or the first CPU in a package) is going to be loaded up
> > with all the events and have all of the rdmsr/wrmsrs in its context
> > switch. Perhaps we should warn and say to use BPF events.
> >
> > Is there a way through say ioctls to get the CPU an event is on? That
> > way we could update the `perf stat -A` to accurately report cpus.
> > There's also the issue that the affinity stuff is going to be off.
> >
>
> I don't think there is such ioctl.
>
> Emphasizing the CPU ID for an uncore event seems misleading. The uncore
> only supports per-socket counter, not per-core counter.
> Opening/reading an counter from any CPUs on a package should be identical=
.
> An accurate report of the `perf stat -A` for an uncore should use "S0".

I think it is an "elite" level trick to try to do things like balance
context switch overhead. Putting everything on the first CPU feels
like a scalability issue for cgroup events. BPF events work around it
to some degree, but they are still going to put all the work on CPU0
which could cause performance issues, latency spikes, etc. on it.

Thanks,
Ian

> Thanks,
> Kan
>
> > Thanks,
> > Ian
> >
> >
> >> Thanks,
> >> Kan
> >>> The overhead I was
> >>> thinking of here is more along the lines of cgroup context switches
> >>> (although that isn't in my example). There may be a large number of
> >>> say memory controller events just by having 2 events for each PMU and
> >>> then there are 10s of PMUs. By putting half of the events on 1 CPU an=
d
> >>> half on another, the context switch overhead is shared. That said, th=
e
> >>> counters don't care what cgroup is accessing memory, and users doing
> >>> this are likely making some kind of error.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >

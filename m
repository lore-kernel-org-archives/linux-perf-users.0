Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064F145B30
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336778; cv=none; b=Pic7lMCpleU714MOzNHims2jWMx3wcejIcsS6w/F+s63qBTo0kmZEJKVnNWwuPHnq5mmeLzcMpNEXPSWN6npOAJsgBQFvcxdi1+gAUL0i4q1Ta6h8bRZZC0IXGZI5FIMaGJHyWTDeys8bzHVEjuCW9sZ0RP0CCvlzX6l06ahtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336778; c=relaxed/simple;
	bh=c4krGfAH/staOfE39yvKA+v4arJjaSYUyyHtKzNsG/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoEwZ2iaghznvvGi0F2dw3fWaZVS3lqNm3rsmCx+Nyf3zn9AAsQ7FBrOTUjMBt5AWjUIRhrokRnUR5S6s8X9gsH+JYjci4fj/FWwNasNs0KNK0BFO6ezEfjN+xPY5DUxYmtvHb7Ns0NnyhcKinCCFHtq4RX24AOu+k7XZCMse/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHXr/XIw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHXr/XIw"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44e534a1fbeso26691cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721336776; x=1721941576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP/W/sfwtHsq0wxwgyRIsVMPhib/wKmzgVvYN6o+OWI=;
        b=oHXr/XIwaGO5caSxpWkLBKAnu1LCx3sK0E0LPoe8hCHsv+LVhMi7txdCVYTlNFWgzJ
         D37bQJnnvKJ8Wc/ml5M0i+gtiYvYzDG2zssJfmeJlBtIEar+5vuSL7/fbNdnWGUIsxk/
         CfYjk5jwLENmatiGYIyhwLgS4Lfy94+N6RWJn5TwOnErPzn0h7EAouq8bqBm1HOz06ON
         0MI8jV/0d2kSI7dZxjFDWXJ7Fv+C1AvDbwPJZagAXBQc/MnoyBr3fAh75ztupF9SjPK7
         ZVmR53aoB9kudNrve00R94zzs3aVeXyFcBwFMXhtfM3NOItBSwyRmiWGnJxKe/Yyqt/I
         Eyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336776; x=1721941576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP/W/sfwtHsq0wxwgyRIsVMPhib/wKmzgVvYN6o+OWI=;
        b=KSqqV6SJDdO7x+KGwSEt2jGEYOZsXuYYptt1gR1ceunD72fcKnFGFxSeIH3DzI/msI
         qoFEFcmjc7ZuUAwl51MlKBhqxUQamlIbhzH1OUXuJsnda0UoxU34GnlblWRHSXoDuVSJ
         Th5T21CIgNnSOHfswXwmh5hGc+ONy9YhuFUVcXlYWtlDY30C5wrH4grZp7vU/FKiqygU
         lfhOULw1VbUtcM2DU18NPgt8kU8TWgLUlT0cIiUWRPvKX/6KtLNonxAoi1UlcptT/OHV
         F2hViRt5f9VDxbjyidZ1ka2FVkpgz8So6xLUgrvwHfJXVMWHuwwYnv6+kBEGP3zlPPId
         oQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQUXHUzGotg+H9eN82667BiT8CFGKVw1qmEun7J4ATmYjWwqY4ydPb37RVXGOUSPk3s6eB9uFYNNahHzi0ulMNHrlFKr/5a0TUquN2QKU/pw==
X-Gm-Message-State: AOJu0YwKucABtwI5PuQBULGlzuVC4iHMe3FlEIn3jXDh+c8Gtarr0D1l
	SaSsT2aeJRcCY03sJV8z/btLtPylIZTb1cAb7twRzjsUSgIROxSets0asK/E3SsM030KsOvfGSL
	bkMOYLrZzFpU6Gc1Uuv2tVrceJhTurH4FNUmv
X-Google-Smtp-Source: AGHT+IH5SzxWNcVDsrDgr/N1emJTC5YTHoAI8dCryfxTE0HqtR/NK+ZzGtknpBn3vPIJ6pCZM6ooIEQJUfMTlDbbg5U=
X-Received: by 2002:a05:622a:261b:b0:447:daca:4b25 with SMTP id
 d75a77b69052e-44f9ad592a7mr1002751cf.28.1721336775439; Thu, 18 Jul 2024
 14:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-7-irogers@google.com>
 <febefab7-7351-4bd5-a6cc-a0116248484f@linux.intel.com> <CAP-5=fUUcehu-C=ytHVVixOpeCYoW4oJkkj6p6W=M0HtQ2wrRA@mail.gmail.com>
 <2e76dd74-b702-4401-ade1-fc1fd1ff40ce@linux.intel.com>
In-Reply-To: <2e76dd74-b702-4401-ade1-fc1fd1ff40ce@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 14:06:04 -0700
Message-ID: <CAP-5=fUEo=EC2iS17_2=1i76ACnHV5PCsA36c3q4TAw3QTvwTQ@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 11:03=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2024-07-18 11:12 a.m., Ian Rogers wrote:
> > On Thu, Jul 18, 2024 at 7:41=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> >>> The -C option allows the CPUs for a list of events to be specified bu=
t
> >>> its not possible to set the CPU for a single event. Add a term to
> >>> allow this. The term isn't a general CPU list due to ',' already bein=
g
> >>> a special character in event parsing instead multiple cpu=3D terms ma=
y
> >>> be provided and they will be merged/unioned together.
> >>>
> >>> An example of mixing different types of events counted on different C=
PUs:
> >>> ```
> >>> $ perf stat -A -C 0,4-5,8 -e "instructions/cpu=3D0/,l1d-misses/cpu=3D=
4,cpu=3D5/,inst_retired.any/cpu=3D8/,cycles" -a sleep 0.1
> >>>
> >>>  Performance counter stats for 'system wide':
> >>>
> >>> CPU0              368,647      instructions/cpu=3D0/              #  =
  0.26  insn per cycle
> >>> CPU4        <not counted>      instructions/cpu=3D0/
> >>> CPU5        <not counted>      instructions/cpu=3D0/
> >>> CPU8        <not counted>      instructions/cpu=3D0/
> >>> CPU0        <not counted>      l1d-misses [cpu]
> >>> CPU4              203,377      l1d-misses [cpu]
> >>> CPU5              138,231      l1d-misses [cpu]
> >>> CPU8        <not counted>      l1d-misses [cpu]
> >>> CPU0        <not counted>      cpu/cpu=3D8/
> >>> CPU4        <not counted>      cpu/cpu=3D8/
> >>> CPU5        <not counted>      cpu/cpu=3D8/
> >>> CPU8              943,861      cpu/cpu=3D8/
> >>> CPU0            1,412,071      cycles
> >>> CPU4           20,362,900      cycles
> >>> CPU5           10,172,725      cycles
> >>> CPU8            2,406,081      cycles
> >>>
> >>>        0.102925309 seconds time elapsed
> >>> ```
> >>>
> >>> Note, the event name of inst_retired.any is missing, reported as
> >>> cpu/cpu=3D8/, as there are unmerged uniquify fixes:
> >>> https://lore.kernel.org/lkml/20240510053705.2462258-3-irogers@google.=
com/
> >>>
> >>> An example of spreading uncore overhead across two CPUs:
> >>> ```
> >>> $ perf stat -A -e "data_read/cpu=3D0/,data_write/cpu=3D1/" -a sleep 0=
.1
> >>>
> >>>  Performance counter stats for 'system wide':
> >>>
> >>> CPU0               223.65 MiB  uncore_imc_free_running_0/cpu=3D0/
> >>> CPU0               223.66 MiB  uncore_imc_free_running_1/cpu=3D0/
> >>> CPU0        <not counted> MiB  uncore_imc_free_running_0/cpu=3D1/
> >>> CPU1                 5.78 MiB  uncore_imc_free_running_0/cpu=3D1/
> >>> CPU0        <not counted> MiB  uncore_imc_free_running_1/cpu=3D1/
> >>> CPU1                 5.74 MiB  uncore_imc_free_running_1/cpu=3D1/
> >>> ```
> >>>
> >>> Manually fixing the output it should be:
> >>> ```
> >>> CPU0               223.65 MiB  uncore_imc_free_running_0/data_read,cp=
u=3D0/
> >>> CPU0               223.66 MiB  uncore_imc_free_running_1/data_read,cp=
u=3D0/
> >>> CPU1                 5.78 MiB  uncore_imc_free_running_0/data_write,c=
pu=3D1/
> >>> CPU1                 5.74 MiB  uncore_imc_free_running_1/data_write,c=
pu=3D1/
> >>> ```
> >>>
> >>> That is data_read from 2 PMUs was counted on CPU0 and data_write was
> >>> counted on CPU1.
> >>
> >> There was an effort to make the counter access from any CPU of the pac=
kage.
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Dd6a2f9035bfc27d0e9d78b13635dda9fb017ac01
> >>
> >> But now it limits the access from specific CPUs. It sounds like a
> >> regression.
> >
> > Thanks Kan, I'm not sure I understand the comment.
>
> The flag is also applied for the uncore and RAPL.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/arch/x86/events/intel/uncore.c?&id=3De64cd6f73ff5a7eb4f8f759049ee24a3fe55e=
731
>
> So specifying a CPU to an uncore event doesn't make sense. If the
> current CPU is in the same package as the asked CPU. The kernel will
> always choose the current CPU.

Ugh, that sounds sub-optimal. If I'm monitoring uncore events with
cgroups CPU0 (or the first CPU in a package) is going to be loaded up
with all the events and have all of the rdmsr/wrmsrs in its context
switch. Perhaps we should warn and say to use BPF events.

Is there a way through say ioctls to get the CPU an event is on? That
way we could update the `perf stat -A` to accurately report cpus.
There's also the issue that the affinity stuff is going to be off.

Thanks,
Ian


> Thanks,
> Kan
> > The overhead I was
> > thinking of here is more along the lines of cgroup context switches
> > (although that isn't in my example). There may be a large number of
> > say memory controller events just by having 2 events for each PMU and
> > then there are 10s of PMUs. By putting half of the events on 1 CPU and
> > half on another, the context switch overhead is shared. That said, the
> > counters don't care what cgroup is accessing memory, and users doing
> > this are likely making some kind of error.
> >
> > Thanks,
> > Ian
> >

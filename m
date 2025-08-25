Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41C1C5D59
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156446; cv=none; b=CrAj2O8Iw8Aq2k8ZD1Gnb4iPaWnwtCrdrW2EqkSDvy7CoJoXBsdoOWfFDzQIVPPCJ5i36/OCXb2f/lqHq8//tgAfUhEGtIh71eQiVQV163C3uIsJsQTqClP4M2p1fVqbrZ0sE52gDSVDtHqFhYjIPpdw5o+/xdP5lsPP3Zb9UgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156446; c=relaxed/simple;
	bh=OunSMzG6M+OWeAHC5TCosWg9CID7soSfxhJJlPZDaWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If+m6bUXk18x3aY3+NpGxyUFg1b9TWUOVzgO9QDSZP9NWlpAa0ba/aWqRBIFKe0OaostmQcJ1jCmTvlKnBnyS4cv77XGRXGhDczozorZ2siPfFnWM+PUBfj0R6TVScCpNbJVAVrxmIPq0gDYtdiA38qV1IUXz+StpVGggjx8+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mi+jdlk1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mi+jdlk1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24611734e50so21725ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 14:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756156444; x=1756761244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRjbULnpYRa//Pe9Knn+rQauoxH2tOU3q+LQp9/G0ZI=;
        b=Mi+jdlk1p2EwY2M69jKauOFaY5kqpVHsev8znvs+i1ZDDtwblwI8gBaj0t/GtFRPqY
         ECMykNPhfh3g2cgusdvA4xoSqt58ELPZ2NKTR362UP4R3pTKEJIB5V8XKTxChusyuiTS
         GVpSeIgrUprdHpDLleIqMkk7/YHctSvKxekJKplJmuJpuGwVaVRDOz/YjO2cR6C2qtua
         kpHn+V7qACO3ewxIXDMccld8KvPo2jV7HEG9kCcQ3URtcubVnl7cPYOvTTmAYY7GHWKK
         ER80U+CjCbesWDyRxxbsPOsCqt1vgkivD2xniYnpmTlUYd54b88knkK8dJAA1Q6xjdsk
         ce1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156444; x=1756761244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRjbULnpYRa//Pe9Knn+rQauoxH2tOU3q+LQp9/G0ZI=;
        b=ufgxtl88PJhV9ZYx66MwSxgofrmT5KZNiuQYYgjRW903tnuWwcDGtZeFkVHmZcxPna
         OtTXm1aUMfMjWCAsj6JfBu/sISG36UWIDYFFVsM6Q20APs3xTAjr77OzM9dT6juimQ4E
         p5cjJ+e2P4L4KcEQa4h9Thxqu8oCDugN10qa6cdi1Cd6qW9uSzs4u0yv/BFIIDw6vIfR
         LEVE6xrWVX1hh8nRzBmNtLE/wBZ/xDF5O8IaFk//dFaHfOubFd72LOLX3t0wwsCp2tRQ
         12EIgjtK9YPE8109qK5o7Qdq1tWAVn0vb1wSwz8HNs1DSd06fUebOx89tCtLq8IYxXF/
         sdhA==
X-Forwarded-Encrypted: i=1; AJvYcCWb7wML7pPwFHD/6UaGh/bbE8oEQvs7O44z62YPI+JGcmOEvOZunaQN02vOXradIbAkxv9IV1Gi3r9yxAJULYuD@vger.kernel.org
X-Gm-Message-State: AOJu0YzDRD4MUoGyN187N6MV2e/GRCW2RPcult21r6rGmUnfj+3BRork
	dxhYWr2ufa8YRuGO7Q44R8LBWiAyg2+L0juTxckPHedr5XfC7pymH0NjVg2fpkudM1V3Wn9BUz4
	1ukZ3MkJl2En0F+AvgAlY1AbXDsS5QNmQPWMFAh9g
X-Gm-Gg: ASbGncunT/7rd0g48u55TMPnjcZ1/fipoCOFLWVWIYU1O4LOme+6mxv8Mh4R+tTxRHs
	bwcDqYW0vKbxuGAmLyFa89Yc3vNHHNpPzpHo6G3zL6gSz+GpcppIsz9hSIUSChbfhczCcQZQU4Z
	SQNxlqMSpY3ZlsennTAhy2XtXgudKfL3Vr5Vpl8fLZoUHRCostLSPNhlOCh9gi3v2DC1wNzbRfU
	2IgzEVC3bwm/H+sqm/dSoK91UqBObrevq+WXenBsRPC
X-Google-Smtp-Source: AGHT+IEm1emTH1eS5Y4w1FaVVc8b/BvwqHo2ahiE9PL6RbDH230lmvUg74G2gH+2ArP2pIIP6MmFrPvT29jTdWSDYIg=
X-Received: by 2002:a17:903:1a67:b0:240:2939:361c with SMTP id
 d9443c01a7336-2485ba52ac4mr1230215ad.4.1756156443145; Mon, 25 Aug 2025
 14:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082233.1850417-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fW6N+eE0KTyV7F4wm=KBwk46QbXjwwG9POtZxEDhbRqRQ@mail.gmail.com>
 <03e30fdd-0624-4fa0-a187-cd870e5d3694@linux.intel.com> <CAP-5=fVdzM=VABXtcX_qM1_o8M5sKB5nJpojVg+Pw+XbfsRWkg@mail.gmail.com>
 <CAP-5=fXqi6Q-DW8d3eV7rSapMx1FtgeBG45o=NkGtbWtj==rvQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXqi6Q-DW8d3eV7rSapMx1FtgeBG45o=NkGtbWtj==rvQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Aug 2025 14:13:51 -0700
X-Gm-Features: Ac12FXx7e94feEGWP0_7N3VmAj7CoKfagavZSKNo9IAcqZBgCTt2-xmL4SYn6nc
Message-ID: <CAP-5=fXiUyb2nmP55HPKakS9-zyPmkxHy-Cmdkm6mJ4nUf+wFQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools topdown: Fix incorrect topdown slots regroup
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:54=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Aug 25, 2025 at 8:29=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Sun, Aug 24, 2025 at 5:54=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> > >
> > >
> > > On 8/23/2025 1:35 AM, Ian Rogers wrote:
> > > > On Fri, Aug 22, 2025 at 1:23=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux=
.intel.com> wrote:
> > > >> When running the command "perf stat -e "slots,slots" -C0 sleep 1",=
 we
> > > >> see below error.
> > > >>
> > > >> perf stat -e "slots,slots" -C0 sleep 1
> > > >> WARNING: events were regrouped to match PMUs
> > > >>  Performance counter stats for 'CPU(s) 0':
> > > >>      <not counted>      slots
> > > >>    <not supported>      slots
> > > >>
> > > >>      1.002265769 seconds time elapsed
> > > >>
> > > >> The topdown slots events are not correctly counted. The root cause=
 is
> > > >> that perf tools incorrectly regroup these 2 slots events into a gr=
oup.
> > > >> If there are only topdown slots events but no topdown metrics even=
ts,
> > > >> the regroup should not be done since topdown slots event can only =
be
> > > >> programed on fixed counter 3 and multiple slots events can only be
> > > >> multiplexed to run on fixed counter 3, but grouping them blocks
> > > >> multiplexing.
> > > >>
> > > >> So avoid to regroup topdown slots events if there is no topdown me=
trics
> > > >> events.
> > > >>
> > > >> With this change, above command can be run successfully.
> > > >>
> > > >> perf stat -e "slots,slots" -C0 sleep 1
> > > >>  Performance counter stats for 'CPU(s) 0':
> > > >>        103,973,791      slots
> > > >>        106,488,170      slots
> > > >>
> > > >>        1.003517284 seconds time elapsed
> > > >>
> > > >> Besides, run perf stats/record test on SPR and PTL, both passed.
> > > >>
> > > >> Reported-by: Xudong Hao <xudong.hao@intel.com>
> > > >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > > I don't think we should do this and if we were to do it we shouldn'=
t
> > > > do it in the common code. The perf metrics requiring a slots event =
is
> > > > a massive mess that never seems to end. What should we do with:
> > > > ```
> > > > $ perf stat -e "topdown-fe-bound,topdown-fe-bound" true
> > > >
> > > > Performance counter stats for 'true':
> > > >
> > > >     <not counted>      slots
> > > >     <not counted>      topdown-fe-bound
> > > >   <not supported>      topdown-fe-bound
> > > >
> > > >       0.000960472 seconds time elapsed
> > > >
> > > >       0.001060000 seconds user
> > > >       0.000000000 seconds sys
> > > >
> > > >
> > > > Some events weren't counted. Try disabling the NMI watchdog:
> > > >        echo 0 > /proc/sys/kernel/nmi_watchdog
> > > >        perf stat ...
> > > >        echo 1 > /proc/sys/kernel/nmi_watchdog
> > > > ```
> > > >
> > > > We've injected the slots event but the repeated topdown-fe-bound
> > > > causes the group to fail in a similar way. Why is repeating slots a
> > > > case we care about more?
> > > > Were we to say, okay slots is more special than the other perf metr=
ic
> > > > events then I'd prefer arch_evsel__must_be_in_group to return false
> > > > for the slots event when there are no other perf metric events in t=
he
> > > > evlist. But then what do you do if the slots event is in a differen=
t
> > > > group like:
> > > > ```
> > > > $ perf stat -e "slots,{slots,topdown-fe-bound}" true
> > > > ```
> > > > It is pretty easy to teach the code to deduplicate events, but then
> > > > again, what about the group behavior?
> > > > It is not clear to me we can ever clean up all the mess that the pe=
rf
> > > > metric events on p-cores create and I'm in favor of having the code=
 be
> > > > no more complex than it needs to be, so I'm not sure we should be
> > > > solving this problem.
> > >
> > > Ian, thanks for reviewing. Yeah, I agree what you said "topdown event=
s are
> > > a massive mess", we could never solve all issues. But it's annoying f=
or
> > > users that it reports "not counted" instead of an error. Is it possib=
le
> > > that we take a step back and don't try to resolve this issue and just
> > > report an error (maybe plus a message) to warn users that multiple sa=
me
> > > topdown events are not allowed? Thanks.
> >
> > Hi Dapeng,
> >
> > looking at:
> > ```
> > $ sudo perf stat -vv -e
> > 'cpu_core/topdown-fe-bound/,cpu_core/topdown-fe-bound/' true
> > Using CPUID GenuineIntel-6-B7-1
> > Attempt to add: cpu_core/topdown-fe-bound/
> > ..after resolving event: cpu_core/event=3D0,umask=3D0x82/
> > Attempt to add: cpu_core/topdown-fe-bound/
> > ..after resolving event: cpu_core/event=3D0,umask=3D0x82/
> > WARNING: events were regrouped to match PMUs
> > evlist after sorting/fixing:
> > '{cpu_core/slots/,cpu_core/topdown-fe-bound/,cpu_core/topdown-fe-bound/=
}'
> > Control descriptor is not initialized
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (cpu_core)
> >   size                             136
> >   config                           0x400 (slots)
> >   sample_type                      IDENTIFIER
> >   read_format
> > TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
> >   disabled                         1
> >   inherit                          1
> >   enable_on_exec                   1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 2631204  cpu -1  group_fd -1  flags 0x8 =3D 3
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (cpu_core)
> >   size                             136
> >   config                           0x8200 (topdown-fe-bound)
> >   sample_type                      IDENTIFIER
> >   read_format
> > TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
> >   inherit                          1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 2631204  cpu -1  group_fd 3  flags 0x8 =3D 4
> > ------------------------------------------------------------
> > perf_event_attr:
> >   type                             4 (cpu_core)
> >   size                             136
> >   config                           0x8200 (topdown-fe-bound)
> >   sample_type                      IDENTIFIER
> >   read_format
> > TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
> >   inherit                          1
> > ------------------------------------------------------------
> > sys_perf_event_open: pid 2631204  cpu -1  group_fd 3  flags 0x8
> > sys_perf_event_open failed, error -22
> > switching off exclude_guest for PMU cpu_core
> > Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
> > falling back to no-inherit.
> > Warning:
> > cpu_core/topdown-fe-bound/ event is not supported by the kernel.
> > failed to read counter cpu_core/slots/
> > failed to read counter cpu_core/topdown-fe-bound/
> > failed to read counter cpu_core/topdown-fe-bound/
> >
> >  Performance counter stats for 'true':
> >
> >      <not counted>      cpu_core/slots/
> >      <not counted>      cpu_core/topdown-fe-bound/
> >    <not supported>      cpu_core/topdown-fe-bound/
> >
> >        0.000975600 seconds time elapsed
> >
> >        0.001034000 seconds user
> >        0.000000000 seconds sys
> > ```
> > We can see that we have two good perf_event_opens and then the evsel
> > open code is trying to disable features because of the perf event open
> > failing. We can improve the error message:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n3828
> > so that a perf metric event that returns EINVAL warns about the broken
> > grouping (perhaps some arch/PMU specific EINVAL handling). Perhaps if
> > this is a slots event that isn't the group leader, the event can be
> > removed from the group at this point. There is some overlap with
> > breaking weak groups, when too many events are placed within a group:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/evlist.c?h=3Dperf-tools-next#n1848
> >
> > Generating the warning message looks relatively easy, making this a
> > case that fails or changes the evlist looks to be a larger refactor.
> > Should the failing perf_event_open cause the other members of the
> > group to break? That seems like an kernel and Intel PMU decision that
> > was already made. My suggestion is we create a warning message for
> > these perf metric event EINVAL cases but otherwise leave things
> > unchanged.
>
> I also think it'd be worthwhile to add a command line option to
> disable parse_events__sort_events_and_fix_groups code so that things
> like "slots,slots" can be just passed through and not get broken. This
> may be unfortunate for uncore things like:
> ```
> $ sudo perf stat -v -e '{data_read,data_write}' -a -A true
> Using CPUID GenuineIntel-6-B7-1
> data_read -> uncore_imc_free_running_0/data_read/
> data_read -> uncore_imc_free_running_1/data_read/
> data_write -> uncore_imc_free_running_0/data_write/
> data_write -> uncore_imc_free_running_1/data_write/
> WARNING: events were regrouped to match PMUs
> evlist after sorting/fixing: '{data_read,data_write},{data_read,data_writ=
e}'
> Control descriptor is not initialized
>
> Performance counter stats for 'system wide':
>
> CPU0                 1.85 MiB  uncore_imc_free_running_0/data_read/
>
> CPU0                 0.08 MiB  uncore_imc_free_running_0/data_write/
>
> CPU0                 1.87 MiB  uncore_imc_free_running_1/data_read/
>
> CPU0                 0.07 MiB  uncore_imc_free_running_1/data_write/
>
>
>       0.000851335 seconds time elapsed
> ```
> where the different uncore PMUs for the data_read and data_write
> events won't get resorted and the groups broken, etc. Perhaps rather
> than a command line option for the evlist it can be an option on the
> event, so something like:
> ```
> $ perf stat -e 'slots:X,slots:X,{data_read,data_write}' ...
> ```
> where the X modifier is indicating not to change the group of the event.

So a patch series doing this is here:
https://lore.kernel.org/lkml/20250825211204.2784695-1-irogers@google.com/

Thanks,
Ian

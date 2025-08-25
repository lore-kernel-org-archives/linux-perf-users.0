Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA32FC86F
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135766; cv=none; b=rCv0wOslbq59jSOfGEVRX/g4rDvKW/fvdH+0L0H2+UqjXNFQhjmwzG+dyX7L2bj/WL78hCy25YBkx5tJ0N4+3kse+A7KvSMhiVgSMYLDRSHAms72ALHhvwJs9VH1zVkZt2AK/Gp3cYQHMEY/LiqZxGzpvj6DAvnR2muHIjowtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135766; c=relaxed/simple;
	bh=Resize7sI/dPctdtM3d/fHY1l9+rmQCwanDuby2PJ0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEqnHz2jJ1Xd0HZ3xuNjA+weqHhog6uij2xsV8GDA/jrytXcnRs7deHIYXw7SuR6maiN2vurSSYJI3dn4qAT/Ak+fAoaBYJRXdXj8afmuWt01mRGGBfSrFpMPL7ovAQFrBg9Y4o7uPVXpIfiYLar9TOhmwJBuseT1VRtXcV6EqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLHC3P+a; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLHC3P+a"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-246013de800so339415ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756135764; x=1756740564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91iE/pJsUSlrkfp0u6OVb67K2yF63yim9CwKAvVMzjg=;
        b=OLHC3P+azFApggSrsmAnziZlrvssYpWK2aXX9p9PEVgQm2YrJ+CLbvxq3SrYcMt74Y
         eNWq4jWsea51zEO4jHTTsoHG7w/mLBo9srb9XwMUmBaF6Tawxkp2YZzfV9kMuHJUXytH
         lkmohP5opRMK3KX67RqNqBnBWL1JEMzgnkFHJy0mNKyneVRXvxs9HDubgI4FkBKEdDtk
         PmQlvkp0BeqQ0rErIP9O0mNbJ1IbFECsjVAOnVx1EGc6JguwfaoiVgLqc0VQ5saVPlp6
         Tt0V2wPu41Rnl5SvLFTL25265vXaSlcRyZnlrFN7iSQGPyVqPMtly53mHLh8iwGgkQwX
         BTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135764; x=1756740564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91iE/pJsUSlrkfp0u6OVb67K2yF63yim9CwKAvVMzjg=;
        b=iWfTrxykwXW6hYaqEYnRAdi7ytKFVTqVtTdyQYnV74rjnKiWDiNmlOQhTI+0WzrkdV
         iStD8ZnamkueObKxTsO/lWLkJc6rMwguqcIC5Nf6f6+xSk/gGAea6fvUOdL/aV/7TDTY
         6yhNM8a6GC7ab6/0zU/Hzq5LPA+ks143uUvEtCg7V8pSIY4+UzfVltrCy2N1N9K1PUST
         PLMiPpbW7jruyyg31Tq9K5Jc1Xk6PZQrRmlSDUizXkSv7Gqxq8zLiuSBVi673PT5cRax
         wvq96J0POG/svZ5OTtiyTzpaZ+rzKnPhkxgPJY6z8Ap//3UZKdDxj78Gm7sIvMyr4Fro
         p+0w==
X-Forwarded-Encrypted: i=1; AJvYcCW4yxDGhVpih7ZQk+cqEYHcoE7H53X1H97530V4rE8uIbkaDg2t6EFIadlQnH7dgQmXxDZu+VNgCJXP5rEvvcOu@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8S16OTA5VE2tlSD4kanmaOEPJXXwe6bEuHKpZ70BpbBOQ9PI
	BRqlkdEBP3SSPJ7OqmyqN+1/xWjOpemMPzg4BVn7SSadQDIqdXRbN/U3y6GDF2c5skW2ZRmmxkp
	FQ5stsVbHZYyCgL6u/JVM/I93pBkI81N3qCjiVvlK
X-Gm-Gg: ASbGncvkTpfDxzH2e2MQaIGs77MGr6xEW0iTtqaOB9O9q9ocwpG/dsRg75qd6WWsVys
	zGIzETvpPQYi9XavkzlvXG42RBN+lifnA1H+Vj8NkqsQ+b3m2XFtStGs+60hCt6ERe+bpvuduD1
	k8Eol6ekeE8bzKuu6ScJkbeHw5VSzmQC87mP6GC1Clm8guHF+15KCJQPtyzxr6/1CcXBBureX/0
	HNlY+TsQeHFaT2Kp7m48XafS6yauA2D5CU4ZKRT1aK4wHjmUvs1eCU=
X-Google-Smtp-Source: AGHT+IG43uQBkTdXPL1j9UwGMPkOOxfvawE8MJ0EV3jR9aK3MYfH9IefryYLLJvrD32AVtiiohH8x9YEXr8d2+jZe7Y=
X-Received: by 2002:a17:903:41ca:b0:237:e45b:4f45 with SMTP id
 d9443c01a7336-2467a21d524mr7589695ad.1.1756135764005; Mon, 25 Aug 2025
 08:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082233.1850417-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fW6N+eE0KTyV7F4wm=KBwk46QbXjwwG9POtZxEDhbRqRQ@mail.gmail.com> <03e30fdd-0624-4fa0-a187-cd870e5d3694@linux.intel.com>
In-Reply-To: <03e30fdd-0624-4fa0-a187-cd870e5d3694@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Aug 2025 08:29:12 -0700
X-Gm-Features: Ac12FXxRJ9fS_RAUsFQShPLelzuJcYEOi-PIWjmghOc36Rw0ch2JFwGHTq5wOWE
Message-ID: <CAP-5=fVdzM=VABXtcX_qM1_o8M5sKB5nJpojVg+Pw+XbfsRWkg@mail.gmail.com>
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

On Sun, Aug 24, 2025 at 5:54=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 8/23/2025 1:35 AM, Ian Rogers wrote:
> > On Fri, Aug 22, 2025 at 1:23=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> When running the command "perf stat -e "slots,slots" -C0 sleep 1", we
> >> see below error.
> >>
> >> perf stat -e "slots,slots" -C0 sleep 1
> >> WARNING: events were regrouped to match PMUs
> >>  Performance counter stats for 'CPU(s) 0':
> >>      <not counted>      slots
> >>    <not supported>      slots
> >>
> >>      1.002265769 seconds time elapsed
> >>
> >> The topdown slots events are not correctly counted. The root cause is
> >> that perf tools incorrectly regroup these 2 slots events into a group.
> >> If there are only topdown slots events but no topdown metrics events,
> >> the regroup should not be done since topdown slots event can only be
> >> programed on fixed counter 3 and multiple slots events can only be
> >> multiplexed to run on fixed counter 3, but grouping them blocks
> >> multiplexing.
> >>
> >> So avoid to regroup topdown slots events if there is no topdown metric=
s
> >> events.
> >>
> >> With this change, above command can be run successfully.
> >>
> >> perf stat -e "slots,slots" -C0 sleep 1
> >>  Performance counter stats for 'CPU(s) 0':
> >>        103,973,791      slots
> >>        106,488,170      slots
> >>
> >>        1.003517284 seconds time elapsed
> >>
> >> Besides, run perf stats/record test on SPR and PTL, both passed.
> >>
> >> Reported-by: Xudong Hao <xudong.hao@intel.com>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > I don't think we should do this and if we were to do it we shouldn't
> > do it in the common code. The perf metrics requiring a slots event is
> > a massive mess that never seems to end. What should we do with:
> > ```
> > $ perf stat -e "topdown-fe-bound,topdown-fe-bound" true
> >
> > Performance counter stats for 'true':
> >
> >     <not counted>      slots
> >     <not counted>      topdown-fe-bound
> >   <not supported>      topdown-fe-bound
> >
> >       0.000960472 seconds time elapsed
> >
> >       0.001060000 seconds user
> >       0.000000000 seconds sys
> >
> >
> > Some events weren't counted. Try disabling the NMI watchdog:
> >        echo 0 > /proc/sys/kernel/nmi_watchdog
> >        perf stat ...
> >        echo 1 > /proc/sys/kernel/nmi_watchdog
> > ```
> >
> > We've injected the slots event but the repeated topdown-fe-bound
> > causes the group to fail in a similar way. Why is repeating slots a
> > case we care about more?
> > Were we to say, okay slots is more special than the other perf metric
> > events then I'd prefer arch_evsel__must_be_in_group to return false
> > for the slots event when there are no other perf metric events in the
> > evlist. But then what do you do if the slots event is in a different
> > group like:
> > ```
> > $ perf stat -e "slots,{slots,topdown-fe-bound}" true
> > ```
> > It is pretty easy to teach the code to deduplicate events, but then
> > again, what about the group behavior?
> > It is not clear to me we can ever clean up all the mess that the perf
> > metric events on p-cores create and I'm in favor of having the code be
> > no more complex than it needs to be, so I'm not sure we should be
> > solving this problem.
>
> Ian, thanks for reviewing. Yeah, I agree what you said "topdown events ar=
e
> a massive mess", we could never solve all issues. But it's annoying for
> users that it reports "not counted" instead of an error. Is it possible
> that we take a step back and don't try to resolve this issue and just
> report an error (maybe plus a message) to warn users that multiple same
> topdown events are not allowed? Thanks.

Hi Dapeng,

looking at:
```
$ sudo perf stat -vv -e
'cpu_core/topdown-fe-bound/,cpu_core/topdown-fe-bound/' true
Using CPUID GenuineIntel-6-B7-1
Attempt to add: cpu_core/topdown-fe-bound/
..after resolving event: cpu_core/event=3D0,umask=3D0x82/
Attempt to add: cpu_core/topdown-fe-bound/
..after resolving event: cpu_core/event=3D0,umask=3D0x82/
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing:
'{cpu_core/slots/,cpu_core/topdown-fe-bound/,cpu_core/topdown-fe-bound/}'
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu_core)
  size                             136
  config                           0x400 (slots)
  sample_type                      IDENTIFIER
  read_format
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 2631204  cpu -1  group_fd -1  flags 0x8 =3D 3
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu_core)
  size                             136
  config                           0x8200 (topdown-fe-bound)
  sample_type                      IDENTIFIER
  read_format
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
------------------------------------------------------------
sys_perf_event_open: pid 2631204  cpu -1  group_fd 3  flags 0x8 =3D 4
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu_core)
  size                             136
  config                           0x8200 (topdown-fe-bound)
  sample_type                      IDENTIFIER
  read_format
TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
------------------------------------------------------------
sys_perf_event_open: pid 2631204  cpu -1  group_fd 3  flags 0x8
sys_perf_event_open failed, error -22
switching off exclude_guest for PMU cpu_core
Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
falling back to no-inherit.
Warning:
cpu_core/topdown-fe-bound/ event is not supported by the kernel.
failed to read counter cpu_core/slots/
failed to read counter cpu_core/topdown-fe-bound/
failed to read counter cpu_core/topdown-fe-bound/

 Performance counter stats for 'true':

     <not counted>      cpu_core/slots/
     <not counted>      cpu_core/topdown-fe-bound/
   <not supported>      cpu_core/topdown-fe-bound/

       0.000975600 seconds time elapsed

       0.001034000 seconds user
       0.000000000 seconds sys
```
We can see that we have two good perf_event_opens and then the evsel
open code is trying to disable features because of the perf event open
failing. We can improve the error message:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c?h=3Dperf-tools-next#n3828
so that a perf metric event that returns EINVAL warns about the broken
grouping (perhaps some arch/PMU specific EINVAL handling). Perhaps if
this is a slots event that isn't the group leader, the event can be
removed from the group at this point. There is some overlap with
breaking weak groups, when too many events are placed within a group:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evlist.c?h=3Dperf-tools-next#n1848

Generating the warning message looks relatively easy, making this a
case that fails or changes the evlist looks to be a larger refactor.
Should the failing perf_event_open cause the other members of the
group to break? That seems like an kernel and Intel PMU decision that
was already made. My suggestion is we create a warning message for
these perf metric event EINVAL cases but otherwise leave things
unchanged.

Thanks,
Ian

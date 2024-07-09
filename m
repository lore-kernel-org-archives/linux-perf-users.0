Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E2187842
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jul 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564652; cv=none; b=ASfyqWTGOKxqdPFWN2ZBmUX8X4z9AI9PyThNphCeCAxmtfQrezpgG+GrfwHYPqmcCB55cpyxoMNcCYW+9Dnhimf5wc8kCenLz9Jzxa1ojqwaFcQVbJFojh4nQfnwJ6oHRX+SVEcpBfXalu21eMnxneniJuKE8h+j69ovq7ANP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564652; c=relaxed/simple;
	bh=e2MDuj8Io1fhCiNsbjZNlwJl04CnqnwieSmEdvc12po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0YacRknxXzyIn7dUeV9hcsDGWC6Rhy9Q1sMDITtGj9Q/mdzAO9D/P9VixDnSeFO5HlWEa7wVDdqxpeKJqtUbAKMZQkQF8HUoJ32LlMyxATchGxSvVmXiozNHT/fg7IkmPwRJqBHAlqva5nPXi7M8DU53S9j6kw4CP3jmeG6Gs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyxPW5f2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyxPW5f2"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44664ad946eso38081cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jul 2024 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720564648; x=1721169448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+6NPnnkHb7G/Ix/vOLuyfaLASHfaochcI1KscloDAk=;
        b=hyxPW5f2p40oZ08EP3Scv74tVdXoYxpeFgqR5hFis/hx7so/C84WsfrAFoEfzvhNtn
         c71Kv4t6HGYdLNFwNKqT5dPhRJgafi/j25362gpdqzeTDi/xY4CQQTjfI9c6gkncuUbi
         LAbte0GIpsBQz68jEHQU36mFoIpz3D8dQDI9h4fsp0rYiStc/urGraJOKm+IqXJfaybg
         7o8MOckz1YJlh75jJGCQ9UIBWr8e1i0LRWNVomTuoZwswuujQOFCapge2OCHdZ0vKXoU
         l5n3q1OzBSdeh3MyEpAKdr0VQXOinQcSnNH66o3Wpb8BePW0cfvkMA4SOofh25UgCFl1
         tPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720564648; x=1721169448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+6NPnnkHb7G/Ix/vOLuyfaLASHfaochcI1KscloDAk=;
        b=AOFxIBGnSPAj5wDISUUKBdGEKswxsbp2akiyzBIwP5n1ri5c/3/4QTxCIMh3fwAVd2
         crdR6zj8Zyns6q7Cgwjaaj5cNL13DdU/rhNycBtKhm2ocf2GLApbMCQjxqcNLk+Inve8
         1zc9QXKcbtfiH5g6OG686rBwaX17rN1omOHBjw8/R4f3Ldx6UxuAwF4JDPW/4cBuJuDM
         IqAfvf2DEuFB91AW1JMI7ssxKyIwYE64ZX443H96r0fri1EJn5v+bQPVHCvgD0+GXfDS
         WK++hLtvO8CjykeXApFgvQ3LuhM+JPQynUvhmL3a5ekRJ+N7x23AfPtVVZdzd2H/z2Nc
         nxFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+CBsqaVbyZFOJgHMP07FRl7raSoHoOhfD5hpYbjlCynSPnYC+G8iUqjzRs/uK4y3fBpT6y1GuLeSFfjwYSAlKM1Q0O1K1gRTQGSoLiQ1BIg==
X-Gm-Message-State: AOJu0YyWWJY5SOJlRELxTP2PwdQBFPeYCOMhNhi/WZRctIQWhnNAW+C6
	AHZdF4rnLnPjl/sTG8SNbMYaeDWVWCeTf2nNcN975/9myi6XeU6ftFpcwxz93FjwMnKKJ76CmZ4
	c9x9kJUmcwqxPsb3kQsrtcnIC5oBpwIJPUUDQ
X-Google-Smtp-Source: AGHT+IFsOz3Vke0hM5F+VfZSR9dT0NQcQEl/36jxf24SqMD0AVDEerXty0dQjAat8ZtCjgixc/iIwNAkLNtXWhaS45Y=
X-Received: by 2002:ac8:53cb:0:b0:43f:ff89:dfb9 with SMTP id
 d75a77b69052e-44acb0faa76mr1257291cf.6.1720564647804; Tue, 09 Jul 2024
 15:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-4-dapeng1.mi@linux.intel.com> <CAP-5=fVPb4JGR3RxfPBGrihrra8bFzdJfFt2iASSs2xHOy=U4g@mail.gmail.com>
 <4d39856e-396d-4a48-9ca3-2e1a574f50d7@linux.intel.com>
In-Reply-To: <4d39856e-396d-4a48-9ca3-2e1a574f50d7@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Jul 2024 15:37:15 -0700
Message-ID: <CAP-5=fW65kxuABBJVAzKwoyBWW92_jkndWgY+4u9s3OGj_UkEg@mail.gmail.com>
Subject: Re: [Patch v2 3/5] perf x86/topdown: Don't move topdown metrics
 events when sorting events
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:18=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 7/8/2024 11:08 PM, Ian Rogers wrote:
> > On Mon, Jul 8, 2024 at 12:40=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> when running below perf command, we say error is reported.
> >>
> >> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep=
 1
> >>
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>   type                             4 (cpu)
> >>   size                             168
> >>   config                           0x400 (slots)
> >>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIF=
IER
> >>   read_format                      ID|GROUP|LOST
> >>   disabled                         1
> >>   sample_id_all                    1
> >>   exclude_guest                    1
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 5
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>   type                             4 (cpu)
> >>   size                             168
> >>   config                           0x8000 (topdown-retiring)
> >>   { sample_period, sample_freq }   4000
> >>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIF=
IER
> >>   read_format                      ID|GROUP|LOST
> >>   freq                             1
> >>   sample_id_all                    1
> >>   exclude_guest                    1
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
> >> sys_perf_event_open failed, error -22
> >>
> >> Error:
> >> The sys_perf_event_open() syscall returned with 22 (Invalid argument) =
for event (topdown-retiring).
> >>
> >> The reason of error is that the events are regrouped and
> >> topdown-retiring event is moved to closely after the slots event and
> >> topdown-retiring event needs to do the sampling, but Intel PMU driver
> >> doesn't support to sample topdown metrics events.
> >>
> >> For topdown metrics events, it just requires to be in a group which ha=
s
> >> slots event as leader. It doesn't require topdown metrics event must b=
e
> >> closely after slots event. Thus it's a overkill to move topdown metric=
s
> >> event closely after slots event in events regrouping and furtherly cau=
se
> >> the above issue.
> >>
> >> Thus delete the code that moving topdown metrics events to fix the
> >> issue.
> > I think this is wrong. The topdown events may not be in a group, such
> > cases can come from metrics due to grouping constraints, and so they
> > must be sorted together so that they may be gathered into a group to
> > avoid the perf event opens failing for ungrouped topdown events. I'm
> > not understanding what these patches are trying to do, if you want to
> > prioritize the event for leader sampling why not modify it to compare
>
> Per my understanding, this change doesn't break anything. The events
> regrouping can be divided into below several cases.
>
> a. all events in a group
>
> perf stat -e "{instructions,topdown-retiring,slots}" -C0 sleep 1
> WARNING: events were regrouped to match PMUs
>
>  Performance counter stats for 'CPU(s) 0':
>
>         15,066,240      slots
>          1,899,760      instructions
>          2,126,998      topdown-retiring
>
>        1.045783464 seconds time elapsed
>
> In this case, slots event would be adjusted as the leader event and all
> events are still in same group.
>
> b. all events not in a group
>
> perf stat -e "instructions,topdown-retiring,slots" -C0 sleep 1
> WARNING: events were regrouped to match PMUs
>
>  Performance counter stats for 'CPU(s) 0':
>
>          2,045,561      instructions
>         17,108,370      slots
>          2,281,116      topdown-retiring
>
>        1.045639284 seconds time elapsed
>
> In this case, slots and topdown-retiring are placed into a group and slot=
s
> is the group leader. instructions event is outside the group.
>
> c. slots event in group but topdown metric events outside the group
>
> perf stat -e "{instructions,slots},topdown-retiring"  -C0 sleep 1
> WARNING: events were regrouped to match PMUs
>
>  Performance counter stats for 'CPU(s) 0':
>
>         20,323,878      slots
>          2,634,884      instructions
>          3,028,656      topdown-retiring
>
>        1.045076380 seconds time elapsed
>
> In this case, topdown-retiring event is placed into previous group and
> slots is adjusted to leader event.
>
> d. multiple event groups
>
> perf stat -e "{instructions,slots},{topdown-retiring}"  -C0 sleep 1
> WARNING: events were regrouped to match PMUs
>
>  Performance counter stats for 'CPU(s) 0':
>
>         26,319,024      slots
>          2,427,791      instructions
>          2,683,508      topdown-retiring
>
>        1.045495830 seconds time elapsed
>
> In this case, the two groups are merged to one group and slots event is
> adjusted as leader.
>
> The key point of this patch is that it's unnecessary to move topdown
> metrics events closely after slots event. It's a overkill since Intel cor=
e
> PMU driver doesn't require that. Intel PMU driver just requires topdown
> metrics events are in a group where slots event is the group leader, and
> worse the movement for topdown metrics events causes the issue in the
> commit message mentioned.
>
> This patch doesn't block to regroup topdown metrics event. It just remove=
s
> the unnecessary movement for topdown metrics events.

But you will get the same behavior because of the non-arch dependent
force group index - I guess you don't care as the sample read only
happens when you have a group.

I'm thinking of cases like (which admittedly is broken):
```
$ perf stat -e "{slots,instructions},cycles,topdown-fe-bound" -a sleep 0.1
[sudo] password for irogers:

Performance counter stats for 'system wide':

    2,589,345,900      slots
      852,492,838      instructions
      583,525,372      cycles
  <not supported>      topdown-fe-bound

      0.103930790 seconds time elapsed
```
As the slots event is grouped there's no force group index on it, we
want to shuffle the topdown-fe-bound into the group so we want it to
compare as less than cycles - ie we're comparing topdown events with
non topdown events and trying to shuffle the topdown events first.

Thanks,
Ian



>
> > first?
> >
> > Thanks,
> > Ian
> >
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  tools/perf/arch/x86/util/evlist.c | 5 -----
> >>  1 file changed, 5 deletions(-)
> >>
> >> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/u=
til/evlist.c
> >> index 332e8907f43e..6046981d61cf 100644
> >> --- a/tools/perf/arch/x86/util/evlist.c
> >> +++ b/tools/perf/arch/x86/util/evlist.c
> >> @@ -82,11 +82,6 @@ int arch_evlist__cmp(const struct evsel *lhs, const=
 struct evsel *rhs)
> >>                         return -1;
> >>                 if (arch_is_topdown_slots(rhs))
> >>                         return 1;
> >> -               /* Followed by topdown events. */
> >> -               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_m=
etrics(rhs))
> >> -                       return -1;
> >> -               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_m=
etrics(rhs))
> >> -                       return 1;
> >>         }
> >>
> >>         /* Default ordering by insertion index. */
> >> --
> >> 2.40.1
> >>

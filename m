Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503F1F30B2
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Jun 2025 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992987; cv=none; b=eE3Nh+teUf5wZ5z5Ft035qVmwU5gOScEcR84jzGkoImxkzlEt2//Y2Y7ESw62+MuyXtwX/LvaftkpJdg0bfENJ1ucoDPV8xv4vcTt4y/gUFOM68TGLhCNAf4vKP7abZGwKueLXwQ47o4bmbyo6pWGdup754SHJ2MbPNYzT6gfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992987; c=relaxed/simple;
	bh=5NMenGirlGYd5Gf7/ZLMGVBPOpZKY630QabLL5KqYsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdrajKkEt/f7yI+0FiyXDp1HAo+UH5T3RtK/93YbLj7lOSJZFMjlyKRySdALRR1ci69FtUl23dcPFYBuw2D/9Cr31rVbSRjJsOEHQ0CB4OI2sdLmsaDxWRsERDw4PB1KgmrgPLyEE441jBYqaTfk4z1D7ldjatzp7nIW04NT2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TqB7IIkb; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqB7IIkb"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso48435ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jun 2025 16:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748992984; x=1749597784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3+/BX3M2Y89rbLNsWUUmJGh+NifKtGuVr8X38aK58k=;
        b=TqB7IIkby3idJRmGeB3gZgETuZCfbsbBhuXo3qyu9VNN7a4g5cZqP9LT9h6/4bfY3r
         PyhisV54pOTL1nQCjTCP5yOgEmPfogDDLLvrG2bIs16oHaDIM/wgU5DfOEBATh/kIHWt
         HAUZIUF/kidxiXbXhFmAV7v3DzDmacqQhQSERstKVFkb7ryWvV0ZDE6XPGfPGMULplzg
         s1aURG0BcEKX0Shkuxj5TRozQrdg4cHON5qipSLIQHNDpxJX4GB3J43MgWmyjHa5px2E
         W3Nh7aFXKq2oXebVYlhyiq5bKFA+SJSmQKveO54zDOP8TjHOBtCF3ocVEl0W9B2LSZhS
         DakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748992984; x=1749597784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3+/BX3M2Y89rbLNsWUUmJGh+NifKtGuVr8X38aK58k=;
        b=ZJHNCYb+ZaOFuRm22Qn0gmCxtDY9YjLocqAilTsPb+rn6P0lQ4awem47ZtRL+jMcy3
         qG/R9vLoNdmZ8QcV1oznGTIaEliDTMKoW8T62fetYS/q/4OEEB942Ok/PxmsebFc/Tze
         q/ghbAQqEnqP+FSv+FRky/8Rl64Ve9+mJ7gVysSAtHypOLMpRZgH/BfLiG2+ArWc7wSp
         vqq2ykWAxNQJBbsFviztvcA+lbqbmNP0YzHIbNayUhFXoRWHK2J22zxFcw2d/CcNfSGR
         hsxHotZE9SKMAmT4552TQhVNdXzMA3lOilvnUfDhzV1WpQVWxFRwsEeKUA70on8Um3GZ
         Xjkw==
X-Forwarded-Encrypted: i=1; AJvYcCUQd9Rv+mr8xFeS7HrphBH/BLmI4czZaW7zWZ3pDS5tE4A83xv5M9W8CPdlsX9x7k4QrzF+yGvsrNTUZJLTGOXQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxktedzN89T9ohOAZhxmrk7HYPlwoAhiZoUWg1H0bnyxggaQZs5
	N27NbK1EN7CeHySJEzGz/7ap8GabPuyc7mLLX3/e2VNXNMBmMA64xdM0JCbAKRSZQFj7t+IjjDZ
	ViHsWlsWrV9zGdZrU9nINnhQjmUK3sBZD20nXswMb
X-Gm-Gg: ASbGncudi3xp6unaQTCkdCZOuEoFt27lQw/MS1cjENdbQNuGVUTC8ufzK7SO+C7xS56
	XCoB9kSoFqLpQOlK5W0GVDIxKBLU62Vhfy5wP8ZuQCeC0x9Ro5FJ6I2BhzjqTNa3B5wbpeRuhi6
	sCUHBzJuYDw/3UgzPvj+b7WfQNPiHVIRAqzy/F+q3BAJJtpOER1q2mud6XfLGfHgkE9/7DhU7k
X-Google-Smtp-Source: AGHT+IEUvzqU7FRoFbEh87gPAJQgeCRr8f1sFtdz3WxvkXIfcfQH0XJb+mhdJId8GrzJCCNDfZograTAqpyqHMwzhx8=
X-Received: by 2002:a92:cdad:0:b0:3dc:7edc:5f42 with SMTP id
 e9e14a558f8ab-3ddbe7b139amr1128855ab.12.1748992984129; Tue, 03 Jun 2025
 16:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com> <CAP-5=fXiYHbe9gd_TNyy=txzrd+ONxecnpZr+uPeOnF5XxunGw@mail.gmail.com>
 <aD586_XkeOH2_Fes@google.com> <CAP-5=fUXJ6fW4738Fnx9AK2mPeA74ZpYKv=Ui6wYLWXE3KRRTQ@mail.gmail.com>
 <aD94FJN4Pjsx7exP@google.com>
In-Reply-To: <aD94FJN4Pjsx7exP@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Jun 2025 16:22:53 -0700
X-Gm-Features: AX0GCFtEmC2fzpawZdDG0b5JgiRdyvBAmvU4lcNQWGCbVObEs3EY-kJpVkdFZzg
Message-ID: <CAP-5=fX98m+PPkHR2+KdjtJfc0ONMwkjeoCLzjwG_O=5j50=5g@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Jun 02, 2025 at 11:26:12PM -0700, Ian Rogers wrote:
> > On Mon, Jun 2, 2025 at 9:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, May 27, 2025 at 01:39:21PM -0700, Ian Rogers wrote:
> > > > On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > Rather than scanning /proc and skipping PIDs based on their UIDs,=
 use
> > > > > BPF filters for uid filtering. The /proc scanning in thread_map i=
s
> > > > > racy as the PID may exit before the perf_event_open causing perf =
to
> > > > > abort. BPF UID filters are more robust as they avoid the race. Th=
e
> > > > > /proc scanning also misses processes starting after the perf
> > > > > command. Add a helper for commands that support UID filtering and=
 wire
> > > > > up. Remove the non-BPF UID filtering support given it doesn't wor=
k.
> > > > >
> > > > > v3: Add lengthier commit messages as requested by Arnaldo. Rebase=
 on
> > > > >     tmp.perf-tools-next.
> > > > >
> > > > > v2: Add a perf record uid test (Namhyung) and force setting
> > > > >     system-wide for perf trace and perf record (Namhyung). Ensure=
 the
> > > > >     uid filter isn't set on tracepoint evsels.
> > > > >
> > > > > v1: https://lore.kernel.org/lkml/20250111190143.1029906-1-irogers=
@google.com/
> > > >
> > > > Ping. Thanks,
> > >
> > > I'm ok with preferring BPF over /proc scanning, but still hesitate to
> > > remove it since some people don't use BPF.  Can you please drop that
> > > part and make parse_uid_filter() conditional on BPF?
> >
> > Hi Namhyung,
> >
> > The approach of scanning /proc fails as:
> > 1) processes that start after perf starts will be missed,
> > 2) processes that terminate between being scanned in /proc and
> > perf_event_open will cause perf to fail (essentially the -u option is
> > just sugar to scan /proc and then provide the processes as if they
> > were a -p option - such an approach doesn't need building into the
> > tool).
>
> Yeah, I remember we had this discussion before.  I think (1) is not true
> as perf events will be inherited to children (but there is a race).

If you log in from another terminal? Anything that creates a new
process for that user but isn't inherited will be missed, which isn't
merely a race.

>  And
> (2) is a real problem but it's also about a race and it can succeed.
>
> Maybe we could change it to skip failed events when the target is a
> user but that's not the direction you want.

We could have other events and try to discover new processes via them,
do things like dummy events to cover races. It is just a lot of
complexity for something that is a trivial amount of BPF. In something
like 10 years nobody has bothered to fix this up.

> >
> > This patch series adds a test [1] and perf test has lots of processes
> > starting and exiting, matching condition (2) above*. If this series
> > were changed to an approach that uses BPF and falls back on /proc
> > scanning then the -u option would be broken for both reasons above but
> > also prove a constant source of test flakes.
> >
> > Rather than give the users something both frustrating to use (keeps
> > quitting due to failed opens) and broken (missing processes) I think
> > it is better to quit perf at that point informing the user they need
> > more permissions to load the BPF program. This also makes the -u
> > option testable.
> >
> > So the request for a change I don't think is sensible as it provides a
> > worse user and testing experience. There is also the cognitive load of
> > having the /proc scanning code in the code base, whereas the BPF
> > filter is largely isolated.
>
> But I think the problem is that it has different requirements - BPF and
> root privilege.  So it should be used after checking the requirements
> and fail or fallback.
>
> Does it print proper error messages if not?  With that we can deprecate
> the existing behavior and remove it later.

For `perf top` with TUI you get an error message in a box of:
```
failed to set filter "BPF" on event cpu_atom/cycles/P with 1
(Operation not permitted)
```
With --stdio you get:
```
libbpf: Error in bpf_object__probe_loading(): -EPERM. Couldn't load
trivial BPF program. Make sure your kernel supports BPF
(CONFIG_BPF_SYSCALL=3Dy) and/or that RLIMIT_MEMLOCK is set to big enough
value.
libbpf: failed to load object 'sample_filter_bpf'
libbpf: failed to load BPF skeleton 'sample_filter_bpf': -EPERM
Failed to load perf sample-filter BPF skeleton
failed to set filter "BPF" on event cpu_atom/cycles/P with 1
(Operation not permitted)
```
This matches the existing behavior if you put a filter on an event.

Thanks,
Ian

> Thanks,
> Namhyung
>

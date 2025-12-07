Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B272617
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Dec 2025 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765071826; cv=none; b=kkULs/6IMgnJByxBiNMaBKs0M43PKmk2yzXLOIMegO0pP0sQpNcQ/z45aakt5pm6UvwowzquJhoZlLorbunl4AbQN4e3fNcR3WsONo3GAv4YEMZ5D2FfanPJ04AuOZDEfYwoQzdm402TrCl7c6Mx3O4nMcKzmPcCs75ozhabXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765071826; c=relaxed/simple;
	bh=ORgfH02iWCsHrIQd+P7pdtlXlH+QgGHM0osVziyquRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB6l4pnTDA317I3YTR3+l6clB8IDu+UiTNffEgVI6PjlkKf59wZcVsxoTWoJ+PPRb6mHTKGyES/0kuP5/rp1zX9Y2Rt9snEdtWd/lDcgYrIBCYkrYGYtb0WU4+zg9LDcIVjixUeHMZjleyy9ASNhbwKza3NSbeTXSjFSHMHM1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IihmeptK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IihmeptK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e13bf404so174085ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Dec 2025 17:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765071824; x=1765676624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wMI4b2lgXfn0gDp7xrxR+VPGcK6RZSXF6Ivc5Euq6Q=;
        b=IihmeptK9kAbf8csT7SiSHPGpHLHwrLPOjgLQb6bKUFHu28MLNPyKOTReFcyzL5ib8
         RA+vottT5F7GVJsidv7QYoOTBLafaR46esNKv3ThgIBliZ350RKCjQhUZdfcmuwc+jei
         SVtW127ujKGMg4cl5oMwkvFFvA9dh+kqNEIvc8YLhjXbBmSz86qF7o8aTaIklWb/IvLz
         pm+QOUcVIfjArp4MdDp5qgwZrXCb4kIMkgeyjD6SSgWuZEKrOp9T4Z0gEtyJ8oZBRmj8
         oasnQslUidW6+3BxOMoNAgL2fFLwqrVic6N32du84DaPkRvCUmHX3ryLM57SF1Ef49s2
         hsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765071824; x=1765676624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1wMI4b2lgXfn0gDp7xrxR+VPGcK6RZSXF6Ivc5Euq6Q=;
        b=PQjm2S4W+yMiXS9/se+9TOrnFPN+y7i2aABSKVVFvrke6+K07Si+jsU2pmGGYbDtFQ
         0M9YF9g/NnURV7ZHDysSGrA/5pPXIb8pRk0JZzqO3xE6+dq/kfeImMnzZxG7L0D9kb/l
         eE8km4uoLm049MrbyI06gmmM5i6i7M2/ordFpe5/kqKqIhDBCPY+37ycqRudyugJuBgp
         rtGpXnF7AosPHdokGLbZwFHqeOQLJkN99VPDHhGXiKgTnNdmPsEJJSG02Z57UGHjMZOP
         xRycpeF4zAb+fKJXHtDkp/CIQAWjeAPaPh/eT61VHvT10NtvD9vDhCOH/Nmc/qARqN0b
         hn7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCMC0IFxUTjuvgNaICkd0uyjXT+1awqdLS78qrMbSGI7Ms82LXni9P952XD8HAtSwzbChttYczu/ntnKIrosCm@vger.kernel.org
X-Gm-Message-State: AOJu0YxILBWTegbF+taofkEcM5NnwH7pywefFmg3/XrLnRrxWc2IeKbU
	VDDeFTcEIhxnzjtAoL8OhDA75haVKbuJkySc4Y+ucOfjD/R2P0ioyB8w7rQ91B07gldaGEFe28C
	CBtRRT7+hfYMHhXzIejN4WD5kmWpmf/+XNq9u6Qg1
X-Gm-Gg: ASbGncuNAXh7VdDCKgxSjR6c+DIDfjFJAxwz2wEGR/4O6EGBDf/S1pjhpUxRv4Ucl8C
	40T5NGbGZgqcVC8Kw4xn6zifVm+dLwAbnsCI2q7ygeCHy0K7nRjhn6+fL/EEctVb+abe76HmHQi
	8tIQD4X3gNUnXhGNHv+/vf/IvEUJLr+njhwP1OFHhFptGMRmV3Ah5shT4+np7VHxc4/IzVmULte
	hoCyUt1ezY4FJ/QAhaRbLQDGw88t3zz4V2G1LM7RP0Is48BRFUPDiA3ibYlFX2gmzsc+xcF
X-Google-Smtp-Source: AGHT+IGv8iVnwuIM9uH3kiA0+B5Xz2rfJaqLRcZB2Stsnz86gPRlM7wvOZR0yPNAN58j7XcfUI5Q2345bywHIPYalr4=
X-Received: by 2002:a17:902:eccd:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-29df9571f4dmr1523955ad.3.1765071823284; Sat, 06 Dec 2025
 17:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com> <aTP4zSy87wEZlbsO@gmail.com>
 <aTQRgAOpKyI53TEq@gmail.com>
In-Reply-To: <aTQRgAOpKyI53TEq@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 6 Dec 2025 17:43:32 -0800
X-Gm-Features: AQt7F2qFYnP8vpdq0ZYx2ko_bxVurHJIaunKzNWmpNu9qMsgPDmY5AAnkXceA08
Message-ID: <CAP-5=fURCzNLC8izLAbu50AV7nhLmCDwaDpfiWkQp3ihgHMNxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Perf stat --null/offline CPU segv related fixes/tests
To: Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 3:20=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > * Ian Rogers <irogers@google.com> wrote:
> >
> > > Ingo reported [1] that `perf stat --null` was segfaulting. Fix the
> > > underlying issue and add a test to the "perf stat tests". Do some
> > > related fixing/cleanup in the perf util cpumap code.
> > >
> > > Thomas reported an issue fixed by the same patches [2] but caused by
> > > giving perf stat an offline CPU. Add test coverage for that and
> > > improve the "error" message that reports "success".
> > >
> > > Ingo further pointed at broken signal handling in repeat mode [3]. I
> > > observed we weren't giving the best exit code, 0 rather than the
> > > expected 128+<signal number>. Add a patch fixing this.
> > >
> > > [1] https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.c=
om/
> > > [2] https://lore.kernel.org/linux-perf-users/94313b82-888b-4f42-9fb0-=
4585f9e90080@linux.ibm.com/
> > > [3] https://lore.kernel.org/lkml/aS5wjmbAM9ka3M2g@gmail.com/
> > >
> > > Ian Rogers (7):
> > >   perf stat: Allow no events to open if this is a "--null" run
> > >   libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map
> > >   perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
> > >   perf tests stat: Add "--null" coverage
> > >   perf stat: When no events, don't report an error if there is none
> > >   perf tests stat: Add test for error for an offline CPU
> > >   perf stat: Improve handling of termination by signal
> > >
> > >  tools/lib/perf/cpumap.c        | 10 +++++----
> > >  tools/perf/builtin-stat.c      | 29 ++++++++++++++++++-------
> > >  tools/perf/tests/shell/stat.sh | 39 ++++++++++++++++++++++++++++++++=
++
> > >  tools/perf/util/cpumap.c       |  9 ++++++--
> > >  4 files changed, 73 insertions(+), 14 deletions(-)
> >
> > A belated:
> >
> >   Tested-by: Ingo Molnar <mingo@kernel.org>
> >
> > And thank you a lot for doing these QoL fixes!
>
> There's one more perf stat QoL bug I'd like to report - I frequently
> do repeated runs of perf stat --repeat and grep the output, to get
> a feel for the run-to-run stability of a particular benchmark:
>
>   starship:~/tip> while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 =
| grep elapsed; done
>          0.1017997 +- 0.0000771 seconds time elapsed  ( +-  0.08% )
>          0.1017627 +- 0.0000795 seconds time elapsed  ( +-  0.08% )
>          0.1018106 +- 0.0000650 seconds time elapsed  ( +-  0.06% )
>          0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
>           0.101883 +- 0.000169 seconds time elapsed  ( +-  0.17% ) <=3D=
=3D=3D=3D
>          0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )
>          0.1017991 +- 0.0000720 seconds time elapsed  ( +-  0.07% )
>          0.1018024 +- 0.0000704 seconds time elapsed  ( +-  0.07% )
>          0.1018074 +- 0.0000946 seconds time elapsed  ( +-  0.09% )
>          0.1019797 +- 0.0000524 seconds time elapsed  ( +-  0.05% )
>          0.1018407 +- 0.0000658 seconds time elapsed  ( +-  0.06% )
>          0.1017907 +- 0.0000605 seconds time elapsed  ( +-  0.06% )
>          0.1018328 +- 0.0000868 seconds time elapsed  ( +-  0.09% )
>          0.1017469 +- 0.0000285 seconds time elapsed  ( +-  0.03% )
>          0.1019589 +- 0.0000549 seconds time elapsed  ( +-  0.05% )
>          0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
>           0.101868 +- 0.000117 seconds time elapsed  ( +-  0.12% ) <=3D=
=3D=3D=3D
>          0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )
>          0.1017728 +- 0.0000718 seconds time elapsed  ( +-  0.07% )
>          0.1017821 +- 0.0000419 seconds time elapsed  ( +-  0.04% )
>          0.1018328 +- 0.0000581 seconds time elapsed  ( +-  0.06% )
>          0.1017836 +- 0.0000853 seconds time elapsed  ( +-  0.08% )
>          0.1018124 +- 0.0000765 seconds time elapsed  ( +-  0.08% )
>          0.1018706 +- 0.0000639 seconds time elapsed  ( +-  0.06% )
>
> Note the two outliers, which happen due to some misguided
> output optimization feature in perf shortening zero-ended
> numbers unnecessarily, and adding noise to the grepped
> output's vertical alignment.
>
> Those two lines should be:
>
>          0.1017844 +- 0.0000601 seconds time elapsed  ( +-  0.06% )
>          0.1018830 +- 0.0001690 seconds time elapsed  ( +-  0.17% ) <=3D=
=3D=3D=3D
>          0.1017757 +- 0.0000532 seconds time elapsed  ( +-  0.05% )
>
>          0.1018465 +- 0.0000891 seconds time elapsed  ( +-  0.09% )
>          0.1018680 +- 0.0001170 seconds time elapsed  ( +-  0.12% ) <=3D=
=3D=3D=3D
>          0.1017705 +- 0.0000590 seconds time elapsed  ( +-  0.06% )
>
> (The zeroes are printed fully, to full precision.)
>
> Basically random chance causing an apparent lack of significant
> numbers doesn't mean the tool should strip them from the output.

Ugh. I'm not sure why the output is like that. Searching back through
history it seems you are to blame :-)
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/builtin-stat.c?h=3Dperf-tools-next&id=3Dbc22de9bcdb2249=
150fb5b3c48fdc4f6bedd3ad7

Perhaps we can drop the precision printf flag and just make the flags
fixed. I think this output is obscure enough that nobody cares about
minor changes.

Thanks,
Ian

> Thanks,
>
>         Ingo

Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F148C8A9
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515872; cv=pass; b=GOR2g7lBIWnxIJz/6PRDkT/DKA36I6X1r+JdMEeAxcwybb7/4cWKx5PkfHjao7IeVk98nd1Qxi7+xE/vKExRBr+Pj83IPvGPDrs+7+I08OY1dZE+87W3A7A1uil7TSSrjQDqk16CX8mXdblM3bpR6a9qqoSRADwHlxPjcRbREEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515872; c=relaxed/simple;
	bh=N/j11mVi1pw6k/jtLgc5XXHiPsW6Fd1ky9CN5Dz8YKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqCggyfcgdUH9AXxsIe+aUMaRPaHbOiOr22OdvIxeeGao1gvmSA6fYr3L6uEjQs8B7IyJ2PGFWI6QIjJk8fqoCTewKvfHpdfoCnnMtmb9YNO0QQewiaE+bIpbAtczR4ZB7Ry6XXY7AGZFNmAgTpw6XMeJyWRoQLh1SqB8czMjU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZaUUnp4; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZaUUnp4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b1a48855so27195ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 12:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780515868; cv=none;
        d=google.com; s=arc-20240605;
        b=cbFiot3/gTHsQlL+BPq9wMjwVpAOBtbsqHalM5DPlIXRv2raAeuhyT0t1NSt63J8/a
         GDR6twAqbOBnZWCvOK20t4rvfVt+LOxtLhbGfLStPOB6SSxdiFrhtHDL9+9PdSPSFH2U
         tgdy6GMYx78lORsBp4G/vgdHjhchpuad0nvxk+n2fQekyFHxmEHRBi2e8jLBOU8pcEX2
         REUe1/puqCoJFBJJIMRBdpMgjajX6skmZpYykX2SRylbnISAZ70J+hklG5qyKPEwRqib
         5ZTCACG7xTnmxoO0YPjy1CBWlsj7dk1b3Dj5XAeAmMgwoksvCe1rbB/szR8rdBtPorX7
         qncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KD9QkPCPhizbORV6MflqV3JLry7KfRyDD2vKeNkVDyE=;
        fh=bPhr9/HI+NqRqtz2qWeXyjK/drxOskTzWEUo+3yNmcg=;
        b=RrodiDu7KlMz+AEsDWw1HsiQbzszgbBD+7MsYcbFEwSXYegrpVeAbaBW/NRbGMadAO
         7L4C2IKZ+QVw2oJTraGeVMKYs10u9QgltjyADmhbhLwlR4eVTenJZA0eu+4Ya750zd8j
         t4m/vPnvlKGG2DhYgnYMsA81eKvKXglTzb9ShUMuqp31H+tSkB0kGjqJ5aZlUwOQNFH2
         HYlbevtvVeShiMlsrsbtQQEl3Qxe3HfjG+0M/zm7KyFeeCSCBDTLKIgF30+bECEJ0pNW
         re2sez9bvkQKGbGm++Qdg9KXBeVpT5di09l1kuWCa+7o5Yf4Uty7GqT4N7D+U3mIZuOs
         Vfag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780515868; x=1781120668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD9QkPCPhizbORV6MflqV3JLry7KfRyDD2vKeNkVDyE=;
        b=kZaUUnp4hRHZGeKNxn3hLeg/5aKX8Hu54GMNkpcOgd0j3xAL3LaITwjuUfuxfYV5qD
         klmUwvS9/KtRv8ZYCyHS2bvLhQctIJ0GyTvKPufV+Y2zVzQwg327jDXrInRyP4MxWTyC
         AGb6GW+955L8mXfWQqf2V7nNi1p+2jEgXHpFLgG0Bh2UsRzQthySVHMEqirWkMqvnqhP
         wD4hKx6olVWONTIts8NojSissIcRqTcVxu3327F+az4Uq2qaRSkkgFGO39sEgp8Dm7VM
         Lpl74nltZ1n+wNH99l6yyphGW+Bo6wXn5s3CepPjavlkuDcaZ7tNqlqe6/vno5gXAv5/
         uUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780515868; x=1781120668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KD9QkPCPhizbORV6MflqV3JLry7KfRyDD2vKeNkVDyE=;
        b=oLpuuCT3OmvULJbKGw6NPC1TqKNfls1TKijV9EkdRJVJNUv1hhMyIDckKPMLf2pRBJ
         PSfh2ibN34SjqhiG6O33jeO3kdBCQzCPgVK6mjD9Z8HFlG3UkKU0g5Trf6q53/OTWafj
         /q3+UeB2c0LEbT3UrOJF3/nKAoxTuDQ2zhpRpRCs1XH02UIGduPKS2RfycmIcpYvZznW
         4zoIAvc+9K4wTIviSe0ioHJJz5s26s09L43iF1120XG4xR6fzqskFzrQbc6+nkfFmsFZ
         b0UmE/wp3ZLLmYM//SO2gdTTvj60CzJghdY5WTa1D2wRxSbfuXXZ9cQ7RQKqrHADlzHr
         NYTg==
X-Forwarded-Encrypted: i=1; AFNElJ/dSSePJeoVGV1Z9ta4gfAz1jkt6QFNfiGhpNeAwruRI6RxzZYGK8UpBVo64Y67fINFsiqIV8+8oIRGZ9LkLElO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46/CoyXurG8zF5DtCalPsQNLOFV/Zu8ETDy9hGdqORdgV1DKU
	4RLLAMRjrsgZiHKpwoKw04KCAWwi7/lAbU7ZMMr8AtE7YRYDv3Df5pyu8B+1xMMvvvJRlFrJnUX
	6ddvjYBNCsPdqGVE9YBy8KrMLAlEoXgHk5GuLC50D
X-Gm-Gg: Acq92OFZHyqFIMOmZ135kAm1sK18bTz0X1n/OHXzcx2EN6PsilwOzF37I7r22AG6xM2
	FQU2XVBa0bvlRs873h3G+TAI/C4l5rpfpwNJjauPq2PByHK7/R9GTqcEW8tpwh5GqMiGZ0uLn/e
	qmP8EiCUl1IZxzghgxqLCCSqO/2ypAZ5tAfZiAx1OeNWl47R2GfzjyHBX+2yDfAo/qx7Yc9FHXP
	eytd4EZ8bdOnTAgibgPWyVnYiMHLlEVOL7nkj/0vT+XutVscx7+3lkAJi2E5PaR2V6zd+dFHxay
	5GPANFrr433uhy+ZjGBjzZaphzIasD8hf7fD+lEQvLkDhof4
X-Received: by 2002:a17:902:ebcd:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2c198b296a5mr598255ad.18.1780515867207; Wed, 03 Jun 2026
 12:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <CAP-5=fVR5zLokhki3CnQTkG1Lb0C2y=BYVRUEYG9fsCXWVfZ5A@mail.gmail.com>
 <aiCAMLNG_VBvUZy9@x1>
In-Reply-To: <aiCAMLNG_VBvUZy9@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 12:44:16 -0700
X-Gm-Features: AVHnY4J1EajNdTg48x8vk_8lyluWYv6X6tCevMXq7-WYO2IHy85ypCWv-rAhsyE
Message-ID: <CAP-5=fWj6d3+S=71-vwaoQCfBTRVzjynO9UxySyTKmdq_ExYPg@mail.gmail.com>
Subject: Re: [PATCHES 0/8] perf tools: Diagnostic offsets in skip messages +
 two hardening fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 12:27=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jun 03, 2026 at 08:06:48AM -0700, Ian Rogers wrote:
> > On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > When perf report, perf sched, or perf timechart skip a malformed or
> > > unprocessable event, the warning message doesn't say where in the
> > > perf.data file the problem occurred.  This makes it hard to
> > > cross-reference with 'perf report -D' output or to locate the
> > > corrupted region with a hex editor.
> > >
> > > This series adds a file_offset field to struct perf_sample, set in th=
e
> > > event delivery path (including the deferred callchain path), and
> > > retrofits all skip/stop/error messages to include:
> > >
> > >   - The file offset where the event was found
> > >   - The event type name via perf_event__name() with the numeric
> > >     type value in parentheses
> > >
> > > For example, instead of:
> > >
> > >   problem processing 10 event, skipping it.
> > >
> > > a user now sees:
> > >
> > >   WARNING: at offset 0x1a3f0: MMAP2 (10) event size 24 too small (min=
 64), skipping
> > >
> > > The peek_event() path, which validates events during initial file
> > > scanning, also gains file offsets in its three warning messages
> > > (misaligned size, unsupported type, undersized event).
> > >
> > > Two pre-existing bugs found by sashiko-bot are fixed:
> > >
> > >   - builtin-timechart.c cat_backtrace(): use-after-free and
> > >     double-free when an invalid callchain context triggers zfree()
> > >     before fclose() on an open_memstream buffer.  The open_memstream
> > >     contract requires fclose() before the buffer can be freed =E2=80=
=94 see
> > >     open_memstream(3).
> >
> > Fwiw, I've also been around the timechart code prompted by AI review
> > and also trying to clean up tests with address sanitizer:
> > https://lore.kernel.org/linux-perf-users/agzWqrn6XPEwTAsb@google.com/
>
> Thanks for all the reviews, I'll merge this series since sashiko found
> just one endianess issue with the new 'perf test' entry and the other
> comments are for pre-existing problems that we've added to TODO lists,
> then you can rebase that timechart leaks on top of it, ok?

Sure. I thought we merged the timechart issue fix with this:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/builtin-timechart.c?h=3Dperf-tools-next&id=3D00b36b394c=
15f625fa166ba3b399cad5bd5065f9
So you may well be fixing other issues I introduced while trying to
implement that fix.

Thanks,
Ian

> - Arnaldo
>
> > Thanks,
> > Ian
> >
> > >   - builtin-sched.c: three BUG_ON(cpu >=3D MAX_CPUS || cpu < 0)
> > >     that abort perf sched when PERF_SAMPLE_CPU is absent from the
> > >     sample type and the CPU sentinel (u32)-1 is cast to signed -1.
> > >     perf.data is untrusted input =E2=80=94 a corrupted or truncated f=
ile
> > >     should produce a warning, not an abort.
> > >
> > > Arnaldo Carvalho de Melo (8):
> > >   perf sample: Add file_offset field to struct perf_sample
> > >   perf session: Include file offset in event skip/stop messages
> > >   perf sched: Include file offset in event skip messages
> > >   perf timechart: Include file offset in CPU bounds check messages
> > >   perf tools: Include file offset and event type name in skip message=
s
> > >   perf timechart: Fix cat_backtrace() use-after-free on corrupted cal=
lchain
> > >   perf sched: Replace BUG_ON on invalid CPU with graceful skip
> > >   perf test: Add file offset diagnostic test for corrupted perf.data
> > >
> > >  15 files changed, 261 insertions(+), 101 deletions(-)
> > >
> > > Developed with AI assistance (Claude/sashiko), tagged in commits.
> > >
> > > Best regards,
> > >
> > > - Arnaldo

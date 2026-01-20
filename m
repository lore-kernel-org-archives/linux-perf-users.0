Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AC426ECD
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931635; cv=pass; b=cWADPa0Amkw36mus5vQF2p95Zt6wFS+8+KN03/ws9WjNjAGSMG8CmBwMRxO/2BfXkpDdr1MO+/gXMmyA+IubEP7QtN5v4q8DsSCnhQPmTw6tU+HigI1lBfH4MIMKdpx6kdxyEEb6/xbzjoNaqtF8p45fjyfejiDzmvTYueZO11M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931635; c=relaxed/simple;
	bh=sr3QBStHJeEw3C3U9XzeCypbbqfz2SSolOzlY41+7+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLoSWlwZv5ZfQH8BxNYX6I1m9VNoWjIPJQYMSg42+6fw2sK7aghqfdtIHbgWlz1MkYCVyTbWEABc20Z0MXIfN5NR2epPrj3tF+8kgCxken7dGQKiWiPiDBp2+G7Qs1+T0beI3hHL25UJCGXANu2qk63d7uREI+NV8e9zHVKKpfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZImf8nP6; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZImf8nP6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06cfa93so2305ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 09:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768931632; cv=none;
        d=google.com; s=arc-20240605;
        b=KtVKMquas2pJ0YsV2uEs9RTeKbN9jXjZpCbBGBZPwF85Ehxa0NppsLMjmJ7k3zEB2y
         +wbRX3cVsj2KgfV3We6tKoVjxNmpteGjqMz6T0CguHrNjjGKEgoQLx1xr5Tv0BvISvMr
         EdZSKmfoL6aBnyhdbtqnYWt+OOi/l5P1rRfLTInMRoLpaM1fQ/LgOtmPr4YieocIac6i
         Ydfy11QJ5IVzGrK+hC3sx/ZmMftXkB25CtH+6++WeI/StfRHHI3Eqj9Fo0m9gI9mh/2V
         4aTDrVUoQ3oN8euY5/9jNNfHOhwyrq497ELBZBr9Ib/trauR/0Yimo6H9q8M9/59d6oe
         EVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/fDt/C8QZJaXJUn286TaIKJsXNO0IK1Mn9UWJCVwlOc=;
        fh=vWRa1/sci5LpeHrg79+KO1YDsDI13LjG0WXSUTvRdRY=;
        b=Ni+vXzud9pmdVZUB3M8TppKKtCOo95A7E5vfdUPGPJlUkLgzhA1mJR3Hb3rcS2ICxH
         /aw/2+NW0TGcBc3HND9INx4V7YeQrm1T2IKOz4hvZ29xLeDb1Gwxay0dLTWB046RH2Ov
         RxPOKxp+igRj/+gncrAI69QV/zBy7MWvD1J5/JGl/Y3WO40okDobYytwbHNrZJsOJlBU
         99x+WnICaxWA4pOjyFthi7KkUIVvDGlbkUtfnQNES15WNUQl8We61a/DLiu42AzAx65D
         yuoKafxKdAwp+35Sr4qkFYt21LFLh07JuXfRqDIK89L+alJLDocw6jGCRCLezuR6Dijj
         yQAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768931632; x=1769536432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fDt/C8QZJaXJUn286TaIKJsXNO0IK1Mn9UWJCVwlOc=;
        b=ZImf8nP6FeLHdVz645sHMANnJ+7w+wOm9fMUGbMMrYriLcK1x7tgunvE01es8HWghK
         lGE9ARtAyySXpS6uGsuDLfS7hC9sB/vSgTm3FFP6NCGsHp/d305ToPYkyiDDBGdkGnHc
         unHhGjHIFR5/GRjwYaTkkkhB2yMOHkWGTsB0t9sfrrKJVD84TntEGcMWjD2TodTdwINE
         jwe32OxCtSYVM8DOAdkBzx9iYsWK64aSWd0X3KMnc0TApgGliFQvCpdz3aj8drwvcQAd
         EbONAteJ8ZJg9qOZegJxf4YN3kTslKQQ2muhsiH9STEq9K9TvC6mizpBBYlQYb+jx//l
         CSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931632; x=1769536432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/fDt/C8QZJaXJUn286TaIKJsXNO0IK1Mn9UWJCVwlOc=;
        b=qUndSauqwbb5c+28Uc5vcdp8UmRdS5FgvqwFWm7hVpuYXIKSm2nda3Nwfz/pIL+WgH
         TBfdEJh4PYX2lWUPEz2HQQ55gQ7UaTgJ9tpujMIY/WuRfRstOGH5GhS2NoqBJ4MMa/J1
         5dbc6r/SueNKSefBF3+UTZSBSoiKfGJ9Ls9R1rkRUml/b3iPi/iLuy85/bwdKSny1Non
         kjn5r7P0FZQp4zp5nKdtR87BVGUzYgIfFWJCB2ntnlhWhvoUILTORAxVMU+CSkL1qy/z
         cnsiDb7QdtojZfHbHGV2d/qxs2Axhqb1l7e01+xeGNrS9XFLe2GRvUEcagTnyb6uT/Jy
         DA0A==
X-Forwarded-Encrypted: i=1; AJvYcCV3JnhHQwnCU2yz5cNeOy7mJtwr95/Lj/EguKeQUWrSDZbPn9d0e5zefrKpv+2b5KTjV1SeOSFY6r2ofR3TG8FB@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHqfPWViSlck3AIMzGzCJAFkC8BQ7klwaTOHX71BgsPXpV2jv
	xPS6eXo1z8pIBkDIgYhFTRz2EUzGlDFTbSvATH9kLgbzXAHCSMpc9OwbeBDgnlLOlufWxkA+s8U
	EGvgjdr6n1flLBNLz3sQgGSeWOcVfQhEbHKxhA+Zd
X-Gm-Gg: AZuq6aJy98HvQLSK920jfnGHQrHZlubjYb83B2rLzmaOGUN/QRYaN7JCKyBK8gjuHtx
	PH0WOYWHGUWfLEiqDf0GORBXBTEda71rZRDPPfvL0xIFmn9l8uhejyoYa99ZilJToQ2h51NQpHu
	OLRFLjdCJocAykeQybmxYYf8wRm3/CmBDhOQg7aHJwqiO1IGb4YJyPv48JC5feahSLobK10uPbN
	HzYg+g0s4fkiLZCVX9mXatmDryafXFGYn65zmp5w2zOKJtqvm8/Y9pJW5c+AqF2hsaqOAnVmsQo
	XhU7/Bsrf9qPejbmSfnGuV6d+dyNDAX20ZrG
X-Received: by 2002:a17:903:124a:b0:29f:f71:a3b9 with SMTP id
 d9443c01a7336-2a72a79f963mr9063605ad.5.1768931631703; Tue, 20 Jan 2026
 09:53:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com> <20260117052849.2205545-5-irogers@google.com>
 <aW-nEbT9iPF06CwY@x1>
In-Reply-To: <aW-nEbT9iPF06CwY@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 09:53:40 -0800
X-Gm-Features: AZwV_QjzEJaVNDMvVtyi6y9JbEp5oc241PG7AvjGVGz2B1ytklThLrTtGh9XDMk
Message-ID: <CAP-5=fU3WaoONKBVyAEfd1BZTjKgXV_vqsyrw38dmseUpgo6gQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/23] perf unwind-libdw: fix a cross-arch unwinding bug
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Shimin Guo <shimin.guo@skydio.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 8:02=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Jan 16, 2026 at 09:28:30PM -0800, Ian Rogers wrote:
> > From: Shimin Guo <shimin.guo@skydio.com>
> >
> > The set_initial_registers field of Dwfl_Thread_Callbacks needs to be se=
t
> > according to the arch of the stack samples being analyzed, not the arch
> > that perf itself is built for. Currently perf fails to unwind stack sam=
ples
> > collected from archs different from that of the host perf is running on=
.
> > This patch moves the arch-specific implementations of set_initial_regis=
ters
> > from tools/perf/arch to tools/perf/utli/unwind-libdw-arch, similar to t=
he
> > way the perf-regs-arch folder contains arch-specific functions related =
to
> > registers, and chooses the implementation based on the arch of the data
> > being processed.
>
> Since this one is coming thru you, we need your:
>
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ok?
>
> I'm adding it here, please ack.

Acked. Sorry for the problem.

Ian

> - Arnaldo
>
> > Signed-off-by: Shimin Guo <shimin.guo@skydio.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/arch/arm/util/Build                |  1 -
> >  tools/perf/arch/arm64/util/Build              |  1 -
> >  tools/perf/arch/csky/util/Build               |  2 -
> >  tools/perf/arch/powerpc/util/Build            |  1 -
> >  tools/perf/arch/riscv/util/Build              |  1 -
> >  tools/perf/arch/s390/util/Build               |  2 -
> >  tools/perf/arch/x86/util/Build                |  1 -
> >  tools/perf/util/Build                         |  1 +
> >  tools/perf/util/unwind-libdw-arch/Build       |  8 +++
> >  .../unwind-libdw-arch/unwind-libdw-arm.c}     | 10 ++--
> >  .../unwind-libdw-arch/unwind-libdw-arm64.c}   | 10 ++--
> >  .../unwind-libdw-arch/unwind-libdw-csky.c}    | 10 ++--
> >  .../unwind-libdw-loongarch.c}                 | 10 ++--
> >  .../unwind-libdw-arch/unwind-libdw-powerpc.c} | 10 ++--
> >  .../unwind-libdw-arch/unwind-libdw-riscv.c}   | 10 ++--
> >  .../unwind-libdw-arch/unwind-libdw-s390.c}    | 14 ++---
> >  .../unwind-libdw-arch/unwind-libdw-x86.c}     |  8 +--
> >  tools/perf/util/unwind-libdw.c                | 51 ++++++++++++++++---
> >  tools/perf/util/unwind-libdw.h                | 10 +++-
> >  19 files changed, 104 insertions(+), 57 deletions(-)
> >  create mode 100644 tools/perf/util/unwind-libdw-arch/Build
> >  rename tools/perf/{arch/arm/util/unwind-libdw.c =3D> util/unwind-libdw=
-arch/unwind-libdw-arm.c} (80%)
> >  rename tools/perf/{arch/arm64/util/unwind-libdw.c =3D> util/unwind-lib=
dw-arch/unwind-libdw-arm64.c} (87%)
> >  rename tools/perf/{arch/csky/util/unwind-libdw.c =3D> util/unwind-libd=
w-arch/unwind-libdw-csky.c} (90%)
> >  rename tools/perf/{arch/loongarch/util/unwind-libdw.c =3D> util/unwind=
-libdw-arch/unwind-libdw-loongarch.c} (86%)
> >  rename tools/perf/{arch/powerpc/util/unwind-libdw.c =3D> util/unwind-l=
ibdw-arch/unwind-libdw-powerpc.c} (89%)
> >  rename tools/perf/{arch/riscv/util/unwind-libdw.c =3D> util/unwind-lib=
dw-arch/unwind-libdw-riscv.c} (87%)
> >  rename tools/perf/{arch/s390/util/unwind-libdw.c =3D> util/unwind-libd=
w-arch/unwind-libdw-s390.c} (84%)
> >  rename tools/perf/{arch/x86/util/unwind-libdw.c =3D> util/unwind-libdw=
-arch/unwind-libdw-x86.c} (87%)
> >
> > diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/=
Build
> > index fd695e1fdaee..3291f893b943 100644
> > --- a/tools/perf/arch/arm/util/Build
> > +++ b/tools/perf/arch/arm/util/Build
> > @@ -1,6 +1,5 @@
> >  perf-util-y +=3D perf_regs.o
> >
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> >  perf-util-y +=3D pmu.o auxtrace.o cs-etm.o
> > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/u=
til/Build
> > index d63881081d2e..0177af19cc00 100644
> > --- a/tools/perf/arch/arm64/util/Build
> > +++ b/tools/perf/arch/arm64/util/Build
> > @@ -1,4 +1,3 @@
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> >  perf-util-y +=3D ../../arm/util/auxtrace.o
> > diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/uti=
l/Build
> > index 5e6ea82c4202..6b2d0e021b11 100644
> > --- a/tools/perf/arch/csky/util/Build
> > +++ b/tools/perf/arch/csky/util/Build
> > @@ -1,3 +1 @@
> >  perf-util-y +=3D perf_regs.o
> > -
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/power=
pc/util/Build
> > index 3d0d5427aef7..5fd28ec713a4 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -9,5 +9,4 @@ perf-util-y +=3D evsel.o
> >  perf-util-$(CONFIG_LIBDW) +=3D skip-callchain-idx.o
> >
> >  perf-util-$(CONFIG_LIBUNWIND) +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >  perf-util-y +=3D auxtrace.o
> > diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/u=
til/Build
> > index 58a672246024..628b9ebd418b 100644
> > --- a/tools/perf/arch/riscv/util/Build
> > +++ b/tools/perf/arch/riscv/util/Build
> > @@ -2,4 +2,3 @@ perf-util-y +=3D perf_regs.o
> >  perf-util-y +=3D header.o
> >
> >  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/uti=
l/Build
> > index c64eb18dbdae..5391d26fedd4 100644
> > --- a/tools/perf/arch/s390/util/Build
> > +++ b/tools/perf/arch/s390/util/Build
> > @@ -2,8 +2,6 @@ perf-util-y +=3D header.o
> >  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >  perf-util-y +=3D perf_regs.o
> >
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > -
> >  perf-util-y +=3D machine.o
> >  perf-util-y +=3D pmu.o
> >
> > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/=
Build
> > index c0dc5965f362..fad256252bb9 100644
> > --- a/tools/perf/arch/x86/util/Build
> > +++ b/tools/perf/arch/x86/util/Build
> > @@ -12,7 +12,6 @@ perf-util-y +=3D evsel.o
> >  perf-util-y +=3D iostat.o
> >
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> >  perf-util-y +=3D auxtrace.o
> >  perf-util-y +=3D archinsn.o
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 4915f237ba9e..5efec73be474 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -227,6 +227,7 @@ perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> >  perf-util-$(CONFIG_LIBDW) +=3D libdw.o
> >
> >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arch/
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local.o
> >  perf-util-$(CONFIG_LIBUNWIND)          +=3D unwind-libunwind.o
> >  perf-util-$(CONFIG_LIBUNWIND_X86)      +=3D libunwind/x86_32.o
> > diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/=
unwind-libdw-arch/Build
> > new file mode 100644
> > index 000000000000..ef17a83a7813
> > --- /dev/null
> > +++ b/tools/perf/util/unwind-libdw-arch/Build
> > @@ -0,0 +1,8 @@
> > +perf-util-y +=3D unwind-libdw-x86.o
> > +perf-util-y +=3D unwind-libdw-arm.o
> > +perf-util-y +=3D unwind-libdw-arm64.o
> > +perf-util-y +=3D unwind-libdw-csky.o
> > +perf-util-y +=3D unwind-libdw-loongarch.o
> > +perf-util-y +=3D unwind-libdw-powerpc.o
> > +perf-util-y +=3D unwind-libdw-riscv.o
> > +perf-util-y +=3D unwind-libdw-s390.o
> > diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-arm.c
> > similarity index 80%
> > rename from tools/perf/arch/arm/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> > index fbb643f224ec..56e9b5975bcc 100644
> > --- a/tools/perf/arch/arm/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> > @@ -1,11 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > -#include "../../../util/sample.h"
> > +#include "../arch/arm/include/uapi/asm/perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> > +#include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/uti=
l/unwind-libdw-arch/unwind-libdw-arm64.c
> > similarity index 87%
> > rename from tools/perf/arch/arm64/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> > index b89b0a7e5ad9..29b6833e036c 100644
> > --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> > @@ -1,11 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > -#include "../../../util/sample.h"
> > +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> > +#include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/util=
/unwind-libdw-arch/unwind-libdw-csky.c
> > similarity index 90%
> > rename from tools/perf/arch/csky/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> > index b20b1569783d..2556d034c32a 100644
> > --- a/tools/perf/arch/csky/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> > @@ -2,12 +2,12 @@
> >  // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> >
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > +#include "../arch/csky/include/uapi/asm/perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> > +#include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf=
/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > similarity index 86%
> > rename from tools/perf/arch/loongarch/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > index 60b1144bedd5..5fca673508be 100644
> > --- a/tools/perf/arch/loongarch/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > @@ -2,12 +2,12 @@
> >  /* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
> >
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/sample.h"
> > +#include "../arch/loongarch/include/uapi/asm/perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> > +#include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *=
arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/u=
til/unwind-libdw-arch/unwind-libdw-powerpc.c
> > similarity index 89%
> > rename from tools/perf/arch/powerpc/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> > index 82d0c28ae345..1560db45e7b4 100644
> > --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> > @@ -1,10 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> >  #include <linux/kernel.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > -#include "../../../util/sample.h"
> > +#include "../arch/powerpc/include/uapi/asm/perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> > +#include "util/sample.h"
> >
> >  /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
> >  static const int special_regs[3][2] =3D {
> > @@ -13,7 +13,7 @@ static const int special_regs[3][2] =3D {
> >       { 109, PERF_REG_POWERPC_CTR },
> >  };
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *ar=
g)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/uti=
l/unwind-libdw-arch/unwind-libdw-riscv.c
> > similarity index 87%
> > rename from tools/perf/arch/riscv/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> > index dc1476e16321..c2e2c4b6b2e0 100644
> > --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> > @@ -2,12 +2,12 @@
> >  /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
> >
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/sample.h"
> > +#include "../arch/riscv/include/uapi/asm/perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> > +#include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/util=
/unwind-libdw-arch/unwind-libdw-s390.c
> > similarity index 84%
> > rename from tools/perf/arch/s390/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> > index c27c7a0d1076..1e05e9d9d95f 100644
> > --- a/tools/perf/arch/s390/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> > @@ -1,14 +1,14 @@
> >  #include <linux/kernel.h>
> >  #include <elfutils/libdwfl.h>
> > -#include "../../util/unwind-libdw.h"
> > -#include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > -#include "../../util/sample.h"
> > -#include "dwarf-regs-table.h"
> > -#include "perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> > +#include "util/event.h"
> > +#include "util/sample.h"
> > +#include "../arch/s390/include/dwarf-regs-table.h"
> > +#include "../arch/s390/include/uapi/asm/perf_regs.h"
> >
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-x86.c
> > similarity index 87%
> > rename from tools/perf/arch/x86/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> > index 798493e887d7..dd27545a4a68 100644
> > --- a/tools/perf/arch/x86/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> > @@ -1,11 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > -#include "../../../util/unwind-libdw.h"
> > -#include "../../../util/perf_regs.h"
> > +#include "../arch/x86/include/uapi/asm/perf_regs.h"
> > +#include "util/unwind-libdw.h"
> > +#include "util/perf_regs.h"
> >  #include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg)
> >  {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-li=
bdw.c
> > index 3ff427a49e4c..b2e194a8be39 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -225,11 +225,45 @@ static bool memory_read(Dwfl *dwfl __maybe_unused=
, Dwarf_Addr addr, Dwarf_Word *
> >       return true;
> >  }
> >
> > -static const Dwfl_Thread_Callbacks callbacks =3D {
> > -     .next_thread            =3D next_thread,
> > -     .memory_read            =3D memory_read,
> > -     .set_initial_registers  =3D libdw__arch_set_initial_registers,
> > -};
> > +#define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
> > +static const Dwfl_Thread_Callbacks callbacks_##arch =3D {             =
 \
> > +     .next_thread           =3D next_thread,                        \
> > +     .memory_read           =3D memory_read,                        \
> > +     .set_initial_registers =3D libdw_set_initial_registers_##arch, \
> > +}
> > +
> > +DEFINE_DWFL_THREAD_CALLBACKS(x86);
> > +DEFINE_DWFL_THREAD_CALLBACKS(arm);
> > +DEFINE_DWFL_THREAD_CALLBACKS(arm64);
> > +DEFINE_DWFL_THREAD_CALLBACKS(csky);
> > +DEFINE_DWFL_THREAD_CALLBACKS(loongarch);
> > +DEFINE_DWFL_THREAD_CALLBACKS(powerpc);
> > +DEFINE_DWFL_THREAD_CALLBACKS(riscv);
> > +DEFINE_DWFL_THREAD_CALLBACKS(s390);
> > +
> > +static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *a=
rch)
> > +{
> > +     if (!strcmp(arch, "arm"))
> > +             return &callbacks_arm;
> > +     else if (!strcmp(arch, "arm64"))
> > +             return &callbacks_arm64;
> > +     else if (!strcmp(arch, "csky"))
> > +             return &callbacks_csky;
> > +     else if (!strcmp(arch, "loongarch"))
> > +             return &callbacks_loongarch;
> > +     else if (!strcmp(arch, "powerpc"))
> > +             return &callbacks_powerpc;
> > +     else if (!strcmp(arch, "riscv"))
> > +             return &callbacks_riscv;
> > +     else if (!strcmp(arch, "s390"))
> > +             return &callbacks_s390;
> > +     else if (!strcmp(arch, "x86"))
> > +             return &callbacks_x86;
> > +
> > +     pr_err("Fail to get thread callbacks for arch %s, returns NULL\n"=
,
> > +            arch);
> > +     return NULL;
> > +}
> >
> >  static int
> >  frame_callback(Dwfl_Frame *state, void *arg)
> > @@ -278,6 +312,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void =
*arg,
> >       const char *arch =3D perf_env__arch(ui_buf.machine->env);
> >       Dwarf_Word ip;
> >       int err =3D -EINVAL, i;
> > +     const Dwfl_Thread_Callbacks *callbacks;
> >
> >       if (!data->user_regs || !data->user_regs->regs)
> >               return -EINVAL;
> > @@ -300,7 +335,11 @@ int unwind__get_entries(unwind_entry_cb_t cb, void=
 *arg,
> >       if (err)
> >               goto out;
> >
> > -     err =3D !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread)=
, &callbacks, ui);
> > +     callbacks =3D get_thread_callbacks(arch);
> > +     if (!callbacks)
> > +             goto out;
> > +
> > +     err =3D !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread)=
, callbacks, ui);
> >       if (err)
> >               goto out;
> >
> > diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-li=
bdw.h
> > index 8c88bc4f2304..574b29848cce 100644
> > --- a/tools/perf/util/unwind-libdw.h
> > +++ b/tools/perf/util/unwind-libdw.h
> > @@ -9,7 +9,15 @@ struct machine;
> >  struct perf_sample;
> >  struct thread;
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)=
;
> > +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)=
;
> > +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *=
arg);
> > +bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
> > +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *ar=
g);
> > +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)=
;
> > +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
> >
> >  struct unwind_info {
> >       Dwfl                    *dwfl;
> > --
> > 2.52.0.457.g6b5491de43-goog
> >

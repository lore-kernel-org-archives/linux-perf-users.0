Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82683A1E9D
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Dec 2025 05:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766638963; cv=none; b=BRfzt5zN9KW/E1lEJ7EuZQvnujmlkDsxVfVyrPnOUfvsl5XuY8PtkZbGQGTjWZrs281Yao4I79sRVjPJaPsqBQR2mzVRcZ9caBVtns/Ck+tNENwV0kf4FmynRe+i64KXWNXuEARSXmTy5qk0TA7YfgAwbxPR9UKQ89znR7/T3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766638963; c=relaxed/simple;
	bh=KDkxTC316rkGhAOXUvZYXurUx/YxRM3ukluwTrdHS1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4KdLYhXzsC3zayfCSl8b4W4DQxUmkZ7d3XY7rzYh0Jk+uDoQRPtOxphps88W0CNwYlXFDqW8OIiMpNnmMVMnIGSFRzSsyhPuL2ou+Vd19ud5JFOgYEBxLkznsOvEFS5Vz0h/LKcissT3Hwl/ZxC5VhUrgSctyDBwrbXeZ61Xuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=ZjeKwQO4; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="ZjeKwQO4"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11beb0a7bd6so10166750c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 21:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1766638960; x=1767243760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2wbTJJdGrhHraisi4Kb/n0+0ClNXXkqttU7yvTO+5U=;
        b=ZjeKwQO4Li4p+Q3flsA43XTZrYyWXqWdXS2dwCcPyRXVJAiHkDH1T+PwG+Lz9552od
         gbTyxPvnqTVVi3f9g5JbqqyOs9diL8khMZaqd53A2/9U1y5ZN+KcZh7cfTQjpwBU+HsO
         xMUnfijuPTKQE2BjpmH1m1rHboz+5eMqMAlVUvH7CGqDW1Zfz8x9OCuuuZV+EErJ11Od
         7g6Ay3sTYhKr5nTOipxiZfhExUSDShpc5QaUR//79P6X2D79DLV1mL29AZy76sLXZYVj
         NEwsTEub9V6qIcd7nEDKltORWlYMi1TFocCK/YyHcHL1a0iHasqdtqaj85TZjdkqLJ3I
         ebAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766638960; x=1767243760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U2wbTJJdGrhHraisi4Kb/n0+0ClNXXkqttU7yvTO+5U=;
        b=Zz2ta3s32LGPq9w3XxsXVOV+faEM+7LoSmfPXGjltdrHtvnMO8fB+9AGJsDzixZlkp
         TqP+YvHWg4SVPHAzhXsgiStvZYf3FcbzZq2ND6Vc8HlhO900y9X/++d06aDkfv4edr2n
         dBcnNruFJYq3iLnfIZFBvvgw3OE1+jEXAhE0iSf8aM2GtzMee9YoZXKDUGHrXmZDFcr4
         bwsp375tGKuSkADPEh7Osq1JWQx/VSbE79aQn4HiZmQjZYyncgf1ZE/c90WzM8anecyF
         aeCTB0/AzzfiSReH/gnKhSmbDUv1TaJ3Rw9yswAAJF2IXYBNriWWCOqjRD6AMfp6pQWV
         GnRA==
X-Forwarded-Encrypted: i=1; AJvYcCWBu6ycVL24jECLUjpzn4LaNx/TxZq5nqzkeMnjw18857fpdv5d02pdmtGUEXq5Uvd0cRezqLsMDgtJM7L0Sm7b@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg02Q5ymbsr5AmWar4xaAKtYFuzp7kKkrtlw8Byfjn/AbYzkln
	D7dzZ+X0P+tVmAIv0ti3ZUJ3CAHISLzdz6EWGGMOoDkRqrS9Nf49hZjgLheUXTXGWSTPZoNVzh/
	MnReVfSoyi84TO+QokzW5twQixMMpvjjJAr+/PGD33g==
X-Gm-Gg: AY/fxX4S99tGHo4OIDEA6l00X04Gk/eEDiEHxTICOlMz5fFzLNa2VQ4RzZwu4aPuCQp
	67xPYPNgFusYVqlvpPVp9hwYmj8X7JQlgo8nIX+7to7DjBwF2PXy79mvSuQhnzl2Hbdad1SO9Tb
	x1EiAdjmlJk1XKPo5Cj+Y+33SqgM0edVLMP7s0nUo+WYDWB0YiTpZSW7+h97H+KV7nGEPPlPd+y
	BVZ8OPheEIDFBA7A4GDIq9F7MNS41aaeXfx93MQOlPTVRPO91MDON5Qw92fvQli16Ngl+cdnDSq
	bDESSA==
X-Google-Smtp-Source: AGHT+IHF405OTLIUnpDZPz1wFgqAaI4ftQnHSvbrUnCDeurihDC79oUuEYjMUaez4j3D0lX20DltvCoBvxyES26cVAY=
X-Received: by 2002:a05:7022:e01:b0:11b:f271:835a with SMTP id
 a92af1059eb24-120619277e0mr23506891c88.3.1766638959686; Wed, 24 Dec 2025
 21:02:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-cross-arch-unwind-v1-1-4d71ee7db512@skydio.com> <c25d5032-5a41-4e95-ae76-3466875241a0@linaro.org>
In-Reply-To: <c25d5032-5a41-4e95-ae76-3466875241a0@linaro.org>
From: Shimin Guo <shimin.guo@skydio.com>
Date: Wed, 24 Dec 2025 21:02:28 -0800
X-Gm-Features: AQt7F2paMCn4O_uHhbWd51NzweedFAV7Wnuz-qM4AiZxt0bRs6_UYKvOMTrtOWU
Message-ID: <CAK3u-5hE6zAT21bnEa7H-URAP1CsNrgnYu2fJ+t8CBO=xo3tpA@mail.gmail.com>
Subject: Re: [PATCH] perf unwind-libdw: fix a cross-arch unwinding bug
To: James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 5:40=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 24/12/2025 2:19 am, Shimin Guo via B4 Relay wrote:
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
> >
> > Signed-off-by: Shimin Guo <shimin.guo@skydio.com>
> > ---
> > checkpatch flagged three issues:
> >> tools/perf/util/unwind-libdw-arch/Build:232: WARNING: added, moved
> > or deleted file(s), does MAINTAINERS need updating?
> >
> > Not sure what to do about that.
> >
>
> You don't need to do anything here because there's a blanket rule for
> the Perf dir.

PERFORMANCE EVENTS TOOLING ARM64 has a rule that matches tools/perf/arch/ar=
m*/.
The new files for arm and arm64 will no longer be matched by the rule.

>
> >> checkpatch.pl: tools/perf/util/unwind-libdw.c:228: WARNING:
> > Non-declarative macros with multiple statements should be enclosed in
> > a do - while loop
>
> I think you can ignore this one.
>
> >> checkpatch.pl: tools/perf/util/unwind-libdw.c:228: WARNING: macros
> > should not use a trailing semicolon
> >
> > Are these two false positives? I'm defining static global variables
> > with the macro.
>
> But I don't see a reason not to follow this one, just remove the semicolo=
n.

Maybe it doesn't matter, but after I removed the semicolon, I got a new err=
or
from checkpatch "Macros with complex values should be enclosed in parenthes=
es"
instead of the warning that suggests do - while.

>
> > ---
> >   tools/perf/arch/arm/util/Build                     |  1 -
> >   tools/perf/arch/arm64/util/Build                   |  1 -
> >   tools/perf/arch/csky/util/Build                    |  2 -
> >   tools/perf/arch/powerpc/util/Build                 |  1 -
> >   tools/perf/arch/riscv/util/Build                   |  1 -
> >   tools/perf/arch/s390/util/Build                    |  2 -
> >   tools/perf/arch/x86/util/Build                     |  1 -
> >   tools/perf/util/Build                              |  1 +
> >   tools/perf/util/unwind-libdw-arch/Build            |  8 ++++
> >   .../unwind-libdw-arch/unwind-libdw-arm.c}          |  4 +-
> >   .../unwind-libdw-arch/unwind-libdw-arm64.c}        |  4 +-
> >   .../unwind-libdw-arch/unwind-libdw-csky.c}         |  6 +--
> >   .../unwind-libdw-arch/unwind-libdw-loongarch.c}    |  4 +-
> >   .../unwind-libdw-arch/unwind-libdw-powerpc.c}      |  4 +-
> >   .../unwind-libdw-arch/unwind-libdw-riscv.c}        |  4 +-
> >   .../unwind-libdw-arch/unwind-libdw-s390.c}         |  6 +--
> >   .../unwind-libdw-arch/unwind-libdw-x86.c}          |  2 +-
> >   tools/perf/util/unwind-libdw.c                     | 49 +++++++++++++=
++++++---
> >   tools/perf/util/unwind-libdw.h                     | 10 ++++-
> >   19 files changed, 79 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/=
Build
> > index fd695e1fdaee2ccc300a206131b8b38a763b00ce..3291f893b943df0722dff58=
3523fff4ae79919bc 100644
> > --- a/tools/perf/arch/arm/util/Build
> > +++ b/tools/perf/arch/arm/util/Build
> > @@ -1,6 +1,5 @@
> >   perf-util-y +=3D perf_regs.o
> >
> >   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> >   perf-util-y +=3D pmu.o auxtrace.o cs-etm.o
> > diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/u=
til/Build
> > index d63881081d2eb1e9a83eabf82104d75308f7fc79..0177af19cc00038d6a60055=
92ddc530bf7eb1557 100644
> > --- a/tools/perf/arch/arm64/util/Build
> > +++ b/tools/perf/arch/arm64/util/Build
> > @@ -1,4 +1,3 @@
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >   perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >   perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> >   perf-util-y +=3D ../../arm/util/auxtrace.o
> > diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/uti=
l/Build
> > index 5e6ea82c42021d3d5651ca4c4a3a6e5138574e4e..6b2d0e021b11464e46d6b53=
974260d32ea969732 100644
> > --- a/tools/perf/arch/csky/util/Build
> > +++ b/tools/perf/arch/csky/util/Build
> > @@ -1,3 +1 @@
> >   perf-util-y +=3D perf_regs.o
> > -
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/power=
pc/util/Build
> > index 3d0d5427aef7f26a8c05c883cc7ad763f08cbb30..5fd28ec713a4db74ecd1d26=
866a65ddb20e94bd3 100644
> > --- a/tools/perf/arch/powerpc/util/Build
> > +++ b/tools/perf/arch/powerpc/util/Build
> > @@ -9,5 +9,4 @@ perf-util-y +=3D evsel.o
> >   perf-util-$(CONFIG_LIBDW) +=3D skip-callchain-idx.o
> >
> >   perf-util-$(CONFIG_LIBUNWIND) +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >   perf-util-y +=3D auxtrace.o
> > diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/u=
til/Build
> > index 58a672246024dd0f72e767d11e9958bd9913ec3c..628b9ebd418bde8cdf1ab13=
32bf79f7c9d50760e 100644
> > --- a/tools/perf/arch/riscv/util/Build
> > +++ b/tools/perf/arch/riscv/util/Build
> > @@ -2,4 +2,3 @@ perf-util-y +=3D perf_regs.o
> >   perf-util-y +=3D header.o
> >
> >   perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/uti=
l/Build
> > index c64eb18dbdae93adafabf8542e4c9a763ecfe057..5391d26fedd46b7d30a1bef=
0bff2ec2d58ec30ed 100644
> > --- a/tools/perf/arch/s390/util/Build
> > +++ b/tools/perf/arch/s390/util/Build
> > @@ -2,8 +2,6 @@ perf-util-y +=3D header.o
> >   perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >   perf-util-y +=3D perf_regs.o
> >
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > -
> >   perf-util-y +=3D machine.o
> >   perf-util-y +=3D pmu.o
> >
> > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/=
Build
> > index c0dc5965f3624a6f02525a04d287dff755356d20..fad256252bb95a8f8350b6b=
b1a54e8074eaebbec 100644
> > --- a/tools/perf/arch/x86/util/Build
> > +++ b/tools/perf/arch/x86/util/Build
> > @@ -12,7 +12,6 @@ perf-util-y +=3D evsel.o
> >   perf-util-y +=3D iostat.o
> >
> >   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> >   perf-util-y +=3D auxtrace.o
> >   perf-util-y +=3D archinsn.o
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1c2a43e1dc68e7f751ec6082352b10de9ffeea62..15f8a4f4b24a46b6300e824=
f672dd9c0d5b7865f 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -226,6 +226,7 @@ perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >   perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> >
> >   perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arch/
> >   perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local.o
> >   perf-util-$(CONFIG_LIBUNWIND)          +=3D unwind-libunwind.o
> >   perf-util-$(CONFIG_LIBUNWIND_X86)      +=3D libunwind/x86_32.o
> > diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/=
unwind-libdw-arch/Build
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e016d54ae2a40ecba47156c=
8f09cb72156105727
> > --- /dev/null
> > +++ b/tools/perf/util/unwind-libdw-arch/Build
> > @@ -0,0 +1,8 @@
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-x86.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arm.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arm64.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-csky.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-loongarch.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-powerpc.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-riscv.o
> > +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-s390.o
> > \ No newline at end of file
> > diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-arm.c
> > similarity index 88%
> > rename from tools/perf/arch/arm/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> > index fbb643f224ec4b27ce9d67051fe0bc4ad555b05e..c2718d6b6cff131cd67883e=
24bb0d3d963c8095a 100644
> > --- a/tools/perf/arch/arm/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> > @@ -1,11 +1,11 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/arm/include/uapi/asm/perf_regs.h"
> >   #include "../../../util/unwind-libdw.h"
> >   #include "../../../util/perf_regs.h"
> >   #include "../../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/uti=
l/unwind-libdw-arch/unwind-libdw-arm64.c
> > similarity index 92%
> > rename from tools/perf/arch/arm64/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> > index b89b0a7e5ad919fed23643d219fbdc3d84deff1e..87602503e057badc6efd371=
69cc60c96cf3949ab 100644
> > --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> > @@ -1,11 +1,11 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
> >   #include "../../../util/unwind-libdw.h"
> >   #include "../../../util/perf_regs.h"
> >   #include "../../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/util=
/unwind-libdw-arch/unwind-libdw-csky.c
> > similarity index 92%
> > rename from tools/perf/arch/csky/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> > index b20b1569783d7e982e91b1b40120d29ccf2f01d1..889d3b788931f3af55b03ef=
8b91d5def364972e5 100644
> > --- a/tools/perf/arch/csky/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> > @@ -2,12 +2,12 @@
> >   // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> >
> >   #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/csky/include/uapi/asm/perf_regs.h"
> >   #include "../../util/unwind-libdw.h"
> >   #include "../../util/perf_regs.h"
> > -#include "../../util/event.h"
> > +#include "../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf=
/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > similarity index 91%
> > rename from tools/perf/arch/loongarch/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > index 60b1144bedd5f325e1512eeab05c29a1e8de2b03..1c5753ace6f63be771aa923=
65d3174ad8ed3a6fd 100644
> > --- a/tools/perf/arch/loongarch/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> > @@ -2,12 +2,12 @@
> >   /* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
> >
> >   #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
> >   #include "../../util/unwind-libdw.h"
> >   #include "../../util/perf_regs.h"
> >   #include "../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *=
arg)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/u=
til/unwind-libdw-arch/unwind-libdw-powerpc.c
> > similarity index 93%
> > rename from tools/perf/arch/powerpc/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> > index 82d0c28ae3459ecdb0039cac1f534420d142739b..28635af3c4aa420faa4de7e=
53428d82917f78021 100644
> > --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> > @@ -1,7 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >   #include <elfutils/libdwfl.h>
> >   #include <linux/kernel.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
> >   #include "../../../util/unwind-libdw.h"
> >   #include "../../../util/perf_regs.h"
> >   #include "../../../util/sample.h"
> > @@ -13,7 +13,7 @@ static const int special_regs[3][2] =3D {
> >       { 109, PERF_REG_POWERPC_CTR },
> >   };
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *ar=
g)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/uti=
l/unwind-libdw-arch/unwind-libdw-riscv.c
> > similarity index 92%
> > rename from tools/perf/arch/riscv/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> > index dc1476e16321736de897ad53a00fbc813bd706db..2a5442b3b5bdc27252378de=
0073deb8a620f8779 100644
> > --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> > @@ -2,12 +2,12 @@
> >   /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
> >
> >   #include <elfutils/libdwfl.h>
> > -#include "perf_regs.h"
> > +#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
> >   #include "../../util/unwind-libdw.h"
> >   #include "../../util/perf_regs.h"
> >   #include "../../util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/util=
/unwind-libdw-arch/unwind-libdw-s390.c
> > similarity index 89%
> > rename from tools/perf/arch/s390/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> > index c27c7a0d1076c890c35ba19543932c4ed5ac9c2a..18d44074a55bc1c7fa2d715=
0afc1f1a93d4eadf8 100644
> > --- a/tools/perf/arch/s390/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> > @@ -4,11 +4,11 @@
> >   #include "../../util/perf_regs.h"
> >   #include "../../util/event.h"
> >   #include "../../util/sample.h"
> > -#include "dwarf-regs-table.h"
> > -#include "perf_regs.h"
> > +#include "../../arch/s390/include/dwarf-regs-table.h"
> > +#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
> >
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-x86.c
> > similarity index 94%
> > rename from tools/perf/arch/x86/util/unwind-libdw.c
> > rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> > index 798493e887d7308cb293e29e4ba11054d0fda722..822e799fe1543d82dab27a8=
efeada3f5cde08a44 100644
> > --- a/tools/perf/arch/x86/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
>
> You missed converting the unwind-libdw-x86.c perf_regs.h paths to a
> static arch so now Perf can only be built on x86. If you try to build
> for another arch then you get the local header and then missing x86
> definitions.

Yeah you are right. I'm also going to change some of the relative include p=
aths
from "../../../" to "../../" since the new files are two levels under
tools/perf instead of
three. The build worked without the change mostly by accident.

>
> Unfortunately you also have to convert the one in
> tools/perf/arch/x86/include/perf_regs.h which is a bit weird, but the
> build seems to work.

How does tools/perf/arch/x86/include/perf_regs.h come up? I seem to be able=
 to
build an arm64 version without changing this file.

>
> Other than that, looks good.
>
> > @@ -5,7 +5,7 @@
> >   #include "../../../util/perf_regs.h"
> >   #include "util/sample.h"
> >
> > -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> > +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg)
> >   {
> >       struct unwind_info *ui =3D arg;
> >       struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-li=
bdw.c
> > index ae70fb56a05729b9f06a411d162eabebbf29ac52..4a0f13bc5af99de446d440c=
551c718ef0187e195 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -225,12 +225,46 @@ static bool memory_read(Dwfl *dwfl __maybe_unused=
, Dwarf_Addr addr, Dwarf_Word *
> >       return true;
> >   }
> >
> > -static const Dwfl_Thread_Callbacks callbacks =3D {
> > -     .next_thread            =3D next_thread,
> > -     .memory_read            =3D memory_read,
> > -     .set_initial_registers  =3D libdw__arch_set_initial_registers,
> > +#define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
> > +static const Dwfl_Thread_Callbacks callbacks_##arch =3D {             =
 \
> > +     .next_thread           =3D next_thread,                        \
> > +     .memory_read           =3D memory_read,                        \
> > +     .set_initial_registers =3D libdw_set_initial_registers_##arch, \
> >   };
> >
> > +DEFINE_DWFL_THREAD_CALLBACKS(x86)
> > +DEFINE_DWFL_THREAD_CALLBACKS(arm)
> > +DEFINE_DWFL_THREAD_CALLBACKS(arm64)
> > +DEFINE_DWFL_THREAD_CALLBACKS(csky)
> > +DEFINE_DWFL_THREAD_CALLBACKS(loongarch)
> > +DEFINE_DWFL_THREAD_CALLBACKS(powerpc)
> > +DEFINE_DWFL_THREAD_CALLBACKS(riscv)
> > +DEFINE_DWFL_THREAD_CALLBACKS(s390)
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
> > +
> >   static int
> >   frame_callback(Dwfl_Frame *state, void *arg)
> >   {
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
> > index 8c88bc4f2304b59561ffd482469ca63ce0f531f0..574b29848cce31e6bfd9302=
1f752b518cebf73b7 100644
> > --- a/tools/perf/util/unwind-libdw.h
> > +++ b/tools/perf/util/unwind-libdw.h
> > @@ -9,7 +9,15 @@ struct machine;
> >   struct perf_sample;
> >   struct thread;
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
> >   struct unwind_info {
> >       Dwfl                    *dwfl;
> >
> > ---
> > base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> > change-id: 20251223-cross-arch-unwind-d890d6a5ff0a
> >
> > Best regards,
>

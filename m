Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672D218AAD
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185837; cv=pass; b=hpg9WXG7eisp226XrdApxMqxuf7eF4wT62kiPaiwJtKgiiBUA459yubxYW/JWeNC0dAs5JDnlNTkxYFTnpmFu58zOi2a8NNWsAjzfMXMUb5WIT7wutUfIUnmojYXAuTPCu8PtUyNhV0Nms3dJ6QPnFKa4WYiWmU7LgVCruvYBTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185837; c=relaxed/simple;
	bh=CcfPcKDQrYR3G+NAFXrkHCf1Tur9N09bSfHFwrEk9II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsYVReZzdOlnODwo/9xhPI2ggNq83qQ+lqig4uUTrrIOE0GMHUctY1dzNlda9ilvtxoj7BhKlSbMi+1Kz0yDiUMo1jkXr9oCrKUQLZ+la8BhdjT1pnuckUp8kVIEb/G1djMCdvVZlgNrZws/NjCSkR3t5G63QvLi5yGq6tiRYcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1LQQ/wh; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1LQQ/wh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a76b39587aso121035ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 08:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769185835; cv=none;
        d=google.com; s=arc-20240605;
        b=eMJEbXwBlbpNjDNlVaLDWGzKYSXmg1gsdFIswbcXt0CIFSyXTjbGCtKhEAUP2Dj7jN
         Hr/F8w5rLJkQZVSefdMXxoFn2Re37/0NjtR//G5YKkVTVO1FsGEuhy8HEbNIO9ff4lZL
         9XiVDZ1ip0FrO6ShnBQIf80uOvfdefi9ARxLuFZhomyvAbiXdTJC2CfLOml0Q3UgJi90
         xRsc9778h8JzC+ZE0UcboP8NWjmiOvVLVHsKWIvNbdBBJYbm48cnsAKW+i4CsrfvqmLG
         E0mZdfG9LLY6D2Yxs/+EKoxcxGpTIAnR3/F9L2PWRFXEMlmrLUyXntIKOazUiokUHkKo
         cXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vOkRLjnifceecHRFjfFtA9Hu0YVFrmdtZP58mWOpjc8=;
        fh=tr/pWlDdHOEOJL9o/Bh933feGBwQdZhep9xvWP7n/kI=;
        b=TM8/g4By2DKn0nY0naSwqWOLrYD0pC9QhFjhtRWOcPIV/PH7jc31PbHR9vJ4PB67a/
         LX/4Php8B6BZFl7NadTLmnwitFhc3GpWJg8YKR8P8Ewrx1tu6fINGv9BH7lfw0bGi8BT
         /8L9XBtfWx0rGOHOODGc8yYp0vsHN0BLJaa/vzzW4+GgcX+f3SOI+QZ4jf7krIyHZG5T
         t+u9HeACgvdMwL9Gi1AwQ3JozKFCc+Pd9U4Inkct96G3ysv28oW3fAIBhb35/RzneLS4
         DkW3eAdb7rtkiDLu3pQvT4EAtXoH89YJ0O80GmoxVYr7V4v87CG+mfuitvkRyaXBe/ZB
         RHAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769185835; x=1769790635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOkRLjnifceecHRFjfFtA9Hu0YVFrmdtZP58mWOpjc8=;
        b=X1LQQ/whiJc2c9aNNKQblNmYOLa5iy9M/rq0V4u6+XP0uEpGgg4uyTb5Tq6O0ED5LP
         3d++efwdqGR7QQG0FGa497OQpCX0xbAz3XkGy7zf8DLbg4m9Cmac+s1sKPQtAtgTmF+p
         QPjpEEblizP+ZNNa4IPeFPvI87SLevU1Qtf9RiQUgM1iB20ntDgiJLMq7rtCi9w1JKA5
         HNXw+aOCzRhAKE5+kDnu1wcKvQqFmYkA1ihbdvNEvWvkGrBXGGOfkDx7pgZYRx1B6SOa
         SRgFhz1W5sA9ggbTk2kcB5QcMpkDIX8Ayc7/VYrkfTkQW7Lhk3MXYjOwADXiI4Q0xPX1
         lePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185835; x=1769790635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOkRLjnifceecHRFjfFtA9Hu0YVFrmdtZP58mWOpjc8=;
        b=kn33HfiMpOQ51yHGWh2PnFo32+RftGU1hHH7ItuXF1C7oTr8PigUmVS0VgYUqd2A4c
         LaCMIx1nTr0ED3zUidvL81xQXQsyBeeIes0geDQiFPVx+5pOiyJO2apfxdeBJ8wcrwof
         O6y/geZbvXmhC8sc02Giv7EYOMI+RuKjK44DbwLERZyUih4A+0jONIEecbQ21OKYGkaS
         9iEphBxoQPxm9f66BZCbTw2GepJasVrEZO8UFX/s3x6bALU/WnqqCcCW5tZtNVrLI43Y
         8BMy27zzBzAwfi2qMxDoolo3UZ5kBgYgQy0bWIcuuNxSJv60Zc7YzjPAugW8rs5k5g+P
         otKw==
X-Forwarded-Encrypted: i=1; AJvYcCUteatgvybzE9grBz9ejHr7fEuvj4HQlMhzgJAj8xruRQ+JQ+c5TEdvayVbsdEGDUrwcub5FNLzIk8iTYqpyjUE@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKCOoB4ixgPEPhyO4W2iAo4NmnragD1WuSfFRrVkQLGxCob4m
	XKrKA1s5RIckB1YZEGyiQiMUe9Kbe/czo6Y7e8aTOQ0VKK+3AvJsN6tGDC/nyUVp+U8R6fzWRCv
	AYypQqdeLFz5FPzN0xpgxPv0p4reL/iIbfgB7DEKz
X-Gm-Gg: AZuq6aKDaG8LupbPR3ccq4iZp7JUlt+lwedukra1SFtFnCHHEiMjlqG1a4+gC2N5fr5
	EuNFv/aapgvgUZiqiL91WHEAgS1Vn6RR2KrBp3OdGp6KUszTu7zdTC3myXZC5NjWaGqm0ogr70R
	BHy+NFfY7Y6MnDqGGrQuUnO9WT1mdmbtHBBwdUdT2lTigvX2v9xdfzGfPw93UWRRl95+STLGcHN
	ARRzCcZ7I3OdNZ3PXBenOVr83hALQVZ0sUsRo5jGyQrgWT5YdYM+AyZFpJh7wVGMcszruYm7mMV
	C6rxXHkjJ0e5WliY4X+wZEJ5aA==
X-Received: by 2002:a17:902:cf01:b0:2a1:3cda:8e99 with SMTP id
 d9443c01a7336-2a805d45517mr2449745ad.21.1769185834577; Fri, 23 Jan 2026
 08:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122213516.671089-1-irogers@google.com> <1310a240-077a-49f6-b83a-a8a4fd52127b@linaro.org>
In-Reply-To: <1310a240-077a-49f6-b83a-a8a4fd52127b@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 23 Jan 2026 08:30:22 -0800
X-Gm-Features: AZwV_QjNay75wDxp2FcK9a1wDgjF2FHge-tLUo_wNfVirsr-f2GGtodRNG80OvI
Message-ID: <CAP-5=fWrJoej0XprvPmYg5qa7SRU2s3yeCF-hWgj+3MTdTZLzQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] perf annotate arch clean up
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 3:02=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 22/01/2026 9:35 pm, Ian Rogers wrote:
> > 3 initial memory leak fix patches for perf annotate.
> >
> > Move the disasm.c #included arch files into a new util/annotate-arch
> > directory. Make the code compile standalone. Try to better encapsulate
> > architecture specific code within the files and with a
> > arch__new_<arch> function that allows additional data to be associated
> > with the struct arch using the standard container_of trick.
> >
> > Make the lookup of struct arch use the ELF machine gather from a
> > thread rather than an evsel. For example, the evsel can't determine
> > the difference between EM_386 and EM_X86_64 so generally the latter
> > has currently been used. This means the dwarf registers are off as
> > register 1 is CX with EM_386 and DX with EM_X86_64. To facilitate this
> > change map_symbol is refactored to use a struct thread rather than a
> > struct maps, the maps being obtainable from the thread.
> >
> > To make in and out arguments clearer, for safety, etc. try to constify
> > struct arch and its related structs.
> >
> > v3: Fix arch initialization on arm, arm64, powerpc and sparc as spotted=
 by Suchit
> >      Karunakaranw.
> >
> > v2: Add a patch to fix a domain info memory leak that was blocking
> >      leak sanitizer analysis. Fix more map_symbol leaks or uses after
> >      reference count put (Suchit Karunakaranw
> >      <suchitkarunakaran@gmail.com>).  Try to repro annotate test crash
> >      (James Clark) but suspect it was addressed in the other reference
> >      count fixes.
> >      https://lore.kernel.org/lkml/20260122165407.561888-1-irogers@googl=
e.com/
> >
> > v1: https://lore.kernel.org/lkml/20260122073127.375139-1-irogers@google=
.com/
> >
> > Ian Rogers (12):
> >    perf header: Fix memory leaks in process_cpu_domain_info
> >    perf annotate: Fix args leak of map_symbol
> >    perf maps: Fix reference count leak in maps__find_ams
> >    perf disasm: Constify use of struct arch
> >    perf disasm: Constify use of struct ins_op
> >    perf disasm: Constify use of struct ins
> >    perf disasm: Rework the string arch__is to use the ELF machine
> >    perf disasm: Don't include C files from the arch directory
> >    perf disasm: Refactor ins__is_call/jump to avoid exposing arch ins_o=
ps
> >    perf map_symbol: Switch from holding maps to holding thread
> >    perf disasm: Refactor arch__find and initialization of arch structs
> >    perf disasm: Minor layout tweaks for struct arch
> >
> >   tools/perf/arch/arc/annotate/instructions.c   |  11 -
> >   .../perf/arch/riscv64/annotate/instructions.c |  36 --
> >   tools/perf/ui/browsers/annotate.c             |   6 +-
> >   tools/perf/ui/browsers/hists.c                |   3 +-
> >   tools/perf/util/Build                         |   1 +
> >   tools/perf/util/addr_location.c               |   4 -
> >   tools/perf/util/addr_location.h               |   1 -
> >   tools/perf/util/annotate-arch/Build           |  11 +
> >   tools/perf/util/annotate-arch/annotate-arc.c  |  18 +
> >   .../annotate-arch/annotate-arm.c}             |  50 +-
> >   .../annotate-arch/annotate-arm64.c}           |  59 +--
> >   .../annotate-arch/annotate-csky.c}            |  29 +-
> >   .../annotate-arch/annotate-loongarch.c}       |  71 +--
> >   .../annotate-arch/annotate-mips.c}            |  29 +-
> >   .../annotate-arch/annotate-powerpc.c}         | 127 +++++-
> >   .../util/annotate-arch/annotate-riscv64.c     |  41 ++
> >   .../annotate-arch/annotate-s390.c}            |  70 +--
> >   .../annotate-arch/annotate-sparc.c}           |  28 +-
> >   .../annotate-arch/annotate-x86.c}             |  89 ++--
> >   tools/perf/util/annotate-data.c               |  12 +-
> >   tools/perf/util/annotate-data.h               |   2 +-
> >   tools/perf/util/annotate.c                    |  88 ++--
> >   tools/perf/util/annotate.h                    |  10 +-
> >   tools/perf/util/callchain.c                   |  12 +-
> >   tools/perf/util/capstone.c                    |  18 +-
> >   tools/perf/util/db-export.c                   |   1 -
> >   tools/perf/util/disasm.c                      | 428 +++++++----------=
-
> >   tools/perf/util/disasm.h                      |  95 ++--
> >   tools/perf/util/event.c                       |   2 -
> >   tools/perf/util/header.c                      |  17 +-
> >   tools/perf/util/hist.c                        |  18 +-
> >   tools/perf/util/llvm.c                        |   8 +-
> >   tools/perf/util/machine.c                     |  13 +-
> >   tools/perf/util/map_symbol.c                  |   5 +-
> >   tools/perf/util/map_symbol.h                  |   3 +-
> >   tools/perf/util/maps.c                        |   1 +
> >   tools/perf/util/sort.c                        |   2 +-
> >   tools/perf/util/unwind-libdw.c                |   2 +-
> >   tools/perf/util/unwind-libunwind-local.c      |   2 +-
> >   39 files changed, 775 insertions(+), 648 deletions(-)
> >   delete mode 100644 tools/perf/arch/arc/annotate/instructions.c
> >   delete mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
> >   create mode 100644 tools/perf/util/annotate-arch/Build
> >   create mode 100644 tools/perf/util/annotate-arch/annotate-arc.c
> >   rename tools/perf/{arch/arm/annotate/instructions.c =3D> util/annotat=
e-arch/annotate-arm.c} (59%)
> >   rename tools/perf/{arch/arm64/annotate/instructions.c =3D> util/annot=
ate-arch/annotate-arm64.c} (70%)
> >   rename tools/perf/{arch/csky/annotate/instructions.c =3D> util/annota=
te-arch/annotate-csky.c} (67%)
> >   rename tools/perf/{arch/loongarch/annotate/instructions.c =3D> util/a=
nnotate-arch/annotate-loongarch.c} (60%)
> >   rename tools/perf/{arch/mips/annotate/instructions.c =3D> util/annota=
te-arch/annotate-mips.c} (59%)
> >   rename tools/perf/{arch/powerpc/annotate/instructions.c =3D> util/ann=
otate-arch/annotate-powerpc.c} (73%)
> >   create mode 100644 tools/perf/util/annotate-arch/annotate-riscv64.c
> >   rename tools/perf/{arch/s390/annotate/instructions.c =3D> util/annota=
te-arch/annotate-s390.c} (66%)
> >   rename tools/perf/{arch/sparc/annotate/instructions.c =3D> util/annot=
ate-arch/annotate-sparc.c} (85%)
> >   rename tools/perf/{arch/x86/annotate/instructions.c =3D> util/annotat=
e-arch/annotate-x86.c} (93%)
> >
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks James!

Arnaldo, it'd be nice for this to land so I can look into addressing
the missing e_flags issue - namely, we should optionally read the
e_flags along with the e_machine so that we have a proper e_flags
value to make csky work properly (not an issue on anything else). At
the same time I think some of the e_machine should be made more robust
like with:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf?h=3Dperf-tools-next&id=3De99d544c7f3691eb321c88fdbadf04=
b777c114c4
but here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/thread.c?h=3Dperf-tools-next#n452
the code should probably be shared.
Anyway, this series does enough without adding all that to it and
waiting for more tags.

Thanks,
Ian

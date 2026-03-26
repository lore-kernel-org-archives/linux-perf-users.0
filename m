Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580A40DFBC
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774566908; cv=pass; b=UzudPLC3mfS3N3iAhid59zcZTZo9MTl8uauNv/OEvXHy0b1Vih9yjpQM28+/HW4UqcFS9XAIjafzlTB6VVceAcZoMH3DR401TdGvEK69YaOjflRx2v5ZEcvPqLnE0lbnO8OfHnBSJJuVWXwPdPN36Ck4GbQ5Eq6aXBSaZOsMJgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774566908; c=relaxed/simple;
	bh=Tfz0geM240yeWd8y4HiLMBMYNidmUDstLMgynTczcOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otvNNe/l0Zpcaoyoi8M9wgv0Zub7iRX6b5B2X1PJkjLmLjZfMlXcVatZ1Q/nWCGIsa5LtVZu4LWKCVLOAr0lybEkEGVoxzz+14fPjVaBbQBW/XWlvEdUVYGUs1XwnUdX+AGt7rbeC2FobmjSMIJz7ERW5Q1bhGZ0YsR2BD5W9qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j65NJ05w; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j65NJ05w"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b052562254so39955ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 16:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774566906; cv=none;
        d=google.com; s=arc-20240605;
        b=lJ342GtmnVhja1DvEqElOG9soL5Y2/qbYsDTJi54qZZbL+1jt99b2BjeKKlbwVuGfS
         d8TVkdE8mP2M1lKA3X+Qvot+/pr2X/7n44tOGKXGnEgrA5liSSU6KMdNnz/5e1qTJlk2
         vL0ZtBbHRqnkYLnwtbt3b12dw67OGxowZZozRGdX7ohJD3hxSekD0hX7nMHY5JQWPbSu
         IBiWi7ucReyt1iTFPIRUbZX1ZJCvwnGDiCCh+PAf0EgxNp65wCXMB8sNPdDYAs1RXr6+
         Op/2VGW/RQX4a+0Pc0pRmXtt5Gwfy5i2cCAaeqUeRuexH+s31emqcfAEtPoSaEMzJPeJ
         gtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T2YD6pwogaEbBAngQ7jzL1Df9t10z5n8+TMyot+6ut0=;
        fh=ypI6NVGvX8d8ND5B8SQ+6UXfMp1p2ARujM+9Q2pzAAY=;
        b=G+g3qz2UzAupJKWEfof/U6QBdeYxVtmRWZ6/4d52qrASI+/BferXJ1sYAFBppXNELx
         Cp/E0mGOxJy/cvjbmf28pDMpiLm79WaYcLi1TrVMrtbLz3j8I4mTHc7R8sAXhCcXybve
         JF1NTSgfDSD7oijSkpIJ4UlDsLNQl0a3za+l9G5uay6ZD2lFIEerxnTefIamlcvIB9dr
         tb8JEh5LLUuv85ZkuCtm+6cyDKq5SqJcArd8gO0AUmGslPgttUxtiexMmCHoBLqDLqwi
         jW+mPjZQQ/h43vm3+WCUToBDXAW6KyzAVNP3zb23CuD9N6XADUwsm9/ItE+lcqARjIZH
         bUtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774566906; x=1775171706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2YD6pwogaEbBAngQ7jzL1Df9t10z5n8+TMyot+6ut0=;
        b=j65NJ05wM43tpsz6TwihQfx4shC4AWb6+r+cJdUCDOgc3p04cSOjLFB+VBJG0WxM4U
         tUsv4tmirMBc1KtsCzKDZLluBn2RSAD1vSNwFOjJF48hagKB0gdBCuAC4AhtyAIgHp1l
         9jKJDOkmblKY6i/PHIqeiobahb5JMYLrKuK6Tio6sa0ACD0LMoQPzoYo3KjH1W5mNmiI
         bQ455DLO4fRQNcoORuDaPvqjCWjdsfLJe08sVUHc6RiaM58kdFHz4meMczYe7iJswqLu
         hzCNKAjtexaVC69Jb5Hy6RineKqOLIJIo87v4IL6pyb9iOHxDW4JuLv3DSgw1ePjXn5R
         o8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774566906; x=1775171706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2YD6pwogaEbBAngQ7jzL1Df9t10z5n8+TMyot+6ut0=;
        b=DgIpQJiuKFLZmDPQpIZZ2Y8/XkqN0N4wbCkztLTXRxvLE4Ojxm12ZEZ+k9TS/XrdxW
         irTFMKvsEJI9Pf265je786QAR/dsMoVZJvORPtqMr6tRII/IB9q3ROOXtRmpt7LpS5Ru
         2v79/crMO0AWErGofA2pdLOkKxCamHVBfUh7GmZjpBgdMbRswicn9UdVa9YqoImbohdR
         ezWPGM18dvXpZkRr1NLyWEwuLjfsrPA+MFuSadddojhE6T1mELgWN4bsWlNpcsBgMIY9
         Qan9Bv1heEfsC9yDlBj2IMDn1Y7NuTjEAkrq1Ahqh6LgcJKLIODTp1KG7n21uB3KsSJF
         s2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY5CbSkT1sjA8/6JUYcvPOwp2XSHIyZO6NbR17v8GtDxe5JnRPN8CrDOdKKitTrV/1rsH0oxgHViZ/cHUo5g6L@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGjUX4xfYk6b1H81/66jrs1cHUj7lxVIcKbsLleb/1PT0jOQj
	qdyqSTlbgXWZpLQWUqKIhi6kbKqKWQabOJ9g9nkb4iMizdemgN4g99yYQnBaZoaaCUUtw/1LwzK
	mVHmp2qXy0LXu5QOj24gyUEgWF9lDFBE1s4851VQl
X-Gm-Gg: ATEYQzxUGn8sL575iBANxTm8YL5qibd/6i/mLwmb99nTAVRXC0gHKTbPqvJHe+7pG1a
	I0xsKY7o4Sv8i+YwIl507zu+N8EqYIuZeVF4HHKoOeKTHqbkT+rq3PCKu8JvqQgY+SbwbCwIryD
	zPOrB3fWxLFQGs8lRCG9C37/lOnGwShr0XY2RCtka70IGpxU944pk/FLvSOnLhHRL+bp80KK+x2
	UqezCf++tRusVfzo5rS74/Zo7MnpvNHJ4T83dGbKX22SYOB5SvZOhJ7trNIoNXk+m+mwU8CwIqT
	ADdBqGY=
X-Received: by 2002:a17:902:ef46:b0:2b0:5193:1212 with SMTP id
 d9443c01a7336-2b0cc23f103mr1451505ad.4.1774566905014; Thu, 26 Mar 2026
 16:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abxs-2rozL1tBEO1@google.com> <20260321234220.848859-1-irogers@google.com>
 <acW4Z2KJbyPZM1SG@google.com>
In-Reply-To: <acW4Z2KJbyPZM1SG@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Mar 2026 16:14:52 -0700
X-Gm-Features: AQROBzAygKd6oTfrEHZEo1yOPUniUJvjrCTN9i1V25cS3M3lNv5jNRoxNUpz8Kw
Message-ID: <CAP-5=fV54H9o4FjALZU3wzEjBjNgGBb6zhaRmrjhseT_noggZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf build: Remove libunwind support
To: Namhyung Kim <namhyung@kernel.org>
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	howardchu95@gmail.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org, amadio@gentoo.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Mar 21, 2026 at 04:42:18PM -0700, Ian Rogers wrote:
> > libunwind support exists for "--call-graph dwarf", however, libunwind
> > support has been opt-in rather than opt-out since Linux v6.13 as libdw
> > is preferred - commit 13e17c9ff49119aa ("perf build: Make libunwind
> > opt-in rather than opt-out"). A problem with the libdw support was
> > that it was slow, an issue fixed in Linux v7.0 in commit 6b2658b3f36a
> > ("perf unwind-libdw: Don't discard loaded ELF/DWARF after every
> > unwind"). As such libunwind support is now unnecessary.
> >
> > The patch series:
> > https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.co=
m/
> > looked to make the libunwind support in perf similar to the libdw
> > support, allow cross-architecture unwinding, etc. This was motivated
> > by the perf regs conventions being altered by the addition of x86 APX
> > support:
> > https://lore.kernel.org/lkml/20260209072047.2180332-1-dapeng1.mi@linux.=
intel.com/
> > It is necessary to translate the library's notion of registers to the
> > perf register convention so that the stack unwinding state can be
> > initialized. On this series it was stated that removing libunwind
> > support from perf should be an option, rather than updating support:
> > https://lore.kernel.org/lkml/abxs-2rozL1tBEO1@google.com/
> > This was also what motivated making libunwind opt-in rather than
> > opt-out.
> >
> > Given that 7 minor releases have happened with libunwind "deprecated"
> > by making it opt-in, let's remove the libunwind support. There doesn't
> > appear to be any disagreement to this on the mailing list.
>
> I'm not sure if we want to remove it now.  I think we need more time to
> verify libdw unwinding is stable and fast enough.  Also maybe we can
> add build- or run-time warning when people try to use libunwind.

I've had issues with old versions of libdw, but presumably the
distributions won't update perf without libdw. Given we're waiting
should we land the cleanup in:
https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/
We have test coverage.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Ian Rogers (2):
> >   perf build: Remove libunwind support
> >   tools build: Remove libunwind feature tests
> >
> >  tools/build/feature/Makefile                  |  31 -
> >  tools/build/feature/test-libunwind-aarch64.c  |  27 -
> >  tools/build/feature/test-libunwind-arm.c      |  28 -
> >  .../test-libunwind-debug-frame-aarch64.c      |  17 -
> >  .../feature/test-libunwind-debug-frame-arm.c  |  17 -
> >  .../feature/test-libunwind-debug-frame.c      |  17 -
> >  tools/build/feature/test-libunwind-x86.c      |  28 -
> >  tools/build/feature/test-libunwind-x86_64.c   |  28 -
> >  tools/build/feature/test-libunwind.c          |  28 -
> >  tools/perf/Documentation/perf-check.txt       |   1 -
> >  tools/perf/Documentation/perf-config.txt      |   4 +-
> >  tools/perf/Documentation/perf-record.txt      |   2 +-
> >  tools/perf/Makefile.config                    | 163 +---
> >  tools/perf/Makefile.perf                      |   3 -
> >  tools/perf/arch/arm/util/Build                |   1 -
> >  tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
> >  tools/perf/arch/arm64/util/Build              |   1 -
> >  tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
> >  tools/perf/arch/loongarch/util/Build          |   1 -
> >  .../arch/loongarch/util/unwind-libunwind.c    |  82 --
> >  tools/perf/arch/mips/util/Build               |   1 -
> >  tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
> >  tools/perf/arch/powerpc/util/Build            |   1 -
> >  .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
> >  tools/perf/arch/x86/util/Build                |   1 -
> >  tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
> >  tools/perf/builtin-check.c                    |   1 -
> >  tools/perf/builtin-report.c                   |   4 +-
> >  tools/perf/tests/make                         |   2 -
> >  tools/perf/util/Build                         |   5 -
> >  tools/perf/util/callchain.c                   |   2 +-
> >  tools/perf/util/dso.h                         |   6 -
> >  tools/perf/util/libunwind/arm64.c             |  40 -
> >  tools/perf/util/libunwind/x86_32.c            |  41 -
> >  tools/perf/util/maps.c                        |  47 +-
> >  tools/perf/util/maps.h                        |   6 -
> >  tools/perf/util/thread.c                      |  40 +-
> >  tools/perf/util/thread.h                      |   1 -
> >  tools/perf/util/unwind-libunwind-local.c      | 832 ------------------
> >  tools/perf/util/unwind-libunwind.c            |  92 --
> >  tools/perf/util/unwind.h                      |  41 +-
> >  41 files changed, 19 insertions(+), 1919 deletions(-)
> >  delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
> >  delete mode 100644 tools/build/feature/test-libunwind-arm.c
> >  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarc=
h64.c
> >  delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.=
c
> >  delete mode 100644 tools/build/feature/test-libunwind-debug-frame.c
> >  delete mode 100644 tools/build/feature/test-libunwind-x86.c
> >  delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
> >  delete mode 100644 tools/build/feature/test-libunwind.c
> >  delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
> >  delete mode 100644 tools/perf/util/libunwind/arm64.c
> >  delete mode 100644 tools/perf/util/libunwind/x86_32.c
> >  delete mode 100644 tools/perf/util/unwind-libunwind-local.c
> >  delete mode 100644 tools/perf/util/unwind-libunwind.c
> >
> > --
> > 2.53.0.959.g497ff81fa9-goog
> >

Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3041F543D
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560014; cv=none; b=OaNNFMiLn7QBnEliVMeSLWe4Jqx8f/t12AXyWNMfKSOCfKe4QCqu+hrOvhWgyxXdYvgv+j1pbN+cQENL6qq9oZ7azFUWCdZbo3h/X/WzsX4xCPx6Z8+rWWmm1oURaahi9+G52oa4iX2QoRFW+/KOoxqYeOQUvtDekxVRGvgizpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560014; c=relaxed/simple;
	bh=SDx93uVFkrFlwarS/sFm3hOwDOBBe+v6/iJoMo1IbQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8sRx9l3u3ThyKOWTBKRqXWIDRBA/ZoO5DKEJuWd5m3G3Ao+1novCHzSi878PVdwW1duxCCDucWXqtl0++yGMcee+68+0bFw4A+fPBxf5KTEZKurOHQoClRL5se+WE7Mx7PV/tLJJeasHyRH4PTsIrXZKfk2HWKl6Bc1qQy6/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUgTJDqd; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUgTJDqd"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso6195ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 14:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734560011; x=1735164811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNyF2ZCrhTzYkHOFwOv71exzNGm0f4UVt3o61cO/AHw=;
        b=bUgTJDqdIoRHD9BPvWawoxp4TqiZhH+Y2OPp7Ir6dwDlVUMqEj9Hepb8GKLqw8jJkR
         7tgsGKs9zn1w5XVEbYSSCos6nkeCM0q7Q8tk5/2YZaHoADeb8eczeCnqB4ZRopyJaVb9
         fj6Pw5mP2lrgrA+7GNIu5v3TGYxiCTZ7e3B86p2GT28Ya8UmLff/IO3iRZ5I7jgvnQez
         ZYHR+OiV6s6wV/CRMKKdwv+0ShWjmIIpPPUYSynCdf0PUI+pTv10Coo0MCE/QWIaqtqJ
         9vzLok0gSpS2QQ0w5XxhbNRg78WU+zEGpZDjMmtUTX1bCXpZLDkU2pEgHbyDSvoiISWu
         n0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560011; x=1735164811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNyF2ZCrhTzYkHOFwOv71exzNGm0f4UVt3o61cO/AHw=;
        b=FvQOVWPQVEAwN5ZOu2ba+t7i/TUW2L4+kJVKROjDBDnY4lD3SvGapx0pJkd89rUcy5
         L9lIbUQBeVD3lvZczRc6SSAeV142ufK1kfWWh+GyJKYOz3CCNFKbVL3FzmF+TVrIP4Fv
         Q4EBg95rKxtzOlXAcfSGZ1brSNRmcaURdpS+XBFHcM6llaAe4bFGOS0yfPwh/N6otpB+
         p/GN8W4Gao7Aa6QY+CRs9+SjHqpU2XzySkqIYHPX2+maVbryyHkzZ5OXRhvNpcaBw99a
         IZGw0ClL4ttQYdxKU014IzY2epnhw1BlcmBqoasdNXNW7c9hCB7d2xT+gGEbAW/Coou7
         L+cA==
X-Forwarded-Encrypted: i=1; AJvYcCXuih4K3nEgudynq8fgpubnhrveEC9hpz04siDfiXIUdD5UxvE17C/7GyQ4RNBJHc5WL/RU1+41gjXMRO/XjUHi@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTDVfuRRl7j8v1YWrKNoPTBVybO1taE18WOpzFb0fRqMMmlUh
	+zBFDF6RrlrofXiPbTkyV5ejDyuVFkDe6lRUuSlPTT+ekuYvlN8usMRt3VboYNZLzdajOKCfWo6
	7WDW9y82V8WL5Tws4DJMa2PnFLCjCj7CPmYKC
X-Gm-Gg: ASbGncv5BeMo6QihTFSGTx4WYoOF4D9vc3nfh6LxUoo6mDa4SqFrKi47/LSN7BnntjP
	7PXALB71FCLD0kNbYHkRgfYs2ll4yY6Nx1qJNh9A=
X-Google-Smtp-Source: AGHT+IEKVIcmec9DHv//inZYLfmgrOtHowVFU41P4dXFAeGSnp+m/BFfIkFiBkYG6iOLBfI+3J+uSAydwMZjIlAvOUE=
X-Received: by 2002:a05:6e02:1f86:b0:3a0:9f85:d768 with SMTP id
 e9e14a558f8ab-3c0aca442ccmr155815ab.11.1734560011376; Wed, 18 Dec 2024
 14:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost> <Z2MXXFhUzoQmW4xV@x1> <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
 <Z2M4ZparbNRvRHpz@ghost>
In-Reply-To: <Z2M4ZparbNRvRHpz@ghost>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 14:13:20 -0800
Message-ID: <CAP-5=fXL6YaEq1cvBh2iESmQ_kqfm5VH5thJ0zrkOCcaWv5s+Q@mail.gmail.com>
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:02=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Wed, Dec 18, 2024 at 11:23:51AM -0800, Ian Rogers wrote:
> > On Wed, Dec 18, 2024 at 10:41=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > > > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > > > On Tue, Dec 17, 2024 at 3:52=E2=80=AFPM Charlie Jenkins <charlie@=
rivosinc.com> wrote:
> > > > > > After binutils commit e43d876 which was first included in binut=
ils 2.41,
> > > > > > riscv no longer supports dumping in the middle of instructions.=
 Increase
> > > > > > the objdump window by 2-bytes to ensure that any instruction th=
at sits
> > > > > > on the boundary of the specified stop-address is not cut in hal=
f.
> > >
> > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > >
> > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > > > > A binutils patch has been sent as well to fix this in objdump [=
1].
> > >
> > > > > > Link: https://sourceware.org/pipermail/binutils/2024-December/1=
38139.html [1]
> > >
> > > > > > Changes in v2:
> > > > > > - Do objdump version detection at runtime (Ian)
> > > > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv=
_obj_reading-v1-0-b75962660a9b@rivosinc.com
> > >
> > > > > > --- a/tools/perf/tests/code-reading.c
> > > > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *fi=
lename, u64 addr, void *buf,
> > > > > >         const char *fmt;
> > > > > >         FILE *f;
> > > > > >         int ret;
> > > > > > +       u64 stop_address =3D addr + len;
> > > > > > +
> > > > > > +       if (IS_ENABLED(__riscv)) {
> > >
> > > > > Not sure if there is a consistency issue here. Elsewhere we're ju=
st
> > > > > using ifdef, such as:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n69
> > >
> > > > I don't have any strong feelings about that. I can change it to be =
an
> > > > ifdef. On other lists I have been told to use IS_ENABLED whenever
> > > > possible, but it's only a small difference.
> > >
> > > Can't we just use uname here?
> > >
> > > So that we don't use kconfig.h since its not used in tools/perf/ and
> > > makes it looks like perf is in lockstep with the kernel source tree
> > > version it was compiled from?
> > >
> > > $ git grep kconfig.h tools/perf/
> > > $
> > >
> > > BTW, what would happen if I collected a perf.data file on x86_64 and
> > > would read it in a RiscV machine with such a objdump version? The sam=
e
> > > problem?
> >
> > This code is in tests hence thinking that a separate fix is needed for
> > that problem. Hopefully the use of elf machine/flags tackles it:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n25
> > We are getting somewhat disassembler heavy. We have llvm as a library,
> > capstone as a library, binutils objdump and llvm objdump. Given the
> > pain with parsing text, could we lose the objdumps? Similarly for
> > addr2line?
>
> Are you suggesting to remove this test case entirely to get rid of the
> objdump dependency? The goal of this test case seems to be to check
> objdump and perf return the same data, so it doesn't seem like there
> would be an alternative to using objdump.

I can imagine having an objdump dependency for a test but not for some
more core like `perf annotate`. We have to do weird things when
parsing text, like this code I'm not proud of:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/srcline.c?h=3Dperf-tools-next#n523
The issue with that code is that LLVM objdump has changed its output
in newer versions to be closer to binutils objdump. Did that break
perf? Maybe it just broke what our variables think is an LLVM objdump,
but things aren't really broken. This kind of issue doesn't occur with
a library, although the differing needs of library versions is a real
thing.

Thanks,
Ian

Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C12155359
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549845; cv=none; b=Yrnd8uW6AAbnRLC0jchdUawyXc3wKjCGu05SCy38UogNxecSrYdJl9toEQbO4IerTa+AIFZ9hxFCl7LD56344fqBv882zunc/DMhygljQp4pCZQG+wWU0QI933PW61sDkYCRNQ7M7BUAA/lREnpruxKj1eB1vhUSm2sHnXNGJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549845; c=relaxed/simple;
	bh=r3JoZs2KPthfZ8lhValUIsSwrD0QsuXY7N77VpQAWuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNeoxGyx/udrMvJCJHUlY31xwYc0VbKNkGMk2kqmbNxw5udss4YZrintyPawqQQJAKXhrsGJXEtQgqYyXDyQWJpnDa42OqJYAQncMUU0yOp22DgVkYfUbZc7rIhjtPMGhgRiVMU1XzC5t1iXDbCBRmubrpjCN1TrHnJCrGBm1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXX5n+ZF; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXX5n+ZF"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so13905ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734549843; x=1735154643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9hTXlPZWSVEYCQ2lSahVNinUrx56wFSX/a32nzhIVI=;
        b=nXX5n+ZFFxMF2+M2Bm/PCLXw1doDx0Jq3ivA1nE/iifhWKOkUxIu0ixulEHWylfbQ7
         Z4O+S7Z4Kc3XjvLvWYgIF/WpE1ZitESJ1PHU+7HIRHHDRWaXKscy4DIdtRPENmx8Y8mM
         KqlgMW7SLWgV2xdD1+64WN0ADw25PYPPagwuD0M+yrV7vp42teiJT3LrNQzaLrxSw6O1
         kzJgXTzBQqjH62SwQJV7007OjFRUQrLXynJidwYNRqPyZ8GVrSI8QShdwE1dE5646/GF
         TdGMJHjM+ChwMfM8Ej9vlEcT0ZEQ9dUoR4s6EN4Ksd1nS/HkbtkpCRLvo3CSqTcduqaJ
         YvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734549843; x=1735154643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9hTXlPZWSVEYCQ2lSahVNinUrx56wFSX/a32nzhIVI=;
        b=giQ7X2fjyfVOCaAR0ppp30qoDHic+9RRpxcDQFKH4JwLtZAhc91o3tNsV0wREkIrQD
         EIdXFrT0PxUNjGOPCjtBlGVLDak8Ir4n2qyLfh9vmMpeDDf207uA+q/7Bdd5Tai5+Qm4
         jUhyfKyLvzEsHTcmzjWRmeYMuOgP3sdiy3XXy05Gx0vIVDzjCsaSMohQd+ll/L7TM2Mn
         PAxmVw2Pj1n9iy8Z49PVKmzeVd5X7a5iy6HDje/ujGa10i2fTahXOvRbE7UbALoA4DMB
         5UW+8t/+HiF4nMi5kuFQWDfnFk9qgYRoIppmpEhaKXyMY+lMG3IGf40gL65FKvVRdJZM
         dzAA==
X-Forwarded-Encrypted: i=1; AJvYcCVWtTGDCLxTk+/5QZD9InC2qJDlm1FsIXYgy5Sq/wEb/Adf/kvZ9CqU0vGFvs82w7ZEQUKWqKFRWJvQb+m5lDoP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+9gusU14OL2cHHDQ9JtUSyalK+0ZghwKlFkrw5a03SpmaiWB
	5SKAx5kdPv9tWWH10hKMxrD95NW+PoLq3OWiEE57aw5myI2JiUVaUUThbT7mtvEyjSALiaau5p+
	CzWIzFWgRxMEwKrnaGvfzkK/6oaIswYNUAdVZ
X-Gm-Gg: ASbGncv3i738CQciVx9XNAjzJG2zBvS06Y1+N9zGiHhHdg0fEGpgvAcwvJk7/z9V7mR
	Vt7EsAWQYGEXvBnzOsGJuN07GxMoKuqWfFRMbFq4=
X-Google-Smtp-Source: AGHT+IFsB3hzBCDfntbKQfvxjP3mGyPhCDyK07+5uTgdW6OxgZh8AuhBDcTf1TpnOVq02GGpwyEGtwa9dzqWj325I5g=
X-Received: by 2002:a05:6e02:221c:b0:3a7:9082:50f6 with SMTP id
 e9e14a558f8ab-3c05c1aa647mr259455ab.22.1734549842734; Wed, 18 Dec 2024
 11:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-perf_fix_riscv_obj_reading-v2-1-58f81b7b4c7d@rivosinc.com>
 <CAP-5=fXK6HRzBKHzF=T_w9cn7ohWOdmZNRMXvJzN6QG11HE6tA@mail.gmail.com>
 <Z2IXl5cuKQJInJb0@ghost> <Z2MXXFhUzoQmW4xV@x1>
In-Reply-To: <Z2MXXFhUzoQmW4xV@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 11:23:51 -0800
Message-ID: <CAP-5=fXPPfHHVPh0nYgR96VM+smuZKepO+GoE4X+aZsQE4tHSw@mail.gmail.com>
Subject: Re: [PATCH v2] tools: perf: tests: Fix code reading for riscv
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Peter Zijlstra <peterz@infradead.org>, 
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

On Wed, Dec 18, 2024 at 10:41=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Dec 17, 2024 at 04:30:15PM -0800, Charlie Jenkins wrote:
> > On Tue, Dec 17, 2024 at 04:18:32PM -0800, Ian Rogers wrote:
> > > On Tue, Dec 17, 2024 at 3:52=E2=80=AFPM Charlie Jenkins <charlie@rivo=
sinc.com> wrote:
> > > > After binutils commit e43d876 which was first included in binutils =
2.41,
> > > > riscv no longer supports dumping in the middle of instructions. Inc=
rease
> > > > the objdump window by 2-bytes to ensure that any instruction that s=
its
> > > > on the boundary of the specified stop-address is not cut in half.
>
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
>
> > > > A binutils patch has been sent as well to fix this in objdump [1].
>
> > > > Link: https://sourceware.org/pipermail/binutils/2024-December/13813=
9.html [1]
>
> > > > Changes in v2:
> > > > - Do objdump version detection at runtime (Ian)
> > > > - Link to v1: https://lore.kernel.org/r/20241216-perf_fix_riscv_obj=
_reading-v1-0-b75962660a9b@rivosinc.com
>
> > > > --- a/tools/perf/tests/code-reading.c
> > > > @@ -183,9 +244,30 @@ static int read_via_objdump(const char *filena=
me, u64 addr, void *buf,
> > > >         const char *fmt;
> > > >         FILE *f;
> > > >         int ret;
> > > > +       u64 stop_address =3D addr + len;
> > > > +
> > > > +       if (IS_ENABLED(__riscv)) {
>
> > > Not sure if there is a consistency issue here. Elsewhere we're just
> > > using ifdef, such as:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n69
>
> > I don't have any strong feelings about that. I can change it to be an
> > ifdef. On other lists I have been told to use IS_ENABLED whenever
> > possible, but it's only a small difference.
>
> Can't we just use uname here?
>
> So that we don't use kconfig.h since its not used in tools/perf/ and
> makes it looks like perf is in lockstep with the kernel source tree
> version it was compiled from?
>
> $ git grep kconfig.h tools/perf/
> $
>
> BTW, what would happen if I collected a perf.data file on x86_64 and
> would read it in a RiscV machine with such a objdump version? The same
> problem?

This code is in tests hence thinking that a separate fix is needed for
that problem. Hopefully the use of elf machine/flags tackles it:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next#n25
We are getting somewhat disassembler heavy. We have llvm as a library,
capstone as a library, binutils objdump and llvm objdump. Given the
pain with parsing text, could we lose the objdumps? Similarly for
addr2line?

Thanks,
Ian

Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182E1D959A
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Oct 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315144; cv=none; b=i64vg718isgL4iK/6DQlTCFSADen4H83mHDwkuIPQty9WDfze5WN7usL62hB+3xBwCdw3wA29sfgqux6jqSkNd/A5hGWnHkqx6D/xkaJy8G1gSvpeE8dAa+/Yf5HDPeC1BuG8ZLcPdJOzMP492ET9BZGY/PNJIJSAhK1E9nWPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315144; c=relaxed/simple;
	bh=sATp4bnQZOdPhjlk7F/9DfVJ1rQ8KktY9Eh1owaoPUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+ckZT/v+uCVxhhObKOtvzYoGbKAhmHn402njantJuYz7fBYvcew4uccySTdQ52E0QPrbGZO9jO2qIurxSQA4WJ/njY7XJPq8gQJEihRr3aR88FRuJbuf3ChWFjZ8vubhsBhM18Mion9GH0EjfRb1ABRKBvFp6YFFiNJjCvhafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHxsOzyr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHxsOzyr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b4a090f3eso259925ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Oct 2024 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728315142; x=1728919942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gMzLm6GeDyitzticM5hzWB6E5aII3zloFuT3pmuk5o=;
        b=tHxsOzyrVNcoXpPiRE7r+SZlEuH75uF7pnlFsXAvZJCZNCWI5+Js6yglBHEQda5zbO
         uQAvWXjBlJks5hNBqKJBv+9N2mdlsEffeWQ65q+qwpb/rbxc+rGiAuqTSpl7H6EagENN
         WIWYb4UpE49COe/vzPh10iB9xw9clqaHx/0fJeloYeXjqcuXyPw/P9b39nR5TAIZoMyA
         GFPyA8XK8I/SAFHUM1p/Xcbb1oAWomHrcorau5U5BEh7K0GoBX3IAKQBwa4iy62cRDWi
         adLD5hozzsbyF6C2JYURzJmCTXAVVX5HYhIinLabR757TqBZx7rTlgpdaGGN3HyYG9Lj
         0cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315142; x=1728919942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gMzLm6GeDyitzticM5hzWB6E5aII3zloFuT3pmuk5o=;
        b=WjyMlA0JllbaPbcFt5V94GFQR2S6B16pE4oAYrKjNQwsNngkI2n8asP6xJk4nTzAEj
         Hs1S+6rjKMOrvvz2HFcisTrBYj15WpBvdbtCXRvqh5+KU8ZokY6QwTL4qgFCohbnBRVk
         Z8IwosaLMi//9eKXE9J3ZX0OvLseJTt5yKZ8+cgCiw5Sf6Y198yxO261dj9n0QVcH/+8
         5H8AInWrUrgkk2mHZ47i805jRkspDlwaGBlmrukAYxmruhe2Ldxb8OmpUwgvg+7sR5VO
         W8yyg7p2SAp4ylRZ3HA8Y1kimDp/zjstP2lrBmmzB+sDfRCsKKE84lnu4hVXKFeln6F9
         Bk9A==
X-Forwarded-Encrypted: i=1; AJvYcCWMZl8VgApeSUGonUbjfuiMRVxR4ve9SdbEdd7Rs9dEGk0X+itKQOGood7FpNezXQC5hN5ReN3nKG/iWtGHp2aj@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcvIX/MGNxMCxr1no1J4bIvswhF7dF4L+zLNvyZcSz/TKbsvH
	ExG74SywlLV99W/6iIDipM50hc8sfTqvDPUkzTarBFswwVQkz4vymPkR1BBtO6S5AYGkwKY0IqY
	b2rn0bP9qZQUjMCc1nNviilDOrIIDm7+yC1wT
X-Google-Smtp-Source: AGHT+IE8EjFttm1Va0WqG8l2f0/amiuCoYKfQShIturGToYPzv43NL3LOmdB4U0J5gpFN+f+JaXzkWQhd+QZ2gG/RJM=
X-Received: by 2002:a17:903:24f:b0:1fc:60f2:a089 with SMTP id
 d9443c01a7336-20c192b9989mr2909975ad.17.1728315141788; Mon, 07 Oct 2024
 08:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com> <20241005195541.380070-19-irogers@google.com>
 <20241007173453.288ec1580855c29af0863d89@kernel.org>
In-Reply-To: <20241007173453.288ec1580855c29af0863d89@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Oct 2024 08:32:09 -0700
Message-ID: <CAP-5=fV29jLxFUDwMFvnaV6R4ZkQg=KZ_FwU+ueQQLof1R3tRw@mail.gmail.com>
Subject: Re: [PATCH v2 18/31] perf dwarf-regs: Move x86 dwarf-regs out of arch
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Guilherme Amadio <amadio@gentoo.org>, 
	Changbin Du <changbin.du@huawei.com>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Daniel Wagner <dwagner@suse.de>, Aditya Gupta <adityag@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Chen Pei <cp0613@linux.alibaba.com>, 
	Dima Kogan <dima@secretsauce.net>, Yury Norov <yury.norov@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 1:35=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Sat,  5 Oct 2024 12:55:28 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > Move arch/x86/util/dwarf-regs.c to util/dwarf-regs-x86.c and compile
> > in unconditionally. To avoid get_arch_regnum being duplicated, rename
> > to get_x86_regnum and add to get_dwarf_regnum switch.
> >
> > For get_arch_regstr, this was unused on x86 unless the machine type
> > was EM_NONE. Map that case to EM_HOST and remove get_arch_regstr from
> > dwarf-regs-x86.c.
> >
>
> Hmm, I'm not sure this change. I feel like to keep the arch dependent
> part under arch/ directory

Code in the arch directory is built with this condition:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/Build?h=3Dperf-tools-next
perf-util-y +=3D $(SRCARCH)/
That is we only enter an arch directory if it matches the architecture
we're building for.
I think what you are saying is that it'd be nice if x86 related code
were in the arch directory, but with things as they are that means the
x86 related code wouldn't be built on say ARM.

To workaround this there is plenty of architecture specific code in
tools/perf/util:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util?h=3Dperf-tools-next
amd-sample-raw.c
arm64-frame-pointer-unwind-support.c
arm64-frame-pointer-unwind-support.h
arm-spe.c
arm-spe-decoder
arm-spe.h
intel-bts.c
intel-bts.h
intel-pt.c
intel-pt-decoder
intel-pt.h
intel-tpebs.c
intel-tpebs.h
s390-cpumcf-kernel.h
s390-cpumsf.c
s390-cpumsf.h
s390-cpumsf-kernel.h
s390-sample-raw.c

With this change added are:
dwarf-regs-csky.c
dwarf-regs-powerpc.c
dwarf-regs-x86.c

So I feel this way of doing things is most consistent and achieves the
best result.

In general I think the arch directory in perf is a mistake:
1) it breaks the profile on one platform, analyze on another model -
in this series it is shown that using the ELF machine is just better
than hard coding to the host architecture;
2) it is used as something of an ifdef __<arch>__ replacement but in a
way that makes understanding behavior in the code harder to fathom as
you need to understand weak functions (not a C feature) and the build
logic;
3) much of the code is really PMU driver dependent rather than
architecture dependent, moving such code out of arch would enable
things like user space emulation of the perf tool.

> But if this is just for reverse mapping of
> regname -> regnum, since we already have regnum -> regname maps in the
> header file, we can reimplement get_dwarf_regnum() as a generic function.
> And that is what you does in this series, correct?

That work could be done for get_dwarf_regnum but isn't done in this
series. Most architectures are missing get_arch_regnum.
For get_dwarf_regstr and get_arch_regstr there was the redundancy as
get_dwarf_regstr would compute a regstr if the machine wasn't E_NONE
in most cases. get_arch_regstr was only used for E_NONE. This code
changes E_NONE to E_HOST and then the get_arch_regstr code isn't
needed. There are #ifdefs adding complexity as I didn't do a single
monolithic patch - the maintainers usually complain if you do big
monolithic patches. Patches at the end of the series remove all the
#ifdefs, it is just without them the series will break cross
compilation if you bisect into the middle of it.

> If so, can you make a generic get_dwarf_regnum() at first, and remove
> the architecture dependent part which is not needed anymore.
> That should be more simpler to review.

I think this is out of scope for this series, not least because of the
testing challenge, but could be follow up work.

Thanks,
Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/Build                |  3 ---
> >  tools/perf/util/Build                         |  1 +
> >  .../dwarf-regs.c =3D> util/dwarf-regs-x86.c}    | 24 +----------------=
--
> >  tools/perf/util/dwarf-regs.c                  | 17 +++++++++++++
> >  tools/perf/util/include/dwarf-regs.h          |  8 +++++++
> >  5 files changed, 27 insertions(+), 26 deletions(-)
> >  rename tools/perf/{arch/x86/util/dwarf-regs.c =3D> util/dwarf-regs-x86=
.c} (77%)
> >
> > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/=
Build
> > index 9705cda4f240..70af491a6dd7 100644
> > --- a/tools/perf/arch/x86/util/Build
> > +++ b/tools/perf/arch/x86/util/Build
> > @@ -12,9 +12,6 @@ perf-util-y +=3D evsel.o
> >  perf-util-y +=3D iostat.o
> >  perf-util-y +=3D env.o
> >
> > -perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs.o
> > -perf-util-$(CONFIG_BPF_PROLOGUE) +=3D dwarf-regs.o
> > -
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1d08608b7e1b..c2221ef431f3 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -202,6 +202,7 @@ endif
> >  perf-util-$(CONFIG_LIBDW) +=3D probe-finder.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-aux.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs.o
> > +perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> >  perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> >
> > diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/util/dw=
arf-regs-x86.c
> > similarity index 77%
> > rename from tools/perf/arch/x86/util/dwarf-regs.c
> > rename to tools/perf/util/dwarf-regs-x86.c
> > index 530905118cd4..7a55c65e8da6 100644
> > --- a/tools/perf/arch/x86/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs-x86.c
> > @@ -11,28 +11,6 @@
> >  #include <linux/kernel.h> /* for ARRAY_SIZE */
> >  #include <dwarf-regs.h>
> >
> > -#define DEFINE_DWARF_REGSTR_TABLE 1
> > -#include "dwarf-regs-table.h"
> > -
> > -/* Return architecture dependent register string (for kprobe-tracer) *=
/
> > -const char *get_arch_regstr(unsigned int n)
> > -{
> > -#if defined(__i386__)
> > -     size_t len =3D ARRAY_SIZE(x86_32_regstr_tbl);
> > -#else
> > -     size_t len =3D ARRAY_SIZE(x86_64_regstr_tbl);
> > -#endif
> > -
> > -     if (n >=3D len)
> > -             return NULL;
> > -
> > -#if defined(__i386__)
> > -     return x86_32_regstr_tbl[n];
> > -#else
> > -     return x86_64_regstr_tbl[n];
> > -#endif
> > -}
> > -
> >  struct dwarf_regs_idx {
> >       const char *name;
> >       int idx;
> > @@ -58,7 +36,7 @@ static const struct dwarf_regs_idx x86_regidx_table[]=
 =3D {
> >       { "rip", DWARF_REG_PC },
> >  };
> >
> > -int get_arch_regnum(const char *name)
> > +int get_x86_regnum(const char *name)
> >  {
> >       unsigned int i;
> >
> > diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.=
c
> > index 86b3ef638fbb..eac99a246737 100644
> > --- a/tools/perf/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs.c
> > @@ -32,9 +32,17 @@
> >  const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
> >                            unsigned int flags __maybe_unused)
> >  {
> > +#if EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D EM_386
> > +     if (machine =3D=3D EM_NONE) {
> > +             /* Generic arch - use host arch */
> > +             machine =3D EM_HOST;
> > +     }
> > +#endif
> >       switch (machine) {
> > +#if EM_HOST !=3D EM_X86_64 && EM_HOST !=3D EM_386
> >       case EM_NONE:   /* Generic arch - use host arch */
> >               return get_arch_regstr(n);
> > +#endif
> >       case EM_386:
> >               return __get_dwarf_regstr(x86_32_regstr_tbl, n);
> >       case EM_X86_64:
> > @@ -65,10 +73,12 @@ const char *get_dwarf_regstr(unsigned int n, unsign=
ed int machine,
> >       return NULL;
> >  }
> >
> > +#if EM_HOST !=3D EM_X86_64 && EM_HOST !=3D EM_386
> >  __weak int get_arch_regnum(const char *name __maybe_unused)
> >  {
> >       return -ENOTSUP;
> >  }
> > +#endif
> >
> >  /* Return DWARF register number from architecture register name */
> >  int get_dwarf_regnum(const char *name, unsigned int machine, unsigned =
int flags __maybe_unused)
> > @@ -90,9 +100,16 @@ int get_dwarf_regnum(const char *name, unsigned int=
 machine, unsigned int flags
> >               machine =3D EM_HOST;
> >       }
> >       switch (machine) {
> > +#if EM_HOST !=3D EM_X86_64 && EM_HOST !=3D EM_386
> >       case EM_HOST:
> >               reg =3D get_arch_regnum(regname);
> >               break;
> > +#endif
> > +     case EM_X86_64:
> > +             fallthrough;
> > +     case EM_386:
> > +             reg =3D get_x86_regnum(regname);
> > +             break;
> >       default:
> >               pr_err("ELF MACHINE %x is not supported.\n", machine);
> >       }
> > diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inc=
lude/dwarf-regs.h
> > index 925525405e2d..062623aefd5a 100644
> > --- a/tools/perf/util/include/dwarf-regs.h
> > +++ b/tools/perf/util/include/dwarf-regs.h
> > @@ -79,7 +79,10 @@
> >  #define DWARF_REG_FB  0xd3affb /* random number */
> >
> >  #ifdef HAVE_LIBDW_SUPPORT
> > +#if !defined(__x86_64__) && !defined(__i386__)
> >  const char *get_arch_regstr(unsigned int n);
> > +#endif
> > +
> >  /**
> >   * get_dwarf_regstr() - Returns ftrace register string from DWARF regn=
um.
> >   * @n: DWARF register number.
> > @@ -88,7 +91,12 @@ const char *get_arch_regstr(unsigned int n);
> >   */
> >  const char *get_dwarf_regstr(unsigned int n, unsigned int machine, uns=
igned int flags);
> >
> > +int get_x86_regnum(const char *name);
> > +
> > +#if !defined(__x86_64__) && !defined(__i386__)
> >  int get_arch_regnum(const char *name);
> > +#endif
> > +
> >  /*
> >   * get_dwarf_regnum - Returns DWARF regnum from register name
> >   * name: architecture register name
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

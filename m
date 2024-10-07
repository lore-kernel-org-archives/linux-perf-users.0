Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2721D5ABA
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Oct 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316035; cv=none; b=MludbEwtfzSjNlxbqG6JG09bcHdbrv1Py/xCcHYWYuPcj/jrsIUwYTXOwVy7GUdLnodTuaoMYBTrh9z3E2G4NCNQAOjT+pncPHjtyKsKFiAJ/T3rrQLB3h+W+FAWUfBpPlovNKbl8aIFkWVjCpiw9sL+zBBSs2M1ZPUy1c0zrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316035; c=relaxed/simple;
	bh=3orWU/TR+HwUCJf+N/O4kdpAwTQz6wOCTHh40ojhmqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVTPlSyk5SidbMaPo3IblqEMN7qqD8CZSb1cWToO4crKtoJ40FR83FQu+KGX8oQyIX2EX/BdnB1cYJQRD5UrJD1kPU+AWrDrvfCvyIhV2K5cdR8iawvRGG5sMWv3htpEYswUbm+7qjOroOCPDInIPvGF986rO/LBezQYfzdR5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtAK+FSO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtAK+FSO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b40c7fd8eso301325ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Oct 2024 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728316033; x=1728920833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrYqnjJpJB2lRJdraSxJi37iXg6kEfvU/vqtEVr4XQ0=;
        b=UtAK+FSOJewCaxmSisiQxqfebpEw0ZEHmXKET2I+eV0XdJl2Hv0nmnS1VoCIyG9bMm
         poqZGXNuaV759+1drYYi6CvbnRYlwFQz8PHJ0ox/QETX3LvC1A6ESSAf2DTjwd5ovBOS
         6Q7TC/Jbvxs5unMk2cD1RXZreweE3BITG5dJky9oP4pWPn7g0KOgOaMku5GH9XUCzMoX
         0GQKDsj7zEftqybNg4Wi+sHZDF5t3pdRyWS4mnSUVGcWzO1ureutlgwuz8ajC6sao1D2
         HgFasy4/rPnnIJTVQ2Oz3BJ+oy5JklPGVyJDNlEpasgeeyyFhVSWd6MerrU/L4tOiB8e
         XpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316033; x=1728920833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrYqnjJpJB2lRJdraSxJi37iXg6kEfvU/vqtEVr4XQ0=;
        b=dUVtc5RIA8JpgbWkLn1ZS1/Dw1K3IEoQvR633GN+YanKNZrCNYQrO582AAgpYf4F5v
         Y2tpiIqgSuYtmjkAhCdxqcS/VAcmaaj01bhy+0LKqdCNzNkNtBc/PoHkCC1oBlHyfX6M
         7RheJ5P+xN+dD372mNyg+zIqTfOC+ZtsR7UZW2eS5OiDm26A7Ddip+DJ9KBTujWwCJxz
         SlV8YJbvtC36lgA5LgAc9vJumplbMYD6a4+LXMqjduGVGU2PYk+Sa/bq8quGpP/C3DTu
         l6nAGf3zsQSkzTCsOe8g78XFSZksW2Rpa7zmG+T27FLbcoQB48MgzRKyKt+G/Jl5PiR2
         ldzA==
X-Forwarded-Encrypted: i=1; AJvYcCUJN4HE1eVoCEqC+lVbF/REUoAl/S9c0uQL1YUqAvugaSVmD+CjPilbWOWVhF0fzTdY7CoOA+Eh893p7I84cnzp@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUMBJmnZzKi31+OtUXI1nAm3nQWgsxBYYoYChY59HFUK+Vi6E
	4jPo+P75we2ixhH184RSg6SrWs5hLNacgaImQNT9FTi/8BCXer8GhnQgbXNvrn5xzc5qMHKHt+t
	7/VCYwz/BVv/MnQEZzmJQYscJZRIyREfdAgmf
X-Google-Smtp-Source: AGHT+IGwu4PJ1LIQLyt4RHgM7VecbrJWT3jfoSUY3o0Fb4S+9czwyhW4r49SVjqTMABhYHxG7QyAo4EIkLYc5TDV9ys=
X-Received: by 2002:a17:902:daca:b0:1fb:172a:f3d4 with SMTP id
 d9443c01a7336-20c15ab20b3mr3586035ad.8.1728316031023; Mon, 07 Oct 2024
 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com> <20241005195541.380070-17-irogers@google.com>
 <20241007170755.03697b9178ed3dcac24dfa21@kernel.org>
In-Reply-To: <20241007170755.03697b9178ed3dcac24dfa21@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Oct 2024 08:46:59 -0700
Message-ID: <CAP-5=fU4hTL1hfB7-FpMnFopJJriZAOXY_8iakW5yHC_gfhTWg@mail.gmail.com>
Subject: Re: [PATCH v2 16/31] perf dwarf-regs: Pass accurate disassembly
 machine to get_dwarf_regnum
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

On Mon, Oct 7, 2024 at 1:08=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Sat,  5 Oct 2024 12:55:26 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > Rather than pass 0/EM_NONE, use the value computed in the disasm
> > struct arch. Switch the EM_NONE case to EM_HOST, rewriting EM_NONE if
> > it were passed to get_dwarf_regnum. Pass a flags value as
> > architectures like csky need the flags to determine the ABI variant.
> >
>
> Does this change the command output when we use it for cross-build
> environment? E.g. remote arch is different from host arch? If so,
> please add output examples with/without this change.

The cases where this would apply are small as get_arch_regnum is only
implemented for x86. get_dwarf_regnum likewise only works for x86 and
it is only called by annotate.
In this code without this patch the behavior is to return -ENOTSUP, ie
the code is set up to fail and this code just makes it not fail for
the x86 case (when not on x86) with code that is well tested on x86.
The code exists as x86 registers may be the same dwarf number but have
different names: e.g. rax, eax, ax, al. I'm not sure this reaches a
high complexity level for extensive testing. I'll see if I can grab an
x86 perf.data file to analyze on ARM, but I don't think doing this
should gate the series.

Thanks,
Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/annotate.c           | 6 +++---
> >  tools/perf/util/dwarf-regs.c         | 8 ++++++--
> >  tools/perf/util/include/dwarf-regs.h | 5 +++--
> >  3 files changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 37ce43c4eb8f..b1d98da79be8 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2292,7 +2292,7 @@ static int extract_reg_offset(struct arch *arch, =
const char *str,
> >       if (regname =3D=3D NULL)
> >               return -1;
> >
> > -     op_loc->reg1 =3D get_dwarf_regnum(regname, 0);
> > +     op_loc->reg1 =3D get_dwarf_regnum(regname, arch->e_machine, arch-=
>e_flags);
> >       free(regname);
> >
> >       /* Get the second register */
> > @@ -2305,7 +2305,7 @@ static int extract_reg_offset(struct arch *arch, =
const char *str,
> >               if (regname =3D=3D NULL)
> >                       return -1;
> >
> > -             op_loc->reg2 =3D get_dwarf_regnum(regname, 0);
> > +             op_loc->reg2 =3D get_dwarf_regnum(regname, arch->e_machin=
e, arch->e_flags);
> >               free(regname);
> >       }
> >       return 0;
> > @@ -2405,7 +2405,7 @@ int annotate_get_insn_location(struct arch *arch,=
 struct disasm_line *dl,
> >                               return -1;
> >
> >                       if (*s =3D=3D arch->objdump.register_char)
> > -                             op_loc->reg1 =3D get_dwarf_regnum(s, 0);
> > +                             op_loc->reg1 =3D get_dwarf_regnum(s, arch=
->e_machine, arch->e_flags);
> >                       else if (*s =3D=3D arch->objdump.imm_char) {
> >                               op_loc->offset =3D strtol(s + 1, &p, 0);
> >                               if (p && p !=3D s + 1)
> > diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.=
c
> > index 7c01bc4d7e5b..1321387f6948 100644
> > --- a/tools/perf/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs.c
> > @@ -70,7 +70,7 @@ __weak int get_arch_regnum(const char *name __maybe_u=
nused)
> >  }
> >
> >  /* Return DWARF register number from architecture register name */
> > -int get_dwarf_regnum(const char *name, unsigned int machine)
> > +int get_dwarf_regnum(const char *name, unsigned int machine, unsigned =
int flags __maybe_unused)
> >  {
> >       char *regname =3D strdup(name);
> >       int reg =3D -1;
> > @@ -84,8 +84,12 @@ int get_dwarf_regnum(const char *name, unsigned int =
machine)
> >       if (p)
> >               *p =3D '\0';
> >
> > +     if (machine =3D=3D EM_NONE) {
> > +             /* Generic arch - use host arch */
> > +             machine =3D EM_HOST;
> > +     }
> >       switch (machine) {
> > -     case EM_NONE:   /* Generic arch - use host arch */
> > +     case EM_HOST:
> >               reg =3D get_arch_regnum(regname);
> >               break;
> >       default:
> > diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inc=
lude/dwarf-regs.h
> > index f4f87ded5e3d..ee0a734564c7 100644
> > --- a/tools/perf/util/include/dwarf-regs.h
> > +++ b/tools/perf/util/include/dwarf-regs.h
> > @@ -93,12 +93,13 @@ int get_arch_regnum(const char *name);
> >   * name: architecture register name
> >   * machine: ELF machine signature (EM_*)
> >   */
> > -int get_dwarf_regnum(const char *name, unsigned int machine);
> > +int get_dwarf_regnum(const char *name, unsigned int machine, unsigned =
int flags);
> >
> >  #else /* HAVE_LIBDW_SUPPORT */
> >
> >  static inline int get_dwarf_regnum(const char *name __maybe_unused,
> > -                                unsigned int machine __maybe_unused)
> > +                                unsigned int machine __maybe_unused,
> > +                                unsigned int flags __maybe_unused)
> >  {
> >       return -1;
> >  }
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

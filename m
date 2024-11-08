Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB36192D7F
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091568; cv=none; b=hRTsieHLbH+LXw1xRG5JnrXnrz8hN72qjGe5JfTVzmakg+Zg0cYX2LoBo643JNCgNCFKkr6bhpL1qkN6jdRIl+nMCkwqZOfCYywBwIG2RepAnJWLbB+X3bHML5W5qDqVtYe2vVPGUt1ulJwLumsk/ncZsoBIPdGxFyCm01YAsDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091568; c=relaxed/simple;
	bh=/WS+fI5h/o/kkOA1At/6uiAJlBqvU583Dh59ply0Wnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHSj1npda0CKYKu4fcgA9tBSbLVh1ZAOTZEnorpJfO+hdVr4+zi8fg21WyJrBGAdrYkrerd7bW4BbVUoysZC0drHI9pf6gko6iqLJirVQ2Jmf6RPLxw6LUdW7iOzZ/E3Z9JeiSGFUDbf3jmlA5gt8Cbsf4f8UtPlwtP6kHXtp/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMTL2ujF; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMTL2ujF"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so4945ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 10:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091566; x=1731696366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oq7W5H+t/LruxWYJFi93XWxZ+SC0sXDXHOurVmQo/Bw=;
        b=OMTL2ujFUlNAYv8a1Iw5CJ5sVHI6uTRDeryHxBTA+we+Ib2PcZPtqdeIPN1I45++Jq
         tRmkmM7Py3KDOgBA4MAhvtYsTeQ0rNg+NGf77OatnlTeXRcvTvObmNpGtACRIfWPx5R1
         2rAADUKUKcFyDY8xG3HyYTejskc+kM7Ogj9h7SaxU6sq1IbGcNX2xo1wUEMSPzUS93sp
         I7DKzBUzm1ah7vI6f9YzIHi5+06oNlic/B8Rx9lq9Sh8vCmo1KCULBiuXOnz+K/upR/D
         a0GLUyirARXFW8ZPn5v8VO87NPwKwshzMGq2/JsCB1zBJ0WDlNVqkS40DddcQImHF6ix
         SnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091566; x=1731696366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oq7W5H+t/LruxWYJFi93XWxZ+SC0sXDXHOurVmQo/Bw=;
        b=qQkizls6mf9a8KgRBMbEjgT32X8ESStt1YLWj2H0xdvKN3VSMap3odqiaXM46G2lHW
         FNHJYrVCLXwDNxczstLtlpF3uoVk8X3F6Cg7PAAe10ITym3DoUAZruU+0IAQoclUjdS0
         WvuT6zfCDgvDQJcmhwTnf8lzNXYmx1Otbtr7xwgOcuuA9bYmIIeLsaHSC8LOEbMDcsfi
         zfnkNOYVIOsU6IeVxU1URUmh8jdFUFO21IiobANV8ZCOXK3JZCY6+QQuJw2xLCifGBd9
         3evgRTAZnqZYBnoilvJ91k76VlkJLL2fWzxopQvwKyUmFCFqfHPagCcN46ubd/bFUe22
         5syQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXv59xAQKRLRfjsuSVjkNqrsdJbTEyvItBKWA6ir9ooUS2Df02qBCU2fHZNBN1sD2CWhu8A2LqoWOh+g3oQ46A@vger.kernel.org
X-Gm-Message-State: AOJu0YwmA4APg7AYuylj9DxcRGL2eZvLKfjrwHGMjfgOamGu2NwfB0fj
	0QInfFTJQ5h+wTL0EU5XP6Mebr+Zi3UMuRtUJwxivWV4NCygyszVPT/JYmM2pbl9ut8G3fSYI9+
	WRwI73AQVKxpqOOV7tdmTo1gqCFMJXM6YCeu5
X-Gm-Gg: ASbGnctR7n8A69rj5ctOECcdwuFmGSIN5R3MET8JbgBVZ3fhMIRH1D96WqNUWiFpiNj
	+OOy8CDEFW7Qll6omSDzkLDAFi/YobvMl
X-Google-Smtp-Source: AGHT+IHdLRWHy0a2E8ArZqPLt9njQZotEfT+CpO+S5UTw1lpU681rHBzVlJvCzLHGs/O89svRJOnyjbXFrmZAfHjHVI=
X-Received: by 2002:a05:6e02:1c81:b0:3a6:f43d:a24e with SMTP id
 e9e14a558f8ab-3a6f8a06128mr98245ab.10.1731091565707; Fri, 08 Nov 2024
 10:46:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com> <20241017002520.59124-5-irogers@google.com>
 <Zy5Le-xn4gzQ2WLo@google.com> <CAP-5=fXe-gJ6pXwdTgGqScCR+mKS2FBfVDsbih7vL-1kPKAvaA@mail.gmail.com>
 <Zy5aoMnY2nupb7SX@google.com>
In-Reply-To: <Zy5aoMnY2nupb7SX@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 10:45:54 -0800
Message-ID: <CAP-5=fW7m0AVVn42XK9s=RFmAs63mh4Mk5QehpLKLFMAGje+9A@mail.gmail.com>
Subject: Re: [PATCH v3 04/20] perf disasm: Add e_machine/e_flags to struct arch
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:38=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 08, 2024 at 10:19:52AM -0800, Ian Rogers wrote:
> > On Fri, Nov 8, 2024 at 9:33=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 05:25:04PM -0700, Ian Rogers wrote:
> > > > Currently functions like get_dwarf_regnum only work with the host
> > > > architecture. Carry the elf machine and flags in struct arch so tha=
t
> > > > in disassembly these can be used to allow cross platform disassembl=
y.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/arch/arc/annotate/instructions.c       | 2 ++
> > > >  tools/perf/arch/arm/annotate/instructions.c       | 2 ++
> > > >  tools/perf/arch/arm64/annotate/instructions.c     | 2 ++
> > > >  tools/perf/arch/csky/annotate/instructions.c      | 7 ++++++-
> > > >  tools/perf/arch/loongarch/annotate/instructions.c | 2 ++
> > > >  tools/perf/arch/mips/annotate/instructions.c      | 2 ++
> > > >  tools/perf/arch/powerpc/annotate/instructions.c   | 2 ++
> > > >  tools/perf/arch/riscv64/annotate/instructions.c   | 2 ++
> > > >  tools/perf/arch/s390/annotate/instructions.c      | 2 ++
> > > >  tools/perf/arch/sparc/annotate/instructions.c     | 2 ++
> > > >  tools/perf/arch/x86/annotate/instructions.c       | 3 ++-
> > > >  tools/perf/util/disasm.h                          | 4 ++++
> > > >  12 files changed, 30 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/pe=
rf/arch/arc/annotate/instructions.c
> > > > index 2f00e995c7e3..e5619770a1af 100644
> > > > --- a/tools/perf/arch/arc/annotate/instructions.c
> > > > +++ b/tools/perf/arch/arc/annotate/instructions.c
> > > > @@ -5,5 +5,7 @@ static int arc__annotate_init(struct arch *arch, ch=
ar *cpuid __maybe_unused)
> > > >  {
> > > >       arch->initialized =3D true;
> > > >       arch->objdump.comment_char =3D ';';
> > > > +     arch->e_machine =3D EM_ARC;
> > > > +     arch->e_flags =3D 0;
> > > >       return 0;
> > > >  }
> > > > diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/pe=
rf/arch/arm/annotate/instructions.c
> > > > index 2ff6cedeb9c5..cf91a43362b0 100644
> > > > --- a/tools/perf/arch/arm/annotate/instructions.c
> > > > +++ b/tools/perf/arch/arm/annotate/instructions.c
> > > > @@ -53,6 +53,8 @@ static int arm__annotate_init(struct arch *arch, =
char *cpuid __maybe_unused)
> > > >       arch->associate_instruction_ops   =3D arm__associate_instruct=
ion_ops;
> > > >       arch->objdump.comment_char        =3D ';';
> > > >       arch->objdump.skip_functions_char =3D '+';
> > > > +     arch->e_machine =3D EM_ARM;
> > > > +     arch->e_flags =3D 0;
> > > >       return 0;
> > > >
> > > >  out_free_call:
> > > > diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/=
perf/arch/arm64/annotate/instructions.c
> > > > index f86d9f4798bd..d465d093e7eb 100644
> > > > --- a/tools/perf/arch/arm64/annotate/instructions.c
> > > > +++ b/tools/perf/arch/arm64/annotate/instructions.c
> > > > @@ -113,6 +113,8 @@ static int arm64__annotate_init(struct arch *ar=
ch, char *cpuid __maybe_unused)
> > > >       arch->associate_instruction_ops   =3D arm64__associate_instru=
ction_ops;
> > > >       arch->objdump.comment_char        =3D '/';
> > > >       arch->objdump.skip_functions_char =3D '+';
> > > > +     arch->e_machine =3D EM_AARCH64;
> > > > +     arch->e_flags =3D 0;
> > > >       return 0;
> > > >
> > > >  out_free_call:
> > > > diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/p=
erf/arch/csky/annotate/instructions.c
> > > > index 5337bfb7d5fc..14270311d215 100644
> > > > --- a/tools/perf/arch/csky/annotate/instructions.c
> > > > +++ b/tools/perf/arch/csky/annotate/instructions.c
> > > > @@ -43,6 +43,11 @@ static int csky__annotate_init(struct arch *arch=
, char *cpuid __maybe_unused)
> > > >       arch->initialized =3D true;
> > > >       arch->objdump.comment_char =3D '/';
> > > >       arch->associate_instruction_ops =3D csky__associate_ins_ops;
> > > > -
> > > > +     arch->e_machine =3D EM_CSKY;
> > > > +#if defined(__CSKYABIV2__)
> > > > +     arch->e_flags =3D EF_CSKY_ABIV2;
> > > > +#else
> > > > +     arch->e_flags =3D EF_CSKY_ABIV1;
> > > > +#endif
> > >
> > > By moving this into the general code, it should take care of old syst=
ems
> > > that doesn't have the macro.
> > >
> > >   In file included from util/disasm.c:109:
> > >   /linux/tools/perf/arch/csky/annotate/instructions.c: In function 'c=
sky__annotate_init':
> > >   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: error: '=
EF_CSKY_ABIV1' undeclared (first use in this function)
> > >      50 |         arch->e_flags =3D EF_CSKY_ABIV1;
> > >         |                         ^~~~~~~~~~~~~
> > >   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: note: ea=
ch undeclared identifier is reported only once for each function it appears=
 in
> >
> > EF_CSKY_ABIV1 is defined in elf.h and has been there at least 5 years i=
n libelf:
> > https://sourceware.org/git/?p=3Delfutils.git;a=3Dcommit;f=3Dlibelf/elf.=
h;h=3D9c82942ae7355a3226c53a92c2c73b33193c5e33
> > I suspected the issue here is missing elf.h include, but the .c file
> > is included in tools/perf/util/disasm.c and that must have a
> > transitive dependency given other things are building. Do you want me
> > to send a patch making this conditional with extra #ifdefs or re-send
> > the series?
>
> Yeah, it's unfortunate but I think we can have a small incremental diff
> here to define them if it's not there.  Then I'll squash it to the
> patch.

Thanks, sgtm. Could you also explicitly include elf.h into disasm.c
rather than depending on the transitive #include? There's obviously
tech debt to not have .c files including each other to work around the
build system.

Ian

> >
> > > Also, I think __CSKYABIV2__ is defined only when the host is csky.  S=
o
> > > it'll use ABI v1 on cross env.  I'm not sure if it's a problem.  We m=
ay
> > > need to save the ABI somewhere in the metadata later.
> >
> > Agreed. In general we should read e_machine and e_flags from the ELF
> > file, so I'm not sure new metadata is needed. This patch is trying to
> > lay groundwork for that.
>
> I understand that.  Yeah it should come from the binary.
>
> Thanks,
> Namhyung
>

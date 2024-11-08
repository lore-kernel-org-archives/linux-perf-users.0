Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E05B1FB
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090007; cv=none; b=J0sJlk/SB6yNvRPodOT2m0wdKij0snqt5fBDCPNoSESUNWn34mbVBNiLoTxEa8U/PaRwlQKIIRap9VHplwhwEKtNwUOgBHE2uHBOqhMEmmSb5Ru95TstPjIQlrF3THHQLgPO2FhfZGi5FrGDeQtzYhhi/0xnL+xfvl6KDn7RLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090007; c=relaxed/simple;
	bh=JUYHYugwKT/LOXZUS3wyLNIITd7vm4Hd7wMZQgV8EGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Emed5cVJwfsB5on9EuBybXXiPNdW7h78NC4LYJb9r7cfOWn3S5T+woy7ltjiLvIIE1t9gIo3ppTLAFl+EQVCS/jAOA6mR4MdJ7mOSafnQ8LPzgGP6bV4DV5Gw96zxlQ7oHRkWHho/rwhTqZNjpdsbkmj4J3OnMuTJlsXjxEsUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AClOlCTT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AClOlCTT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8ac50b79so6275ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731090004; x=1731694804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf7MfvQHFHsMilMOcrRu8oE+bBUT3BnfeKEv0/Bnz2U=;
        b=AClOlCTTEviVvL3bAC0WTb6Kql8wnaZciP83XD3Oy/KLZ3Hwd4x2cQrAh9RGDOKvOv
         c9rCIWQ1Dro3Ta4YNj0DheDZ+oWiJIiYbtxGYdAOLadkt6Ko1RFOXBRjFNBNMkv4Po5H
         UZ4SOykj15ecYPYNUgMLxDmX87rJDQR3xbzLE3pSriULAXKSYexljQvPN1kBP+II/iUv
         mNStrKkYDo0XplZo7gJsn5YvxKY6aSVGa+ale5Pj5rzbINR9ucuNJ4MKrFFLTS7NQ/n+
         ecKMFA1nRwVju4vOlzVTHzvtrg7qKHlOq/XGjcYrxaMgbGNFTYU2W9n33noSd2c/6e3V
         SxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731090004; x=1731694804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf7MfvQHFHsMilMOcrRu8oE+bBUT3BnfeKEv0/Bnz2U=;
        b=w25plh49jjkjV8pH2YRbV1IbqWS8Sq8v++GqUV0r0+sCNcUadvmjvytbIXX2Wrkixe
         1oHv2zXssgeRMzKjreYZyvgqdl/LuT81XFHwc8jQhrqA0dRrBZEnMg/7LGxa7Z/akV2w
         p4LJ4RgSJN/77I3zFBjpbe+T/0QHw8GT/5oVIeUvqaLK/BiHJ7acth8QBsMAd5WMzlxu
         GwLUZtA7jWEY6/CNvmtqOwvZ9W2S5oqFxK5DaN+pywJYfNGo8NH034HAqD0Gke7QH+Vc
         B4MlqzJ92ngRNfCqwR4iIEx8hb14Afbr/Qu8X5t2Gxga1rzyT/W6NXa92hWelzlxfa0i
         aH3w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/yiAxC8zulFYbzXN0gAJ7GSEQkPtpErqiezqqVqodf/+x8AqtAs2WB4tnwQ/YMQRKi5j8bi8sz++KPBeP7Yw@vger.kernel.org
X-Gm-Message-State: AOJu0YzCtVYF1T3AFCXO1xcrxy4FEcQsV4n/5FS8iayFi9b4nYvsOBta
	7Iujzh7i+5B3bYk0lvxkTk8s9fYC/+gRzjpEidviFOrTX1P2s+D1tDWGwhG8VH5zqsPy79oMVwA
	D/QMf5331AdT0xExerRJS2N8GTU2WB5AxoDdQ
X-Gm-Gg: ASbGncugNnM4f4z7zdj/4egqciVjB5s+zXx/8CxTv4t9B3IpoXwOhqaJ9wOWoOg5JlM
	qZ/KPD1lrCFnXlFMe4MYfdpBtm53Hdnjn
X-Google-Smtp-Source: AGHT+IGAGxygO8zIMuBBzlLrISaHhzYu5CrxNemIriyDIaZe+XR//zXcE6s13MhITP3HJRDsgVoeguyaiFUqTkwRFOs=
X-Received: by 2002:a17:902:d4c7:b0:205:968b:31e9 with SMTP id
 d9443c01a7336-211748f482dmr6592465ad.1.1731090004012; Fri, 08 Nov 2024
 10:20:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com> <20241017002520.59124-5-irogers@google.com>
 <Zy5Le-xn4gzQ2WLo@google.com>
In-Reply-To: <Zy5Le-xn4gzQ2WLo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 10:19:52 -0800
Message-ID: <CAP-5=fXe-gJ6pXwdTgGqScCR+mKS2FBfVDsbih7vL-1kPKAvaA@mail.gmail.com>
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

On Fri, Nov 8, 2024 at 9:33=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Oct 16, 2024 at 05:25:04PM -0700, Ian Rogers wrote:
> > Currently functions like get_dwarf_regnum only work with the host
> > architecture. Carry the elf machine and flags in struct arch so that
> > in disassembly these can be used to allow cross platform disassembly.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arc/annotate/instructions.c       | 2 ++
> >  tools/perf/arch/arm/annotate/instructions.c       | 2 ++
> >  tools/perf/arch/arm64/annotate/instructions.c     | 2 ++
> >  tools/perf/arch/csky/annotate/instructions.c      | 7 ++++++-
> >  tools/perf/arch/loongarch/annotate/instructions.c | 2 ++
> >  tools/perf/arch/mips/annotate/instructions.c      | 2 ++
> >  tools/perf/arch/powerpc/annotate/instructions.c   | 2 ++
> >  tools/perf/arch/riscv64/annotate/instructions.c   | 2 ++
> >  tools/perf/arch/s390/annotate/instructions.c      | 2 ++
> >  tools/perf/arch/sparc/annotate/instructions.c     | 2 ++
> >  tools/perf/arch/x86/annotate/instructions.c       | 3 ++-
> >  tools/perf/util/disasm.h                          | 4 ++++
> >  12 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/a=
rch/arc/annotate/instructions.c
> > index 2f00e995c7e3..e5619770a1af 100644
> > --- a/tools/perf/arch/arc/annotate/instructions.c
> > +++ b/tools/perf/arch/arc/annotate/instructions.c
> > @@ -5,5 +5,7 @@ static int arc__annotate_init(struct arch *arch, char *=
cpuid __maybe_unused)
> >  {
> >       arch->initialized =3D true;
> >       arch->objdump.comment_char =3D ';';
> > +     arch->e_machine =3D EM_ARC;
> > +     arch->e_flags =3D 0;
> >       return 0;
> >  }
> > diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/a=
rch/arm/annotate/instructions.c
> > index 2ff6cedeb9c5..cf91a43362b0 100644
> > --- a/tools/perf/arch/arm/annotate/instructions.c
> > +++ b/tools/perf/arch/arm/annotate/instructions.c
> > @@ -53,6 +53,8 @@ static int arm__annotate_init(struct arch *arch, char=
 *cpuid __maybe_unused)
> >       arch->associate_instruction_ops   =3D arm__associate_instruction_=
ops;
> >       arch->objdump.comment_char        =3D ';';
> >       arch->objdump.skip_functions_char =3D '+';
> > +     arch->e_machine =3D EM_ARM;
> > +     arch->e_flags =3D 0;
> >       return 0;
> >
> >  out_free_call:
> > diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf=
/arch/arm64/annotate/instructions.c
> > index f86d9f4798bd..d465d093e7eb 100644
> > --- a/tools/perf/arch/arm64/annotate/instructions.c
> > +++ b/tools/perf/arch/arm64/annotate/instructions.c
> > @@ -113,6 +113,8 @@ static int arm64__annotate_init(struct arch *arch, =
char *cpuid __maybe_unused)
> >       arch->associate_instruction_ops   =3D arm64__associate_instructio=
n_ops;
> >       arch->objdump.comment_char        =3D '/';
> >       arch->objdump.skip_functions_char =3D '+';
> > +     arch->e_machine =3D EM_AARCH64;
> > +     arch->e_flags =3D 0;
> >       return 0;
> >
> >  out_free_call:
> > diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/=
arch/csky/annotate/instructions.c
> > index 5337bfb7d5fc..14270311d215 100644
> > --- a/tools/perf/arch/csky/annotate/instructions.c
> > +++ b/tools/perf/arch/csky/annotate/instructions.c
> > @@ -43,6 +43,11 @@ static int csky__annotate_init(struct arch *arch, ch=
ar *cpuid __maybe_unused)
> >       arch->initialized =3D true;
> >       arch->objdump.comment_char =3D '/';
> >       arch->associate_instruction_ops =3D csky__associate_ins_ops;
> > -
> > +     arch->e_machine =3D EM_CSKY;
> > +#if defined(__CSKYABIV2__)
> > +     arch->e_flags =3D EF_CSKY_ABIV2;
> > +#else
> > +     arch->e_flags =3D EF_CSKY_ABIV1;
> > +#endif
>
> By moving this into the general code, it should take care of old systems
> that doesn't have the macro.
>
>   In file included from util/disasm.c:109:
>   /linux/tools/perf/arch/csky/annotate/instructions.c: In function 'csky_=
_annotate_init':
>   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: error: 'EF_C=
SKY_ABIV1' undeclared (first use in this function)
>      50 |         arch->e_flags =3D EF_CSKY_ABIV1;
>         |                         ^~~~~~~~~~~~~
>   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: note: each u=
ndeclared identifier is reported only once for each function it appears in

EF_CSKY_ABIV1 is defined in elf.h and has been there at least 5 years in li=
belf:
https://sourceware.org/git/?p=3Delfutils.git;a=3Dcommit;f=3Dlibelf/elf.h;h=
=3D9c82942ae7355a3226c53a92c2c73b33193c5e33
I suspected the issue here is missing elf.h include, but the .c file
is included in tools/perf/util/disasm.c and that must have a
transitive dependency given other things are building. Do you want me
to send a patch making this conditional with extra #ifdefs or re-send
the series?

> Also, I think __CSKYABIV2__ is defined only when the host is csky.  So
> it'll use ABI v1 on cross env.  I'm not sure if it's a problem.  We may
> need to save the ABI somewhere in the metadata later.

Agreed. In general we should read e_machine and e_flags from the ELF
file, so I'm not sure new metadata is needed. This patch is trying to
lay groundwork for that.

Thanks,
Ian

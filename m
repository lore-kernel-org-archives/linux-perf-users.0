Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED9E199949;
	Fri,  8 Nov 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091107; cv=none; b=nvVk21Uw8gOMtSwclEfbOHxb/MezXNpwso8XU6O4oBY2fgWrazLue+GBevlwxp19xrNzgYOB06fBIiGv8hy5xVIesnfxirA76CcQhmnV3APYTL9teYUhpvDmbesAjA/EWEuRUzunBgUh8Hq3EiVEA/VckPq/NX8w0G2ff7MN9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091107; c=relaxed/simple;
	bh=ysbnWIA04niPh4/FnRelxvy/7qgNN9jt3TdDs+ECXHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqzIAFqKZ09q1NW/6dbwa7DPBjXpglX+kgHMjo1P9jn6hrJ7JlFn6jOphgwIYbYeQcvfQTdhkO/IxUGgdgzehVJlk9xJ7fuETNhFn85EnoYeUkSSvPCMV36T9xELZZVEpfOyO86oRbnpbdKXqEWSXJ6bkPT+LtPI0gPYR8f4ek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5x9U7KD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5x9U7KD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85CDC4CECD;
	Fri,  8 Nov 2024 18:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731091107;
	bh=ysbnWIA04niPh4/FnRelxvy/7qgNN9jt3TdDs+ECXHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5x9U7KDBB10MgdIZ5cjW590p6De536vrCk6OUvDIUUWG2j2zr4RwiRpbjUPAeBfJ
	 KA+Mj+0+vl1KNhF2gZGB3soVZT6L4Mq/fgt6ZAkMTvHEaZcF6cD/gm+P3ks6j2M8Ce
	 0aFHCp+CEvssjEwhAJ/3qT904uMtGPDYzowmckVMpkBsiMOPjm/cf5hsu0BkrngexS
	 +ePBbaF3hoEU86XGCPhGZY/Qr3JR9xpJ+Uz3p2yAEsewaPXhnSpWjXv13FrdBVsClu
	 lZ4glEdEamcE+LykLNeeXHS25zbgkF9/5tjYvV8cmic/HB/9XlfQfKa6/YwQ2/kqh8
	 u0Ykcp1J7+p7Q==
Date: Fri, 8 Nov 2024 10:38:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>, Atish Patra <atishp@rivosinc.com>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Anup Patel <anup@brainfault.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 04/20] perf disasm: Add e_machine/e_flags to struct
 arch
Message-ID: <Zy5aoMnY2nupb7SX@google.com>
References: <20241017002520.59124-1-irogers@google.com>
 <20241017002520.59124-5-irogers@google.com>
 <Zy5Le-xn4gzQ2WLo@google.com>
 <CAP-5=fXe-gJ6pXwdTgGqScCR+mKS2FBfVDsbih7vL-1kPKAvaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXe-gJ6pXwdTgGqScCR+mKS2FBfVDsbih7vL-1kPKAvaA@mail.gmail.com>

On Fri, Nov 08, 2024 at 10:19:52AM -0800, Ian Rogers wrote:
> On Fri, Nov 8, 2024 at 9:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Oct 16, 2024 at 05:25:04PM -0700, Ian Rogers wrote:
> > > Currently functions like get_dwarf_regnum only work with the host
> > > architecture. Carry the elf machine and flags in struct arch so that
> > > in disassembly these can be used to allow cross platform disassembly.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/arch/arc/annotate/instructions.c       | 2 ++
> > >  tools/perf/arch/arm/annotate/instructions.c       | 2 ++
> > >  tools/perf/arch/arm64/annotate/instructions.c     | 2 ++
> > >  tools/perf/arch/csky/annotate/instructions.c      | 7 ++++++-
> > >  tools/perf/arch/loongarch/annotate/instructions.c | 2 ++
> > >  tools/perf/arch/mips/annotate/instructions.c      | 2 ++
> > >  tools/perf/arch/powerpc/annotate/instructions.c   | 2 ++
> > >  tools/perf/arch/riscv64/annotate/instructions.c   | 2 ++
> > >  tools/perf/arch/s390/annotate/instructions.c      | 2 ++
> > >  tools/perf/arch/sparc/annotate/instructions.c     | 2 ++
> > >  tools/perf/arch/x86/annotate/instructions.c       | 3 ++-
> > >  tools/perf/util/disasm.h                          | 4 ++++
> > >  12 files changed, 30 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/arch/arc/annotate/instructions.c
> > > index 2f00e995c7e3..e5619770a1af 100644
> > > --- a/tools/perf/arch/arc/annotate/instructions.c
> > > +++ b/tools/perf/arch/arc/annotate/instructions.c
> > > @@ -5,5 +5,7 @@ static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> > >  {
> > >       arch->initialized = true;
> > >       arch->objdump.comment_char = ';';
> > > +     arch->e_machine = EM_ARC;
> > > +     arch->e_flags = 0;
> > >       return 0;
> > >  }
> > > diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
> > > index 2ff6cedeb9c5..cf91a43362b0 100644
> > > --- a/tools/perf/arch/arm/annotate/instructions.c
> > > +++ b/tools/perf/arch/arm/annotate/instructions.c
> > > @@ -53,6 +53,8 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> > >       arch->associate_instruction_ops   = arm__associate_instruction_ops;
> > >       arch->objdump.comment_char        = ';';
> > >       arch->objdump.skip_functions_char = '+';
> > > +     arch->e_machine = EM_ARM;
> > > +     arch->e_flags = 0;
> > >       return 0;
> > >
> > >  out_free_call:
> > > diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
> > > index f86d9f4798bd..d465d093e7eb 100644
> > > --- a/tools/perf/arch/arm64/annotate/instructions.c
> > > +++ b/tools/perf/arch/arm64/annotate/instructions.c
> > > @@ -113,6 +113,8 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> > >       arch->associate_instruction_ops   = arm64__associate_instruction_ops;
> > >       arch->objdump.comment_char        = '/';
> > >       arch->objdump.skip_functions_char = '+';
> > > +     arch->e_machine = EM_AARCH64;
> > > +     arch->e_flags = 0;
> > >       return 0;
> > >
> > >  out_free_call:
> > > diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
> > > index 5337bfb7d5fc..14270311d215 100644
> > > --- a/tools/perf/arch/csky/annotate/instructions.c
> > > +++ b/tools/perf/arch/csky/annotate/instructions.c
> > > @@ -43,6 +43,11 @@ static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> > >       arch->initialized = true;
> > >       arch->objdump.comment_char = '/';
> > >       arch->associate_instruction_ops = csky__associate_ins_ops;
> > > -
> > > +     arch->e_machine = EM_CSKY;
> > > +#if defined(__CSKYABIV2__)
> > > +     arch->e_flags = EF_CSKY_ABIV2;
> > > +#else
> > > +     arch->e_flags = EF_CSKY_ABIV1;
> > > +#endif
> >
> > By moving this into the general code, it should take care of old systems
> > that doesn't have the macro.
> >
> >   In file included from util/disasm.c:109:
> >   /linux/tools/perf/arch/csky/annotate/instructions.c: In function 'csky__annotate_init':
> >   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: error: 'EF_CSKY_ABIV1' undeclared (first use in this function)
> >      50 |         arch->e_flags = EF_CSKY_ABIV1;
> >         |                         ^~~~~~~~~~~~~
> >   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: note: each undeclared identifier is reported only once for each function it appears in
> 
> EF_CSKY_ABIV1 is defined in elf.h and has been there at least 5 years in libelf:
> https://sourceware.org/git/?p=elfutils.git;a=commit;f=libelf/elf.h;h=9c82942ae7355a3226c53a92c2c73b33193c5e33
> I suspected the issue here is missing elf.h include, but the .c file
> is included in tools/perf/util/disasm.c and that must have a
> transitive dependency given other things are building. Do you want me
> to send a patch making this conditional with extra #ifdefs or re-send
> the series?

Yeah, it's unfortunate but I think we can have a small incremental diff
here to define them if it's not there.  Then I'll squash it to the
patch.

> 
> > Also, I think __CSKYABIV2__ is defined only when the host is csky.  So
> > it'll use ABI v1 on cross env.  I'm not sure if it's a problem.  We may
> > need to save the ABI somewhere in the metadata later.
> 
> Agreed. In general we should read e_machine and e_flags from the ELF
> file, so I'm not sure new metadata is needed. This patch is trying to
> lay groundwork for that.

I understand that.  Yeah it should come from the binary.

Thanks,
Namhyung


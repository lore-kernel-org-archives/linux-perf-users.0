Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF171D95A2;
	Fri,  4 Oct 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069818; cv=none; b=qnFVaG0Onp+5J+TA7Bt3u3W8WD4upF4xii/hbMKRvY2rnrGTEafz51awN1IkOPKIdwWuGMMu3nw+3NznHOgUTZsJaXGJQKkEMpCZaVW955/GCmHFwviK76tySvBznSBaAdOXJ2/I/ma3sWGcDDROS2gHRiqe/+nZv6UXMoXHsrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069818; c=relaxed/simple;
	bh=otK0x2nuRoYkX6AVr+3xhfdRrkCNDV/nxTPPVs2qFb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex/jov0B9hRRjdUyhTza+LKEvJ64gVJqTrQqx6bKKqRJ66VqT01OxzDej9iRxozUcmlj22lgjtEd4LZ0WTKFhWO0liEMMOU+cfwqSno7yCFL22vfH2Cvnldjn+i5YqkR8K/pc/KAoHRng5QIYcQb/lWaM2QeHKUpMEJg1MGHG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKmyqMoJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKmyqMoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4C3C4CEC6;
	Fri,  4 Oct 2024 19:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069817;
	bh=otK0x2nuRoYkX6AVr+3xhfdRrkCNDV/nxTPPVs2qFb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKmyqMoJ7ZnbYJTm8k6NflxxW657q4myATsgm25ito4zDtfxBI1zOXdU5DdvhBppd
	 XBBkZfreg2lZ5zdKB7drh6TOuu1yjNuaivh4oPQSP3hKtrce/nN0OVgjuSsq94EtPX
	 1s+zXl6wfOU3JiBAslKte7RR74AaouE1AxnM8lsX0Q2ug1SqGPfF3feObAJyuxeAZR
	 PCA/z7IAfVldOT8AgpiZR7mUevwfW46LvjxQUCFbw4Un99mMArhAmYAsmf3xkajo6c
	 b4seT6nGNggX0dRqBYaPo1xPE8lbOPOqDlqRETxe2BfdwvNAI7UyNsv1OGLE6EgZan
	 LmPArfsDkFdLw==
Date: Fri, 4 Oct 2024 12:23:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
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
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Atish Patra <atishp@rivosinc.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to
 PERF_HAVE_LIBDW_REGS
Message-ID: <ZwBAtbF9GWD4HQ6y@google.com>
References: <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
 <20241002082859.8821e441024fe873a4301afc@kernel.org>
 <CAP-5=fWcOpF4+mgnkHOG=ntGMafJ7JSks_4j1JWVvgccApn+Ng@mail.gmail.com>
 <20241002225614.774bdd0742a826557f142d0e@kernel.org>
 <CAP-5=fWoiD=7XbB3FbE++1RSo3BZKeOOyNg81t4GQ7Ve6ejpSg@mail.gmail.com>
 <Zv8fIh4jaY7QbeDZ@google.com>
 <CAP-5=fVvzNMDPUpAvK0itjG0ZptrSg-_BN3t6UwB4XAvSsDt8w@mail.gmail.com>
 <Zv95OTflePPTMi7I@google.com>
 <20241004234544.76317dc8c7027bcd4b70fda3@kernel.org>
 <CAP-5=fUr9X4TKd8RA9SEJfsaAvvBJxh5UzKToJoOS_M=0mEpCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUr9X4TKd8RA9SEJfsaAvvBJxh5UzKToJoOS_M=0mEpCQ@mail.gmail.com>

On Fri, Oct 04, 2024 at 08:15:22AM -0700, Ian Rogers wrote:
> On Fri, Oct 4, 2024 at 7:45 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 3 Oct 2024 22:12:25 -0700
> > Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > > On Thu, Oct 03, 2024 at 05:58:13PM -0700, Ian Rogers wrote:
> > > > On Thu, Oct 3, 2024 at 3:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > I agree renaming libdw-specific parts.  But the register is for DWARF,
> > > > > not libdw even if it's currently used by libdw only.   So I don't want
> > > > > to rename it.
> > > >
> > > > So your objection is that we have files called:
> > > > tools/perf/arch/*/util/dwarf-regs.c
> > > > and PERF_HAVE_DRWARF_REGS is an indication that this file exists. This
> > > > file declares a single get_arch_regnum function. The building of the
> > > > file after this series is:
> > > > perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
> > >
> > > Well.. I think we can even make it
> > >
> > > perf-util-y += dwarf-regs.o
> > >
> > > since it doesn't have any dependency on libdw.  But it'd be inefficent
> > > to ship the dead code and data.  Anyway we may remove the condition to
> > > define the PERF_HAVE_DWARF_REGS like below.
> > >
> > > diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> > > index 67b4969a673836eb..f1eb1ee1ea25ca53 100644
> > > --- a/tools/perf/arch/x86/Makefile
> > > +++ b/tools/perf/arch/x86/Makefile
> > > @@ -1,7 +1,5 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > > -ifndef NO_DWARF
> > >  PERF_HAVE_DWARF_REGS := 1
> > > -endif
> > >  HAVE_KVM_STAT_SUPPORT := 1
> > >  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> > >  PERF_HAVE_JITDUMP := 1
> > >
> > > >
> > > > My objection is that PERF_HAVE_DWARF_REGS is controlling the #define
> > > > HAVE_LIBDW_SUPPORT, so dwarf (that can mean libunwind, libdw, etc.) is
> > > > guarding having libdw which is backward and part of what this series
> > > > has been trying to clean up.
> > >
> > > Why not?  If the arch doesn't define DWARF registers, it can refuse
> > > libdw support because it won't work well.
> >
> > It actually does not DWARF registers, but just "dwarf-regs.c" file
> > since arch should define DWARF registers if the compiler generates
> > the DWARF.
> > Here the flag means only "we implemented dwarf-regs.c file for this
> > arch." So if it is called as "libdw-helper.c" then we can rename the
> > flag as PERF_HAVE_ARCH_LIBDW_HELPER simply.
> >
> > > > If we rename tools/perf/arch/*/util/dwarf-regs.c to
> > > > tools/perf/arch/*/util/libdw-helpers.c the PERF_HAVE_DWARF_REGS can be
> > > > renamed to PERF_HAVE_LIBDW_HELPERS to align. Then
> > > > PERF_HAVE_LIBDW_HELPERS guarding the #define PERF_HAVE_LIBDW makes
> > > > sense to me and I think we achieve the filename alignment you are
> > > > looking for.
> > >
> > > I don't think it's a good idea.  The logic is not specific to libdw.
> >
> > Yes, the logic (DWARF register mapping to the ISA register name) is
> > not libdw. But I think we can also implement it in "libdw-helper.c".
> > (In fact, this implementation does not depend only on Dwarf, but
> >  rather on the convenience of ftrace.)
> >
> > > >
> > > > Yes get_arch_regnum could make sense out of libdw and needn't just be
> > > > a helper for it, but let's worry about that when there's a need.
> > > > What's confusing at the moment is does libdw provide dwarf support,
> > > > which I'd say is expected, or does dwarf provide libdw support?
> > >
> > > As I said, it's about refusing libdw.
> >
> > I think Ian pointed this part, even if libdw is available, dwarf-regs.c
> > controls its usage, but libunwind is not.
> >
> > >
> > >   ifndef NO_LIBDW
> > >     ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
> > >       $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
> >
> > I think *this message* is the root cause of this discussion. It should be
> > changed to
> >
> > "DWARF register mappings have not been defined for architecture $(SRCARCH), libdw support disabled."
> >
> > or (if changed to libdw-helper)
> >
> > "libdw-helper.c is not implemented for architecture $(SRCARCH), libdw support disabled."
> 
> So looking at the code I think the whole thing looks wrong. The
> get_arch_regnum function is used by get_dwarf_regnum which is used in
> 2 places in annotate.c:
> ```
> static int extract_reg_offset(struct arch *arch, const char *str,
>                              struct annotated_op_loc *op_loc)
> ...
> int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>                               struct annotated_insn_loc *loc)
> ```
> So these functions are passing in an architecture. In get_dwarf_regnum:
> ```
> /* Return DWARF register number from architecture register name */
> int get_dwarf_regnum(const char *name, unsigned int machine)
> {
>        char *regname = strdup(name);
>        int reg = -1;
>        char *p;
> 
>        if (regname == NULL)
>                return -EINVAL;
> 
>        /* For convenience, remove trailing characters */
>        p = strpbrk(regname, " ,)");
>        if (p)
>                *p = '\0';
> 
>        switch (machine) {
>        case EM_NONE:   /* Generic arch - use host arch */
>                reg = get_arch_regnum(regname);
>                break;
>        default:
>                pr_err("ELF MACHINE %x is not supported.\n", machine);
>        }
>        free(regname);
>        return reg;
> }
> ```
> But why, if the machine is EM_X86_64 and I'm on an x86-64, can't I
> call get_arch_regnum? The code should be something like:
> ```
> if (machine == EM_NONE) {
> #ifdef __x86_64__
>   machine = EM_X86_64;
> #elf...
> ```
> Once we have an architecture specific machine then instead of
> get_arch_regnum it should call get_x86_64_regnum or
> get_aarch64_regnum.
> ```
> switch(machine) }
> case EM_X86_64:
>          reg = get_x86_64_regnum(regname);
>          break;
> ...
> ```
> Is this better? Yes, it means that the annotate logic can work if,
> say, annotating/disassembling an ARM binary on an x86-64.
> 
> So we need to pull all the tools/perf/arch/<arch>/util/dwarf-regs.c
> files into tools/perf/util/dwarf-regs-<arch>.c files. We need to
> rename the get_arch_regnum to reflect the <arch> in the file name. The
> Makefile logic can include all of this unconditionally and
> PERF_HAVE_DWARF_REGS can just be removed. In the process the ability
> to annotate binaries from one architecture on another is improved. It
> needn't be the case that we have dwarf regs for the architecture perf
> is being run on as we may be annotating an x86-64 binary where there
> is support.
> 
> What's strange is that get_dwarf_regstr in the common code already
> does things pretty much this way. This whole Makefile, arch, weak
> function, PERF_HAVE... logic just looks like a mistake that is making
> the tool worse than it needs to be. I think this is frequently the
> case with code in arch/, a lot of the functionality there can be moved
> into pmu.c and doing things conditional on the pmu, which is
> inherently architecture dependent. This can fix unusual cases of say
> running the perf tool on user land qemu, where we may have an ARM perf
> binary but see the PMUs of an x86.
> 
> I can work to put this into a v2 so please scream if my reasoning
> doesn't make sense.

Sounds good, it'd be easier if we merge patch 1-10 first and you would
work on the register thing separately.

Thanks,
Namhyung


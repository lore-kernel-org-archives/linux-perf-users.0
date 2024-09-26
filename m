Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A31D5AD0;
	Thu, 26 Sep 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727378894; cv=none; b=IAOUxZjFfJgK3uIO6kH9PEWGDAOslRlb/kJ4ToXHfejULsgcH6B5qLUk7Uu91hndJDl8FYLUgpvHZbyRF/k7ScB5h0V91q6LDym9WZ+gNKOds2LSzJ/NwYWRm5lcnR45oXeJ8rLEJkrh1FTLymH2v/z51RDCBf41dhUxBuIh/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727378894; c=relaxed/simple;
	bh=N8BavcGn2zxjNEV0Y6P+p7CjpbR4j1G560dlPX38ImI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE9TRz/BEpjomUfxB0/lTFelTW3TotCNyxKGfcn4BRdNZKZ7RBpPqGcLowUIFuayfs8qfOLqosLS1T+hBMsJQK5ONOV5ws8K5mbdCQu1zpu1Wpv2c+rXi1JF03sGdmOvqFwTsW/4ty3ZG2B7krnJXcdyGOvwsEDPM5qoT8yrRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtCE+Z49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtCE+Z49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD24C4CEC6;
	Thu, 26 Sep 2024 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727378893;
	bh=N8BavcGn2zxjNEV0Y6P+p7CjpbR4j1G560dlPX38ImI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtCE+Z49xEw784+6deCejBazcKlZ8BbrAx2laZFqNgkuHzES3O+vnR16pSJTEh/y4
	 ezBo3LEBvjD40NcGljd3jq4ANFb3f4rh8LjGJ5hISWbP4Pv/t663PvaIe1bTp49uPQ
	 aaztbYvNlshzp2UTYKBOEIE0GCGCLZjO2SqSfv9okn5sOu7snxM1BSXu1Uwm9EPkFR
	 54NQ7suQlCrySlTtO9hVPQqclaCRWj9MPZ0e619VFCQiEjFVzaM4tkLjxe1N3TKn7l
	 S5rSa4zpFenLJs42f4mD/Chs5KZnJsN7bSMCEem/klHT6l7cfm9joa9epMC9zFF6Us
	 TqUGDaCG3trsQ==
Date: Thu, 26 Sep 2024 12:28:09 -0700
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
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
Subject: Re: [PATCH v1 01/11] perf build: Rename NO_DWARF to NO_LIBDW
Message-ID: <ZvW1yYrmHEDUIOkr@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-2-irogers@google.com>
 <ZvSqNqNKKysw_309@google.com>
 <CAP-5=fUf40_4LbsYOavy45L=153bAVuwK_km8UKNQ3imSQ-_2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUf40_4LbsYOavy45L=153bAVuwK_km8UKNQ3imSQ-_2w@mail.gmail.com>

On Thu, Sep 26, 2024 at 08:02:45AM -0700, Ian Rogers wrote:
> On Wed, Sep 25, 2024 at 5:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Sep 24, 2024 at 09:04:08AM -0700, Ian Rogers wrote:
> > > NO_DWARF could mean more than NO_LIBDW support, in particular no
> > > libunwind support. Rename to be more intention revealing.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/Makefile.config         | 16 ++++++++--------
> > >  tools/perf/Makefile.perf           |  2 +-
> > >  tools/perf/arch/arm/Makefile       |  2 +-
> > >  tools/perf/arch/arm64/Makefile     |  2 +-
> > >  tools/perf/arch/csky/Makefile      |  2 +-
> > >  tools/perf/arch/loongarch/Makefile |  2 +-
> > >  tools/perf/arch/mips/Makefile      |  2 +-
> > >  tools/perf/arch/powerpc/Makefile   |  2 +-
> > >  tools/perf/arch/riscv/Makefile     |  2 +-
> > >  tools/perf/arch/s390/Makefile      |  2 +-
> > >  tools/perf/arch/sh/Makefile        |  2 +-
> > >  tools/perf/arch/sparc/Makefile     |  2 +-
> > >  tools/perf/arch/x86/Makefile       |  2 +-
> > >  tools/perf/arch/xtensa/Makefile    |  2 +-
> > >  tools/perf/builtin-probe.c         |  2 +-
> > >  15 files changed, 22 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 5e26d3a91b36..55a39211496d 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -429,7 +429,7 @@ ifeq ($(feature-file-handle), 1)
> > >  endif
> > >
> > >  ifdef NO_LIBELF
> > > -  NO_DWARF := 1
> > > +  NO_LIBDW := 1
> > >    NO_LIBUNWIND := 1
> > >    NO_LIBDW_DWARF_UNWIND := 1
> > >    NO_LIBBPF := 1
> > > @@ -471,9 +471,9 @@ else
> > >        endif
> > >      endif
> > >      ifneq ($(feature-dwarf), 1)
> > > -      ifndef NO_DWARF
> > > +      ifndef NO_LIBDW
> > >          $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
> > > -        NO_DWARF := 1
> > > +        NO_LIBDW := 1
> > >        endif
> > >      else
> > >        ifneq ($(feature-dwarf_getlocations), 1)
> > > @@ -496,7 +496,7 @@ ifeq ($(feature-libaio), 1)
> > >    endif
> > >  endif
> > >
> > > -ifdef NO_DWARF
> > > +ifdef NO_LIBDW
> > >    NO_LIBDW_DWARF_UNWIND := 1
> > >  endif
> > >
> > > @@ -574,17 +574,17 @@ ifndef NO_LIBELF
> > >      endif
> > >    endif
> > >
> > > -  ifndef NO_DWARF
> > > +  ifndef NO_LIBDW
> > >      ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
> > >        $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
> > > -      NO_DWARF := 1
> > > +      NO_LIBDW := 1
> > >      else
> > >        CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
> > >        LDFLAGS += $(LIBDW_LDFLAGS)
> > >        EXTLIBS += ${DWARFLIBS}
> > >        $(call detected,CONFIG_DWARF)
> > >      endif # PERF_HAVE_DWARF_REGS
> > > -  endif # NO_DWARF
> > > +  endif # NO_LIBDW
> > >
> > >    ifndef NO_LIBBPF
> > >      ifeq ($(feature-bpf), 1)
> > > @@ -633,7 +633,7 @@ ifdef PERF_HAVE_JITDUMP
> > >  endif
> > >
> > >  ifeq ($(SRCARCH),powerpc)
> > > -  ifndef NO_DWARF
> > > +  ifndef NO_LIBDW
> > >      CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
> > >    endif
> > >  endif
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 9dd2e8d3f3c9..a144bfaf8aeb 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -40,7 +40,7 @@ include ../scripts/utilities.mak
> > >  #
> > >  # Define EXTRA_PERFLIBS to pass extra libraries to PERFLIBS.
> > >  #
> > > -# Define NO_DWARF if you do not want debug-info analysis feature at all.
> > > +# Define NO_LIBDW if you do not want debug-info analysis feature at all.
> >
> > Can we keep NO_DWARF for compatibility and set NO_LIBDW=1 internally?
> > I think it's fine to change it here to advertise NO_LIBDW over NO_DWARF
> > but still want to support NO_DWARF as well.
> 
> This would be actively confusing. NO_DWARF should really imply
> NO_LIBUNWIND, it is like removing the ability for "perf record
> --call-graph dwarf" to work - dwarf meaning libdw or libunwind in the
> tool. Having NO_DWARF control NO_LIBDW, I'm not sure what I'm being
> asked to do. The point of this clean up is to make the names mean what
> they should mean and not something potentially confusingly broader,
> but you're asking for the confusingly broader case to mean just libdw.
> I don't follow and I don't see how it serves the purpose of the
> cleanup.

I have no idea how many people use NO_DWARF actually.  We can probably
ignore such users and convert it to NO_LIBDW.

What I actually thought was

  ifeq ($(NO_DWARF),1)
    NO_LIBDW := 1
    NO_LIBUNWIND := 1
  endif

but it'd break the compatibility too. :(

Thanks,
Namhyung


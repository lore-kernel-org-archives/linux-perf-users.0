Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EE3214;
	Sun, 29 Sep 2024 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727575320; cv=none; b=Q0XR1bMMV4B6nR9bUG6sPxQxJImQJgCtayr0u/2gtGdHVZ0FuDy7mitnoVOXRgKAaf1jio1qmsVIhgISSR2jvFgQCHLi2BnzLQ9UrFQ3yQNQ05a6cn8B+0l14J3eL7HTVWMN87G/WjfPgar5uUoRHu7XiLQG2AWWLn5+fl+Ki8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727575320; c=relaxed/simple;
	bh=4Rfh+L2v/OaFy27WHwsOAgj+2Q/K+plGJp56tMw9PhY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oxDA+o9eahYtCelv9KI3HVLdseMP06dEaUN+XnCNpTb1oXjf6Lsqaa2OPOCRsjEnpBnpyIZtFfpcxWT//J7K6BUeIKuHSRc+n0Cibd+XPczaf2qnO+R7DUDQ2gEoJoeCTLtvatNcqtGX9XU4n6yvtKc6mWoR62Tk7Ye7CmoqwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJqnHjxw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJqnHjxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9BFC4CEC3;
	Sun, 29 Sep 2024 02:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727575320;
	bh=4Rfh+L2v/OaFy27WHwsOAgj+2Q/K+plGJp56tMw9PhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJqnHjxwVbDPJlZ0Ekp2qKeIdAzLsxULTZgJN4VMyr9ynpShbzdFMjJptM4u4udX3
	 LxeA7nKhudXPxOHAauNvHSAzu54WB468YcV/4zWgIcVlejSlkwENPzmanapCHF7rkL
	 dm0Gg00JFYEiijZO0iOk54InjCxCveuVL/4Q9ZWgOsIf/smDEkgWKyf4IbVHMlW491
	 rXLdPsQmlmIXlgNHRTm9h0a7RtXNR3s/gDukXiQSKwvBfsXGkCPFrhvCoGVwnhrPnA
	 JI7qAWC9dEzpw/YyVfJbCp0qRBIcmgQUvCEYoZlLt3lIbAHm8XkkXSuS4yRfy0DX++
	 dXwSfYFurndbw==
Date: Sun, 29 Sep 2024 11:01:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James
 Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan
 <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, Guilherme Amadio
 <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>,
 "Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Kajol
 Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Shenlin Liang
 <liangshenlin@eswincomputing.com>, Atish Patra <atishp@rivosinc.com>,
 Oliver Upton <oliver.upton@linux.dev>, Chen Pei <cp0613@linux.alibaba.com>,
 Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yang Jihong
 <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 01/11] perf build: Rename NO_DWARF to NO_LIBDW
Message-Id: <20240929110147.61aa651d748bcf524ad81507@kernel.org>
In-Reply-To: <ZvW1yYrmHEDUIOkr@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
	<20240924160418.1391100-2-irogers@google.com>
	<ZvSqNqNKKysw_309@google.com>
	<CAP-5=fUf40_4LbsYOavy45L=153bAVuwK_km8UKNQ3imSQ-_2w@mail.gmail.com>
	<ZvW1yYrmHEDUIOkr@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 12:28:09 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> On Thu, Sep 26, 2024 at 08:02:45AM -0700, Ian Rogers wrote:
> > On Wed, Sep 25, 2024 at 5:26 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, Sep 24, 2024 at 09:04:08AM -0700, Ian Rogers wrote:
> > > > NO_DWARF could mean more than NO_LIBDW support, in particular no
> > > > libunwind support. Rename to be more intention revealing.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/Makefile.config         | 16 ++++++++--------
> > > >  tools/perf/Makefile.perf           |  2 +-
> > > >  tools/perf/arch/arm/Makefile       |  2 +-
> > > >  tools/perf/arch/arm64/Makefile     |  2 +-
> > > >  tools/perf/arch/csky/Makefile      |  2 +-
> > > >  tools/perf/arch/loongarch/Makefile |  2 +-
> > > >  tools/perf/arch/mips/Makefile      |  2 +-
> > > >  tools/perf/arch/powerpc/Makefile   |  2 +-
> > > >  tools/perf/arch/riscv/Makefile     |  2 +-
> > > >  tools/perf/arch/s390/Makefile      |  2 +-
> > > >  tools/perf/arch/sh/Makefile        |  2 +-
> > > >  tools/perf/arch/sparc/Makefile     |  2 +-
> > > >  tools/perf/arch/x86/Makefile       |  2 +-
> > > >  tools/perf/arch/xtensa/Makefile    |  2 +-
> > > >  tools/perf/builtin-probe.c         |  2 +-
> > > >  15 files changed, 22 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > > index 5e26d3a91b36..55a39211496d 100644
> > > > --- a/tools/perf/Makefile.config
> > > > +++ b/tools/perf/Makefile.config
> > > > @@ -429,7 +429,7 @@ ifeq ($(feature-file-handle), 1)
> > > >  endif
> > > >
> > > >  ifdef NO_LIBELF
> > > > -  NO_DWARF := 1
> > > > +  NO_LIBDW := 1
> > > >    NO_LIBUNWIND := 1
> > > >    NO_LIBDW_DWARF_UNWIND := 1
> > > >    NO_LIBBPF := 1
> > > > @@ -471,9 +471,9 @@ else
> > > >        endif
> > > >      endif
> > > >      ifneq ($(feature-dwarf), 1)
> > > > -      ifndef NO_DWARF
> > > > +      ifndef NO_LIBDW
> > > >          $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
> > > > -        NO_DWARF := 1
> > > > +        NO_LIBDW := 1
> > > >        endif
> > > >      else
> > > >        ifneq ($(feature-dwarf_getlocations), 1)
> > > > @@ -496,7 +496,7 @@ ifeq ($(feature-libaio), 1)
> > > >    endif
> > > >  endif
> > > >
> > > > -ifdef NO_DWARF
> > > > +ifdef NO_LIBDW
> > > >    NO_LIBDW_DWARF_UNWIND := 1
> > > >  endif
> > > >
> > > > @@ -574,17 +574,17 @@ ifndef NO_LIBELF
> > > >      endif
> > > >    endif
> > > >
> > > > -  ifndef NO_DWARF
> > > > +  ifndef NO_LIBDW
> > > >      ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
> > > >        $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
> > > > -      NO_DWARF := 1
> > > > +      NO_LIBDW := 1
> > > >      else
> > > >        CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
> > > >        LDFLAGS += $(LIBDW_LDFLAGS)
> > > >        EXTLIBS += ${DWARFLIBS}
> > > >        $(call detected,CONFIG_DWARF)
> > > >      endif # PERF_HAVE_DWARF_REGS
> > > > -  endif # NO_DWARF
> > > > +  endif # NO_LIBDW
> > > >
> > > >    ifndef NO_LIBBPF
> > > >      ifeq ($(feature-bpf), 1)
> > > > @@ -633,7 +633,7 @@ ifdef PERF_HAVE_JITDUMP
> > > >  endif
> > > >
> > > >  ifeq ($(SRCARCH),powerpc)
> > > > -  ifndef NO_DWARF
> > > > +  ifndef NO_LIBDW
> > > >      CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
> > > >    endif
> > > >  endif
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index 9dd2e8d3f3c9..a144bfaf8aeb 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -40,7 +40,7 @@ include ../scripts/utilities.mak
> > > >  #
> > > >  # Define EXTRA_PERFLIBS to pass extra libraries to PERFLIBS.
> > > >  #
> > > > -# Define NO_DWARF if you do not want debug-info analysis feature at all.
> > > > +# Define NO_LIBDW if you do not want debug-info analysis feature at all.
> > >
> > > Can we keep NO_DWARF for compatibility and set NO_LIBDW=1 internally?
> > > I think it's fine to change it here to advertise NO_LIBDW over NO_DWARF
> > > but still want to support NO_DWARF as well.
> > 
> > This would be actively confusing. NO_DWARF should really imply
> > NO_LIBUNWIND, it is like removing the ability for "perf record
> > --call-graph dwarf" to work - dwarf meaning libdw or libunwind in the
> > tool. Having NO_DWARF control NO_LIBDW, I'm not sure what I'm being
> > asked to do. The point of this clean up is to make the names mean what
> > they should mean and not something potentially confusingly broader,
> > but you're asking for the confusingly broader case to mean just libdw.
> > I don't follow and I don't see how it serves the purpose of the
> > cleanup.
> 
> I have no idea how many people use NO_DWARF actually.  We can probably
> ignore such users and convert it to NO_LIBDW.
> 
> What I actually thought was
> 
>   ifeq ($(NO_DWARF),1)
>     NO_LIBDW := 1
>     NO_LIBUNWIND := 1
>   endif

Maybe we can add another patch to do this for new compile option?

Thanks,

> 
> but it'd break the compatibility too. :(



> 
> Thanks,
> Namhyung
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

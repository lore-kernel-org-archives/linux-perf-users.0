Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8CB186E3D;
	Thu,  3 Oct 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995685; cv=none; b=NNOwRViBZw3Ztx63incWaMVGoC7QzLpnBYIBqx8Yk68Sfkh9ofOTxQ93XZ9GiAN0ZX2EoE3QbPyZCWvOghlBpLFGJ9G7ZflfjPrFoomwLN9ZsAeNClRKqErJhEZqaVm0BKHEySBDuUQEJTH5EXVIvlthd2++xAUsc2qhGYVXWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995685; c=relaxed/simple;
	bh=vuyw00EQ4RDjbOXQWfksAazYJs2CDjY0EayvANfqii0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcaOQ4UptfRSr+THvBng99NnmzZYmPc9VhFvXoiKQ8TA73Jv1I/RJoStqT3zqbblgErbLq/EMibmdePzV16GaL/N55sz+XWcoSgRdYcN8Uax88IMp4lPq+8RdNpapR4rAB3j0SNq2vQFjESRe2K751tTYJT8e470j0GFJgsGdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIL0eHN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIL0eHN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37240C4CEC5;
	Thu,  3 Oct 2024 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727995685;
	bh=vuyw00EQ4RDjbOXQWfksAazYJs2CDjY0EayvANfqii0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIL0eHN+nook2855zU8iuGHUiIEyTvq5ZAt6vk0lUWVAOT9ha+Ty2h/VCJJLAHfUG
	 qkA0iSq3bM+x/fXCazmTNg4+wOIg8m6Dxuh977s5YiECRoc9hP1Un3xUv9k+0X4YDJ
	 nqUoIAzYaRYHyiuPy0fVzKULf4K5w61S5F55bpLa+B242+tGe/3gF1DqvfXW2jRFXx
	 /6FIcGpG2uGnvUqCmYZ6UvoLvVqyHDBhbCL5nEJExirU6fCo6tk1/QNAwXsEqbmGoE
	 j0uffg0zZPKwVqTSTrtT5biA1dsW1xPM/XHw+7qg8Y/Eo5bYo1EnLlwv6IEbRoYj8C
	 vZvWEoVmx9dqA==
Date: Thu, 3 Oct 2024 15:48:02 -0700
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
Message-ID: <Zv8fIh4jaY7QbeDZ@google.com>
References: <ZvbocHwtPkwJwDOA@google.com>
 <CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
 <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org>
 <CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
 <ZvyBQ6xgGE4gZdoo@google.com>
 <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
 <20241002082859.8821e441024fe873a4301afc@kernel.org>
 <CAP-5=fWcOpF4+mgnkHOG=ntGMafJ7JSks_4j1JWVvgccApn+Ng@mail.gmail.com>
 <20241002225614.774bdd0742a826557f142d0e@kernel.org>
 <CAP-5=fWoiD=7XbB3FbE++1RSo3BZKeOOyNg81t4GQ7Ve6ejpSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWoiD=7XbB3FbE++1RSo3BZKeOOyNg81t4GQ7Ve6ejpSg@mail.gmail.com>

On Wed, Oct 02, 2024 at 07:27:16AM -0700, Ian Rogers wrote:
> On Wed, Oct 2, 2024 at 6:56 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 1 Oct 2024 18:31:43 -0700
> > Ian Rogers <irogers@google.com> wrote:
> >
> > > On Tue, Oct 1, 2024 at 4:29 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Tue, 1 Oct 2024 16:17:34 -0700
> > > > Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > > On Tue, Oct 1, 2024 at 4:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Sep 30, 2024 at 09:02:36PM -0700, Ian Rogers wrote:
> > > > > > > On Sat, Sep 28, 2024 at 7:35 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 27 Sep 2024 11:15:21 -0700
> > > > > > > > Ian Rogers <irogers@google.com> wrote:
> > > > > > > >
> > > > > > > > > On Fri, Sep 27, 2024 at 10:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> > > > > > > > > > > On Thu, Sep 26, 2024 at 12:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > > > > > > > > > > > > On Wed, Sep 25, 2024 at 8:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > > > > > > > > > > > > The name dwarf can imply libunwind support, whereas
> > > > > > > > > > > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > > > > > > > > > > > > > > make it clearer there is a libdw connection.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > While it only covers libdw, I think the idea of this macro is whether
> > > > > > > > > > > > > > the arch has register mappings defined in DWARF standard.  So I think
> > > > > > > > > > > > > > it's better to keep the name for this case.
> > > > > > > > > > > > >
> > > > > > > > > > > > > How can the dwarf standard exist for an arch but not define registers?
> > > > > > > > > > > >
> > > > > > > > > > > > I meant it's about the arch code in the perf tools to have the mapping,
> > > > > > > > > > > > not the DWARF standard itself.
> > > > > > > > > > >
> > > > > > > > > > > But we guard those definitions behind having libdw:
> > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/Makefile?h=perf-tools-next#n3
> > > > > > > > > > > So we only have the regs if libdw is present, not if dwarf is in use
> > > > > > > > > > > for libunwind/libdw. Hence wanting to be specific that they are just a
> > > > > > > > > > > libdw and not a dwarf thing. Trying to use the regs in libunwind code
> > > > > > > > > > > would be broken. That could change but I wanted to make the code clear
> > > > > > > > > > > for the way things are at the moment.
> > > > > > > > > >
> > > > > > > > > > I understand your point but calling it LIBDW_REGS looks unnatural to me.
> > > > > > > > >
> > > > > > > > > I don't follow. Wouldn't it be unnatural to see PERF_HAVE_DWARF_REGS
> > > > > > > > > in libunwind code but you are to some how know that the code only had
> > > > > > > > > meaning if libdw was present? I don't like the implication that DWARF
> > > > > > > > > means LIBDW as throughout the code it doesn't. I think the name
> > > > > > > > > PERF_HAVE_LIBDW_REGS better captures how the code is, makes the code
> > > > > > > > > more intention revealing and so readable, etc.
> > > > > > > >
> > > > > > > > I agree with Namhyung this point. dwarf-regs is defined only by the
> > > > > > > > DWARF standard, not libdw only. The standard encode registers by a digit
> > > > > > > > number and the dwarf-regs decode the number to actual register name.
> > > > > > >
> > > > > > > The code is not making a statement about the DWARF standard, take arch/csky:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/csky/Makefile?h=perf-tools-next
> > > > > > > ```
> > > > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > > > > ifndef NO_DWARF
> > > > > > > PERF_HAVE_DWARF_REGS := 1
> > > > > > > endif
> > > > > > > ```
> > > > > > > in the patch series NO_DWARF becomes NO_LIBDW, so it is now:
> > > > > > > ```
> > > > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > > > > ifndef NO_LIBDW
> > > > > > > PERF_HAVE_DWARF_REGS := 1
> > > > > > > endif
> > > > > > > ```
> > > > > > > So the Makefile says that PERF_HAVE_DWARF_REGS is dependent on having
> > > > > > > NO_LIBDW, that is having libdw implies PERF_HAVE_DWARF_REGS is defined
> > > > > > > for csky.
> > > > > >
> > > > > > I think this is totally fine and we can change the condition later if
> > > > > > needed.
> > > > > >
> > > > > > After all, I don't think it's a big deal.  Let's just call DWARF
> > > > > > registers DWARF_REGS. :)
> > > > >
> > > > > The define is called PERF_HAVE_DWARF_REGS, notice the HAVE, but we're
> > > > > not setting it while supporting call-graph dwarf with libunwind. It is
> > > > > actively confusing.
> > > >
> > > > Does libunwind requires the dwarf regs? I think the dwarf regs information
> > > > is only needed for analyzing dwarf register assignment, not stack unwinding.
> > >
> > > So you are saying the #define is guarding a libdw feature?
> > > perf record/report --call-graph=dwarf is supported with either libdw
> > > or libunwind. The dwarf support in the tool may come from more sources
> > > hence wanting in this patch set to be clear what variable is guarding
> > > what. PERF_HAVE_DWARF_REGS is set to 1 for a specific set of
> > > architectures and only when libdw is present. The variable is saying
> > > that libdw supports the notion of registers needed for the #define
> > > HAVE_DWARF_SUPPORT that patch 9 in the series renamed to
> > > HAVE_LIBDW_SUPPORT. So I want the makefile variable
> > > PERF_HAVE_LIBDW_REGS to guard the #define HAVE_LIBDW_SUPPORT, rather
> > > than what is being argued by yourself and Namhyung that the #define
> > > HAVE_LIBDW_SUPPORT be guarded by a variable called
> > > PERF_HAVE_DWARF_REGS and that is only set when NO_LIBDW isn't set.
> >
> > It will be only used with the libdw, but I don't care.
> > "HAVE_DWARF_REG" (internal config, just indicates the arch implemented
> > feature) simply means there is `arch/XXX/util/dwarf-regs.c`.
> > Also the APIs provided by the dwarf-regs.c are still based on DWARF
> > standard, which defines registers by number like DW_OP_reg[0-31].
> > So the mapping of these suffix number and actual register must be
> > defined for each architecture.
> >
> > That is why I had introduced dwarf-regs.c and call it "dwarf"-regs.
> > Even if the implementation depends on libdw, this dwarf-regs.c is
> > still based on DWARF standard.
> 
> You seem to be missing the point of the series which is to clean up
> inconsistencies where dwarf is used to mean libdw. Here we have libdw
> guarding a #define with DWARF in the name, it should have libdw in the
> name as the patch cleans up. This is a coding thing and not a dwarf
> specificatin thing.
> 
> > > We've made a digression into the name dwarf for a reason I can't
> > > fathom, at best it is inconsistent. Having dwarf registers is like
> > > having a bright sun or numeric numbers, it is a truism (playing devils
> > > advocate maybe if there were an ELF file format for postscript we
> > > could have a dwarf specification without registers). Anyway, I'm
> > > trying to connect the dots that libdw support controls the libdw type
> > > variables and defines hence not wanting 10 out of 11 patches applied.
> >
> > Oh, wait, I think we can apply other patches. I just don't like this
> > patch. I think the other patches are good. But this is
> 
> Then we are intentionally aiming to be inconsistent, with libdw
> meaning dwarf with a #define that just states a truism. Arguably the
> code is better with none of the series applied.

I agree renaming libdw-specific parts.  But the register is for DWARF,
not libdw even if it's currently used by libdw only.   So I don't want
to rename it.

Thanks,
Namhyung


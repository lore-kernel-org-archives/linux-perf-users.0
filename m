Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE08158218;
	Tue,  1 Oct 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825350; cv=none; b=HcaLVU6C9V+5mS3kOgibxH4dcMQJ7ZiebZQTxGI8OqNhs1jnwDKEjDqLXyZbmOMBo2D5UN/7uPBwk51FArGoQzcql58+UmzQDeSVX0uJ/RP+sOqX5xMpgfUguY8qEvJqdjBuU3GZRgcJOTmBeWjBMncYmTC/nGJrqKuo5YSfnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825350; c=relaxed/simple;
	bh=4Fy8eNRtSt+QTDrwoajgzv4Ov+8bOvNngzpkr0e+lO8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IEnT7J6j/32fEqr+dW3KFeHcev0Z22+28zQvFfKWowrrhkzmkeBTMpGvKwiffxhWIXyz/I/NW+E8gkCGddVzYUF+VpakysOpP/ONtEGxjOjgPOqR6Zi/ekDOlFg42WCeLhaCKwy1jkkehv7lEvZVBru7M8XTDsGgzEUVCMvp3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMXdN+yW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMXdN+yW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88071C4CEC6;
	Tue,  1 Oct 2024 23:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727825350;
	bh=4Fy8eNRtSt+QTDrwoajgzv4Ov+8bOvNngzpkr0e+lO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KMXdN+yWUEv4EMnFnrko1O3AaFNHCKbYhbBRh2PfYc6xPpBWd4lZ2iakRudJC1UfB
	 LrkKRfyBrxFNKYTtuimTanABdf5E4CdGQ1vK1FegPdZ4YwWxXh6d0g7I3F8IX51dYD
	 ZSaiVyFePP3NUtXwW+bgPkqaApdsAD4nAD3rGn4wRHX6SlNEmVM9n/aAuY4bD40XtQ
	 j46SPcAmF5jVplH/85YwNeqkJ5GnOnGB67u131+ts6hv1pN6jOgtAy6JJLudFw/Oza
	 91NXezSNfjyI+WXx8LN5Qx/RmKrRaZRKWyn9/ORoxgxEDnJQf82hDWJ8KpU6RUOUNG
	 frizls8H4JPYA==
Date: Wed, 2 Oct 2024 08:28:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James
 Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan
 <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, Guilherme Amadio
 <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>,
 "Steinar H. Gunderson" <sesse@google.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Kajol Jain
 <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Shenlin Liang
 <liangshenlin@eswincomputing.com>, Atish Patra <atishp@rivosinc.com>,
 Oliver Upton <oliver.upton@linux.dev>, Chen Pei <cp0613@linux.alibaba.com>,
 Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yang Jihong
 <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to
 PERF_HAVE_LIBDW_REGS
Message-Id: <20241002082859.8821e441024fe873a4301afc@kernel.org>
In-Reply-To: <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
References: <20240924160418.1391100-1-irogers@google.com>
	<20240924160418.1391100-12-irogers@google.com>
	<ZvTUo_nbr_gKaJrs@google.com>
	<CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
	<ZvW4iZpTinJKWIFD@google.com>
	<CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
	<ZvbocHwtPkwJwDOA@google.com>
	<CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
	<20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org>
	<CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
	<ZvyBQ6xgGE4gZdoo@google.com>
	<CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 1 Oct 2024 16:17:34 -0700
Ian Rogers <irogers@google.com> wrote:

> On Tue, Oct 1, 2024 at 4:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Sep 30, 2024 at 09:02:36PM -0700, Ian Rogers wrote:
> > > On Sat, Sep 28, 2024 at 7:35 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Fri, 27 Sep 2024 11:15:21 -0700
> > > > Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > > On Fri, Sep 27, 2024 at 10:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> > > > > > > On Thu, Sep 26, 2024 at 12:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > > > > > > > > On Wed, Sep 25, 2024 at 8:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > > > > > > > > The name dwarf can imply libunwind support, whereas
> > > > > > > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > > > > > > > > > > make it clearer there is a libdw connection.
> > > > > > > > > >
> > > > > > > > > > While it only covers libdw, I think the idea of this macro is whether
> > > > > > > > > > the arch has register mappings defined in DWARF standard.  So I think
> > > > > > > > > > it's better to keep the name for this case.
> > > > > > > > >
> > > > > > > > > How can the dwarf standard exist for an arch but not define registers?
> > > > > > > >
> > > > > > > > I meant it's about the arch code in the perf tools to have the mapping,
> > > > > > > > not the DWARF standard itself.
> > > > > > >
> > > > > > > But we guard those definitions behind having libdw:
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/Makefile?h=perf-tools-next#n3
> > > > > > > So we only have the regs if libdw is present, not if dwarf is in use
> > > > > > > for libunwind/libdw. Hence wanting to be specific that they are just a
> > > > > > > libdw and not a dwarf thing. Trying to use the regs in libunwind code
> > > > > > > would be broken. That could change but I wanted to make the code clear
> > > > > > > for the way things are at the moment.
> > > > > >
> > > > > > I understand your point but calling it LIBDW_REGS looks unnatural to me.
> > > > >
> > > > > I don't follow. Wouldn't it be unnatural to see PERF_HAVE_DWARF_REGS
> > > > > in libunwind code but you are to some how know that the code only had
> > > > > meaning if libdw was present? I don't like the implication that DWARF
> > > > > means LIBDW as throughout the code it doesn't. I think the name
> > > > > PERF_HAVE_LIBDW_REGS better captures how the code is, makes the code
> > > > > more intention revealing and so readable, etc.
> > > >
> > > > I agree with Namhyung this point. dwarf-regs is defined only by the
> > > > DWARF standard, not libdw only. The standard encode registers by a digit
> > > > number and the dwarf-regs decode the number to actual register name.
> > >
> > > The code is not making a statement about the DWARF standard, take arch/csky:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/csky/Makefile?h=perf-tools-next
> > > ```
> > > # SPDX-License-Identifier: GPL-2.0-only
> > > ifndef NO_DWARF
> > > PERF_HAVE_DWARF_REGS := 1
> > > endif
> > > ```
> > > in the patch series NO_DWARF becomes NO_LIBDW, so it is now:
> > > ```
> > > # SPDX-License-Identifier: GPL-2.0-only
> > > ifndef NO_LIBDW
> > > PERF_HAVE_DWARF_REGS := 1
> > > endif
> > > ```
> > > So the Makefile says that PERF_HAVE_DWARF_REGS is dependent on having
> > > NO_LIBDW, that is having libdw implies PERF_HAVE_DWARF_REGS is defined
> > > for csky.
> >
> > I think this is totally fine and we can change the condition later if
> > needed.
> >
> > After all, I don't think it's a big deal.  Let's just call DWARF
> > registers DWARF_REGS. :)
> 
> The define is called PERF_HAVE_DWARF_REGS, notice the HAVE, but we're
> not setting it while supporting call-graph dwarf with libunwind. It is
> actively confusing.

Does libunwind requires the dwarf regs? I think the dwarf regs information
is only needed for analyzing dwarf register assignment, not stack unwinding.

Thank you,

> 
> Thanks,
> Ian
> 
> > Thanks,
> > Namhyung
> >
> > >
> > > Dwarf in the code base implies libdw, libunwind and potentially other
> > > dwarf capable things like llvm. If we don't have libdw then NO_LIBDW
> > > will be set and PERF_HAVE_DWARF_REGS won't be set. That is the more
> > > general dwarf thing will not be set because of missing libdw. This
> > > goes contrary to wanting this to be true whenever a dwarf thing is
> > > present - something that reflecting what the standard says would
> > > achieve.
> > >
> > > In the code base right now PERF_HAVE_DWARF_REGS isn't a dwarf
> > > dependent thing, it is a libdw dependent thing, this is why
> > > PERF_HAVE_LIBDW_REGS is a more intention revealing name as it makes
> > > the connection explicit.
> > >
> > > We could change the code so that in Makefile.config we set something like:
> > > ```
> > > ...
> > > ifndef NO_LIBDW
> > >   PERF_HAVE_DWARF := 1
> > > ...
> > > ```
> > > and in the arch/.../Makefiles change them to be:
> > > ```
> > > if PERF_HAVE_DWARF
> > > PERF_HAVE_DWARF_REGS := 1
> > > endif
> > > ```
> > > but this is going beyond the clean up this patch series was trying to
> > > achieve. I also don't know of an architecture where dwarf is present
> > > but registers are not, so having a definition for this case feels
> > > redundant.
> > >
> > > Thanks,
> > > Ian
> > >
> > > > Actually, there is a histrical reason I had called it is DWARF. I used to
> > > > use "libdwarf", and switched to "libdw" for required features. So I know
> > > > there are more than 1 implementation of DWARF library, and the libdwarf
> > > > also uses the same operation number because it depends on the same standard.
> > > >
> > > > https://github.com/davea42/libdwarf-code/blob/main/src/lib/libdwarf/dwarf.h#L809
> > > >
> > > > So I think we'd better keep it call as DWARF_REGS.
> > > >
> > > > Thank you,
> > > >
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

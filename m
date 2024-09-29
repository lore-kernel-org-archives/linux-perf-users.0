Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC396171D2;
	Sun, 29 Sep 2024 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727577334; cv=none; b=aO1FSExnDl5FkJbD53Xiz52/c0FJHSD4HbRgHOCxW8eclFkITZ2TwVhsLnBotjkV/vWZyl6n+qwc7JBOPWT1T6SVM+l0UObcl1EwuEizccif5N5z5h45R3rgkoYexi4X5lqevjL04BzEK8HofXuC2EcnrlAC5GQgqIfpC1syJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727577334; c=relaxed/simple;
	bh=pGmxhmTYANWCvurU2o11mStBdyF2pwiRfjMYpR/2hF8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nACePkxuGdbQPRvxIh1pcEb2yMs1Xgxu2bUWY1BYjvN1xUIUhUU41D7o7a8AS5xqRLnaQ2RtyUBiPMUa+6Vqu4UD2rJ90KVX1B+Nx8f0vyF/LAFqFaPw4HzaXbLHpB+GPg5vsMvLMBTYnOE/bSfUIyEtU7n7j9TgHiIb4bRt0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asPZhxpj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asPZhxpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692D8C4CEC3;
	Sun, 29 Sep 2024 02:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727577333;
	bh=pGmxhmTYANWCvurU2o11mStBdyF2pwiRfjMYpR/2hF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=asPZhxpjdDzxkfnv5zZHVcggaHVSDuTUjAif+8xkuB8F9VTlgOuab9CxlpDnLlXhq
	 DqcBdLeGyUxZ0Qvo5TVeHkzwbkJfc0TPFdCQjd4P9l8AjW6qHFrbD4dmQF3E2YsRwD
	 PBZ3Kgj8Ai01AbWczdKxP0I+51+Ke2E+W2VZUctgk2npLtALy2fbP2+oh8u6chwQQ2
	 wqq5WFBlQDXnrzth0yQNnN8dPqgBJR8ON9gIbehDefpWrBBdiAPwlybsRiXfxNDtS+
	 rQ4ajLg2Hbzcm5eKeZd0rw07qrdMljN1Krav3pf1kL+smbLEo4sjTjESd2qGpNYIxZ
	 Q4/a+J9G4eDgA==
Date: Sun, 29 Sep 2024 11:35:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, Will
 Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren
 <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nick
 Terrell <terrelln@fb.com>, Guilherme Amadio <amadio@gentoo.org>, Changbin
 Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Aditya Gupta
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
Message-Id: <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org>
In-Reply-To: <CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
References: <20240924160418.1391100-1-irogers@google.com>
	<20240924160418.1391100-12-irogers@google.com>
	<ZvTUo_nbr_gKaJrs@google.com>
	<CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
	<ZvW4iZpTinJKWIFD@google.com>
	<CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
	<ZvbocHwtPkwJwDOA@google.com>
	<CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 27 Sep 2024 11:15:21 -0700
Ian Rogers <irogers@google.com> wrote:

> On Fri, Sep 27, 2024 at 10:16 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> > > On Thu, Sep 26, 2024 at 12:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > > > > On Wed, Sep 25, 2024 at 8:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > > > > The name dwarf can imply libunwind support, whereas
> > > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > > > > > > make it clearer there is a libdw connection.
> > > > > >
> > > > > > While it only covers libdw, I think the idea of this macro is whether
> > > > > > the arch has register mappings defined in DWARF standard.  So I think
> > > > > > it's better to keep the name for this case.
> > > > >
> > > > > How can the dwarf standard exist for an arch but not define registers?
> > > >
> > > > I meant it's about the arch code in the perf tools to have the mapping,
> > > > not the DWARF standard itself.
> > >
> > > But we guard those definitions behind having libdw:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/Makefile?h=perf-tools-next#n3
> > > So we only have the regs if libdw is present, not if dwarf is in use
> > > for libunwind/libdw. Hence wanting to be specific that they are just a
> > > libdw and not a dwarf thing. Trying to use the regs in libunwind code
> > > would be broken. That could change but I wanted to make the code clear
> > > for the way things are at the moment.
> >
> > I understand your point but calling it LIBDW_REGS looks unnatural to me.
> 
> I don't follow. Wouldn't it be unnatural to see PERF_HAVE_DWARF_REGS
> in libunwind code but you are to some how know that the code only had
> meaning if libdw was present? I don't like the implication that DWARF
> means LIBDW as throughout the code it doesn't. I think the name
> PERF_HAVE_LIBDW_REGS better captures how the code is, makes the code
> more intention revealing and so readable, etc.

I agree with Namhyung this point. dwarf-regs is defined only by the
DWARF standard, not libdw only. The standard encode registers by a digit
number and the dwarf-regs decode the number to actual register name.

Actually, there is a histrical reason I had called it is DWARF. I used to
use "libdwarf", and switched to "libdw" for required features. So I know
there are more than 1 implementation of DWARF library, and the libdwarf
also uses the same operation number because it depends on the same standard.

https://github.com/davea42/libdwarf-code/blob/main/src/lib/libdwarf/dwarf.h#L809

So I think we'd better keep it call as DWARF_REGS.

Thank you,

> 
> Thanks,
> Ian
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

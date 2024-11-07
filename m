Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22E198A34;
	Thu,  7 Nov 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007503; cv=none; b=tFW1oBtNa1RpHyWs7teSPImv1SNZfV+BHV9lUPHGUaI0b2RojMLFHrzyNgdkqoWx/XDHiB5HBEwdCGjlpul/zgHaieA6XxC7P3DVb7ojXsRInrdRKWHAGuGRSjTj8G6Ezh82iBOH4NmtRfb0tgvMcWpOVswWJvXnttI8TMn55Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007503; c=relaxed/simple;
	bh=6q3di7FCObUiv+8Jph+EMw//u0ETdnwSd7iOqeptPbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAuvW1SYe2KYdi/WH+gZO1fu6aKm1i3j3nCRB3JsX1sZMkv05ZAxsvHVMqhRdzvBQQEtfu668/43VJsAJuEqegZXZAhu4PHblMxVLWYILcYCAdv/3hRLOthXV53SDPB43UVRRM4UH2gsO1k1ZAwXbksUv/PdNpqqChK/c7qYwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG73QAev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG73QAev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A98C4CECC;
	Thu,  7 Nov 2024 19:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731007502;
	bh=6q3di7FCObUiv+8Jph+EMw//u0ETdnwSd7iOqeptPbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GG73QAevx0zlzfcdWAvXpV28VzlJoMdMbX0AMjUcQI5vRN+7+pMfRGgqU0cDfptSb
	 zL2MQbJ6cjAH3Kg5SzBu7m7j14xnl/Pw+YVlvNdqS2jOHNCUnnBLn/bw/GEN8Al1Vm
	 h79qPml7pCyhy1l6XdwW6rHsctM7ryhCv2NTyRg8wXWMHsRBW8Jduz4Oi/v+MfUUaP
	 4wTFJIdKoIbBBEjHQAgG0A4oRVx5kYPCGe67ZROg3W+7wYMcljYzILh4wU7dN7t6kE
	 mR473WoU0J7nZIGUw0BdXT67ZoZLu/6e1QiZVvH0drnfh+vRUNdfkjYTbJSFflSC7h
	 Lddp+3GFnvwWg==
Date: Thu, 7 Nov 2024 11:24:59 -0800
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 17/31] perf dwarf-regs: Pass ELF flags to
 get_dwarf_regstr
Message-ID: <Zy0UCxKmD3_mQmNh@google.com>
References: <20241005195541.380070-1-irogers@google.com>
 <20241005195541.380070-18-irogers@google.com>
 <20241007170927.f30fced63c5e777628bea311@kernel.org>
 <CAP-5=fVmD-M-ZOinkWZ7AOtfRHqo89gFtDeeatwufq0TcBiZUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVmD-M-ZOinkWZ7AOtfRHqo89gFtDeeatwufq0TcBiZUA@mail.gmail.com>

On Mon, Oct 07, 2024 at 08:05:23AM -0700, Ian Rogers wrote:
> On Mon, Oct 7, 2024 at 1:09 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Sat,  5 Oct 2024 12:55:27 -0700
> > Ian Rogers <irogers@google.com> wrote:
> >
> > > Pass a flags value as architectures like csky need the flags to
> > > determine the ABI variant.
> > >
> >
> > Same here. I need some examples of this chaneg.
> 
> The code here was already using the ELF machine, so dwarf-regs.c
> functions would already support cross building. There is the addition
> of ELF flags as on csky the registers change depending on the ABI
> version in the ELF flags.

I think it's used by the probe-finder only which won't support
cross-arch environment.  So probably no changes to users at this point.

Thanks,
Namhyung


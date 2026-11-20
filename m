Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149186;
	b=42Col3gYg5GVvnknC+iIjIvZ5D11S9xHmwY2fvRsGATqQRIVOH4mrMjo8dI/OQk089/G
	 1c1MazrOUYbU5A4lHwV31jJ/4hDsfUxmcEXC3SLudbAnAJPjLscuSG1b4EP1dzKrYSUxx
	 OgBl2XP6LetkPK7GgP+zZW1dGB37nYT0qWo75mgFH0K/MCWS78D/edyvWFBkHIrUVQpYZ
	 mslwdDOKumSZxuMlr6FcxkJ7QiybSR4sVNmRSL/aqIQ0xDCuCo09rULx5bCTI8cLF1CoB
	 cQU6qT3EOyTfws7DQ2cAaauiKleQAXq8sC4JTPyMfwBLJIS7rVe5HnlNWDNftyYyyyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149186;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4ZUTHixnNvHLACadZ78CCCEWccIH2yVT7jYAC6zU53A=;
	b=1dwMrTms0w0pH8R+Hg1VjEZeIZ61lgzOOUm+BPwCpXrZYcsLo0b1mm+oNQSeRCMYeUhD
	 dAsQiU/kkBj9CwfFj0UHJx1hnTi4cm4uMki4lCb7TMuMu+BPDDHWQvPhoZAt1/0br29EV
	 vgd8uAegZEUper4p+GbvEVIqiPHMEJmAM+ihxim+s8HYIa46kYqqAKVcFGelPq1kgmDyB
	 1JI+H97/Ao9SKujm2UD3KjKnf8X0bNTD2+M3WpViXQvsqWr/9paKrTtanZ5JlAKlScnfK
	 hA9k7RVTX2haFb2tgYj6hrBj+zSuotyY2kdN3RDmOKNoFoMaZmb+aJenK+Oh8pCiqig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O4s9Rc/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED69606A332;
	Fri, 20 Nov 2026 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4s9Rc/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14431F000CA;
	Fri, 20 Nov 2026 04:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795149186;
	bh=4ZUTHixnNvHLACadZ78CCCEWccIH2yVT7jYAC6zU53A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O4s9Rc/fpmh2rQxqFrKwn3SskeYKCWhyDGsKMWK7e8f/RI3Jc376vVA/K36/KFEO0
	 6rOsyFlbsXE4uxfbWeGWXYSJkw+kS9IeIvJnoebKUCIa2ThBV3mtHyMTuONV/5aBrd
	 vyAfNFMcNTMlkDPoyTqiqcQbnrTml1391CkRZbBe9RB6DJG/LlbGPb8iMVVc4kqFLH
	 6vDwgSFimkg3Tepgmxy0e495NEy8xXEGBilN6TdyyNv0fg+3uUl/WgiRAk8psIJ+8R
	 yfWPF7h92lw++Nhuqk0RNJEvGut6bDhQ1BKpF1xPj9UuqIGz/nUSZhH3oJShdAGD8i
	 K7vGqxqQlQ0xg==
Date: Thu, 19 Nov 2026 20:33:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alireza Haghdoost <haghdoost@uber.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] perf symbol: Sorted arrays, DSO-owned lifetimes,
 and memory shrinking
Message-ID: <av_NgB044_PInjhM@google.com>
References: <20261117185305.108003-1-irogers@google.com>
 <av6mfhEBYhJUebPZ@google.com>
 <CAP-5=fXy3L42T03AiSfhmw9pXR5-VTxFK4bKu005tkocJAXp6g@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXy3L42T03AiSfhmw9pXR5-VTxFK4bKu005tkocJAXp6g@mail.gmail.com>

On Thu, Nov 19, 2026 at 08:31:48AM -0800, Ian Rogers wrote:
> On Wed, Nov 18, 2026 at 11:34 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Nov 17, 2026 at 10:52:56AM -0800, Ian Rogers wrote:
> > > When profiling large binaries or long-running workloads with many DSOs and
> > > threads, symbol and DSO tables frequently dominate perf's memory footprint
> > > and startup latency. Currently `struct symbol` has several structural
> > > limitations:
> > >
> > > 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
> > >    `dso->symbols` address rbtree, plus an optional negative-offset
> > >    allocation prefix (`symbol_conf.priv_size`) for `struct annotation`
> > >    state even when only a tiny fraction of symbols are ever annotated.
> > > 2. `dso__symbols()` has no internal synchronization against concurrent
> > >    readers/writers, and `struct call_path` (plus Python callchain frames
> > >    and nodes) still retains raw `struct symbol *` pointers without
> > >    retaining a reference on the owning `struct dso`, preventing
> > >    unreferenced DSOs and their symbol tables from being safely reclaimed
> > >    under memory pressure.
> > > 3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
> > >    invokes `libelf` section/program header lookups per symbol, calls
> > >    `elf_sym__name()` before filtering out non-function/non-allocated
> > >    symbols, and resorts `dso->symbols` with `qsort()` even when ELF symbol
> > >    tables are already largely ordered in ascending address runs.
> >
> > [...]
> >
> > Applied the first 3 patches to perf-tools-next, thanks!
> 
> Thanks Namhyung! Should I rebase or do anything else for the next 6 patches?

Please read my comments in the thread. :)

Thanks,
Namhyung


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39E9443;
	Fri, 27 Sep 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457396; cv=none; b=iIDA9wwuCeIsGfZAnnkpfk4yFy7Qvb0EtOsrj7EbFGH+4vfZD8sCxzWVFNIOjf06/H1t0mkBBKGUQXRpaseZ1PCivCGuFapJvshSf4NfAqZ1MPNwUhBcjup1d29nhSM7jb9Mz2rxo5Vg6QVZvxinXtS3Qv4782kZ1kkQHjqq+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457396; c=relaxed/simple;
	bh=WknK4cOtOLyalFU6sTUSoe3/Zmky5Kztt69ULojNWv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erJvMtQDU2nW1Cernxn40+WZi453VbHPGcTYulhWG85yCBsOeJgiXGr9YI7u+E6gmMgIPpZl0798TmqAyvHp85r/HrpJAfk8d7TVuVUtaZBj93OpRo5haXcixV9Cie3Hy4KNUSbJONmsKhDE15JsueFRvOPLphbmRJejH5pXLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9KsOEca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9KsOEca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813ADC4CEC7;
	Fri, 27 Sep 2024 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727457395;
	bh=WknK4cOtOLyalFU6sTUSoe3/Zmky5Kztt69ULojNWv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9KsOEcaHCPjUZl479E0wwJWyCK9AgvhOzUUUXvhchm5hebe/NhKlSQ9XuCbncHmg
	 4lQoAuPEAXbP+MpoXSH0/p5H2StYSnZ7ejPSWd5kUz/wwlvhURZZ6b9PaNUsgGNmrf
	 yntEXqCPH9dOlHnxz3m1sDt/cgLPvJ5ik+Mc5Nru0FNKuotpOqdyGcSy0jha05TEre
	 ckWnlydh16vKwmjc3dhN+6CfHTPfoPVTB/mFwuKmxDT7eHqBvs9rqhPs+ueEuXU2Qp
	 1ovPTBZyjTSaukjfwD9wAIO20PMweL6uQ2epLWYPkXC3VWLRDcGW7BQghIJQSelLEf
	 Xs1xW5fUvxQ2w==
Date: Fri, 27 Sep 2024 10:16:32 -0700
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
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to
 PERF_HAVE_LIBDW_REGS
Message-ID: <ZvbocHwtPkwJwDOA@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com>
 <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
 <ZvW4iZpTinJKWIFD@google.com>
 <CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>

On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> On Thu, Sep 26, 2024 at 12:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > > On Wed, Sep 25, 2024 at 8:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > > > The name dwarf can imply libunwind support, whereas
> > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > > > > make it clearer there is a libdw connection.
> > > >
> > > > While it only covers libdw, I think the idea of this macro is whether
> > > > the arch has register mappings defined in DWARF standard.  So I think
> > > > it's better to keep the name for this case.
> > >
> > > How can the dwarf standard exist for an arch but not define registers?
> >
> > I meant it's about the arch code in the perf tools to have the mapping,
> > not the DWARF standard itself.
> 
> But we guard those definitions behind having libdw:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/Makefile?h=perf-tools-next#n3
> So we only have the regs if libdw is present, not if dwarf is in use
> for libunwind/libdw. Hence wanting to be specific that they are just a
> libdw and not a dwarf thing. Trying to use the regs in libunwind code
> would be broken. That could change but I wanted to make the code clear
> for the way things are at the moment.

I understand your point but calling it LIBDW_REGS looks unnatural to me.

Thanks,
Namhyung


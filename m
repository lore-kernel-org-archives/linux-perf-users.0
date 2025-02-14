Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10915FA7B;
	Fri, 14 Feb 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558723; cv=none; b=m1TN6xWEcSi46ZGYhU6AAiDeaNSxX2KMoKT7R0gSkR8Ps6rQsjhoGMS78aF+mCf3VrgFZvuSphh2ha8s6jSsfUmzOmjfHlE1g0aIJSxHi702ENyCxWXNUzFKY4+83xzA7Yv/TGNWaXz1rJULmwMnu9I0CVrb043EoeRUYVYo6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558723; c=relaxed/simple;
	bh=hhnbXVudW3X9Ob2dmDCWIf7SoirkZhCcBkp92o1UP/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H64E04lUDF2ES/HVKQFvVSEuOq2ncOMw5oiZxokNjcfK2C2yD8b0L31JU7KSKi28y8eqJEtIopqWoOOZvPi2BCnlMnYbf5J2/tWp6oYB4i+m9yG5I++gZ7h1SKUE1z+tEitMAW11tVBd2kspe+baxWoXRGrOS6O/v9udYp14UWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exnUPGgX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exnUPGgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACCEC4CED1;
	Fri, 14 Feb 2025 18:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739558723;
	bh=hhnbXVudW3X9Ob2dmDCWIf7SoirkZhCcBkp92o1UP/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exnUPGgXUpVDJXfejHV+qS8UhaO6MyTm9FhHIGy7axieRMhiCYpxEeV95XUqEQV/z
	 dWba2REJty7aNMPZvd9Qp0s+t19qx39nouxaC7aOyQDi4gQdsE76u1ASz5BBjPuo7O
	 d3XH7wnod77QHb+bL+nWASGq0iMT8Knn3iNc6FhfdD6ovJB/lIBbH13LgkHLcxVcA2
	 SXkKx+ag/Lzr2L14KoHqK0SZhS9nFlpdA5PSXmR+XmBBk65mNp3Vdw+4keQWEwoCIm
	 H64XCqnLZsYDQzUr7PH73nT8o2NSP5ql6wYrx6gf1Pguyni+nrMRlVp00fnzPZ/1NT
	 1b0lxMUIoA9fw==
Date: Fri, 14 Feb 2025 10:45:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm64: Fix compilation error
Message-ID: <Z6-PQVOVLrZqey-u@google.com>
References: <20250214111025.14478-1-leo.yan@arm.com>
 <aa347f0f-ebd3-4744-9053-14dab87d06b8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa347f0f-ebd3-4744-9053-14dab87d06b8@linaro.org>

On Fri, Feb 14, 2025 at 11:21:52AM +0000, James Clark wrote:
> 
> 
> On 14/02/2025 11:10 am, Leo Yan wrote:
> > Since the commit dc6d2bc2d893 ("perf sample: Make user_regs and
> > intr_regs optional"), the building for Arm64 reports error:
> > 
> > arch/arm64/util/unwind-libdw.c: In function ‘libdw__arch_set_initial_registers’:
> > arch/arm64/util/unwind-libdw.c:11:32: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
> >     11 |  struct regs_dump *user_regs = &ui->sample->user_regs;
> >        |                                ^
> > cc1: all warnings being treated as errors
> > make[6]: *** [/home/niayan01/linux/tools/build/Makefile.build:85: arch/arm64/util/unwind-libdw.o] Error 1
> > make[5]: *** [/home/niayan01/linux/tools/build/Makefile.build:138: util] Error 2
> > arch/arm64/tests/dwarf-unwind.c: In function ‘test__arch_unwind_sample’:
> > arch/arm64/tests/dwarf-unwind.c:48:27: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
> >     48 |  struct regs_dump *regs = &sample->user_regs;
> >        |                           ^
> > 
> > To fix the issue, use the helper perf_sample__user_regs() to retrieve
> > the user_regs.
> > 
> > Fixes: dc6d2bc2d893 ("perf sample: Make user_regs and intr_regs optional")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>

Thanks for the fix, I'll handle other archs too
Namhyung


> > ---
> >   tools/perf/arch/arm64/tests/dwarf-unwind.c | 2 +-
> >   tools/perf/arch/arm64/util/unwind-libdw.c  | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
> > index b2603d0d3737..440d00f0de14 100644
> > --- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
> > +++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
> > @@ -45,7 +45,7 @@ static int sample_ustack(struct perf_sample *sample,
> >   int test__arch_unwind_sample(struct perf_sample *sample,
> >   		struct thread *thread)
> >   {
> > -	struct regs_dump *regs = &sample->user_regs;
> > +	struct regs_dump *regs = perf_sample__user_regs(sample);
> >   	u64 *buf;
> >   	buf = calloc(1, sizeof(u64) * PERF_REGS_MAX);
> > diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/arch/arm64/util/unwind-libdw.c
> > index e056d50ab42e..b89b0a7e5ad9 100644
> > --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> > +++ b/tools/perf/arch/arm64/util/unwind-libdw.c
> > @@ -8,7 +8,7 @@
> >   bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> >   {
> >   	struct unwind_info *ui = arg;
> > -	struct regs_dump *user_regs = &ui->sample->user_regs;
> > +	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> >   	Dwarf_Word dwarf_regs[PERF_REG_ARM64_MAX], dwarf_pc;
> >   #define REG(r) ({						\
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 

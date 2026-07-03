Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1233A9FE;
	Fri,  3 Jul 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111872; cv=none; b=GbTLQS/VgdhBNdzPeoNzB6WsSanKoKZ8BSL0aUAecnWIfiyPnfRf3oSZCRlQeGA5490hsGyY2kVDwJxV/GfBY+D7dCVH58u1mpiWuliw7NZuh4ndIl9WbprKwb5l2K2YUNyJmUg79xcJ3zwOFZrRMZiwBD5X9lPfINvzVYvrqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111872; c=relaxed/simple;
	bh=XyHCWJhPb3o5p3Y9q3cRTUIpwkdwTWqw4Y9urcH3ktc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP1t7QpRiX6/BUoqTKM4ARh4t86/u9dWzQ7gtTCPHyQZuzy70C4MVMwmdu+f/gv38Z6ZiNJQFexWEd5mPdVvwNjo7zBswR4j7JlcrjwwXx31tjW3W2CQWjwzw1DDm687QSKwMvqjGvfL0mqJMI/qDHvE0aexq7jbSHCBxq8pxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad25vx7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad25vx7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D64A1F000E9;
	Fri,  3 Jul 2026 20:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111869;
	bh=QcWbDiJJuAusGFh5DYAZanbvEeu4zT4OEzfbO6WxwSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ad25vx7HD6qV53pKiaOU1+m1XVRPSqjfjHFA3FOo8l/8H+lTgzLycJTNPEa9pPzDZ
	 s/PsUTvDKdP9s5zpZXZd4YDJ+7RuNEjykX7UngjeABVBgWK4zvk4HN+6/ABPAYGwNV
	 cE1M/mTelpsFf1z9bIvipz4w9BCXTtzm1v6+esAyu3VYJb58jD2Jmf1hThswQy5cZ7
	 LRV8dtaThmz+tZ7QrzY3LYOuWGixinJHukeHIKOhryqZ9Rdc/iYMzavOccHu15bdh3
	 91vsk1voiuKT/k9fOodtQqjA2DrcMPqxeNkzdJ4G8Bb1ytkfQsdFN0flZRwh+buW1E
	 ur+rBeopZGRsA==
Date: Fri, 3 Jul 2026 13:51:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix compiler errors with old capstone
Message-ID: <akgguxqFNmXtbgA3@google.com>
References: <20260701182824.347941-1-namhyung@kernel.org>
 <CAP-5=fUzfFkErqnDp4iJEgCQdAO1pFRKMKWn3mhEGK5z2qZvWA@mail.gmail.com>
 <akVqvG7amtP99cmE@google.com>
 <CAP-5=fXUzEzFjLoh9SuNSch5=NdCEAkw4Dx-+Xd883JKVGV65w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXUzEzFjLoh9SuNSch5=NdCEAkw4Dx-+Xd883JKVGV65w@mail.gmail.com>

On Wed, Jul 01, 2026 at 04:39:07PM -0700, Ian Rogers wrote:
> On Wed, Jul 1, 2026 at 12:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Jul 01, 2026 at 11:49:03AM -0700, Ian Rogers wrote:
> > > On Wed, Jul 1, 2026 at 11:28 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > It seems RISCV was added in capstone version 5.  Unfortunately they are
> > > > enum constants so cannot check with #ifdef but anyway we can define the
> > > > symbols.  Let's do it using the version number to avoid build errors.
> > > > It'll fail at runtime though.
> > > >
> > > >   util/capstone.c: In function 'e_machine_to_capstone':
> > > >   util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in this function);
> > > >                                   did you mean 'CS_ARCH_SYSZ'?
> > > >     186 |                 *arch = CS_ARCH_RISCV;
> > > >         |                         ^~~~~~~~~~~~~
> > > >         |                         CS_ARCH_SYSZ
> > > >   util/capstone.c:186:25: note: each undeclared identifier is reported only once for each function it appears in
> > > >
> > > >   util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use in this function);
> > > >                                   did you mean 'CS_MODE_MIPS64'?
> > > >     187 |                 *mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
> > > >         |                                  ^~~~~~~~~~~~~~~
> > > >         |                                  CS_MODE_MIPS64
> > > >
> > > > Also note that capstone renamed CS_MODE_RISCVC to CS_MODE_RISCV_C which
> > > > would cause a different build failure on latest versions.  It's reported
> > > > in https://github.com/capstone-engine/capstone/issues/2977 so I think
> > > > they will add compatibility layer to prevent the error.
> > > >
> > > > Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_machine")
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Perhaps update the feature test from:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/build/feature/test-libcapstone.c?h=perf-tools-next
> > > ```
> > > cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
> > > ```
> > > to be CS_ARCH_RISCV? That way we won't detect old libcapstones and
> > > avoid cluttering up the code.
> >
> > Then it'll drop support for capstone version 4 which works fine on some
> > architectures.  Maybe we can add another feature check for capstone
> > RISC-V support but I think it's better to define the RISCV symbols here.
> >
> > What do you think?
> 
> Arnaldo and I also discussed this in a thread, but I can't find it
> right now. I believe the RISC-V support in libcapstone is now 8 years
> old:
> https://github.com/capstone-engine/capstone/issues/966
> so it seemed unfortunate to add shims to support older libcapstone versions.

It seems v5.0 was released 3 years ago (2023-07-05).

https://github.com/capstone-engine/capstone/releases/tag/5.0

Actually it's added to v5.0-rc1 which was released a year before
(2022-02-27) but I guess many distro didn't ship the -rc.

https://github.com/capstone-engine/capstone/releases/tag/5.0-rc1

Thanks,
Namhyung


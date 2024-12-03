Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5291E868;
	Tue,  3 Dec 2024 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250840; cv=none; b=i4XfvMJVIzOXZUCixbrhu43yzlFpHgHCHIUDPvJFtff+k92T6i2fM0NNKdStDzVp23C5Jl2zlV9uuAuoNwNk8Jla0UOJcvR+aersMFtMfDp+wCsgDc8Iekyf7W1BRr80Sz8yLGih89bmi20qKioryCBt1oXNpsVXzkV9Q/UmjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250840; c=relaxed/simple;
	bh=qL82kdN/VnAc1eWZA5QGGREouW8YZfGqE11v9lnfWOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfJkmAj/YfXRr75j0hL+AQH2MAgXKxS2jjGZTrYA9CUZrQmuKYjYMdmbfAloUzBUnMzJD6800ukUS6y9UVy7IvgZwg23HafJM7+z4UckHLB3c4PMq37Ax8zJSpR2u8TbiWKTLJV/YQA4/1poGeEU0/WNBoNe0kFMAT8+N66MlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWlKnfbY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWlKnfbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BAEC4CED6;
	Tue,  3 Dec 2024 18:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733250840;
	bh=qL82kdN/VnAc1eWZA5QGGREouW8YZfGqE11v9lnfWOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWlKnfbY7zWnVJJBLncHaEwQ1q1nJW8AReXGzlx8w48tgIXG6nHc1V8TT22KsL/cZ
	 FPOcPa2PN3Dxb2PaIX2TbFVK5gYfImrj6T9EjIltMfBMmBWVGvfqWInFWqFAVzrWPh
	 WgVkHRBYmXR61discBStT41744KOoi/5u9rRLOiE1gQ/8/8syeycMh0FXia54tlRcj
	 dSnPlJJG01r4zIlsJfx2mgigqHYO0luAut5yQDtua9pXzc0qkqIFWOJK50DZikFCK9
	 tUH2n1I1oCabWUIIFCj5cz2e/cf7VVe074X2OeUCuNaJw5oWC6LIKXVD3EamyK5Ddz
	 wpDCqTKZlU2uw==
Date: Tue, 3 Dec 2024 10:33:58 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] perf-tools changes for v6.13
Message-ID: <Z09PFr3iEoa-oJg0@google.com>
References: <20241125071653.1350621-1-namhyung@kernel.org>
 <Z0TK9aqrQO1PremH@sashalap>
 <Z0U4Dk_W30x4JSXG@google.com>
 <CAP-5=fVE4VTtB23CHF2rSwm=0RM4Y=iVEJJYiYD9OLJLQQfaVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVE4VTtB23CHF2rSwm=0RM4Y=iVEJJYiYD9OLJLQQfaVg@mail.gmail.com>

On Mon, Nov 25, 2024 at 11:36:37PM -0800, Ian Rogers wrote:
> On Mon, Nov 25, 2024 at 6:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Mon, Nov 25, 2024 at 02:07:33PM -0500, Sasha Levin wrote:
> > > On Sun, Nov 24, 2024 at 11:16:53PM -0800, Namhyung Kim wrote:
> > > > Hi Linus,
> > > >
> > > > Please consider pulling the following changes in perf tools for v6.13.
> > > >
> > > > Thanks,
> > > > Namhyung
> > > >
> > > >
> > > > The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:
> > > >
> > > >  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.13-2024-11-24
> > >
> > > Hey Namhyung,
> > >
> > > After merging this PR into linus-next, the "Simple expression parser"
> > > test has started failing:
> > >
> > > --- start ---
> > > test child forked, pid 292
> > > Using CPUID GenuineIntel-6-1A-3
> > > division by zero
> > > syntax error
> > > Failed to find TSC frequency in /proc/cpuinfo
> > > FAILED tests/expr.c:250 #system_tsc_freq > 0
> > > ---- end(-1) ----
> > >   7: Simple expression parser                         : FAILED!
> > >
> > > Here's a full log of the run: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-24716-gab16e9af2ff9/testrun/26045681/suite/perf/test/_7_Simple_expression_parser/log
> >
> > Thanks for the report, I'll take a look.

Sorry about the delay.  But I cannot see the log unfornately.

> 
> I suspect this is a side effect of the tool PMU refactoring where the
> expr double values were changed to u64 counter like values:
> https://lore.kernel.org/lkml/20241002032016.333748-8-irogers@google.com/
> 
> The CPU model matches nehalemep:

Oh, it's an Intel machine.  Then it should have the #system_tsc_freq.


> ```
> $ python tools/perf/pmu-events/models.py x86  GenuineIntel-6-1A-3
> tools/perf/pmu-events/arch/
> nehalemep
> ```
> so the tsc frequency should be determined via /proc/cpuinfo looking
> for  "model name ... @ %lfGHz":
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/tsc.c?h=perf-tools-next#n44
> 
> The logs make the machine look like an emulator (reference to bochs)
> so I wonder if the cpuinfo is incorrect. Why the switch from double to
> u64 would show this problem I'm not sure, perhaps a latent bug was
> exposed in the test as previously NaN would be returned which does
> interesting things with comparisons. The test is expecting on an Intel
> x86 it should be able to compute the TSC frequency and assuming the
> cpuinfo is lacking the "@ ...GHz" then the test could be working as
> intended.

Right, we may change the test code not to assume TSC frequency is always
available on Intel machines.

Thanks,
Namhyung


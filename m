Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14902218EBC;
	Thu,  5 Dec 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733424598; cv=none; b=Kej6a4/ccuM290j58O5BzuOqKJVZ6wGBwyuN3elz4NozuYzcOXCaq4NmNHjlMGlmgV827lqycmZbjtsK6SJGC9OXOky5Bzn1F1uiDZBXyjr0GroPI5lTnrMelB2RPIoVkvHUlbvcBG1gUhUL1uxcewZ5t8ze+oKbDiq0u8OO7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733424598; c=relaxed/simple;
	bh=dDt0khiKo+ui9Wm7vhnocIu34JPC6qEiqspVC45Co08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEF9GGMCNgvMCYTSYJo/8ubkgF/mK1vqAs0Fy2QelX4LXRr4LUbWJSUlwVWhbkg2/4FTY3cu91CX33aHlLBo1r/3iSD0wi6C8BbWAGQ7rbCPycv12EsLIJXikJqZvKgdAYzTl2UNLK5ji/dD2Zwhr/QNg+2iy5kvz4w9kT1Hqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAUOWeBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAUOWeBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07F5C4CEDD;
	Thu,  5 Dec 2024 18:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733424597;
	bh=dDt0khiKo+ui9Wm7vhnocIu34JPC6qEiqspVC45Co08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAUOWeBh4k673SZK1Msddq6V6UTnmQk/LU+3iyN7fuAVSHyC00QyVNzSN85PQlFgy
	 ON9nQJ1ABrXgUL8aQBmiW7vNn8VYrHdwl1aB2seQhsUk0ygR0jnLVgnFzIULmyiLMu
	 gOWJKXpcT35sPFN3Xqn/lJkUiY6+NrAk1dinnGr0oRhvrkZ0KXIdzuTy0C5+L6PjhF
	 aOlEPZHvWG08ZSrOOcKT6L4/U7DT3p0cfLGA8UDNyc2FwqyXLmA24NSjNapUFnXssk
	 hVLzDsPHhMCbmvl0j0T6BsOJNELymYdHXl809FpiddgsKW5KhHu9nYYJEumffMAaaf
	 lavkBDZnSgndw==
Date: Thu, 5 Dec 2024 10:49:54 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.ibm.com
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
Message-ID: <Z1H10jkXnGqC1vWg@google.com>
References: <20241205022305.158202-1-irogers@google.com>
 <Z1E-WHWSPAezVF4f@google.com>
 <CAP-5=fVPw5wJtVR0fxU-7drXg34vNrBsEzurfcLLvC+wFPMAAg@mail.gmail.com>
 <CAP-5=fV6s0=X-+8i2+1O_ZKERTL8+S9S-nyZC8rJPNU_nQpbyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV6s0=X-+8i2+1O_ZKERTL8+S9S-nyZC8rJPNU_nQpbyg@mail.gmail.com>

On Wed, Dec 04, 2024 at 11:09:50PM -0800, Ian Rogers wrote:
> On Wed, Dec 4, 2024 at 10:33 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Dec 4, 2024 at 9:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Dec 04, 2024 at 06:23:05PM -0800, Ian Rogers wrote:
> > > > The refactoring of tool PMU events to have a PMU then adding the expr
> > > > literals to the tool PMU made it so that the literal system_tsc_freq
> > > > was only supported on x86. Update the test expectations to match -
> > > > namely the parsing is x86 specific and only yields a non-zero value on
> > > > Intel.
> > > >
> > > > Fixes: 609aa2667f67 ("perf tool_pmu: Switch to standard pmu functions and json descriptions")
> > > > Reported-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > > > Closes: https://lore.kernel.org/linux-perf-users/20241022140156.98854-1-atrajeev@linux.vnet.ibm.com/
> > > > Co-developed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > It failed on my VM.
> > >
> > >   root@arm64-vm:~/build# ./perf test -v 7
> > >   --- start ---
> > >   test child forked, pid 2096
> > >   Using CPUID 0x00000000000f0510
> > >   division by zero
> > >   syntax error
> > >   Unrecognized literal '#system_tsc_freq'FAILED tests/expr.c:253 #system_tsc_freq == 0
> > >   ---- end(-1) ----
> > >     7: Simple expression parser                                        : FAILED!
> >
> > I'll need to check this. The test is looking for parsing failures, so
> > it's confusing to me expr__parse is returning 0. I was testing on x86
> > but disabling the literal in the tool PMU.
> 
> Hmm.. perhaps you had a similar issue to me and that b4 silently
> failed as git user.email/user.name weren't configured? When I test on

No, I confirmed it's appplied.  Maybe my VM setting has some problem.
After reboot + rebuild it works now, sorry for the noise.

Thanks,
Namhyung


> a raspberry pi 5:
> ```
> $ uname -a
> Linux raspberrypi 6.6.51+rpt-rpi-2712 #1 SMP PREEMPT Debian
> 1:6.6.51-1+rpt3 (2024-10-08) aarch64 GNU/Linux
> $ git log -1 --oneline
> 94733a0e50fd (HEAD -> ptn-expr-test) perf test expr: Fix
> system_tsc_freq for only x86
> $ /tmp/perf/perf test expr -v
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
> BPF maps, etc
>   7: Simple expression parser                                        : Ok
> ```
> 
> Thanks,
> Ian

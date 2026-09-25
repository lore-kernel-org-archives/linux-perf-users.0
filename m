Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451A497B8A;
	Fri, 25 Sep 2026 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332970; cv=none; b=a6v3T0OjOzLT4YUogKvrc8jiHWPrJXBwWy5jm9gqU+P651x7iAByKhqytsMOqAKhLt4C9zZVlxP0R1P3s/8jwXYx4LieYDD7CiwccmRRK70zGl5UbKAKj40iszZTsTvTic7fiL4O6qw8Zs8GqAOqRYSlBgi1TjmHUTxJopFZNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332970; c=relaxed/simple;
	bh=KcardFD8DAGQ7e7khcgcpBT1t4GfrgFXB3N8ue0fUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmk6gncNJDC1LAshH+StEwUJxOKMpwCoT9Bs1olkAKwuxc30nQ2XQP3Nsj9wxtdjKQpTKn7OdgZwn+NWEqiYmTDZVe5OA0tQ/Hl2gdSHBi0nIzvvX4jm0UIhJcjv3edfPyY7UoUAMnjX39VtwIu4pgPULFMergfa5TRivSA7Cls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPeC49qc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPeC49qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B8D1F000FF;
	Fri, 25 Sep 2026 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790332968;
	bh=3ZTzhLuxEXouR3TAU4feLXrI0GNfd/I47bIeg4EAUXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPeC49qcWkXmzPw3W0T4pIzxDlK+vS1Nou5Qdcd01cqjsXTJO7SwrbhAPrDihTueH
	 Y3E9D63YjF3gQlqFn76iiM2prg5+yvo8/6i3Q+yBROlkYXoLSe/y9UPySKLYKkREgR
	 4WaW4Nl191DsG1s+j6hk6KJVSBgAl0zSr0VPnXeAkq2WfrozRKXibIOt74xTv0rLYW
	 V7txUWYbZB2wxYrKYhTgCLKi/DY4+bTJynLS5zBdO+SWiGtbn5goisyjvbE/gBsY72
	 2SRykHTUvCHTnJRemntWUUGpH+GwMN1qnLmB2q/EIpDDwu0exPfkP7pi1M9rvudD1N
	 +yTNBKwuiQy0Q==
Date: Fri, 25 Sep 2026 12:42:45 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH] perf jevents: Limit the number of JSON reading workers
Message-ID: <arZQJZvMWyksoJ9E@x2>
References: <20260917095921.2802275-1-sandipan.das@amd.com>
 <CAP-5=fXcDT7Vi32odox1_gSbiGakN8KQMjXCZjmh=SyxuaVDZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXcDT7Vi32odox1_gSbiGakN8KQMjXCZjmh=SyxuaVDZw@mail.gmail.com>

On Fri, Sep 18, 2026 at 08:31:46AM -0700, Ian Rogers wrote:
> On Thu, Sep 17, 2026 at 3:00 AM Sandipan Das <sandipan.das@amd.com> wrote:
> > The ProcessPoolExecutor is created without max_workers, so
> > concurrent.futures defaults to one worker per CPU and forks all of them
> > when the first task is submitted. Each worker costs the parent a few
> > file descriptors. For systems with high core-count processors like the
> > AMD EPYC 9996, the pool can easily exhaust RLIMIT_NOFILE as seen below.
<SNIP>

> > Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py")
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD022ACEB;
	Wed,  1 Apr 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076991; cv=none; b=O6iUmqiUv4c6HEdx371zHkWXegtc/+SVT5xb/+Jx6/4Sl6MbpLciu2l+bq7kS6UyXocsxlXPyBLc3dUnAZp5YEBge+5UBJZ3Bl/5gN/JqbTal8Apmv0xrYaYV6901xzA6rxp0Va/dK1mKUJvzkh+fjvfO7nR7XsY7P8ERy+D9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076991; c=relaxed/simple;
	bh=1AoxwUh+eJoEX7ZU+q6bFbXjIuzUu+7s5IX+yUW9eRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiC6nSS5XlNYimKjn1Lojpc0IR1obMHdG98miGdmwQwznAnzEcAmzP/e5ZiIZ26Ds3n1SUYvaCtShqKgE6I/q1oRXGXcZ95zu3j6wLWa2ERQNO1lht2Pxar51xlFOjt6LzCWFnTWSomfXFbDlgXoqFAt0gAi/PEmnmm4Cd46MH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdpVA5xw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdpVA5xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344DEC4CEF7;
	Wed,  1 Apr 2026 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775076990;
	bh=1AoxwUh+eJoEX7ZU+q6bFbXjIuzUu+7s5IX+yUW9eRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdpVA5xwH/Jt3aeECaHtqDt3c9vuybgQqyQxthXwLnjl0sJi32O8zMjMCB9kP4D3V
	 sa7xTPtX5MM+2OIT9s910XGgK/VTSN/X6x65EWD56hr7jC3FrTtnkfzot3vljywoCm
	 5rlzhRthGtQmYZw/1Ygs8ReGwgq8pyyyQ6sYdxC72Sqfipw/ugG31IaxXMGTzab/Wh
	 X1nNR3sXf/Ew/4Ak6ORNWU4gV8ssMURcNTOX0/kV6qPGg0yv0TGXx/HF8UD+Y0iQBg
	 gmz+Saso5H5zO/PlIEnMmvoehgrZ0IejLimZPKn6rw1ga7xzZT7X9QJotNFwDuIluT
	 0+qaNSRj5NR2Q==
Date: Wed, 1 Apr 2026 17:56:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Melo <arnaldo.melo@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Breno Leitao <leitao@debian.org>, Leo Yan <leo.yan@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH v2] perf stat: Fix crash on arm64
Message-ID: <ac2F5F1qShC9n2kE@x1>
References: <20260325-perf_stat-v2-1-d986ef5b9327@debian.org>
 <20260325205914.GA356832@e132581.arm.com>
 <CAP-5=fWkbhffgL6BJjpiwRV6rD3yd=KkOz7-ODH2FnORBf70bQ@mail.gmail.com>
 <20260326163926.GB356832@e132581.arm.com>
 <acZcG634vXs2_EWj@gmail.com>
 <5CAC1C39-9E69-4952-95CC-D84919D81F8A@gmail.com>
 <CAP-5=fUr4RdrGnnDE96GTQnpfj9anHVMxZ+gy7SwMEXGgm70uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUr4RdrGnnDE96GTQnpfj9anHVMxZ+gy7SwMEXGgm70uA@mail.gmail.com>

On Wed, Apr 01, 2026 at 01:16:49PM -0700, Ian Rogers wrote:
> On Fri, Mar 27, 2026 at 6:48 AM Arnaldo Melo <arnaldo.melo@gmail.com> wrote:
> >
> >
> >
> > On March 27, 2026 7:35:19 AM GMT-03:00, Breno Leitao <leitao@debian.org> wrote:
> > >On Thu, Mar 26, 2026 at 04:39:26PM +0000, Leo Yan wrote:
> > >> On Wed, Mar 25, 2026 at 03:27:05PM -0700, Ian Rogers wrote:
> > >>
> > >> > From the stack trace I don't see anything that should allow this.
> > >> > Either the list of metrics is broken, or the struct metric_event's
> > >> > evsel is NULL. But that should never happen as we wouldn't have a
> > >> > metric at that point. The sorting shouldn't affect that. If you can
> > >> > reproduce the issue, verbose logs may help.
> > >>
> > >> I believe I encountered a different issue, which is irrelevant to this
> > >> patch.  So Breno's patch is fine for me.
>
> > >That said, are there any concerns about merging this patch in its
> > >current form?

> > I guess not, will try and merge it later today for 7
> > 0.

> Looks like this one is still missing. Thanks,

So I think its too late for 7.0, I guess Namhyung should get it for
perf-tools-next, the fixes tag will make it get into the upcoming stable
series.

- Arnaldo

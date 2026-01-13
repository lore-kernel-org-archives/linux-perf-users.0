Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA150094C;
	Tue, 13 Jan 2026 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336360; cv=none; b=AqF7yZIlU2+cmoWSkkbmsI0EIGGAu+4lW/TjSTiMj7IT4yKZ8TgBRp0ylpgHc5kYz1MxawGg5QpKdrFzw5qt9d8SfnbHsTIt7J/qfU9e5RBGKOdseTxMHMyEpYzVeWZjKllGI9zGajau2UeWqzjvLKrq3mONd/QtIj4Q7Fhui6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336360; c=relaxed/simple;
	bh=H6PhnM2kCppM8aCBeFuEKsIPQgQaguqi5t6ulW9YN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLroWwGxDmbEzDa1p+cYtDqA0vsK5LohYltYn0ehsnNHTo072xu4oeJEPasM/ji27DoJalx/TPW1VYC+2h7sQj5C/OHzYuiySHsOcFb3BP8nQ7KQutO05VqDKgLIJoATeIF6oLcx3461COHShEK1fBDX49S9sBRHYPeREZODqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCsXeInD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCsXeInD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D85C116C6;
	Tue, 13 Jan 2026 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768336360;
	bh=H6PhnM2kCppM8aCBeFuEKsIPQgQaguqi5t6ulW9YN7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCsXeInDtJ3LS6lqB9JbP2I+iXKQxPaFsV2mB+xnT2JM4kPJQQa1uw6n0GjSGKfBJ
	 8p459RTS77vabkXDF5tDCpmP7BV5usl+yl0q8HwNFkR+BsJqTj1ADn/8ZYGeZlyXj4
	 yzLyyRuDXyWZx8hcMaeS5mEEw/IvvkEfyYxXpX3dOvV3kJdFVFmCZt5pF+DyTxeDR9
	 /9h+EDm/6LOQm9ocnfsMWFaJe8cnOlhDY9YDOYZIrL+/Y10TtmkSsinlG8HSfId2ae
	 9CRQ/S3o6KaAwaxuxZO+Gj7zMUDDi555mdcIBixcMavTsUM8J1xJ1wqoyY9EZILgdm
	 s22cZ+XaKvHkA==
Date: Tue, 13 Jan 2026 17:32:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf vendor events arm64: Remove uncountable events
Message-ID: <aWar5eUPISsiLA00@x1>
References: <20251231-james-perf-uncountable-events-v1-1-f2d9932999fd@linaro.org>
 <CAP-5=fUNJLoy25rS=diSXNR9h-h4m6EFPTy8M+KpTKxm6HtDSA@mail.gmail.com>
 <951f10c5-e1ac-45d4-b7ca-56aa32e57cd6@linaro.org>
 <CAP-5=fWQU59Vyb6y+W6ObOTh3nzFSofsn8sc6JzwZp7FiV+n6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWQU59Vyb6y+W6ObOTh3nzFSofsn8sc6JzwZp7FiV+n6w@mail.gmail.com>

On Sat, Jan 03, 2026 at 05:27:49PM -0800, Ian Rogers wrote:
> On Sat, Jan 3, 2026 at 8:38 AM James Clark <james.clark@linaro.org> wrote:
> > On 02/01/2026 3:29 pm, Ian Rogers wrote:
> > > On Wed, Dec 31, 2025 at 4:13 AM James Clark <james.clark@linaro.org> wrote:
> > >> These events are never countable by the PMU and are only intended to
> > >> be used as external inputs to trace. Therefore showing them in 'perf
> > >> list' is misleading so remove them.

> > > What does "trace" mean in this context?

> > CPU trace, Either ETE (Embedded Trace Extension) or ETM (Embedded Trace
> > Macrocell). You can select PMU events as inputs to the trace block to
> > make it do things like start and stop tracing.

> Ah ok, trace immediately makes me think of `perf trace` currently.
> Presumably there's no perf integration for ETE and ETM that somehow
> use these event encodings? Looks not and the changes make sense to me.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E34366;
	Sat, 14 Dec 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734135228; cv=none; b=OQVsrXAbEG8BWW7sl0vcT93r7p969JigFsI+Jw9yY1ji+VijBcWF0naR1/N0Yk07YvH9e6U1vnYpu/9W4b9xJuQrssVIVY6MYnii6kcQIhGcVukiWy8YXP67Fg1XMt8J5W7nDge4ctptsh4QRRvkaGHnljgy/y8578lAvpLxUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734135228; c=relaxed/simple;
	bh=fG9idVSJT3S6L7tCx0N4GpumBLRytSIG+hnvmB89sD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqLWMhvRu0cspGUW+4EeNpOt3qXUNyDaLCZ9ChTf0uw6Z7zsAEvB6awgcJPvjSiWaDmjp8QmLyANlW4nlzOV9B+XOOvr3yEN2AeJLKYhwxvQPAfinLG6eOF7GULaTF+zv7IcDlPp4sP5hLroSdcYKsE3Kfe4WX+ZjNvn3arYA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1xpBk7d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1xpBk7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBA7C4CED0;
	Sat, 14 Dec 2024 00:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734135227;
	bh=fG9idVSJT3S6L7tCx0N4GpumBLRytSIG+hnvmB89sD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1xpBk7dOfyjiIfJG094Pfsp0utg4lDCVgTC7odUCfNiw5JT4Exsw5Fo7e97LadBs
	 mfGzr/vR5zNf5sFwUJEZImJhSKcXOet4y6eBkxXNHlksmCkGfbBNzLdd3ACja3+iN1
	 66pyzsXNustEXxAINMMrRbttorlTLXPPRiEXBnRLqEQv1qII/g6tcs7hYeX1G+5lvM
	 qazjoUm0zCG54IhfIoG1CxEunivX9htMMjyXjAKNRM9wQgihEk/VfgwtW+a4k+tmQq
	 gBAta/8KglzceDKall8GiCz080vr/J/Zy1EjzePkJ8OPtx1428O17/K2VuVQe1HuPf
	 bj38pnGj+xtQA==
Date: Fri, 13 Dec 2024 16:13:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Chen Ni <nichen@iscas.ac.cn>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Prefer evsel over evsel->core.idx
Message-ID: <Z1zNuQaqtDDoQhP6@google.com>
References: <20241114230713.330701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114230713.330701-1-irogers@google.com>

On Thu, Nov 14, 2024 at 03:07:10PM -0800, Ian Rogers wrote:
> James Clark's patches fixing evsel->core.idx [1] reminded me that we
> pass the int value around unnecessarily. Passing the evsel avoids
> issues if the evlist is reordered but paired with sanitizers we can
> also know when something is used when it shouldn't be. These patches
> do some initial work reducing the use of evsel->core.idx or reducing
> the API to pass evsels and not their interior index.
> 
> [1] https://lore.kernel.org/lkml/20241114160450.295844-2-james.clark@linaro.org/
> 
> Ian Rogers (3):
>   perf stream: Use evsel rather than evsel->idx
>   perf values: Use evsel rather than evsel->idx
>   perf annotate: Prefer passing evsel to evsel->core.idx

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/builtin-diff.c         |   4 +-
>  tools/perf/builtin-report.c       |   4 +-
>  tools/perf/builtin-top.c          |   4 +-
>  tools/perf/ui/browsers/annotate.c |   2 +-
>  tools/perf/util/annotate.c        |  32 +++++----
>  tools/perf/util/annotate.h        |  20 +++---
>  tools/perf/util/stream.c          |   7 +-
>  tools/perf/util/stream.h          |  10 +--
>  tools/perf/util/values.c          | 106 +++++++++++++-----------------
>  tools/perf/util/values.h          |   9 +--
>  10 files changed, 90 insertions(+), 108 deletions(-)
> 
> -- 
> 2.47.0.338.g60cca15819-goog
> 

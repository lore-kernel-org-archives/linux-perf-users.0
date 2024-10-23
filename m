Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C878C9C;
	Wed, 23 Oct 2024 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726269; cv=none; b=Han2aaM0p7fbaJdrmkEwU0jrJFltl9KhZFyluppN6NtVS+IwTMw2PQpzYpjKvu2b0n5ZoqBBSOagf3INS8uFYEiKcMyw62nZl6lO0Lq8KR8Nl55d8gQQHJNNeQT/abE3ZibFIlnRCiBkOmIxtSsl313BMbeOstQgmnVLFnE6w4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726269; c=relaxed/simple;
	bh=4ea7wWTwkRtdh2RaDmD6c/QNHMZBnTfz2285rFbBDno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixaDxi9RxgBeiBbKMq3mrrMdvdB6EhZUzmj/Of/igUL7NZkAGq08mzjsSXU6SLal+pdXKfJofdzIl8BQIg6zQdbIv6HRl4fbyoIsA6q+xLevKlJPVdGuebCSaHd4nIpOBQsg9ek84gj0KHhAssBuwTH5sze8vzgPmELJ7FCQB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8XGC5V0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8XGC5V0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42744C4CECD;
	Wed, 23 Oct 2024 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729726268;
	bh=4ea7wWTwkRtdh2RaDmD6c/QNHMZBnTfz2285rFbBDno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8XGC5V0XJeXU+g9Xte4WVZl31AH6fklggPwlyyaXOEX3VPAVpxn8mNbNuPJEsRVG
	 6DHzGrBUCthGxAVmjFZt3BCKswjfKHDwuOWcr60oBl2Xs//BknM09gYuVm56vTvqH3
	 U40BEDk3tei0TCK6rWCFcnF9nQn/vVdvwwus5p3/tev8rUD0SLTua5qnzZlpDIrqTU
	 ceW9J1lqIgrGKN8LXxMAf7RGkXqAmy0fwsdJFYPZFJSuIxJgl8axiLe22tYhWPzbwM
	 Qtp2QUhNZOjHkvEUceMt5AjjBzv2+/EzKxlKRxHASpwdvLo93p7S5znTRnAOEZY4xg
	 YUkPsmacQccGQ==
Date: Wed, 23 Oct 2024 16:31:06 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf test: Skip annotate test for sanitizer builds
Message-ID: <ZxmHOkp1USQCujM-@google.com>
References: <20241022174838.449862-1-irogers@google.com>
 <20241022174838.449862-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022174838.449862-2-irogers@google.com>

On Tue, Oct 22, 2024 at 10:48:38AM -0700, Ian Rogers wrote:
> Symbols vary and the test breaks.
> 
> Closes: https://lore.kernel.org/lkml/CAP-5=fU04PAN4T=7KuHA4h+po=oTy+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/annotate.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
> index 1590a37363de..199f547e656d 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -4,6 +4,12 @@
>  
>  set -e
>  
> +if perf check feature -q sanitizer
> +then
> +  echo "Skip test with sanitizers due to differing assembly code"

I don't think it's because of different assembly code.
It should be the return value from ASAN leak detector.

Maybe we can enable it using "ASAN_OPTIONS=detect_leaks=0"?
Probably with a comment that mentions we don't call
perf_session__delete() in perf annotate for a performance reason.

Thanks,
Namhyung


> +  exit 2
> +fi
> +
>  shelldir=$(dirname "$0")
>  
>  # shellcheck source=lib/perf_has_symbol.sh
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AD2701C4;
	Tue, 28 Apr 2026 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417798; cv=none; b=hIFfPF8vJsO1txGlDstcn5++jO2YQRdT9Aewf0fEHeonwZ52xx7amQveHWopgCTWRI3XrXYDU0TOY2X72I2LZ2jIRM1n4dRlhnRBxA8U2Wbyv2FRNxd/XKqKWqRZN/CwGWMCdUS5wQZMdTzJliv48Xdy4hrNlJ+M1fWqKR7MjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417798; c=relaxed/simple;
	bh=SCBnzVee/BY2ENxe/na7jvTalljuXQiHCcsTT7moBos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7GOkrl0gZPhVqZ0psGg3TrqAaCo/t1E+wIqGaya3aFm/rBKWdGbpaIRLMb0QIIkAK10hDU0g/zO3QqsWvKI73TaAb0foaWTB9bdutkEBRpRakozmWHmo8N8AcD/ntbsetM2eYUpghm8rHkYWMnEiFP3Ft7Ve0qNojVlNYTkSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYOhZNqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYOhZNqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D454AC2BCAF;
	Tue, 28 Apr 2026 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777417798;
	bh=SCBnzVee/BY2ENxe/na7jvTalljuXQiHCcsTT7moBos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYOhZNqtrkg6sbMqWoPEvBeLnq9RxFsf7n0bm5tMdfmz6gfqHs0tUBH8JPKkpaqcJ
	 MCP5wdMniRx1D7ZHBCVArYxKyHNJ2bj8mfzxrgJZwr+ARpWRstTviqFBWLAdAihVUb
	 GzTwCpkHMwoV0ygCKFVVpb8wS6ttFxyfP1j3NzcJ7Q/7ozJz2sfnBzPnWrlYGX9iD2
	 MurqTTkHG84wQOIOAGrDH3YCNdgG0nVpSqG66OmPWORnO9PYVKegXAG8fqarOS4dLA
	 bLzRGQXR4yZcF955rDylSKeVSDVMRt2wDXIFdXx+NsE+91sUlA+0X/b+XXqueNuHvK
	 2mRBO14zhLMcg==
Date: Tue, 28 Apr 2026 16:09:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf: fix some tests for musl
Message-ID: <afE-QzduLVrSaZcO@google.com>
References: <20260428143920.2466185-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428143920.2466185-1-martin@kaiser.cx>

On Tue, Apr 28, 2026 at 04:38:45PM +0200, Martin Kaiser wrote:
> Fix some perf tests for systems that use musl instead of glibc.
> 
> v2:
> - add Namhyung's Acked-by for patch 1
> - stricter flags check for patch 2
> - more generic workload in patch 3
> 
> Martin Kaiser (3):
>   perf test: fix nanosleep check in the ftrace test
>   perf test: fix sys_enter_openat event test for musl
>   perf test: fix "trace summary" test for musl-based systems

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/tests/openat-syscall-tp-fields.c | 5 ++++-
>  tools/perf/tests/shell/ftrace.sh            | 7 ++++---
>  tools/perf/tests/shell/trace_summary.sh     | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> -- 
> 2.43.7
> 

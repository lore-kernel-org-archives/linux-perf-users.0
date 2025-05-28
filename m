Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF62459EA;
	Wed, 28 May 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436593; cv=none; b=rGa+pn5uIMTmqYYWZnf2GaZ8mm/80uuuss/Wcz+MfWd/6V6BszEciOBVvSf0ufcU0Al+BoWQJWJkP9krhbu/xELFcbBpKPnwP1yNJoPgYRfvFOdqhbj/S1ruCPJryUpgctfR3zdSH7sY/qTnE7gEluM4QdQjwCHMB4+AYLVOFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436593; c=relaxed/simple;
	bh=zG58Qfis3MVaxADVC9NvFFiFdyxhDqPETkMDlqepafI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggttLufYTKLzOusnTHB032xOYFNSCE2Qix5JfprofIshqiH7+Ehq9Wk/NzNNjNM5DqYsdFIUDH/u7CUi1YOjDUIuLap1qe6oYZ8OZEu9WI4TS3Gaknv8jUsOZ4+BtjZ2Aq/aFsPHCq4HhHbuPIaHdCmlaKGJl1sbjjYWnl1YtAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3fMib8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3fMib8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB56BC4CEE7;
	Wed, 28 May 2025 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436593;
	bh=zG58Qfis3MVaxADVC9NvFFiFdyxhDqPETkMDlqepafI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3fMib8k5j19SJ1VaOYDiWEju48wR5yrDqs+ASX1wA5cAhU+g7gtiWzPvrKPTASBW
	 VUDKcfu/+Hxm4JmubjLeHeP8RiaPwr97FTx+PkjWDr/QplXqWnt1Aeom1/rf0a1dWz
	 HG1c9RPX9igTHNqkngoSn9mdarEeWFVQvAxg23jGClYeFQOhjgw/M2m9TniTSQ+k56
	 TDDTpm14LhI7yC2M3si2aOzXuErK5HVxt0CNHJNata+AbCrlSIfVmwKM+PKtofsBP0
	 zu6DFtlyfB0mOpXDxhCEIAFmhupX767JhILffKGyMESkRVOr0jbIyjaoREYcgYt6VW
	 CNNKpElrG6NGQ==
Date: Wed, 28 May 2025 09:49:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] perf test demangle-java: Don't segv if demangling
 fails
Message-ID: <aDcGbmJXkLL4TVzC@x1>
References: <20250527180703.129336-1-irogers@google.com>
 <20250527180703.129336-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527180703.129336-3-irogers@google.com>

On Tue, May 27, 2025 at 11:06:59AM -0700, Ian Rogers wrote:
> The buffer returned by dso__demangle_sym may be NULL, don't segv in
> strcmp if this happens. Currently this happens for NO_LIBELF=1 builds.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/demangle-java-test.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied to perf-tools-next,

- Arnaldo
 
> diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
> index ebaf60cdfa99..0fb3e5a4a0ed 100644
> --- a/tools/perf/tests/demangle-java-test.c
> +++ b/tools/perf/tests/demangle-java-test.c
> @@ -30,6 +30,11 @@ static int test__demangle_java(struct test_suite *test __maybe_unused, int subte
>  
>  	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
>  		buf = dso__demangle_sym(/*dso=*/NULL, /*kmodule=*/0, test_cases[i].mangled);
> +		if (!buf) {
> +			pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n", test_cases[i].mangled,
> +				 test_cases[i].demangled);
> +			continue;
> +		}
>  		if (strcmp(buf, test_cases[i].demangled)) {
>  			pr_debug("FAILED: %s: %s != %s\n", test_cases[i].mangled,
>  				 buf, test_cases[i].demangled);
> -- 
> 2.49.0.1204.g71687c7c1d-goog

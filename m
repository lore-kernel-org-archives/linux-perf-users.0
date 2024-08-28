Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736545C1C;
	Wed, 28 Aug 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879948; cv=none; b=cxWNoiOzDAeHFVrBHmcGSycNH4fk2pYFDd7BQy02DFh0ldmbzDxJRin6ft5C3jT/wlLKUwKakjnuQ1YVPu9nIvI4sxUXj8roeMJ0p0G+kJrtb8e753+KQk0qkPBbbJqJjaXYQOhUihB1mz/cEqvY0xoBbRWt2Eb9OCu3UCJU4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879948; c=relaxed/simple;
	bh=HrkBjPqgCHYfB+jdzgRSX9c+dxZURzUSQH5uAg2XuMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrJsBWEtPB+i9UhlBK2ExMiHzXQdUPPBtcZ+Fdb7dZHa3ZCB1flqlTR7+GrENM/McF68UJFvH0ePgFuF7IPFhHCQspIZgi1FTMoGrLB/7JGnhQ4j1LEao1sihk+sLjF5hTx/wdpewKiA7q0SGt71IhJVM0WMcRKgKrkn9q8dU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQBKRUoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQBKRUoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0650C4CEC0;
	Wed, 28 Aug 2024 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724879948;
	bh=HrkBjPqgCHYfB+jdzgRSX9c+dxZURzUSQH5uAg2XuMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQBKRUoQYDvTbhcpQwJevgPvibOi3dk5ny2ajn0AIZsiV40pimr4d33rx33h2yKxa
	 spReKD+IloN9IZczViw9TC0gsJ4x9Fm5IE/0Cd5if1ybe4PrOMW7VFGwzs01NjMDCF
	 zmPVOXY9t7pMYbPXrsecKyZI8aPp3V/Uc+4jMF1DoJORw3ilqMlGIfwAkVoH3Nd2ZV
	 52GZIIqS7AGGyALHrZk3/8K2VZ+grPt0j2SuVKZMD1zw7IRf3AMuhiToq7PmEL5qhp
	 9EoGwVt1aFqTt6ZVXryd9uYC9XcNqbTIM4B9VuCYbghwvAxqivODPdD/ff/GBHQqfC
	 sqO4QGCn7M0Fw==
Date: Wed, 28 Aug 2024 18:19:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test trace_btf_enum: Fix shellcheck warning
Message-ID: <Zs-USNvG5gfxCM2h@x1>
References: <20240809095426.3065163-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809095426.3065163-1-james.clark@linaro.org>

On Fri, Aug 09, 2024 at 10:54:22AM +0100, James Clark wrote:
> Shellcheck versions < v0.7.2 can't follow this path so add the helper to
> fix the following warning:
> 
>   In tests/shell/trace_btf_enum.sh line 13:
>   . "$(dirname $0)"/lib/probe.sh
>   ^--------------------------^ SC1090: Can't follow non-constant source.
>   Use a directive to specify location.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Fixes: d66763fed30f ("perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/shell/trace_btf_enum.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
> index 7d407b52bea5..5a3b8a5a9b5c 100755
> --- a/tools/perf/tests/shell/trace_btf_enum.sh
> +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> @@ -10,6 +10,7 @@ non_syscall="timer:hrtimer_init,timer:hrtimer_start"
>  
>  TESTPROG="perf test -w landlock"
>  
> +# shellcheck source=lib/probe.sh
>  . "$(dirname $0)"/lib/probe.sh
>  skip_if_no_perf_trace || exit 2
>  
> -- 
> 2.34.1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96171D5AB1;
	Thu, 26 Sep 2024 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727310597; cv=none; b=hRdVOgn6N+9jkcN395k8+lmKv+5NntiB9frO9wrDHhihX0U9e9nr/SRP1SjvYRBsopIeQmTNsjw4jJs/7nkorDXYlB0CCDNYqleNstUpam7oYPROgdrcX66r1S7C4jXcCPzC5EzEYRjJGsZVaqmIYqSO1YmrUkOiG5IVTHfgtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727310597; c=relaxed/simple;
	bh=KOs0YfzUNBbk4R1VfRVilY5jzXByg+fGRbcUSjl0HGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUxzjk8EVSWBfzG5HZ8K6EKtE5+HMgS1/kXCjWlfVuRjesDT4VxtCpO47hvAtqPxOI7eIcv9Kl9t2qN2dDcvv2ql947FtxulonDaAttFwUux2QUqqViyVx3czG0x+BDhfiAC/HJzNEIQfhtaWDP10DCO45nJ1WP+ZOAPTvD15eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLomp19u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLomp19u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C29C4CEC3;
	Thu, 26 Sep 2024 00:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727310597;
	bh=KOs0YfzUNBbk4R1VfRVilY5jzXByg+fGRbcUSjl0HGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLomp19uyPvk2F6cfgEi68eE2X+nu+sJREj2zuY2BJM6/pJwX01f+gmNuRuqypJS0
	 lTst5KwqsO1tj53sG5jHQqWrjIU4tGiOM+kkWek6zKhFphCaDabaVmYwYWG6qyRg5+
	 0hzgTSFJJbiShWQHkKhgPiVns3MjLvFRGi3MGdkxY3SqpE1+aebCRLa66QaC+6Te7/
	 8yu3AlY/nP5SUz+LdUhVg6xHCahg1Y+QhJRrxHyKLHFwDyU6NhMj8pXdMsR0PffygG
	 /sAYOwCTC1ctXlQ9zESInbIXjTgaq/4rAejQVTvZ6/5fPcv1Z/t0O1vnjsFfXsZDVp
	 Y8PJd2YnpGLgA==
Date: Wed, 25 Sep 2024 17:29:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Atish Patra <atishp@rivosinc.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 07/11] perf probe: Move elfutils support check to
 libdw check
Message-ID: <ZvSrAv_6NUOVWJdD@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924160418.1391100-8-irogers@google.com>

On Tue, Sep 24, 2024 at 09:04:14AM -0700, Ian Rogers wrote:
> The test _ELFUTILS_PREREQ(0, 142) is false for elfutils before
> 2009-06-13, but that is 15 years ago and very unlikely. Add a test to
> test-libdw.c and assume the libdw version is at least 0.142 to
> simplify the build logic.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/feature/test-libdw.c | 10 +++++++++-
>  tools/perf/util/probe-finder.c   |  2 --
>  tools/perf/util/probe-finder.h   |  2 --
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
> index 71c6f8e3b0ee..2fb59479ab77 100644
> --- a/tools/build/feature/test-libdw.c
> +++ b/tools/build/feature/test-libdw.c
> @@ -41,8 +41,16 @@ int test_libdw_getcfi(void)
>  	return dwarf_getcfi(dwarf) == NULL;
>  }
>  
> +int test_elfutils(void)
> +{
> +	Dwarf_CFI *cfi = NULL;
> +
> +	dwarf_cfi_end(cfi);
> +	return 0;
> +}

I think it's the same as test_libdw_getcfi() and let's get rid of it.

Thanks,
Namhyung

> +
>  int main(void)
>  {
>  	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations() +
> -	       test_libdw_getcfi();
> +	       test_libdw_getcfi() + test_elfutils();
>  }
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 78f34fa0c391..7434b38596b9 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1379,10 +1379,8 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
>  	if (ret >= 0 && tf.pf.skip_empty_arg)
>  		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
>  
> -#if _ELFUTILS_PREREQ(0, 142)
>  	dwarf_cfi_end(tf.pf.cfi_eh);
>  	dwarf_cfi_end(tf.pf.cfi_dbg);
> -#endif
>  
>  	if (ret < 0 || tf.ntevs == 0) {
>  		for (i = 0; i < tf.ntevs; i++)
> diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
> index 3add5ff516e1..f0149d72310c 100644
> --- a/tools/perf/util/probe-finder.h
> +++ b/tools/perf/util/probe-finder.h
> @@ -63,12 +63,10 @@ struct probe_finder {
>  	struct intlist		*lcache;	/* Line cache for lazy match */
>  
>  	/* For variable searching */
> -#if _ELFUTILS_PREREQ(0, 142)
>  	/* Call Frame Information from .eh_frame */
>  	Dwarf_CFI		*cfi_eh;
>  	/* Call Frame Information from .debug_frame */
>  	Dwarf_CFI		*cfi_dbg;
> -#endif
>  	Dwarf_Op		*fb_ops;	/* Frame base attribute */
>  	unsigned int		machine;	/* Target machine arch */
>  	struct perf_probe_arg	*pvar;		/* Current target variable */
> -- 
> 2.46.0.792.g87dc391469-goog
> 

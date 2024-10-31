Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DD1CB316;
	Thu, 31 Oct 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402517; cv=none; b=Ng3qPAzNz7DznJKTWE/jZJTwx12wYrysQ5eeTuyfjExu74MiO0CSBBwTPkjA197AE318TmjVtAfwa2oaXswFksl1pUJwkh/D/yrbPoJ3IxsQqWKf008IpnRs8t7RxBVpVQQQZ2n/O4gHr1dYvzlm4libbBrxAEVV6GCBpNAZhGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402517; c=relaxed/simple;
	bh=W6kgg88zrHCrf22nJfw8tbSKKqNxH1rsErpXBmKqqIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX6/IYPTZCq8UV6e+QU6/fjvzuDQ85JEXu32gE7LHZGfQeWGwMlWI7KgVOL/fE5BZK2h2GwSZ+vr6u3oQGYHR4mdfhZ/in8b3xUUa4SgkrQtqZ8ksMdE+TetFGgtl+r8Fri1uqP6s6lIxdAsjfkwu7tsFBBwyCQ3RUo3nXXdKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0reAsTC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0reAsTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37482C4CEC3;
	Thu, 31 Oct 2024 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402517;
	bh=W6kgg88zrHCrf22nJfw8tbSKKqNxH1rsErpXBmKqqIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0reAsTCzI9m/gsCnevKqHdMu7DPT/h1LRQbt/l7flSGB0zevYA49tibPDwtnK61Q
	 sGgb3eGX4bMhIepY2+I7nwWEOaEQF6ljMqFk7ySH998BW9EVN6fq5pNBOUK96UNm3S
	 UWo25kaCAYCIVRLZJuVuZ4hExMsYegZwNGso5URcjLmwJMdArn3GfJyBxKcWy47aW7
	 N6zLuuwYXM7zVUeGokhnUrdhVM5pIOWgiwE5EAzxNDtAAzbGjVzBdtXBLBSrdd3Kwf
	 qoEdIdMrRAQeiLEZieo0zVk/j3OyincbEp3F3hrJZplNSxNm9fGjifSOQ9MJtb5NQr
	 xCkYg08fRzwHA==
Date: Thu, 31 Oct 2024 16:21:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 17/21] perf build: Remove test library from python
 shared object
Message-ID: <ZyPY0JGMOp25FWm6@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-18-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:48PM -0700, Ian Rogers wrote:
> With the attr.c code moved to a shell test, there is no need to link
> the test code into the python dso to avoid a missing reference to
> test_attr__open. Drop the test code from the python library.
> 
> With the bench and test code removed from the python library on my x86
> debian derived laptop the python library is reduced in size by 508,712
> bytes or nearly 5%.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index ef1b39b5042d..2059f1c4b78d 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -487,7 +487,7 @@ endif
>  EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
>  LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>  
> -PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
> +PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
>  LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>  
>  export INSTALL SHELL_PATH
> -- 
> 2.47.0.163.g1226f6d8fa-goog

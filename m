Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AEF241665;
	Tue, 11 Nov 2025 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844556; cv=none; b=M49wusWdCimJZA8z+OuWnl2YIv66uH5XolNXTBonjYigHuAp7SC6PpxzJjMyOi5PCPYWEjwqTGQ3uW8kWcpzaHHZRmkjHTM6Y4WHjrKiQqcJME+VQIPHZIdd2ItBIkv15G0yr+vQh2jjZPTW5F13jjf0U8nwJKzHzLgwjZiMB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844556; c=relaxed/simple;
	bh=YVQBVaE/9No66SQGg8IqSPubllwiHTVnEzIMPwYrZdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKheKKI3/EfZZ2xn9kBSSD7BUXhfPVqP0/2LKxOfVsSu9M+fnXa/1O0ODUrEEq7H9T6pCwlErFhIY9yeYqyocrc1ojO5L78sFVrq9Do1NjxQVk+ZHdssOV/Yry7qaTQ5zBdqwblUNe0eeZpzSij5aKuj53Xu8Kn1LAAAIwtmacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKQGp870; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKQGp870"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DF2C4AF0B;
	Tue, 11 Nov 2025 07:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762844555;
	bh=YVQBVaE/9No66SQGg8IqSPubllwiHTVnEzIMPwYrZdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKQGp870gQzUpODlgQddhednwzxOFIz+eM7TtpMdeyOJgedXVjhbqufNpUiFN+7iH
	 9QDC2z00bpa9h2F1efTFae+xFKW/0Uy9tacQyv0aF2cza6y48Pwzdew57CE4ugaxec
	 d4BWqhHU/qVBuIcei8NanZUvZZoZ7sCATmOWocvE9WoPEIPo70Zrl4vlp8UvU7Ppap
	 RM2gayWfrmOLoh+qCeCGrdV6/NzWVqpz+V/Uz9ow0b6e4JGzI3ij6pFQgaDfExmMaa
	 IhTQtwwlTsqnjo7nCp9XJwzJQpJoxCMeGMhLP61O0u9oSjzUXM4iOcS5DLPc6B26pT
	 yeARQf3cmW9pQ==
Date: Mon, 10 Nov 2025 23:02:33 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v3 07/18] perf stat: Remove hard coded shadow metrics
Message-ID: <aRLfiZ4MCBZJGUlz@google.com>
References: <20251111040417.270945-1-irogers@google.com>
 <20251111040417.270945-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111040417.270945-8-irogers@google.com>

On Mon, Nov 10, 2025 at 08:04:06PM -0800, Ian Rogers wrote:
> Now that the metrics are encoded in common json the hard coded
> printing means the metrics are shown twice. Remove the hard coded
> version.
> 
> This means that when specifying events, and those events correspond to
> a hard coded metric, the metric will no longer be displayed. The
> metric will be displayed if the metric is requested. Due to the adhoc
> printing in the previous approach it was often found frustrating, the
> new approach avoids this.
> 
> The default perf stat output on an alderlake now looks like:
> ```
> $ perf stat -a -- sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>              7,932      context-switches                 #    281.7 cs/sec  cs_per_second
>              TopdownL1 (cpu_core)                 #     10.3 %  tma_bad_speculation
>                                                   #     17.3 %  tma_frontend_bound
>              TopdownL1 (cpu_core)                 #     37.3 %  tma_backend_bound
>                                                   #     35.2 %  tma_retiring
>              5,901      page-faults                      #    209.5 faults/sec  page_faults_per_second
>        418,955,116      cpu_atom/cpu-cycles/             #      0.0 GHz  cycles_frequency       (49.77%)
>      1,113,933,476      cpu_core/cpu-cycles/             #      0.0 GHz  cycles_frequency
>                                                   #     14.6 %  tma_bad_speculation
>                                                   #      8.5 %  tma_retiring             (50.17%)
>                                                   #     41.8 %  tma_backend_bound
>                                                   #     35.1 %  tma_frontend_bound       (50.31%)

I'd like to merge the alignment fix for this.

https://lore.kernel.org/r/20251106072834.1750880-1-namhyung@kernel.org


>         32,196,918      cpu_atom/branches/               #      1.1 K/sec  branch_frequency     (60.24%)
>        445,404,717      cpu_core/branches/               #     15.8 K/sec  branch_frequency
>                235      cpu-migrations                   #      8.3 migrations/sec  migrations_per_second
>     28,160,951,165      cpu-clock                        #     28.0 CPUs  CPUs_utilized
>        382,285,763      cpu_atom/cpu-cycles/             #      0.4 instructions  insn_per_cycle  (60.18%)
>      1,114,029,255      cpu_core/cpu-cycles/             #      2.3 instructions  insn_per_cycle
>          1,768,727      cpu_atom/branches-misses/        #      6.5 %  branch_miss_rate         (49.68%)
>          4,505,904      cpu_core/branches-misses/        #      1.0 %  branch_miss_rate
> 
>        1.007137632 seconds time elapsed
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c    |   1 -
>  tools/perf/util/stat-display.c |   4 +-
>  tools/perf/util/stat-shadow.c  | 392 +--------------------------------
>  tools/perf/util/stat.h         |   2 +-
>  4 files changed, 6 insertions(+), 393 deletions(-)

Nice work!

Thanks,
Namhyung

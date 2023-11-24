Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrY8nM7t"
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A87D59;
	Fri, 24 Nov 2023 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sZ2n5kJr0I8EW9IHtq/ppoCQzkJzXCFITxFVQG51leA=; b=UrY8nM7tzzYrO+J1quhqWmDI62
	a4qKLYgw0nxQI9wq9hdcvc8bEMvs+BEWQdT1ffr7xcwsXmSDZQ4XJ+nJ7kC7g+F1fsWOJYigUy1Uy
	5ACkjxB0q9mz1QPtTG43GmvCD2BUubBdfRTEGagnnCDFeIMBESQXJXAv0s0ONNcKeGOUV1ZYv3lT1
	8u6KRlqCbMjmN8lNk5X4lUQnJ9qeqVadq5LoIn6qdbZtJe2zyGfMbCOd3bm84ukjZHcrZOxQ4fUd3
	qHt8jlB5zgMV1XsUcJv64sT6iWBLNHx/dCPuFqQSmAYUfwzUYVmKy/1dh0f5mF+8La9uq5lbpSCf4
	IfNqdqqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r6SsC-00Dpus-27;
	Fri, 24 Nov 2023 09:55:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 045F1300134; Fri, 24 Nov 2023 10:53:20 +0100 (CET)
Date: Fri, 24 Nov 2023 10:53:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sean Christopherson <seanjc@google.com>, Li Dong <lidong@vivo.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf lock: Fix a memory leak on an error path
Message-ID: <20231124095319.GN3818@noisy.programming.kicks-ass.net>
References: <20231124092657.10392-1-zhaimingbing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124092657.10392-1-zhaimingbing@cmss.chinamobile.com>

On Fri, Nov 24, 2023 at 05:26:57PM +0800, zhaimingbing wrote:
> if a strdup-ed string is NULL,the allocated memory needs freeing.
> 
> Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> ---
>  tools/perf/builtin-lock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index b141f2134..086041bcb 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2228,8 +2228,10 @@ static int __cmd_record(int argc, const char **argv)
>  		else
>  			ev_name = strdup(contention_tracepoints[j].name);
>  
> -		if (!ev_name)
> +		if (!ev_name) {
> +			free(rec_argv);
>  			return -ENOMEM;
> +		}

Isn't this an error path straight into exit?

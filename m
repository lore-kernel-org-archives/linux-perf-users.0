Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B511BC41
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616720; cv=none; b=WozCfd75x7rH8EiLrMKyYjj/pipW8DRnrxqd8ostKK933ayBb1KWCc1af6DRBmo06YU+5nMx/s5RXfA239Hc28dYHsCmO1y73OpiXzEgq88soWLaRwm++yKzXd/a4UofYQEV08L8+Ifh4yGJ26XGVkgsBPnMT9Z9xTke1HIlnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616720; c=relaxed/simple;
	bh=pH+Tus83erUr+DDFNhkjgnullp4lB8TbGlhmy3hKBVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9pNaYDtBEQUQYQyvBURayKb2HJjMQPqDXn5EoRtiNeG4oEJE2iU0pu0Df31WZ+6RpLBLYrAhCs/t0hXrMqxjeHis5tJdnmz8tb35ho2nvUV1gPvXzlcCPdbw+VYLbgYyJ0/UPr+q8s5UxbKSeLUrGG5qo+Jf51w8+Y3emedSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1cnCKTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1cnCKTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0C8C4CEEC;
	Thu, 27 Feb 2025 00:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740616720;
	bh=pH+Tus83erUr+DDFNhkjgnullp4lB8TbGlhmy3hKBVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1cnCKThxchj7yhzswvyKGZkpy4HNrdzezSEwQQuWH6FX377VszAlVHMLiDeKYHtQ
	 tFiAxFZuNRqg5tBvkXXkqGl9vUGEPvgB9n49A5MSbECN25EDI5krLzZ5fTsDAc/6pA
	 TRvl2gHASGv3Tg7/kdD3hzGjOWo0wKMv7rUiDRn35JUpJFoLhQ9kySpIY9w69KhyN+
	 JDw4hfKGOs6FwDbIXX+J7pzCKy/YqMFdOOrVzQZSOUkZJqcmVyCS+VqC8LVlonE6b7
	 fPFAjkke7fAnQAz3MPbHAvqKByuwNVXA31mR1eUdwW94afYJ2tZY3kpS+t/r7MYlQz
	 d8z06fOnwWjOQ==
Date: Wed, 26 Feb 2025 16:38:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com,
	Tejas.Manhas1@ibm.com
Subject: Re: [PATCH] tools/perf: Use perf_tool__init() to initialize default
 values in builtin trace
Message-ID: <Z7-0DuisrMHyscDj@google.com>
References: <20250225113157.28836-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225113157.28836-1-atrajeev@linux.ibm.com>

On Tue, Feb 25, 2025 at 05:01:57PM +0530, Athira Rajeev wrote:
> Perf trace on perf.data fails as below:
> 
> 	./perf trace record -- sleep 1
> 	./perf trace -i perf.data
> 	perf: Segmentation fault
> 	Segmentation fault (core dumped)
> 
> Backtrace pointed to :
> 	?? ()
> 	perf_session.process_user_event ()
> 	reader.read_event ()
> 	perf_session.process_events ()
> 	cmd_trace ()
> 	run_builtin ()
> 	handle_internal_command ()
> 	main ()
> 
> Further debug pointed that, segmentation fault happens when
> trying to access id_index. Code snippet:
> 
> 	case PERF_RECORD_ID_INDEX:
> 		err = tool->id_index(session, event);
> 
> Since 'commit 15d4a6f41d72 ("perf tool: Remove
> perf_tool__fill_defaults()")', perf_tool__fill_defaults is
> removed. All tools are initialized using perf_tool__init()
> prior to use. But in builtin-trace, perf_tool__init is not
> used and hence the defaults are not initialized. Use
> perf_tool__init() in perf trace to handle the initialization.

Thanks for fixing this.  I can reproduce the problem and confirmed this
patch fixed it.

Thanks,
Namhyung

> 
> Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
>  tools/perf/builtin-trace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f55a8a6481f2..092c5f6404ba 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4589,6 +4589,7 @@ static int trace__replay(struct trace *trace)
>  	struct evsel *evsel;
>  	int err = -1;
>  
> +	perf_tool__init(&trace->tool, /*ordered_events=*/true);
>  	trace->tool.sample	  = trace__process_sample;
>  	trace->tool.mmap	  = perf_event__process_mmap;
>  	trace->tool.mmap2	  = perf_event__process_mmap2;
> -- 
> 2.43.5
> 

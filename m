Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791F1D0164;
	Fri,  8 Nov 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056434; cv=none; b=PbJmdvvDglfk5DljqzxBgTzSD8lxYQmGasENN+YOSVDDUcurm0N4MU4Oryrqga+OCsVm4zJ382iNi3J+49eKRCZcp0n2jYqB/7D1VqNU4ueXfkncSkvcfoUkSanhXE/CdKk1kNp+GlD7bRcBRXenNkR49l4apNbEPd+YF01F2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056434; c=relaxed/simple;
	bh=CrWKUfftFBZ+wGLTC10F8LpLBdIyBX00HenmHhZlwc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFEqJb7qXgzOmykKvHMwIwX07NNPlYGIR/lZmPtb/LDGMk8dYHbl7KZG4rvj1EEAvGESkFW83aIrRLMC27e3ITGkHQOi9a9uoeaJWzhC11BYIxSEDu1ri1PdpMn55NdknFO3KJ39pvWromNULrGBdSotmTvv+D9ibPaqqSWiG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d8lDBsz+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8lDBsz+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q0aUDxAYn5YeExddRWD2diDvkGNWUz6lbURBYyNRMws=; b=d8lDBsz+T3r5iY9iWi9iHdiJS/
	vzyM6gIJSbD8yWA0s2Pq+V1KM7rOb1uTvN05cMFQ6SmM6EpuBqroelhIRqt9B5X/h39XvfgvKaTjN
	GU0KRleG1AEcgJL+YWeQus5WurpdDX0YqXVlIjvgSxxwmYya11pojSo9M01GTtFQraYsVq/FYrCC0
	sLB4EnSDYVQI57F2KIvCtYFGP4OJofwY93GXlLW83yPcaiCEHsjdhWXigs7915XeMTtIABOaRT0ds
	JDQUWB1e+OiRV/JOlHFo4Xu6jYneDSnB3jRiDcvxlpborQ4DBj6s++WzG0uDLKWU0WdfPINOChc4V
	bMQtGiEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Kqt-00000008awS-2qSz;
	Fri, 08 Nov 2024 09:00:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2E6230049D; Fri,  8 Nov 2024 10:00:23 +0100 (CET)
Date: Fri, 8 Nov 2024 10:00:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] uprobes: get RCU trace lock before list iteration
Message-ID: <20241108090023.GE38786@noisy.programming.kicks-ass.net>
References: <20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-rcu_probe-v1-1-0ca8cc2dedfb@debian.org>

On Thu, Nov 07, 2024 at 09:14:45AM -0800, Breno Leitao wrote:
> Acquire RCU trace lock in filter_chain() to protect
> list_for_each_entry_rcu() iteration, protecting the list iteration in a
> RCU read section.
> 
> Prior to this fix, list_for_each_entry_srcu() was called without holding
> the required lock, triggering warnings when RCU_PROVING is enabled:
> 
> 	kernel/events/uprobes.c:937 RCU-list traversed without holding the required lock!!
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
> ---
>  kernel/events/uprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index fa04b14a7d72353adc440742016b813da6c812d2..afdaa45a43ac3948f7983175eda808c989e8738a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1103,11 +1103,13 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
>  	bool ret = false;
>  
>  	down_read(&uprobe->consumer_rwsem);
> +	rcu_read_lock_trace();
>  	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {

Maybe I'm confused, but isn't uprobe->consumer list protected by
uprobe->consumer_rwsem, which we hold for reading?

That is, AFAICT this is a false positive and we should be doing this
instead, no?


diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a76ddc5fc982..a5405e9ef9f5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1104,7 +1104,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
+	list_for_each_entry(uc, &uprobe->consumers, cons_node) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;

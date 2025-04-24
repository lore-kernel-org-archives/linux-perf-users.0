Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7627F744;
	Thu, 24 Apr 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512651; cv=none; b=dP9+OTveUWVZU6wjTf7gioOff+2HVymo7YjA7NTApH9s+DgRceAiGcIVdJ+ubMheoPpe9vFADpaS7X9lExYeF7ydzP4DzIo/4dOrHCI+4TUlgQgezXJGdL8vxueUZUqKgcu1MYJ7Z+7/sRlFWLJ2irKOVYx/EX/VefmYChGq7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512651; c=relaxed/simple;
	bh=xhr2a8AwpaqE5j0/f32s3QrVCU8rwIewFtPY9Nnv0Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io4cqZegCfqbmGdLeKMYQvWKCZH1o67S0ct75WtftR5bi83RK2Hin/vUlKi5CPqDoaNmgn/f8nXWy8VZXFSUS/j1xzQFmUybPFvya6dMyYht2ho4t5QPORpLVASfeSTcezxMBHAR3M8UNMSST0MJHT9wLlCGgwXj160Rr3gSGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P9n041dc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9n041dc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YAzzQLLXII5R5x17zi222iI6n4jQgEmopQhiOBoIlFs=; b=P9n041dc30TI4LI9TmiPgx9/u1
	CJyPi4QhNuJ3XIsTn5L3l3Pq7qW/np+pZZbTvbKqO8LRE4vL1I+olS1feJx1ZbTd7dGszGkjxjnhY
	0PmzgE2uh4if6NeHmO7mMMeXSP9mFLI6Zo6hyNfINVgBHiMsnTGtPskNNkmwvafjWwaq3X2Kcc1Qy
	7t/w85rItBl61+P1cQVL65D5zxXBMa9oSRxpx++HA7l97MX4dl+DYFUDnpM+GfujevUPVQZxcMWlN
	yb3JQgAWzgvgVuW5lGaHOL0GjgOrv6t3hoojtccJczSgq7ikPT9BfkMLodfotZMWj8JDd0XKdS4HZ
	3YcX1xvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7zZe-0000000BrS6-2d1P;
	Thu, 24 Apr 2025 16:37:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 356B6300642; Thu, 24 Apr 2025 18:37:18 +0200 (CEST)
Date: Thu, 24 Apr 2025 18:37:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 12/17] perf: Skip user unwind if !current->mm
Message-ID: <20250424163718.GF18306@noisy.programming.kicks-ass.net>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.216110813@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424162633.216110813@goodmis.org>

On Thu, Apr 24, 2025 at 12:25:41PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> If the task doesn't have any memory, there's no stack to unwind.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Note from v4: https://lore.kernel.org/all/24cde1381495cd637f0d5663ab7629572bc0eca6.1737511963.git.jpoimboe@kernel.org/
> 
> - From the previous version, Peter Zijlstra brought up concern about
>   io_uring helpers, but this was never resolved. No update was made.

What is there to resolve? If you want to check for kthreads, don't check
for ->mm

> 
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 009f34bd9e63..40b98b05fb7c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8101,7 +8101,7 @@ struct perf_callchain_entry *
>  perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  {
>  	bool kernel = !event->attr.exclude_callchain_kernel;
> -	bool user   = !event->attr.exclude_callchain_user;
> +	bool user   = !event->attr.exclude_callchain_user && current->mm;
>  	/* Disallow cross-task user callchains. */
>  	bool crosstask = event->ctx->task && event->ctx->task != current;
>  	const u32 max_stack = event->attr.sample_max_stack;
> -- 
> 2.47.2
> 
> 

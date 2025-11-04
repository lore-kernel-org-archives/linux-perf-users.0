Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79631B114;
	Tue,  4 Nov 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263462; cv=none; b=BAz0L8Ln/R4aODJdG4hHwDNdowjDZFYdnA14YF+U63xG6AjNy5fWDLeN3QRyQct6wBjBSFLSCZQh/QqRonB25Ti/C0/ua1iP5Zd5PNOc3KJdYPyuNrT9mrYHeCgl7MIY8mUuoMdGnx2COlMusjbLUx1golN5EoyaS4P946z+nSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263462; c=relaxed/simple;
	bh=kW/ssnpFqsyUGVSW+ike0uQYSm2DE4pa7UTDsdKBjsY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WTk18r90Q3wK7I4HVozoFtQTmsgksoDORSCT9sPpX7iG7WNB3QJyXe7gFS4R0F4zZg4TmLIYAOEt3w7yzcQOg1rvh8sHwluLjH1QBu0bmhS2HvSPrKguLh86LgAAaic9WKxbBrXoMwZ9AOYpEDrgSyNNlkh3hcckEyNEX2IXC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoAZWgcd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoAZWgcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FB0C4CEF7;
	Tue,  4 Nov 2025 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762263461;
	bh=kW/ssnpFqsyUGVSW+ike0uQYSm2DE4pa7UTDsdKBjsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MoAZWgcdVfAiKGcImcD9LaLKF/jODEq4BpZLVVjxmTyMzJYQoHekfdrzqPDexT/kz
	 SINX5UNQfnuV10UlpeRkELACz3eBqcW26FdLPGKgSzMEpqCUIPn44jBlxef8YsIx0S
	 JOf1dhtBWvuZADG4ioasi8YQmVOHse0RQPRRRDqsyihs5zhgO+OFdwSU22kCur6hcr
	 RzC7VoPGTFvifLua0W8BJ6uAFh+1RR9/zkxGdd9iZ3mtnrTr14i0Sp0YwdYDuQPxsc
	 OIWMuySlXsUpKE23viueJZ0lKTpvpp7GHRi9vq/8cbGEJ7s8E3AQGOqJhEE+bmTD5t
	 uePtyfGV+h1Xg==
Date: Tue, 4 Nov 2025 22:37:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] tracing/wprobe: Fix to avoid inifinite watchpoint
 exception on arm64
Message-Id: <20251104223735.4164f224790ea0aea267dff1@kernel.org>
In-Reply-To: <176179481538.959775.12326313742393696258.stgit@devnote2>
References: <176179481538.959775.12326313742393696258.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Gently ping.

There is a bugfix (or strange behavior) on arm64 hw breakpoint but
to fix it cleanly, it should change the perf itself (but I'm not
sure why arm64 changes the behavior only for the default overflow
handlers.) Anyone knows it?

Thank you,

On Thu, 30 Oct 2025 12:26:55 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here are patches which fixes a wprobe bug reported by Mark Brown on
> arm64[1]. The root cause was that the infinite watchpoint exception on
> the same instruction, because arm64 watchpoint exception happens before
> the memory access has done, it needs to configure a single-step after
> calling overflow handler. It does that only for the default overflow
> handlers, and not for custom overflow handler registered via
> hw_breakpoint interface.
> 
> [1] https://lore.kernel.org/all/aPvwGhMBJqMKcC9D@finisterre.sirena.org.uk/
> 
> To fix this issue, this series introduces default_overflow_compatible
> flag in the perf_event and use it for identifying default overflow
> handlers instead of checking handler functions everytime[1/2], and
> set it in wprobe[2/2].
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       perf: Introduce default_overflow_compatible flag
>       tracing: wprobe: Make wprobe_handler default overflow_handler compatible
> 
> 
>  include/linux/perf_event.h  |    9 ++-------
>  kernel/events/core.c        |    2 ++
>  kernel/trace/trace_wprobe.c |    7 +++++++
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

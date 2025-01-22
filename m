Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BE17C220;
	Wed, 22 Jan 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556164; cv=none; b=sHccKf9+oeRKq/wa3o2Et8WFA1SB3X3lA7c0JvJRgey9HwwKT/EIfTfRPt0iFkwMtfjwraL+WfLn7QhwmnAr11CfxMIqRXWpGrivmnizGG+kwGmqntDw7jFpfd1LUMXDNZPT9Jri6SqyOrMN8yNJQb3XREVnDHvn1RQKuhR7Fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556164; c=relaxed/simple;
	bh=/QuYLbMciNEg112Hi88iTqqGzv/UzhiCzj7dIYKIK18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIksbmWao8TWnocNFcau4Yy5azzcMvP2NSeNPbdIhpvQvqA4+x5OyinPRt97guhCZ5pz0l8LQt9aQWI+EukWQHBGmVQlsS8VtHcmAlI/kCr9RTtfrdAcjFJPWRFZJt66HZB1gHrs8wmt8J5N4ZuRU23cKqfxYKajgjh6a8h69xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mO9cj4uo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mO9cj4uo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZgcuTvass36SWvQtsw+fq8x9uNnHa1v6uA9BfphBvpQ=; b=mO9cj4uoYr3kyd3P/pQbCr+arT
	4jLLlCXHempAhR4UekM/APJDlZMvzTdSFQ6d8RGRHn/bdFyplTzzrslE6WobYWQzaHqjHpZzEQpq4
	LPJyU5lmc8An/A8MnyDqv1msJWYICAKspg2ghltVjMQF4c241eifYyqNHa1L+s8k8qTFrbOCS6Tum
	pPKwkVom8N22t76TqEggKjlOWjYkUdN/fb9y0J6md/bVFd9MVYyQNqEEZz/HaNoHQLw9Ke6FpAphM
	6jxU8OAX/7V5ukzFRopDExyuHQQcrLcyL0nKflmlCMH+QqeDMpzU3Rw3fwBfCx9RcHmz2R+rxl22O
	OH3ZdqIg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tabjC-0000000DacE-47QY;
	Wed, 22 Jan 2025 14:29:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8875D300599; Wed, 22 Jan 2025 15:29:10 +0100 (CET)
Date: Wed, 22 Jan 2025 15:29:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 34/39] perf: Skip user unwind if !current->mm
Message-ID: <20250122142910.GW7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <24cde1381495cd637f0d5663ab7629572bc0eca6.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24cde1381495cd637f0d5663ab7629572bc0eca6.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:31:26PM -0800, Josh Poimboeuf wrote:
> If the task doesn't have any memory, there's no stack to unwind.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 99f0f28feeb5..a886bb83f4d0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7792,7 +7792,7 @@ struct perf_callchain_entry *
>  perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  {
>  	bool kernel = !event->attr.exclude_callchain_kernel;
> -	bool user   = !event->attr.exclude_callchain_user;
> +	bool user   = !event->attr.exclude_callchain_user && current->mm;

What about things like io_uring helpers, don't they keep ->mm but are
never in userspace?

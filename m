Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C927CB2E;
	Thu, 24 Apr 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512745; cv=none; b=d0fa9vgg+Cr2NW8g29e/WOEErNW7J04VIn3MIEIrvtIswftlxck9NMCT7k4jqzU/MVIGDgFexVSf0P0JWe8QSYbITMMQGg09sqvBp5Tq+3eFFgwrE3lWocpK+KoRfSzN3brRgbosbDgJMJmDUAjk7U9uWfYxEyalSKjUgOvrF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512745; c=relaxed/simple;
	bh=r0QQ5oF6Kungb5ZMRyOmpC1ZNPxQ/OH8ya8HhDekB94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5iMcIG31jF5Hleya2BDtX30hrqEPEKAw0TngPmNcCFhsiCkvVqRGEqHcUuoWdW2wJdCYUuWvfKDh1nCl0fY5gwKIiq1RMJxLjUyE8ZkXadAest+stYzMaF9iI787mNOyDAnzKkVw0Q3vNVVlmeIRwHeBpEb40IKuD7ZY0UJ/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dkAVhItV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkAVhItV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jOXSDfaCatZZ/ECtwwXhcFjaGO043FL06Kl+mmAkYK4=; b=dkAVhItVcz/8gMYe5/eg3TLB7U
	JFrOdF/fwYfxE7Ei1n2F8zIlWbZQOJ+g2bSUijaA6FfEo8Uv4W51eiOpt+cwpQhffVJ6zvhMLHAHW
	xAXdG7JpyEIdr3aZbqcD2jDWfkQd8/4/qdWh900iwSJCNW8Oz1GrYsrZ4EVZJA4YZ2ic8pRCEtAq5
	/Md00G0vDfpHlVRMYQCB1XeCvsR1p4gOKLcdU3arWNRQesF6S9N0PFIpM65TXd5aslW638SE/NGPl
	0vaNSxnTst+d2hnq74U9hjZ1rzVy2zE8LS855fyysc6oJNl4/kR6dTzX3TKSMaU/Kg7hRBqkrh5gG
	dDVsHkCA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7zb3-0000000Cqzk-31Aq;
	Thu, 24 Apr 2025 16:38:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 49848300642; Thu, 24 Apr 2025 18:38:45 +0200 (CEST)
Date: Thu, 24 Apr 2025 18:38:45 +0200
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
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <20250424163845.GG18306@noisy.programming.kicks-ass.net>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424162633.390748816@goodmis.org>

On Thu, Apr 24, 2025 at 12:25:42PM -0400, Steven Rostedt wrote:
> +static int deferred_request(struct perf_event *event)
> +{
> +	struct callback_head *work = &event->pending_unwind_work;
> +	int pending;
> +	int ret;
> +
> +	if (!current->mm || !user_mode(task_pt_regs(current)))
> +		return -EINVAL;
> +
> +	if (in_nmi())
> +		return deferred_request_nmi(event);
> +
> +	guard(irqsave)();
> +
> +        /* callback already pending? */
> +        pending = READ_ONCE(event->pending_unwind_callback);
> +        if (pending)
> +                return 1;
> +
> +        /* Claim the work unless an NMI just now swooped in to do so. */
> +        if (!try_cmpxchg(&event->pending_unwind_callback, &pending, 1))
> +                return 1;
> +
> +        /* The work has been claimed, now schedule it. */
> +        ret = task_work_add(current, work, TWA_RESUME);
> +        if (WARN_ON_ONCE(ret)) {
> +                WRITE_ONCE(event->pending_unwind_callback, 0);
> +                return ret;
> +        }
> +	return 0;
> +}

You have whitespace issues ...

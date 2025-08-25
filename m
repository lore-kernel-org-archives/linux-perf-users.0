Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A72E1F1E;
	Mon, 25 Aug 2025 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120346; cv=none; b=Ftm2itFiz0vVYg6Py5FZcJD0wjjQ+OM+jFIfDNJm/ZcGWWnxRix/cvjeqbcpUG6Q0MzffEYFRmOlTYwFNxpYdzKVRlEoczE8alBdzj8wVkaBXPyB2dDkAineJ+DZt5fb4hxFNmp5/8mlQjxbQoQiW4B4vSJzUKDjOo7ZaARHaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120346; c=relaxed/simple;
	bh=OFLnYyUEJ3JuO+oUr4XR+6EkX2YtC3G9xR4CRvONhZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIg/k09tRZuJiY1ijmOLidYijj5puBo56lDeibuhpM8jkRNhNMTFUWWVVsEQu7WQAjhSKVddbnsxNKcj5JbjUdLRBw+C9yAHqJ95QjNu8sruShXPkTSkmuikmDJgC+of8xeA7R3g/Bm2EHyxAzhbkSB+yyk+fLrF7gaz0JrIfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=APHgAKoM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="APHgAKoM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=inLUygxQrBlOcBVJAiumzESRvN7gkOLTGHKSL79Rhuk=; b=APHgAKoMN6/Ku+Qj1mEKSJA+WR
	eI6hK0zQ7DeKgOns41W8583oUEDYdEm/jtMT/08+aqkAAjeS+HpE5PDZxRxXcFwoG9sBNiHoVugDP
	B6epWr5Y1z7yVS0kTN8IUQLI3NQBLIviXmh/CUAlTlEetLNUmxLaOl9cg15ZO7+GzvFTW0c3iMab7
	/k0yMckdqxD8DUrdLw6u7mWEOVq4d71ytyJjdRpULfR3ZkUWAdIMU2sqdUZ+rydZVJduzMFK4eE1L
	8XAox8OEAc0elaQouUPiTc5zzyHfXhbAE6GjzjJF6cWF+juLpCTgBfsuTm26Nc2+Y72SXKL0yMEpW
	XS2unchA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqV7W-00000001oVJ-38a5;
	Mon, 25 Aug 2025 11:12:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6A8C3002ED; Mon, 25 Aug 2025 13:12:13 +0200 (CEST)
Date: Mon, 25 Aug 2025 13:12:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND][PATCH 0/5] perf: Clean ups and simplifications
Message-ID: <20250825111213.GV3245006@noisy.programming.kicks-ass.net>
References: <20250820180338.701352023@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820180338.701352023@kernel.org>

On Wed, Aug 20, 2025 at 02:03:38PM -0400, Steven Rostedt wrote:
> 
> This is a resend from: https://lore.kernel.org/linux-trace-kernel/20250717173125.434618999@kernel.org/
> 
> It cleanly applied on top of the latest tip/perf/core:
>   448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")
> 
> The ongoing work to support sframes[1] in the kernel required a few clean ups
> to the perf kernel side. Instead of having these changes in the ongoing
> work, there's no reason they cannot be applied now.
> 
> These are just clean ups to the perf code to help simplify the updates that
> will be made later.
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250708020003.565862284@kernel.org
> 
> 
> Josh Poimboeuf (4):
>       perf: Remove get_perf_callchain() init_nr argument
>       perf: Have get_perf_callchain() return NULL if crosstask and user are set
>       perf: Simplify get_perf_callchain() user logic
>       perf: Skip user unwind if the task is a kernel thread
> 
> Steven Rostedt (1):
>       perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL

Thanks!

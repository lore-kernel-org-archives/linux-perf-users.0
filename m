Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89841B3948;
	Thu, 23 Jan 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737675288; cv=none; b=aoQaymrp7uaZjjJ/F5sxVnKiv851sGqJ2AyTtAgUaGj/YxONC8wPDcBaPvPaQ8ZVi8pOuzkjXNcA88tQ4VIUyqNjINzjD5r9zWEGGhrSNncg2KjhqkyHc3uke3N+vf11A6sFwFtHFJ8E0TQu4QywXMRqRvJy1bUS54UX/kjnM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737675288; c=relaxed/simple;
	bh=wltKtIfT/TCDwXyqaM/kVHw+sjdWjy2b3K+3XwkPwvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i37APGCGsVBB58oT5DXFTmn1fZ/zz3XTFZk3barDc5uOfRGPGvkaZ7a9Uen7ndpSDTfsvQ3yl8WepOW1cE1DPKJGsEpNZrX0TO30LbSqgiA0HWhfc/cpHniuh4OWwuw5jyMmCHYW70kI5BJB2gzAUjW2yC6As6aGPD8tP2dMxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td7iJcvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td7iJcvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456F3C4CED3;
	Thu, 23 Jan 2025 23:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737675288;
	bh=wltKtIfT/TCDwXyqaM/kVHw+sjdWjy2b3K+3XwkPwvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td7iJcvlHx3Mo9I/quWKQjNsyRBBwa0p8+r9vK/pejEgXCD07CHX5YaYXUob+Q1ul
	 e/7fen+rXZu/iQz8ZCXNt2KkLV/+yWR2uRoo42fzY7Bjp8ZYp2wF4ctO1kmak7Y6Kv
	 aTAvS6/iv2IO7YkYVjOfEvqY3hTEAqxN04HT8sbWmwsOiRbRPZQNVfog5rhOZwnPYn
	 xPQ7EwiB7YU+GEsYUqlDw/MEE5ldAjfCLv+d1geJVq9DT77qdjbPMVpxD5p+3mnVu7
	 ySHqaPh/DUrxJObIishUm2/tpP9u5zz115qyXZzJWUmDN7Rqc44s2Xhwlv4qricQWK
	 RhYrAMdZv6WRw==
Date: Thu, 23 Jan 2025 15:34:45 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v4 30/39] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250123233445.qhgb76tj7tjiqagj@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <4ea47a9238cb726614f36a0aad2a545816442e57.1737511963.git.jpoimboe@kernel.org>
 <20250122141505.GT7145@noisy.programming.kicks-ass.net>
 <20250122224902.hhpmhi7r3azz3a4x@jpoimboe>
 <20250123084026.GF3808@noisy.programming.kicks-ass.net>
 <20250123194807.2mn54dsk2ef5i4iy@jpoimboe>
 <20250123221734.GE969@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123221734.GE969@noisy.programming.kicks-ass.net>

On Thu, Jan 23, 2025 at 11:17:34PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 11:48:07AM -0800, Josh Poimboeuf wrote:
> > > > > 	cookie = READ_ONCE(current->unwind_info.cookie);
> > > > > 	do {
> > > > > 		if (cookie)
> > > > > 			return cookie;
> > > > > 		cookie = ctx_to_cookie(cpu, ctr+1);
> > > > > 	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie, cookie));
> > 
> > Should not the 2nd argument be &zero?
> 
> This I suppose
> 
> 	cookie = READ_ONCE(current->unwind_info.cookie);
> 	do {
> 		if (cookie)
> 			return cookie;
> 	} while (!try_cmpxchg64(&current->unwind_info.cookie, &cookie,
> 				ctx_to_cookie(cpu, ctr+1)));

Here's what I have at the moment.  unwind_deferred_request() is vastly
simplified thanks to your suggestions, no more NMI-specific muck.
work->pending is replaced with work->cookie so the task work can use it
in case it crossed the cookie-clearing boundary (return-to-user with
IRQs disabled).

static inline bool nmi_supported(void)
{
	return IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG);
}

/*
 * Read the task context cookie, initializing it if this is the first request
 * since the most recent entry from user.
 */
static u64 get_cookie(void)
{
	struct unwind_task_info *info = &current->unwind_info;
	u64 ctr, cookie, old_cookie = 0;
	unsigned int cpu;

	cookie = READ_ONCE(info->cookie);
	if (cookie)
		return cookie;

	guard(irqsave)();

	cpu = raw_smp_processor_id();
	ctr = __this_cpu_read(unwind_ctx_ctr);

	cookie = ctx_to_cookie(cpu, ++ctr);

	/* Make sure the cookie is non-zero. */
	if (!cookie)
		cookie = ctx_to_cookie(cpu, ++ctr);

	/* Write the task cookie unless an NMI just now swooped in to do so. */
	if (!try_cmpxchg64(&info->cookie, &old_cookie, cookie))
		return old_cookie;

	/* Success, update the context counter. */
	__this_cpu_write(unwind_ctx_ctr, ctr);

	return cookie;
}

/*
 * Schedule a user space unwind to be done in task work before exiting the
 * kernel.
 *
 * The returned cookie output is a unique identifer for the current task entry
 * context.  Its value will also be passed to the callback function.  It can be
 * used to stitch kernel and user stack traces together in post-processing.
 *
 * It's valid to call this function multiple times for the same @work within
 * the same task entry context.  Each call will return the same cookie.  If the
 * callback is already pending, an error will be returned along with the
 * cookie.  If the callback is not pending because it has already been
 * previously called for the same entry context, it will be called again with
 * the same stack trace and cookie.
 *
 * Thus are three possible return scenarios:
 *
 *   * return != 0, *cookie == 0: the operation failed, no pending callback.
 *
 *   * return != 0, *cookie != 0: the callback is already pending. The cookie
 *     can still be used to correlate with the pending callback.
 *
 *   * return == 0, *cookie != 0: the callback queued successfully.  The
 *     callback is guaranteed to be called with the given cookie.
 */
int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
{
	enum task_work_notify_mode mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
	u64 zero = 0;
	int ret;

	*cookie = 0;

	if (!current->mm || !user_mode(task_pt_regs(current)))
		return -EINVAL;

	if (!nmi_supported() && in_nmi())
		return -EINVAL;

	/* Return a valid @cookie even if the callback is already pending. */
	*cookie = READ_ONCE(work->cookie);
	if (*cookie)
		return -EEXIST;

	*cookie = get_cookie();

	/* Claim the work unless an NMI just now swooped in to do so. */
	if (!try_cmpxchg64(&work->cookie, &zero, *cookie))
		return -EEXIST;

	/* The work has been claimed, now schedule it. */
	ret = task_work_add(current, &work->work, mode);
	if (WARN_ON_ONCE(ret)) {
		WRITE_ONCE(work->cookie, 0);
		return ret;
	}

	return 0;
}

-- 
Josh

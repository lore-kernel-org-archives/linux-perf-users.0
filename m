Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF11BD9DF;
	Wed, 30 Oct 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312710; cv=none; b=DuwF5y/a/ELSM4rcDn2BlDAXtsBPI1Oo41UiW8dtrC9l/tmE5MkiycaoI4l1TQwXgTeXVI0mHZJydxrsDSNUoIUTyXR0yfpDu7eW27m/aj/PaX4QIWz5tQHfEaZ3aRmc+0qy+WeQE4CiEhutwJIPHJp6XhucHIE4NQRH5nOXwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312710; c=relaxed/simple;
	bh=xtHHaVHjQlJsAq8PH+DEgcvsognlHgDHLIjv3oQ2wlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVgotLEVySnNwu3qZ14MZp8HhA+wUM0eIinyBu11NTkqcsg7GfWv53N3k55lYqHxengXdIhthKeOibkxzh3Z3OmrNahOsrFb8aqfra0T1iiCamtvMSCevMoAnPQXVoewlxySfv/AOM3YRSeQlLt+47ri5ljgEw7H4k6vNAm7Uyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrTJF2RG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrTJF2RG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D8FC4CECE;
	Wed, 30 Oct 2024 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312709;
	bh=xtHHaVHjQlJsAq8PH+DEgcvsognlHgDHLIjv3oQ2wlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrTJF2RGKuIXFDebsRtqeyL7zNcUh8IKtqpdL+hpaSxhZoQOXJF53fosdiIFI9YmB
	 Mnuc7JRBtF8uQR/aMBAb32ukMXWR/bpqok0mPjjMu7zOOC0FjXt8qLE0tVevg8AbnY
	 zRnhM+3PFkjSCZJwGoBbdcsfQLxIiSEf+ylQ1vCx2DRjRLDNlCgIiZtyoWJ1uUpFuF
	 7QackYg/Iz77Pa41wRDlaQcty0urU+V8aG0PoGcmMrx83l4M88zjlayf0A3kU+UcPw
	 Quqt+AJLwopq6XH4urDYoK+6Za2oKYLTrXisSJ4PiXFETFT68aFac9MCHrZ23V4hZ+
	 vGCaEs1uLyWqw==
Date: Wed, 30 Oct 2024 11:25:07 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241030182507.wpjdsvnitn7k2q2p@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
 <20241029183440.fbwoistveyxneezt@treble.attlocal.net>
 <74afc8d4-621a-4876-a8cf-6165a913e4b3@efficios.com>
 <20241030174752.gwzk6q6n2f3sg52a@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030174752.gwzk6q6n2f3sg52a@treble.attlocal.net>

On Wed, Oct 30, 2024 at 10:47:55AM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 30, 2024 at 09:44:14AM -0400, Mathieu Desnoyers wrote:
> > What you want here is to move the point where you clear the task
> > cookie to _after_ completion of stack unwind. There are a few ways
> > this can be done:
> > 
> > A) Clear the task cookie in the task_work() right after the
> >    unwind_user_deferred() is completed. Downside: if some long task work
> >    happen to be done after the stack walk, a new unwind_user_deferred()
> >    could be issued again and we may end up looping forever taking stack
> >    unwind and never actually making forward progress.
> > 
> > B) Clear the task cookie after the exit_to_user_mode_loop is done,
> >    before returning to user-space, while interrupts are disabled.
> 
> Problem is, if another tracer calls unwind_user_deferred() for the first
> time, after the task work but before the task cookie gets cleared, it
> will see the cookie is non-zero and will fail to schedule another task
> work.  So its callback never gets called.

How about we:

  - clear task cookie on entry or exit from user space

  - use a different variable (rather than clearing of task cookie) to
    communicate whether task work is pending

  - keep track of which callbacks have been called for this cookie

something like so?

int unwind_user_deferred(struct unwind_callback *callback, u64 *ctx_cookie, void *data)
{
	struct unwind_task_info *info = &current->unwind_task_info;
	unsigned int work_pending = work_pending;
	u64 cookie = info->ctx_cookie;
	int idx = callback->idx;

	if (WARN_ON_ONCE(in_nmi()))
		return -EINVAL;

	if (!current->mm)
		return -EINVAL;

	guard(irqsave)();

	if (cookie && (info->pending_callbacks & (1 << idx))) {
		/* callback already scheduled */
		goto done;
	}

	/*
	 * If this is the first call from any caller since the most recent
	 * entry from user space, initialize the task context cookie.
	 */
	if (!cookie) {
		u64 cpu = raw_smp_processor_id();
		u64 ctx_ctr;

		__this_cpu_inc(unwind_ctx_ctr);
		ctx_ctr = __this_cpu_read(unwind_ctx_ctr);

		cookie = ctx_to_cookie(cpu, ctx_ctr);
		info->ctx_cookie = cookie;

	} else {
		if (cookie == info->last_cookies[idx]) {
			/*
			 * The callback has already been called with this unwind,
			 * nothing to do.
			 */
			goto done;
		}

		if (info->pending_callbacks & (1 << idx)) {
			/* callback already scheduled */
			goto done;
		}
	}

	info->pending_callbacks |= (1 << idx);
	info->privs[idx] = data;
	info->last_cookies[idx] = cookie;

	if (!info->task_pending) {
		info->task_pending = 1; /* cleared by unwind_user_task_work() */
		task_work_add(current, &info->work, TWA_RESUME);
	}

done:
	if (ctx_cookie)
		*ctx_cookie = cookie;
	return 0;
}

-- 
Josh

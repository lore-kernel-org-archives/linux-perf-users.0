Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA28565E
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Apr 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532168; cv=none; b=uzua4m5+5hXOf7Tm0r0EPcvGJbpGvpX7EJ+e7gOruZ1yxN/ra7dq142qri6BzXE243xL0Zg1ElnxkbcSm4EVRO0hDmNTIKWaTGDeKRhEIi/a0/h2JcO/tUKfRFvh+IZ+LlntlVkYmtrkYg3+gtY1YnbZhGJfyk8pyGoAI7NTuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532168; c=relaxed/simple;
	bh=G0YsJ5+r9qxGqxH+OhCG0NB07frLTlVTsIoh8Br23/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upGQ7Vt/1fONY8d1IhRm271jQxkC5J2CIZ6kATGln5K/pGQdEYcMBWMtWKfc7qpLF6gZ1rIYF4F98Q3kH8G9+Fs8ahWLdiSizAi6QZ5LMje1osNMgPpcgyJteWhs6If8Hv4LQFwK3QRfy7RL8f9HfcQnuSHKU+/9v+D8LUnxggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX7IN1Lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX7IN1Lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223FC072AA;
	Fri, 19 Apr 2024 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713532167;
	bh=G0YsJ5+r9qxGqxH+OhCG0NB07frLTlVTsIoh8Br23/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pX7IN1LuSfFC66h8/wP/Pb2pXJEit5IGHKbz2sSECqnbrRYnudoGQzxArvW4o8ET2
	 dE0LcoP9AExqxwyfIL7jSI4pby4dKLcx2KJ5+GCxfRQx/C5hIZ7bYA9ugv8beSsAAm
	 KXk6tfoT6AJw6gd5pSDb+JI35NCBIHxU6YVXGPAge66/pX5Iq1fe8ckG1u0ERB6l2r
	 5KKT901h7WetOfGOGjCPdu3bYmjsVdGRJWLk4ADzPLo2j1A8L+SMu+mqNIMfqHvbCO
	 Dfeb7cbeFi4dcwMP+8tkDnFIeB7RdPHVwZn1Z/8guJ2HlrR1aNJ30Mw92+ewsRbv/X
	 y8/q5AMc80GMA==
Date: Fri, 19 Apr 2024 14:09:21 +0100
From: Will Deacon <will@kernel.org>
To: chenqiwu <qiwuchen55@gmail.com>
Cc: catalin.marinas@arm.com, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, kaleshsingh@google.com,
	ardb@kernel.org, alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	chenqiwu <qiwu.chen@transsion.com>
Subject: Re: [RESEND v3] arm64: Add USER_STACKTRACE support
Message-ID: <20240419130921.GA3148@willie-the-truck>
References: <20231219022229.10230-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219022229.10230-1-qiwu.chen@transsion.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 19, 2023 at 10:22:29AM +0800, chenqiwu wrote:
> Currently, userstacktrace is unsupported for ftrace and uprobe
> tracers on arm64. This patch uses the perf_callchain_user() code
> as blueprint to implement the arch_stack_walk_user() which add
> userstacktrace support on arm64.
> Meanwhile, we can use arch_stack_walk_user() to simplify the
> implementation of perf_callchain_user().
> This patch is tested pass with ftrace, uprobe and perf tracers
> profiling userstacktrace cases.
> 
> changes in v3:
>   - update perf_callchain_user() to use arch_stack_walk_user()
>     and delete the redundant code as Mark's suggestion in v2.
>   - update the commit message.
> 
> Tested-by: chenqiwu <qiwu.chen@transsion.com>
> Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
> ---
>  arch/arm64/Kconfig                 |   1 +
>  arch/arm64/kernel/perf_callchain.c | 118 +---------------------------
>  arch/arm64/kernel/stacktrace.c     | 120 +++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+), 114 deletions(-)

This mostly looks good to me, with one potential issue:

> @@ -107,35 +25,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>  		return;
>  	}
>  
> -	perf_callchain_store(entry, regs->pc);
> -
> -	if (!compat_user_mode(regs)) {
> -		/* AARCH64 mode */
> -		struct frame_tail __user *tail;
> -
> -		tail = (struct frame_tail __user *)regs->regs[29];
> -
> -		while (entry->nr < entry->max_stack &&

The old code is checking entry->nr against entry->max_stack here...

> +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> +					const struct pt_regs *regs)
> +{
> +	if (!consume_entry(cookie, regs->pc))
> +		return;
> +
> +	if (!compat_user_mode(regs)) {
> +		/* AARCH64 mode */
> +		struct frame_tail __user *tail;
> +
> +		tail = (struct frame_tail __user *)regs->regs[29];
> +		while (tail && !((unsigned long)tail & 0x7))
> +			tail = unwind_user_frame(tail, cookie, consume_entry);

... but it looks like you've dropped that with the rework. Why is that ok?

Will

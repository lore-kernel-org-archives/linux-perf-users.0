Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348CF455639;
	Sat, 12 Sep 2026 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220225; cv=none; b=HHQTeYyRGLNcs2+hufXh11obPU9EnA3awpFic1OQRM3HPOpWc5op5EbpFDiEswXIhxhWpeOb3YSotZtr37j8OwgjMVj+k/y3jzO8sJdA1vG+CSC8Vv/MWljEk2w4drt13bOxeCkb/hT3qm0++oDWxtYuny92ya2qlI6BPvC904o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220225; c=relaxed/simple;
	bh=oNST79umTYOnUVPeaIvOX5gmne1rcIc1dIFSgwmJbY0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WnhEcFP/fS5TuD8OuumS7tiUbD8K1qhEa0jd4TYHcilOqy/tWt5+wFUN5IuhmrDiIMrPbxD0qiQglUkuOL5fWuGfnzXWDwKX/VvldnwP+Xkj5qZNX3ZIt4Na6Q+Tj8lF8GgwDyJ6hr/YfsR7fg8DOtBr2kCxg/jFd1DbPZuj0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg9J3tjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg9J3tjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BDC1F000FF;
	Sat, 12 Sep 2026 13:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789220224;
	bh=jwd4Rk+LghulteCFZ22CToEe8Fypa34me6oLaUXnTn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lg9J3tjWv8hrtyNST5+hW8b/otbqwiOm6OjnlTpt+7n+lCWW06FZZfpXKLEu/V9dg
	 q0LFsRJKg0nW7JrKPw0BInBM1iBIKlex33UOc0XsJTGaeJi6BUTakRPQK6X7JHQBee
	 EeKJTM/b5CzGiQ8OLKq5G2hDgoZ8Ar8hfhifOnWjeVQA+Wseyo4byuVFzcEEujmWv9
	 +QiMTexATwKHLauFvivoKoarjHfOn1Q8u5hnaldxchV8rr1rKIb8DYVQbEF7wHLSZk
	 /cRBK5Yp9JPM3tSzLuOfyxgHMtUakohY1o45O96Gl2Ul7Mmr9DDy9NBtZA4uWmMbSB
	 lzRza60O8j68Q==
Date: Sat, 12 Sep 2026 22:36:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v15 00/12] tracing: wprobe: x86: Add wprobe for
 watchpoint
Message-Id: <20260912223658.c4495241023f72e3cf48bf0c@kernel.org>
In-Reply-To: <307d6fd5-a8fa-4777-b513-9a8cce46f38a@gmail.com>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
	<307d6fd5-a8fa-4777-b513-9a8cce46f38a@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 15:27:41 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> Hi Masami,
> 
> I see the watch address update currently goes irq_work -> workqueue ->
> on_each_cpu().  I would like to discuss that path.
> 
> The race window wprobe may be used to watch can be very narrow --
> sometimes it lives entirely inside a single function -- and the trigger
> does not always run in in_task() context.  The current path defers the
> update to a work item, so by the time the debug registers are updated the
> window may already be gone.
> 
> Now that we have modify_local_hw_breakpoint_addr(), the trigger could arm
> the local CPU directly and use smp_call_function_single_async() for the
> remote ones.  That should improve the overlap between the watch and the window.

Hm, that is a good idea. Maybe we can check the current context and if
possible call modify_local_hw_breakcpoint_addr() directly for current
CPU core, and kick irq_work for other cores.
Does this make sense for you?

Thanks,

> 
> What do you think?
> 
> Thanks,
> Jinchao


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

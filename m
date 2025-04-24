Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22828A1F2;
	Thu, 24 Apr 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515569; cv=none; b=qW4hPSw4/meKR8z+vXKLRIZc5caztSRoZlj18pB77I9V8BkqUcBZz3uFAupWb4kWbzokNge8Usd1iMjYMMQzg5qvdc4uV5dIaj8eteXWtV0oV6NXJv7J22hvhc5qOs+LYtZ+kYj6jA/87FamP7PCnIyZb5+jScsd3iMyjZy0Lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515569; c=relaxed/simple;
	bh=bwbO91dFPDAxOEMD44xM9TYpqSrewfqJ7a4pKWUFzUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVeq9ut4CQyiigbZwwQe1UxxY1L1EPWyVsuXemr3GgIhtd1EVQMYo5ynfMnf4zEBgpP71Oz2VdOoNfo/KncQf3PerdRtOd4LOsesECnzi4PLUZ9LYaBgyQjScXz1h2ExJesK7+DcJECoUSONQKjIozI4pgqlasfBfoM85eIbOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C3C4CEE3;
	Thu, 24 Apr 2025 17:26:05 +0000 (UTC)
Date: Thu, 24 Apr 2025 13:28:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu
 <wnliu@google.com>, Blake Jones <blakejones@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 11/17] perf: Simplify get_perf_callchain() user logic
Message-ID: <20250424132800.49160c2e@gandalf.local.home>
In-Reply-To: <20250424163607.GE18306@noisy.programming.kicks-ass.net>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.048002581@goodmis.org>
	<20250424163607.GE18306@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 18:36:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > +++ b/kernel/events/callchain.c
> > @@ -246,22 +246,20 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> >  
> >  	if (user) {
> >  		if (!user_mode(regs)) {
> > -			if  (current->mm)
> > -				regs = task_pt_regs(current);
> > -			else
> > -				regs = NULL;
> > +			if (!current->mm)
> > +				goto exit_put;
> > +			regs = task_pt_regs(current);  
> 
> I'm thinking this might be one of those is-kthread test written as
> has-mm, and they're broken.
> 
> Notably things like the io-uring kthreads do have mm.

Would there ever be a case where:

	current->mm == NULL && !(current->flags & PF_KTHREAD)

?

That is, do we still need to check for current->mm if it's not a kernel
thread, or can we assume it exists?

-- Steve

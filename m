Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73A4AEE2;
	Mon, 28 Apr 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863935; cv=none; b=VS/9AQVLGmCdzgLLy4HbD3T7HHSeuUHdYD2mdqw+THBj2KWp1f/YayYhEPn2F1foiq/xIb78mr+3r/5E9+7a/utd8ZiLQoxRjyWYmk9W0pITvNGzfnv0kEV133twmuQWyJKqVny3Xx0+LuFXtksSZDdISGTNMl4BsNndymcNFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863935; c=relaxed/simple;
	bh=baR8yuZ+DKQ7vAMklIhbgweOPRiTcktqr21Q2I4keIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S396FAXMgPZCaOtQ5OE/Vx5xe3oylLcvz48l49dE/kJfHYoFNU0jm3+ffGVMlJYF1eym7pQSNc27Mt2JRuLnbBBruDHylw0EO/GhhLm0yOl2lPrreOqVZg3zPO0Z1u0DImnQ8zylKuDvVKVk5m9KaUsjGLD0abqI17ly8DTFgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D130C4CEE4;
	Mon, 28 Apr 2025 18:12:12 +0000 (UTC)
Date: Mon, 28 Apr 2025 14:12:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v5 3/9] unwind deferred: Use bitmask to determine which
 callbacks to call
Message-ID: <20250428141210.6ef945c6@gandalf.local.home>
In-Reply-To: <ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com>
References: <20250424192456.851953422@goodmis.org>
	<20250424192612.844558089@goodmis.org>
	<02339b93-de9a-49e4-8dbb-137d02fc6ea8@efficios.com>
	<20250428125600.1f50f476@gandalf.local.home>
	<ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 14:00:07 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> >>
> >> It is enough to guard with RCU ? See syscall_regfunc() from
> >> tracepoint.c where we do:
> >>
> >>                   read_lock(&tasklist_lock);
> >>                   for_each_process_thread(p, t) {
> >>                           set_task_syscall_work(t, SYSCALL_TRACEPOINT);
> >>                   }
> >>                   read_unlock(&tasklist_lock);
> >>
> >> To prevent concurrent fork from adding threads while we
> >> iterate, thus opening the possibility of missing a clear
> >> due to a concurrent fork + set bit.  
> > 
> > A set_bit only would happen if the callback was live and accepting new
> > callback requests. It's a bug for a tracer to call unwind_deferred_cancel()
> > and then call unwind_deferred_request() (which would set the bit). We could
> > possibly set the tracer's unwind descriptor id to -1, and do an
> > WARN_ON_ONCE() in unwind_deferred_request() if the tracer's id is negative.
> > 
> > The loop is called under the callback_mutex, where no new tracer could
> > register and be assigned that bit.  
> 
> Ah, that's the piece I missed. The callback_mutex prevents reallocation
> of the ID by unwind_deferred_init while iterating on the tasks.
> 
> One more comment: if we change the linked list for an array (or make the 
> linked list an RCU list), can we remove the callback_mutex from
> unwind_deferred_task_work by turning it into an RCU read-side ?
> 
> Then we just need to wait for a grace period before returning from
> unwind_deferred_cancel, which then allows the caller to reclaim "work".
> 
> Taking the callback_mutex in unwind_deferred_task_work will end up being
> the single thing that does a lot of cache line bouncing across CPUs when
> hit heavily by tracers.

I'm not against this, but again, that's an optimization. I want to keep the
initial code simple. And then add the more complex optimizations when this
is stable.

-- Steve

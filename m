Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A31EB9E3;
	Wed, 30 Oct 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295956; cv=none; b=sJMf7sghwsSLQ4uNpmMqKxQWqiEiQEEAX6sfrLR+7/sHOhl38nlShzNE9JHSm3TGwF2tCOS5y7xjI3/krxDrXPwe3E63sLl0B93wR2wRa9S2Y7s5PoCEy/jXbkWI378ti00zI1cFQeTRDdGpgl1bEbNK9WnanE+V/gJSZeE3d9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295956; c=relaxed/simple;
	bh=inaXq35j3illj9PkvgGc1dWz3CoE0YPpBiSWZgXyH14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0kZEFJPCNuXDJeyJo5j+g5Tj0DbV/IoEQH3lhXpHWhiYsHuKnk0LNPCkgZgtiXizU/vK+c1BdRezLsardZCyNSrZnl9LZGhZVoWRlG0DsYjntN7oryBY8trkvbqOFQ4sjfUFLSOcBI92V5MOixnU6cEd315FtSFVyU62Fh6zdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FseGwaDA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FseGwaDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730295951;
	bh=inaXq35j3illj9PkvgGc1dWz3CoE0YPpBiSWZgXyH14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FseGwaDAyWUlQyT9V6NJwpyrEul/8LotpIe2AfAY4FEM5/enn2rPCEcSnbvruRitM
	 6UflBBgdmTrtg9qFuaeR/A/jxMSGz9whx1TJSbcMXlh7nZm7UTZi/UJftEANS0iTDv
	 SFfrMInsHYtBndoIWnLHjpYU1bHvWuBVC+NYu6CNGQV0CdzT9Vb3ma33bEp+gfKlVG
	 oleW+gEoMxXKc7OuuWDrJx/5l39McaOxxuGb2SlE/4ca8/isOLvpi6gy+54556TP0c
	 4r04mdX1wUljdr6fKvZ0cHpmeJ6TsuSeNElkhTpfMEOoQz7zjLm5G9MXVcNJXEhGRq
	 zPXyjTtxNPz4Q==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XdpL71YMCzKGr;
	Wed, 30 Oct 2024 09:45:51 -0400 (EDT)
Message-ID: <74afc8d4-621a-4876-a8cf-6165a913e4b3@efficios.com>
Date: Wed, 30 Oct 2024 09:44:14 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
 <20241029183440.fbwoistveyxneezt@treble.attlocal.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241029183440.fbwoistveyxneezt@treble.attlocal.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-29 14:34, Josh Poimboeuf wrote:
> On Tue, Oct 29, 2024 at 01:47:59PM -0400, Mathieu Desnoyers wrote:
>>>> If ftrace needs brain damage like this, can't we push this to the user?
>>>>
>>>> That is, do away with the per-cpu sequence crap, and add a per-task
>>>> counter that is incremented for every return-to-userspace.
>>>
>>> That would definitely make things easier for me, though IIRC Steven and
>>> Mathieu had some concerns about TID wrapping over days/months/years.
>>>
>>> With that mindset I suppose the per-CPU counter could also wrap, though
>>> that could be mitigated by making the cookie a struct with more bits.
>>>
>>
>> AFAIR, the scheme we discussed in Prague was different than the
>> implementation here.
> 
> It does differ a bit.  I'll explain why below.
> 
>> We discussed having a free-running counter per-cpu, and combining it
>> with the cpu number as top (or low) bits, to effectively make a 64-bit
>> value that is unique across the entire system, but without requiring a
>> global counter with its associated cache line bouncing.
>>
>> Here is part where the implementation here differs from our discussion:
>> I recall we discussed keeping a snapshot of the counter value within
>> the task struct of the thread. So we only snapshot the per-cpu value
>> on first use after entering the kernel, and after that we use the same
>> per-cpu value snapshot (from task struct) up until return to userspace.
>> We clear the task struct cookie snapshot on return to userspace.
> 
> Right, so adding some details to this, what I remember specifically
> deciding on:
> 
>   - In unwind_user_deferred(), if task cookie is 0, it snapshots the
>     per-cpu counter, stores the old value in the task cookie, and
>     increments the new value (with CPU # in top 48 bits).
> 
>   - Future calls to unwind_user_deferred() see the task cookie is set and
>     reuse the same cookie.
> 
>   - Then the task work (which runs right before exiting the kernel)
>     clears the task cookie (with interrupts disabled), does the unwind,
>     and calls the callbacks.  It clears the task cookie so that any
>     future calls to unwind_user_deferred() (either before exiting the
>     kernel or after next entry) are guaranteed to get an unwind.

This is where I think we should improve the logic.

If an unwind_user_deferred() is called right over/after the unwind,
I don't think we want to issue another stack walk: it would be redundant
with the one already in progress or completed.

What we'd want is to make sure that the cookie returned to that
unwind_user_deferred() is the same as the cookie associated with the
in-progress or completed stack unwind. This way, trace analysis can
look at the surrounding events (before and after) the unwind request
and find the associated call stack.

> 
> That's what I had implemented originally.  It had a major performance
> issue, particularly for long stacks (bash sometimes had 300+ stack
> frames in my testing).

That's probably because long stacks require a lot of work (user pages
accesses) to be done when stack walking, which increases the likeliness
of re-issuing unwind_user_deferred() while the stack walk is being done.

That's basically a lack-of-progress issue: a sufficiently long stack
walk with a sufficiently frequent unwind_user_deferred() trigger could
make the system stall forever trying to service stalk walks again
and again. That's bad.

> 
> The task work runs with interrupts enabled.  So if another PMU interrupt
> and call to unwind_user_deferred() happens after the task work clears
> the task cookie but before kernel exit, a new cookie is generated and an
> additional task work is scheduled.  For long stacks, performance gets
> really bad, dominated by all the extra unnecessary unwinding.

What you want here is to move the point where you clear the task
cookie to _after_ completion of stack unwind. There are a few ways
this can be done:

A) Clear the task cookie in the task_work() right after the
    unwind_user_deferred() is completed. Downside: if some long task work
    happen to be done after the stack walk, a new unwind_user_deferred()
    could be issued again and we may end up looping forever taking stack
    unwind and never actually making forward progress.

B) Clear the task cookie after the exit_to_user_mode_loop is done,
    before returning to user-space, while interrupts are disabled.

C) Clear the task cookie when entering kernel space again.

I think (B) and (C) could be interesting approaches, perhaps with
(B) slightly more interesting because it cleans up after itself
before returning to userspace. Also (B) allows us to return to a
purely lazy scheme where there is nothing to do when entering the
kernel. This is therefore more efficient in terms of cache locality,
because we can expect our per-task state to be cache hot when
returning to userspace, but not necessarily when entering into
the kernel.

> 
> So I changed the design a bit:
> 
>    - Increment a per-cpu counter at kernel entry before interrupts are
>      enabled.
> 
>    - In unwind_user_deferred(), if task cookie is 0, it sets the task
>      cookie based on the per-cpu counter, like before.  However if this
>      cookie was the last one used by this callback+task, it skips the
>      callback altogether.
> 
> So it eliminates duplicate unwinds except for the CPU migration case.

This sounds complicated and fragile. And why would we care about
duplicated unwinds on cpu migration ?

What prevents us from moving the per-task cookie clearing to after
exit_to_user_mode_loop instead ? Then there is no need to do per-cpu
counter increment on every kernel entry and we can go back to a lazy
scheme.

> 
> If I change the entry code to increment a per-task counter instead of a
> per-cpu counter then this problem goes away.  I was just concerned about
> the performance impacts of doing that on every entry.

Moving from per-cpu to per-task makes this cookie task-specific and not
global anymore, I don't think we want this for a stack walking
infrastructure meant to be used by various tracers. Also a global cookie
is more robust and does not depend on guaranteeing that all the
trace data is present to guarantee current thread ID accuracy and
thus that cookies match between deferred unwind request and their
fulfillment.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


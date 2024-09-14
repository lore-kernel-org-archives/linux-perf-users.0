Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E677115;
	Sat, 14 Sep 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726315976; cv=none; b=oTXT2cOdgFoWyN6jLWMkwk7heDo46yEsq1uHpTEbHSB2gqzxE72a9tPWEOZ1/+DMmb7Ej04/+BE5W6UGVLh2yIXT4hParQvFlDkYPZ8EuA4HXKp7IPpADZZ5aR82vb7z6+7BmsLRLjuel9GGd9TWn5eYT0uSHBqI60nSfdL1O8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726315976; c=relaxed/simple;
	bh=Pl9ObVTke+fwVEyKkC+JOM9WLEuzpl957b9y4okZyX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqzghH+voL65QFrXpxgrQJEkpTMjk2IQJhJnWt4HYWwLQ+ayjACXdBcqHoh/WIvp4e1AMU9G2vXSpEvyStklh56SyaMzM/QftrazBgX6xVxtQDg7zjrhCv6R/b4sr+n+H8keINoWPKrCAduhvCGZEX0iUW06MyczMyv4SVOrBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A67C4CEC0;
	Sat, 14 Sep 2024 12:12:50 +0000 (UTC)
Date: Sat, 14 Sep 2024 08:12:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20240914081246.1e07090c@rorschach.local.home>
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 01:02:02 +0200
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> This is a new version of sframe user space unwinding + perf deferred
> callchains.  Better late than never.
> 
> Unfortunately I didn't get a chance to do any testing with this one yet
> as I'm rushing it out the door before GNU Cauldron starts.
> Conference-driven development ;-)

Thanks for posting this!

BTW, next time, can you also Cc linux-trace-kernel@vger.kerne.org.

> 
> Plus I don't have the perf tool piece working yet so I don't have a way
> of doing end-to-end testing at the moment anyway.
> 
> In other words, please don't merge this yet.
> 
> Namhyung, if you're still available to write a perf tool patch which
> integrates with this, that would be great.  Otherwise I could give it a
> try.
> 
> Steven, let me know if this would interface ok with your anticipated
> tracing usage.

This is a very good starting point for me. A couple of notes.

I think the unwinder should have an interface itself that provides the
deferred unwinding, instead of having all the tracers to implement
their own.

The user space unwinder (regardless of sframe or not) should provide a
way to say "I want a user space stack trace for here, but don't do it
yet. Just give me a cookie and then call my callback function with the
stack and cookie before going back to user space".

That is, we should have an interface like:

typedef void (unwinder_callback_t)(struct user_space_stack *, u64 cookie);

struct unwinder_client {
	struct list_head	list;
	unwinder_callback_t	callback;
};


struct unwinder_client my_unwinder = {
	.callback = mycallback;
};

	register_unwinder(&my_unwinder);



Then a tracer could do this in NMI context:

	/* Get the current cookie of the current task */
	cookie = unwinder_get_cookie();

	/* Tell the unwinder to call the callbacks */
	unwinder_trigger();

	/* then the tracer can save off that cookie, do a kernel stack trace
	 * and save the cookie with that stack trace.
	 */


On return to user space, it will go the ptrace slow path and call all
registered callbacks with the cookie, regardless if it asked for it or
not.

	/* Save the stack somewhere, could even allocate memory to do so */
	list_for_each_entry(callback, &unwinder_callback, list) {
		callback->callback(userstack, cookie);
	}
	update_next_cookie();

The cookie is a unique number for every entry into the kernel by all
tasks. Then it is up to the tracer's callback to know if it should save
the trace or ignore it. That is, if perf and ftrace are expecting
callbacks, but only perf triggered the callback, it should record the
cookie, and save the stack if it matches a cookie it wants. ftrace's
callback would ignore the trace, because it did not ask for a callback.
That is, the tracer will need to save off the cookie to know if its
callback needs to do something or not.

The cookie can be generated by this:

static u64 next_cookie;

u64 unwinder_get_cookie(void)
{
	u64 next;

	if (current->unwinder_cookie)
		return current->unwinder_cookie;

	next = next_cookie;
	while (!try_cmpxchg64(&next_cookie, &next, next + 1))
		;

	next++;

	/* Check for races with NMI */
	if (!cmpxchg(&current->unwinder_cookie, 0, next))
		next = current->unwinder_cookie;

	return next;
}

When the task goes back to user space and does all the callbacks, it
would reset the task cookie.

	current->unwinder_cookie = 0;

Now the loop of callbacks should also catch if unwinder_trigger() was
called again (NMI), and may need to recall all the back traces again
with the new cookie.

That will need some thought about handling that race.

This is just an idea to start discussion.

-- Steve

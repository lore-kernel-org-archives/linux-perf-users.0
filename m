Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B337160;
	Tue, 29 Apr 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935211; cv=none; b=RKFeVgEJwgrLmtBWbuvsXu10DMITk2o2zcLtWXDbS6rO7cXXSry/m/GNOcvZG0blg0u9/1VcicGTMPLu7xVEjgSj8nQhHhhZCteA93LhBhNAxH4bFmSxAsSXNMRGqhc6EYdMYmYuiIqP0OJoZDLFfuddpaIDreGReBCmltLgISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935211; c=relaxed/simple;
	bh=2i/8tVY56b3DVucwE4I0Opa9mcCFm5PbnmBsbO63Vi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGAgpfA/rpUrMW6aDdc59Frnkm5/K2hQsdWcr1KKPIF/oVgCmqHpY+IoZf5fzThj4bghA4wTydcVWt6UJtKvrocik0Cc6l8fFEqqymZUrPPmNq83TT60z/Luw4DbpiBlTe0VKvny6VHt4ahC8E07r+fZ03RajY76BamBtUvudZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEF5C4CEE9;
	Tue, 29 Apr 2025 14:00:06 +0000 (UTC)
Date: Tue, 29 Apr 2025 10:00:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <20250429100007.3225e7eb@gandalf.local.home>
In-Reply-To: <aBAdgUpi9fxsQ_t4@google.com>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.390748816@goodmis.org>
	<aAupP56jOM_wul_8@google.com>
	<20250425125815.5c5b33be@gandalf.local.home>
	<aA_oJ7tgGv-H4ocX@google.com>
	<20250428180253.1b1517a8@gandalf.local.home>
	<aBAdgUpi9fxsQ_t4@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 17:29:53 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Thing is that the kernel doesn't know the relationship between events.
> For example, if I run this command on a machine with 100 CPUs:
> 
>   $ perf record -e cycles,instructions -- $MYPROG
> 
> it would open 200 events and they don't know each other.  Later other
> process can start a new perf profiling for the same task.  IIUC there's
> no way to identify which one is related in the kernel.
> 
> So I think we need a way to share some informaiton for those 200 events
> and then emits deferred callchain records with the shared info.

Hmm, I'm thinking of creating an internal perf descriptor that would join
events by who created them. That is, the first event created will take the
thread leader (pid of the task) and check if an entity exists for it. If
one doesn't exist it will create it and add itself to that event if it has
a deferred trace attribute set. If it already exists, it will just add
itself to it. This deferred descriptor will register itself with the
deferred unwinder like ftrace does (one per process), and then use it to
defer callbacks. When the callback happens, it will look for the thread
event or CPU event that matches the current thread or current CPU and
record the backtrace there.


> 
> > 
> > It could use the cookie method that ftrace uses, where the request gets a
> > cookie, and can be recorded to the perf event in the interrupt. Then the
> > callchain would record the cookie along with the stack trace, and then perf
> > tool could just match up the kernel stacks with their cookies to the user
> > stack with its cookie.  
> 
> Yep, but the kernel should know which events (or ring buffer) it should
> emit the deferred callchains.  I don't think it needs to include the
> cookie in the perf data, but it can be used to find which event or ring
> buffer for the session is related to this request.

Let me see if my suggestion would work or not. I'll try it out and see what
happens. And post patches later.

-- Steve

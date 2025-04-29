Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03620155333;
	Tue, 29 Apr 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886596; cv=none; b=CXRTQJO/FulWTuTnguxinunH6O94pDi/gS3buSL6fBXGZnT7c1cuaaakrvhJg47FyFqtuYKrQ9Xiz9SkkWLokaNe4NnPv1Atp+Towdk+rVEBeayeGQA+1tkei4fxdCh8tYRkiPzQw7p9AnyL2ynSGE3/Mvg6KTicjxMjEfd+QLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886596; c=relaxed/simple;
	bh=tLYrPYZW/X/t1bozTpHr9P83ZuJCHn0ll7fGYXewILk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjH0/KZty4qC11rvI8jqinqZjvNWCXaS0KBeI2uP8gd2zvFPw3m9f9pt6m1zuVYs6hjOL9WSHGY+Q5xXhpI1nW8TPEEsGOlZEeVku3dHDUUHfC4L34YMBZB3As4s/NV9VnxLyBRnnfn2aponzONKYZRCUDh4F/zByjzgl6813ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRhnJ53k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRhnJ53k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CDAC4CEF0;
	Tue, 29 Apr 2025 00:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745886595;
	bh=tLYrPYZW/X/t1bozTpHr9P83ZuJCHn0ll7fGYXewILk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRhnJ53kJ3lxPhW//wTC2sjlYIHaM3FV2DbU+UQFW44a9kSVid7dpDFV9JRoIEUT7
	 /+SyZcQSKI2PMp7e59tDWeHLY/9sJR01A40tkRYfne9mlX43zFAtS6A7jO5SLjj47R
	 /7IpzEFeVytdPCvFPrtKEKV2HJEHsp8rDDc4SiM2GXwfilmGG4ZUC1rOPgFKV7ugJN
	 zQCgcoTcWGLyhHY2nl7MOMTScHgn7UoFyGeCZMUQTfaV/Wa9O5KZKKnXNEfpD3LHY2
	 kykK2HoLeADOftf0wyPF/r8sJUB2gg3fc0/148NxW++B8pAAKQYMEI6/O/nA0k6tvs
	 XdQaMqV2gNCZw==
Date: Mon, 28 Apr 2025 17:29:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <aBAdgUpi9fxsQ_t4@google.com>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
 <aAupP56jOM_wul_8@google.com>
 <20250425125815.5c5b33be@gandalf.local.home>
 <aA_oJ7tgGv-H4ocX@google.com>
 <20250428180253.1b1517a8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250428180253.1b1517a8@gandalf.local.home>

On Mon, Apr 28, 2025 at 06:02:53PM -0400, Steven Rostedt wrote:
> On Mon, 28 Apr 2025 13:42:15 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> 
> > > 
> > > Could we just not use deferred when running with "-a" for now? Or could we
> > > possibly just make the deferred stacktrace its own event? Have it be
> > > possible that perf just registers a signal instance with the deferred
> > > unwinding logic, and then perf can handle where to write the information. I
> > > don't know perf well enough to implement that.  
> > 
> > Even if it excludes per-CPU events, per-task events also can attach to a
> > CPU and that's the default behavior of the perf record IIRC.  In that
> > case, it needs to be careful when it accesses the event since the task
> > can migrate to another CPU.  So I'm not sure if it's a good idea to
> > track event that requested the deferred callchains.
> 
> Wait? Even for per task, it uses per cpu?

Yep, it has per-task + per-CPU events.

> 
> > 
> > Also it doesn't need to emit duplicate deferred callchains if a task
> > has multiple events and they are requesting callchains.  Unfortunately,
> > the kernel cannot know which events are related or profiled together.
> > 
> > Hmm.. maybe we can add a cookie to the event itself (by ioctl or
> > something) in order to group events in a profiling session and then use
> > that for deferred callchains?  Task should maintain a list of active
> > cookies (or sessions) somehow but then perf can check if the current CPU
> > has events with matching cookies and emit a deferred callchain.
> 
> Could we add a callchain event? It gets woken at any request but not
> triggered until the task returns. A way that there would be only a single
> event for every perf instance, but it can trace any task.

Thing is that the kernel doesn't know the relationship between events.
For example, if I run this command on a machine with 100 CPUs:

  $ perf record -e cycles,instructions -- $MYPROG

it would open 200 events and they don't know each other.  Later other
process can start a new perf profiling for the same task.  IIUC there's
no way to identify which one is related in the kernel.

So I think we need a way to share some informaiton for those 200 events
and then emits deferred callchain records with the shared info.

> 
> It could use the cookie method that ftrace uses, where the request gets a
> cookie, and can be recorded to the perf event in the interrupt. Then the
> callchain would record the cookie along with the stack trace, and then perf
> tool could just match up the kernel stacks with their cookies to the user
> stack with its cookie.

Yep, but the kernel should know which events (or ring buffer) it should
emit the deferred callchains.  I don't think it needs to include the
cookie in the perf data, but it can be used to find which event or ring
buffer for the session is related to this request.

Thanks,
Namhyung


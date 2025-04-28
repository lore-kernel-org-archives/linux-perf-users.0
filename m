Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91261367;
	Mon, 28 Apr 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877778; cv=none; b=TAnmczllshilX3IqypcGY9cuEiysQDqVmjp5fqBL2vkKGTMH50QTocrINsQT7QAdnxIWo2RirI2baBkPJjd/Rd/U9JNDqtaLbkIGk0vmz7SxxagH6nOOByiC56QRYp+K6KUXdnx3MlrecmTQho9MEgoGsfJcFRdHrnIPqNbTr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877778; c=relaxed/simple;
	bh=W4YKhaHesIMWHxvP/qA3bz+J9Plo8P7isVbJBSL3WXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRW1HbJJx/E3hLzQtEe3d1NTVRiBcUYUrCNqAag/z8RrUls9DS2Qy10WCq/tt7J5+GfsLnQLo0HM5mXd0bpWNcOKoUaHoyjZPtSzmuJKsaDRiddpjvGdxJqnTKAYaIUf21soNnxubexUUg/5eMxkTYuWWkXo6o7Ygrk/RdMSCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA0C4CEE4;
	Mon, 28 Apr 2025 22:02:54 +0000 (UTC)
Date: Mon, 28 Apr 2025 18:02:53 -0400
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
Message-ID: <20250428180253.1b1517a8@gandalf.local.home>
In-Reply-To: <aA_oJ7tgGv-H4ocX@google.com>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.390748816@goodmis.org>
	<aAupP56jOM_wul_8@google.com>
	<20250425125815.5c5b33be@gandalf.local.home>
	<aA_oJ7tgGv-H4ocX@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 13:42:15 -0700
Namhyung Kim <namhyung@kernel.org> wrote:


> > 
> > Could we just not use deferred when running with "-a" for now? Or could we
> > possibly just make the deferred stacktrace its own event? Have it be
> > possible that perf just registers a signal instance with the deferred
> > unwinding logic, and then perf can handle where to write the information. I
> > don't know perf well enough to implement that.  
> 
> Even if it excludes per-CPU events, per-task events also can attach to a
> CPU and that's the default behavior of the perf record IIRC.  In that
> case, it needs to be careful when it accesses the event since the task
> can migrate to another CPU.  So I'm not sure if it's a good idea to
> track event that requested the deferred callchains.

Wait? Even for per task, it uses per cpu?

> 
> Also it doesn't need to emit duplicate deferred callchains if a task
> has multiple events and they are requesting callchains.  Unfortunately,
> the kernel cannot know which events are related or profiled together.
> 
> Hmm.. maybe we can add a cookie to the event itself (by ioctl or
> something) in order to group events in a profiling session and then use
> that for deferred callchains?  Task should maintain a list of active
> cookies (or sessions) somehow but then perf can check if the current CPU
> has events with matching cookies and emit a deferred callchain.

Could we add a callchain event? It gets woken at any request but not
triggered until the task returns. A way that there would be only a single
event for every perf instance, but it can trace any task.

It could use the cookie method that ftrace uses, where the request gets a
cookie, and can be recorded to the perf event in the interrupt. Then the
callchain would record the cookie along with the stack trace, and then perf
tool could just match up the kernel stacks with their cookies to the user
stack with its cookie.

-- Steve

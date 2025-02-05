Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DDD78F4C;
	Wed,  5 Feb 2025 02:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722304; cv=none; b=NHgNqLV2qE6fAeFbL2xeoxib5zV9yV2p7kcXMyyx8Ipa8k3oCw4ekKXo+kxSVLUqKVuqm0sBjSONqnUon7KDoYBYpskbsmVgnSHoa2Q8sZC9oS4s+O2wd5g0bgygLhmWgHBbvb//dRXuxX1KdDVOOdQOil0NX+DUB4LeTq65mxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722304; c=relaxed/simple;
	bh=pufqpysQKd95ciAQ8Ar90FFziPH/uymLmauofbzInFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAPq/lndGgGk4wAilPgHyrkzKyTyd5wNRuqnQrLbGgupP+YG4vgtRx/biUv6qXkQS5WzyTW8CZU1uSnqR1WKWETthH8kfyHEYUra+Xs8QmaNar9o8I0na+LbmoAXn6A3iTyn+otqoF3KDK3ffOFziZNPpieabDfiZItC0o+hekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4K1CC0D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4K1CC0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980CAC4CEDF;
	Wed,  5 Feb 2025 02:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738722303;
	bh=pufqpysQKd95ciAQ8Ar90FFziPH/uymLmauofbzInFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4K1CC0DtiPBGVOrymzduhv0rmPRb0lHU5vZfwsbv/XLxlG+q1KZgGDOTNyzfmtVx
	 trkPEYMgCwkY+AQHNuMGP0v3Tv2t6EvUW+VDJWhzwQQF3OXeBPaZWsEqF7wZqPbVOg
	 V5bSH5km3qvNnkylN+D8UDGbovBnTVRFuNkPnkOmuLxMTVYt1m/QsEyQpMIiyys74S
	 rSuUbpZbKeJHOdko/qXNlowP0ANy/IEHddNCnMKijL1xMTf0eSnHR4NwMP9QeKshwc
	 tZwiDNafA39SKqlIiHYwwxoDGG1Kz+sZaCMlMom2Pjh1Ni3vueaQxzK0sWyjlR1efe
	 IVpSae6kOXUow==
Date: Tue, 4 Feb 2025 18:25:00 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
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
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250205022500.lnz3jlaetzh6gxds@jpoimboe>
References: <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
 <20250123040533.e7guez5drz7mk6es@jpoimboe>
 <20250123082534.GD3808@noisy.programming.kicks-ass.net>
 <20250123184305.rjuxj7hs3ond3e7c@jpoimboe>
 <20250123221326.GD969@noisy.programming.kicks-ass.net>
 <20250124165803.565c29ed@gandalf.local.home>
 <20250124224645.lcovfraeq53gegys@jpoimboe>
 <20250124225011.aebigdykpmnnthfg@jpoimboe>
 <20250124185744.69379ba6@gandalf.local.home>
 <20250130152136.51bee69b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130152136.51bee69b@gandalf.local.home>

On Thu, Jan 30, 2025 at 03:21:36PM -0500, Steven Rostedt wrote:
> Coming back from this. It would be fine if we could do the back trace when
> we come back from the scheduler, so it should not be an issue if the task
> even has to schedule again to fault in the sframe information.

So there would be two callback hook points:

  - schedule() after enabling preemption

  - task work

and first one wins?

> I was also wondering if the unwinder doesn't keep track of who requested
> the back trace, just that someone did. Then it would just take a single
> flag in the task struct to do the back trace. Return the "cookie" to the
> tracer that requested the back trace, and when you do the back trace, just
> call all callbacks with that cookie. Let the tracer decided if it wants to
> record the back trace or ignore it based on the cookie.
> 
> That is, the tracers would need to keep track of the cookies that it cares
> about, as if there's other tracers asking for stack traces on tasks that
> this tracer doesn't care about it needs to handle being called when it
> doesn't care about the stack trace. That said, if you want to trace all
> tasks, you can just ignore the cookies and record the traces.

Easy enough for the unwinder, but IIUC each tracer would have to
maintain a global list of pending cookies (and corresponding ptrs to
perf_event, trace_array, etc)?  Would that not create a lot of
contention?

Seems like there really needs to be some kind of per-task or per-request
state.

-- 
Josh

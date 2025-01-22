Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0D1C54A5;
	Wed, 22 Jan 2025 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737582765; cv=none; b=n+o70Q3rVd7HwJFtHc88VBVgwd3v+WCv4O5IZJhkWeqOcM8JFYUJDNI9SIv9SwjotMiUDTwGS7Qy5ruiS5ruvv3oWNZkbYCB7i0/zK86FqppsjL1eI2J6Ce0HEpvq7nKsuzZJR91ZxTcxKpfzi+r9ijCz6TquDYGnIY1lZeG7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737582765; c=relaxed/simple;
	bh=rGgJnGJbCH093WZXL65TqjFTkBH/SVb4xp5TY6NpG0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfW3aCroLjlcG0w6of7HMXumPPkVG0H4seKO9kuCxt0UvGI5CLAKeOiXvypoyia4kKgcLlYPPc3eX8C1FTW+CXEx4SoN4pZh04oySeu16u2Deiz6NyJupwBptRJiS0fVEKYEtU6/8ij8qh30G/l708J+73dDmoH9LOdf1h9cdUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUuYZ38Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUuYZ38Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAECC4CED2;
	Wed, 22 Jan 2025 21:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737582764;
	bh=rGgJnGJbCH093WZXL65TqjFTkBH/SVb4xp5TY6NpG0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUuYZ38QMw7EItgjVYMtKPLOK38XSqOP93G2SyNmuI7ZExrVENejEjuMgr7zpbNpO
	 /FNxTGyI9b/9Z3GzukB/EYL8bcy+Rl4dELvvWFWPJdFgTznTAjFaouTP99BCtUatII
	 B2pDutO5LHZpcG5h7yS4FN4AJ0Y5auN0S0gzkANEZfqgI02aMwnd68LhtZOUQprpiU
	 SAmMB1cK9HgzgTXz765pNNmesKwLcb9+ScRpUhZnrThNUuhz5p0kv8/ra45NnXe3Dz
	 NQeRGtnTwly0qkHBl//JdzOcy8Pz4cpoPzsCwdqmdT2IMysU9W5yJCv13z54nG2kIk
	 Fk2q0GBa5WPIQ==
Date: Wed, 22 Jan 2025 13:52:41 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250122215241.gpzay24gzx4yggla@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <20250122134420.GR7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122134420.GR7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 02:44:20PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:20PM -0800, Josh Poimboeuf wrote:
> 
> > +/* entry-from-user counter */
> > +static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
> 
> AFAICT from the below, this thing does *not* count entry-from-user. It
> might count a subset, but I need to stare longer.

Right, it's a subset.  Something like so:

/*
 * This is a unique percpu identifier for a given task entry context.
 * Conceptually, it's incremented every time the CPU enters the kernel from
 * user space, so that each "entry context" on the CPU gets a unique ID.  In
 * reality, as an optimization, it's only incremented on demand for the first
 * deferred unwind request after a given entry-from-user.
 *
 * It's combined with the CPU id to make a systemwide-unique "context cookie".
 */
static DEFINE_PER_CPU(u64, unwind_ctx_ctr);

-- 
Josh

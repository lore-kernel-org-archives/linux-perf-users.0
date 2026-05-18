Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9E23505E;
	Mon, 18 May 2026 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087051; cv=none; b=c2Nw5utdLOpdlXEFGLpDxe3LhYTI+zw3NFIiCxasx+eKCZIQQhIwgVsv8AG8qsvNqJz5h6BmgwTZdE/5/fa370Rf+iI7eb9N2xg16ynkFK37XaMOKpf5GZKp9KIkx87VB8bXoWLuaHi5v/dr4HIe5nQO1UROD53eOlZgYtoJyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087051; c=relaxed/simple;
	bh=2X31ZTZlDD4U/Dn+N9t5BUFl3vyfiwuau+dhhE7APV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktu9BTVIZz2WoWZlN2dQwTUtFdY57foBVDNskJFGAq2aLWnl4JVbzs35onWATOoO2ee3qwotqPx4FRZBP/xCFQuNV7fw6EEs6UEKnzGfEiZE2VrpEoolnK4ocN69HMJ6aB/phTnc27kd0kj4sgOPlJxSTmDg3jLT0e8Dzo4HIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIl2UGDY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIl2UGDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B92C2BCB7;
	Mon, 18 May 2026 06:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087050;
	bh=2X31ZTZlDD4U/Dn+N9t5BUFl3vyfiwuau+dhhE7APV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIl2UGDYfr+oKXZFQjfa7t5ZtXjqF1hZ5xIDVIz51e/UHPiIkwNJn+xXg0ZtPnjdY
	 A2CO6AXH2AgdPnL+9r9j2VUQ3mtG2JFXRNT07zicBjTDDEUoXYQ8ntNKfu+78liX42
	 qKAslHm2L6C3N70GC5fbvSB+0Plz46Pv0bJF+D9bqk4tZx82hSzP6ePW4WB3PBArUw
	 YUz1yNDydjZW8nMr8AeP2y6X2lJQpD3H34oT9Nb9Qe6nOygJrhGfdYfIWS65nyT/wZ
	 2QNJslFUP30m6/WbCWaw++Yp3JmyM54wS/1qvg6R6RM2HozbmlmIr27HCOQg6goykH
	 ANGDZKdhAkcEg==
Date: Sun, 17 May 2026 23:50:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	sean@ashe.io, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf trace: Introduce --show-cpu option to display
 cpu id
Message-ID: <agq2yOddNDgqjh5W@google.com>
References: <20260424212933.151154-1-atomlin@atomlin.com>
 <fjphwjezyi2rfq54kyx6f7z5nee2iurou4ll6rhlporzbqvonr@5qxhd7q6qvej>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fjphwjezyi2rfq54kyx6f7z5nee2iurou4ll6rhlporzbqvonr@5qxhd7q6qvej>

Hello,

On Sat, May 16, 2026 at 10:03:40AM -0400, Aaron Tomlin wrote:
> On Fri, Apr 24, 2026 at 05:29:33PM -0400, Aaron Tomlin wrote:
> > When tracing system-wide workloads or specific events, it is highly
> > valuable to know exactly which CPU executed a specific event. Currently,
> > perf trace output defaults to omitting CPU information.
> > 
> > Introduce a new "--show-cpu" command-line option. When provided, this
> > flag extracts the CPU from the perf sample and prints it in a "[000]"
> > format immediately following the timestamp. This mirrors the behaviour of
> > other tracing tools like ftrace and perf script. For example:
> > 
> >   # perf trace -e sched:sched_switch --max-events 5 --show-cpu
> >        0.000 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_prio: 120, next_comm: "rcu_preempt", next_pid: 16 (rcu_preempt), next_prio: 120)
> >        0.009 [002] rcu_preempt/16 sched:sched_switch(prev_comm: "rcu_preempt", prev_pid: 16 (rcu_preempt), prev_prio: 120, prev_state: 128, next_comm: "swapper/2", next_prio: 120)
> >        0.033 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_prio: 120, next_comm: "kworker/u32:48", next_pid: 35840 (kworker/u32:48-), next_prio: 120)
> >        0.041 [002] kworker/u32:48/35840 sched:sched_switch(prev_comm: "kworker/u32:48", prev_pid: 35840 (kworker/u32:48-), prev_prio: 120, prev_state: 128, next_comm: "swapper/2", next_prio: 120)
> >        0.045 [002] :0/0 sched:sched_switch(prev_comm: "swapper/2", prev_prio: 120, next_comm: "kworker/u32:48", next_pid: 35840 (kworker/u32:48-), next_prio: 120)
> > 
> > The feature is implemented strictly as an opt-in toggle to prevent
> > cluttering the standard output and to preserve backwards compatibility
> > for scripts parsing the default output format.
> 
> Hi Peter, Ingo, Arnaldo, Namhyung,
> 
> Just a gentle ping on this patch. It has been a few weeks since v4 was
> submitted [1].
> 
> Are there any further comments or revisions needed, or is this in a good
> state to be picked up?
> 
> [1]: https://lore.kernel.org/lkml/20260424212933.151154-1-atomlin@atomlin.com/

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


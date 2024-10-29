Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF22107;
	Tue, 29 Oct 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226883; cv=none; b=czVu1y7PCpaT0Tkfy8u7FXscJDUd/gfiD4+hWjtge5LmD0UeChTajSyu7cOyp/c9e0AluWr0Yd01v22v7yOwi/197SOUK9iAtOJTHVXWbuit7zj8a9CnFXvOg/4Qa9Mm2jE6Un4LxMLtKWFPKsoSMSzv/s2q+96Ikex5hfkyjoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226883; c=relaxed/simple;
	bh=EODAUXNVcC71MCCXMsrsilw4SOigG1r/H9SNpsFpuqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piLRsXZxmOubpN6HfFMN/AjWNcWBddcdIDxAe+UyZu0XHwgYIM3T21dYEdInuLdd8GddJzOD5VotyuLCu4ENyMkxnXcj/rLyrHvTGd2n8DKoKxC1ws7r/ynKWQfsIw8UaVKvaGPOiTYcDlP9upNpi4qD7ilkTQ9jYpP2eQASOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6xmXaYi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6xmXaYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745C8C4CECD;
	Tue, 29 Oct 2024 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226883;
	bh=EODAUXNVcC71MCCXMsrsilw4SOigG1r/H9SNpsFpuqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6xmXaYicjbqsZKBcoLttfPVngIuu/qQvvOocYnVA4si/VrHKBp0cBB7ve39Ut9Z5
	 JkokHRXmNwLivK1p/GRADJ3c9c8oo/rFDAWe7h+7GIf08ZiqM2zgrAtuOl+FP/GVbd
	 Agcb+KoIuS3/syqdbTKYE+f0qJ/zeAgD0I7Rp8fIkSjPptqQHRcCXd4ezWaJrJS6vA
	 gw0SNa8DxIU2nMu1iNErFnw0ULyZZz0O1Qdav123XWBH09OKSFqpOnZEYGkKYfzmoB
	 C/jXv6IfQczyDR1c1VavuzUZxd7lIF0zjOrbwnWoj/k3oCPpBIzR48soV9fABvVlci
	 Ia406QhHf9vAw==
Date: Tue, 29 Oct 2024 11:34:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241029183440.fbwoistveyxneezt@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>

On Tue, Oct 29, 2024 at 01:47:59PM -0400, Mathieu Desnoyers wrote:
> > > If ftrace needs brain damage like this, can't we push this to the user?
> > > 
> > > That is, do away with the per-cpu sequence crap, and add a per-task
> > > counter that is incremented for every return-to-userspace.
> > 
> > That would definitely make things easier for me, though IIRC Steven and
> > Mathieu had some concerns about TID wrapping over days/months/years.
> > 
> > With that mindset I suppose the per-CPU counter could also wrap, though
> > that could be mitigated by making the cookie a struct with more bits.
> > 
> 
> AFAIR, the scheme we discussed in Prague was different than the
> implementation here.

It does differ a bit.  I'll explain why below.

> We discussed having a free-running counter per-cpu, and combining it
> with the cpu number as top (or low) bits, to effectively make a 64-bit
> value that is unique across the entire system, but without requiring a
> global counter with its associated cache line bouncing.
> 
> Here is part where the implementation here differs from our discussion:
> I recall we discussed keeping a snapshot of the counter value within
> the task struct of the thread. So we only snapshot the per-cpu value
> on first use after entering the kernel, and after that we use the same
> per-cpu value snapshot (from task struct) up until return to userspace.
> We clear the task struct cookie snapshot on return to userspace.

Right, so adding some details to this, what I remember specifically
deciding on:

 - In unwind_user_deferred(), if task cookie is 0, it snapshots the
   per-cpu counter, stores the old value in the task cookie, and
   increments the new value (with CPU # in top 48 bits).

 - Future calls to unwind_user_deferred() see the task cookie is set and
   reuse the same cookie.

 - Then the task work (which runs right before exiting the kernel)
   clears the task cookie (with interrupts disabled), does the unwind,
   and calls the callbacks.  It clears the task cookie so that any
   future calls to unwind_user_deferred() (either before exiting the
   kernel or after next entry) are guaranteed to get an unwind.

That's what I had implemented originally.  It had a major performance
issue, particularly for long stacks (bash sometimes had 300+ stack
frames in my testing).

The task work runs with interrupts enabled.  So if another PMU interrupt
and call to unwind_user_deferred() happens after the task work clears
the task cookie but before kernel exit, a new cookie is generated and an
additional task work is scheduled.  For long stacks, performance gets
really bad, dominated by all the extra unnecessary unwinding.

So I changed the design a bit:

  - Increment a per-cpu counter at kernel entry before interrupts are
    enabled.

  - In unwind_user_deferred(), if task cookie is 0, it sets the task
    cookie based on the per-cpu counter, like before.  However if this
    cookie was the last one used by this callback+task, it skips the
    callback altogether.

So it eliminates duplicate unwinds except for the CPU migration case.

If I change the entry code to increment a per-task counter instead of a
per-cpu counter then this problem goes away.  I was just concerned about
the performance impacts of doing that on every entry.

-- 
Josh

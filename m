Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE717D355;
	Tue, 29 Oct 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221529; cv=none; b=VWkieU3uekYW7GqRNUXYNY5pJREEnxI+LD7vaMxJB6J8vGKCsN4GIgT+4wX39Hi60+sRgIkTsfFwCW/ZIYRloj+hAlgQlEO0c+rkf5ZGt7WlMevyPsdxi0rvTABiatxJ+6h8Kl0qvl/Fx2tJdIxk0GcfdZKDq8esabrNm3Isiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221529; c=relaxed/simple;
	bh=aMTC2oKgWzWSk/UJ4SA8OyecYycQ3lwvSz+25traKM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTB2PeECLmOLAt0BMW3F1tOhpZP0SO1pHMQb5rSEb//GYez+QNqP/2vlMuluJb/2jUSTC1Q7fysf8gUTrytx7xNbFL3ZNu2G9O/yc8kKeAQkEo879rizMIUTL4HlJ7SQQQX66JT9vgYWs7LoEAZx8aL69lf7XiAwrh/eWI1aBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shMB0R2I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shMB0R2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01FEC4CECD;
	Tue, 29 Oct 2024 17:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730221528;
	bh=aMTC2oKgWzWSk/UJ4SA8OyecYycQ3lwvSz+25traKM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shMB0R2I9iWsENoAPHjm4eUKcUGjn5moay4P2XvsScneSI4JN8rJdqnbPRvQwmMmj
	 3u/Zt3pixnq1FDgcgYN0W0HwamPJyewBgmOPQ2xEexpRFrYmv4hLIZG19S/LQ/Rew5
	 kEgt43lUhw7vYIYpxky+Au9t5k4eWpwOpCEx/R8hPSpCTuZjQ/GuBcKiCmVvLAFiaP
	 V5oFdtpMvo/bqBYT8B+wdmdNt7ey1JNo3XCz9qc93OLGLDh12bLf5rthKNES/MHxnp
	 gZHtzjxm5DLQK9HZnuXgNSO7k9TuY3XeQCiiS87hUsPF7CQIWPiYlbuA8olXLeX4MK
	 CLrltoSGLUjdA==
Date: Tue, 29 Oct 2024 10:05:26 -0700
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241029170526.5gdnqdlnoqsd7pxh@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029134918.GA14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029134918.GA14555@noisy.programming.kicks-ass.net>

On Tue, Oct 29, 2024 at 02:49:18PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:
> 
> > +static void unwind_user_task_work(struct callback_head *head)
> > +{
> ...
> > +	guard(rwsem_read)(&callbacks_rwsem);
> > +
> > +	for_each_set_bit(i, &pending, UNWIND_MAX_CALLBACKS) {
> > +		if (callbacks[i])
> > +			callbacks[i]->func(&trace, cookie, privs[i]);
> > +	}
> 
> I'm fairly sure people will come with pitchforks for that read-lock
> there. They scale like shit on big systems. Please use SRCU or somesuch.

I'd expect that unwind_user_{register,unregister}() would only be called
once per tracing component during boot so there wouldn't be any
contention.

But I think I can make SRCU work here.

-- 
Josh

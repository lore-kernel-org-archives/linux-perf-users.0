Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C17191473;
	Tue, 29 Oct 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222275; cv=none; b=Jp1F1lQSR3fJFpqnr0K/uamjFRS31y90UCLZFoAt5UX6tkRHclA1VG3EMeBNgwnj2cEWiHHi+FY6mnhUtssS5ciMDYfnW/eGHtl69rDgD3Diw2JMx8mreiS2Q6cAZnNTRjZD+DbJD//8/BcY/eMq94D7F0JGAkFRyX8HjKZtn5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222275; c=relaxed/simple;
	bh=3mkF/cT8YHRxMcJ7fQXvYLyYHDmqKFcg+RBRoPDt8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtyqyWBxtJOr7gKzZKN/EkZvS6YJs5kQkRaHmOHBLabSUNOjUBtXJm1RmB7hplIXBs/VzHYIB5luo/ONJI2FWNge/puxkX89ZtzifG6vOLlv1AFkGAvWrlybTKYiyzw9z/OZQUeBgmxc6EupAc/uPpwhxuBT5cOzpIaty4tNXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9432L5p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9432L5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F41C4CECD;
	Tue, 29 Oct 2024 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730222275;
	bh=3mkF/cT8YHRxMcJ7fQXvYLyYHDmqKFcg+RBRoPDt8dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9432L5p4K+AXTdBXo/dZ91no4Y1hI/j6ZXI0QnAiiLN+KHoReHz2C14WvEjB3X2d
	 lpD5o4BpR4iEahu3C6+0ROG7eP1khkEMFAE/JTH9cRVbYg4MKpjsxgxnmOco3mo5pP
	 yarDIuJgd2JUvgZ4pCISqnU8uUXgIo1VYsEoSN6pNGECqHh+pQWAMrnCOFcGWidwjP
	 ms6k2FQh2a/hIn3JFDFYHn02JLxcRdnHvTxr4Lj+nRuE5G1hL/T3BnOQVF1t1cYsGK
	 rwgizihJGWhItNmfFxFt0NM36aj5+aJJ06+b6a/ASZQ52EkONDEQn9eyZVbLeXVnFl
	 JBr6Mhw//1Jyg==
Date: Tue, 29 Oct 2024 10:17:52 -0700
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
Message-ID: <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029135617.GB14555@noisy.programming.kicks-ass.net>

On Tue, Oct 29, 2024 at 02:56:17PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 02:47:38PM -0700, Josh Poimboeuf wrote:
> 
> > + * The only exception is when the task has migrated to another CPU, *and* this
> > + * is called while the task work is running (or has already run).  Then a new
> > + * cookie will be generated and the callback will be called again for the new
> > + * cookie.
> 
> So that's a bit crap. The user stack won't change for having been
> migrated.
> 
> So perf can readily use the full u64 cookie value as a sequence number,
> since the whole perf record will already have the TID of the task in.
> Mixing in this CPU number for no good reason and causing trouble like
> this just doesn't make sense to me.
> 
> If ftrace needs brain damage like this, can't we push this to the user?
> 
> That is, do away with the per-cpu sequence crap, and add a per-task
> counter that is incremented for every return-to-userspace.

That would definitely make things easier for me, though IIRC Steven and
Mathieu had some concerns about TID wrapping over days/months/years.

With that mindset I suppose the per-CPU counter could also wrap, though
that could be mitigated by making the cookie a struct with more bits.

-- 
Josh

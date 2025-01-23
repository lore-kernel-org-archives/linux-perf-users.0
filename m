Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C7147C91;
	Thu, 23 Jan 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657059; cv=none; b=BAWTj31vKv1u00cuwj5TTqXL6NMy3HBiE4dizLiTWcbxsaHyts6q7h59MBJCxGuRsDraGHb3tDWG+U9b1+NaNWcDsVD5VujF6YKtA7u1uT1hw9E1KzIPEl1I1FxOum2HkI4tU1+vZM15TCwVKoUIxdV7HwEUweWTmnHI/kXyfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657059; c=relaxed/simple;
	bh=8NJCtbEEx5kYiy3UAc6g8mcWsZRKq/mcS6qEQQ3Y6NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD+OeiSIs7gubSNVmErWF8Hagv9wIX9/BqKxrL2y1s9cdALMFdByw2OdTUiJwmnCv/tNEOmDvKaPvZpEDAba6GdyScOLzz2IOk2LHLGlgjcYy1lb63USIJMPbKtlenCdXtT6R2Vxt0RqGGPUrbK9wYi/Mct+pIJ8ss1l1b4+mMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki/nxfcR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki/nxfcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B049C4CED3;
	Thu, 23 Jan 2025 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657059;
	bh=8NJCtbEEx5kYiy3UAc6g8mcWsZRKq/mcS6qEQQ3Y6NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ki/nxfcRzIGED0q/s+Aed7HRnfQ7FTZW72BQTKcBmUACrLMiGPhoHM4GLJ7DoAqGS
	 u05qvk6ECWvmL5PqcenRWPfpCku8HqsQB+trXBed+YOR2GIc0xphWKO+d5VDKaxZXq
	 5PdOHS+Sbi+2ZHpWmPpqSS9nWnVX0h92xVXrYrd99acipyudzN8bEgT7HpQq14t6Lx
	 o6P1+w3zqzDCnZUX0WNaHy6mIg573WDDBsvz0oVWnF9k5l6rz5bxFvPevydJJSNG/C
	 xhjqeXFvguQX3mJRokeBTAibsJMIvnVOLLOIz/1F3KnuIsVGu3kF8fM2a6arud0FPU
	 JJ1WPkTLlDbtA==
Date: Thu, 23 Jan 2025 10:30:56 -0800
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
Message-ID: <20250123183056.rnl4nbihml6pxx2n@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <20250122133730.GQ7145@noisy.programming.kicks-ass.net>
 <20250122141616.GU7145@noisy.programming.kicks-ass.net>
 <20250122225127.qhxmqamg7pnugnya@jpoimboe>
 <20250123081718.GC3808@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123081718.GC3808@noisy.programming.kicks-ass.net>

On Thu, Jan 23, 2025 at 09:17:18AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 02:51:27PM -0800, Josh Poimboeuf wrote:
> > On Wed, Jan 22, 2025 at 03:16:16PM +0100, Peter Zijlstra wrote:
> > The ctx_ctr is always incremented before calling this, so 0 isn't a
> > valid cookie.
> 
> Right, so that's the problem. You're considering 0 an invalid cookie,
> but ctx_to_cookie(0, 1<<48) will be a 0 cookie.
> 
> That thing *will* wrap.

Well, yes, after N years of sustained very high syscall activity on CPU
0, with stack tracing enabled, in which multiple tracer unwind requests
happen to occur in the same entry context where ctx_ctr wrapped, one of
the tracers might get an invalid cookie.

I can double-increment the counter when it's (1UL << 48) - 1).  Or use
some other bit for "cookie valid".

-- 
Josh

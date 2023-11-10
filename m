Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494BC2111E
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra52qHk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34C4C433CA;
	Fri, 10 Nov 2023 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699638048;
	bh=fGBoZnP2xadG2rKM/h58nMACuhHYVt8nwgYEioXQRuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ra52qHk0nia5r1gamKEdE1fvUzyjRyJfdaeqz0eIxLNQnsBNHSVR3J+/sUBfaHZwN
	 oVLfKTpF7lqP6eR2J856K67Er2OANg2u2FCoX/XjdAajlwN3fsco1DNbHFN2sS9yOF
	 NPS5bNlzwgaAUkU/8cnFk5MTh/bwqo6a4OR7H3fWQlVQjLEOkDiVbiu2XMVNRPd0Hx
	 ho2ctMiSYHRIk9kv6SkjTk8ghaa6BQe7JO1iZchC1ZosFp7sjyvEXdNVOihh+PbhEJ
	 0c6lP48US70DkRZrPh+rAxldVOp9ZXlVhZ6o3o5BoKGwIm8OWKJkyAvzx1guewIHGv
	 3Mjiu4HVRbY0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 48B3D40094; Fri, 10 Nov 2023 14:40:44 -0300 (-03)
Date: Fri, 10 Nov 2023 14:40:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Maksymilian Graczyk <maksymilian.graczyk@cern.ch>
Cc: Hao Luo <haoluo@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	linux-perf-users@vger.kernel.org,
	syclops-project <syclops-project@cern.ch>,
	Guilherme Amadio <guilherme.amadio@cern.ch>,
	Stephan Hageboeck <stephan.hageboeck@cern.ch>
Subject: long BPF stack traces Re: Broken stack traces with --call-graph=fp
 and a multi-threaded app due to page faults?
Message-ID: <ZU5rHB4DCiBqlKtC@kernel.org>
References: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
 <ZU5TZiXMUZ4VLOO+@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU5TZiXMUZ4VLOO+@kernel.org>
X-Url: http://acmel.wordpress.com

Em Fri, Nov 10, 2023 at 12:59:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 08, 2023 at 11:46:03AM +0100, Maksymilian Graczyk escreveu:
> > Alongside sampling-based profiling, I run syscall profiling with a separate
> > "perf record" instance attached to the same PID.

> > When I debug the kernel using kgdb, I see more-or-less the following
> > behaviour happening in the stack traversal loop in perf_callchain_user() in
> > arch/x86/events/core.c for the same thread being profiled:

> > 1. The first sample goes fine, the entire stack is traversed.
> > 2. The second sample breaks at some point inside my program, with a page
> > fault due to page not present.
> > 3. The third sample breaks at another *earlier* point inside my program,
> > with a page fault due to page not present.
> > 4. The fourth sample breaks at another *later* point inside my program, with
> > a page fault due to page not present.
 
> Namhyung, Jiri: ideas? I have to stop this analysis now, will continue later.

Would https://lore.kernel.org/all/20220225234339.2386398-7-haoluo@google.com/
this come into play, i.e. we would need to use a sleepable tp_btf (see
below about __get_user(frame.next_frame...) page faulting) in
tools/perf/util/bpf_skel/off_cpu.bpf.c, here:

[acme@quaco perf-tools-next]$ grep tp_btf tools/perf/util/bpf_skel/off_cpu.bpf.c
SEC("tp_btf/task_newtask")
SEC("tp_btf/sched_switch")
[acme@quaco perf-tools-next]$

But Hao's patch (CCed here) doesn't seem to have made its way to
tools/lib/bpf/, Hao, why this hasn't made into libbpf?

+	SEC_DEF("tp_btf.s/",            TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),

- Arnaldo
  
> > The stack frame addresses do not change throughout profiling and all page
> > faults happen at __get_user(frame.next_frame, &fp->next_frame). The
> > behaviour above also occurs occasionally in a single-threaded variant of the
> > code (without pthread at all) with a very high sampling frequency (tens of
> > thousands Hz).

> > This issue makes profiling results unreliable for my use case, as I usually
> > profile multi-threaded applications with deep stacks with hundreds of
> > entries (hence why my test program also produces a deep stack) and use flame
> > graphs for later analysis.

> > Could you help me diagnose the problem? For example, what may be the cause
> > of my page faults? I also did tests (without debugging though) without
> > syscall profiling and the "--off-cpu" flag, broken stacks still appeared.

> > (I cannot use DWARF because it makes profiling too slow and perf.data size
> > too large in my tests. I also want to avoid using
> > non-portable/vendor-specific stack unwinding solutions like LBR, as we may
> > need to run profiling on non-Intel CPUs.)

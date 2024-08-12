Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561042B9B5;
	Mon, 12 Aug 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481557; cv=none; b=Y2ScAw5jZOWhqhl22C84oI7avq16rRCAf8OHGIk31rxuuWEb+L91hFO603m1zZQGNXgXvUbm/AZiglhP4L/0iYl5HfD7A9cdqSQEBEAyeA3vS31eL2xy8OZ0vkY56HBuljaPZfzB1/vrHorzw3/yzNbTNCA8MidOj/R6l1bHrnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481557; c=relaxed/simple;
	bh=3qgWsQdcGADenlHvP4FzflqDdjCwLUTzchk8IpLtHEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1EnDXPmZ9cfoATDbTMlbGxx0Sb+TVI+QhF7zsJB5g1HWjMUmrhutp9OgPG/B+0XGB1kTiO1OXOpMeTzlIvmok/b0DFpqeuYciqKPserJux3B1Lp9SAcbYNf/H1qVTD5eJNkdyqesSW8rqf36P+Dv36mtXXKahyY4YwCsTJE1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzPs7Cj6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzPs7Cj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4ABC32782;
	Mon, 12 Aug 2024 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481556;
	bh=3qgWsQdcGADenlHvP4FzflqDdjCwLUTzchk8IpLtHEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JzPs7Cj69J7IapWJHuXuddKKRI/y4kI7wkwxIH2RkzApfZgenHAtTB+i7YQn8g7/6
	 BNa21TjkCtpg3ilPqdmGrWtAc7T2YYdgGG1xYX8gao+rkWH2ZJbMl6HA59kDH6J8NY
	 7t2rXEs5B/SpEPNrrJlK7CxTtdzR0KzHfKCiDu6h5EMWkyfQTQOGqaro4uKR/j0d/2
	 z10WZUgEbUpsbsKnXN98A25Kc0fCVPuVn4RLDHkwN4S0gJ78+bsaahae6LZ7238DqP
	 YsFELV6gpzLkljOd2xmPY+Gg1h87kiyenYFrZQXsIkTmGQGfq2La7uLNCMgrv4wEtb
	 AXRJwcPTUq+Cw==
Date: Mon, 12 Aug 2024 13:52:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] perf lock contention: Change stack_id type to s32
Message-ID: <Zro90YPyLCB9PsfL@x1>
References: <909abbc8-efca-40df-9876-8c36b6942a83@stanley.mountain>
 <20240810191704.1948365-1-namhyung@kernel.org>
 <ZrozwIQcB_viRsKt@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrozwIQcB_viRsKt@x1>

On Mon, Aug 12, 2024 at 01:09:40PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, Aug 10, 2024 at 12:17:04PM -0700, Namhyung Kim wrote:
> > The bpf_get_stackid() helper returns a signed type to check whether it
> > failed to get a stacktrace or not.  But it saved the result in u32 and
> > checked if the value is negative.
> > 
> >       376         if (needs_callstack) {
> >       377                 pelem->stack_id = bpf_get_stackid(ctx, &stacks,
> >       378                                                   BPF_F_FAST_STACK_CMP | stack_skip);
> >   --> 379                 if (pelem->stack_id < 0)
> > 
> >   ./tools/perf/util/bpf_skel/lock_contention.bpf.c:379 contention_begin()
> >   warn: unsigned 'pelem->stack_id' is never less than zero.
> > 
> > Let's change the type to s32 instead.
> > 
> > Fixes: 6d499a6b3d90 ("perf lock: Print the number of lost entries for BPF")
> 
> Thanks, applied to perf-tools-next,

I'll try to fix this later, but now it fails the first 'make -C
tools/perf build-test' target, that you can run directly as:

⬢[acme@toolbox perf-tools-next]$ tools/perf/tests/perf-targz-src-pkg tools/perf
<SNIP>
  CLANG   /tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
In file included from util/bpf_skel/lock_contention.bpf.c:9:
util/bpf_skel/lock_data.h:10:2: error: unknown type name 's32'; did you mean 'u32'?
   10 |         s32 stack_id;
      |         ^~~
      |         u32
util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
   17 | typedef __u32 u32;
      |               ^
In file included from util/bpf_skel/lock_contention.bpf.c:9:
util/bpf_skel/lock_data.h:14:2: error: unknown type name 's32'; did you mean 'u32'?
   14 |         s32 stack_id;
      |         ^~~
      |         u32
util/bpf_skel/vmlinux.h:17:15: note: 'u32' declared here
   17 | typedef __u32 u32;
      |               ^
2 errors generated.
make[2]: *** [Makefile.perf:1247: /tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:292: sub-make] Error 2
make: *** [Makefile:76: all] Error 2
make: Leaving directory '/tmp/tmp.FRZLVEwqdz/perf-6.11.0-rc2/tools/perf'
⬢[acme@toolbox perf-tools-next]$

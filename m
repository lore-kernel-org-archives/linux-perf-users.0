Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC01FDFBD;
	Wed, 23 Oct 2024 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721981; cv=none; b=XpZPoI5JQKi/Nl2xznqlh7PHrMqTp2pYhEIB82/80i8VPbRx4zu8aCwn9jsBeZ6fLIY4KukdcJJGEuuFLZn/3bZOA9GHPtnZhTi4MMhk0Ac+1VoFvQ8I8MQF9K/o0J/IYda7YQK2W9kCMZfBqqQ6LA8VXq6wGvy0w5lIYe9uQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721981; c=relaxed/simple;
	bh=Dw3jN8UXPpeXAOKIsCxlxoWmdgdYhKqQcjOgPzGKFtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBYFCSbTztuA18jAEiVELRsaXf400FvWKvFoGlNXZn+bl3GArpuvL94wnOwStvRD0N24s3KyS5hiHLYUXhuL92ZhKrH2fg6kImSU/bXiCfuK5HBBnIhlD8wmsal2xqzJ2j/ZEQrdG6lFpq83eo7FL+XN/+DXbuYA75hge3YCFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+i2VPDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+i2VPDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECE3C4CEE5;
	Wed, 23 Oct 2024 22:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729721980;
	bh=Dw3jN8UXPpeXAOKIsCxlxoWmdgdYhKqQcjOgPzGKFtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+i2VPDcRJO+rZIfGLFWo1W7lL2FvKjHO9Ci72s6U/byaYNDCwumTNYwsYabcCQNi
	 0qe2/NDwbsE3C9DvoEUJ69tiVY6awS9BuYrqFMTloYwLgaf9ovfDX5+yOB70m3EvVK
	 yLCT0EQoS9FnZodTalFgd8DkojLr3fkNEMcxuHuMzKEM/vojp1gQ+gdmZdim8DHXBz
	 BKtgCDidcwJYNecErjLWNZuZG2UAIyCNlUcGSw9Y51Sz0E0tbcJ7GaxBVNVtgdrRK9
	 JXQRsTMuu2t5iUPyrtQ4HMYanH/hT9Ca6qINmYYw+fuOv75Z0jGjRA/Gec3bu+/zAI
	 XCfZSRf6sIvqg==
Date: Wed, 23 Oct 2024 15:19:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf check: Add sanitizer feature and use to avoid
 test failure
Message-ID: <Zxl2etmBtc5XsQ3p@google.com>
References: <20241018055627.1005723-1-irogers@google.com>
 <Zxc6_jZdDcWgtEom@google.com>
 <CAP-5=fU04PAN4T=7KuHA4h+po=oTy+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com>
 <ZxiVKvmzjeHd4xBQ@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxiVKvmzjeHd4xBQ@google.com>

On Tue, Oct 22, 2024 at 11:18:18PM -0700, Namhyung Kim wrote:
> On Tue, Oct 22, 2024 at 10:39:36AM -0700, Ian Rogers wrote:
> > Sure, the reproduction is trivial, just add -fsanitize=address, so I'm
> > surprised you're not already seeing it:
> > ```
> > $ perf test annotate -v
> > --- start ---
> > test child forked, pid 444258
> >  68e8a0-68e96b l noploop
> > perf does have symbol 'noploop'
> > Basic perf annotate test
> >          : 0      0x68e8a0 <noploop>:
> >     0.00 :   68e8a0:       pushq   %rbp
> >     0.00 :   68e8a1:       movq    %rsp, %rbp
> >     0.00 :   68e8a4:       subq    $0x30, %rsp
[...]
> >     0.00 :   92d6:       shrl    %cl, %edx
> >     0.00 :   92d8:       movl    %edx, %ecx
> >     0.00 :   92da:       movq    %rax, %rdx
> > Basic annotate [Failed: missing disasm output when specifying the target symbol]
> 
> Hmm.. this is strange.  The error message says it failed when it
> specified the target symbol (noploop) for perf annotate.
> 
> As it's the dominant symbol, it should have the same output for the
> first function (noploop) whether it has target symbol or not and it
> should match the disasm_regex.  I'm curious how it can fail here.

Hmm.. ok.  For some reason, it wasn't failed when I add DEBUG=1.

Without DEBUG, I can see it now.

=================================================================
==1053492==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 33 byte(s) in 1 object(s) allocated from:
    #0 0x7f1ad78edd20 in strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:566
    #1 0x55eda19cb76f in perf_data__open (linux/tools/perf/perf+0x65276f) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
    #2 0x55eda18ffafa in __perf_session__new (linux/tools/perf/perf+0x586afa) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
    #3 0x55eda15485d3 in cmd_annotate (linux/tools/perf/perf+0x1cf5d3) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
    #4 0x55eda1695467 in run_builtin (linux/tools/perf/perf+0x31c467) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
    #5 0x55eda1695c0e in handle_internal_command (linux/tools/perf/perf+0x31cc0e) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
    #6 0x55eda153ba72 in main (linux/tools/perf/perf+0x1c2a72) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
    #7 0x7f1acda43b89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58

SUMMARY: AddressSanitizer: 33 byte(s) leaked in 1 allocation(s).
Unexpected signal in test_basic

No idea how it can leak the data->file.path (that's what I can find
where strdup is used in the function).

Thanks,
Namhyung


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674420011A;
	Wed, 23 Oct 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729725891; cv=none; b=VI7DQhRGu6PYsyfG6r7p/3jzp+O+fqnUIMIDodViBlv4wFVvlQUVL9TJlYLI/xiBF3UNEpor5J/yNxgH9HyJfH4EYIPX9Bt/zARGReLqJhK912dY314Q56bgPMcY57eBn82SCBO173bPmGwdlgv3nY2edd5z+GXA6shzs0R7BwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729725891; c=relaxed/simple;
	bh=TQUgDuQJ+FX7ZOLQyK6su2b3Qlq/Yhgy8JGEFUSRJ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ossmO/tYG1drnxBD41w4oVHY7PIxg/Ban1GrR5033REW8T4JiKMS15rOKLaDNoPHzk/BZa5Ilby8xDQRhDU+W9xFteMSAk4LS26LLBkmRybETILicj7dyhwTNNGIL1Zcqu77bSKWjqp9xgYFjjN82va0lljiGhyQ6/QKu76BCHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzWfsSzQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzWfsSzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90613C4CEC6;
	Wed, 23 Oct 2024 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729725891;
	bh=TQUgDuQJ+FX7ZOLQyK6su2b3Qlq/Yhgy8JGEFUSRJ+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzWfsSzQpbcGLOWI1EZTgcRmDr4aSiLdi8ofCGpiDKu2qFK5iVDT913MjN+zGHpj3
	 3pjo5T9JaWLXc0rwPKXN9e6ZhDVjiOirG/p/cIxDD8r2ADNL7azryJ3a6LcS+oBA0z
	 IaOZ0GLBJCcb3y475wZr/PlnrqKF8bS6UnWmZ36SkmXL4jHsUXlezDavzHx+ecNqy/
	 URnpUe7NFkQ8qPCjQS5CTvO0gRH/UH4uq6ZPNwifyo3nc5//SrwZ9gUZGr7b7VICoE
	 mIJIWBJHivUVie8xuEFllHrZ6YRCQ6Av7SSy2XTgxoa7yuEQNWg+SKvnzN6EGk1gMb
	 L7LQ7lLWuNpWA==
Date: Wed, 23 Oct 2024 16:24:49 -0700
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
Message-ID: <ZxmFwUPyD34LqAHX@google.com>
References: <20241018055627.1005723-1-irogers@google.com>
 <Zxc6_jZdDcWgtEom@google.com>
 <CAP-5=fU04PAN4T=7KuHA4h+po=oTy+6Nbee-Gvx9hCsEf2Lh0w@mail.gmail.com>
 <ZxiVKvmzjeHd4xBQ@google.com>
 <Zxl2etmBtc5XsQ3p@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxl2etmBtc5XsQ3p@google.com>

On Wed, Oct 23, 2024 at 03:19:38PM -0700, Namhyung Kim wrote:
> On Tue, Oct 22, 2024 at 11:18:18PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 22, 2024 at 10:39:36AM -0700, Ian Rogers wrote:
> > > Sure, the reproduction is trivial, just add -fsanitize=address, so I'm
> > > surprised you're not already seeing it:
> > > ```
> > > $ perf test annotate -v
> > > --- start ---
> > > test child forked, pid 444258
> > >  68e8a0-68e96b l noploop
> > > perf does have symbol 'noploop'
> > > Basic perf annotate test
> > >          : 0      0x68e8a0 <noploop>:
> > >     0.00 :   68e8a0:       pushq   %rbp
> > >     0.00 :   68e8a1:       movq    %rsp, %rbp
> > >     0.00 :   68e8a4:       subq    $0x30, %rsp
> [...]
> > >     0.00 :   92d6:       shrl    %cl, %edx
> > >     0.00 :   92d8:       movl    %edx, %ecx
> > >     0.00 :   92da:       movq    %rax, %rdx
> > > Basic annotate [Failed: missing disasm output when specifying the target symbol]
> > 
> > Hmm.. this is strange.  The error message says it failed when it
> > specified the target symbol (noploop) for perf annotate.
> > 
> > As it's the dominant symbol, it should have the same output for the
> > first function (noploop) whether it has target symbol or not and it
> > should match the disasm_regex.  I'm curious how it can fail here.
> 
> Hmm.. ok.  For some reason, it wasn't failed when I add DEBUG=1.

Oh, now I'm seeing why.  We skip perf_session__delete() on !DEBUG build.
:(

> 
> Without DEBUG, I can see it now.
> 
> =================================================================
> ==1053492==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 33 byte(s) in 1 object(s) allocated from:
>     #0 0x7f1ad78edd20 in strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:566
>     #1 0x55eda19cb76f in perf_data__open (linux/tools/perf/perf+0x65276f) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
>     #2 0x55eda18ffafa in __perf_session__new (linux/tools/perf/perf+0x586afa) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
>     #3 0x55eda15485d3 in cmd_annotate (linux/tools/perf/perf+0x1cf5d3) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
>     #4 0x55eda1695467 in run_builtin (linux/tools/perf/perf+0x31c467) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
>     #5 0x55eda1695c0e in handle_internal_command (linux/tools/perf/perf+0x31cc0e) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
>     #6 0x55eda153ba72 in main (linux/tools/perf/perf+0x1c2a72) (BuildId: 6fc1b7cdc123c7bd586ce55ea8b727875f42cda2)
>     #7 0x7f1acda43b89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
> 
> SUMMARY: AddressSanitizer: 33 byte(s) leaked in 1 allocation(s).
> Unexpected signal in test_basic
> 
> No idea how it can leak the data->file.path (that's what I can find
> where strdup is used in the function).

Maybe we need to revisit how much speed up it can give.

Thanks,
Namhyung


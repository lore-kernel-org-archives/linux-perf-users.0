Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778412;
	b=1o/Mv1SdoIahrMUNS2SYlJV2+Znw7hXOjABf6JrkWunxG5VysXJreu30tAZXUC8ssdxT
	 XEckd0qosqeueex0D15cF8U602IrEHc1Rd3CbmhAGlZHk3eCHtVNOoUTI69JewHznqOPy
	 RFJOBaqoBNciTtdnWTtcxQ6F7/GI+b6lrHYrLScv86f/9H7lvb2w1f13WrDDvgWz9tMlc
	 VtcGUK5vsA8XDzblsluYHIfebgD1a/94+NJR+MdsLAtoVPK15rSskj/k6UmyU7hJZIQaQ
	 +0u66ee65EoKCVCRbbXF/PmDxgczUZw9Pra/z2aopV9K1CyP8R02FRuyxymAlRKAJag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778412;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=rlCf1eERwwKr4Aym6e2l6RBl0JDFs9iXKjBzurv9y80=;
	b=Bdb2dOBFBxpvD2I3xN2sjyCnpZhlsMlcF+d+xTalUMmz+2U3YnHxhMgBg67Dp+8Ww5gD
	 7ctG4x48A2gHlIohZeySjzFrPqZFlLyB31EjlupbhUqYoZL/oj061pu7NqEGJvBiTt6cC
	 BJzJPFdLQLve8BWqrD9JJdOimSi790gcGICuScem690OwR629WQJSiagKxYeE3zD234Vv
	 3lT3o55BkCS7HtdE8B26pRyXBJ43qF86Z2/fYSa1B2DE2ZlBqPtUb/zzMFTunIvmsZMY1
	 750GfjnAjgv5qPYajLU/D1mgn8I/bGUgRWqbhZ5fLLw+P/qJnIOvStVhbKVUfnXRh+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtqzeBsu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A3606D818;
	Wed,  4 Nov 2026 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtqzeBsu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE891F00A28;
	Wed,  4 Nov 2026 07:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793778411;
	bh=rlCf1eERwwKr4Aym6e2l6RBl0JDFs9iXKjBzurv9y80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BtqzeBsuYwQEZl4AGp/iGWkKHvaVNJhMZm7FiHU477IKFxQu9PUTEIRgo+9wrHoRe
	 cuHY+AZhuH2IYCv+kn1vNI/ekjqz1tfnfnovLJu+wGC18jP3gl6aFm20snGgwpLASi
	 YkXhOky+BdrM34qiGIXKDpeWcf86r62v8ra5yhMM1PB64GIwlGQSKb/uAC2VRPRvJ2
	 7J+JlbBcFfmO6qODCk7kvpA2loMYx2TY9ZLasoqmcMLv/AEmLB6M3jGQ5zuAx6GN2Y
	 lx1LSgqkiVyQH6mlrnmVaYcHgeStHxQu+N4KXwFfn3nIvgHH1pWMFBsRi7kBq8paP9
	 XqI+NW4yORGIw==
Date: Tue, 3 Nov 2026 23:46:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 06/10] perf ftrace: Support display
 of inlined functions in function graph tracer
Message-ID: <auri6Q6oisHLi9Y6@z2>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-7-atomlin@atomlin.com>
 <auZ6tj_5-m1MNGDM@z2>
 <zri4x5jfbpykc7jxdicixkrjdw4f7tui72t7is3mos6cnzbhj5@2wct4vkl7sno>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zri4x5jfbpykc7jxdicixkrjdw4f7tui72t7is3mos6cnzbhj5@2wct4vkl7sno>

On Mon, Nov 02, 2026 at 02:20:47PM -0500, Aaron Tomlin wrote:
[SNIP]
> > > +		cs->stack[cs->depth].inlined = true;
> > > +		cs->stack[cs->depth].indent = entry_indent;
> > > +		cs->stack[cs->depth].raw_indent = -1;
> > 
> > I'm curious if it's possible to get rid of the indent and raw_indent.
> > I think you can get the indent from the depth easily.  The raw indent
> > would be from any non-inlined parent if needed.  Also having inlined
> > depth in the cs/ts seems unnecessary.  What do you think?
> 
> We still need to record the trace line's indentation rather than deriving
> it purely from ts->depth * 2 because tracing can start mid-callchain (or
> after ring-buffer drops), where ts->depth == 0 has a non-zero kernel
> indentation (e.g. 6 or 8 spaces), and bare "}" exits must be matched
> against that kernel indentation.

Right, but it may start from non-zero depth then.  Probably save the
starting depth in the ts struct.

> 
> However, we do not need both indent and raw_indent on struct
> ftrace_stack_frame, nor do we need inlined_depth in struct
> ftrace_task_state:
> 
>     1.  In struct ftrace_stack_frame, indent was only used for inlined
>         frames and raw_indent was only used for non-inlined frames, so they
>         can be consolidated into a single indent field.
> 
>     2.  In struct ftrace_task_state, inlined_depth can be dropped
>         altogether and computed from the active inlined frames on ts->stack
>         when needed.
> 
> I will simplify both structures accordingly.

Thanks!

> 
> > > +#define FTRACE_MAX_INLINES 32
> > 
> > Isn't 32 too big?  I guess 8 would be enough..
> 
> No, 8 is not enough in practice. I will prefer to keep 32.
> For instance, after a -O2 kernel build:
> 
> ❯ addr2line -f -i -e vmlinux 0xffffffff816916e9
>       __do_trace_rss_stat
>       include/trace/events/kmem.h:427 (discriminator 20)
>       trace_rss_stat
>       include/trace/events/kmem.h:427 (discriminator 20)
>       mm_trace_rss_stat
>       mm/memory.c:169 (discriminator 20)
>       add_mm_counter
>       include/linux/mm.h:3469 (discriminator 20)
>       add_mm_rss_vec
>       mm/memory.c:492 (discriminator 20)
>       zap_pte_range
>       mm/memory.c:2087 (discriminator 20)
>       zap_pmd_range
>       mm/memory.c:2151 (discriminator 20)
>       zap_pud_range
>       mm/memory.c:2179 (discriminator 20)
>       zap_p4d_range
>       mm/memory.c:2200 (discriminator 20)
>       __zap_vma_range
>       mm/memory.c:2240 (discriminator 20)
> 
> Another example:
> 
> ❯ addr2line -f -i -e vmlinux 0xffffffff821c34af
>       constant_test_bit
>       arch/x86/include/asm/bitops.h:202
>       arch_test_bit
>       arch/x86/include/asm/bitops.h:232
>       _test_bit
>       include/asm-generic/bitops/instrumented-non-atomic.h:142
>       test_ti_thread_flag
>       include/linux/thread_info.h:133
>       test_tsk_thread_flag
>       include/linux/sched.h:2102
>       task_sigpending
>       include/linux/sched/signal.h:384
>       fatal_signal_pending
>       include/linux/sched/signal.h:406
>       ptrace_report_syscall
>       include/linux/ptrace.h:427
>       ptrace_report_syscall_exit
>       include/linux/ptrace.h:477
>       arch_ptrace_report_syscall_exit
>       include/linux/entry-common.h:233
>       syscall_exit_work
>       include/linux/entry-common.h:266
>       syscall_exit_to_user_mode_work
>       include/linux/entry-common.h:297
>       syscall_exit_to_user_mode
>       include/linux/entry-common.h:334
>       do_syscall_64
>       arch/x86/entry/syscall_64.c:89

Oh, indeed.  Thanks for providing this!

Namhyung


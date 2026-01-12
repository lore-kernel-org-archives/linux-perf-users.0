Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2B23ED6A;
	Mon, 12 Jan 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234557; cv=none; b=QcvH9xqPnLaPlI0Nisz/J4VBWaISTwCZbEfSo1YxjGVtRSP24pwnxRju5/hJ+rYPifUj4jdOu/IlzodVtKmohczte/+IB40mPS4+H/rVdICsV+h+zfbylx8Y3yliu8xOQuvkpqLhOGG5mfWI7ubtgu3KEgtck3GYzouz36LL8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234557; c=relaxed/simple;
	bh=eI8C8BtDMPqSFRxHRe5KQNURmveRuV+sdj74r3IkIyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+lG5X9hip+piF9UN2Pmfsw9JrzRZsNMK2IrY2AFMDmtDSyFNegcMmi2AjuRip5KxSFYN1Tg7gNqS+ZooGXtNyNlXYKZMJr5f4g91bHToMYGtJyq/EgjVNC/xxVq7zc9WsZec4o2GfSvq/S9pJxIvPHPtZjSQxTy07oz/WLIpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnvYy0hN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnvYy0hN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D58C116D0;
	Mon, 12 Jan 2026 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768234557;
	bh=eI8C8BtDMPqSFRxHRe5KQNURmveRuV+sdj74r3IkIyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnvYy0hN/8mVEw+0u+XM+aMPj1rLiTn5BKzlaPyMAPqnObPQpJF0Zxzv/hnEWGDQx
	 o0AtIYw1N3tBsnyGcD3vaytaTepZHnhxh4DHZrvldB1paSDSDi3PX7tg8YcdHY3SBw
	 qdcvW3+vXHgSf/VK1T/M9HZuuBpifTAoBJaIVlH/cZESvB2wiUUKqGNiLCoY8zPhT6
	 B7PTzN0ggIKP2oALcwwWthdNl8PK+GZRd/lCVe6UL11R7yIPK7m1YTYRLYjtvlk2Ck
	 UZxM7fjocWwNetgUPpw14c/DMv1G2VkuQJvp8qL2CxR/cjYcgAY3oFwUl/gO8/Bv8R
	 j/rhE5/imOw4Q==
Date: Mon, 12 Jan 2026 09:15:53 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH] perf: fix segfault in `lock contention -b`
Message-ID: <aWUeOQbFOZ2CVBG2@tycho.pizza>
References: <20260109164417.396138-1-tycho@kernel.org>
 <aWGh_XNyt-hmSamy@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGh_XNyt-hmSamy@google.com>

On Fri, Jan 09, 2026 at 04:49:01PM -0800, Namhyung Kim wrote:
> On Fri, Jan 09, 2026 at 09:44:17AM -0700, Tycho Andersen wrote:
> > From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> > 
> > When run on a kernel without BTF info, I get:
> > 
> >     libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> >     libbpf: failed to find valid kernel BTF
> > 
> >     Program received signal SIGSEGV, Segmentation fault.
> >     0x00005555556915b7 in btf.type_cnt ()
> >     (gdb) bt
> >     #0  0x00005555556915b7 in btf.type_cnt ()
> >     #1  0x0000555555691fbc in btf_find_by_name_kind ()
> >     #2  0x00005555556920d0 in btf.find_by_name_kind ()
> >     #3  0x00005555558a1b7c in init_numa_data (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:125
> >     #4  0x00005555558a264b in lock_contention_prepare (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:313
> >     #5  0x0000555555620702 in __cmd_contention (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2084
> >     #6  0x0000555555622c8d in cmd_lock (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2755
> >     #7  0x0000555555651451 in run_builtin (p=0x555556104f00 <commands+576>, argc=3, argv=0x7fffffffea10)
> >         at perf.c:349
> >     #8  0x00005555556516ed in handle_internal_command (argc=3, argv=0x7fffffffea10) at perf.c:401
> >     #9  0x000055555565184e in run_argv (argcp=0x7fffffffe7fc, argv=0x7fffffffe7f0) at perf.c:445
> >     #10 0x0000555555651b9f in main (argc=3, argv=0x7fffffffea10) at perf.c:553
> > 
> > If we really are running -b without BTF info, the error is fatal, so let's
> > propagate it and exit accordingly.
> 
> Thanks for the patch.
> 
> I'm curious how the kernel will react if we want to load the BPF.
> Probably the verifier will reject as it calls some helpers like
> bpf_get_current_task_btf().
> 
> I think it used to work without BTF - the callstack (default) and task
> output mode won't need it.  It'd be nice if we could run it when the
> kernel doesn't have BTF.  But maybe it's out of scope of this patch.
> 
> That said, can you add a NULL check in the init_numa_data() instead
> and see how far it can go?

Looks like not much further, it fails in lock_contention_bpf__load():

./perf lock contention -b
libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
libbpf: failed to find valid kernel BTF
libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -ESRCH
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
Failed to load lock-contention BPF skeleton
lock contention BPF setup failed

Tycho

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEB280A21;
	Tue, 13 Jan 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339134; cv=none; b=SYmTASi8Trp88ySu17RaGyZXmvraxZ9faP30ZDTKSVMyA+76WXon5S9BheGHCbjxrzPWUFPyeJiebM4tTbWgX7zkV4BxciCeKjf0xMbMcNvJcOU8xZaodE8HEbp6E4B3hRoRN727XGHjlH65PQHMBk7cAq6lcc3bOYHREEDrivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339134; c=relaxed/simple;
	bh=urXJR1wqdryg4e2LlRJgqtRcoggpXmHJNpnRVXaJwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqYVbKi9OsRAPEVgqXa5yVtJgHJLaKtwTxlljs3ZZLeyL6vfLGdbyiH75j6O0EI2tuNVCdAk9swWsiLOC0l7C/qj7iCWcrYFFZiz3hj/Czg9t50ys1ubppnbTe8AfSwQRqnEvZHlcIFD3HkTbkGHANmKNr1wr+bS4bScb4L64xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN9PPapZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN9PPapZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD7C116C6;
	Tue, 13 Jan 2026 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768339134;
	bh=urXJR1wqdryg4e2LlRJgqtRcoggpXmHJNpnRVXaJwFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WN9PPapZP4Tt3nCBK+irFt0H66WnbMazIIMPR9ugwq1IwHDpH2HmGT0cx24OuNqns
	 9FGnpoSnpzHpKyH7B/q5/FH3TXVgYQW6Mrdb1cus3pMl/HpRoFBrjEd6L4gTzUdQAA
	 8RytrCP7NgFZ0ZhxMrX5k8NI+Ti+w9+r/dxdhSF7ibe+mXxXZ/ImALUhUerRyUEMVj
	 XvU/zUiQJD4fh8zMpUzlIUDWi35ZM1X5teHkcD5fWI/zy+JYLG8KDi2MtB4EXkXHMV
	 oOLUJXl3RpL3Sre6nGAocrHNutcAdBL2eTiHuLkmNRXt8h7iYlF5xCpdV2EMs7hRgG
	 M0dP81VhZ2ucQ==
Date: Tue, 13 Jan 2026 13:18:52 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Tycho Andersen <tycho@kernel.org>
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
Message-ID: <aWa2vDy_0QGh_a20@google.com>
References: <20260109164417.396138-1-tycho@kernel.org>
 <aWGh_XNyt-hmSamy@google.com>
 <aWUeOQbFOZ2CVBG2@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWUeOQbFOZ2CVBG2@tycho.pizza>

On Mon, Jan 12, 2026 at 09:15:53AM -0700, Tycho Andersen wrote:
> On Fri, Jan 09, 2026 at 04:49:01PM -0800, Namhyung Kim wrote:
> > On Fri, Jan 09, 2026 at 09:44:17AM -0700, Tycho Andersen wrote:
> > > From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> > > 
> > > When run on a kernel without BTF info, I get:
> > > 
> > >     libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> > >     libbpf: failed to find valid kernel BTF
> > > 
> > >     Program received signal SIGSEGV, Segmentation fault.
> > >     0x00005555556915b7 in btf.type_cnt ()
> > >     (gdb) bt
> > >     #0  0x00005555556915b7 in btf.type_cnt ()
> > >     #1  0x0000555555691fbc in btf_find_by_name_kind ()
> > >     #2  0x00005555556920d0 in btf.find_by_name_kind ()
> > >     #3  0x00005555558a1b7c in init_numa_data (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:125
> > >     #4  0x00005555558a264b in lock_contention_prepare (con=0x7fffffffd0a0) at util/bpf_lock_contention.c:313
> > >     #5  0x0000555555620702 in __cmd_contention (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2084
> > >     #6  0x0000555555622c8d in cmd_lock (argc=0, argv=0x7fffffffea10) at builtin-lock.c:2755
> > >     #7  0x0000555555651451 in run_builtin (p=0x555556104f00 <commands+576>, argc=3, argv=0x7fffffffea10)
> > >         at perf.c:349
> > >     #8  0x00005555556516ed in handle_internal_command (argc=3, argv=0x7fffffffea10) at perf.c:401
> > >     #9  0x000055555565184e in run_argv (argcp=0x7fffffffe7fc, argv=0x7fffffffe7f0) at perf.c:445
> > >     #10 0x0000555555651b9f in main (argc=3, argv=0x7fffffffea10) at perf.c:553
> > > 
> > > If we really are running -b without BTF info, the error is fatal, so let's
> > > propagate it and exit accordingly.
> > 
> > Thanks for the patch.
> > 
> > I'm curious how the kernel will react if we want to load the BPF.
> > Probably the verifier will reject as it calls some helpers like
> > bpf_get_current_task_btf().
> > 
> > I think it used to work without BTF - the callstack (default) and task
> > output mode won't need it.  It'd be nice if we could run it when the
> > kernel doesn't have BTF.  But maybe it's out of scope of this patch.
> > 
> > That said, can you add a NULL check in the init_numa_data() instead
> > and see how far it can go?
> 
> Looks like not much further, it fails in lock_contention_bpf__load():
> 
> ./perf lock contention -b
> libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> libbpf: failed to find valid kernel BTF
> libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -ESRCH
> libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
> Failed to load lock-contention BPF skeleton
> lock contention BPF setup failed

Thanks for checking this.  I think it's ok to fail like this when BTF is
not enabled.  Let me see if I can make some changes to run without it
later.

Thanks,
Namhyung


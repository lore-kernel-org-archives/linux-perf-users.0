Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36528D8F1;
	Thu,  4 Dec 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861468; cv=none; b=C4wuGiBjZtjDl3zogS2TLN1mHsjJHIW/wYz1GsRoGjEZ2h3xK2md0/YrHzcfWut5rmnWZ2Jo2e1Wid2CjYux9BhUxCNfPhzSld7/ammoAIuh8uFrBkFIaWnmuKWP7HxhUjE3zavUkTQhDVXxMpFQQyCGHS2TOgz5Mn6el7EF+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861468; c=relaxed/simple;
	bh=hV57clRW+wpiYylqDXPtkiindbjOMDruNDZBGnNV6J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmugHkEVxOjgLtKLuM7HEdJ/yrKlu35HuB9UHJAcaF3wD3HDOmsarV8ntTiZxzZcIVJ30nxVY/6vDPq8CBLJenMSr+x3X7bVgr7P7+qLcb65gsDibtx2WXtwKuUJ7dDy6CZKWqSaA+XZMh2v1TucbM4Si9PVe99xJKn3QWsA67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cfDve1FJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cfDve1FJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rvxWzEfFMQOWKLdgZ3xIPHPAEdldbKZZc9FtHIVjgWA=; b=cfDve1FJ/pBF/mMqFr/7Mc9LMA
	3dKv6bwmhh/a8zseGq9btrkmFphW/vgVv8ta3fBc7d05WYU0pgob3oqB9Zfjgg0xtQun8AMbtyVOf
	2pzRWijooOv4xEFndwx6SJDCv9muWXgfdA9tOxxKMEJq2nnsiAIo6fHYQGcs/z6KoIqTmmV2vPmrb
	tphVAybUceyzrG33igYV3JDf31pMgPoXBjlkFeZBwHb86RvKCRnVoejeoKciXF+JtWJQBEDViF1XY
	/AnMPyNZYKIuSGqYKn+8jkAZcKXqf5aoKUus6Z/dE3lOMMINXiBs1mhv6gBMheW0fukdPhRBKeiil
	MhV5yyNw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRADp-00000004ICH-23S3;
	Thu, 04 Dec 2025 14:22:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 991083004B8; Thu, 04 Dec 2025 16:17:35 +0100 (CET)
Date: Thu, 4 Dec 2025 16:17:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v5 06/19] perf/x86: Add support for XMM registers in
 non-PEBS and REGS_USER
Message-ID: <20251204151735.GO2528459@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203065500.2597594-7-dapeng1.mi@linux.intel.com>

On Wed, Dec 03, 2025 at 02:54:47PM +0800, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> While collecting XMM registers in a PEBS record has been supported since
> Icelake, non-PEBS events have lacked this feature. By leveraging the
> xsaves instruction, it is now possible to snapshot XMM registers for
> non-PEBS events, completing the feature set.
> 
> To utilize the xsaves instruction, a 64-byte aligned buffer is required.
> A per-CPU ext_regs_buf is added to store SIMD and other registers, with
> the buffer size being approximately 2K. The buffer is allocated using
> kzalloc_node(), ensuring natural alignment and 64-byte alignment for all
> kmalloc() allocations with powers of 2.
> 
> The XMM sampling support is extended for both REGS_USER and REGS_INTR.
> For REGS_USER, perf_get_regs_user() returns the registers from
> task_pt_regs(current), which is a pt_regs structure. It needs to be
> copied to user space secific x86_user_regs structure since kernel may
> modify pt_regs structure later.
> 
> For PEBS, XMM registers are retrieved from PEBS records.
> 
> In cases where userspace tasks are trapped within kernel mode (e.g.,
> during a syscall) when an NMI arrives, pt_regs information can still be
> retrieved from task_pt_regs(). However, capturing SIMD and other
> xsave-based registers in this scenario is challenging. Therefore,
> snapshots for these registers are omitted in such cases.
> 
> The reasons are:
> - Profiling a userspace task that requires SIMD/eGPR registers typically
>   involves NMIs hitting userspace, not kernel mode.
> - Although it is possible to retrieve values when the TIF_NEED_FPU_LOAD
>   flag is set, the complexity introduced to handle this uncommon case in
>   the critical path is not justified.
> - Additionally, checking the TIF_NEED_FPU_LOAD flag alone is insufficient.
>   Some corner cases, such as an NMI occurring just after the flag switches
>   but still in kernel mode, cannot be handled.

Urgh.. Dave, Thomas, is there any reason we could not set
TIF_NEED_FPU_LOAD *after* doing the XSAVE (clearing is already done
after restore).

That way, when an NMI sees TIF_NEED_FPU_LOAD it knows the task copy is
consistent.

I'm not at all sure this is complex, it just needs a little care.

And then there is the deferred thing, just like unwind, we can defer
REGS_USER/STACK_USER much the same, except someone went and built all
that deferred stuff with unwind all tangled into it :/

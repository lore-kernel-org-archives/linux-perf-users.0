Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33D371D01;
	Wed, 10 Jun 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079813; cv=none; b=nWmeuS1eQgPGz5tPEiPZi+iqo6BlTMNTNga7H+DO9inAUE/5XLgC3dFvrO3U6dzU5ZvfgRo6wUDNEYSo4oLXBg54NWPo/qABTD2dUmtnljCRAEU73eRmZzwC87CQ73SNuLgyOCLtBpWuuZIa/fmOr/vgpcd/+/kZ1UIMHSu20oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079813; c=relaxed/simple;
	bh=MDUJzjqUTITQ/j9U1V8OmUmnTXwN5uuSKTcirXuAx5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDdwlZvoSOCW4K+GhnD8FHM9lOlG/QwnOMW2siBBKqqEhX5OqdK56n4hWCM9HXSlVZqs6LCCdftZkua5HI8nzkVPvJphSPPzcK2PXEGVxx4kN/oPJ+BJwb2J9rA3Ad9DotfS9dMLjkH1Z3c45+GZnMmQ8YlOYlvjI0B9TurcIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qnW/dqgP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qnW/dqgP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FSi8TsILe+9SHcoDvfROE5vmDQrrsH2KiHSTwcFJfOU=; b=qnW/dqgP3zauVTAGVmvJmocHla
	gdOczc9Y+x55eRYOc5JMjPsRZAISOWT0tm5DXsludzwbkjPeXWGaaMY3nbPyHCD84Rv5BabQRqdQm
	P8QVFMSBL8P0iOz3GYD/6LOrZJTYhKQwdKYnSsCUqnTk4YstKY05gJCg8VSxTpP79zk1D4S+QXTbL
	YpwCISGr/1iFxSBve7SlcX+/KgKE5qii5Ur7+Q2Vb7M9faKx3kHcdYstl55iXfrMi4dO/2B78S0fo
	3FSu97RpLBbmagOVG9vRFf5AD42Jp0fUjakwDUKykLgPUvz2P2tjgGHWTI6v5Xx7QEbmeqMQKahvH
	1IEBNyOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXEDd-0000000HFPi-0ifw;
	Wed, 10 Jun 2026 08:23:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A1EC3031AF; Wed, 10 Jun 2026 10:23:25 +0200 (CEST)
Date: Wed, 10 Jun 2026 10:23:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [Patch v2 7/9] perf/x86/intel: Drop fixed-counter PEBS
 constraints for baseline PEBS
Message-ID: <20260610082325.GA49529@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>
 <20260610082051.GF49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610082051.GF49951@noisy.programming.kicks-ass.net>

On Wed, Jun 10, 2026 at 10:20:51AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 09, 2026 at 01:02:20PM +0800, Dapeng Mi wrote:
> > On SPR guests where pebs_baseline is not advertised, running:
> > 
> > $ ./perf record -e cpu/event=0x00,umask=0x01,i\
> > 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
> > 
> > can trigger:
> > 
> > unchecked MSR access error: WRMSR to 0x3f1 ... in\
> > 	 intel_pmu_pebs_enable_all()
> > 
> > Root cause:
> > SPR-specific PEBS constraints allow fixed-counter scheduling,
> > for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
> > pebs_baseline, KVM does not support PEBS sampling on fixed counters,
> > so enabling such events reaches an invalid MSR programming path.
> > 
> > Fix:
> > Drop fixed-counter entries from the PEBS constraint table. Without
> > pebs_baseline, those fixed-counter PEBS events now resolve to empty
> > constraints and are not scheduled/enabled, avoiding the warning and the
> > broken guest PEBS path.
> > 
> > This is safe because, in pebs_baseline-capable cases, PEBS constraint
> > lookup already falls back to non-PEBS constraints when needed, and
> > fixed-counter constraints are effectively shared there.
> 
> I am confused, this works outside of KVM? (It appears to work fine on my
> spr).. so removing this to fix some guest only issue seems wrong.
> 

Also, perf tools guys:

[ perf record: Woken up 1 times to write data ]
ERROR: Trying to write bpf_prog_info without libbpf support.
ERROR: Trying to write btf data without libbpf support.
[ perf record: Captured and wrote 0.041 MB perf.data (92 samples) ]


I explicitly build perf like:

  make NO_LIBBPF=1 NO_LIBPYTHON=1 NO_LIBLLVM=1 NO_RUST=1

W.T.F does it even attempt to use libbpf and report and error about it
?!?!

(Also, I needed that NO_RUST because the build was full on crashing
without it)

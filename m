Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82511343893;
	Thu, 17 Sep 2026 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640614; cv=none; b=RyxVPLXOAJYjwINQPe/9V1f0M5sTaQKj4r2lcz9MxYpKGfv+gUmEixbeCK+QdkAhO/H6wLCVPSieGKntDcz7lTrX+uQ7PaR0rKyxNg3LmOh63Yx7w/fFyni6G6e+wPb/Bf0i5ipCXIVqezTOe5pi67Jz8+s/kT1L/FyO4DlTjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640614; c=relaxed/simple;
	bh=t8wO41taTD6iGpUjRq+yEVHz2UbwzvT/8u1dEcpghc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4VRs/PigBnEuQ/Jp60MLRaczluPcdnJcPX0dlI6eoivc4lrbPuOmvQ86L5dERBeEX3e29lr9jR/8ekJBJceNwDoLTqscsG6asveUwshMCF1wqyPGWSyeFcdnhxEw7xgdGcoUeAxgZ+evGdVwLOu9p3qJJDG/TQkSnDfNNTiDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D4dyPhy8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D4dyPhy8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4A+Pj1WGudSCI8JmGe5z1JrMzxlI+rziCJEAOBn8QD8=; b=D4dyPhy8yv34KN6ankHcC0FNLV
	KsZnvR+2xtA6Of6ZgdsklrIKaU94pJZJczcIpP82iHQeBjcoXp/0ppOxPSklpXMlzLodRD2ls85Hi
	faNNP4WXO0RQQ2zEGmjB+AwhT8w5+JAo2YR9Djia7+S4q2iN9hkanAdeaqbp7qGmRidodViGtPXup
	giY1t6iDEdHu7SimtIgRgeTNQQV91GqAU3YSYHz6hpjknRJLMuBDZl7vgdLOM9uatnFCOJ1JXjBiI
	KOea0Y0mChiGwCYjkDL+GxbDChRWG5z524aMmbpuyRn1WYZ4f3mpu8bC6KU5ufj6BhbkqoitjeyGo
	rpaQM3Uw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x79Gt-00000009U6N-240E;
	Thu, 17 Sep 2026 10:23:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7B76D300583; Thu, 17 Sep 2026 12:23:14 +0200 (CEST)
Date: Thu, 17 Sep 2026 12:23:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Stephane Eranian <eranian@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v3 0/9] perf/x86: Don't write PEBS_ENABLED on KVM
 transitions
Message-ID: <20260917102314.GI776954@noisy.programming.kicks-ass.net>
References: <20260508231353.406465-1-seanjc@google.com>
 <anTB6ksbUs18FEf1@google.com>
 <aqLvXM5SPPlQePXs@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqLvXM5SPPlQePXs@google.com>

On Thu, Sep 10, 2026 at 10:56:44AM -0700, Sean Christopherson wrote:
> On Thu, Aug 06, 2026, Sean Christopherson wrote:
> > On Fri, May 08, 2026, Sean Christopherson wrote:
> > > Sean Christopherson (9):
> > >   perf/x86/intel: Ensure guest PEBS path doesn't set unwanted
> > >     PERF_GLOBAL_CTRL bits
> > >   perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
> > >     has isolation
> > >   perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
> > >     is unused
> > >   perf/x86/intel: Make @data a mandatory param for
> > >     intel_guest_get_msrs()
> > >   perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
> > >   perf/x86: KVM: Have perf define a dedicated struct for getting guest
> > >     PEBS data
> > >   perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
> > >   KVM: VMX: Drop a redundant pmu->global_ctrl check when processing
> > >     pebs_enable
> > >   KVM: VMX: Only tell perf to enable PEBS counters for fully enabled
> > >     PMCs
> > > 
> > >  arch/x86/events/core.c            |  5 +-
> > >  arch/x86/events/intel/core.c      | 92 +++++++++++++++++++------------
> > >  arch/x86/events/intel/lbr.c       |  2 +-
> > >  arch/x86/events/perf_event.h      |  7 ++-
> > >  arch/x86/include/asm/kvm_host.h   |  9 ---
> > >  arch/x86/include/asm/perf_event.h | 11 +++-
> > >  arch/x86/kvm/vmx/pmu_intel.c      | 28 +++++++---
> > >  arch/x86/kvm/vmx/vmx.c            | 10 ++--
> > >  arch/x86/kvm/vmx/vmx.h            | 15 ++++-
> > >  9 files changed, 114 insertions(+), 65 deletions(-)
> > 
> > Ping.  This still applies on Linus' tree and against tip/master.
> 
> Ping again.  This fixes a real issue and IMO provides much-needed improvements
> for the KVM<=>perf APIs.

Right, finally got around to staring at them. How did you want them
merged?

AFAICT 2-4 have Fixes tags and should go in perf/urgent, while the rest
goes in perf/core?

/me tries and finds patch 5 doesn't apply.

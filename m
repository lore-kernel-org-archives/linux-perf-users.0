Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FB43498C;
	Tue, 22 Sep 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065862; cv=none; b=VbMHd3tQj3nX/z5UBJbAlDs18DuYerQMjqsOTzuauxOIFYil4X9nReoA2g35KLTSV8PgqY36QwYs6lAjsp0qw+O2nDoVXyThiBmQLXpTG6ARR/2M7GCW/3ePytB79drN2uGVtL4S3sa7DGtWv76bgDn0VCOpq++xIqUTqtQkPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065862; c=relaxed/simple;
	bh=W07KPETAFWOKHqHQ1ajEJUJQivlun3GqSHDn/+uiTtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXpJuL20JAv0jdMyuwf5XtWtk/HxWpkaS0GGOeRRg8s51a2046cQwh5UZHYAmGskZmLurvf3gH/WQUGyjFMAfwfGbCpoTXapkBXn2b2G8t+veH5ZCDREx5WybnxcRK7onaIayjegyIzXvyJ1a3svCV5s6v1rBarrmWDl0qEoDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aoAIQVZ8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aoAIQVZ8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oDcHFwTwM257p7mTTBAku1Nxwr45U9cHxRrVhHyENf4=; b=aoAIQVZ8+Ldaq0VxfWJVHdrQ6j
	z8dh9PrsavvaJAsJJ9KMxBbngfvZDK3De/qdW0QuGd/OiTS3peSs6OAE98vn1W7tu8RXhbV/mhZ6u
	HLz7EFyWJ4sLG0ZVYwTNN+79oitg/HJwOyV1F8IO7wp0asd9/4/5WZyG0be6G8pUBtLPvHG93D814
	uxaNi3z+y6N0Wx6/+JiutX7mCWKg3ReeEXYUKoGJfAkwUUgye4ZsLobI1DsxO0z3jnGv+5F+dpHV3
	2LIJQBeicxgp16NO1hw+6Mb4btp64kR6ITk34JmLDc2pCbPI/zSN+9eJnTJijvYuhJAG9r09w0ees
	8ZqAG73Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8vtm-00000007krB-3azy;
	Tue, 22 Sep 2026 08:30:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FE2F300708; Tue, 22 Sep 2026 10:30:46 +0200 (CEST)
Date: Tue, 22 Sep 2026 10:30:46 +0200
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
	kvm@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Stephane Eranian <eranian@google.com>,
	Sashiko Bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 00/10] perf/x86: Don't write PEBS_ENABLED on KVM
 transitions
Message-ID: <20260922083046.GY4121339@noisy.programming.kicks-ass.net>
References: <20260921191418.950933-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921191418.950933-1-seanjc@google.com>

On Mon, Sep 21, 2026 at 12:14:08PM -0700, Sean Christopherson wrote:

> Sean Christopherson (10):
>   perf/x86/intel: Ensure guest PEBS path doesn't set unwanted
>     PERF_GLOBAL_CTRL bits
>   perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
>     has isolation
>   perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
>     is unused
>   perf/x86/intel: Make @data a mandatory param for
>     intel_guest_get_msrs()
>   perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
>   perf/x86: KVM: Have perf define a dedicated struct for getting guest
>     PEBS data
>   perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
>   KVM: VMX: Drop a redundant pmu->global_ctrl check when processing
>     pebs_enable
>   KVM: VMX: Only tell perf to enable PEBS counters for fully enabled
>     PMCs
>   perf/x86/intel: Check only PMC bits in PEBS_ENABLED when detecting
>     host PEBS usage
> 
>  arch/x86/events/core.c            |  5 +-
>  arch/x86/events/intel/core.c      | 94 +++++++++++++++++++------------
>  arch/x86/events/intel/lbr.c       |  2 +-
>  arch/x86/events/perf_event.h      |  7 ++-
>  arch/x86/include/asm/kvm_host.h   |  9 ---
>  arch/x86/include/asm/perf_event.h | 11 +++-
>  arch/x86/kvm/vmx/pmu_intel.c      | 28 ++++++---
>  arch/x86/kvm/vmx/vmx.c            | 10 ++--
>  arch/x86/kvm/vmx/vmx.h            | 15 ++++-
>  9 files changed, 115 insertions(+), 66 deletions(-)

Thanks, split in two and queued in perf/urgent and perf/core. I'll push
to tip in a day or so unless the robots scream.

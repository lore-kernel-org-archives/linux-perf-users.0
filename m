Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B737DEB5;
	Thu, 23 Apr 2026 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961010; cv=none; b=fKUDlHCRd1J/8v6GuvBA7B2ZWLiNdNDuMGCrfcX3OPPWHrvUC5Sl97IWb7bXN2Mqpl/d3RIC+pQwqSEW6l7ND+51diUNzD8qEHIBXa96dABrZRGTwwo6XLGsp/W/Ilw4AYLSQKKhptOPBI7Q0Hiu4GvTGp6qO4BlO6MD7eSZHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961010; c=relaxed/simple;
	bh=3TuCer8dMjOuWTldjw+dyH7Is7P3SFDrvfxQ/Qjus2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/9+Kn92nKnbCtemWPMWDLPrfg6gYDAvlTfMYuLIqF+E2An5y0lQtDr2vAiCal1eQcviYrB+BupVn2y1VHY/1F0u47Rwaxu6r/Ril1i1YQj/NY3X2r/NxoWg+w469KGT+bP4Lxn8yF8MvDHSmFiuS7a6vwbT9PX2BJm7wGmKenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UqatAL6M; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqatAL6M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KEbBMy/7Z6YoPH/c4t4nNAeYgkjzdgqfs3JRrO4cFrw=; b=UqatAL6MwZYbiHnNEqVD2AO9Ys
	3+JHjMR78VFxwl5eKaK2psl7aVuKlUglykZsQ1BIw8So0WRNPT0SQZce5zeszTqYnWWhUE7sCS5W+
	TwdF1dcv89fUT6Eu1UAfptFy8D7Lte1IvgRl8vsiJm4HP2HezUGaavknRqM262CKZkGz4LjpLuaf4
	1MxtSPeyF44aHNCTsbjzqS2sLbSYpvtmm/apVuAy2uP0IkgSGbpiwEtPMhuyaximYIT5MiPAY1RCe
	eCMx51HxCDUTnQZ0IVVbbq9Cu0ra9ofu1n82ERBCQw0qvZnu8bJFMOMy9gSHiYH/O2wabs9xSIeG8
	xqSA3Z6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFwjJ-0000000DPQa-45Uo;
	Thu, 23 Apr 2026 16:16:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46DB13008E2; Thu, 23 Apr 2026 18:16:41 +0200 (CEST)
Date: Thu, 23 Apr 2026 18:16:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Stephane Eranian <eranian@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 0/4] perf/x86: Don't write PEBS_ENABLED on KVM
 transitions
Message-ID: <20260423161641.GA641209@noisy.programming.kicks-ass.net>
References: <20260423150340.463896-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423150340.463896-1-seanjc@google.com>

On Thu, Apr 23, 2026 at 08:03:36AM -0700, Sean Christopherson wrote:
> Testing this against our "PEBS_ENABLED is stuck" reproducer is (still) a work
> in-progress (largely because the "reproducer" is currently "throw the kernel in
> a big test pool"), i.e. I don't know if this actually resolves the problems we
> are seeing.  But even if it doesn't fully resolve our woes, it seems like a
> no-brainer improvement, and if we're missing something with respect to "stuck"
> PEBS_ENABLED, it'd be nice to get feedback/input asap.
> 
> Note, if the throttling theory is correct (which is looking unlikely at the
> moment), then there are likely more fixes that need to be done, e.g. for CPUs
> without isolation, and/or if PERF_GLOBAL_CTRL can be modified from NMI context
> too.

Throttle does: pmu->stop() := x86_pmu_stop() -> intel_pmu_disable_event()

Which in turn should:

  x86_pmu_disable_event()
    wrmsrq(config_base, config & ~EN);
  x86_pmu_pebs_disable() := intel_pmu_pebs_disable()
    wrmsr(PEBS_ENABLE, pebs_enabled & ~(1<<idx));

So that's just the counter EN bit and PEBS_ENABLED cleared. However, if
this is from PMI, then the PMI handler should also update GLOBAL_CTRL --
provided it wasn't 0.

See intel_pmu_handle_irq():

  if (pmu_enabled)
  	__intel_pmu_enable_all()
	  wrmsrq(GLOBAL_CTRL, intel_ctrl);



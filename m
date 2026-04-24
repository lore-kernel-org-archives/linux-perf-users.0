Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066423AF676;
	Fri, 24 Apr 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033421; cv=none; b=p0s+AetQKzlU2caZqxLhhqjUQ6bqM85gIBh493bS4Ow7fWN+5eJ09jeBzt2P9MTIHHSpTge7VE1FA6rwFQ+CsGUxWwZOnXoEn4SX/FfmKrE8eUvtq3d0JY+75NkQ8sFYe9DFK7Qmi9eOIBbQm+jjjeBVyjqMI8yEh4wRFGYQJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033421; c=relaxed/simple;
	bh=GLGraWvtQHBOFIhN97oPQw0hR+WnjpVdiVnGX9C2HVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQRLqhREfGFOQn86+hLSBfx01qByfjTxHt2mFXbpnf8Uq+5tGHD4NcBg/cTgt0QR2GUbtj64E3F+q4FX/s0Ct3ODN+o57Ic31QQt1uGF+zDkuZKMGjjttK0FJVtMsGqMtV9rJfqvhFimLGFOkGQU7LUuaxZLUcugBUMIcxqTAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eZeQCcx+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eZeQCcx+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SUqnbh3lZC0aoG+4uV14UrcKIahclGM3EDChFHr17qg=; b=eZeQCcx+MSHSKZuM8saudpTOKX
	KzB2IxNqKhjEqg0Gu/gcijNpg/kRaam9UFeJq95Cdl/z7At7sbMcAGq1NPGn/SO93qDNLYJ8y2WzE
	hSifPRo0mzwTTYoxEcMSxdDJ6y2xkTVgTOahFfwFxnOOyz+5RZDBV7pomb5juzh1o78h+IDLC53Vx
	t7q2vV2GkV+3dBiVUh09KWZQkSiegXDIM8Xg3z0ow/Nbqi0TW4UNw+K7xGsY5PN+9uzIPfFCvCr87
	rDKf33ulb3Q6GAVe+5iGVkcyCKohH/kkxBdBYaip0xkdEiCgkCqn0Ij5ePJcqUfj8C4pj+PA76IeE
	YFYNChMQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGFZB-0000000F6wR-0asY;
	Fri, 24 Apr 2026 12:23:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9F10130301B; Fri, 24 Apr 2026 14:23:27 +0200 (CEST)
Date: Fri, 24 Apr 2026 14:23:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 0/4] perf/x86: Don't write PEBS_ENABLED on KVM
 transitions
Message-ID: <20260424122327.GD641209@noisy.programming.kicks-ass.net>
References: <20260423150340.463896-1-seanjc@google.com>
 <20260423161641.GA641209@noisy.programming.kicks-ass.net>
 <3585d823-00f3-46ae-a799-b62a95743e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3585d823-00f3-46ae-a799-b62a95743e76@linux.intel.com>

On Fri, Apr 24, 2026 at 08:17:42PM +0800, Mi, Dapeng wrote:
> 
> On 4/24/2026 12:16 AM, Peter Zijlstra wrote:
> > On Thu, Apr 23, 2026 at 08:03:36AM -0700, Sean Christopherson wrote:
> >> Testing this against our "PEBS_ENABLED is stuck" reproducer is (still) a work
> >> in-progress (largely because the "reproducer" is currently "throw the kernel in
> >> a big test pool"), i.e. I don't know if this actually resolves the problems we
> >> are seeing.  But even if it doesn't fully resolve our woes, it seems like a
> >> no-brainer improvement, and if we're missing something with respect to "stuck"
> >> PEBS_ENABLED, it'd be nice to get feedback/input asap.
> >>
> >> Note, if the throttling theory is correct (which is looking unlikely at the
> >> moment), then there are likely more fixes that need to be done, e.g. for CPUs
> >> without isolation, and/or if PERF_GLOBAL_CTRL can be modified from NMI context
> >> too.
> > Throttle does: pmu->stop() := x86_pmu_stop() -> intel_pmu_disable_event()
> >
> > Which in turn should:
> >
> >   x86_pmu_disable_event()
> >     wrmsrq(config_base, config & ~EN);
> >   x86_pmu_pebs_disable() := intel_pmu_pebs_disable()
> >     wrmsr(PEBS_ENABLE, pebs_enabled & ~(1<<idx));
> >
> > So that's just the counter EN bit and PEBS_ENABLED cleared. However, if
> > this is from PMI, then the PMI handler should also update GLOBAL_CTRL --
> > provided it wasn't 0.
> >
> > See intel_pmu_handle_irq():
> >
> >   if (pmu_enabled)
> >   	__intel_pmu_enable_all()
> > 	  wrmsrq(GLOBAL_CTRL, intel_ctrl);
> >
> Yes, currently all valid bits in GLOBAL_CTRL would be set by default on
> Intel platforms. IIUC, this issue looks more like a race condition between
> Perf and KVM.
> 
> 1. KVM saves the value of host PEBS_ENABLE before VM-entry.
> 
> 2. PMI is triggered and interrupts the upcoming VM-entry. PEBS events are
> throttled and PEBS_ENABLE MSR is updated in the PMI handler, then the KVM
> saved host PEBS_ENABLE value gets stale. 
> 
> 3. VM entry continues and then the next VM-exit occurs, the stale
> PEBS_ENABLE value is restored. 
> 
> 4. The PEBS_ENABLE MSR keeps the stale value until next write.
> 
> Seems an alternative way to fix this issue is to disable the PMU (Clearing
> GLOBAL_CTRL) before KVM saving the PMU MSRs?

Yes, that would seem a prudent thing to do.

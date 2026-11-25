Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649025;
	b=Mwz2zk0l2wDsI7mm/8OXFWbtUusjpJlMjyVPwtMYuBM64nf5cLnbmsLVq6nFPEdLju62
	 JO2rSO1nqNL2Yd9wZ1fVXC7PTFOamYezptKCKJv35pJcfAAI4TBVd/m7I4vjuE2cjJ2YO
	 WLsdcwyRCJyqAFU7J4cbLUMk1itpa1zdLbgN2Q0ds9jRqkre0sRa+807VwoEM9I7nWJOH
	 HHOiaeNW+liv75c/l8fidtn/xwhz/O9lFOQtA/hle7MVFOjVpDUnXpPblSj6zq9L5HHXq
	 pSuLWGHRu8h+f3vRJXOBFS/O3NwJHtf/pFzYlkmz6Ys52eVlu0OHhMlssaWV0hilqrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649025;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HylcXLYdrbMpv/2aFN44v2Wt/953Ia1OkzX0FGD1774=;
	b=XRc29Oqcx65uUoOB+6bLss208UqKd3zr8rHmvPDm1Yu32aOK1PLSxyKmUvYmY29IwS4A
	 S/UicS4ISm/JGdV/qCvPGD7Qcj9hEE2CGyjGhhFNW6EpklfcFRrpG+KlOCwDvWmFXOTn1
	 urZE1VJV9VZvmfASRsHpFpGpICdoGfoHUO9SHaNmNtHKfWlfNwBtygz6dHKqeuKoRMapV
	 02rgnBVHsHBpO1WvSCGONlDU2n8sRZLqp08shrA0Qbcr/KW0ygnsCFnLYkFi5hgsntugo
	 wnjxjUH8FS9iDfI8xpKK912iEPEjiJtQe2wEhzKpLCbIGj5EO+vXvSFNw92qGank+5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5dZl2dq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0396606A31E;
	Wed, 25 Nov 2026 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5dZl2dq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822AE1F000C0;
	Wed, 25 Nov 2026 23:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795649025;
	bh=HylcXLYdrbMpv/2aFN44v2Wt/953Ia1OkzX0FGD1774=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m5dZl2dqSzBRpFzDU0Pkcuu9rg485DnDUrCc5UIpY/bEhRpd3eKfa+XVoiBc1ml+5
	 Z5MW1/6ElSqYiDzartJCR/5TqY37JUePR3actN4gEZ7azMjA3PrCTwuvZkSl9AHJkC
	 uU82Got94V60Rbu2suuBrcBVwzkLudhL6XBo35oUUlIOelRVeZgyXOhgRUSZnGuKIO
	 5xKdxFYaAiYWgcSDNnWZ132foUfrGcMtI/i78nRFgB3MZmj0zKh2ILa31a9DpIU3U/
	 BUoC5ZHxyqFwG5zXXuWb59JMXRbrR1ip6dIgwiu0GD41cLjFLPZm6hmrrtFH/gXKyT
	 P3URUmudfvSpg==
Date: Wed, 25 Nov 2026 23:23:43 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM
 guest-only events
Message-ID: <awdnFkLVRkAglrXv@google.com>
References: <20231107183605.409588-1-seanjc@google.com>
 <20231117103236.GI3818@noisy.programming.kicks-ass.net>
 <ZWaU3HZURCjms5DM@google.com>
 <20231129112019.GG30650@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129112019.GG30650@noisy.programming.kicks-ass.net>

On Wed, Nov 29, 2023 at 12:20:19PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 28, 2023 at 05:33:16PM -0800, Sean Christopherson wrote:
> 
> > If programming a "period" of 1 puts the host at risk in some way, then I agree
> > that this is unsafe and we need a different solution. 
> 
> IIRC if you put in -1 on a Nehalem, you end up with an NMI-storm which
> wasn't trivial to recover from if at all (it's too long ago and I don't
> have ancient hardware like that anymore :/)
> 
> > But if the worst case
> > scenario is non-determinstic or odd behavior from the guest's perspective, then
> > that's the guest's problem (with the caveat that the guest might not have accurate
> > Family/Model/Stepping data to make informed decisions).
> 
> Things like bdm_limit_period() will cause odd behaviour IIRC, it does
> daft things like generate extra PEBS records on overflow and gives
> otherwise daft results for PDIR.
> 
> glc_limit_period() lacks a useful comment :/

Sorry for thread necromancy, but it seems like the discussion stopped
here and I'd like to get this fixed as I am observing the same failures
that Sean did.

Basically, if KVM needs to program period=1 (guest counter is -1), perf
overwrites it to 2. After 1 event, the guest counter should overflow,
but the hardware counter doesn't, so there is no PMI. On the other hand,
KVM relies on the hardware PMIs to signal overflows while perf events
are counting.

The overflow is then lost: when KVM pauses the event (e.g. to account
for an emulated instruction), it folds the perf count into its software
counter and restarts the event with a new period, so the late hardware
overflow never comes, and KVM only checks for wraps on its own emulated
counts.

Sean's fix makes the problem go away on all CPU platforms, and Peter's
makes it go away on Skylake+ on Intel (with updated microcode) and all
AMD platforms. So I am mostly happy with both. It's worth noting that
the blast radius is smaller with Sean's fix as it only affects guest
events.

A middle ground would be skipping the left < 2 clamp on exclude_host
events, but not the x86_pmu_limit_period() callback, which makes the
problem go away on slightly more CPUs than Peter's patch (I think
Sandy/Ivy Bridge, and Skylake on older microcode versions). This keeps
the *_limit_period() subtleties in place.

All three versions seem to make the problem go away on AMD Turin.

WDYT?

An alternative to all of this is a "fix" on the KVM side where KVM is
always responsible for signaling all PMC overflows, instead of signaling
some of them from the PMI code path. KVM would keep track of the guest
counter value as of the last pause or write, and on PMI it would just
pause the event, manually check for the counter wrapping, and deliver
the PMI to the guest.

This would obviously be a more complex change.

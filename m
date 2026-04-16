Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DE359A8D;
	Thu, 16 Apr 2026 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383482; cv=none; b=sP0mXntgYCe2P8wKv2vVrZ3MkFhxi1AVxHUXfDDjoX/N76Imw8JPcPsESCgPVJH7iZFgzoJo2fFXhI/aIchOiPzZzAan19fkvE1IJYIi/aiYMbJIGw3bBEk2ahgjAVg4+Wmoj7xlKkujVWMDTHVVhwCQFmJNZx7bXlG0QDdBLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383482; c=relaxed/simple;
	bh=GNAIWnx1mf+4N5VGFoL1bAZxlT61uDGeEjvrZMUjWc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udBBXY+o7mOYZ+Wh5jC6uC4qLx+bVUD/RjA+yYwQODOQpurfGO7iZ1zNirrYzVkBm/Vgzw7hEBpT1N47/ytQP+AghrpspLBYKdiyTmPKBYNN2rJUrSJriUKOMurH0Pr7XFsJ8HMO7BzQYky9M2RNWhHYthtXHpWzqvS2/3m12Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNv4xC48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNv4xC48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9147C2BCAF;
	Thu, 16 Apr 2026 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776383482;
	bh=GNAIWnx1mf+4N5VGFoL1bAZxlT61uDGeEjvrZMUjWc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNv4xC48TICy622MgCIf5ah6kBhsIvcgv5BQEOPmeLmKv0anxPW2ypkYhWHYyipAX
	 6oYl2OIIKRyJsbHmw2+4TNNP5U6IWslPai5OgkaxLl8y8gYlHhB5JW74kIodrL69zL
	 zlFCiwbGdhvZbhHdorvJBRnRLO8JZmrmxI8sbdUXJMZlJwZNLeAHfaIYvIpbNTPEaT
	 B8ijpIeBPpj6AKEUJQBPsnp6xSO4N1S6pbmeCOIH2BMWqYbGOcPOUgaOReCU4GufgZ
	 wSyh4mTKxfpFjTdi2onwvLTt3Sj7vRAO21+AKMEBmvdpPBnj9K0WwKovlU9QPHFYrJ
	 i0AAPxwWBdLVg==
Date: Thu, 16 Apr 2026 16:51:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Stephane Eranian <eranian@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
Message-ID: <aeF1-A8DqVPhViJZ@google.com>
References: <20260414191425.2697918-1-seanjc@google.com>
 <20260414191425.2697918-2-seanjc@google.com>
 <aeEpV9kfBSQrxwm-@google.com>
 <aeE6yYGaq2rnj77v@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeE6yYGaq2rnj77v@google.com>

On Thu, Apr 16, 2026 at 12:38:49PM -0700, Sean Christopherson wrote:
> On Thu, Apr 16, 2026, Namhyung Kim wrote:
> > > +	/*
> > > +	 * Disable counters where the guest PMC is different than the host PMC
> > > +	 * being used on behalf of the guest, as the PEBS record includes
> > > +	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> > > +	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
> > > +	 * is using PEBS, to avoid bleeding host state into PEBS records.
> > > +	 */
> > > +	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
> > > +	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> > > +		guest_pebs_mask = 0;
> > >  
> > > +	/*
> > > +	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
> > > +	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
> > > +	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
> > > +	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
> > > +	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
> > > +	 */
> > > +	arr[global_ctrl].guest |= guest_pebs_mask;
> > 
> > I was confused by the earlier comment in the funcion that says it is not
> > enough to disable counters but I've realized it's only for the case PEBS
> > isolation is not supported by CPU/ucode.
> 
> Yeah, me too, more than once. :-/
> 
> > I think it's ok for disabling guest PEBS, but I'm curious if there's a
> > case to enable PEBS only in guest and it'd be handled correctly.
> 
> Yep, if PEBS is being virtualized for the guest, unless the host is also profiling,
> then PEBS will be active for the guest but not the host.  KVM tests for PEBS pass,
> and while they aren't exactly comprehensive, they should detect outright breakage.

In that case, wouldn't it need to update PEBS_ENABLED here?

Thanks,
Namhyung


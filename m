Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E331714AA
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Apr 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776385416; cv=none; b=SdbVppDtGt6w74leMxwWFevGxhik2S35FqOo1t7PDJaz9NiBFtL4mOEO356y2iXtTmw9t4Bs3K1hg0VIL0w/nSE3VziQBT7RN/oteHkJgqms3aSWoGs/aG7CRvt9I+ARBz5WLVNhGq/e4oED+sVApZ03Ga92zHx6MjMlzajjRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776385416; c=relaxed/simple;
	bh=/aqm4WRoWHn1sLZRYKE22jwj4n1vdAS03UEkXoVry9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZVqqiEXnq9iOE14Wgci9xrEapE0/zAqCWqVuMeo9pMrmbTbekUhUlVR5oavEBZSY4x6aG+WJaHEfUJhinP5trMIK9OXh5caQbjDthCwPsuATYJlTwyYLJUjbLPIg6asq2SjfjAeI9lPYswvw80+oNNUmoJuTtAB/M4r0/VUVPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9ue0zNp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9ue0zNp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f543bae3cso87346b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776385414; x=1776990214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKQIMmt8g6K9uGClGEbvFNEwh+zq6tLKWRUCGQ1b2aU=;
        b=R9ue0zNpHPS2aYrhXj8YPxP8YTxRlveX+VIRp0VqJ6qOXija4n6rgknlWLcKSsedsc
         bZtXFLIBi+uzcA4xzH/gnoZO18xaV8xVVyxkH8n72hz4tFGC9+E3csr+SVhcDnJqQY+6
         8cWekTf+SOwg4wOsxIfIQ0t15q+YhrU++rnfLWGGlsotkXzeHiKmIkRgLaDGOp0uFsIJ
         68wx+6HORhUPCRywMry2hgHwHxM4lRxAd2xnn6NyKvrwuPowQ9+s50xRReYt6P28m4Dh
         kZFlBRwCVOC9V3arI7kiYhbJRelaStjGdRxBKawTyL6Puqg/PADaMYZLqMVZRfsA/OAM
         w9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776385414; x=1776990214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKQIMmt8g6K9uGClGEbvFNEwh+zq6tLKWRUCGQ1b2aU=;
        b=FY1GLWpqcoD+FGokzis5yPdX5KRLbm7iSw0LL/sp0RI04Uzx6S4Sg5dxmPgR/hPzuV
         Q/hZfWjQNyI0cd3qP2W0pbE7c2456cTaHmY8TPcBb+MTrLQK917Z75lyaaW6GIQ9NTxv
         JowOQbf4h0K8kaOUQecGLa8byINtkIU9Jls7xB28hwkGKsZw/gp7CFU3SfyosLOy6dTB
         IjMxmfFmh8NlnCy3xD7McGDpVEsaz0Yn9EHNRUY8vgCmQNrUwIMjFLB8zjipOIfzkZTY
         f8MkJItbe6F+gr9wCvaFHDx/2DrnW5DzCSEpDO1FzqKSFfgQ9Av35sdIKS+PQ2vmY0th
         sqPw==
X-Forwarded-Encrypted: i=1; AFNElJ+0m/m6/u3Ki/JPl8zpYx6/VyOgG9SzXMrDX99zeLlkOtjD34D74DGlV75sb/y73fZ3g+f7p1qM0aKhVJiHRzjG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MZ5AuVYeQqIxoc3rfTENfWO8eAzntAZRcwn2gB+yBtfvlh6b
	kTkTYicrAu/FZ03CToW54+jNZBaYCINlaiCObsTy3EuttJYgRl28H83PGtgvUYJeTpk3PIt4o9h
	50nLIuA==
X-Received: from pfoh24.prod.google.com ([2002:aa7:86d8:0:b0:82f:7d76:22f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d88:b0:829:6f7d:3086
 with SMTP id d2e1a72fcca58-82f8b3aff42mr485749b3a.11.1776385413608; Thu, 16
 Apr 2026 17:23:33 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:23:32 -0700
In-Reply-To: <aeF1-A8DqVPhViJZ@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-2-seanjc@google.com>
 <aeEpV9kfBSQrxwm-@google.com> <aeE6yYGaq2rnj77v@google.com> <aeF1-A8DqVPhViJZ@google.com>
Message-ID: <aeF9hFBVdkra3rOW@google.com>
Subject: Re: [PATCH 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
From: Sean Christopherson <seanjc@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 16, 2026, Namhyung Kim wrote:
> On Thu, Apr 16, 2026 at 12:38:49PM -0700, Sean Christopherson wrote:
> > On Thu, Apr 16, 2026, Namhyung Kim wrote:
> > > > +	/*
> > > > +	 * Disable counters where the guest PMC is different than the host PMC
> > > > +	 * being used on behalf of the guest, as the PEBS record includes
> > > > +	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> > > > +	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
> > > > +	 * is using PEBS, to avoid bleeding host state into PEBS records.
> > > > +	 */
> > > > +	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
> > > > +	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> > > > +		guest_pebs_mask = 0;
> > > >  
> > > > +	/*
> > > > +	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
> > > > +	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
> > > > +	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
> > > > +	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
> > > > +	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
> > > > +	 */
> > > > +	arr[global_ctrl].guest |= guest_pebs_mask;
> > > 
> > > I was confused by the earlier comment in the funcion that says it is not
> > > enough to disable counters but I've realized it's only for the case PEBS
> > > isolation is not supported by CPU/ucode.
> > 
> > Yeah, me too, more than once. :-/
> > 
> > > I think it's ok for disabling guest PEBS, but I'm curious if there's a
> > > case to enable PEBS only in guest and it'd be handled correctly.
> > 
> > Yep, if PEBS is being virtualized for the guest, unless the host is also profiling,
> > then PEBS will be active for the guest but not the host.  KVM tests for PEBS pass,
> > and while they aren't exactly comprehensive, they should detect outright breakage.
> 
> In that case, wouldn't it need to update PEBS_ENABLED here?

No, because KVM only supports guest usage of PEBS when KVM is proxying the guest
PMU via perf.  I.e. when perf fully controls PEBS_ENABLED.  On perf's side, events
created by KVM show up as "guest only", but are otherwise programmed normally,
including getting shoved into PEBS_ENABLED as needed.  So to activate PEBS PMCs
for the guest, KVM just needs to load PERF_GLOBAL_CTRL with the counters that
should be enabled for the guest (taking care to not load "guest only" PEBS events
that were (stupidly) created by host userspace, as those can crash the guest.

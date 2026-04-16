Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD03845D5
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368335; cv=none; b=VO+HBhwbT1UEwp9683ji+AkfRZ2cS62es0IWypYo515vfeggV8iM/xVeQc0dFSMpzgpJG5XJpzEZhbWrhNI5MBb17Eg74WQ3uYCXfYRDx1/SCB5sOjRtswqz0guPFJZuU5HLJGCurpAb2IXwDJPYpfQk7YiT4qmIWGO5x4gIY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368335; c=relaxed/simple;
	bh=ysLa6ksEOUYVMmhdG9ZT9GZLHSpQavIhtm92MOWxgRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACfR8hS3uVugN5+7NG7z7Wkk9X+RO9duFykxcSU2EfQUvzmrZo+po5y2lWvQNVry6X66d0NgscFHRXRICL70IxHZ26gUdvIyruaX0ZzkM4VjErI4vL0/oAVGVM+nmsqMZ7fR0Wg0LYQuSMdH6hmEGWn+FEalUNiF928NPtET4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QA0N+lt+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QA0N+lt+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6610a6c8so1259386b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776368331; x=1776973131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S4kcc1nmfLe/qZYFBrnwpUX8iJIcKjKD0pIVP+tkdCo=;
        b=QA0N+lt+3MOuNXIatUTJ/9rnYKhuleyJizI0cnqBx7rfHOHFLboUaZ2BZvbzmKek5l
         SRmGmP2+G3sfqZERHWWnYNTiEygzovhw6i0pKpeSChtl4BduUjRUu9vnKSIVDrXL2OLS
         sf7/o7SmAMbxb6GSNP46f41yZt4DwshU9fOMpnlG6iZB2nBMGI61Wiq3lx6V3v+ZVPXC
         9IU2ZHU8Oufo0LFLW0wjXV3BjRaSiltQ8Fpsl0mFq3SXDaXsrdSvQvP3VAA1T/+BtQk0
         BeVedJOXaEdn1nuaBUtOKwoZDjHgTK2qndlwa251dnyccf/Ncv5+qJt5J92BFdgkX0WM
         Zaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776368331; x=1776973131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4kcc1nmfLe/qZYFBrnwpUX8iJIcKjKD0pIVP+tkdCo=;
        b=ZTH7T8lzywHG6cF51sZn51WdkYLKfkbZ+DfeMGSS0BOGNJTGzC6926/4DQVEP9N83u
         okUGNodgCBu6/7h5D/2fXvZ8ur6sYEawyS0vqTQM6BK+eZ/me3OccDM8B9Eaj0YCWFk7
         1K3rQAoIXWpWJFH2jT18uYmro6DmbjZSzqdE1l6bNrzo6yTiec4KnNg4NuuRZlTm2vOY
         UAvAQxSkzCZ1OIT9AQDjvC9CUVU0+vAmxBXAU7svXTjyYp9FRn1cbbKoM3bUv9H0jmx7
         hhy09tShwRx4LbtFWWgNPnqCEixSkRA7/neu9pfCjkuzfmJBqi1ePp/mriY3n+1PiSvV
         YhvA==
X-Forwarded-Encrypted: i=1; AFNElJ8i5nE1SLYWimc+oHtI6eKBPuTfwe+yvvpKRZG/dwELWVKkE85hU30Ns6GtEY8U18GFxPvaDDZKJelsvTr7g8VI@vger.kernel.org
X-Gm-Message-State: AOJu0YyVjkKaWN7OCaFf8M6Hp2Na0fQgpgK2rxKupKbOEm//9j1U7a6y
	M5U8pUY1l250Tb5Jz7fzv1WIUj5k6MirXMSl86vysxkluJNBr4L/UmYOovhuXcZXP/WJCeHoWej
	VZrEEcw==
X-Received: from pfgs39.prod.google.com ([2002:a05:6a00:17a7:b0:82a:108d:4308])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:18a7:b0:82f:6bd2:eac5
 with SMTP id d2e1a72fcca58-82f885645f2mr646007b3a.2.1776368330543; Thu, 16
 Apr 2026 12:38:50 -0700 (PDT)
Date: Thu, 16 Apr 2026 12:38:49 -0700
In-Reply-To: <aeEpV9kfBSQrxwm-@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414191425.2697918-1-seanjc@google.com> <20260414191425.2697918-2-seanjc@google.com>
 <aeEpV9kfBSQrxwm-@google.com>
Message-ID: <aeE6yYGaq2rnj77v@google.com>
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
> > +	/*
> > +	 * Disable counters where the guest PMC is different than the host PMC
> > +	 * being used on behalf of the guest, as the PEBS record includes
> > +	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> > +	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
> > +	 * is using PEBS, to avoid bleeding host state into PEBS records.
> > +	 */
> > +	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
> > +	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> > +		guest_pebs_mask = 0;
> >  
> > +	/*
> > +	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
> > +	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
> > +	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
> > +	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
> > +	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
> > +	 */
> > +	arr[global_ctrl].guest |= guest_pebs_mask;
> 
> I was confused by the earlier comment in the funcion that says it is not
> enough to disable counters but I've realized it's only for the case PEBS
> isolation is not supported by CPU/ucode.

Yeah, me too, more than once. :-/

> I think it's ok for disabling guest PEBS, but I'm curious if there's a
> case to enable PEBS only in guest and it'd be handled correctly.

Yep, if PEBS is being virtualized for the guest, unless the host is also profiling,
then PEBS will be active for the guest but not the host.  KVM tests for PEBS pass,
and while they aren't exactly comprehensive, they should detect outright breakage.

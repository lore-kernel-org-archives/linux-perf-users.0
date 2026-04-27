Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9A3E51E4
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311281; cv=none; b=GxK5RYgZ69X/XmEDJV1rc44Tno6CW6JYsF/a65ph997wMSRHx1WNxl4KqViQ1pj1YApdZrxq8+YnfVGweQfdNsKbQI9T8zGreR4UOaS4gY6Lp+D27OE0bHRDF/wpqhMYW1O2O/NWCPCo8DSSCTiXTkiFG8ZUoGL3sGYqOkxRLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311281; c=relaxed/simple;
	bh=zXsxEj1uV1jT6g8uPy7vpdf7iKBLusxzqQTDXrMZoXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVKJ6dS8u8fidInVExiS9FwuC1RurdUbeqocxwamcIt0KkvTqIYOjAXBy7b/FwJPfz0YoQkC+PJqmc6s4FZeMjnxsYBWSqjaJpfrJvRzptpLG2zTodEupXVR8bZ67RbpLiniBAw+mlkO6yTHORfFS05MKOtkBPJvqdy215MvZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=warKmD6n; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="warKmD6n"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f07078ff0so7097748b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777311279; x=1777916079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdEnpzDIOCEcXBvG6SCSAkx4aELVLebcgUGVQXndMA8=;
        b=warKmD6n2W02WagiH3IGv9uPEFHrJJo6RKaw4EAdfd7iKERgqHAufUN1XPMC+QrsVB
         aVMYBV9+WX1dYV7c2GKOoeDbm7RSgLO49o6sN2ZheU4QmjqWR56tR91zkIOVvxEJ+us8
         rbL0ZlOKAxl42VSQmvpUHjgBiDOPmiLMyt9rlY9S2azb6EKegfIfhhDzqGdq25Ty2z8h
         4lidO2nTyObGtwUggF9ddec9JMv332p07hqUuHYf9D01ikmW5oBtB3yR56i/kquvz5P/
         VjYJ7jAC5/MKtGS2GRvoyOLphlLdefpEqD6kgDH42PT4Viqu3VW3HVipiD+1Z+vHVu14
         sEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311279; x=1777916079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdEnpzDIOCEcXBvG6SCSAkx4aELVLebcgUGVQXndMA8=;
        b=cDMbWI6vDEMNnRBbxVKbdQqcdusEg1Atx4ciOxR1fxrxESHZS9p+EkVcDaAjmXlRSs
         Z+inonp+cSz9Cw7nfC+WM+5ub9AMNdb4SGShiY6pYklSsNTZcVFRR0rmuBjHPCxzIAo1
         7D1UXMFo5MqlWBYqXOepVN8u/mylcW1pl/cnKt9k8iRcZAQn4+eB9oEIhV0Thd4Fe4D9
         2GherA3ubn14MdOAjJtbg8Zyrr9eLKAPgCaPkMW0QBpPvgaj4ECyB2SLMRQzWudPEUjY
         3EVyjZ75GxwFKaymDtgdVHr/d9IrFJHqkCX2GJ8M6M48XMO+bJf/cYLB4ggQ4hPgP+ec
         NHuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gcbGSuCB7ECXH0wLnVsqpLBly6IhiT4AoJU7/3IZTzCHXBjCvqLCR+DTytzV8n4JPqpVHGu8mvb2ARmT0NItt@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrTty1iSYEB0l6SO3eXIX06ydy+/c7AJ8h76vlVaFrM4R2Blk
	HSNte5leJGrcac99YBik/851qS+PFwPZDqdZzJdxHkCHL2W0wJg43x4WQKmd2OaNFPaVL17rHjI
	40uNuqA==
X-Received: from pfblh2.prod.google.com ([2002:a05:6a00:7102:b0:82f:ad57:40bb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3498:b0:82f:85c8:fc19
 with SMTP id d2e1a72fcca58-82f8c8502d9mr43552491b3a.11.1777311279289; Mon, 27
 Apr 2026 10:34:39 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:34:38 -0700
In-Reply-To: <9d318656-3faf-479c-817f-f32f7d5caaae@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-3-seanjc@google.com>
 <9d318656-3faf-479c-817f-f32f7d5caaae@linux.intel.com>
Message-ID: <ae-eLlHq8g3KMuXT@google.com>
Subject: Re: [PATCH v2 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 27, 2026, Dapeng Mi wrote:
> > @@ -5065,6 +5056,26 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
> >  	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> >  		guest_pebs_mask = 0;
> >  
> > +	/*
> > +	 * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS will be
> > +	 * active in the guest; if no records will be generated while the guest
> > +	 * is running, then simply keep the host values resident in hardware.
> > +	 */
> > +	arr[(*nr)++] = (struct perf_guest_switch_msr){
> > +		.msr = MSR_IA32_DS_AREA,
> > +		.host = (unsigned long)cpuc->ds,
> > +		.guest = guest_pebs_mask ? kvm_pmu->ds_area : (unsigned long)cpuc->ds,
> > +	};
> 
> The code looks good to me.
> 
> one nit: people may be curious on why set same host value for guest if they
> don't notice that the same value on host and guest would lead to the MSRs
> would be removed from MSR load-list. Maybe add comments to further explain it.

+1.  In the same comment (maybe on the function?), I'll also call out that the
inclusion/exclusion of MSRs must only ever be based on constant host state,
specifically because of the need to _remove_ MSRs from the list when KVM doesn't
need to load a guest value on entry.

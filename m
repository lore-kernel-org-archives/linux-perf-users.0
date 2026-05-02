Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8375E54B
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680300; cv=pass; b=FKcuXm1Ehbot5wVJZ5gVx8pd/ot7mt2wlvLbgYW4h0B5ESQpltfhxR9CaJROs36+L2v/3uDL1Ki64NtFm6Q9NowW6/5MMN2PfwKjAAIxx9A6DqDdLBW7rzV7EVBljz0JAI8yq/BRuUkgV7Ii7+yhEUoNG7i6If9dkJOJs3Rh2Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680300; c=relaxed/simple;
	bh=jmTIlqDIG+2F0eY0rS1JU8RB5gKbSRn+IjlGTZDRniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvtBjfsbs24abw9tbCN7eVJjS5LnamK6azAkIL1O1REgikJGxJRirnNURbdZeCf1ODoUGsvBG2rElzvPyad/2FypWHonT/SPbZ6Oc0kRthtmfiWXUrm8XndzLDbLPpHLAGy5dC58aQIyecb1nUxneQ976XDXgb6D9bBkIAfYFhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nronevRu; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nronevRu"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso1439a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 17:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777680297; cv=none;
        d=google.com; s=arc-20240605;
        b=EtZIGg3RUg5tAv4lPz8hZPdzCeOkwKiZSSVDQsmAoDRKA7TnBFL6OvV4GGxOECPiV4
         7mTbsrar9q/a2iN3EknrtLRcLKxy6GjQPLkf2yOjb4GZ2l5GY5/ogoKNA9n872pqPLAZ
         i0J3cuPUgsRqg1LsmtvMwiwSRZ4HrBP4z+EzwMYk/ofKLITbV2qu+ACBRAfOGoqXtSp7
         mkDrTR2QH1KXqdvJfTw7Rl452mr5eF4YPcgtEk+bJoxihpczCFKKDHVZvwlvsNHGEoJg
         prIHXncKDaki8dLTJMhAqd/HcIXN+QqawoCJicNDqkrAEqdhFmMu/261PWFttFlOhBSS
         k5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BiMKE0Qc1DxW4ucWujV74L8Z61uu2FejYlr/YNQXWk4=;
        fh=ll7wjZ3G4RMsdSRy1fyS/cZW9xW3FMGsRMxyfdUGoIs=;
        b=ROqY+efTJvuZGuLBlRVI6xMiFvZLWCzu1b9z39WIfWFeLyJAGM9edEJvFXAtKCeUjx
         CgOVjvKpEHvFkPukN20YyRusA+kYHY0KFtPyn+MlFBL+QElHOy9SCtkVkKuA/5m7Si4s
         WgxoxAsXxWjTYqBKfb1IOsTAAECtmCqqcE7CRMHaFPeMH7gE6ICJChNJjM5Dp0vILah2
         wpF0QOg+Kh94DCcD8slJcy6EqH54E6+wQX4rhJ2vUXTzJQFRDibMuvjPy/9gRHd4n70a
         WRBodSXm3rwM8PnlRmR44u6R+xyqOIrl0N9G0eb4EMTREC8eYjfxmygK1mfdy5C6fcn5
         Ymqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777680297; x=1778285097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiMKE0Qc1DxW4ucWujV74L8Z61uu2FejYlr/YNQXWk4=;
        b=nronevRu2lKBvXZMA4+w1LG6/B98OZddxZukCSWvBQdVCFdO8pw8sbQWwvAh8XiyMp
         ADLq9OVAXH0Xxs46757UkllcnOv1nNM2dmcHQxzVLHylVhxYttTFEEAxwg3FQJs3VRhg
         17U1AJVMovjqFgLKEtOGQwAFB+wyNUUT/Ose0t6NmWyD+i5POra1kCVncM/020454owu
         EghtXs7ir5X2Czf4oNqxzlp6ofbGLUYvYMAU5A43tm3YGTghUMZSdDMuUB5SGiueWn0e
         MEDLZp3RCy7MexwtKh8keLCXwQKNqNqJcUO5Z1J7pTdwTxllyIEgwxWl14cFhTf3A/2f
         dnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777680297; x=1778285097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BiMKE0Qc1DxW4ucWujV74L8Z61uu2FejYlr/YNQXWk4=;
        b=rUn6ZHUeNAZxlLuZzPPJRvvAbl2bnHy5ibCcqyO8BXzwptVsJHWDxv+UfGB+wAfDzO
         zBksLmNKRDSxOe2bDPgld8ruu35nUvOEDW7FwfSX2qYfyE82bjOCLmx4HTtzONDX9o8w
         B4ttncVf0DB+F6QTQQ72QSYP4NCHdVWitWiCkB4oo5bxj6pYt2dhJ6lsZn6waSzZgNDh
         N/f2OKTF6Deh0i5KABLcQn4EYNDfvHMh4bM9pKnbgTOL3XY6jb4fJwD8/dSRYbkvcal5
         esud5UnqPeAyV536vShWt1uvjqMFNIsQQrhSBDrQDNAsk27droCyl1tHRq6hmtwi7bgq
         To3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9z5sHu7+fswq5ZQ4zAKf5eFITVqu/UcrgAQuLXAXoRhK1XjQUpLBylsRHDxQSa4WWGXiwovHQhQxD9hBbRDI1L@vger.kernel.org
X-Gm-Message-State: AOJu0YwsB5jaTwybrrBTpBct3V1VbO4KBHiHQPp6ZC3QLO3xeogNJSxj
	UtjqcIpTWnd5FWjrU1q/lfI2f+2ccnmayACuu5KDcpmxIGecyFyJg3BB3IfMCNzDHaFyelIN0kN
	3McoBS3PClpu81sa2JJjctX/OSP5EAYqvIHlIca4l
X-Gm-Gg: AeBDieurzc/bjPNhKnXAWe9N1n1pHEBdfFhsv0egri6hLWyEWrAoZclfVtDOPJYJT5j
	bizBB7MIaadCu61FxB8uNuv8vbQ65qnNYqMFac2MBJMv7WB8/o9E702uEqolYikd8twOL3cjtFh
	xFMgR4lm+lhThHF+RZJJM7qL2cNdL1ySz6UnrJMPFkB0NJ+P98BsNSkfTYmgYfYB0NHDtYRie0m
	m8yQCpxtCjD9i0y36S8soLWeUM2gxrfGFCnd7b6lHY10DrcBoPrdOyF5102C7LT+Y8gbYpi0jNz
	2T4Zj7R1K27Tnw31wHTGfvI8kQ6G
X-Received: by 2002:a05:6402:148c:b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-67c1df8eb77mr10027a12.3.1777680296929; Fri, 01 May 2026
 17:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
In-Reply-To: <20260423150340.463896-5-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 1 May 2026 17:04:44 -0700
X-Gm-Features: AVHnY4LR57kQ_JJz2IVwy7QXTY7cpNVRpOebxhP2Ymd9SP-YstGqP92VpD8VPNc
Message-ID: <CALMp9eSt-ZDCxhyVjEiov2475ToZ7M_94HSpKg6hqrh=m3iZAg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

.

On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Have perf define a struct for getting guest PEBS data from KVM instead of
> poking into the kvm_pmu structure.  Passing in an entire "struct kvm_pmu"
> _as an opaque pointer_ to get at four fields is silly, especially since
> one of the fields exists purely to convey information to perf, i.e. isn't
> used by KVM.
>
> Perf should also own its APIs, i.e. define what fields/data it needs, not
> rely on KVM to throw fields into data structures that effectively hold
> KVM-internal state.
>
> Opportunistically rephrase the comment about cross-mapped counters to
> explain *why* PEBS needs to be disabled.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> ...
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 7403ca721b6a..04d9c51335d7 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -14,7 +14,6 @@
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <linux/nmi.h>
> -#include <linux/kvm_host.h>
>
>  #include <asm/cpufeature.h>
>  #include <asm/debugreg.h>
> @@ -4992,11 +4991,11 @@ static int intel_pmu_hw_config(struct perf_event =
*event)
>   * when it uses {RD,WR}MSR, which should be handled by the KVM context,
>   * specifically in the intel_pmu_{get,set}_msr().
>   */
> -static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void =
*data)
> +static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
> +                                                         struct x86_gues=
t_pebs *guest_pebs)
>  {
>         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>         struct perf_guest_switch_msr *arr =3D cpuc->guest_switch_msrs;
> -       struct kvm_pmu *kvm_pmu =3D (struct kvm_pmu *)data;
>         u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
>         u64 pebs_mask =3D cpuc->pebs_enabled & x86_pmu.pebs_capable;
>         u64 guest_pebs_mask =3D pebs_mask & ~cpuc->intel_ctrl_host_mask;
> @@ -5052,7 +5051,7 @@ static struct perf_guest_switch_msr *intel_guest_ge=
t_msrs(int *nr, void *data)
>          * wrong counter(s).  Similarly, disallow PEBS in the guest if th=
e host
>          * is using PEBS, to avoid bleeding host state into PEBS records.
>          */
> -       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_=
mapped_mask;
> +       guest_pebs_mask &=3D guest_pebs->enable & ~guest_pebs->cross_mapp=
ed_mask;

It would be helpful to save this mask somewhere, so that it can be
used when calculating guest_pebs_idxs in x86_pmu_handle_guest_pebs().
I think that code needs a fix similar to the one in commit
58f6217e5d01 ("perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
with vCPU's value.").

Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ABE168B1
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863294; cv=none; b=oVgo/bKfUVzRkIrEDtk+vkQWnRp+KgNc5FTdfoz97Vw28HgT9/zQ0+m0rlCv6kJWMh1bTiLc/qk5K+a12uA9g6ayp9PG2zZinE1s87FZguKp7Xj3ioF+q8WgXq76WM9kctzvXJUw3x9J3Dd8b3ZTb5MY5UVu5WzhsvSEVU5BOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863294; c=relaxed/simple;
	bh=0iDrj2AwfZPdpvbdX9zswaCeouu1E0y3S0A8fzExlVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NEXB2p7x4sDWu3g7NbDw4Fm9s5K/GssrtSjjB+s71gHpOLHO9Un7O2Kv/xbgj12XnhGIySskG/UTCSyAtWgp8LmJQERNfgB7eh4K1XPTOTi8CqooIo96m6eKbiqOF5/q4hGQHBHqu7yv9z+SjA5Ab6QjY6pgaB+fbnykGDxGsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HV0dDten; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HV0dDten"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a537ab9d7eso116322a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712863292; x=1713468092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IuZWM+vvGhXI111nZezq7YkDGfyo2NaCVPFqmlVhiZg=;
        b=HV0dDtenLo7xoWt3tuGE+MsFQMFI68O+g88NMlCmQKr+x8ZRiUGCECNYs/6jKKwChQ
         JJXYDL7g+4v7xePFR0ZkxgAVUyYMR4F88GyBMSltXoz757Z0li4V93dpKTLmc0NeGWpP
         TLSYY3cTGxAIKRQUwBI2pWU8VaLGCygpmrAQK7tZx/de+8DRt4dZUnUcB6HRxtH++iXI
         5fR+HxsBgfm+CZ+En9OCBJYk7z0Bn+ingwGHgrwRUCFvbX4GDJFC2nFNrMATfF6oya0c
         b1ir/jaxDMz3zFtMwB9kP9LZjoj47DyjRkvhOMcnx+Ui2Kw8CRY+ZbfypYQUQiirvjWy
         A8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863292; x=1713468092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuZWM+vvGhXI111nZezq7YkDGfyo2NaCVPFqmlVhiZg=;
        b=sJz1naJJXbYFJOWrsWxXaBFYso/NQv819VWImW7bNMQLCOICylEdJb2rZXnAKmgYgc
         QIONxQdZmhNmlfN3V8kWiBSsGx5k7+keQdc7PCoVtrwdm0zK3n7LI+OxCndu4IBI509k
         ps6wd40uwWlAyc4yQw+OaGuDl8k3JANvEf88TG8Csdpmf1a0Gj7UsQRehvoriN/WETq0
         3jXtekS50IoA3m8Js7sZ2/dQPKpFHoTfK/TAh1jbhA9m/Rl9Tp0uMPPsSAx5BG8o8DPN
         gb/6KOwgCTDpv6ecCEJqJWxILzDbVV+8iJwcpa6zp42snU62hPo9LZ2oiJzEiY+kx9O2
         OFSw==
X-Forwarded-Encrypted: i=1; AJvYcCWVpVnZrX/LDofVT1uUzwgSlT3otT035S+sujbB0OG9zzgql7mkqko7UTTJ2JYDOmQdby8q0r0raQD3XOMJJnfq6GijaySfM4uPC94mnErEFg==
X-Gm-Message-State: AOJu0YzYLyZyf94x7mTGn3MEKWZi4NsE72xCj4vAF1BkQHFZuDckBuBN
	NI6U1WMsuLLmfzEUASr1mKmXrc1FrzBkBL+5UuTicy6r+W28AQIfNBf2lcJowkBKaTSHi0j5Kmv
	stg==
X-Google-Smtp-Source: AGHT+IHPgtVqy0nFz025gGkTnMo7Alsvac05GAyUWXxa4k7Ytx/BHJCnyE1o2+n0hRWW+1ji8QfCIZN6pMU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:fb94:b0:2a5:2428:2253 with SMTP id
 cp20-20020a17090afb9400b002a524282253mr1232pjb.8.1712863291990; Thu, 11 Apr
 2024 12:21:31 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:21:30 -0700
In-Reply-To: <20240126085444.324918-8-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-8-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhg4Oph6yCpN0DeX@google.com>
Subject: Re: [RFC PATCH 07/41] perf/x86: Add interface to reflect virtual
 LVTPC_MASK bit onto HW
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Xiong Zhang <xiong.y.zhang@intel.com>
> 
> When guest clear LVTPC_MASK bit in guest PMI handler at PMU passthrough
> mode, this bit should be reflected onto HW, otherwise HW couldn't generate
> PMI again during VM running until it is cleared.

This fixes a bug in the previous patch, i.e. this should not be a standalone
patch.

> 
> This commit set HW LVTPC_MASK bit at PMU vecctor switching to KVM PMI
> vector.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/events/core.c            | 9 +++++++--
>  arch/x86/include/asm/perf_event.h | 2 +-
>  arch/x86/kvm/lapic.h              | 1 -
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 3f87894d8c8e..ece042cfb470 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -709,13 +709,18 @@ void perf_guest_switch_to_host_pmi_vector(void)
>  }
>  EXPORT_SYMBOL_GPL(perf_guest_switch_to_host_pmi_vector);
>  
> -void perf_guest_switch_to_kvm_pmi_vector(void)
> +void perf_guest_switch_to_kvm_pmi_vector(bool mask)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> -	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR);
> +	if (mask)
> +		apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR |
> +			   APIC_LVT_MASKED);
> +	else
> +		apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR);
>  }

Or more simply:

void perf_guest_enter(u32 guest_lvtpc)
{
	...

	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_VPMU_VECTOR |
			       (guest_lvtpc & APIC_LVT_MASKED));
}

and then on the KVM side:

	perf_guest_enter(kvm_lapic_get_reg(vcpu->arch.apic, APIC_LVTPC));

because an in-kernel APIC should be a hard requirement for the mediated PMU.

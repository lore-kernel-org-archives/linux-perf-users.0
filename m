Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3189308F19
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Aug 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273100; cv=none; b=tZfqME77pDszfebyK2E0cdUEW/IMxAA798SlifvMaf6xmVM07V36ZB3WJ3Va0KqePKupl61D5YXQeSnARRUSJmvOwGiskZSadPxhwuHIiM84oHdinDEoWu0Nspr3MjUIgBDAhfuXiiZ/wj8F35hs6+pJHrtsPf8wc1cW05yCYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273100; c=relaxed/simple;
	bh=TC3F7GjzY+OYu16pCnRLEw1W9DDDYcqj1aSZMIOYjuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxBzLyEI9qEGRLvFGs1/BZXvxsMd+UMCZUnZd7fwNfdt/WiaxnHGdcOWJRp3rirCvRryHh5qrLUVBQBCQtvsTwzw5oXKbRMNJPIS88tN8Uui9MaeOnPpWUZDaGa4AMQHNFb/oBfA3hi1kZEtRpoM6jO7TisvwTGNbcGUxgCKIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbUwWtvm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbUwWtvm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244570600a1so24406775ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Aug 2025 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755273098; x=1755877898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLuuQdqXBRGyu60+ieS//bbxP+3AVwFN22YqAdloirM=;
        b=VbUwWtvmPg2mzJ1mDCrvoA9XcEX+R1vUa2Ytu1ZtQTkrmWQBNqlULza7r07TfXRunw
         rgTiJih/HIKEqr7vaGDRRkBS0UnEY54fKQBbf4WBjGJVIk38G8ugO1jrZ3Xd0gSIz6cT
         R8STM5KEF6lEudZxvKFLWEkK0CiqcYRWCl8OZlFVyonlBmDE43x4v3HHCoaFVQYkZue0
         3DDjzZSrVEJdosIX6rTshEjnnm7d/hKlnkWEy3LUwn8NqJ7LWYZ2DxJChCMoZwznWSqX
         TRyAEETcPbALtpKTWxzCy1T3weTv0fjnZI76Z8PrWUcFGL84VdFEXdrEadNIdzowWYYh
         l9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273098; x=1755877898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLuuQdqXBRGyu60+ieS//bbxP+3AVwFN22YqAdloirM=;
        b=Kf4jeknXWkwc6E7MWWhI8uaC6prEmXR6qHW/gtl0VYSPh5skAcvBiqDjuTt0Ge41mH
         7kgJ/z4tSQsHrhpmYX2Cci258tA+Y7/gox+87WRsJcLxAGRtAK0CQFRqyNoWHKAnPXpj
         bIue+D3aGFI8N4YrwHfpQqrTfoevaui8FZcnE2T8PHX8XGiGEmnbEh9bZaEECE9TVFak
         6kCOESMU/9r26BCLhOAQfxOwxZRW95weuxxuxDQEm4J0W+TCUMMYVcT6UgWU7tidoGOg
         6GFNPOqdXrbk9JiyQhQswaMua/12Tn2l+3AeqapWqIdHy+dKRKDPKZXXbb2Oew430OOJ
         PyNw==
X-Forwarded-Encrypted: i=1; AJvYcCU2BLuDNGI76tQz+rJpJDnSQ5JQPBYsmgbSU3wrIbNcf/xbCpZoRF4GCn1N+sTRVUad7m4db9+P3zGcs9ln3Vgn@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqegKzFHlU6V2tbz9GJz72Rhe5tcYws3oC3tJKGSbeYR3XG8s
	vCVX9Wr8/eubuzkBi1ij/lBmtQSsaTZqUH+E/KoA/w1JJSGaqMh+HS8z7Yqog9cRssYJbxKHWKA
	9lQ9Qtg==
X-Google-Smtp-Source: AGHT+IEixUUF/+ontXG1UvvxuaP113HP3iSlTpnTS0Og0gwZnRo8djp+nSrKI0cvN3mMbDgB4JtBQNij17k=
X-Received: from pjee7.prod.google.com ([2002:a17:90b:5787:b0:321:c2d6:d1c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec3:b0:244:5aa5:a8b
 with SMTP id d9443c01a7336-2445aa50e20mr99042625ad.27.1755273098085; Fri, 15
 Aug 2025 08:51:38 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:51:36 -0700
In-Reply-To: <20250815130436.GA3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com> <20250806195706.1650976-10-seanjc@google.com>
 <20250815130436.GA3289052@noisy.programming.kicks-ass.net>
Message-ID: <aJ9XiAa58oMs55Ky@google.com>
Subject: Re: [PATCH v5 09/44] perf/x86: Switch LVTPC to/from mediated PMI
 vector on guest load/put context
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Mingwei Zhang <mizhang@google.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 15, 2025, Peter Zijlstra wrote:
> On Wed, Aug 06, 2025 at 12:56:31PM -0700, Sean Christopherson wrote:
> 
> > @@ -2727,6 +2739,21 @@ static struct pmu pmu = {
> >  	.filter			= x86_pmu_filter,
> >  };
> >  
> > +void arch_perf_load_guest_context(unsigned long data)
> > +{
> > +	u32 masked = data & APIC_LVT_MASKED;
> > +
> > +	apic_write(APIC_LVTPC,
> > +		   APIC_DM_FIXED | PERF_GUEST_MEDIATED_PMI_VECTOR | masked);
> > +	this_cpu_write(x86_guest_ctx_loaded, true);
> > +}
> 
> I'm further confused, why would this ever be masked?

The idea is to match the guest's LVTPC state so that KVM doesn't trigger IRQ
VM-Exits on counter overflow when the guest's LVTPC is masked.

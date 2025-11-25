Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5271D6BB
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035316; cv=none; b=ZcqF1qjwuvf6/hbEWOs27NG5r1V2YnTYHoTQ2LTIf3CAmQXoC/NHleuaxApWE615Tu9oXDt9yix0aAY5jnefIgotvXBKjeuNljqMR5b1FJ2VRnDsjJRaBM988EwUG1QUtKkXPVSAnSuNGQhA6Pi0jX7qku6MtdC+I8S3m9AA3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035316; c=relaxed/simple;
	bh=lFQY39DQ0sZ3/1CBs/5a9Gc/Z7HqjZGV9ub0E6byxfg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VWJ25R4HnFWOIt1cQwNc523OoYOHGdmr2u/zc4UcvJox7DZgt/+dKQRTloNmzIJimxmdx/VJVwWow9C8RFK5pBLGISeCyLxuJDDbSi6JufpefeLBQRqKAojVdKgMob7WSLJXxvVwhhdQjLgN64tBO6YxAb1oLvJW/UDJSXY9rS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHOn9LvZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHOn9LvZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3437b43eec4so8005035a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 17:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764035314; x=1764640114; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxECKAH71uYUFlk1OLSRLVGsdtXKfBuiVH3qX5Bq1JE=;
        b=IHOn9LvZ5ruN4WXJfYa6XrAOBbmnRCg479IO3EiNissMGF4F4FqYSktpzj4BRMNA0k
         36acquoO7D8bgvtUEaK1NJ4/ujc7oJPuF9lez+1DZ3OUqOf+5Ld2AbNy8G01Fj/owcjM
         RFE3YHoYGo3ya/JTJp2nfuzXAwDZ7bOwEFZF2Pmd+TQhtQLXeX5jnIydfan/6WAywBx7
         m86DeyAgmmGZZyMxUWg8jbNYLzouBbE3hbWt0lUauMw9/u9gF0mjwVR8U+H+CISCNm7C
         IRHXC3806ctU50cfi+4ZbMau3W1sBnEHnA3PUmmMU7CPTRZ7ePl/qzQAoSQu7An3Hv73
         g3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764035314; x=1764640114;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxECKAH71uYUFlk1OLSRLVGsdtXKfBuiVH3qX5Bq1JE=;
        b=vVW2HpyQ718HgEM+clhQsN+eerG9FYBt+8hHT2baXwGPcbKs0j9Fjm+NuFsfMV7Fep
         3wieIxXrEqllvbo/84Fn2D+A7VLkv5sa97jGQFFso7sAZCbOfaUillb9VplBVlSema2b
         JiRyt3AO+6MzZHLoBAzMc0VZNxg1P2yQWMT60yL9Z4egJFs8hStzmOQn0j0NV/FnRvpe
         bgxSnHQddCYBGfs3lWmj6pqaeibv/05L+9GWUiObzGtYgiSWt412MQdwoxa78m/u2HKD
         uXT/aschV7C1SqToGgfy1YFlHAqx5UnLdOwhQ5rn4YsqM63E6vvmpW0/l0kkCmu2jT02
         TVVg==
X-Forwarded-Encrypted: i=1; AJvYcCWb8ZlvjoM2Oykxd84WDGYVHY+JI60y1/X5rMOADajAAORkr6UEFkRnAbN5hLM+pQYHDSxGYv37XPsP4PqS21Rb@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFoj4oagO6FRHy18FW6CQwjqHxsg2Hz7Wi/ARS0HbRmA+5vJx
	ndMcCvSddaMBX7wVvrt+V/wz50XMAtdCqDaVK5NAk0Su14X5hyJSgiH7o19Y7A4nkQn4JDXni6j
	CwnOeQQ==
X-Google-Smtp-Source: AGHT+IGw7n/WkVQTGzwbQxQ9VV1HAFWO+WUionAVci6QFcq9BhvaMpdHuGTmwsKZi9fkk+aykjevdAFNlrA=
X-Received: from pjvb14.prod.google.com ([2002:a17:90a:d88e:b0:341:8ac7:27a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164a:b0:340:c261:f9db
 with SMTP id 98e67ed59e1d1-34733e60944mr13320658a91.10.1764035314194; Mon, 24
 Nov 2025 17:48:34 -0800 (PST)
Date: Mon, 24 Nov 2025 17:48:32 -0800
In-Reply-To: <20250806195706.1650976-29-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com> <20250806195706.1650976-29-seanjc@google.com>
Message-ID: <aSUK8FuWT4lpMP3F@google.com>
Subject: Re: [PATCH v5 28/44] KVM: x86/pmu: Load/save GLOBAL_CTRL via
 entry/exit fields for mediated PMU
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Mingwei Zhang <mizhang@google.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 06, 2025, Sean Christopherson wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> When running a guest with a mediated PMU, context switch PERF_GLOBAL_CTRL
> via the dedicated VMCS fields for both host and guest.  For the host,
> always zero GLOBAL_CTRL on exit as the guest's state will still be loaded
> in hardware (KVM will context switch the bulk of PMU state outside of the
> inner run loop).  For the guest, use the dedicated fields to atomically
> load and save PERF_GLOBAL_CTRL on all entry/exits.
> 
> Note, VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL was introduced by Sapphire
> Rapids, and is expected to be supported on all CPUs with PMU v4+.  WARN if
> that expectation is not met.  Alternatively, KVM could manually save
> PERF_GLOBAL_CTRL via the MSR save list, but the associated complexity and
> runtime overhead is unjustified given that the feature should always be
> available on relevant CPUs.

This is wrong, PMU v4 has been supported since Skylake.

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 7ab35ef4a3b1..98f7b45ea391 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -787,7 +787,23 @@ static bool intel_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_
>  	 * Require v4+ for MSR_CORE_PERF_GLOBAL_STATUS_SET, and full-width
>  	 * writes so that KVM can precisely load guest counter values.
>  	 */
> -	return host_pmu->version >= 4 && host_perf_cap & PERF_CAP_FW_WRITES;
> +	if (host_pmu->version < 4 || !(host_perf_cap & PERF_CAP_FW_WRITES))
> +		return false;
> +
> +	/*
> +	 * All CPUs that support a mediated PMU are expected to support loading
> +	 * and saving PERF_GLOBAL_CTRL via dedicated VMCS fields.
> +	 */
> +	if (WARN_ON_ONCE(!cpu_has_load_perf_global_ctrl() ||
> +			 !cpu_has_save_perf_global_ctrl()))
> +		return false;

And so this WARN fires due to cpu_has_save_perf_global_ctrl() being false.  The
bad changelog is mine, but the code isn't entirely my fault.  I did suggest the
WARN in v3[1], probably because I forgot when PMU v4 was introduced and no one
corrected me.

v4 of the series[2] then made cpu_has_save_perf_global_ctrl() a hard requirement,
based on my miguided feedback.

   * Only support GLOBAL_CTRL save/restore with VMCS exec_ctrl, drop the MSR
     save/retore list support for GLOBAL_CTRL, thus the support of mediated
     vPMU is constrained to SapphireRapids and later CPUs on Intel side.

Doubly frustrating is that this was discussed in the original RFC, where Jim
pointed out[3] that requiring VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL would prevent
enabling the mediated PMU on Skylake+, and I completely forgot that conversation
by the time v3 of the series rolled around :-(

As mentioned in the discussion with Jim, _if_ PMU v4 was introduced with ICX (or
later), then I'd be in favor of making VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL a hard
requirement.  But losing supporting Skylake+ is a bit much.

There are a few warts with nVMX's use of the auto-store list that need to be
cleaned up, but on the plus side it's also a good excuse to clean up
{add,clear}_atomic_switch_msr(), which have accumulated some cruft and quite a
bit of duplicate code.  And while I still dislike using the auto-store list, the
code isn't as ugly as it was back in v3 because we _can_ make the "load" VMCS
controls mandatory without losing support for any CPUs (they predate PMU v4).

[1] https://lore.kernel.org/all/ZzyWKTMdNi5YjvEM@google.com
[2] https://lore.kernel.org/all/20250324173121.1275209-1-mizhang@google.com
[3] https://lore.kernel.org/all/CALMp9eQ+-wcj8QMmFR07zvxFF22-bWwQgV-PZvD04ruQ=0NBBA@mail.gmail.com

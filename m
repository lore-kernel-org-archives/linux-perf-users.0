Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF58478865
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036718; cv=none; b=KWdkV0x0pELHv0bYp/WJ2vgB/AaBYDs1tK3m6LuS5iwLN+OJYFVUCF6wGlZpsBQruQhkFCzraLuuOfDcgVk/bgMU53/fEEY1078oP9NRyRr0eZUbUKoSTkkrV1DhduU/km8vXhtzTTkmNywcL5ndnc3u4p60zSNEGDIqborMIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036718; c=relaxed/simple;
	bh=/osmdlOzOaPZjmz/eL73IZgcEBPxf62ZZzBFgEBZrPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=l/FGaNehaHQaYsleDGyx3k1/qDZdwThPupu7mO/C2+5dt+nkzQd+2ynYx8/7z9rBCPxenSwCFVUuvBtI+bDPE9YxEUT6FSmoyWbYxPHhqLU9I9gpXWRce/chrgNFFvpEXAkezu7xYudLiTOnQzKioIVBiHthoHKBdltYmeW/zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCJ5f2Et; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCJ5f2Et"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so3097764a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Aug 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786036715; x=1786641515; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhI24rX+Y5w7TUnQEOZYP3VlRg2+NeVZmSo9caXsF8c=;
        b=CCJ5f2EtWI3L0sWbuXS9/h1Mdsrcfpk9WsbGnJssnrFY3yADmF4/o38cDuqfTfTRWf
         fmEazsTS2tSgTLej4bw764RvtmJMoW8QezLvTDfuxACzyt6twk2Y5Kl4LdTIONEr6vZq
         9sb/wFaVPy2CmJBL1ISsQOw4QC2cgUhp15peLra6IBxEwecPAqBQV4d0Sh+znLcYZEiQ
         SPjgscaLBgR42I0lGi2YbC/aUVZYd7DjHwLACtq9x89ybDmiEa4q5AUyoC1JSTaQ46po
         t41kGVAbRWTYWY/B2h3zIn67hVLyzjeLqvzf5fAREYWTX5/lnxv+3CMDCtP3X8D4y/pT
         2GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036715; x=1786641515;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhI24rX+Y5w7TUnQEOZYP3VlRg2+NeVZmSo9caXsF8c=;
        b=G/CCn+aqm/BKx+WGqZtjl6dKv3EYMR+VKVxX9Yg9HJ1lwmNZ6Hmjhk7TEvht9Bv2ql
         OdhzuBpko0dGxfQLr+MEspjW4mxc7GdM+d0ShZsQBKta6+5jKdw3612CTckxX7x3Q5E8
         eQeOY5Of0widUQrLVNxhaG8yKO/Hv7r+Dl9GTObfyuv63zrqxjlXuoGgHR+19Mr0SUbF
         QjSjzg95qCwfvmG+XjJhmLOZORQExsoe6nEjwWMyreZ5bu/14EFzDSKTikSBhhr/fHta
         qzWqC1xQYnBNQfnU+kQ8hwWBAj+EjNAnrbWbWGCv9tndsTiMN94WV2613LR26Vdji3Kr
         SFgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFcYjrPP08KoMa4NTxcAsRz8RJtQfsi8fIlgzi/JpZjzR4S81GTzj3WgfiWvMiaZ/jM41WVmv45Ww+YJSEtyte@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmn4dwNOYBn7xUZHhethCXrk3lr5PEPja5n0MQ/D1FWlpKTk3L
	AMOvUk4yjL2xz4/SRi3+BWdgr6kCPhB9TnvOBrY0rLcRQvscqMOsGpPyae4FndmpkYEhVN6CRSa
	8byzrBA==
X-Received: from pjbgi21.prod.google.com ([2002:a17:90b:1115:b0:38e:620b:ba5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1843:b0:37f:bfa2:1887
 with SMTP id 98e67ed59e1d1-3903c53639amr17964821a91.8.1786036715207; Thu, 06
 Aug 2026 10:18:35 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:18:34 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
Message-ID: <anTB6ksbUs18FEf1@google.com>
Subject: Re: [PATCH v3 0/9] perf/x86: Don't write PEBS_ENABLED on KVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Sean Christopherson wrote:
> Sean Christopherson (9):
>   perf/x86/intel: Ensure guest PEBS path doesn't set unwanted
>     PERF_GLOBAL_CTRL bits
>   perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
>     has isolation
>   perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
>     is unused
>   perf/x86/intel: Make @data a mandatory param for
>     intel_guest_get_msrs()
>   perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
>   perf/x86: KVM: Have perf define a dedicated struct for getting guest
>     PEBS data
>   perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
>   KVM: VMX: Drop a redundant pmu->global_ctrl check when processing
>     pebs_enable
>   KVM: VMX: Only tell perf to enable PEBS counters for fully enabled
>     PMCs
> 
>  arch/x86/events/core.c            |  5 +-
>  arch/x86/events/intel/core.c      | 92 +++++++++++++++++++------------
>  arch/x86/events/intel/lbr.c       |  2 +-
>  arch/x86/events/perf_event.h      |  7 ++-
>  arch/x86/include/asm/kvm_host.h   |  9 ---
>  arch/x86/include/asm/perf_event.h | 11 +++-
>  arch/x86/kvm/vmx/pmu_intel.c      | 28 +++++++---
>  arch/x86/kvm/vmx/vmx.c            | 10 ++--
>  arch/x86/kvm/vmx/vmx.h            | 15 ++++-
>  9 files changed, 114 insertions(+), 65 deletions(-)

Ping.  This still applies on Linus' tree and against tip/master.

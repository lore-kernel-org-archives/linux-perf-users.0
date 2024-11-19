Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6C1CF7DB
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030993; cv=none; b=tdHIPEmyRTo5RSsryceS1ULK94FuMIz9W70ttDCbPi7RO4qrhVivY6mD1yvHDc71M5IlSsRNBCSdMaFwEJKVLhfOHfAp9xf69K/7inhWcgLabha1u8UCtDo1kmDjfo9KfmTTtJJMZt6wq2U1kxi7sHqvimUAgn+VXh4hakjFo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030993; c=relaxed/simple;
	bh=KjKAUisPP4PTwPSuoMZH56lWV/0EBojMgOmHPXphLGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lBCmhaJZrIHF996BOaJSDxLUS8F02y8tjheYuXb/ydWX0F3+Zu2vNQDNwBq3GWoN7ehcf7bKvd1RuLL9JY3kyqcWk7NBTtQM192q4v8BnQZ7NDy2U5HQFujsphjOzzPHzAANc9ocju5wdvttHgk4m1cS2iRoGzLB+A4HcKf1tKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mULPKh8e; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mULPKh8e"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee86f21b2cso19289257b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732030990; x=1732635790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHYzDNeBKakJG8hRVBgbLBhXsiM23myvHWLb6lBUBoU=;
        b=mULPKh8eQiesuEd2kTFpxz6W1Vy5fWohVEJ6QOBsOAtUNGhS7m7P00yd1HcdxWWiPp
         5lPvx3/RZDTbjkVUWKgjrxmrxtkqrKrOauhcWHQAOsqGJ13X71InDlUFwScGJYy6ACQY
         9no4jjJ2m767vXZWWebvJ+Dy4AU1/OLh4NPhGkJHul9rjA6pv91YXET0UzP18I1frMGM
         WITQUEFrWknTqQ4c0fXOxSW3PmMppfDVpACaYkRvAdZHaEUlK+/ffxd+xJbAK+uewK8c
         cO8wNs7p04Uxvf5PFyafHcs69IRIIJqZBOuy6VT08lQtiVuannsqr9Kh81O2hS8BZ8pH
         rgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030990; x=1732635790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHYzDNeBKakJG8hRVBgbLBhXsiM23myvHWLb6lBUBoU=;
        b=cJgnPnd9x3iIO2wHA5JOc8nuYElahnahGbe9tadpmkkF9UbO6zmVDLuuUCE1vjAv5G
         U6bZveRncy2o4DErHuKZq266uOM1mXTZuE1Y58adl1/Y5vbwR8db2dkUWqIlVdH08WJj
         Au3Vz4rIZ6/0MPx+mFtHA24CYRAK9ZlXHwbtmP4BwCzWlj7bAYw/0DvgVck5bHERDFTP
         RpYsiK5lc1lmpSIL1kw4kP8fRwtMPCzRZaKGY3+16wiuQcEAhsxX1vYhoSaVwFNCGBBM
         ywz79zWNUQPg6w7Tb8WRJr6z4sUHBgGvSxDwMb7uPRGSbbwQuAz2aTWKw9mzaVHmD88N
         D2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFc6lZpfkFQr4s2MoS9xv0ZoYz8iiDHchxmmUsJiTNcf0D/ZjR33MVnipdyClGwho20eXWFRne60yphXyPbPLo@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNSrz33496GY/RVVMTEInpDU4pIxkTRpLjcjwnkHzHlOeiBIX
	pymi3jvq6U/K7wWnz3iXd2GJoadMCO0pQfWOSsFieo3Adhw/4yaFkO9G+xhhihToYNX7bM7UJ3P
	fNw==
X-Google-Smtp-Source: AGHT+IGqou6Wkgd/f8arnHNLYAjcsv42Bk6ENu0WspAXb1XpNYseCu3msu9X2fK8hbCplo8+EwidHJLGx0s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:e84:b0:e38:7c92:33b0 with SMTP id
 3f1490d57ef6-e387c9234d7mr42958276.9.1732030989964; Tue, 19 Nov 2024 07:43:09
 -0800 (PST)
Date: Tue, 19 Nov 2024 07:43:08 -0800
In-Reply-To: <20240801045907.4010984-23-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-23-mizhang@google.com>
Message-ID: <ZzyyDC7nh_5XGaHa@google.com>
Subject: Re: [RFC PATCH v3 22/58] KVM: x86/pmu: Add host_perf_cap and
 initialize it in kvm_x86_vendor_init()
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiong Zhang <xiong.y.zhang@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0c40f551130e..6db4dc496d2b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -239,6 +239,9 @@ EXPORT_SYMBOL_GPL(host_xss);
>  u64 __read_mostly host_arch_capabilities;
>  EXPORT_SYMBOL_GPL(host_arch_capabilities);
>  
> +u64 __read_mostly host_perf_cap;
> +EXPORT_SYMBOL_GPL(host_perf_cap);

In case you don't get a conflict on rebase, this should go in "struct kvm_host_values"
as "perf_capabilities".

>  const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
>  	KVM_GENERIC_VM_STATS(),
>  	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
> @@ -9793,6 +9796,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
>  		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, host_arch_capabilities);
>  
> +	if (boot_cpu_has(X86_FEATURE_PDCM))
> +		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
> +
>  	r = ops->hardware_setup();
>  	if (r != 0)
>  		goto out_mmu_exit;
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 

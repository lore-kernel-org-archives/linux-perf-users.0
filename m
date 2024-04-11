Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D565134A6
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863604; cv=none; b=Ml7mR2+iXhEUl9QYdzuiaUtDxF34AcBs52xZLTaoG4XxNwKm2CQkXpa6DBVaW67YW0axbE4+AHcBYzvViij1Vz1gV06icYpYskMGJLi6emL010F03aiDwfTSw9POAlpfUGBPVhQZEgOOLyMBlPR4kny/jo3WeU3FnfulxyrTEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863604; c=relaxed/simple;
	bh=0XgHpG9vX/kIvmtLehNYvc8OJhfk98bHSrvRyoWR2Kw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CWcT5iZZ+Ovnegl4c9g0IVhvL+ySMP/NS5jGPq1gO7f0hLCqLme0F6gA7/HpPTS/FW0VQ62oXuLpkHEPWA7aomSf+J59w0MgD+uUCxidf/ProVNGKeVBxuxBS6aT2FNHrL2BP+v9MajugwHnPNYrK8aY3urpqquwQBTw4lzbElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTfyBTn4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTfyBTn4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso266343276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712863602; x=1713468402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/MgwNwffmIAS0R8bxGeJvh6mxdWCPK8g/Rb9tm+ISo=;
        b=BTfyBTn4+xT4GNw6Un9Vnjx/3EZ+7K8S6ZyJdjK/KqigtyYZB4h2C3f2Arwpf79C6G
         Zc+Jy5zkfv9ThKFGnynTHP4bmWBM8JWZZ/hHv2KgO9LNiRU7qCEkOrFgIuJYyoSu+W5E
         bXhw3o+uOHx7/C57TKe/X9e9O7UE/YXZ1EQ3ytOvJZJtqIAfl80CJ4UynE0KmomdpDx6
         LJcfrDNWXN81AAqOBrcccbJinmGWH6zLqX6ooLa/JIpFWNx0Sb2l3p6e3VuMlnIzrUQy
         VnM1bnGi3jtKAgE4UnMW7gDDqmEhhJxUWwvD5pK3t6+dfUdGH9owtxw4lC/0wo9qwBPm
         bDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712863602; x=1713468402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/MgwNwffmIAS0R8bxGeJvh6mxdWCPK8g/Rb9tm+ISo=;
        b=a63gg1f3eZ0zSedgYSJQH5X/QEISsJYVfreW2XmN24VF51gk/nAhkNO4y1pZlFB1Zf
         X+GO0hsP4YQ8F5D2y02nez78RJj+3B/4eK8uF+x93RWuqrxzLfWkuVj9zkwwTtkzGNm5
         E9Owm8FvLyZeN17QLWIUhTi0z6X3ViIfgeD3ZcnmT+bcd3Ggp8rQ4ZkuLpii22+EAarw
         odx2khjUUb8dxAm6J+d42tQILmcWNin6nT1Jb0wyreq6ZMSGs8VcjSvxMEAMcofi+TCR
         ObfnxwZnHpV3nXwoMPtkNabIWhRWGCrjOhaU5jVSI1mhw6zhmNpFGgu5xfSG2kUXuMoZ
         /R0g==
X-Forwarded-Encrypted: i=1; AJvYcCXjdtKJ9Dq0FvmRxc+uLUD2xdr1aVqUah0okSm+NfExK9lp2PfYj0+ytmjrqWGeU0sCaFavAiGAfTP20wGkr6Y8c/Ap+Hb7UEmLL5XaGFj6Ow==
X-Gm-Message-State: AOJu0YzTZQd3bv+86LoEGJkHJMVTpHNFq+HAVvCkaKx9V7g9kzU7Y6Dy
	sm7WpI2kwDGDpqSIWLoAwoP5utmi9AYoD0/Evn+qfHXixZTkJ/91tIExRdUsN/tv1VwA2rSWgGM
	jTw==
X-Google-Smtp-Source: AGHT+IGmzgf5KeeFYGZBCXwZQqfg4fCxOlevM9CoUirZy2bp2SeSl/953tOx5wakGYYh0uQowopD/M4RiEQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:aac1:0:b0:de1:d50:ad47 with SMTP id
 t59-20020a25aac1000000b00de10d50ad47mr120058ybi.13.1712863602281; Thu, 11 Apr
 2024 12:26:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:26:40 -0700
In-Reply-To: <20240126085444.324918-10-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-10-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhg5cFPL9GgujFKV@google.com>
Subject: Re: [RFC PATCH 09/41] perf: core/x86: Forbid PMI handler when guest
 own PMU
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> +	/*
> +	 * When PMU is pass-through into guest, this handler should be forbidden from
> +	 * running, the reasons are:
> +	 * 1. After perf_guest_switch_to_kvm_pmi_vector() is called, and before cpu
> +	 *    enter into non-root mode, NMI could happen, but x86_pmu_handle_irq()
> +	 *    restore PMU to use NMI vector, which destroy KVM PMI vector setting.
> +	 * 2. When VM is running, host NMI other than PMI causes VM exit, KVM will
> +	 *    call host NMI handler (vmx_vcpu_enter_exit()) first before KVM save
> +	 *    guest PMU context (kvm_pmu_save_pmu_context()), as x86_pmu_handle_irq()
> +	 *    clear global_status MSR which has guest status now, then this destroy
> +	 *    guest PMU status.
> +	 * 3. After VM exit, but before KVM save guest PMU context, host NMI other
> +	 *    than PMI could happen, x86_pmu_handle_irq() clear global_status MSR
> +	 *    which has guest status now, then this destroy guest PMU status.
> +	 */
> +	if (perf_is_in_guest_passthrough())

Maybe a name more along the lines of:

	if (perf_is_guest_context_loaded())

because that makes it more obvious that the NMI _can't_ belong to the host PMU.

For that matter, I would also rename __perf_force_exclude_guest to
perf_guest_context_loaded (or "active" if that's better).  The boolean tracks
the state (guest vs. host context loaded/active), where as forcing perf events
to exclude_guest is an action based on that state.

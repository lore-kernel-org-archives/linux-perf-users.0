Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7F610E
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862465; cv=none; b=tTCMNMD2rGPOQyv9NOMtBlBAdJMpKly8qi8hmOYPHYjZ0fEbEAzXxim3XsA/BghD5fzgi2YM1+AeajEAUQG2r1DnnSZgQ/Vw69BrIpvKlw7hbVt49G31VQ0KnTLeQpduy1eGJ1KlpxrfsK7EcjYwbdF8ATF7xApSSWP1kSUSeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862465; c=relaxed/simple;
	bh=K+2mLJIg465ypUQJI5giyc0VIu85pZleLQxiFXuwW4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZjsVP46GLdF7khUu1kmsHhYYkHVOWga0KWfmxJgOLA9Dd4k7Pd9LPxyIhNdUlzde+wCWitThz9a6YzyfcEyzunkpTIauqm5sJUoXDb0jYGRDWazCREX3yRAHznEsU7WGl2BkdgyGCDy7Z5E/l6djaMSyXyEoIjRazDCJHy+SQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0kynmDk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0kynmDk"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6156cef8098so1749907b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712862462; x=1713467262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcJF+KC6MHAw0xXKqx6sflzbfRynihMrB3htgV72+eA=;
        b=f0kynmDkNZPv77oCffRn+KoJ3tdkglIylhkS65IiPp7z2BFEx/rE7+OWoeL6f/SwLy
         r6F5Bel9eLCxP/0EX5S4KJExzuH6LEsfCuGcckKZpC0YnaidqzO3kV4zdzz9Pny5CvqL
         BLTbC+nQaNAWBOLsqAzZD7q7agMKrv0peXCtC10BrdJstg8+me2ObLsvBJsyQChUSxjI
         +9OvKdG4NNoLTmYH3D74Y/GiCCcdhlaCXKOQqI80azuclLd/G6rhbRvwa4UFkpItjjBQ
         /lOfujifD5xEic3PMQO/Nu3O9oJXVzOMBNR4pooqy6ao+/auEQ6yqLfNDAAClrrXAXTX
         d56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862462; x=1713467262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcJF+KC6MHAw0xXKqx6sflzbfRynihMrB3htgV72+eA=;
        b=Kagth8PdsYGS9wP1NHw5xftmkS7PuzCRLw3yyPcl4mp3SfaYBDZvSSLvWLexwL8sqg
         I7N0IX65t2MfMGxnrtkrK0HgswQ2BhYG6dGGqA9iXF7rp1OPkH6BOC58dLtCb6UKpfkN
         G8+aYbOfGGlSebbKI4hNoHNXhScyREJzdq6pDCyzGcWPZxAmniBCwh34NH5EmpidCz/3
         ko3yrYoHFVltaR3t1+mwq0qRR8XoIrIhflhFK9UOxjazRL3h0BmR1Iy+06BzMawpqDr3
         w91JIKABnmsN5Ewv0sLMlXiTYclijJmQBG8fcYMQbzE25469YMLAP6AepQP3N/b2wK2e
         0HRA==
X-Forwarded-Encrypted: i=1; AJvYcCUDv/O2HmW7KOqg8cVmDuoKLruKqF5M00oSp55Nhdcv+2V5ZtUQlQ6IzXjANe7JR7IGJEW6dYSj6j37/ZYbxsHUyaCkshP2DcUESWPUlTuipA==
X-Gm-Message-State: AOJu0YzMVm5jfwWEqoI1d3M8t81tty46DKlPQPujyIyhgwYLu0oHvfh2
	4hFBJ+3bxEf79LYdLPSLdZSB2JKs2zLyTvcdqznAyXbjqsFmoNbhy27e39axcmJMK4EePw6x160
	MMA==
X-Google-Smtp-Source: AGHT+IHtU0YJeUQQHL8WAHyzgFdSIwlw2ajKFvDhlBylMFmOQHLdub7ugcHbYGeGD3LFpO+LpN625tYE5/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:188f:b0:ddd:7581:1825 with SMTP id
 cj15-20020a056902188f00b00ddd75811825mr121974ybb.8.1712862462048; Thu, 11 Apr
 2024 12:07:42 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:07:40 -0700
In-Reply-To: <20240126085444.324918-6-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-6-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhg0_B4ktNzQbWZZ@google.com>
Subject: Re: [RFC PATCH 05/41] KVM: x86/pmu: Register PMI handler for
 passthrough PMU
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
> Add function to register/unregister PMI handler at KVM module
> initialization and destroy time. This allows the host PMU with passthough
> capability enabled switch PMI handler at PMU context switch time.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/x86.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2c924075f6f1..4432e736129f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10611,6 +10611,18 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(__kvm_request_immediate_exit);
>  
> +void kvm_passthrough_pmu_handler(void)

s/pmu/pmi, and this needs a verb.  Maybe kvm_handle_guest_pmi()?  Definitely
open to other names.

> +{
> +	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> +
> +	if (!vcpu) {
> +		pr_warn_once("%s: no running vcpu found!\n", __func__);

Unless I misunderstand the code, this can/should be a full WARN_ON_ONCE.  If a
PMI skids all the way past vcpu_put(), we've got big problems.
 
> +		return;
> +	}
> +
> +	kvm_make_request(KVM_REQ_PMI, vcpu);
> +}
> +
>  /*
>   * Called within kvm->srcu read side.
>   * Returns 1 to let vcpu_run() continue the guest execution loop without
> @@ -13815,6 +13827,7 @@ static int __init kvm_x86_init(void)
>  {
>  	kvm_mmu_x86_module_init();
>  	mitigate_smt_rsb &= boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible();
> +	kvm_set_vpmu_handler(kvm_passthrough_pmu_handler);

Hmm, a few patches late, but the "kvm" scope is weird.  This calls a core x86
function, not a KVM function.

And to reduce exports and copy+paste, what about something like this?

void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void))
{
	if (!handler)
		handler = dummy_handler;

	if (vector == POSTED_INTR_WAKEUP_VECTOR)
		kvm_posted_intr_wakeup_handler = handler;
	else if (vector == KVM_GUEST_PMI_VECTOR)
		kvm_guest_pmi_handler = handler;
	else
		WARN_ON_ONCE(1);

	if (handler == dummy_handler)
		synchronize_rcu();
}
EXPORT_SYMBOL_GPL(x86_set_kvm_irq_handler);

Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB094142E74
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973487; cv=none; b=IbKO5rdd7yW+wa9HKsmUBS7LWfgKG0/rOKigH88VMMR30MEbHJRfRBbaw12Hs38EppiGI4keSKqwdHsJlb3bGJbaeHynkBK0YsSdQWTKyzLbOwinV4rwjjw+dQfjrp7J4nd06ACzu9BlEociCHFbiKrbpjBnWAdmPUaPXqy2h48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973487; c=relaxed/simple;
	bh=n5Th5FCxd/04ThzgN8Y/MPQyLr52bWN+77a9kDbda0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kFZgVBr/RYCSNKhHnIPWXIHsTzYgZK5GuvnvEQ506HKbo7Cd4hH4Y8hvmjFbYqlFOPoWz4pwIxSanEZYGe7eRwrXQ9fjcPkRgEJFFXV2u7/O+RUPtNCyV6zJVi6YCQRcExDWq0jgMyGilSFhkaM7+2YwkyzLWDzcvaY+WmqPx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cobkYYgc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cobkYYgc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b3f16d858bso2180690a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973486; x=1715578286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w1yUm6XA3zeZ1+N3WlOUCwdlG3aJfass2zXQ1z5EDuE=;
        b=cobkYYgcJhRBOArPTKRjRv4OU6Rhk6epESaZJOr8M9XPTGUDmWMIR+MAn6R7EvbTqF
         pBYeEUYmigVYtrG02x2d6qUt3I5ecnXvpZgJWwAswGkxv/CPj86NbYwN445gm22diK6Y
         5Eaqsag1pRG4ok1a15zl0P08mFJ+uN4SWxvvUcdifMQ7MjaE8jRiKdvlCt4bOGs9c5oN
         /RL7PKNDU+hi8qj3CZkjPYkBEHA+EbD6gBO1EnJRcpVdmcNeDV8WtC4fVUDfOCrTlfi7
         16RRbrPnToEBu2Wj2wBuPLYNhd2Ls0JX5MUNrkUZ/NKFd2ni6cDt/gm6Hsf9VuAYcYbe
         nbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973486; x=1715578286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1yUm6XA3zeZ1+N3WlOUCwdlG3aJfass2zXQ1z5EDuE=;
        b=HH7lRaf6uQi7gCjevLZ+HH/1otmjdBmSI0bsi6BPaK/Ok3ZAr36z2X/PCoCTf+5FUh
         qlQu/gITqfLDN6JAhznCHuvMqv1dGwtpuszjLJje75bEzTiW3J749KEAzqKNTjntV7GL
         hIplXjimU5l/HCi54JlO9Asr97Oo4E1VsDnlOukvzhOjDwScr275f9QvjZLApgCsQ6VX
         hJ+mCoSemGEo+AB7sD/pUAEMcaKiV45Tj8u+KOS5phClQkXwIv5vegUY8fpXnrJi5iKL
         bX9NvgJni2A/kLPZfeTXyF7Aby98kltJTJhNR8UwKkewV65b9l9QZxnImojaKMD7rFQS
         bQbA==
X-Forwarded-Encrypted: i=1; AJvYcCWZKwPwww5TNwjvR1WiLZGFXMMzrIjCv6F1vABuaXOCP4eo9swN2e2kIc7DXOwUivu80drAvGP1w4CeNmuseJ0XvYaV6uoWxIbOBoiV7t2omg==
X-Gm-Message-State: AOJu0Yxj0w6qFm9EJYQv4A2pbWQ1uAj7yvmWgyAWl7vrN7zIU0dUjuuV
	8Qj+1R/uD//SmRHoeqmso98onmrU+H/1Gdb18PoCux2gpQu6xLHM5RMtnAn0rjCiVOGeGR5UVJB
	5W2CZWg==
X-Google-Smtp-Source: AGHT+IGcaWWhZDc+bgXyO+oGuBfAxps/UvT+dJNdwJsZJQ/yS52DVP88zOnc4v7Eu6lE5eNfqK5RaTctivz3
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:ce8d:b0:2af:f522:4ce9 with SMTP id
 g13-20020a17090ace8d00b002aff5224ce9mr29423pju.7.1714973485416; Sun, 05 May
 2024 22:31:25 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:56 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-32-mizhang@google.com>
Subject: [PATCH v2 31/54] KVM: x86/pmu: Make check_pmu_event_filter() an
 exported function
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make check_pmu_event_filter() exported to usable by vendor modules like
kvm_intel. This is because passthrough PMU intercept the guest writes to
event selectors and directly do the event filter checking inside the vendor
specific set_msr() instead of deferring to the KVM_REQ_PMU handler.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/pmu.c | 3 ++-
 arch/x86/kvm/pmu.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 13197472e31d..0f587651a49e 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -443,7 +443,7 @@ static bool is_fixed_event_allowed(struct kvm_x86_pmu_event_filter *filter,
 	return true;
 }
 
-static bool check_pmu_event_filter(struct kvm_pmc *pmc)
+bool check_pmu_event_filter(struct kvm_pmc *pmc)
 {
 	struct kvm_x86_pmu_event_filter *filter;
 	struct kvm *kvm = pmc->vcpu->kvm;
@@ -457,6 +457,7 @@ static bool check_pmu_event_filter(struct kvm_pmc *pmc)
 
 	return is_fixed_event_allowed(filter, pmc->idx);
 }
+EXPORT_SYMBOL_GPL(check_pmu_event_filter);
 
 static bool pmc_event_is_allowed(struct kvm_pmc *pmc)
 {
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 8bd4b79e363f..9cde62f3988e 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -298,6 +298,7 @@ bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu);
 void kvm_pmu_passthrough_pmu_msrs(struct kvm_vcpu *vcpu);
 void kvm_pmu_save_pmu_context(struct kvm_vcpu *vcpu);
 void kvm_pmu_restore_pmu_context(struct kvm_vcpu *vcpu);
+bool check_pmu_event_filter(struct kvm_pmc *pmc);
 
 bool is_vmware_backdoor_pmc(u32 pmc_idx);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


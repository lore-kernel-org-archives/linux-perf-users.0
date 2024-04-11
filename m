Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F68182B3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869046; cv=none; b=LjzsdWCyRHkrULhKhjMdVwgVgjh82o0y45etF408tMWOLwtHflymPTJkrfOaUBs7bb13wHbkGXNjp9ObOau5FP6pQz49+t4+/s107cUkszDFvrmM5YAAypXzFV7HVQd2bsw5L2lBwv7qe+P7Tc0xP9FTAjuDB8LcJgmQJtgPrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869046; c=relaxed/simple;
	bh=3USpWrUNdliUnscE24vOtr4QdAGj6lskCeojhOFYzPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Grym6zZhJMAR/nDpfKLIrp930XBzah0bNFsWR1gz6EeViFKPfCpfp0FC0AAsh/hfGD9RibUDeYlXSqb6Xdveay9sCXyp6tnAwFBOmKmvAkL7Ssq/1FG5nSLQv2WRyFQV+RPk7yAz2g8wgt73ATXZx+DMMUvjj692+LGRz29eWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgAo3Z5Z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgAo3Z5Z"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ceade361so453307276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712869044; x=1713473844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYEU2A1US/h58udhZtj8GUv/NlwFdWP5dUC/V5yhCYE=;
        b=bgAo3Z5Z8YlxchApJSWwvLNxUIct4f5jUXsEVbv5eeRhP0AewFemHgKqtBB6/dOYP0
         vjTPUIUlVcut7bUddcYVRUIbwpI/dW5clQ7eYbHZSZSjxlxkObzDnglp3LjwkyGT4hNZ
         PXo9HUdOD02hvu/8lnJ6dYoliJzWi0edm67Ho6ItR/LSSUcuCtf06dwmNWsuBt/cIJM8
         jwjxsHdIPCzF/j8NTKEeZJgbH+x1ku848sob740eY2iiy938RBIB0pkhT8YK8P7K9ygZ
         5UCElEc560pFkIjkzDKdN/GCSMbly2t9Av+KVUz/qdSUTOK7mNuQoU5dW/cN0KxvVx0L
         2IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869044; x=1713473844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYEU2A1US/h58udhZtj8GUv/NlwFdWP5dUC/V5yhCYE=;
        b=CKJ6lDS9TMmRaR6Z6mR02wKKqUlFofsml2N3Ol2TvNEb5Usd1kLzl+S3H0kWLtO2mD
         MpyN425KUFwCJE0fNOUnPWDiUoncJt4HI4qq8m2kQ2RMIVY3w/1u2nAcco9j9A7ej1aH
         ImOQJdA4YbNYGbjxgMKIHvmNdaddrSClH8dOGYc5qKv1C573BPExkgcLromdTSUPEdJk
         NlP86eexeJJ1a6Xyuup3sroeZV5XozelAyK4G3/0iz/i71jYljVxWi/eiADTGdCFwmrj
         LfmJ/YoIHkCXxxCikMt6nMdoGAE4/xuoOsIgUYo/E/NUmGTYagDyKtmxLnsSblKGrfFs
         KpfA==
X-Forwarded-Encrypted: i=1; AJvYcCUlJQIfA6UPcRf+kzWWyIeVQvAg6GPu33ezRPGDXNYORWjGnQGm8VboxXoXR1toUjzsVhFCHWcjvZviE/E0iRrWoob4maj7lF5KpUYnOu72KQ==
X-Gm-Message-State: AOJu0YyIoPz+mMKEENKEAuaO0ptJz+41Hu6FP/eStesC6TysWIEO7FTU
	WbSvO/PKJcuXuksk1sMd84rA3CWqAPXW9ldGpTBpaoHodMUkYI4xbd3CsZOZcSLrfxxewLduR94
	vmA==
X-Google-Smtp-Source: AGHT+IH0B7KlVbl2bxNL8+iczB8+rRyeR8gTDQmgFF/XhbcdNrmoi+RlgGKOLAAFLeDcsQfs3Ca5mIGAi50=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100b:b0:dcc:f01f:65e1 with SMTP id
 w11-20020a056902100b00b00dccf01f65e1mr183523ybt.8.1712869044460; Thu, 11 Apr
 2024 13:57:24 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:57:22 -0700
In-Reply-To: <20240126085444.324918-13-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-13-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhOsvPxhEQl9YmX@google.com>
Subject: Re: [RFC PATCH 12/41] KVM: x86/pmu: Plumb through passthrough PMU to
 vcpu for Intel CPUs
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
> From: Mingwei Zhang <mizhang@google.com>
> 
> Plumb through passthrough PMU setting from kvm->arch into kvm_pmu on each
> vcpu created. Note that enabling PMU is decided by VMM when it sets the
> CPUID bits exposed to guest VM. So plumb through the enabling for each pmu
> in intel_pmu_refresh().

As stated in the previous patch, even the most naive implementation can be:

static inline bool is_passthrough_pmu_enabled(struct kvm_vcpu *vcpu)
{
	return enable_passthrough_pmu && vcpu_to_pmu(vcpu)->version;
}

Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948931F4163
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335978; cv=none; b=AUaNQ+lPlyIk9GsMrD3Jl6hjhkoluSpNXSgsth83vmBbzQsZBuJKvs6NcFQi18/2J6UMX1gfv0StOoT+atOLufD6whUb6cJ3LmVTFEburGQlv4taSFLsuJMcB22bX7pxusc3rP03MJWmUjKxSPGP657ZbX54U457NV+BY5Iu7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335978; c=relaxed/simple;
	bh=CnL0sloZkje+Gy9jckN96zccVLpEiTSNRW+B4JDbs5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=av+7+4P6WN297TcsL4aQ2GcXWfsfNF2LWuVDG7BAPzwk/n/WyqqXLe2JI2Dw/znYFC0zElLb3aR7hnb/KaGxHiwa41dCtDvvIux0ml1RC2sKR6F9KxbVoEhltlMjd5YPBEj5McawjJ3A4VCxndvH9HlhFI/EEY7fYaJzyfvkMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8gD5bD3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8gD5bD3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ad109bc89so1490447a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747335976; x=1747940776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLPqD/um8R1X6WXUHjnXwyW6WNUpCfKj1WPzSpe7c+Y=;
        b=u8gD5bD3RAgyHbZ1P3Jn/KcnmSX3vkdx+bnKAQwKXR28uwazNcms5KIhHp5s9oNOw4
         HS6XvFMJfbcsyXanK3tiLlvZ/1uEAACC7bR0+BPvMAf7FE6038rVmPkTD/S68SfLUa7x
         VbKtnUX+hiqIO6Kj+/KfEBhfU0c9gcXXqwYsjNqDwBNLpEVEbPW04ANS62azcBDPJoli
         /InLMeGWY/WTQdm5rGjp6QIzk8Ndex8bZtY7BmYZbZ84ssxOVkn+RoxVXhklVc2owJV7
         +z1UBYskUDlpQMEKor9LqERun0P2RdvYvBLUJcd6yB8QsQUi/F902L12tBv0b7mjoOE5
         n4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335976; x=1747940776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLPqD/um8R1X6WXUHjnXwyW6WNUpCfKj1WPzSpe7c+Y=;
        b=pTyuJSyGT4iOJGPSyNZN7x/D/87WCfCzigQJgx/wf4d6g4GpKlqIpWW79k0AsT3yaL
         o24bdKesb3/RfeDdvAIeVxTBts64zEwwcszifpFqu4FSsDnqLQ+rZqoXN1XOweRRdnXd
         yK2PJ/4fLVoTq+HeFP+qf//YyWRFrC1lu0vZ3CMIZLDYwoKhAEstnOPm8dLwAWhNa+2R
         gS++7seUG+ANGk6UAKwZL8P/FFgiP9vzWc6hQDTAG+VdSvmxViJ5Vf4MBABssFMbqk1o
         /5onhqx9FC/cyAonj2ekzH7lsb4gSUUaX4ZEsjzYV+DfIRgDpwOSepAt16P26bKfrUyG
         mO0w==
X-Forwarded-Encrypted: i=1; AJvYcCWar7zAzebd4uNOkPWHS+whyMVzWixJK/zHBYRLqAcrlbZUwX9Q3ayco/lfhDtfDkJMuRJQ0GXz9by2HLIfurjZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywepm1oT4tTPZbXOzBs/ol1FlYY6trjBxeHhI5t6AhRzKBJHbO+
	DZ40nU/fByGI5RobCHS1MUPEy8ikY2sUzh28fbL45kSGdXf6QqXji4JHohAtBL1gN9reJ69i64Y
	RIRBK9w==
X-Google-Smtp-Source: AGHT+IENNFvaXlYo+BqzOoVnfUajKC5r6pRv5u9QDBMqQirkEdvSRp0jQC+k8xHSU7HIox0eXH/Z7cf4jZY=
X-Received: from pjn12.prod.google.com ([2002:a17:90b:570c:b0:2ef:8055:93d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dd1:b0:301:c5cb:7b13
 with SMTP id 98e67ed59e1d1-30e7d501e03mr664683a91.3.1747335975881; Thu, 15
 May 2025 12:06:15 -0700 (PDT)
Date: Thu, 15 May 2025 12:06:14 -0700
In-Reply-To: <bac13842-9d15-4664-a20d-4916abcdc3e7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-24-mizhang@google.com>
 <aCU4Uuhzo_ovR7r8@google.com> <bac13842-9d15-4664-a20d-4916abcdc3e7@linux.intel.com>
Message-ID: <aCY7JkJA25D2HfXF@google.com>
Subject: Re: [PATCH v4 23/38] KVM: x86/pmu: Configure the interception of PMU MSRs
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 15, 2025, Dapeng Mi wrote:
> On 5/15/2025 8:41 AM, Sean Christopherson wrote:
> >> +	if (kvm_mediated_pmu_enabled(vcpu) && kvm_pmu_has_perf_global_ctrl(pmu) &&
> > Just require the guest to have PERF_GLOBAL_CTRL, I don't see any reason to support
> > v1 PMUs.  It adds complexity and weirdness, and I can't imagine there's a use case.

I take that back, there absolutely are use cases, especially for AMD.  Any VM
shape that exists today should be compatible with the mediated PMU.  And I was
dead wrong about adding complexity; KVM already needs to intercept GLOBAL_CTRL
if the guest has fewer PMCs than hardware, so incorporating this check is all of
two lines of code.

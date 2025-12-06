Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53C25C821
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980269; cv=none; b=T96qfPQVCf1qvVcr58cIVdUwB2V7ze06KQzQ1ZxT50jJgd14EP4JSD6WZWO9IU4pctSi1TEfTr02AFHSKZLhx6JWCIap1kZhEtzj0qicg2PMryBrxy/ebtLMU+3O96LGV13mYXhLfbT11Ysf9p4qb6mo56OHT3AdF9MyLFcCW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980269; c=relaxed/simple;
	bh=gw4FQTHE8SLlwJArBri42euAjtNSeNQ1byjalYji5b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CWCvGS6fOQHp033p9vZfqQ1+yOEmk3MRgJ1Tb0UJtXGIAFhOnScyQuoXPBC4rMRPMHQuBuQOv9T4vFgqcoUjjd2sA3t7E0zVcvDV6hLeJPsCZG0mGCgJx4OPgTNf8et9RG1qNrsrbTbORO1ToYbUfckzGltogdqrIFor8pQxUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qReMFqf8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qReMFqf8"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34566e62f16so3089758a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980266; x=1765585066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CUuCYzCJ+7mOkcgENgUcVnWD5HNM+Ecxc29Wc5gu0a8=;
        b=qReMFqf83LKwpbNApAv433CETZlXKi85nOvIXeqkLijljWe8SrlpKQMFuMS1K3eMHA
         uNE9OqI2jDoLxzkjvHJml8htJx4gz/O9hcVherDcQ+8yPpmIsJKmdg5EoMPtIQGjP/KG
         kLpXtVYDOvmbQBD1udIXAAwI1ShLBq4DIkhFqyTCOakJJeJwSMyhEEKOKN3YkB8ZOI0d
         ziTBj0XV+LrC6suGn09PLuYjPdqYLLZTEedKbImmIBsyLzP6qyE+kcW0p1+IOhzeo7EQ
         +UVsYVMGlVOsWl/Z7KsbvCiLl0+dWVMXaaNWXP1SHRKIDWW8OZZbXxV4qsz8jpVFTBHs
         le5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980266; x=1765585066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUuCYzCJ+7mOkcgENgUcVnWD5HNM+Ecxc29Wc5gu0a8=;
        b=gqvc10Tn9ZHLn9TPak/IkJt0OlSknhdPjK4u5nkCLR+reXQkIBPD4n0z7lDa+Rcksr
         Rjkng8kgOUiYybQlU1wcFZLwYe6VvDR3i9XBAct1Pq+Cz/9yy8ZeTgX4MivThEuMOWgS
         Jkogm5eMLbB9bNy43y6GH1AattWxLlzdGdnBrk+1rgN5QQC5q02b1DDT8Ms2sAQM6IDG
         OBey/UAEjMjHObS+699o+hCy7H71Tob3p+dIudf7HwvVhVZTe976Cm6RjBtCUCSui99H
         sixEsq2OSS59xVzxf/1tPPAkSrIR8hUuLxDp8GC6CHAmS7Sg5rj0KrqW5FMsngxL6Ibg
         LZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVL6N9L8/pgb7JXXH7SnygdWpRDAQDGnvvAeoZHekyf9vPxHzuxPxJHW5kri9BbJvNsqrxP0G9l+DOI3N//9vF@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFz/pvs9uwRUtNTihQV9VIZWxv5WC/H4CjwGbU3muQQ1mSl2s
	wxdEFUnwFo5h+g8ZFz4BVuoVZ/1d4T6bqCkar9kXYKvgUNdDZEJBffhfsi49H+8tySNEOFeDOYP
	Cdcg5tg==
X-Google-Smtp-Source: AGHT+IEudAc+RtrsthgQd29i5TzWwClBzh0orawUsXJ6SsndAr08K8DVgHn3KuIiiMIFAwisOcz2YNtd49Q=
X-Received: from pjqx1.prod.google.com ([2002:a17:90a:b001:b0:33b:5907:81cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d92:b0:340:b572:3b7d
 with SMTP id 98e67ed59e1d1-349a25fb840mr628818a91.19.1764980265902; Fri, 05
 Dec 2025 16:17:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:46 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-11-seanjc@google.com>
Subject: [PATCH v6 10/44] perf/x86/core: Do not set bit width for unavailable counters
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Xudong Hao <xudong.hao@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

Not all x86 processors have fixed counters. It may also be the case that
a processor has only fixed counters and no general-purpose counters. Set
the bit widths corresponding to each counter type only if such counters
are available.

Fixes: b3d9468a8bd2 ("perf, x86: Expose perf capability to other modules")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index abe6a129a87f..bd9abe298469 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3132,8 +3132,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->version		= x86_pmu.version;
 	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	= x86_pmu.cntval_bits;
-	cap->bit_width_fixed	= x86_pmu.cntval_bits;
+	cap->bit_width_gp	= cap->num_counters_gp ? x86_pmu.cntval_bits : 0;
+	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
-- 
2.52.0.223.gf5cc29aaa4-goog


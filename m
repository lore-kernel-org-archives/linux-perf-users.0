Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574712750ED
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980275; cv=none; b=VespITLSsiCdgh5OiRTKv0FOw/KJBuz1BW0TSWKi6tFlHDvi5/pLoq84KDsvFLRGaAUYtf8tv/LC5Pm8wrMgofTuJiBQgD5JTiyyb3a0IsbJDBy2DSd1/sUehE6t3Ra2sNrk9dmP56zkdlpK+JHkoJndNmad5/bs7GZVNVPXASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980275; c=relaxed/simple;
	bh=kd7T73ar6I8NiXQe7LuWrPEA21EYkgr8AnFeISoZufY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uicNBlr7bqtVi0ABR/kSXPilF16kIO6xOJDJL25iRzyR6baHyqjnqbSJOmjeI8wV4bz7YY0Z1nMesvGBtfjpsRdBLbQNNgxcUkVyHEEf8TQNA7HIbipnwK7d8HAaFW8r6r1gCMOgAhDfvvzP9fk2QrsTd6cGLptCWM8mthF6HVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WSJjoP7u; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WSJjoP7u"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bd74e95f05aso2132772a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980273; x=1765585073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvhz9N1L4N+mDurmwM1rhQiV/PP6RHnJJPdqNYMoi5g=;
        b=WSJjoP7uPjzY1dDmTWmM4fjP5WnVRsuKjpeV31BcAHZIi+0+MreLMOF0wGBuNasFoE
         SR6MdHuzURqebl1OG5cSW+QHIcyBoirhIpOpd48RNmMt8p47YnEZ1m0jUVDfoTg/troL
         dp4F/3GXOCrgjRvrpo+w1/hCj/d4HLhGrzmMKcfHptjwFPAgeCpfMtOZIqMsf/2ylxaJ
         lnOeXigZeTswFnCJj3t9lQh+XdLv9XFgJl9tRzEWIq05KaPBB/lsXHzgMNKWhqp0TfZl
         IKv7DqcXi+4eOx7Mxyg07udsq1mU6MKXmcXPImTFxQLGPdkNjtJihWAtZRik6CznVRl9
         8xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980273; x=1765585073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xvhz9N1L4N+mDurmwM1rhQiV/PP6RHnJJPdqNYMoi5g=;
        b=ZYfshk/Ein2WN2+qFo4bCnAg+O+xHByk+2BSxxbVvnG1TpHMTMU4m8S+MEJUSt3rsE
         i6JQm4Pd46N0JRW/c7FY8/YLA4k3iio6BOkyueuY7kIJ3NBYKy5V2hLZ8dmA6wezkjWc
         6hIeRFCxVuFTLlaPJkAwsPiAt+luFG+4W0Q63DA0xyTCgHhHn16pv6r4DlirYIeXoshp
         95mgHUQI/+ZU/fD6ZcfXamSkGMMwE5XgJjM0k/S1f8aTJ4gxjuirumz+D0CNVhYjwpSp
         3/s3ZJn9600DC3wAZKDhbXrRBlbK3gGKaf9FEyOYGiRBwSnvQqWX74yF2+pJpSBOHb/m
         OfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7fGQoB1Vf/DyvJ3ZEVmZfi+SilF2EQgBE2ru5ZxM7iRTCIu5Dvkm6swGIhQw16IcDKzkY5mM5/oRZnqxAs7Nx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MARpSv+2g/MaPmNdETb57qP8fqW6zcAPuWkPkwpvsmU+hvKH
	ocm+frg2IWhEXx9JXeRULjwiHYOnzrGqbPWQxMZ2Ym30vkd4hvkeRwKIQ+PBPVpQ0AVtiVuR7TS
	IgX4kbA==
X-Google-Smtp-Source: AGHT+IFWUJIU/8E8cWwKD1KvVXfXTPgHtbYSY08/FWGA961BLSrK8ZlXaCtvUM6dR/7cetdvhZaXTRiVhyQ=
X-Received: from pfdc17.prod.google.com ([2002:aa7:8c11:0:b0:7dd:1a70:fbc1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5605:b0:366:14b0:4b19
 with SMTP id adf61e73a8af0-366180292f3mr728551637.36.1764980272562; Fri, 05
 Dec 2025 16:17:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:16:49 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-14-seanjc@google.com>
Subject: [PATCH v6 13/44] perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for
 AMD host
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

Apply the PERF_PMU_CAP_MEDIATED_VPMU flag for version 2 and later
implementations of the core PMU. Aside from having Global Control and
Status registers, virtualizing the PMU using the mediated model requires
an interface to set or clear the overflow bits in the Global Status MSRs
while restoring or saving the PMU context of a vCPU.

PerfMonV2-capable hardware has additional MSRs for this purpose, namely
PerfCntrGlobalStatusSet and PerfCntrGlobalStatusClr, thereby making it
suitable for use with mediated vPMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/amd/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b20661b8621d..8179fb5f1ee3 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1433,6 +1433,8 @@ static int __init amd_core_pmu_init(void)
 
 		amd_pmu_global_cntr_mask = x86_pmu.cntr_mask64;
 
+		x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
+
 		/* Update PMC handling functions */
 		x86_pmu.enable_all = amd_pmu_v2_enable_all;
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
-- 
2.52.0.223.gf5cc29aaa4-goog


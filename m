Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4096144309
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973516; cv=none; b=gLX1gQMP3m5gn1kGmQ0fcM7uVv8NtihdN/K8UtJNcoAi85XOaYPUr93ZARJ/lOQ/yfwwLTFq3KzfNYjeWs1u/h+U55nBM1SB5xi97VKyh0OGDs2iWxhRry30xJWpyQRqztl3ch05tzok+QoDJ+As1C30/kOaC11UcaY5v7WwGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973516; c=relaxed/simple;
	bh=hYHJs9v3pADKP6kDRWPxKlGprXJTLz69FbXvygErydg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQmlPfdyk96a8YgtNZZ0jvoEAjtGidlk088jn++juGPv7E/paBAni3f1ICpwTSCdmaGLFm4xCSc2Zri2muBDWiJC6lLTfdcnn54/VVzSwLLP4CiPY7LDg43jZJioHMuyn50YN+Nx8AjNGBdo9ehf5Bk8qdtlw9DUIxl3D2j4Avc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t810ES2/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t810ES2/"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de8b6847956so5603097276.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973514; x=1715578314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=R3btYVSbOUUUG6wvVgZKK1IzrRe1w7aTXikAYvX9oRU=;
        b=t810ES2/PbGQwjSdzDCPo63xfYQC1nTzbnPyT9T7AKeLmncETNvUgfPwk3lk/GHeCq
         W6P8C+u2HiapPlQyxHnwnNxAOjtiLRsLNS5Ghnnv6MPHZXOaZb406Hf/7l8672PbJ30H
         gktSbBExPsTyCWkbkxAWnOgsnnO3pZ+dxzVmvypaB4MHLuiThwXG8k91Ag4Btre97ONo
         GUMYOzdhFP59GUWa1GiDsG8JXrU5aRUo44g5rlOTyZDBhdHjrL6bIaAke//wptRdfS/o
         QvpDKWf9++ZUrwlMQ0BMa5xL7DlWUxM7Zplw9uT0sDAcxNfopTI7HpoW6ivaKmbxStx0
         grNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973514; x=1715578314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3btYVSbOUUUG6wvVgZKK1IzrRe1w7aTXikAYvX9oRU=;
        b=j2/FUzxvTr/hLU6S3M7vQNyY0xDkDjyk9yb0Tc52OMFJKInaowwHg3IiZ66IX4fhmd
         Mfk4w6Y2WQ7wQRa1WNOCHsseKhn+6oTiMGOq9x1C/XJZu2k/GVZfv7qfXOlHSfYKcs7U
         F46s++/wSWyx9a5E7zSsN2RfBwSQS20DiBErrj9qcAC99evQRL2QWEW3SGlXjLPmRAZv
         GI9dhZGo5OnQedQAt/G6DrymLB0HzGLIKdO3RxP6uTSk3p/+xuUFqtARthsMZgfUeoVN
         5lS77qwFMhhxusfO1TxOcmQ/Siqj/Q+Jz1Y+x5sipcN3/ytyOgrfjiXwYeJ7oarkrMga
         ELqA==
X-Forwarded-Encrypted: i=1; AJvYcCUlklBblGt0EtAm63XYP5n/g490NZjmA13WXgWX1HmJbL9AftOO3U892gYehFxkkQ2WvBPsaiQIHxLACLRM2TxVQpbP+eUP84CCPLNRBbWOtQ==
X-Gm-Message-State: AOJu0YxYA/K1dMEmMvwKJMDEG4pUezBgTq8vt436F2K5AKgF5HD/ZDEb
	tYwGFhp/R9WRQhwDwsAqn+28fz2ygmibierxAu10tnA7tuDEdX83DMMq01NopkFxIVudHZ8V+sx
	fgzLl6Q==
X-Google-Smtp-Source: AGHT+IHYtAKETaSkJtaWjBbjSZv1PW0dYkKkjX2kkHnO+ZOXalrSCVSrUqbKXqRrINppkxEB/rczGUaFb3SL
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6902:1505:b0:de5:9ecc:46b6 with SMTP id
 q5-20020a056902150500b00de59ecc46b6mr3476037ybu.6.1714973514144; Sun, 05 May
 2024 22:31:54 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:11 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-47-mizhang@google.com>
Subject: [PATCH v2 46/54] perf/x86/amd/core: Set passthrough capability for host
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

From: Sandipan Das <sandipan.das@amd.com>

Apply the PERF_PMU_CAP_PASSTHROUGH_VPMU flag for version 2 and later
implementations of the core PMU. Aside from having Global Control and
Status registers, virtualizing the PMU using the passthrough model
requires an interface to set or clear the overflow bits in the Global
Status MSRs while restoring or saving the PMU context of a vCPU.

PerfMonV2-capable hardware has additional MSRs for this purpose namely,
PerfCntrGlobalStatusSet and PerfCntrGlobalStatusClr, thereby making it
suitable for use with passthrough PMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 985ef3b47919..7a91c991779c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1395,6 +1395,9 @@ static int __init amd_core_pmu_init(void)
 
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
 
+		x86_pmu.flags |= PMU_FL_PASSTHROUGH;
+		x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_PASSTHROUGH_VPMU;
+
 		/* Update PMC handling functions */
 		x86_pmu.enable_all = amd_pmu_v2_enable_all;
 		x86_pmu.disable_all = amd_pmu_v2_disable_all;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


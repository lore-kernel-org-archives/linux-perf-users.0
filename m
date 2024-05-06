Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36CA1420DB
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973462; cv=none; b=XXkijV8y1i3X5m/AkG3Xs189y0Quc7er1XCR29YbcwjPHuLT6Py1OimMwdfymmyol4c0KQOA5tHVRbp4oINdtxzdjB7ZFHi7DuyQdSFwyR2n52WW7aPwy0P9W+xXpyAupbeYTde9lfA6i1VxnKyQ1HvppIzScpgZ/XeFqHq9/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973462; c=relaxed/simple;
	bh=minTSL9XqHEpIVjTC2PQRW4L97izhLeLHuOSnX5dCBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CfiVrWi+b65MncDo6Epuo3E6PuWQZUTIs0UwFcEVEPeKxMW1UZQzlBDLkQqiyjGaRm3u3Gpab4gSMxJ+LZEwlFYuBAM/CTojK8WgSsS/EoeOP720+OSP5F2GhsUCQRuvitn+n0HKVoJYkvFN8jzuluDeafVGowM8ViY6bLa6+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3p51e7h+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3p51e7h+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b38f3e2919so2813459a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973460; x=1715578260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DMSkODsG7t5yWnGmB0n44Dj2lacu17Mhk7BwCmJOvKA=;
        b=3p51e7h+7u0iwTSqmag5XM7suGf9AXLz8l46lXbDUXLhgItyszyr75q1B9upGgc+e/
         EGcHJyZrEHUmApi+gFFv88rpkZWu82vwEDqgbhu83vIUyUrMmtr/xzOBsGtIWXziqram
         Ljx5MXNCh3G4daGkdWaFs2t0Ey8uN1VHeAPwWRbgPmEU0KLle55q4TTjUsAZFGV4To69
         xkZKN+nUYN402iVLwwq6eA/JF/vBqDiCLA0BIGacS50LL3IqhKXXn7vMjxe5OliSVhF2
         iUaBpqqVQ+qJWkSc2tRPjvPsGbjy8Fi5y2/Jkyo+K0nXOhTBsHjb39mRwdcwPmmTL48a
         4mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973460; x=1715578260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMSkODsG7t5yWnGmB0n44Dj2lacu17Mhk7BwCmJOvKA=;
        b=oZXxzapxzNgEBNqFjw/+jVzvt40OUH1iqm5g6rMXRQx9Gk7/bHvTX62LM+fHq9U80z
         UNm5OUDEi7f2rJLxI9S5TkKRp3HwOIKchwYNuMazOd8JWcQU/djAZefmZTAK/c3MVhfo
         FtFeGm63LGcqjKqTOoGlYWq/xRTElgi/SsoP1/UVlhhTAUpK7CqMn+Q41LXmvRW2ZxNL
         AkqySqoOuJzpRMCZnenBs8aABU4KYBs2jQpzNb0pwWpc7aV2DOHbCpv4UB1xm8MBVkMJ
         EoEJEYrku0hDHf6zoxxybam1ql7GwyY9hpPYn5PPEwWwFoC8UmfrU31IAfrGLAEeDZdt
         caKA==
X-Forwarded-Encrypted: i=1; AJvYcCW7QBTGbvIgC6sIsozrhddguHoHbCEa1GEocluRNRohO+fv5G8gYnOhNXdERwLwF0xKCkmahkbN6/8gyxrtKblFgeHQ+rOjq8lI8zzNnibA2g==
X-Gm-Message-State: AOJu0Yxda3U7glxEWnGPxOoQNc4lYtfQrjC8lN6GLfHh71YwWalNy5ZC
	HY580X4bsa4x+eVKjOGGT1y8HLAKUHdnGA8V8Ws7UT2CYf8FAvuzUq7illb5VQyELVvP2riVm0V
	n1iNGzQ==
X-Google-Smtp-Source: AGHT+IGVAUyB6MHqFjd2ZrXXirE+zSCX3EDDFExYLi3qdObYKdk9RYe07S4/VPk6JzALE+CLT0k1NZtIOAbh
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90b:2302:b0:2b4:329e:ead7 with SMTP id
 mt2-20020a17090b230200b002b4329eead7mr30779pjb.3.1714973460060; Sun, 05 May
 2024 22:31:00 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:43 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-19-mizhang@google.com>
Subject: [PATCH v2 18/54] KVM: x86/pmu: Add a helper to check if passthrough
 PMU is enabled
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

Add a helper to check if passthrough PMU is enabled for convenience as it
is vendor neutral.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/kvm/pmu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index cf93be5e7359..56ba0772568c 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -48,6 +48,11 @@ struct kvm_pmu_ops {
 
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
 
+static inline bool is_passthrough_pmu_enabled(struct kvm_vcpu *vcpu)
+{
+	return vcpu_to_pmu(vcpu)->passthrough;
+}
+
 static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
 {
 	/*
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


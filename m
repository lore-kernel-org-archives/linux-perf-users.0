Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066A14BF89
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488406; cv=none; b=LWu4y+BaHAKL8sSTUfm2jJRRiZfSyG9FgobylvrOEbTPX04z68OXOkkIXDGrk0jwWDejD0xQfvLTg+HW39Vc7GFmsB1dRh6NG/MuHWFkGQh9N1UCzrjKJpTxPqZCgjbX9kle6o4NghCsjXQrmtg6Yf6xrBXWG8HPyUQFowYpooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488406; c=relaxed/simple;
	bh=1N6o/tt0qjZsiNn9TRtgdTMszPz/rc89Ap92HYjYtN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGZ3mQ8WiRB0KNI5z62HUCPiP/vZ8boIYU0NL7u6OOhXoiXzzSjm+LgCQ8MYMRRSp3jMsj7AIiUl+08wvnA0dJepPH4dnMkD5w87Ez89uhwE+sWZrPMFPYW8YC+dysPIkdkSDQWBBVs93riGMmpdGk2AlTMb0wzxImBHkfbOYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6zvgYSc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6zvgYSc"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a242496838so5202249a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488405; x=1723093205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25WbRm7EAjN1rG2FTSFj2DRaI/V7TjNZhs9wOJ+514=;
        b=L6zvgYScixa8tXW8dNa9alUZuE0XUIkLr5A69kIA2/Z8opnrTMnHPXyAILSzJpTyVj
         3eyN9TeTP7w8zyLU8FHX/b1GLZlEIAQ9cg2dLiEyNFgRRP7Zj1eJNbfsdY8MvMed1DXr
         3OhUf/gx5MkySqTBcxlDOBh/TNx3TLbwYMpJMITlYYMyOLADItiStxT9skMHprZlwH82
         ef4OUM9YRRZddX/HzrpAS6Nmkh+LkNAohIkuUt/uFXzSQACnOTjNX7oAdan/7iBon7zu
         gbDqmFkBKRx7nJMEwB7ognjQjghxsYkq0i0BIUWGm8I/P6Lj+LkutOEVy0feU4SgcqB9
         2+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488405; x=1723093205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y25WbRm7EAjN1rG2FTSFj2DRaI/V7TjNZhs9wOJ+514=;
        b=ZIOnzXsGvtY1JUYf0wUdmxyJdu1nKT6dxLGPaNcG3jjfvI/4xrohead7RVs2qOenNv
         fAd0cp4c4RzFLUnEBoMSPWTjIdxms6IM26V5WksjiTUtcllujx23P207bE1lc+9G5VwW
         ndy0lBgMmMkezO54WNTkzZbHykSLAj6xqRva/PYrOEbssY2lj5Z59J0ztu6U08U5lGrr
         xkeIonB9Wm+hi1HHhV1SSG7VvuvBo3favYaQhjxdSfR+KLTIcad9rbETv8kpZCaopNC1
         gvlojbTuh/RR3qQ+mJld3NZXW8njTCoYmj4ePhB6xt502uK/PfV85DF0G5HjYDb0y2xw
         nIjg==
X-Forwarded-Encrypted: i=1; AJvYcCWeBXSNuzrQ7zD3EBFbviPusirPEnWyyl7HQ4e2+f2pkmI0LZzgbD9QKRVdd64x+iSAUZfboJMeciPBJf34/+tDJP5X9usWEBbAvNYAIVp9xg==
X-Gm-Message-State: AOJu0YyLxpLV+kR4GLNMvv9sFESERuGkG6mmPnT/51JDpx2w4WginyMM
	g+toWbxyPozinVtSYPhbNMKKtb8WfPpH/BeipwNt1zyedRuuOvSYIR/dML50jOJFNvaYi9+5woM
	Hgl4DNw==
X-Google-Smtp-Source: AGHT+IF8rIuIfSmR/4aWJNkI7c7QHFwq9CTozYEPbwuVYBVtfJNVlPByRErHPVL59wZvz91muV2Q0JVJYfDN
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a02:c03:b0:7a0:ec69:7cb8 with SMTP id
 41be03b00d2f7-7b634665ddamr2631a12.3.1722488404429; Wed, 31 Jul 2024 22:00:04
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:38 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-30-mizhang@google.com>
Subject: [RFC PATCH v3 29/58] KVM: x86/pmu: Avoid legacy vPMU code when
 accessing global_ctrl in passthrough vPMU
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid calling into legacy/emulated vPMU logic such as reprogram_counters()
when passthrough vPMU is enabled. Note that even when passthrough vPMU is
enabled, global_ctrl may still be intercepted if guest VM only sees a
subset of the counters.

Suggested-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/kvm/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index bd94f2d67f5c..e9047051489e 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -713,7 +713,8 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->global_ctrl != data) {
 			diff = pmu->global_ctrl ^ data;
 			pmu->global_ctrl = data;
-			reprogram_counters(pmu, diff);
+			if (!is_passthrough_pmu_enabled(vcpu))
+				reprogram_counters(pmu, diff);
 		}
 		break;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
-- 
2.46.0.rc1.232.g9752f9e123-goog


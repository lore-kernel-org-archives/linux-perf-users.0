Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FF144D36
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973530; cv=none; b=qqJfk+mYLxFurr3zugN7ogX63gCMIMqBFiEXF+cudHPp8U0+c8qqd/VGckHbEqTyt4NAd0CdsVQBTOuYpuJ1cftwQtrYKKdzT23pQlGYbLz9iPjDqxBShHjicER1g6HR1REmpcnPtpasAHjgyImLr8WNWDTzxs8cF5hz3/wuXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973530; c=relaxed/simple;
	bh=BVEc3GheAMrvPPEiSDpTNWaEswxhgD9hvN+mtoDq/PE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YIldMBDQ+E/3Ow6fAA/v308ms116PtPbd08i9b9jOwqILIWMH93A1xFH65dGu+Yo+9bxy/l8boxvNbi17Vez5eL/paZ5pdMYWf71fFNDO6hUEDiJPuk39XvJWK9FbJpq86rW3a1y45G/ToHUpt7JnLGpnSyxbeL1/gzLQw9SNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6fvUmSQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6fvUmSQ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b38f8cac9dso2811501a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973528; x=1715578328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=r0dMbpLuPkp27Z0NYeXAfwk+uuX6GzkvFCu4OKzkqfg=;
        b=N6fvUmSQJpIJ9NdwabWFmQ08m2n8dwgniGZuQCGQmXt377YDWpFBmO1VGsBKljv3KV
         xgUfBfNpY20u7vZ3eXUquxpTh6wwWnBUYjszn2mb5mydbMULMaFD/zDMZRkN8XNJh2vU
         TgpkSXgE6lyFA3ehjuW3p+x+earEG7+SFjNxR3Dfctwr/oQepr9rkiYe4nLtRI+jlJ2N
         EYVAPMJB4FaU7fSFC2sYOpEoUkvHkJ9eaexvcylENcL3LWYEUrOOAX0B5uXdIyFxf7gN
         0TwvvKsITy+c1TOixU8Dz2tfnuJz5oYJoUZmNOsRjtVMpNEMu3dzGa4o9TjwTWcqRTP1
         A39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973528; x=1715578328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0dMbpLuPkp27Z0NYeXAfwk+uuX6GzkvFCu4OKzkqfg=;
        b=rTWPcJwSYG2SLjIB4MwEQhSkG0lfj6w+Znc3YV1A2eW6+GNay5RUKDM0cNvl/zuQGK
         aFOFh6wbQCxWvHE+M9F8/97wUprmwuZCZVNH/q6j0in/yyQnBFRgvI22+keHpvpK49x1
         DiUp/izNEBfMkMJafMgiSioDaPj2xEsu7qJmCvgq3rLvbTUOygyJ+hONuIzbhzJGvEt7
         taYcPW+VNKL7v/F0u1yniMloO56gTn5ubUaCMsvLqMuMIe+gNWIheU9g8/LU1lvtbPyi
         WM8bt9OjGySzSO6Id0FDcIW+DCBV9e7herqVx8bV3OUR3fHn3h1Sg5x4h5w3obi/QRGi
         yYvw==
X-Forwarded-Encrypted: i=1; AJvYcCWppXJdpoJenoBGoEzopiZljAycNvFWZVUFCNOylBAu2mdHYeAMnwLif7oDq6yG7HHX0dSxRGSP/MaGMK9+ggvuMH2xumiSS4IvPoqvjjb9Wg==
X-Gm-Message-State: AOJu0Yz2JHxL/RG3bXg0jint8eKC6sLis4GjTA71PbR9jW4IUN5LuZ3z
	sscAKpMXcgopr6RAa6I/eHPueUg+bDGbQiY7xvRVaPEsNCsinobU/2S88SUpxfMhWULntvXeIbR
	DhNdDvA==
X-Google-Smtp-Source: AGHT+IHEVIsC3OzLcKPgw25unnky+n+wjQaLNtSetm/7/zKes1bE9kZoM4IWaLd7BdgQxrlqRoWjj60+LZyI
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:9f83:b0:2b2:7ca7:a217 with SMTP id
 o3-20020a17090a9f8300b002b27ca7a217mr53260pjp.4.1714973528312; Sun, 05 May
 2024 22:32:08 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:19 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-55-mizhang@google.com>
Subject: [PATCH v2 54/54] KVM: x86/pmu/svm: Wire up PMU filtering
 functionality for passthrough PMU
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

From: Manali Shukla <manali.shukla@amd.com>

With the Passthrough PMU enabled, the PERF_CTLx MSRs (event selectors) are
always intercepted and the event filter checking can be directly done
inside amd_pmu_set_msr().

Add a check to allow writing to event selector for GP counters if and only
if the event is allowed in filter.

Signed-off-by: Manali Shukla <manali.shukla@amd.com>
---
 arch/x86/kvm/svm/pmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 9629a172aa1b..cb6d3bfdd588 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -166,6 +166,15 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
 			if (is_passthrough_pmu_enabled(vcpu)) {
+				if (!check_pmu_event_filter(pmc)) {
+					/*
+					 * When guest request an invalid event,
+					 * stop the counter by clearing the
+					 * event selector MSR.
+					 */
+					pmc->eventsel_hw = 0;
+					return 0;
+				}
 				data &= ~AMD64_EVENTSEL_HOSTONLY;
 				pmc->eventsel_hw = data | AMD64_EVENTSEL_GUESTONLY;
 			} else {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


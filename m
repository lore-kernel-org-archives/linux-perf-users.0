Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF63152E05
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488452; cv=none; b=LTETettntt6Fa7t/lRD+dVfPKo/zSz+L04azjIKhA+OoFH4Rew8PmfRxSzDagO16ctoCac3pwjvoYRIDZ9x4v4BOasQO/johipgoQLSvXFcgL73Kzf7o+v8edRu9+xRyhIhkaPvS0Hr+niB34uxEUzF/Mj9mBYIIoNNQBL9XH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488452; c=relaxed/simple;
	bh=tIwjYv8ypqkxRXoGS4xc9qXzWyaseA4dDsRGcwRADJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=On6P5P0dI8c8xLbnMZ2Dj82wTRLS8M+rH1Wv+c0AeRtQ3QR7Zih+boyOCVq0HkncHYCqllEKyCmF5PIjdKI8mMGqodFp/P6Euv7cHAY3ylb9SZb+KbK7ndCMyS99q7nizfvowZwmJUL1i6G3MWq/+QOhJlBWVe0x+zhY7X2wM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWtNYTC5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWtNYTC5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a23a0fb195so6697654a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488450; x=1723093250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vsSwrDmkl/yCmJ0VnLkvY5bBtC/K75K4TCnFQ/SbBkk=;
        b=BWtNYTC5YjtZh1XTeVx1jGlp53fv0wojOrNoPIuX+6WU9N2j1iB72RMyY8MJhcTTrc
         6RMaEkpmokJfJ0WuYCfE7TAlKn6ssGO/DBVxrAlIkpP5/TFKcYJPJHq3cCybtm2N1jQv
         yePjxkSx3ogKwLNUTeBWOg83kpFXGXiRy4RcwcPCfT60oCld5uHLLsyXaXCD9hCdvNEy
         RaID6TKoichdhszk6hh9mBYn2zBd/cyag9GC2inMQWul3PYyTFhUHBEUBRNGQiZQh+Li
         pCxsBp5w3Mh8nWnDLUm/5PUBqPHBoh2bpCYCASZOswh3VV6Pvvtb8mRcfHFlMKi9R5TC
         8VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488450; x=1723093250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsSwrDmkl/yCmJ0VnLkvY5bBtC/K75K4TCnFQ/SbBkk=;
        b=hqRsS4A+3oEQNcbCqOeqJFar7Wbv2i4uHxEPoERbEta+rYE+dCBOX1BU+LQvdMawl8
         h6zA+vUk0k1Drnnx7i/fYCuh48hGos8QfudT/dxuAbJnyA9AI9Mo3fWuj1rYRFYv8M49
         xTrPHw+tFzbzRG13T6FBju2QQ+CSpXtxpRvQrAJ5PdhKM9qvJ5vH718hgevb5BsvG4Ps
         OeGT9SnqoeL+DMyqdIz7aWdIB40wVO+eDm0CX8lJtjJjQXLsWdAVmphrJiJWvJhwIl5z
         HLgQx0I+XuOtKlWGljdR/9I+FuWETke0c3TIOQV6fIe3vC6qpIBPVVdLxhxKqNmzy5qd
         lqAA==
X-Forwarded-Encrypted: i=1; AJvYcCX2xwSx4xM7M6Qx0vhrBTbCAEnWrIiVuodAokbYszDnJJnGgd6j4Kp+UpAtlHuV9H1co8ywPCo/TZnfqIa0jFjJyGDfv55BOLWMQc6slR0vEQ==
X-Gm-Message-State: AOJu0Yzvv2pH0PV1yX2DvuhMFoYgdgL0EFDClsCqwKYXhcLeBhU/iikA
	fxXz93KqbytgMSVq0mziLEY87NQYeKUsX8XmmjoVBG2lRgPwLlr03wF8Ji3XGNdSq9S4p4OwXEQ
	LvU+Icg==
X-Google-Smtp-Source: AGHT+IFBlYeU4l8+KBps0mlbqMtbd2Yclwsw8dmK7Kp2BehpNXQf8F5wL2xKaITxDppl5saznX7iR1mMQ22i
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a63:1c47:0:b0:6f3:b24:6c27 with SMTP id
 41be03b00d2f7-7b634b58f82mr2706a12.5.1722488449902; Wed, 31 Jul 2024 22:00:49
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:59:02 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-54-mizhang@google.com>
Subject: [RFC PATCH v3 53/58] KVM: x86/pmu/svm: Set GuestOnly bit and clear
 HostOnly bit when guest write to event selectors
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

From: Sandipan Das <sandipan.das@amd.com>

On AMD platforms, there is no way to restore PerfCntrGlobalCtl at
VM-Entry or clear it at VM-Exit. Since the register states will be
restored before entering and saved after exiting guest context, the
counters can keep ticking and even overflow leading to chaos while
still in host context.

To avoid this, the PERF_CTLx MSRs (event selectors) are always
intercepted. KVM will always set the GuestOnly bit and clear the
HostOnly bit so that the counters run only in guest context even if
their enable bits are set. Intercepting these MSRs is also necessary
for guest event filtering.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/pmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index cc03c3e9941f..2b7cc7616162 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -165,7 +165,12 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			kvm_pmu_request_counter_reprogram(pmc);
+			if (is_passthrough_pmu_enabled(vcpu)) {
+				data &= ~AMD64_EVENTSEL_HOSTONLY;
+				pmc->eventsel_hw = data | AMD64_EVENTSEL_GUESTONLY;
+			} else {
+				kvm_pmu_request_counter_reprogram(pmc);
+			}
 		}
 		return 0;
 	}
-- 
2.46.0.rc1.232.g9752f9e123-goog


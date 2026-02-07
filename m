Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF228489B
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427435; cv=none; b=GkNk4/nkR0eFnnpy4rJFoGX87hAnHsqwNUhcuoIHfLRIJuXpGyK9XogZoN2liDMOWDNkAUEe6//mpkjWRspdVGITN6WSiVUI5rW6orhvBWcKdW4k19MVY6n/JZ2NIIl/2zSJH+ph7c5oY4za2FV5qRThZQJu0WApRcatlmIGcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427435; c=relaxed/simple;
	bh=rUj9ix3uDrXvjD+ufVp15UBmVgPFZ3lQbTxS5CHo8TA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EAo+VlT+UtDyTYB9kZu9XgI5c3YRTJWJeMrGOGPr22rxodDbv4ZGmoNCGkHNOfIoqiefbcIXxtegdRTzJCWTKQjlnbRbmou6j6Jfy+Ilk2Rq/5gqRtVUjwQbJnEUytUkQZLEpULkvo8b2rHw64gvdUQeBdKa/XSTC+oNg6VSXnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xC9Ev/1B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xC9Ev/1B"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so2825459a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 17:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427435; x=1771032235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mngs9Ic51OGXCzrzlPYHhqLnfHfzn7x/zcXQZcf+JUA=;
        b=xC9Ev/1BaCnMn1BVZWCASpZ0YZPPZA0IleJk0+Q6STFiPgu+1qYSOpDL61NWOL/Dn4
         TreEjYPLcOEd4uejgtKlxfOQg/joWUK4fL/ZyaHfubi9vJhBmRJq0fOhp7CUlQhQM01h
         CStQNulq4EpubXIk/3OIWw8puutdp/K0CZSrTfWeEOIZriHrK3+Fy1NAsdm5EsJm6buL
         8pHJl3YX0jRthfVUa1R7yjLCzK3CmXLh9xJ+wsh8kMiLjhoQRAvq0S1+mM7x8sDHa0gf
         wzzJ0YrfkRQcTknq1JZM/P8jcPq8r5aMFb0U4IoMqliznVEjjOtd6qrTuw3P87hFR89g
         QrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427435; x=1771032235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mngs9Ic51OGXCzrzlPYHhqLnfHfzn7x/zcXQZcf+JUA=;
        b=DYhBbAADcSlvuJffkuQDIuSXM6HuTTkzmVjjCpteauG0NFNEIJaVLtb6H3L+n6l0p5
         DQSySpELbE0o/1CQNvKV6rrfggtWCAg7GSbuwgiIxQycuOMoxxt/BcKxOuXcvR5JLWcH
         QWA4VRiOnPVry7r+DwEXgMIR48ii1QuYwigAvm9pS+hpmk8AtQn/ZNpxboNuhsOhXgHM
         PEgxZ9qwXzDu1dGdEPFVn0dUA1o9kLNFyvhG9lqGY7WcqTvzt0SX89+k7lEeD/u6qjHK
         kc/7CY5/diNu0VuiSwhyFxFOqB9QiSpqf+xWi4aoO1tz3CjXBZJEh0lAcYos59MfAH3e
         6QWA==
X-Forwarded-Encrypted: i=1; AJvYcCVdzeq6CUFlZN17011kqsJ0NpfkzWFPvrLJHq8gGkchgEYuCv5NiytDHxc5gDIOYW4cQwP47jBBCt1gECoNcwRA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6H6D8k3z7jOd0Gb4BeUe8jYtGc265h2FeC1PlJJL9j7xi3TQ
	6cBxXgMHZhrDV9o5JC90ouvHJ3WwIWNmixM/nuj8IcgjkM03nKd5OKnMsH62o/kgfo8W1sMP/BN
	c0BoykTOkkfsXfA==
X-Received: from pjb13.prod.google.com ([2002:a17:90b:2f0d:b0:354:565c:69ac])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5348:b0:340:ec6f:5ac5 with SMTP id 98e67ed59e1d1-354b3c406a0mr3511383a91.2.1770427434980;
 Fri, 06 Feb 2026 17:23:54 -0800 (PST)
Date: Fri,  6 Feb 2026 17:23:27 -0800
In-Reply-To: <20260207012339.2646196-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207012339.2646196-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207012339.2646196-2-jmattson@google.com>
Subject: [PATCH v3 1/5] KVM: x86/pmu: Introduce amd_pmu_set_eventsel_hw()
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract the computation of eventsel_hw from amd_pmu_set_msr() into a
separate helper function, amd_pmu_set_eventsel_hw().

No functional change intended.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/pmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 7aa298eeb072..d9ca633f9f49 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -147,6 +147,12 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 1;
 }
 
+static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
+{
+	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
+			   AMD64_EVENTSEL_GUESTONLY;
+}
+
 static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -166,8 +172,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
-					   AMD64_EVENTSEL_GUESTONLY;
+			amd_pmu_set_eventsel_hw(pmc);
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
-- 
2.53.0.rc2.204.g2597b5adb4-goog


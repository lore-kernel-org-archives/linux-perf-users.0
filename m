Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C2337BB5
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729881; cv=none; b=H1sjtgzITr6e92zAIW9VINiIR8z5Ql1Py4yEMiwWwqzRuUVBIEXzqWCA1lmRycPcfUEj7hlg51IEm6O5T2SnxtK+NtKvaMonRqcXYrbTg/qkLz5ETnNu8ZXQYq5EUl+VK5CHR5c3nOEdusQnFnz4+qwOm/hDSmJfFgH6T9VsT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729881; c=relaxed/simple;
	bh=P2gomgDRGmJ4vLTkCMnRaUel1qN8UOZyfcbTRRVQbSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XzD1AovUtxSLvvDIlGZRY9g9ZEEZhLx7OGTZzO6dJWmv9LuwX+hgHC+8oMb9bYl4gDWVZ600GYNfX2VHP5lWt1qvZr0b9JImXrebxiJqYEJ8iM4iy4dfEJf6rmN27TLLthB5+gMbEH1qc5AgJLU56OF1LPiBQmN0ztl+EHTJpfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P4DLWFDz; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4DLWFDz"
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-9426773a207so5338968241.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769729879; x=1770334679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9edmz9F0+Ueeg69+oBnQppllXkvN4AaYJE9iZBV8Nzc=;
        b=P4DLWFDz/der70FqsWMufnP/AZ+FmsKeX5/kVMpGgOKFCsMoLEAAOeZ+rPxmlERKca
         9vSIH4kHE51TrzoE8RN0IzrIuuUGojNDuZdnXAOttMwVLH01GUulZIFnsJ4pkg4F8mZ4
         5fIVv/eYm/kbMhufI9sJGBKFThrObZKi7RnPQNaFRxtKPMlNwPKHdHpQ9c8oSr00IjDO
         8PSLdvB5SBW7w9+ujkKXMfRpSs1FUTiZXaAoF7RoODAdGFrAxM9DNdPm+qDaXPa5LjnD
         OpzNg25gIPdaWZZ0ZbirYNN/k9Kr9S1sVd/TX7cYB289J8oz8ynP1YUBxyjl4LEfdf6g
         kg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769729879; x=1770334679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9edmz9F0+Ueeg69+oBnQppllXkvN4AaYJE9iZBV8Nzc=;
        b=cAJ2VOwTNOAZf+r4z5EUJs5gBEGozHWgnRh4FmAJ7V4WUDvWLG8tXCMJo3EOM8Z9CM
         nr4NI+HB0Sc3rAkdcaWyEvCM9krxAjHb0qGPp10a6swFuec0mdXnsZl00BZzaRm07GJh
         5XZT7hoXL6RTNCo1xNo5P5HsMmoGC+9iBSCrlEQxCxkCtX1kjzfJTH3WmQ+LT7UQrWDq
         JJZWtDEho1LArxgACRuUFfj8g9vXsSerQwCh0pBlCLHFC+2vu6gRqPsc8k7IQgzSBNUc
         nYgeL6YW5lkEQIhpg59mlzkOAvh1Oqp4l9TWPSQL71XBQ3kNlWHZg4FgLw0+7i821Fly
         QFww==
X-Forwarded-Encrypted: i=1; AJvYcCWns7Gf/DmbTLgzi82Ak+PIM3SU/IK1rMIhSqVjjlV7lrX1RKAhdSWde6mzQCIxSukBTNAAPeR/+3YrBY7DCC2w@vger.kernel.org
X-Gm-Message-State: AOJu0YyBiUL22l2VxbRhbLPL6kd9EUP7AiVx7ZaW3LptOMI8ZfG8M3q2
	B7K26/SQLMTQ61jzmRoBDxceTZcf/e5Z5NZwyuqZmeCC1ukZejIHqMue4WOnwOCBRCN6eRcTcYz
	ySqsljocBE5lXeQ==
X-Received: from plbll8.prod.google.com ([2002:a17:903:908:b0:2a8:759b:173d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d485:b0:2a0:9eed:5182 with SMTP id d9443c01a7336-2a8d96a6b54mr8177095ad.20.1769729346081;
 Thu, 29 Jan 2026 15:29:06 -0800 (PST)
Date: Thu, 29 Jan 2026 15:28:09 -0800
In-Reply-To: <20260129232835.3710773-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129232835.3710773-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129232835.3710773-5-jmattson@google.com>
Subject: [PATCH v2 4/5] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with
 nSVM and mediated PMU
From: Jim Mattson <jmattson@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: mizhang@google.com, yosryahmed@google.com, sandipan.das@amd.com, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vCPU advertises SVM and uses the mediated PMU, allow the guest to
set the Host-Only and Guest-Only bits in the event selector MSRs.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index e2a849fc7daa..7de7d8d00427 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -243,6 +243,9 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) &&
+	    kvm_vcpu_has_mediated_pmu(vcpu))
+		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-- 
2.53.0.rc1.225.gd81095ad13-goog


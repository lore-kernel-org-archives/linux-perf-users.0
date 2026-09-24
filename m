Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC64B512D
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270997; cv=none; b=iQZUM9108QIA6N2+mV+G/NNiJnPG+0Goy+fBuSV+OSnlUBWle5dK1lmyvc5FcoeomiNoFsLLaehRKxFN0l673mof4rQ2O4x9J2kxxbPiOdClWAnM8QCXuJ+7uMCBoEB/rALJz9lhrK7h4Gv3I25/M4KcSnaepyMOPn/+uGvn2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270997; c=relaxed/simple;
	bh=dPoD2KWcJdBMoqLmCayL0dkgGb1iTFvhuDn+uK1Rbmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWX8OdDqa4z86veiYyT6EsEPuDTaa/d/9ZIhx/qMefVbE7yJEqSviMeMnCT7vh2rwWz09bo1LhK68OrlOqxEBM8in82BfT7+xpkiXTJDRD4hU7x3fxkpiS4c67XdVF6eoA01sGv2UF+/GgavsGOf341sxNNrVXmyP8nigtM5EEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZiwh/yS; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZiwh/yS"
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b28dafb8e1so194070b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790270993; x=1790875793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5UB2VMD+EAaxdax2pXXlz1H3xk/sziSl+ovTL17nQcA=;
        b=kZiwh/ySSQrU6W/bNKo1lPMZb6KoSzwMT61prSIxuoaKDXHTAVQxLok9xs6hHrxSI5
         1kUPOaeM9jp2ovuLdszGGpkuTUERqFJHvkepjHSA0KibxDX7BXeoJLSypMbQMVwybPbx
         RsfT3NETtj5EzkgmvhUOlaMLb9RhWU/LtzQhwHs6mSxcSH7Cc2xlfkXaZVayvfIFWddA
         FH9PLxPvXBF12BqsW7jQvz4LGE5qpPNQzXsyLXVwDNHAUotF3r3UFgbEe/XjmRqpPl+A
         8/x62kRyA59J3MxlL1XKs/PHb/EPG2J0LU73sOfWOOUglWe58Nv7mqhDnQnb5edyr3XR
         fu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790270993; x=1790875793;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UB2VMD+EAaxdax2pXXlz1H3xk/sziSl+ovTL17nQcA=;
        b=egbsbPg/MKbp5IYXfSAGFua4baGhoOe/Z0PNxLHtAhv7PqhFyp7j8ChmXQr4LjLw5j
         Ki/eS5U8TWLENUPys6InmOVkJ0vuhgTl7T/YL2P41jq59k9n8ztTcQlL5pYxCag6g1Ek
         drsCn2gWTluqh5OlWCHw1JrC5U8RS5sTQ0EFqzgvPsDHzjqBOomkMnmLrKrk2ISqj1DK
         wckm6V0rDULQi3v46u4MnrKc/jt7WHX8ZtOagmRYsnJOyFnoUmCxJFDCdmvrFKrQtnux
         brFvaFYTKRxQy1Uroyit5dM4Q154p1cMupl0OmRCqh2W3Y1LqJyr97JKhyAjIo2bpNcY
         dDvA==
X-Forwarded-Encrypted: i=1; AKwUvBxvRe96aLEl3qOqvm6G5DKBYUz4NvJrzWT+IQE2EbzZU591LHugP0TxC5x4jmz9r+H7FRp3zzjF/hH870RXTrG+@vger.kernel.org
X-Gm-Message-State: AFuF++lDqOfekzD7eck3Movbqpj9e2WQpQHjpK4KI37C9A6owxsu1rGB
	kWxyffb0Y0XvM4UGAjkyiAWBq4TO2qMR7KFZkLYjmFn7yRn9zmMZp3sXovOLe7TB65QvCTRa/vo
	QGlkRoBL4LX6Wvdw8DZJusla85w==
X-Received: from ilbel26-n2.prod.google.com ([2002:a05:6e02:501a:20b0:50b:1d1a:8453])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:199d:b0:4d6:90f4:48af with SMTP id 5614622812f47-4d72e966ec8mr3960018b6e.49.1790270993044;
 Thu, 24 Sep 2026 10:29:53 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:29:21 +0000
In-Reply-To: <20260924172928.2110956-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924172928.2110956-16-coltonlewis@google.com>
Subject: [PATCH v9 15/22] KVM: arm64: Allow kvm_vcpu_pmu_resync_el0() to
 resync filters in process context
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zide Chen <zide.chen@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Mingwei Zhang <mizhang@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, kvm_vcpu_pmu_resync_el0() only scheduled
KVM_REQ_RESYNC_PMU_EL0 when called from interrupt context (such as an
IPI reprogramming host perf events). When perf_pmu_resched_update() is
invoked synchronously from process context during vCPU load/put to
reschedule host events around guest-reserved counters,
armv8pmu_enable_event() calls kvm_set_pmu_events() and
kvm_vcpu_pmu_resync_el0() in process context.

Update kvm_vcpu_pmu_resync_el0() to call kvm_vcpu_pmu_restore_guest()
directly when not in interrupt context so that newly rescheduled host
perf events have their EL0 exclusion filters applied immediately.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 6f60f86fad387..a8214ab52fcb5 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -213,14 +213,17 @@ void kvm_vcpu_pmu_resync_el0(void)
 {
 	struct kvm_vcpu *vcpu;
 
-	if (!has_vhe() || !in_interrupt())
+	if (!has_vhe())
 		return;
 
 	vcpu = kvm_get_running_vcpu();
 	if (!vcpu)
 		return;
 
-	kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	if (in_interrupt())
+		kvm_make_request(KVM_REQ_RESYNC_PMU_EL0, vcpu);
+	else
+		kvm_vcpu_pmu_restore_guest(vcpu);
 }
 
 void kvm_host_pmu_init(struct arm_pmu *pmu)
-- 
2.56.0.rc1.310.g51773c2048-goog


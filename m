Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8F14AD23
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488391; cv=none; b=E8EeHvbMmaYO1rbZXKZYM2wmxhgmRMZCiAOsywU/wxOEutLCBi/tMfFcC8X6br8omBZPPSWCzyGL74f6YJIA8QsXc/15MNpqZEei5TpmdDOtsmmv5OZYPs1C0zD7X82hYZpBr9iIdVAPiKRV7jC2Gv0wVwMS4jwoZ9RdmIRBk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488391; c=relaxed/simple;
	bh=BaHu02UFGqjoVlKM/KF0W8Z1EcBs0bxy9IzWhYDzC2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hvo7243j387XfeL7wkNJjFArtQmTTSxd7q2X5TofUUeDHilt+EC/rKlk+CU4t+qhnvrz0UrcPiMBcujRUacuzUBEXzZ/snKTm6YQ+0SyXzrdK3tscKs66Xs/FFoduooYOkJjyQohaxhxWyJA3vwzGM1NjS9Ema2GCvT6ELhl81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PK0BQ5DH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PK0BQ5DH"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-79028eac001so6060435a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488390; x=1723093190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RUvQCQx/WMIpOOFe9mcTTW5PZCf+TCUSSqHzyb7UegQ=;
        b=PK0BQ5DH9hon1toAm7uuoTbuasYKVwaq1eEvGzpK7piVVqv6R60PqoPZQlP7xrqubf
         2kHO8Qe9aPc2Xs4tXeb9F0XdkvEsUdYobIbUF5xdS8sdHazjpLGfx+JT5FwsBFpyl3zG
         YpHF/kM2dLIOulCH38KzG4o3FkrE9BM1CcV6HZfa+EFm5NPqIPc9LTZAtbt4ZOgv6yAD
         9YpTYwwQ6FbZZdy4SxM1c06jmcqV0AyQ+pitkE663x2esSlfRit8uy7K4HNqyHhxMIMH
         YZFr4m40pngUZwHlhPbCU8KJnCpWC2eUw4TRp12XlJLtryoWVGa2wb074Yr7Mhgd7eUf
         Mozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488390; x=1723093190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUvQCQx/WMIpOOFe9mcTTW5PZCf+TCUSSqHzyb7UegQ=;
        b=jV9zB7rQb56ZHxDQyW62pEvch1tNxu4v65eAOWYfSGD5MWoOrjsRDZa9H6KXEYBC7M
         9dtYUBVMs5n3B2Q2OE8EzQTyEewebhBBMyvAvJzlYx9r0jilVjDjimAYreANHlXR1XKU
         hw59dY+fH0JDOEOGses3jqF+1PYo9AJ/cLXNp9zU3p3MeM4iCdCjWUtxj+X9TiHxfwKv
         VzRRQkGkipSGrfaj4e1+Du9ChcOeaiyY0x7eivPfzsNRMI8Z/oXSFGeQgA72wBvKzcML
         4Yv5vL5uA6XPFdmWrhRU/k6lhZ4uNre76MOA2guIcwaSsTQr1CMnV+c4sMTHKAUm2adF
         GaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC8tDhkL4OF+mK3dpGAfX39A0jVxfdjsJljcNMuL/ddOHT7uPW6Y42ra7XiqM+ZcMTZo6lfK5oxS8VIX7PbYgX5YPnmDXvPBQAh2JH0+I4oA==
X-Gm-Message-State: AOJu0YxVgeGOqAQwypa8mYP/BJeixmiBffvMTTCJ1+OXlNJOpnoi9Qyk
	Fff9sOm4/ELswueMhdFW1B72JEeGaBE71qFYxw9G6rRPaFHQS9nJ7E133LLEktnw8pU8MNdjipK
	HaqKbxA==
X-Google-Smtp-Source: AGHT+IHjXcgdfDuOm2S1Gi0CNX+VfGrMUYUIMcwlsSzve61nT6t1siC1nF2RVWD4E2UIzf/j4bY/WUAd3RI8
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a65:6813:0:b0:76c:26a8:e0dc with SMTP id
 41be03b00d2f7-7b634c51fcbmr2594a12.5.1722488389288; Wed, 31 Jul 2024 21:59:49
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:30 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-22-mizhang@google.com>
Subject: [RFC PATCH v3 21/58] KVM: x86/pmu: Add a helper to check if
 passthrough PMU is enabled
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

Add a helper to check if passthrough PMU is enabled for convenience as it
is vendor neutral.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
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
2.46.0.rc1.232.g9752f9e123-goog


Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC314A0A0
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488385; cv=none; b=gNocwrrICkrNqLW6j4Qkj+0wRWPriCO8WX+sb1TWIDQbm3nHB8rb5/J7qRpk+GEKVeloKxjH8tJ4NKxvP7FMLzDRLp0PEqM6cGR39DEHHndux3PhuPbyADcuSwF5qm4PGytMx1i/AlQvv2zdqNXjojHIU9fVPIM7MiyCQb63x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488385; c=relaxed/simple;
	bh=SZpuNCUbeW47z3voU4/T4n8knmMeJ7taYycwdsZPWMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=abWWtu58WfBMQbMPlOchvvbeHCaDSPg+RVp9X+igjs8AoQltQDQIEL/uiCmyaxRRdSnuNbWj05Cv/AaiktUayNjiubj6ez2F/Q+KacpzcDUn9Jw2Sq0FxaQmziTf5si2Egpa9c7XzZezkhWyMbIodUwbz0KNZbSRND2e128tsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Njb1j3Xv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Njb1j3Xv"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-72c1d0fafb3so4604027a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488382; x=1723093182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=apo+gka9tJa5IlwnnK8v5X5JZRB3daZzNGsyw+GPEag=;
        b=Njb1j3Xva1WeCV1YV/MVHl1tqR76Q6NH9ITjZE5bcmUzB8aRfpQDzNHtFAgoZzE6DJ
         BdTZo3q8uP6uSI4i96tyL58I3KtyfJluc2GXndm2KztAq8u2fcctxhMZYquKEt+orJWD
         77ZikjXBcImpBlAGn45prcfFkE7u4w0TxRr03ucm7JT/yU3Ty+/vhaVb98btlyv7NM+C
         GtDTMz3r3oxsxpIW6Kf8bVsxGKQrc5ujFwumYt5sX2Swx+dfeabOsERxgJzEpNshVi3E
         +oITnaBugZZz9DUazFXWsxS2Q6YFalyzpWaK37HAe0gNc5yxAepaSe+urYU0xRrirumd
         NQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488382; x=1723093182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apo+gka9tJa5IlwnnK8v5X5JZRB3daZzNGsyw+GPEag=;
        b=eYG/fyAPiC8mV6lmg9WRcVWVTnvanvQTvft/0Vj7SoibzG6e0Rq+NNjBYYRSsJdpG2
         7N6ogLZJnvA0wFKZdVfEFru4HGrt0S6eebYMdIz/axXtB7rrjgmOZCUgYIKWuz5VhCkl
         MWCf+fwQ/kDT1q6+2jgw5HS0k146fOl9CpkXKcNYXJFnRMrGdOYzElaovDbVq8vL9fVp
         Qs57ITBN0TWIe+P04g1209pLTVstCG9n71qBrD2fMePOJBphkGjN3naDgY3rLFs/Rf6v
         zhd/3YlIUIYQSZ3lF2RYIyk+ffO6Gg/13yDZvAB8zOz4eTS53BypBkwNUqF8aXbXg+mH
         F6gA==
X-Forwarded-Encrypted: i=1; AJvYcCWWiFUduLVpdZyMfwSbXLnOTOaYy222XCvDXDrPMCQUAe+jPpal4b9bB/5d2JZtodKLIFuAJjsetf4h2Zi6KPaeAavHxocUR36k4Tg+9Pqu6g==
X-Gm-Message-State: AOJu0YxZtFZarlawvwjuuCCGUQDR1kbsy82B12Yyva9lhtp4VKhY8fin
	xAJWSdgeXSqKAaSfzU5GrTQGh7UKu4oklZoF8rNcSxfUWBQfgcJi/Fz6B1gO1hk5TG87jLh9Z42
	/fkdORA==
X-Google-Smtp-Source: AGHT+IGgJu42eibEXwGmvhNIKvCVPcTIrKdXusvwGwzjhiPGFNmYBNNMkSLWK0IiHmwfzRGjr6PPwL6r9sPb
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:902:c40a:b0:1fc:6c23:8a69 with SMTP id
 d9443c01a7336-1ff4d1ffd30mr929935ad.7.1722488382211; Wed, 31 Jul 2024
 21:59:42 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:26 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-18-mizhang@google.com>
Subject: [RFC PATCH v3 17/58] perf: core/x86: Plumb passthrough PMU capability
 from x86_pmu to x86_pmu_cap
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

Plumb passthrough PMU capability to x86_pmu_cap in order to let any kernel
entity such as KVM know that host PMU support passthrough PMU mode and has
the implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index cb5d8f5fd9ce..c16ceebf2d70 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3029,6 +3029,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
+	cap->passthrough = !!(pmu.capabilities & PERF_PMU_CAP_PASSTHROUGH_VPMU);
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 7f1e17250546..5cf37fe1f30a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -258,6 +258,7 @@ struct x86_pmu_capability {
 	unsigned int	events_mask;
 	int		events_mask_len;
 	unsigned int	pebs_ept	:1;
+	unsigned int	passthrough	:1;
 };
 
 /*
-- 
2.46.0.rc1.232.g9752f9e123-goog


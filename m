Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45F1411F6
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973455; cv=none; b=thJ75M6cm4zj3SC56gUHZJkLsr42y8rG/cT4IUR7YQuhG0TUjNHB1Lnu3KTZUrKrImuLGrkbLu9mmghLE7cJqGQ8ZNJrJ27cJtURPinsrjKTBpV8PFPFk9xkOTKdJWgjdcNDMcxU8qcTGzleDmV/LqtgDmSWm72TFRO57w6J53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973455; c=relaxed/simple;
	bh=wRxUTC7x9CWXEvNMF7E9sx/rU7V4s3S4YgbgezX91CY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ERfzEoXtnBeyitUfZVtRt35cHpKsvlgSl24BQHvMQ5fhsVwEX7ujvKDQzRIozh3iZCmu0AkXepP3v73ROI5dbzH6AqW3qdEqkogD7X0Wjou+q7cMBYsIduSJfCyihJecjed/AZ92y8cGVAgb97a9a4knoXc4ajOaH7/qxzP79R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0b2jmsvo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0b2jmsvo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be8f9ca09so33950467b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973453; x=1715578253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bP3oBwDW20hxSg6WVcXvnMQIVNdAHwD/LZxVaA/0aug=;
        b=0b2jmsvoLPhYw+sh3OmL3+R+9NIMVFg/6Mxr95uN0jjPp6PJdNbfgsKBx5jfSSPo69
         1RFAlfa+wWiF7O83KBCtoFgQAx5LClu3K/vhwiY/l5kHZPzsrd+5oS6osXY+3m83xdmf
         ggbCsjnnxO0oDFjr0Zfb6s8EQN7FuZ2E2BUunkP4YkVOkVJJRvENFyCERA9clIpP1oKH
         A9aakFfhSdNhJRWEsGGbbwbvKqB7/3T8s5H2341e8W000++UpQ52BONDxIGGNfKXqTCQ
         DI3E12cQ2N7bj3xnrMTYj8iirXl83TUduKBpP2/Ty37LlwK3c4bZLqoiMtkob1WAMcZg
         ecWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973453; x=1715578253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP3oBwDW20hxSg6WVcXvnMQIVNdAHwD/LZxVaA/0aug=;
        b=VWPXSbNHx55omQwoh+vWushAiq2rywculT7DBGsv28qWxDB0OYXsjhFV9WlOZ0K7Pv
         Gxq/Y4Oao3lNJ7zFM7X7Zvvlap76HJeTp0Q2FxPYEZC0Bp7pibMf/11viIOq7HY09Yl6
         wkL9Z1rw8wbwxlwARyLPHR/O6IdOEc7FPGbtzZBu75svTCFBRwrMotbireqtVab9JAL1
         nwwC8tve4a9pGvUhqTVQ3QT4q/pdpyv3nbseMIssapPL9kZLFcmqPsvrP5HNL5CzVxlP
         5xsKmtewm0qAx9hdEE7Z4wbck7oENkRfwUMZXodVwSyDvFX1Hyr97sbjHp5SPpoJAPrO
         NVDg==
X-Forwarded-Encrypted: i=1; AJvYcCVh3loRUquqvuDuSZVF24ElX8iw9XcskisuDYvV2QErJkwffaFRSvNkG/OGSZw7fYz4LtVwcGheIkn3eLfkIk7jvWxlcFULk6F0ovnaBDVVqw==
X-Gm-Message-State: AOJu0YwNmoYdwmHo+rdTZYqqpafxpA3dvwl/1PNNU+fF1KXfHURQlMC9
	2sppkonwQJG9H6HsUOJdRp4a9TQzao3+cHxlG7KOD+kQ9NEFj/H04+QS0RiTzZ905hqXLzkPS5k
	ftAIn7w==
X-Google-Smtp-Source: AGHT+IH9mg0Ubq4dcyz/RQ1HXFgbY1IeX2tzHvbTCxN9Jfy0soPCuTeJii35p/Rl/hpDX+KAqDrATNqsyKJ+
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a0d:d541:0:b0:614:f416:9415 with SMTP id
 x62-20020a0dd541000000b00614f4169415mr2641013ywd.7.1714973453141; Sun, 05 May
 2024 22:30:53 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:39 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-15-mizhang@google.com>
Subject: [PATCH v2 14/54] perf: core/x86: Plumb passthrough PMU capability
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
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Plumb passthrough PMU capability to x86_pmu_cap in order to let any kernel
entity such as KVM know that host PMU support passthrough PMU mode and has
the implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 1 +
 arch/x86/events/intel/core.c      | 1 +
 arch/x86/events/perf_event.h      | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c0f6e294fcad..f5a043410614 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3023,6 +3023,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
+	cap->passthrough	= !!(x86_pmu.flags & PMU_FL_PASSTHROUGH);
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4d8f907a9416..62d327cb5424 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6246,6 +6246,7 @@ __init int intel_pmu_init(void)
 
 	/* The perf side of core PMU is ready to support the passthrough vPMU. */
 	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_PASSTHROUGH_VPMU;
+	x86_pmu.flags |= PMU_FL_PASSTHROUGH;
 
 	/*
 	 * Install the hw-cache-events table:
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fb56518356ec..bdf6d114d05a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1020,6 +1020,7 @@ do {									\
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
+#define PMU_FL_PASSTHROUGH      0x800 /* Support passthrough mode */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 807ea9c98567..39a6379162bc 100644
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
2.45.0.rc1.225.g2a3ae87e7f-goog


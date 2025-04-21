Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9221ADA4
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272709; cv=none; b=ISLrzVFOrGPXoKtmEv0ny4UM9LymhRbzHG1SXMzbowQEaeDLc7lihZ0kMDYR+OdEbkHHYq7it4rKMqkt/Y2ww1xPn9eDx3osOBPVPYRp5tT45HmGLDCdJaJ1ACF5CVmNgDDgr1N884wvLvmZHwFGtHCxDMj1PZvH0KgzLuFGGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272709; c=relaxed/simple;
	bh=hS1o3wNFKx2vnmveTMX3eCOlsgwQBYcrENQJm+49WtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKprhkaGlkqPrXPW3qSFYdoF0MrA7+AX8OiUpLjcDv7KsV5axysJPxIhYkb1wOffZl5dL9S2l+8GyUCI6gC+3yoZiAWR5uzmdoQhS0Z8qynvaRYEAPwXtqDAzD6xkq5of2EcQuZ1KkErIPpBp4gGSuWXwHMf5K06crAq0Zt8hVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJJRQavT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJJRQavT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff62f96b10so4238296a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745272707; x=1745877507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppEhzGTJ1895vVIrd/yxk1GkqcslORwV/iBHx5nBBw0=;
        b=IJJRQavTTaWcA4u71k/5b+Sv5G+y/pC/QpGYF59x38bP9aSfNSd6Sbxey6g6O7Drsk
         jHpwvJt9mVPB1ClRtUKfA7OTzX3a/cbsx1y4XJdSVRNVV6hh2wkXxCp4dV0Ve60tGGqu
         we2rFn7bOpKSCVDzd4CmPv3RHihMt+l0ZS/42xuL9kvd/+hc83BMpzreqtZA+UafCUaj
         Pru82iBeDE+0BGL6jMigR6B6MvQTs4FgZIMapo6j99n/864PEDcwGp5tt5M4yQPs0MRP
         wdx6SAACdbbb0WLoyGyoLkukfdGmv3V7cVOa4XvLlT65p7zunJwZI3kuYDn/5AKWCkCU
         ikVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745272707; x=1745877507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppEhzGTJ1895vVIrd/yxk1GkqcslORwV/iBHx5nBBw0=;
        b=BYsbUITxA6Yk6KBuK/hswJeRqmA6Ew50SojWcPES1XNmE/j+jTMX6OfU0QpvJqeZK7
         NJJ67z2MJ+qWY/B7uIIMJvpds+Gsna+gY8gaY1gjwhlVAhizI62SUwGbDLfsHRUcg7y/
         NyTo5DnVO/ByT6V+1H/UKZBBsqvq8ep9usLeCPt0X3+FseeU7EWq0H6uKmmjcAEFLACp
         77ob3EiDcJPuZ1b5cnmfG+DgFmxCuhpyrMuERM0XratOpychlAMsEMX2iH34OjsNEUwo
         MdHgN3mZrvbcaw2yfz++NlfZgUugVAicCzFL0DC/Nl2FBCAYyzhw5Nx3pz9W4UBxBrej
         NhIw==
X-Forwarded-Encrypted: i=1; AJvYcCWVC9gKWltn3HI5dVuN0uF1CAJqNGeAfFZCqEeWjA3H4bsQ9neEVb/raUhlOwP6haTj+sjE3xsp3uXeN+naBvom@vger.kernel.org
X-Gm-Message-State: AOJu0YyUP3SXZYcX/pl3fxCqBgcJgeZJukvpYVuXZBXArd9WcBQIy8ST
	2257l42CPlsSGW4nzqg+onteOwfpWULCHW2oRPaoBj5DY7myE3dFj5D/sooHr67eRuTqN7tQ5Zf
	H
X-Google-Smtp-Source: AGHT+IEUjbbR7dOsTbPRk4tKnHc0lJD5Lp9uelQGasXEqv+mLjMNCHnAVBHz9WrQmMThkR2ExG51pC8JdTg=
X-Received: from pjbnb11.prod.google.com ([2002:a17:90b:35cb:b0:2fc:201d:6026])
 (user=yabinc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5826:b0:2fe:93be:7c9d
 with SMTP id 98e67ed59e1d1-3087c2ca5a2mr18673508a91.7.1745272707042; Mon, 21
 Apr 2025 14:58:27 -0700 (PDT)
Date: Mon, 21 Apr 2025 14:58:17 -0700
In-Reply-To: <20250421215818.3800081-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250421215818.3800081-1-yabinc@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250421215818.3800081-2-yabinc@google.com>
Subject: [PATCH 1/2] perf: Allow non-contiguous AUX buffer pages via PMU capability
From: Yabin Cui <yabinc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

For PMUs like ARM ETM/ETE, contiguous AUX buffers are unnecessary
and increase memory fragmentation.

This patch introduces PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES, allowing
PMUs to request non-contiguous pages for their AUX buffers.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 include/linux/perf_event.h  | 1 +
 kernel/events/ring_buffer.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0069ba6866a4..26ca35d6a9f2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -301,6 +301,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 #define PERF_PMU_CAP_AUX_PAUSE			0x0200
+#define PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES	0x0400
 
 /**
  * pmu::scope
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 5130b119d0ae..87f42f4e8edc 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -710,6 +710,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		max_order = ilog2(nr_pages);
 		watermark = 0;
 	}
+	/*
+	 * When the PMU doesn't prefer contiguous AUX buffer pages, favor
+	 * low-order allocations to reduce memory fragmentation.
+	 */
+	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES)
+		max_order = 0;
 
 	/*
 	 * kcalloc_node() is unable to allocate buffer if the size is larger
-- 
2.49.0.805.g082f7c87e0-goog


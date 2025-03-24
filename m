Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E251267391
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837593; cv=none; b=pNnGMFdPCPzdq9MizDXYnV7IMGqyuO0tpBjNgyHA51bWeEMR22iyJ7QMRmhiqeYzMNEXAXZpYMRlW09LHDxWH9YED+KO17fkXtZvwAwTEMB2NwQoS4KtjVoFr5VzypD89UeE6J4dBi4Y41/kzA4VQDhGgyvuq6NLUeY0aua4Uug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837593; c=relaxed/simple;
	bh=aKPDqW/NC3IvupYuKRIdymXqUgDQVOkH4kyaS7aodbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U+6ytzrq+NpvVX9+8tdOS0AibKT5VfI/3p0iSvEMjMPCC/4Ks/rNunuUqoIQDNHu9dDct7HgJQpJeixZW0WeRZ5QZgcG+hrGkTjPlEmVQVjF/vBZdxbj8o/BmzOQOaFKIFtHsV+0TRbPGIANvGgV1kQDIxrJMh4KWHhTk3s9M40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lqrla69f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lqrla69f"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso12476533a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837591; x=1743442391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PnRSUNVr3rnNCPEtvYKiZWXoNmnUmRmeili7I7gz5MU=;
        b=Lqrla69fQi/OIOipNCmy6MYeX8iAbsZZbwtbh3UzxcB5h37hLVOUsnNr6i2ajr6umc
         tloDyA/gygXfU4fO1nsS0W/ppTjTITuyxGGNj5nejn/0UDfl0q42GqEVdbZONH5y/sHP
         OsEvKAbrUnUad3bAPeQkp2oRn+pL1QIya7hiJNVFD7Hdy4wfXbaJk6oqDtNHmeR22Zpm
         PF8r45BL+Eqz+qZWzQi7dw/4vVUROUqTjSnQ1BfHDNL4RwvZVl4CqZOGoB4TCRcKcu8z
         /XWSvrnQK3DLcEpYo6dvAapn/H2p/9Oj4MExjpCF0my9L7JRd+nbQd7BK34oVR4o5O0A
         bj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837591; x=1743442391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnRSUNVr3rnNCPEtvYKiZWXoNmnUmRmeili7I7gz5MU=;
        b=OoD+r1b+fQSIh42AgSME2rdzQmZhI4AMPu5AiWRVQPhGrcU3s9oGRb+aaoibTHBbZZ
         NK84QBO6ddTPw8+5cXTcysrQEDDPuOsLWi6LwxoxMWv/vt4rgMfmr9SjWIJYqsJyzcNL
         cFfXheIkHvfBokkXB9iLg0ScOFPivphp81y8QuqNCEibEHrZD7x9po8xByLUeT2YNVlM
         OPmBRRvM42crmeq6ncV2XrbSF+/5wPm4dba4P9eMvyDtuyb7faAmsI8XWWGBBZnkg88r
         Ij4zXUKJR5FvFi/dQsgAm8B2dmyQP3LyeCL49zkD0nrMLZ3SsoUnNd2PviteGuI7dRKX
         Af9w==
X-Forwarded-Encrypted: i=1; AJvYcCXMlCzWHdvidTx/d9vQ8SbrJiZsyh7iCdBr+tchPL0wA/51+1crEegLzpvI4m/h1rqVIkiDLWgOvGoQD3eeMaDV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4FptPnXpWkA1PxkI6tafGEWULzl4kekj3NePb9kS04rgHcK0C
	ocirIvdpoMGiclI9qccRQ3kVWRWWXnPhIUiyKyuvD06GUhI3d29yn2eo86Xlz9dHVTUdw4vKq5x
	X/qHOgA==
X-Google-Smtp-Source: AGHT+IEW+7GJcDXGG6CURiKG3q1Lc5zKORtSrc56gB/zRY+t9aZM8BPwlqJUyaIgVCLGS/H1C2BVYJ2TtCKc
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:2ff:5f6a:835c])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcc:b0:2f4:434d:c7ed
 with SMTP id 98e67ed59e1d1-3030fea7d0cmr26492841a91.16.1742837591632; Mon, 24
 Mar 2025 10:33:11 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:52 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-13-mizhang@google.com>
Subject: [PATCH v4 12/38] perf/x86/core: Do not set bit width for unavailable counters
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Sandipan Das <sandipan.das@amd.com>

Not all x86 processors have fixed counters. It may also be the case that
a processor has only fixed counters and no general-purpose counters. Set
the bit widths corresponding to each counter type only if such counters
are available.

Fixes: b3d9468a8bd2 ("perf, x86: Expose perf capability to other modules")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 96a173bbbec2..7c852ee3e217 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3107,8 +3107,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->version		= x86_pmu.version;
 	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	= x86_pmu.cntval_bits;
-	cap->bit_width_fixed	= x86_pmu.cntval_bits;
+	cap->bit_width_gp	= cap->num_counters_gp ? x86_pmu.cntval_bits : 0;
+	cap->bit_width_fixed	= cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
-- 
2.49.0.395.g12beb8f557-goog


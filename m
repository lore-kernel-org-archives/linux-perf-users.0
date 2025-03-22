Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CC18C006
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625275; cv=none; b=UORzA2ED/mZAHR5tTti9qfM+clcEJJ+F1JyJOL3+5TGudrX2C7aT71OjFyeUSJ+i/8rspG4/p6tRu1OyO1PiAqX33rn3EKX1tSa/BUU9KV6kPVjMQGFRhsKr/6LlkyppCqqQ1EDUQac5qd57lU79WCW7OEO0GRTGCbvMcpeTvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625275; c=relaxed/simple;
	bh=gzOhUwuk6PRtqJT004lFT8JmHmf233ItpyrfAz7UByY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k10YtizsLseBMWYVU5qwdCCZPvup3TrEWf9LsmoWsXn0lD/tBfPdPUpxaQT61Tso/kxaLwrx/7VmE2D8JCxdZReeA0qf4o8FPWMnEQYFWrCKGNtc8oKpRGXFBNYD6e/0Hi3iTrI/tAfFeJ6EiqqAOmTNu1R9k7XNfIEYHXxpFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sv6SlrbF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sv6SlrbF"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2a2ab50f6so32986757b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625273; x=1743230073; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=sv6SlrbFrg8iuKV2ImtsDiRkbo5I0frBUahs3rqDpU//h9PfU79oH+njG7RjVXHVoQ
         wiLIMEJYhOn6KKhv5oQDSa/erO3gkWoDZF0YOJhQ8OggUlOjOqJK0Kd6hMuMbtKCyEHk
         b2sS4ALe7vzj/OirNchS4NyKBMm17VvnaAPJ43ZQ4eZjCwtvVJfGG6P1MMObAMy27lDI
         BDa2tbBdIv6peaRLl8w3tuxfQhckaeCm9E67a8jKTfo0Ziqy1B8wY4TvpiMfUpJ9SaU9
         osjGK6/DRMto1ohTVxp+P8iegL2EUIQcJQMTmukPHK6dwIxLP973KHvvFyjv8AoNmmvs
         8Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625273; x=1743230073;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=DFBRUAJgJ1Slr4To2popWAInSQ9UAQagg6/5fR+Oc1bZc5w6A5bUpNBOx7OPGhb3Gn
         NzwezmILa5tG5EEYqdA73FSDmiP+h8N76KJydCaOxtUaFb+9xE0F2JQDwNmkyKHu9uTF
         wStxSmPgqzC6XFujCN4FqqBDnl2155ZNgCElLFjLSwSmydCEbURVM3kKm8Lq89z8/waI
         oRo1eukegr1D8BvW1C9L4b4s/pbGA8Ddoi4BjeBqLwwEdpUtJOjML/iX3S8Ee9re0U/2
         WwV86XlM+ce9efY1fuiaHuyoxwTDPGvjejvAb6OWI1dxTWDRA4dEmkEui8OfA8Ruapzi
         vfXw==
X-Forwarded-Encrypted: i=1; AJvYcCVs7/9YtEmAmyGWvtWRqrYfmPj510SB7LyGZgUwB+e0rin/0/ZcrPM+KoppIOfTCVCETnFnhHbY6xYUcwa/mkTM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9MCQE5NtTre3xD9ruF/Gq3I8zJ9HmTHxAw+dHXN7RwgT2zQV
	7XfYX/vqP9LxJ32sRHRI9byCpwvNnzGUyutTdFV3wQ9HjNle2Ifqe/pTwAbhOZ2QmqIrsy9W2ky
	1XONWbg==
X-Google-Smtp-Source: AGHT+IGoRZBLAATkk6CrzIJdrb/6KBcOQJLgFpEERB3mzffVqwH52k6KG5j1d1MvINvdpWH0bTkiN2xUQGvg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a81:a844:0:b0:6f9:8797:a245 with SMTP id
 00721157ae682-700baced0a6mr29167b3.3.1742625272412; Fri, 21 Mar 2025 23:34:32
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:32 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 04/35] perf vendor events: Update bonnell events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move DISPATCH_BLOCKED.ANY to the pipeline topic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/bonnell/other.json    | 8 --------
 tools/perf/pmu-events/arch/x86/bonnell/pipeline.json | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/bonnell/other.json b/tools/perf/pmu-events/arch/x86/bonnell/other.json
index 3a55c101fbf7..6e6f64b96834 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/other.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/other.json
@@ -323,14 +323,6 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x2"
     },
-    {
-        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason",
-        "Counter": "0,1",
-        "EventCode": "0x9",
-        "EventName": "DISPATCH_BLOCKED.ANY",
-        "SampleAfterValue": "200000",
-        "UMask": "0x20"
-    },
     {
         "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
         "Counter": "0,1",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
index 9ff032ab11e2..48d3d053a369 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
@@ -211,6 +211,14 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason",
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "DISPATCH_BLOCKED.ANY",
+        "SampleAfterValue": "200000",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Divide operations retired",
         "Counter": "0,1",
-- 
2.49.0.395.g12beb8f557-goog


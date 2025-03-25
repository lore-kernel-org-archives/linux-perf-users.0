Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8D263F59
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925865; cv=none; b=JMtt/k1tf56OlgWq8WbwAyjbWzHasi1JWE2WEBtdZdpV9lfnLZgPVjYIIC3R6WSqTjX331+iKQas61IPfQ9QHOrUB/IEiFVmJSXDoj9GHh0SD3A5jpKFJIWj3WKX3YgclP0br5S1LVmL9iR6nFVEnQodgGfVhUNHwRvaa9nZK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925865; c=relaxed/simple;
	bh=gzOhUwuk6PRtqJT004lFT8JmHmf233ItpyrfAz7UByY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=K6lEbH47sS6trd7+I0jYj58fai9E/hX47trtdSHQ+Tu3elQbM+zwnxYiN4YWL/3IrqUrmLAaSZnFUGMcNOy1lLxfuDlXhtMVn8RCRxlT56y34tAviqrt10RZUTwLFcW4nA0equXbir8/qX7BDIZOj3QLlbcwEO82PbqYymwv01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTQY09sk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTQY09sk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ff0be1cedfso58742847b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742925862; x=1743530662; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=OTQY09skPOgs/OZ+dqEFTUqb/7FFv9tEDewY9sU/ay5HVhIwVEV+HBbOe33VcgOabG
         9ZLGu5e3wTvTLPvaQ3H9/jmxqZvxXdcDW/BiINQr9mi+jUctL1DqN2/n6SBsUzRQK8Nm
         3bEyk/1yFQWDbB02K5War90HtEDn05LntOwDo0fiWVKaqJMVWCKBqdoOeqCnzdeSq4eF
         4rb+95cukMv9fgUJmTisJDJ3pdWxeOyvSY/NLyOCGJ3VZFB5EhdenJr4leFjS+ojjCz4
         XNuZFVHPrdbzD+RMeVx2WfdbZJyb/wSVm0EC3dBBA8itvz1hcQ8Iqxmg95Iq5tHO9Ktj
         JPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925862; x=1743530662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=rd3A2Of2vmUXDNzqvlkt4QOeEYiVdjsDuMbrM5U7Ul7OM2k53TeWRuqtYTxUB2IgJ8
         d1G7WFlUMuUL4hGjqSYV/FjUxxgFU5B/zafr0Ps11J7bjBMeMlPyA9ZeZDqQn91BNxcq
         jLFoP48oPWDRej8NkLOz4KRoFEJc8+lThBPHFuvIHSQLt1Hn0jGDJC2DBOOSGpDdZQy2
         gfsN1C+5wKWBVpCye4o24Cw6maX1OuR8JwYL6Jr9dXFKQcZ1BmzVNBy2R2flOtgnGHzT
         zi4ZCwmHBN96++rjD6BDnYOMrVIGM87t6bySS4J+qm0bK9IYs//Bj87Zn71rs/si7YTm
         JGZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+xVhrtzwc/Y1H22hDB8YlodZ6lzDuP0ILGSf3oYwDK40N2P26GA7MmMAJueSjEFQ7Q4MElMklwXRM8S6bL1j0@vger.kernel.org
X-Gm-Message-State: AOJu0YwrevWi2TaFY71Dhnhw13HTdoE5UNEyi7FAii4jI8c2uv07Jous
	Wt+m9icfDSIkfrqjVU2026tTuMRl057MqOfmyuefJfwD+QVdfqNdbYKJtZAkXwbDfeYp7GOyo5c
	4iqeyXw==
X-Google-Smtp-Source: AGHT+IF9YyhxapdXHQGbuCilvl5dw4vLR/qivzVgJCU64mtJ0pTHlLiz6AT33fpup5E3o2UqI4xlMfSVJqTk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a05:690c:62c7:b0:6ee:3fb4:45b9 with SMTP
 id 00721157ae682-700bad0e08amr891617b3.4.1742925862538; Tue, 25 Mar 2025
 11:04:22 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:52:06 -0700
In-Reply-To: <20250325175238.50097-1-irogers@google.com>
Message-Id: <20250325175238.50097-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325175238.50097-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v3 04/35] perf vendor events: Update bonnell events
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


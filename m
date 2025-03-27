Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EA1E1E00
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114226; cv=none; b=K31kpQvroZfYTBaB7x0thcFBBUw0kyszVQUbL0vevD7E7EugsTQcJ8KFnUJTcoL0oxkWSuPTjue0FVug+4FgM/V+IOoSroU/POYjNg+d5wjO6f2kzrqSYnzeku/gaty+ualNbxdbnaWFm8LtviZIocckSn0jwObpPaQEn5agpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114226; c=relaxed/simple;
	bh=AffUvX5zCf3cTK5MurocInrFSdTsN2HgHiDhp4hyhbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bgyWKcLywpGi5WdwI97bZk+Yph/Kmi+0OSH4rc/ZfsYnFXHffWZCrO4I0XjkrYFpDomp5n2CjCSPdjkRvepmdaoJ2hbxnQckQXZdm+3qC0QrYQtHL6yzTMbM9EtIBPNGW+/L73C5UXYIiBWaqewyPAGPqrDnfMjZkUAihpbdvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUXHT05R; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUXHT05R"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso1209974a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114224; x=1743719024; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHRIwyWsa80ZRekjr2RJmtN6YQau949Rv9N62LCMjWs=;
        b=QUXHT05R1sgqE57T8wegJ4tJ6EmgAiUA6+RnZlU+rXUhAzo+DK06BKspqf5ZsfGxCJ
         ikViI3oC/sOrElaL8oFvJ/vHP9tdPhRNWUfo+U7sBMIbfrR/tZyiiUOyLtWig7vI4rKv
         fplrPbPRwlIizZehJkwQauEsh12QfwhHULZsiA+zEISiu0FQIunOXEd1SN4T00axI/um
         FGAnArliFEiMcIiI+fEUAjk6nrRdAZV+fk9K0auK1r6l2099BpKY563skv7N2tGKbhQk
         GUHI6EBOXIeSHQ7B2HF+HVk1UTxp+7pWn7e046zpWHvdYrIrIssTFDhkQN+o2iZpG7OZ
         CsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114224; x=1743719024;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHRIwyWsa80ZRekjr2RJmtN6YQau949Rv9N62LCMjWs=;
        b=aTz+6eX5Je2jyk4oX5kP89giQ+Qr+p9ZUg7WilfO64TIdgUO9EDv7I1EGYC/TyN1nA
         5o7dJjgc7tmvad+Nq7l/axzeNPSjCf3PO8ygFREFGz42kZvvlL4uOb87vK8NVw8ymxij
         udG+nB8Dpcm6AKRkNTaqAE532gydzEo9yHHSXjVL2NOvs0SUUSCD94MpArDWr1dESinP
         lNipHHIG5fshP2p/KZcSrpRsAGtq8E/dFBKKb8H5gFb3ro5gh7zJkW23e45/n6QH27VD
         ikvwuSykc9XC5Bh414tG9ixoXBss4Dmu5bIVUPQfaZwtcy9tWD772VoUX/IdywuCbStB
         XItg==
X-Forwarded-Encrypted: i=1; AJvYcCWgLfmXx9V3yoIGFyQQjWdQI7hHm0XsiEXiy2ac5Nglr6bSgts6EVmh9oPD6bnoK1DFn0CdUOB1sazA4emm6Prn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ruopdxhT0wprirtdVNSBlD41Qr+P+uA729DbLiyZEvoJDwVL
	N6Om861zVuUfwIT5MZRWbfRQ+6Q4SNJXXq0T9BAe2ChVONLzkM54cdY40pEyzX24d7SkeKry0u0
	+lttS3w==
X-Google-Smtp-Source: AGHT+IFoV579FcedX2l2PVH98xzRHLzrsOnrlswi0dollhtO2FNEKoxtBM1uwhkCYPZVGMpNZ2rkbNVQqBO8
X-Received: from pjbnw9.prod.google.com ([2002:a17:90b:2549:b0:301:1bf5:2f07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c4:b0:2ee:9b2c:3253
 with SMTP id 98e67ed59e1d1-303a9192f68mr5654319a91.30.1743114223890; Thu, 27
 Mar 2025 15:23:43 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:22:59 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-5-irogers@google.com>
Subject: [PATCH v4 04/35] perf vendor events: Update bonnell events
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
2.49.0.472.ge94155a9ec-goog


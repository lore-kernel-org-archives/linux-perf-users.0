Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2E31DE3DF
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184234; cv=none; b=V69S/JvWyWGkqtLDDLpYif9nomw09hAO+NEfiG6CyJdZV9YO7qY/xe5jOeLejV1Yk+/qiTYDHFRroPPUCol6rY2DVqTzwNwWPn/QswBhsa4Yjp7v48PJ9q+qkZmF49UadNtFB11IiYDq0LHn/cJcXtDvNAemv87/9FzyBrN70U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184234; c=relaxed/simple;
	bh=AffUvX5zCf3cTK5MurocInrFSdTsN2HgHiDhp4hyhbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=amWe/3LV8Uq3FWborblTENInblCTmIPkzRV+u41YApOYHdGbETJWJI5kWG2WsCShh4LiY4rx5E2YZtOxMdN4/021qGfczDkKUFAIOgVkgANqTTb+5h18ZU3+kQCijV9pYP25F1Xp8ChacpYbbYfIv/Pu/OuZz6kPSnqq6S0fTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0TEB1Zb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0TEB1Zb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2255ae39f8fso64197375ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184231; x=1743789031; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHRIwyWsa80ZRekjr2RJmtN6YQau949Rv9N62LCMjWs=;
        b=q0TEB1ZbNLyxzUwrfrO1KZ6k/LdwGuwwYCccAmL06AXsDJ9Q176qPdyS7yNAboryFP
         VJqejBKG2Lqr8DyRuXCiGE1tk9UoE+AJdAbW/ZECe4FnV3EnD1TW4Dx5Qo4Zi3iZuw66
         PIkByzlOy/WGkypRGreSx+wmL18ihfhQQKnvLwnaZ0QgIOOxvXJsbC+5fH5iaew2ymeE
         gZkpeoWG/arrH0vR+wS+39t8UMahDRCtzwjsG4UOaD8Y7jUcNv4occrcmEB3D6wogZds
         WGR/G/xyUxhbgeaZjmrfkReoyk6EyOPTJHIDWQXQe02pGtCn927+HnYhS+ReXXGwv1q7
         65Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184231; x=1743789031;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHRIwyWsa80ZRekjr2RJmtN6YQau949Rv9N62LCMjWs=;
        b=Nmij3VI6BwV+BlG0IDMe/sOowHq8HQGYNo0bt7ejvQcLSDmlzjGbv29qHBHAcDapN+
         TTgxGe8liB11AGOn2oG3SjvlzIrxvfIUCuPOwIH5WokZAL88mDWi/fI1qngdng6/Xs4B
         v/aAmvvTgsjB0eyK2tuyb382tlrQKZ+L8XACG0G19rm0CRfTFIkyEdZwpiNxD+dABZri
         2KwxXTrnBcQokIVKbCDAy6IUg5SQqgO80noQhXU3S3hhwNP2SwO/JZUYk1ovHVqdQQRf
         g/Xdem/AoqgvvPgnR6XyI8tSDKASq+yD6DSkQK6PnsNrQzryyea8gR5TKhJYbSGbIIQK
         WVIw==
X-Forwarded-Encrypted: i=1; AJvYcCURjviAdWvErse/SAueU22FGSMDh7WJF/YbahLox9F78eajtZXPON/VPC/dAgo2roXXk5u+gzdK6cUoo88+SXrT@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5ynOWHocXG3gZBv0lioutOEdpfxOUdZvkahpgz0Sy4mGj6qb
	uq3DgKeIEMGmCwsFx/aS258WUxUHUYhnz1SDdsprQYZbeUR3GP3snXSpsybgT2izgsOTYmP2m0R
	+N10DmA==
X-Google-Smtp-Source: AGHT+IHXX9CHvyBCwYOYik7gynV31+D+OMm2FocfcuYeVBZQM0k4OAxEWLRIYK9HNo74ifHhLHKlj+raooHJ
X-Received: from pfwz40.prod.google.com ([2002:a05:6a00:1da8:b0:737:79:e096])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2918:b0:736:5813:8c46
 with SMTP id d2e1a72fcca58-7397271aadcmr6325365b3a.8.1743184231422; Fri, 28
 Mar 2025 10:50:31 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:35 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-5-irogers@google.com>
Subject: [PATCH v5 04/35] perf vendor events: Update bonnell events
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


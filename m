Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F579D8
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873523; cv=none; b=Mz046ZndaSG/aRVTDpmCq1BjgA0fIwpIMG6/18IYGboR/9D1lzxB+juT5rHcwJN2r8cyqSVXexYFB//FYPgQobcxtAF/X4CghjGWrZ+edZ3E8y6ksqQxfiCRPfhlXPYOLVF8cPexW0cnNBWh5Hdlkyt9+HPzhgN2FI/HKZcZUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873523; c=relaxed/simple;
	bh=Y9bNWts54qF24481TKf8WJPwGJz0WIcwE+VErux7wGk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=iNiPUtaeXSKxdNbhDVrwC1PYe4qMcFCYzgrPopr/HsEMecV9ctXXafDKakgAdf+Bxq/KfZpYKwmWPz+xhBKpA+kj7hs6Z1MuHEZDg2hZoi6wX/Q61hKOBnLSV5+MGnvQQnPu2MlEcZ5vCGVFwYZz0NAONnxhcAD1jCgmnfboU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgLQpxTo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgLQpxTo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60790eb0f8fso19184527b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2024 17:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707873521; x=1708478321; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0y5+5SSHhOjDyALGXDEJSsmAPqLoelaAkrXUU7aDhqc=;
        b=jgLQpxTo8MymXq1AxPyn15egu8csYqbcO2PmL6OcWhyIU3AzFdn8nDMACYGuP0kOMz
         P8hPvJg0VY1zdvzvKEF0bccGhcqQm5C8dxuMoAfo9NiS0kbwadbfMBALK86wq5jWNRCy
         ePA8lpNUJYqneAIXC1h/EDICv5uu+rYZHE9TeDMsBIBpaZUT3vB8wpTM6vb3TSNKbuPZ
         vlF6pqEuFFQb0m6WqqBHstl7EVZQH3KzOpmis5erx4b3IppV2Om7ySweOe0RzqYXfAvn
         YqaguXDCFjZPPM5S6uAucoztbtEWKxR7yg4CPy82An/7BLC9WUrR5Xo+E9qO4sNRTMHC
         4Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873521; x=1708478321;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0y5+5SSHhOjDyALGXDEJSsmAPqLoelaAkrXUU7aDhqc=;
        b=uxjWuuwOlFf2tPB8qhG3iA4kIJFBGGh81fyNtaKG0o92fs01fd8bDD3i7uM+bXJKZl
         ppzv0lKicLtbThF0GnYmcAUiLAKNe5lxJRRX3ILvOp9QTktzGP4yYccuEJF6BIr6KeIU
         z1G/VzCYsQCPDMwAWuUVH5Azp8/Z/Y5pMrezgP+6+G7Hxzki4BtwEiwEshWWNhE5dpR0
         GgDbTvjqhZ0G41Q1Ix/2ylE83O/L4Iysmy18ULuhZcrmT8a7nMHdaRTvArPPzemZ8kAu
         T1gH3pthaUKRewybC4CT/5krReqohywRQWsErPq94EaOY1i0dKleb9Itj37OhzKggiAV
         OvYA==
X-Forwarded-Encrypted: i=1; AJvYcCWGh3pCMLmIASKGamu7+GjiZUeDekfarwzzPnv03Nx0fQK6Wyz5jeG3xTO/sPGteKkaG/ai793v/R2MQmG+GgL2tdNLH1GZhTYC4e9HbIyxbg==
X-Gm-Message-State: AOJu0YwK5qFIU1pS45tOes9vWAOjKWxSQMbbmhlx07oHB3vWAGyeZWjj
	E5pbwW71jxPxJi9nWutCsBp31ladaYm54LLow3KhBF2CGaV6K8MEXEMG4gd3gn4SApaf/EQpwwN
	Ao6cYQQ==
X-Google-Smtp-Source: AGHT+IGqmAaMsFQkYOWmx0yz4BgEBxxzP2wbypzVJh1CZLdByws1pG7kNOw8eiqZgKc5ox4Z8N8yKeAiycFj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a0d:eb16:0:b0:607:9963:2dd4 with SMTP id
 u22-20020a0deb16000000b0060799632dd4mr258831ywe.9.1707873521081; Tue, 13 Feb
 2024 17:18:41 -0800 (PST)
Date: Tue, 13 Feb 2024 17:17:51 -0800
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
Message-Id: <20240214011820.644458-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214011820.644458-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 02/30] perf vendor events intel: Update alderlaken events
 to v1.24
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Update alderlaken events to v1.24 released in:
https://github.com/intel/perfmon/commit/e627dd8d89e2d2110f1d499608dd6f37aae37a8c

Adds LBR_INSERTS.ANY/MISC_RETIRED.LBR_INSERTS event.

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlaken/other.json    | 9 +++++++++
 tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json | 9 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv              | 2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/other.json b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
index 6336de61f628..ccc892149dbe 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "This event is deprecated. [This event is alias to MISC_RETIRED.LBR_INSERTS]",
+        "Deprecated": "1",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and L2 cache that have any type of response.",
         "EventCode": "0xB7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index 3153bab527a9..846bcdafca6d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -344,6 +344,15 @@
         "SampleAfterValue": "20003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of LBR entries recorded. Requires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to LBR_INSERTS.ANY]",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PEBS": "1",
+        "PublicDescription": "Counts the number of LBR entries recorded. Requires LBRs to be enabled in IA32_LBR_CTL. This event is PDIR on GP0 and NPEBS on all other GPs [This event is alias to LBR_INSERTS.ANY]",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of issue slots not consumed by the backend due to a micro-sequencer (MS) scoreboard, which stalls the front-end from issuing from the UROM until a specified older uop retires.",
         "EventCode": "0x75",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index b4adaa1b5e9e..5bda5d498841 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.24,alderlake,core
-GenuineIntel-6-BE,v1.23,alderlaken,core
+GenuineIntel-6-BE,v1.24,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v28,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
-- 
2.43.0.687.g38aa6559b0-goog


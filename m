Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186B1F4164
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184304; cv=none; b=cspz2i7hIT/462w2gv0a9TxN6UuTVtY9/9HRgKR7Of0s313/ZJR9v9y4OBDehR7EqBD1NxB1bh6R10cO/kKw8zzQW2zWpuD3bnbR0Q48NxsNdvjXaPXwEG5tk3RtEMMTjlx3Xx7EJCg6Gu6zx72lAm52y0YWZsvcMHTn2Tg1J5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184304; c=relaxed/simple;
	bh=rEKsyl5VeXsQYB6M9jGct7xgL9z+rZvIbO9f2wNkGrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J8pRza5b9SwSoGxUHx2iKiN7YE28xgTjT3CD5KrMhc+d+5Ej7ShxdK88EIqSaXypRcKYX+ht7ghcG73hz+GshhJHvrqTYE+q8DuMsBCm4eHlbHptvE4dje/chGAUfJ0wI3sFkZnsDGAvTkZPSM06uI+aIIHWHQLYQuHEkqcXgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRQ/EemB; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRQ/EemB"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c2545da7b6so3206600fac.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184293; x=1743789093; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlkA6u2yJZ2VVf9mufqU92QMT0mRmr2z4j7mWj8ghPE=;
        b=lRQ/EemB7a9dNxVC3yxPdx3gRgt95mcfXMMW+UVxHjcDQZR+MeG3F14BbJMoKWhsIS
         qBVM8y9yXmUmQDcuWSUnNbs+ZpUFolBx774XK+GcfweBruOrDpLjN7/AWdFGZXNFega+
         knVbc5eV0aytDHby0N7uxIvME08w9AG3TMdvIv+12iSoYUdVbHq2wlR+/h6mP8babPKN
         u7qR6VgrwlhingDIbsaUJA6llJ5i51hxqGrj6earydTakxq8Qh2phm0LJLL30uPQTPpT
         Bqx7CSdCpY+ZcZ/SVBbiDaiGOH8i+cbTAEEOoPsTkYiKmuABy0t2IqmqySMYGWBMkIT6
         MeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184293; x=1743789093;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlkA6u2yJZ2VVf9mufqU92QMT0mRmr2z4j7mWj8ghPE=;
        b=kC8Ju7hNN4KIj0KPyxKcHsh49gUJpiZy4McdUlEoOkdGzLE6+qhUpVHQahsrtuEiB3
         aKSoAS3VdNiL7urZSJIuOqVhOrLu0LyV88qW9SczlCMtxIbY5/YOWEs7MYQum7PL/rzn
         EnzAlW6djNRV3la/DVR/fiu3te38Ia+cKMbdp+PboWdLyrLC+LZCSUP/nt5dhJxigpqS
         vEzueGdhATlcSj5jh82N2Yed8j0XH5zpR7xrjI5FSUkEwNweagGoE4d0d7ao18oTczuf
         y5Ojg0WPaxXJ5Nk2xiLkYKY01MjvYBJH9Rc0JEb8R2c5hxr7WfuidEp8dvV2Yg5XXLLV
         ssRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTzuqKH6/7JTwzmfHQTz5nB1LHn0L3/rk+5VoQGFi99tfdqPX+yknJ+0In9k6oJ39DkMpBxxsgmuJ/NrXG5Xve@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhv4wMpDKwaPCjDnZ/7C0eLXLUF17GUYQr3YkoI41WkXZb2B/5
	K5mvDrTTw+yP4anz0OS4b9dCv+phaa0wbnnl+ihR1e6UHtFti+f1G4FObN5pDBw035vVfB41vn6
	v+gDYGg==
X-Google-Smtp-Source: AGHT+IGHF+O1EpbLFR/rFZ08lwaps+o4Ek5lPHmdTnPHmxvT1Vi495VS4ksktcPS6ErFHrfbIW8+unaT6FGg
X-Received: from oaen1.prod.google.com ([2002:a05:6870:8201:b0:29d:f69c:1743])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:809:b0:29d:c6dd:cc6c
 with SMTP id 586e51a60fabf-2cbcdf6ada5mr316904fac.15.1743184293587; Fri, 28
 Mar 2025 10:51:33 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:50:04 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-34-irogers@google.com>
Subject: [PATCH v5 33/35] perf vendor events: Update westmereep-dp events
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

Update event topic moving other topic events to cache and virtual
memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/westmereep-dp/cache.json         | 32 +++++++++++++++
 .../arch/x86/westmereep-dp/other.json         | 40 -------------------
 .../x86/westmereep-dp/virtual-memory.json     |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
index 30845c7dbf08..f6f95f3ff301 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
@@ -119,6 +119,38 @@
         "SampleAfterValue": "100000",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "L1I instruction fetch stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.CYCLES_STALLED",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch hits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.HITS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch misses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.MISSES",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "L1I Instruction fetches",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.READS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "All L2 data requests",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
index bcf5bcf637c0..c0cf8bae8074 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
@@ -15,46 +15,6 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "L1I instruction fetch stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.CYCLES_STALLED",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch hits",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.HITS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch misses",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.MISSES",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "L1I Instruction fetches",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.READS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x3"
-    },
-    {
-        "BriefDescription": "Large ITLB hit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x82",
-        "EventName": "LARGE_ITLB.HIT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Loads that partially overlap an earlier store",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
index 53d7f76325a3..84c920637b12 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
@@ -152,6 +152,14 @@
         "SampleAfterValue": "200000",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Large ITLB hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "LARGE_ITLB.HIT",
+        "SampleAfterValue": "200000",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Retired loads that miss the DTLB (Precise Event)",
         "Counter": "0,1,2,3",
-- 
2.49.0.472.ge94155a9ec-goog


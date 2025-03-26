Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B31286A1
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947584; cv=none; b=hxNqUhLyKHvDWQzMPglmhHpAUM+JgNTvq73qwzomGzJX7VE5gYwK1i5QebIMo4Q4OPQ0wgCLww+NPAMinrGoRU+3ID1/FZR6LW69hwusCmkFS4putHXS2F5azco5DQh1xD+aq++bQ2qkvikGJ4YbWW9js0HrOOWd5yPJZjQeeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947584; c=relaxed/simple;
	bh=jj7cgVY1dHCdbl7CToIOpx+DtAOgzXi+ZwBseYtASCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QXzuZqZKwGFNE/Wdjw13/d4RXaVdbi8a2jEAW9Z7xS0K+MiRVh4nMdj8U0ZJDvc45d9s+XlHXqUexPRNCq1NOhsNvSPx2+5/k7ZKZa79s36VHRwwDq3nE44TN90z7iAuYw8ajR6Aqshs5O4eTrRGvMBqXbg5d4k0ZlJ4oTnIcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ubqg7UTq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ubqg7UTq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30364fc706fso3294634a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947583; x=1743552383; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=Ubqg7UTq9r/Hdkk87250xpWbi7HOpyje7lAqkhYCWr3aUfGxIKht2Zio1DI+NNfWoO
         A49DBDRO/UVeJyxzoltRyhnRahUC7zava/5v/30JMUWMLmgDQgAcCz+cImgURcha1QY5
         1BDpGaMKFR9U3SJ3Q4bErQffH8GTvDhstr8D2FwAidT3aJUAHGk542EVu/YJhEIccfVN
         jiivm4s2VkEV0f6cf/ZOWFRD8+6821NAv0mOKNdXkOLIwmbHDD3nx4Bi61uXo2k5TP01
         uNsHwHoIXpcr+cujXcvTl5GfXSTgVQ19JFzm2n95iaCDygm9coRYz1PWrfsP6JD+JUrB
         2yQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947583; x=1743552383;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=bfhUW6Jq6TEOXTHbBJ/dw0fWe2j0/TqotaWlDcH2iKXCAq3xfY0TymveWKuNyaxZY/
         pzfagFjwXK/SpZ59hgw7m1yY90ogQNcPYUP8frtTNOsAxnd/mmKQkFeIPn0O5isg8nQm
         0IkKeVYYB3JlH4s4k8GhE/zU/J5GYk/GHgLDpdkpAZMz182S92AoSa2+v/U/AarqZHik
         derfslPHTB7CI+2OqYeKycuPuY2jLKw6jAUgEqDmOrwW133RlV+opZSZ/gdcLvBrdQnA
         i1DP8NjUlSdN4kJUwAnaaUw1ehQZfy3Bj9lK8On0ZN0cDIhuO8q/OFLUpCpoI1XGIDNT
         wYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVF7vPabgVufFpJMH+ZZt7XBUXRr/BId6uzpjMiJOatp9vgLqENZ1fPrz9hYxR+GgoCERf8OlvYli4fJex5X++F@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIGCYym++OGH+d3OyU86hTUNZ/k2vfvjIxkB01fjNkYTroRUJ
	lVx5LsDOiTXVusvPopH+0T5GfXE+ZBCC4jazLjwhLyOFEyq+RaHx9UPWzHW6sK8XLEx87gScboB
	vDmTi6g==
X-Google-Smtp-Source: AGHT+IEwizCIlZ2mc7buHdqoiSSOfJ7BZ84a8AqmrE27Kj7Vd7q1ky5apXKAZA8h3DcPgWfNdVvfYIQ7kII8
X-Received: from pgbdo14.prod.google.com ([2002:a05:6a02:e8e:b0:af2:48c3:360f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a92:b0:1f5:6a1a:329b
 with SMTP id adf61e73a8af0-1fe4300f787mr38309635637.32.1742947582873; Tue, 25
 Mar 2025 17:06:22 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:07 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-10-irogers@google.com>
Subject: [PATCH v3 09/35] perf vendor events: Update clearwaterforest events
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

Update event topic of OCR.DEMAND_DATA_RD.ANY_RESPONSE and
OCR.DEMAND_RFO.ANY_RESPONSE to be cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/clearwaterforest/cache.json      | 20 +++++++++++++++++
 .../arch/x86/clearwaterforest/other.json      | 22 -------------------
 2 files changed, 20 insertions(+), 22 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
index 875361b30f1d..17f8bfba56bc 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
@@ -140,5 +140,25 @@
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
deleted file mode 100644
index 80454e497f83..000000000000
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
+++ /dev/null
@@ -1,22 +0,0 @@
-[
-    {
-        "BriefDescription": "Counts demand data reads that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    }
-]
-- 
2.49.0.395.g12beb8f557-goog


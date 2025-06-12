Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B74207A
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686561; cv=none; b=l6t+vwBNUQu/V3nC3r5saUat83vzf8FthsxEpui9mhSLyl6Z8lpTyp8RKHmxhp0oF4biNV6o55AMmxsrpYoKpVBWAcTi4SuXXsTdqVeUYcnUxSv4W1gOIcoxk811SPg/gY//PDY8nQtSTBjZpXqUki6EGh22qYQN6W88iWQ4pgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686561; c=relaxed/simple;
	bh=Lc2JtIfXZmV3USXNIWX8ioxXhWowqkdZiB4vXpyFRg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ltjO70EcTBig7rIcAHjQb/qiIvTqUGWnRAjBGF051fI/kkdlpqUb+MUmyCcGXEoTRJiYaiYzRFW8tjFtQfTrMk+aHD+EKPZiYYXHWfpEXHECQXHF1L4S+XPl9lmgFTdUvr6sW2YTrH0KRIAkN9ZtItkbJNR2pzUMNDfek3eQJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLRefGJE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLRefGJE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74299055c3dso557318b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686559; x=1750291359; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kbUi/cjzpRxNlnb7nAF6rA+ZYZSCoeqQsAo52QIjAo=;
        b=uLRefGJEBAxoNvjSYlItUBrOnUx86izauuvWg9AVqx5cUPGy6NrkBNeInyCQ/FdjGT
         rcSImbENEJTh5fjkmyvk9m6bSU5umdWHrrY2xODLAfJvc5Z2Bl1fKvJQF6KM+aEacOpu
         P8GfptwQtYtpJFIohq1+LV4jeGRNu4j1PwIsxVENK/5bIoHV/xoMzUpRAeKEU5MtP/ry
         6zVCsnuM7s1ZTNpM2EihoIHV+rZ+d1kEcG2J4Y0zwI+vqAsdNiVZ4QEDGL3eEPbyxwi1
         6SC/pzwQY2GA9FBBRHGrq68Mt1mh9Tpolr4NDW/GDI5koiqpdng2jdFxpn7B5dBPmPEc
         o6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686559; x=1750291359;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/kbUi/cjzpRxNlnb7nAF6rA+ZYZSCoeqQsAo52QIjAo=;
        b=bhbmnFLqOyhyc9Yj1gEmxPziucv2dY0kNYSUQgBF14ZezS4Ek83QGyR0BUxQ8l3kNJ
         AI2y4HiADyKcq6rixqoqsWFgePMh4BAppcvaTPa3rHTzklhOoN4+HJ713uepkAg9GR+G
         oSWWkiWAPSb8YKq7IvM7J8I8GW9CPnj/S3uXAdSKWRN4Q7/cmbcfjAsnf87FHkV//kBQ
         UUjGnXsBUv9ChT8KnS6TYYJkGv6jLP6ihihCtOvymPLHmoTw65xBGh2ZMHcytra2FVV5
         CK6kO0txs7CE58Ze+e/kq2agbXxjqFwZzMenu27/uqF2frRrMKdXwo6yS4myNxRgiVUK
         QYYA==
X-Forwarded-Encrypted: i=1; AJvYcCVETVpiAsBN2Jf5eTCZDlBi/DdlRDJ9DUXRHL2Gy9L6jkmhiLeLnEaGsFYVuGO8UIubddw79O2pBJ6UaqDjMhcE@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHR686FPRPDkGHGnW9uPJMpCMoZ6Ip0YfCwSLzLiIz9k3RAd9
	n0i1cIu6M8g1NUTbjgvqUVVuaTlPjR6/l6b7YIyq/r9JaPDsVu2PK3DJ7yOj6qp+8XJxKWeSqPk
	uDfZKAhqhzg==
X-Google-Smtp-Source: AGHT+IEZii1Q+P5Yn5awiIs8jS8CnZRYbs2S3R/ET1MZ6cTwUMgbwb9kf33+3inn8JjSQuZ693FU7KQcdTLT
X-Received: from pga13.prod.google.com ([2002:a05:6a02:4f8d:b0:b2f:c26a:8705])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e91:b0:1ee:e33d:f477
 with SMTP id adf61e73a8af0-21f86645fb9mr7942605637.15.1749686558839; Wed, 11
 Jun 2025 17:02:38 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:14 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-6-irogers@google.com>
Subject: [PATCH v1 05/15] perf vendor events: Update EmeraldRapids events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.11 to v1.14.

Bring in the event updates v1.14:
https://github.com/intel/perfmon/commit/6f6e4c8c906992b450cb2014d0501a9ec1c=
da0d0
https://github.com/intel/perfmon/commit/e363f82276c129aec60402a1d64efbbd41a=
f844e

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/pipeline.json      |  2 +-
 .../arch/x86/emeraldrapids/uncore-io.json     | 12 +++++++++++
 .../arch/x86/emeraldrapids/uncore-memory.json | 20 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
index 00b05a77c289..48bec483b49a 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
@@ -684,7 +684,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
index 94340dee1c9c..d4cf2199d46b 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
@@ -1821,6 +1821,18 @@
         "UMask": "0x4",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Posted requests sent by the integrated IO (II=
O) controller to the Ubox, useful for counting message signaled interrupts =
(MSI).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
+        "Experimental": "1",
+        "FCMask": "0x01",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "ITC address map 1",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
index aa06088dd26f..68be01dad7c9 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
@@ -2145,6 +2145,16 @@
         "UMask": "0x1",
         "Unit": "MCHBM"
     },
+    {
+        "BriefDescription": "ECC Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_MCHBM_ECC_CORRECTABLE_ERRORS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "ECC Correctable Errors.  Counts the number o=
f ECC errors detected and corrected by the iMC on this channel.  This count=
er is only useful with ECC devices.  This count will increment one time for=
 each correction regardless of the number of bits corrected.  The iMC can c=
orrect up to 4 bit errors in independent channel mode and 8 bit errors in l=
ockstep mode.",
+        "Unit": "MCHBM"
+    },
     {
         "BriefDescription": "HBM Precharge All Commands",
         "Counter": "0,1,2,3",
@@ -2759,6 +2769,16 @@
         "UMask": "0x3",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "ECC Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "ECC Correctable Errors : Counts the number o=
f ECC errors detected and corrected by the iMC on this channel.  This count=
er is only useful with ECC DRAM devices.  This count will increment one tim=
e for each correction regardless of the number of bits corrected.  The iMC =
can correct up to 4 bit errors in independent channel mode and 8 bit errors=
 in lockstep mode.",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "IMC Clockticks at HCLK frequency",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 9a60e95a2e15..e139a099374a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.00,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
-GenuineIntel-6-CF,v1.11,emeraldrapids,core
+GenuineIntel-6-CF,v1.14,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.07,grandridge,core
--=20
2.50.0.rc1.591.g9c95f17f64-goog


Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436951DE4CA
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184285; cv=none; b=b4n6iJ1lfGYSP65ZEJD1tADryDM/Co5Z4ZZwUySXFG0M+lhXNpeaSjFtNrZumaKT12tgVwupxyXMS44wnGKN+TT4xI6jDkSLODtpF6DQnCa1wSfQ1xg/G0e/pS+8H3EppvW++zybBxbg7JAAWjtdE+/f9F2wZCei044GzVDYB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184285; c=relaxed/simple;
	bh=puDldx4SEnC8Cw+xNp1r7Afj8U//25Hgv1vtE4fmGdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QNNFr6sUqazqPW8kRu1dWRtCut+ip7wqB8MCk9i6MS6ddF9ffokDCALSJCgef8hM9MnjdMLBMdTIjedOIR9cr+r43+rZe/qj++9mb4rqPsqcTBeBIeyW3k76r7igCsGCpiXdHllGo9JlFAO4TGoyJjyh/TPV37cAouIrwKoOz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pnXExKdG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnXExKdG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so4068640a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Mar 2025 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743184246; x=1743789046; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA8gKSErOIgPhtY5XyYmvYpeqsbnVoRP5UGMygdXk7U=;
        b=pnXExKdGg7srOa877hznFP7oOkrQx39rsCZGPI+o+njAtlDPq4/epCPfIBxLzwOypC
         eOoRDVdaM/WfG+oUu9AGlprz8C2c1rMTHtrFe82KXxLj5PnuJdBq7cHBTgoe+0o4G45R
         PqXA7URt8DsAeof97uqaEPLXbS9fvn5fzfbdzJMm8Mwdg0i6EI8wEVY1ZQMPMe9uli+M
         gsVtGHNlsQ1TLf4HXSqZsu8eiOqAjoAzrHKC/eQhw5Ab+AUfop+X3GXQ8KrZvhr6EM2V
         TxxOs/GdCusdgv/8KC091ga46LX6eTtN6Q/wsZAufFvwEXhVq7/j1APLrthdEC5+9dYI
         5C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743184246; x=1743789046;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rA8gKSErOIgPhtY5XyYmvYpeqsbnVoRP5UGMygdXk7U=;
        b=l/eDxnsowHlD46NGxAGx/Ys43p/UQpA7XuBx8A3uuZK0oKs2v2roOUQEiaMr00Ofv0
         o0w0XH+wp74besIgyBNTnkbD/1k1JiJVlRT5qqzDg/a53l65JC1mysAiB+hgJXaSmvu1
         IWfTkbnTBC7K+UibgUzt4UsZbwP3QOnmdoXQ8OcA1O0kNm/eDvbBQkvXtHIRNKJcRJ9T
         X7rHemaEqr/sToklvHZoQp3BkQew3Bh8PMFfo8ZELXUlmXu2D8eu7iYkuKiJ5XFiX7ES
         gpICybrsD0o/Y9DEmORRZhYLTb0Lx23b1qGpYPlZ3s7nU75KqdUaxIVAtqejkuari7WC
         xskA==
X-Forwarded-Encrypted: i=1; AJvYcCVDM9LT0K+YFMeJ06r170qYcACINh6wPtup9I2yOOohsamSfKjBPIHtPzmG9ANMTZtDRqVWxjqF4gqvWhk6h9Db@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5d2jV3NLr0fk6/Y5Kbu7R4rjhBr5MqVj9hMxAGJsV6N3gxxB
	5Q6OMt58/91HqNn0132l9D2SAIWxxz6Nxn41+kn9aC3E4LPADvosN6xVuOk9vDPJZzl2OLKdpre
	Vfi7QQg==
X-Google-Smtp-Source: AGHT+IEnYTvWVYP5zytEq6qyOwE3lknp9DU8/OY/bdk6iXov0XndxDzuqLYmTjaRnwmVUL7wCHBPsGP5/4+s
X-Received: from pgbcv10.prod.google.com ([2002:a05:6a02:420a:b0:af9:4d6f:2675])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1515:b0:1f5:5903:edd3
 with SMTP id adf61e73a8af0-2009f608d5fmr372546637.11.1743184246244; Fri, 28
 Mar 2025 10:50:46 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:49:42 -0700
In-Reply-To: <20250328175006.43110-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328175006.43110-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328175006.43110-12-irogers@google.com>
Subject: [PATCH v5 11/35] perf vendor events: Update emeraldrapids events/metrics
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
Content-Transfer-Encoding: quoted-printable

Update event topics, addition of PDIST counter into descriptions,
metrics to be generated from the TMA spreadsheet and other small clean
ups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/cache.json         | 284 ++++++++---
 .../arch/x86/emeraldrapids/emr-metrics.json   | 475 +++++++++---------
 .../x86/emeraldrapids/floating-point.json     |  43 +-
 .../arch/x86/emeraldrapids/frontend.json      |  78 +--
 .../arch/x86/emeraldrapids/memory.json        | 231 ++++++++-
 .../arch/x86/emeraldrapids/other.json         | 332 +-----------
 .../arch/x86/emeraldrapids/pipeline.json      | 259 +++++++---
 .../x86/emeraldrapids/virtual-memory.json     |  40 +-
 8 files changed, 941 insertions(+), 801 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/cache.json
index 3b0581151d63..10bdb193c16f 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
@@ -4,6 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
+        "PublicDescription": "L1D.HWPF_MISS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -12,7 +13,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
-        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -21,7 +22,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -32,7 +33,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
-        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -42,6 +43,7 @@
         "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 L1D_PEND_MISS.L2_STALLS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -50,7 +52,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
-        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses. Availa=
ble PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -59,7 +61,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
-        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -69,7 +71,7 @@
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
-        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -78,7 +80,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
-        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1f"
     },
@@ -87,7 +89,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.NON_SILENT",
-        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3 Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
@@ -96,7 +98,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -105,7 +107,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
-        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
@@ -114,7 +116,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES] Available PDIST coun=
ters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xff"
     },
@@ -123,7 +125,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS] Available PDIST coun=
ters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x3f"
     },
@@ -132,7 +134,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "PublicDescription": "Counts the total number of L2 code requests.=
",
+        "PublicDescription": "Counts the total number of L2 code requests.=
 Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe4"
     },
@@ -141,7 +143,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe1"
     },
@@ -150,7 +152,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
-        "PublicDescription": "Counts demand requests that miss L2 cache.",
+        "PublicDescription": "Counts demand requests that miss L2 cache. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x27"
     },
@@ -159,7 +161,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
-        "PublicDescription": "Counts demand requests to L2 cache.",
+        "PublicDescription": "Counts demand requests to L2 cache. Availabl=
e PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe7"
     },
@@ -168,6 +170,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
+        "PublicDescription": "L2_RQSTS.ALL_HWPF Available PDIST counters: =
0",
         "SampleAfterValue": "200003",
         "UMask": "0xf0"
     },
@@ -176,7 +179,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
-        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xe2"
     },
@@ -185,7 +188,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
-        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc4"
     },
@@ -194,7 +197,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
-        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x24"
     },
@@ -203,7 +206,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc1"
     },
@@ -212,7 +215,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
-        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
@@ -221,6 +224,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
+        "PublicDescription": "L2_RQSTS.HWPF_MISS Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0x30"
     },
@@ -229,7 +233,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
-        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS] Available PDIST co=
unters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x3f"
     },
@@ -238,7 +242,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
-        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL] Available PDIST counters:=
 0",
         "SampleAfterValue": "200003",
         "UMask": "0xff"
     },
@@ -247,7 +251,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc2"
     },
@@ -256,7 +260,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
-        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x22"
     },
@@ -265,7 +269,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
-        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0xc8"
     },
@@ -274,7 +278,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
-        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x28"
     },
@@ -283,7 +287,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "L2_TRANS.L2_WB",
-        "PublicDescription": "Counts L2 writebacks that access L2 cache.",
+        "PublicDescription": "Counts L2 writebacks that access L2 cache. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
@@ -292,7 +296,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x41"
     },
@@ -301,7 +305,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3. Available PDIST counters: 0=
",
         "SampleAfterValue": "100003",
         "UMask": "0x4f"
     },
@@ -311,7 +315,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
     },
@@ -321,7 +325,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PublicDescription": "Counts all retired store instructions.",
+        "PublicDescription": "Counts all retired store instructions. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
     },
@@ -331,7 +335,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x83"
     },
@@ -341,7 +345,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
-        "PublicDescription": "Counts retired load instructions with locked=
 access.",
+        "PublicDescription": "Counts retired load instructions with locked=
 access. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x21"
     },
@@ -351,7 +355,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x41"
     },
@@ -361,7 +365,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x42"
     },
@@ -371,7 +375,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
-        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x11"
     },
@@ -381,7 +385,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x12"
     },
@@ -390,7 +394,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
-        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss) Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xfd"
     },
@@ -400,7 +404,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3. Available PDIST counters: 0",
         "SampleAfterValue": "20011",
         "UMask": "0x4"
     },
@@ -410,7 +414,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
@@ -420,7 +424,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required. Available PDIST counters: =
0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -430,7 +434,7 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache. Available P=
DIST counters: 0",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
     },
@@ -440,7 +444,7 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
+        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -450,6 +454,7 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "PublicDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -459,7 +464,7 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
-        "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache.",
+        "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -469,6 +474,7 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "PublicDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -478,7 +484,7 @@
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock). Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x4"
     },
@@ -488,7 +494,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready. Available PDIST counters:=
 0",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
     },
@@ -498,7 +504,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -508,7 +514,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
@@ -518,7 +524,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
@@ -528,7 +534,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources. Available PDIST counters: 0",
         "SampleAfterValue": "100021",
         "UMask": "0x10"
     },
@@ -538,7 +544,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100021",
         "UMask": "0x4"
     },
@@ -548,7 +554,7 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "50021",
         "UMask": "0x20"
     },
@@ -557,6 +563,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "PublicDescription": "MEM_STORE_RETIRED.L2_HIT Available PDIST cou=
nters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -565,10 +572,21 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
-        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that have any type of response. Available PDIST c=
ounters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
         "Counter": "0,1,2,3",
@@ -576,6 +594,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that hit in the L3 or were snooped from another c=
ore's caches on the same socket. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -586,6 +605,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that resulted in a snoop hit a modified line in a=
nother core's caches which forwarded the data. Available PDIST counters: 0"=
,
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -596,6 +616,7 @@
         "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that hit a modified line in a distant L3 Cache or=
 were snooped from a distant core's L1/L2 caches on this socket when the sy=
stem is in SNC (sub-NUMA cluster) mode. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -606,6 +627,18 @@
         "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that either hit a non-modified line in a distant =
L3 Cache or were snooped from a distant core's L1/L2 caches on this socket =
when the system is in SNC (sub-NUMA cluster) mode. Available PDIST counters=
: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "PublicDescription": "Counts demand data reads that have any type =
of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -616,6 +649,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0001",
+        "PublicDescription": "Counts demand data reads that hit in the L3 =
or were snooped from another core's caches on the same socket. Available PD=
IST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -626,6 +660,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
+        "PublicDescription": "Counts demand data reads that resulted in a =
snoop hit a modified line in another core's caches which forwarded the data=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -636,6 +671,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
+        "PublicDescription": "Counts demand data reads that resulted in a =
snoop that hit in another core, which did not forward the data. Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -646,6 +682,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
+        "PublicDescription": "Counts demand data reads that resulted in a =
snoop hit in another core's caches which forwarded the unmodified data to t=
he requesting core. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -656,6 +693,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1030000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by a cache on a remote socket where a snoop hit a modified line in another =
core's caches which forwarded the data. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -666,6 +704,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x830000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by a cache on a remote socket where a snoop hit in another core's caches wh=
ich forwarded the unmodified data to the requesting core. Available PDIST c=
ounters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -676,6 +715,7 @@
         "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000001",
+        "PublicDescription": "Counts demand data reads that hit a modified=
 line in a distant L3 Cache or were snooped from a distant core's L1/L2 cac=
hes on this socket when the system is in SNC (sub-NUMA cluster) mode. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -686,6 +726,18 @@
         "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000001",
+        "PublicDescription": "Counts demand data reads that either hit a n=
on-modified line in a distant L3 Cache or were snooped from a distant core'=
s L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) =
mode. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that have =
any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -696,6 +748,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that hit i=
n the L3 or were snooped from another core's caches on the same socket. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -706,6 +759,7 @@
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that resul=
ted in a snoop hit a modified line in another core's caches which forwarded=
 the data. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -716,6 +770,7 @@
         "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that hit a=
 modified line in a distant L3 Cache or were snooped from a distant core's =
L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mo=
de. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -726,6 +781,40 @@
         "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that eithe=
r hit a non-modified line in a distant L3 Cache or were snooped from a dist=
ant core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA =
cluster) mode. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts data load hardware prefetch requests t=
o the L1 data cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L1D.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10400",
+        "PublicDescription": "Counts data load hardware prefetch requests =
to the L1 data cache that have any type of response. Available PDIST counte=
rs: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches (which bring data =
to L2) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L2.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10070",
+        "PublicDescription": "Counts hardware prefetches (which bring data=
 to L2) that have any type of response. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L3.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x12380",
+        "PublicDescription": "Counts hardware prefetches to the L3 only th=
at have any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -736,6 +825,40 @@
         "EventName": "OCR.HWPF_L3.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80082380",
+        "PublicDescription": "Counts hardware prefetches to the L3 only th=
at hit in the L3 or were snooped from another core's caches on the same soc=
ket. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline was homed in a remote socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L3.REMOTE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x90002380",
+        "PublicDescription": "Counts hardware prefetches to the L3 only th=
at were not supplied by the local socket's L1, L2, or L3 caches and the cac=
heline was homed in a remote socket. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10808",
+        "PublicDescription": "Counts writebacks of modified cachelines and=
 streaming stores that have any type of response. Available PDIST counters:=
 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC4477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that have any type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -746,6 +869,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F003C4477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that hit in the L3 or were snooped from another core's caches on the s=
ame socket. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -756,6 +880,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C4477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that resulted in a snoop hit a modified line in another core's caches =
which forwarded the data. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -766,6 +891,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C4477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that resulted in a snoop that hit in another core, which did not forwa=
rd the data. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -776,6 +902,18 @@
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C4477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that resulted in a snoop hit in another core's caches which forwarded =
the unmodified data to the requesting core. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F33004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were not supplied by the local socket's L1, L2, or L3 caches and =
were supplied by a remote socket. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -786,6 +924,7 @@
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1830004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by a cache on a remote socket where a snoop was sen=
t and data was returned (Modified or Not Modified). Available PDIST counter=
s: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -796,6 +935,7 @@
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1030004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by a cache on a remote socket where a snoop hit a m=
odified line in another core's caches which forwarded the data. Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -806,6 +946,7 @@
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x830004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by a cache on a remote socket where a snoop hit in =
another core's caches which forwarded the unmodified data to the requesting=
 core. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -816,6 +957,7 @@
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that hit a modified line in a distant L3 Cache or were snooped from a =
distant core's L1/L2 caches on this socket when the system is in SNC (sub-N=
UMA cluster) mode. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -826,6 +968,7 @@
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that either hit a non-modified line in a distant L3 Cache or were snoo=
ped from a distant core's L1/L2 caches on this socket when the system is in=
 SNC (sub-NUMA cluster) mode. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -836,6 +979,7 @@
         "EventName": "OCR.RFO_TO_CORE.L3_HIT_M",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1F80040022",
+        "PublicDescription": "Counts demand reads for ownership (RFO), har=
dware prefetch RFOs (which bring data to L2), and software prefetches for e=
xclusive ownership (PREFETCHW) that hit to a (M)odified cacheline in the L3=
 or snoop filter. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -846,6 +990,7 @@
         "EventName": "OCR.STREAMING_WR.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080800",
+        "PublicDescription": "Counts streaming stores that hit in the L3 o=
r were snooped from another core's caches on the same socket. Available PDI=
ST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -854,6 +999,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "PublicDescription": "OFFCORE_REQUESTS.ALL_REQUESTS Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -862,7 +1008,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
-        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -871,7 +1017,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
-        "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests.",
+        "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -880,7 +1026,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
-        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -889,7 +1035,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
-        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -899,6 +1045,7 @@
         "Deprecated": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 OFFCORE_REQUESTS_OUTSTANDING.DATA_RD Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -908,6 +1055,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DAT=
A_RD Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -917,7 +1065,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -927,6 +1075,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
+        "PublicDescription": "Cycles where at least 1 outstanding demand d=
ata read request is pending. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -936,6 +1085,7 @@
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
+        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEM=
AND_RFO Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -944,6 +1094,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "PublicDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -952,7 +1103,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
-        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -961,7 +1112,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
-        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor. Available PDIST counters: 0"=
,
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -970,7 +1121,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
-        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -979,6 +1130,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.ANY",
+        "PublicDescription": "Counts the number of PREFETCHNTA, PREFETCHW,=
 PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed. Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xf"
     },
@@ -987,7 +1139,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -996,7 +1148,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -1005,7 +1157,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
-        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -1014,7 +1166,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json =
b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
index d3b51fa6ec1c..34e1cbcd722c 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
@@ -300,7 +300,7 @@
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
         "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_co=
re_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -312,7 +312,7 @@
         "MetricExpr": "EXE.AMX_BUSY / tma_info_core_core_clks",
         "MetricGroup": "BvCB;Compute;HPC;Server;TopdownL3;tma_L3_group;tma=
_core_bound_group",
         "MetricName": "tma_amx_busy",
-        "MetricThreshold": "tma_amx_busy > 0.5 & tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2",
+        "MetricThreshold": "tma_amx_busy > 0.5 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -320,12 +320,12 @@
         "MetricExpr": "78 * ASSISTS.ANY / tma_info_thread_slots",
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
+        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
         "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / tma_info_thread_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_avx_assists",
@@ -335,7 +335,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_thread_slots",
         "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -351,12 +351,12 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_bottleneck_big_code",
         "MetricThreshold": "tma_bottleneck_big_code > 20"
@@ -371,7 +371,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_full)=
))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_bottleneck_cache_memory_bandwidth",
         "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
@@ -379,7 +379,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_de=
pendency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_=
bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_d=
ram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_st=
ore_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_load=
s + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma=
_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma_s=
tore_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_sha=
ring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_mem=
ory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_late=
ncy + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_dtl=
b_store)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound =
+ tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependen=
cy + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_=
bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma=
_l3_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_fb=
_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tm=
a_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_=
latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_s=
tore_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharin=
g + tma_split_stores + tma_store_latency + tma_streaming_stores)) + tma_mem=
ory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_boun=
d + tma_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store=
 + tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming=
_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
@@ -387,22 +387,22 @@
     },
     {
         "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_amx_busy + tma_ports_utilization) + tma_c=
ore_bound * tma_amx_busy / (tma_divider + tma_serializing_operation + tma_a=
mx_busy + tma_ports_utilization) + tma_core_bound * (tma_ports_utilization =
/ (tma_divider + tma_serializing_operation + tma_amx_busy + tma_ports_utili=
zation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_amx_busy=
 + tma_divider + tma_ports_utilization + tma_serializing_operation) + tma_c=
ore_bound * tma_amx_busy / (tma_amx_busy + tma_divider + tma_ports_utilizat=
ion + tma_serializing_operation) + tma_core_bound * (tma_ports_utilization =
/ (tma_amx_busy + tma_divider + tma_ports_utilization + tma_serializing_ope=
ration)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
         "MetricGroup": "BvCB;Cor;tma_issueComp",
         "MetricName": "tma_bottleneck_compute_bound_est",
         "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy"
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: "
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fe=
tch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers=
 + tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredict=
s) / (tma_mispredicts_resteers + tma_clears_resteers + tma_unknown_branches=
)) / (tma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_sw=
itches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_ms / (tma_=
mite + tma_dsb + tma_ms))) - tma_bottleneck_big_code",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetc=
h_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers +=
 tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredicts)=
 / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_branches))=
 / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_m=
isses + tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_ms / (tma_ds=
b + tma_mite + tma_ms))) - tma_bottleneck_big_code",
         "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20"
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_switches + tma_b=
ranch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_othe=
r_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_resteers + tma_c=
lears_resteers + tma_unknown_branches)) / (tma_icache_misses + tma_itlb_mis=
ses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) +=
 tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ms)) + 10 * tma_m=
icrocode_sequencer * tma_other_mispredicts / tma_branch_mispredicts * tma_b=
ranch_mispredicts + tma_machine_clears * tma_other_nukes / tma_other_nukes =
+ tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOURCE / tma_inf=
o_thread_clks * tma_ports_utilized_0) / (tma_divider + tma_serializing_oper=
ation + tma_amx_busy + tma_ports_utilization) + tma_microcode_sequencer / (=
tma_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_m=
icrocode_sequencer) * tma_heavy_operations)",
+        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_switches + tma_bra=
nch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_other_=
mispredicts / tma_branch_mispredicts) / (tma_clears_resteers + tma_mispredi=
cts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma_dsb_swit=
ches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) + t=
ma_fetch_bandwidth * tma_ms / (tma_dsb + tma_mite + tma_ms)) + 10 * tma_mic=
rocode_sequencer * tma_other_mispredicts / tma_branch_mispredicts * tma_bra=
nch_mispredicts + tma_machine_clears * tma_other_nukes / tma_other_nukes + =
tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOURCE / tma_info_=
thread_clks * tma_ports_utilized_0) / (tma_amx_busy + tma_divider + tma_por=
ts_utilization + tma_serializing_operation) + tma_microcode_sequencer / (tm=
a_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_mic=
rocode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
@@ -410,7 +410,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_lo=
ads + tma_fb_full)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound +=
 tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_dt=
lb_store / (tma_store_latency + tma_false_sharing + tma_split_stores + tma_=
streaming_stores + tma_dtlb_store)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
fb_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + =
tma_store_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound=
 + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dt=
lb_store / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_sto=
re_latency + tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -418,7 +418,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_mem + tma_remote_cache) + tma_l3_bound / (t=
ma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bo=
und) * tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_spl=
it_stores + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + t=
ma_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_cache + tma_remote_mem) + tma_l3_bound / (t=
ma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bo=
und) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_=
stores + tma_store_latency + tma_streaming_stores - tma_store_latency)) + t=
ma_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
@@ -426,7 +426,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
         "MetricName": "tma_bottleneck_mispredictions",
         "MetricThreshold": "tma_bottleneck_mispredictions > 20",
@@ -438,10 +438,10 @@
         "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls"
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls."
     },
     {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
         "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
         "MetricGroup": "BvUW;Ret",
         "MetricName": "tma_bottleneck_useful_work",
@@ -450,7 +450,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tm=
a_info_thread_slots",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;Default;TmaL2;TopdownL2=
;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
@@ -463,24 +463,24 @@
         "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings).",
         "MetricExpr": "CPU_CLK_UNHALTED.C01 / tma_info_thread_clks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c01_wait",
-        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings).",
         "MetricExpr": "CPU_CLK_UNHALTED.C02 / tma_info_thread_clks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c02_wait",
-        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -488,8 +488,8 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
+        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
         "ScaleUnit": "100%"
     },
     {
@@ -497,24 +497,24 @@
         "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache.",
         "MetricExpr": "max(0, tma_icache_misses - tma_code_l2_miss)",
         "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
         "MetricName": "tma_code_l2_hit",
-        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & (tma_icache_misses > =
0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache."=
,
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_COD=
E_RD / tma_info_thread_clks",
         "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
         "MetricName": "tma_code_l2_miss",
-        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & (tma_icache_misses >=
 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
@@ -522,7 +522,7 @@
         "MetricExpr": "max(0, tma_itlb_misses - tma_code_stlb_miss)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
         "MetricName": "tma_code_stlb_hit",
-        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & (tma_itlb_misses > =
0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
@@ -530,32 +530,33 @@
         "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
         "MetricName": "tma_code_stlb_miss",
-        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & (tma_itlb_misses >=
 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses.",
         "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_2M_=
4M / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
         "MetricName": "tma_code_stlb_miss_2m",
-        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & (tma_code_stlb_=
miss > 0.05 & (tma_itlb_misses > 0.05 & (tma_fetch_latency > 0.1 & tma_fron=
tend_bound > 0.15)))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses.",
         "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_4K =
/ (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
         "MetricName": "tma_code_stlb_miss_4k",
-        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & (tma_code_stlb_=
miss > 0.05 & (tma_itlb_misses > 0.05 & (tma_fetch_latency > 0.1 & tma_fron=
tend_bound > 0.15)))",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "((81 * tma_info_system_core_frequency - 4.4 * tma_i=
nfo_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + (79 * tma_info_system_core_fre=
quency - 4.4 * tma_info_system_core_frequency) * MEM_LOAD_L3_HIT_RETIRED.XS=
NP_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / t=
ma_info_thread_clks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(76.6 * tma_info_system_core_frequency * (MEM_LOAD_=
L3_HIT_RETIRED.XSNP_FWD * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMA=
ND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD=
))) + 74.6 * tma_info_system_core_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_=
MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_=
info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related =
metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false=
_sharing, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false_=
sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -566,24 +567,25 @@
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "(79 * tma_info_system_core_frequency - 4.4 * tma_in=
fo_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD=
_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR=
.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WIT=
H_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / t=
ma_info_thread_clks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "74.6 * tma_info_system_core_frequency * (MEM_LOAD_L=
3_HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR=
.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT=
 / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears, =
tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu@I=
NST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & t=
ma_fetch_bandwidth > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%"
     },
@@ -592,8 +594,8 @@
         "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
+        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
         "ScaleUnit": "100%"
     },
     {
@@ -601,7 +603,7 @@
         "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%"
     },
@@ -611,7 +613,7 @@
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
     },
     {
@@ -619,34 +621,34 @@
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D0=
x1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - MEM=
ORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
+        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - MEMOR=
Y_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_bottleneck_memory_data_tlbs, tma_dtlb_store",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D0x1=
@ + DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
+        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_bottleneck_=
memory_data_tlbs, tma_dtlb_load",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "(170 * tma_info_system_core_frequency * cpu@OCR.DEM=
AND_RFO.L3_MISS\\,offcore_rsp\\=3D0x103b800002@ + 81 * tma_info_system_core=
_frequency * OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM) / tma_info_thread_clks",
+        "MetricExpr": "(170 * tma_info_system_core_frequency * OCR.DEMAND_=
RFO.L3_MISS@offcore_rsp\\=3D0x103b800002@ + 81 * tma_info_system_core_frequ=
ency * OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM) / tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
-        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cac=
he",
         "ScaleUnit": "100%"
     },
@@ -667,7 +669,7 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1;FRONTEND_RETIRED.LATEN=
CY_GE_1;FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches, t=
ma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_fr=
ontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
@@ -678,7 +680,7 @@
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -696,7 +698,7 @@
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
         "ScaleUnit": "100%"
     },
     {
@@ -705,15 +707,15 @@
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals).",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active.",
         "MetricExpr": "ARITH.FPDIV_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
         "MetricName": "tma_fp_divider",
-        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_fp_divider > 0.2 & (tma_divider > 0.2 & (t=
ma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -721,8 +723,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIR=
ED2.SCALAR) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -730,8 +732,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.VECTOR + FP_ARITH_INST_RETIR=
ED2.VECTOR) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6=
, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -739,8 +741,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.128B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_po=
rts_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -748,8 +750,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.256B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_po=
rts_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -757,8 +759,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.512B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_512b",
-        "MetricThreshold": "tma_fp_vector_512b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_512b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
         "ScaleUnit": "100%"
     },
     {
@@ -769,27 +771,27 @@
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
         "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_thread_slots",
         "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_re=
tiring_group",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+]). Sample with: UOPS_RET=
IRED.HEAVY",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.([ICL+] Note this may overcoun=
t due to approximation using indirect events; [ADL+]). Sample with: UOPS_RE=
TIRED.HEAVY",
         "ScaleUnit": "100%"
     },
     {
@@ -797,8 +799,8 @@
         "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -809,28 +811,28 @@
         "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000"
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_ret",
@@ -858,7 +860,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_ms)))",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_mite=
 + tma_ms)))",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
@@ -866,7 +868,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_ms))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite + tma_ms))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
@@ -874,10 +876,11 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
-        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5"
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
@@ -938,11 +941,11 @@
         "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)"
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D0x1@",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
     },
@@ -955,20 +958,20 @@
         "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "DSBmiss",
         "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D0=
x1@",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_frontend_fetch_upc"
     },
     {
         "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "ICACHE_DATA.STALLS / cpu@ICACHE_DATA.STALLS\\,cmask=
\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricExpr": "ICACHE_DATA.STALLS / cpu@ICACHE_DATA.STALLS\\,cmask=
\\=3D1\\,edge@",
         "MetricGroup": "Fed;FetchLat;IcMiss",
         "MetricName": "tma_info_frontend_icache_miss_latency"
     },
@@ -1005,13 +1008,13 @@
     },
     {
         "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
-        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNKNO=
WN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNKNO=
WN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_unknown_branch_cost",
-        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node"
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node."
     },
     {
-        "BriefDescription": "Branch instructions per taken branch",
+        "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch"
@@ -1029,7 +1032,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW"
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
@@ -1037,7 +1040,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
@@ -1045,7 +1048,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
@@ -1053,7 +1056,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx512",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
@@ -1061,7 +1064,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Half-Pr=
ecision instruction (lower number means higher occurrence rate)",
@@ -1069,7 +1072,7 @@
         "MetricGroup": "Flops;FpScalar;InsType;Server",
         "MetricName": "tma_info_inst_mix_iparith_scalar_hp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_hp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Half-P=
recision instruction (lower number means higher occurrence rate). Values < =
1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Half-P=
recision instruction (lower number means higher occurrence rate). Values < =
1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
@@ -1077,7 +1080,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
@@ -1132,7 +1135,7 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 13",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp"
     },
     {
@@ -1269,7 +1272,7 @@
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
         "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_mlp"
     },
@@ -1334,21 +1337,21 @@
         "MetricExpr": "64 * OCR.READS_TO_CORE.DRAM / 1e9 / tma_info_system=
_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_soc_r2c_dram_bw",
-        "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW"
+        "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average L3-cache miss BW for Reads-to-Core (R=
2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.L3_MISS / 1e9 / tma_info_sys=
tem_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_soc_r2c_l3m_bw",
-        "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW"
+        "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average Off-core access BW for Reads-to-Core =
(R2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.ANY_RESPONSE / 1e9 / tma_inf=
o_system_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_soc_r2c_offcore_bw",
-        "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches"
+        "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches."
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
@@ -1376,8 +1379,8 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D0x1@)",
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
     },
@@ -1398,18 +1401,18 @@
         "MetricExpr": "INST_RETIRED.ANY / ASSISTS.ANY",
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
-        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D0x1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
     },
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D0x1@",
+        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D1@",
         "MetricGroup": "MicroSeq;Pipeline;Ret",
         "MetricName": "tma_info_pipeline_strings_cycles",
         "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1"
@@ -1472,14 +1475,13 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000"
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
-        "MetricName": "tma_info_system_kernel_cpi",
-        "ScaleUnit": "1per_instr"
+        "MetricName": "tma_info_system_kernel_cpi"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
@@ -1490,7 +1492,7 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / cha_0@event\\=3D0x0@",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / uncore_cha_0@event\\=3D0x1@",
         "MetricGroup": "MemOffcore;MemoryLat;Server;SoC",
         "MetricName": "tma_info_system_mem_dram_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
@@ -1500,11 +1502,11 @@
         "MetricExpr": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH / UNC_CHA_CLOCKTIC=
KS",
         "MetricGroup": "LockCont;MemOffcore;Server;SoC",
         "MetricName": "tma_info_system_mem_irq_duplicate_address",
-        "MetricThreshold": "(tma_info_system_mem_irq_duplicate_address > 0=
.1)"
+        "MetricThreshold": "tma_info_system_mem_irq_duplicate_address > 0.=
1"
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@UNC_CHA_TOR=
_OCCUPANCY.IA_MISS_DRD\\,thresh\\=3D0x1@",
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
@@ -1538,7 +1540,7 @@
     },
     {
         "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
-        "MetricExpr": "cha_0@event\\=3D0x0@",
+        "MetricExpr": "uncore_cha_0@event\\=3D0x1@",
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
@@ -1568,7 +1570,7 @@
         "MetricName": "tma_info_system_upi_data_transmit_bw"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks"
@@ -1577,15 +1579,14 @@
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_thread_cpi",
-        "ScaleUnit": "1per_instr"
+        "MetricName": "tma_info_thread_cpi"
     },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage"
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
     },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
@@ -1595,13 +1596,13 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "slots",
+        "MetricExpr": "TOPDOWN.SLOTS",
         "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
+        "MetricExpr": "(tma_info_thread_slots / (TOPDOWN.SLOTS / 2) if #SM=
T_on else 1)",
         "MetricGroup": "SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots_utilization"
     },
@@ -1617,14 +1618,14 @@
         "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5"
+        "MetricThreshold": "tma_info_thread_uptb < 9"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active.",
         "MetricExpr": "tma_divider - tma_fp_divider",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
         "MetricName": "tma_int_divider",
-        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_int_divider > 0.2 & (tma_divider > 0.2 & (=
tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -1633,7 +1634,7 @@
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_int_operations",
         "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
-        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
         "ScaleUnit": "100%"
     },
     {
@@ -1641,8 +1642,8 @@
         "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_128b",
-        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1650,8 +1651,8 @@
         "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
-        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1659,8 +1660,8 @@
         "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -1668,7 +1669,7 @@
         "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
@@ -1677,7 +1678,7 @@
         "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
         "MetricName": "tma_l1_latency_dependency",
-        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & (tma_l1_boun=
d > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%"
     },
@@ -1686,16 +1687,17 @@
         "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "4.4 * tma_info_system_core_frequency * MEM_LOAD_RET=
IRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) =
/ tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
         "MetricName": "tma_l2_hit_latency",
-        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & (tma_l2_bound > 0.=
05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
@@ -1704,17 +1706,18 @@
         "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
+        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricExpr": "(37 * tma_info_system_core_frequency - 4.4 * tma_in=
fo_system_core_frequency) * (MEM_LOAD_RETIRED.L3_HIT * (1 + MEM_LOAD_RETIRE=
D.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2)) / tma_info_thread_clks",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "32.6 * tma_info_system_core_frequency * (MEM_LOAD_R=
ETIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2=
)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_cache_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1722,19 +1725,19 @@
         "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
         "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
         "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_re=
tiring_group",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
         "ScaleUnit": "100%"
     },
     {
@@ -1751,7 +1754,7 @@
         "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_hit",
-        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
         "ScaleUnit": "100%"
     },
     {
@@ -1759,39 +1762,39 @@
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
-        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_1g",
-        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPL=
ETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_2m",
-        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_4k",
-        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "(109 * tma_info_system_core_frequency - 37 * tma_in=
fo_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_=
LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks"=
,
+        "MetricExpr": "72 * tma_info_system_core_frequency * MEM_LOAD_L3_M=
ISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1=
_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
-        "MetricThreshold": "tma_local_mem > 0.1 & tma_mem_latency > 0.1 & =
tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)=
))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM",
         "ScaleUnit": "100%"
     },
@@ -1800,7 +1803,7 @@
         "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
@@ -1816,19 +1819,19 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling)",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling).",
         "MetricExpr": "INT_MISC.MBA_STALLS / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;Server;TopdownL5;tma_L5_group;tma=
_mem_bandwidth_group",
         "MetricName": "tma_mba_stalls",
-        "MetricThreshold": "tma_mba_stalls > 0.1 & tma_mem_bandwidth > 0.2=
 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2"=
,
+        "MetricThreshold": "tma_mba_stalls > 0.1 & (tma_mem_bandwidth > 0.=
2 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2)))",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
@@ -1837,32 +1840,32 @@
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_thread_slots",
         "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;tma_b=
ackend_bound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
-        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
         "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -1883,7 +1886,7 @@
         "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * INT_=
MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
         "ScaleUnit": "100%"
     },
@@ -1897,17 +1900,17 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
         "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_thread_clks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
-        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmask\=
\=3D0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_clk=
s / 2",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details.",
+        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmask\=
\=3D1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_clks =
/ 2",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
         "MetricName": "tma_ms",
         "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
@@ -1915,11 +1918,11 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=3D=
0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
+        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ / (UO=
PS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_mac=
hine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_o=
peration",
+        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_bottlene=
ck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clear=
s, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
     {
@@ -1928,7 +1931,7 @@
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
         "ScaleUnit": "100%"
     },
     {
@@ -1936,7 +1939,7 @@
         "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_thread_slots)",
         "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
-        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
         "ScaleUnit": "100%"
     },
@@ -1950,19 +1953,19 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
-        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
         "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
-        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
@@ -1971,7 +1974,7 @@
         "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_page_faults",
         "MetricThreshold": "tma_page_faults > 0.05",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
         "ScaleUnit": "100%"
     },
     {
@@ -1980,7 +1983,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_po=
rts_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1989,7 +1992,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Related metrics: tma_fp_s=
calar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector=
_512b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_5, tm=
a_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1998,7 +2001,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
ts_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, =
tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector=
_256b, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -2006,8 +2009,8 @@
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_3_PORTS_UTIL)) / tm=
a_info_thread_clks if ARITH.DIV_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_=
ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EX=
E_ACTIVITY.2_3_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
         "ScaleUnit": "100%"
     },
     {
@@ -2015,8 +2018,8 @@
         "MetricExpr": "(EXE_ACTIVITY.EXE_BOUND_0_PORTS + max(RS.EMPTY_RESO=
URCE - RESOURCE_STALLS.SCOREBOARD, 0)) / tma_info_thread_clks * (CYCLE_ACTI=
VITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
         "ScaleUnit": "100%"
     },
     {
@@ -2024,7 +2027,7 @@
         "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
         "ScaleUnit": "100%"
     },
@@ -2034,8 +2037,8 @@
         "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6",
         "ScaleUnit": "100%"
     },
     {
@@ -2044,32 +2047,32 @@
         "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "((170 * tma_info_system_core_frequency - 37 * tma_i=
nfo_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM + (170 * =
tma_info_system_core_frequency - 37 * tma_info_system_core_frequency) * MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD=
_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(133 * tma_info_system_core_frequency * MEM_LOAD_L3=
_MISS_RETIRED.REMOTE_HITM + 133 * tma_info_system_core_frequency * MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
-        "MetricThreshold": "tma_remote_cache > 0.05 & tma_mem_latency > 0.=
1 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. Sample with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM, MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD. Related metrics: tma_bottleneck_memory_sy=
nchronization, tma_contested_accesses, tma_data_sharing, tma_false_sharing,=
 tma_machine_clears",
+        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article. Sample with: MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS. Related metri=
cs: tma_bottleneck_memory_synchronization, tma_contested_accesses, tma_data=
_sharing, tma_false_sharing, tma_machine_clears",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "(190 * tma_info_system_core_frequency - 37 * tma_in=
fo_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM=
_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks=
",
+        "MetricExpr": "153 * tma_info_system_core_frequency * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
-        "MetricThreshold": "tma_remote_mem > 0.1 & tma_mem_latency > 0.1 &=
 tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_DRAM",
+        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
thread_slots",
         "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2082,7 +2085,7 @@
         "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks +=
 tma_c02_wait",
         "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
-        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
         "ScaleUnit": "100%"
     },
@@ -2091,8 +2094,8 @@
         "MetricExpr": "tma_light_operations * INT_VEC_RETIRED.SHUFFLES / (=
tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
         "MetricName": "tma_shuffles_256b",
-        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_ops =
> 0.3 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_ops=
 > 0.3 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers.",
         "ScaleUnit": "100%"
     },
     {
@@ -2101,7 +2104,7 @@
         "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
-        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
         "ScaleUnit": "100%"
     },
@@ -2111,7 +2114,7 @@
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.3",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -2119,8 +2122,8 @@
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
+        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
         "ScaleUnit": "100%"
     },
     {
@@ -2128,7 +2131,7 @@
         "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / tma_in=
fo_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
         "ScaleUnit": "100%"
     },
@@ -2137,8 +2140,8 @@
         "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
+        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -2146,8 +2149,8 @@
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
         "ScaleUnit": "100%"
     },
     {
@@ -2155,8 +2158,8 @@
         "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RETI=
RED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE=
_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
-        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -2173,7 +2176,7 @@
         "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_hit",
-        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
         "ScaleUnit": "100%"
     },
     {
@@ -2181,31 +2184,31 @@
         "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
-        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_1g",
-        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_C=
OMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_2m",
-        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_4k",
-        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
@@ -2213,7 +2216,7 @@
         "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thread=
_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
-        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
         "ScaleUnit": "100%"
     },
@@ -2222,7 +2225,7 @@
         "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_thread_cl=
ks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%"
     },
@@ -2231,8 +2234,8 @@
         "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
+        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.js=
on b/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
index bc475e163227..8c9207750c82 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/floating-point.json
@@ -5,6 +5,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
+        "PublicDescription": "ARITH.FPDIV_ACTIVE Available PDIST counters:=
 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -13,7 +14,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
-        "PublicDescription": "Counts all microcode Floating Point assists.=
",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
 Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -22,6 +23,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
+        "PublicDescription": "ASSISTS.SSE_AVX_MIX Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -30,6 +32,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
+        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is al=
ias to FP_ARITH_DISPATCHED.V0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -38,6 +41,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
+        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is al=
ias to FP_ARITH_DISPATCHED.V1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -46,6 +50,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
+        "PublicDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is al=
ias to FP_ARITH_DISPATCHED.V2] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -54,6 +59,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V0",
+        "PublicDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_0] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -62,6 +68,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V1",
+        "PublicDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_1] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -70,6 +77,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V2",
+        "PublicDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias =
to FP_ARITH_DISPATCHED.PORT_5] Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -78,7 +86,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events. Available PDIST counters: 0"=
,
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -87,7 +95,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -96,7 +104,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -105,7 +113,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events. Available PDIST co=
unters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -114,7 +122,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
-        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events. =
Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x18"
     },
@@ -123,7 +131,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
@@ -132,7 +140,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -141,7 +149,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.8_FLOPS",
-        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision and 512-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 8 computation operations, one for each element.  Applies =
to SSE* and AVX* packed single precision and double precision floating-poin=
t instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RSQRT14=
 RCP RCP14 DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice=
 as they perform 2 calculations per element. The DAZ and FTZ flags in the M=
XCSR register need to be set when using these events. Available PDIST count=
ers: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x60"
     },
@@ -150,7 +158,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
-        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
@@ -159,7 +167,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events. Available PD=
IST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -168,7 +176,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
-        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -177,7 +185,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
-        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xfc"
     },
@@ -186,6 +194,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -194,6 +203,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -202,6 +212,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -210,6 +221,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF A=
vailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -218,7 +230,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     },
@@ -227,6 +239,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR_HALF Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -235,7 +248,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.VECTOR",
-        "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1c"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
index bf68493d4509..9fe9d62b867a 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/frontend.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "BACLEARS.ANY",
-        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore. A=
vailable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -13,7 +13,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
-        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk. Available PDIS=
T counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -22,6 +22,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
+        "PublicDescription": "Cycles the Microcode Sequencer is busy. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x2"
     },
@@ -30,7 +31,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
-        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE. Available PDIST counters: =
0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -41,7 +42,7 @@
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
-        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. Availa=
ble PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -52,7 +53,7 @@
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
-        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -63,7 +64,7 @@
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
-        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -74,7 +75,7 @@
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
-        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -85,7 +86,7 @@
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
-        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -96,7 +97,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600106",
-        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -107,7 +108,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x608006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -118,7 +119,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x601006",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -129,7 +130,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600206",
-        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -140,7 +141,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x610006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -151,7 +152,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -162,7 +163,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x602006",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -173,7 +174,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600406",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall. Available PDIST count=
ers: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -184,7 +185,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x620006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -195,7 +196,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x604006",
-        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -206,7 +207,7 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600806",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -217,6 +218,7 @@
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
+        "PublicDescription": "FRONTEND_RETIRED.MS_FLOWS Available PDIST co=
unters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -227,7 +229,7 @@
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
-        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -238,6 +240,7 @@
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
+        "PublicDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH Available PD=
IST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -246,7 +249,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
-        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity. Available PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x4"
     },
@@ -257,6 +260,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALL_PERIODS",
+        "PublicDescription": "ICACHE_DATA.STALL_PERIODS Available PDIST co=
unters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x4"
     },
@@ -265,7 +269,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
-        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss. Available PDIST counters: 0",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
@@ -275,7 +279,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -285,7 +289,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -294,7 +298,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -304,7 +308,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
-        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -314,7 +318,7 @@
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -323,7 +327,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
-        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB). Available PDIST c=
ounters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -333,7 +337,7 @@
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
-        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -344,7 +348,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_SWITCHES",
-        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -353,7 +357,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
-        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
+        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS). Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -362,7 +366,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE] Available PDI=
ST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -372,7 +376,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE]",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES=
_0_UOPS_DELIV.CORE] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -383,7 +387,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_N=
OT_DELIVERED.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -392,7 +396,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
-        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE]",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE] Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -402,7 +406,7 @@
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
-        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE]",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DEL=
IV.CORE] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -413,7 +417,7 @@
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "Invert": "1",
-        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK]",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLE=
S.CYCLES_FE_WAS_OK] Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/emeraldrapids/memory.json
index 41d4120d4dae..7c3f9b76d367 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
@@ -5,6 +5,7 @@
         "CounterMask": "6",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
@@ -13,7 +14,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -23,6 +24,7 @@
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
+        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -32,6 +34,7 @@
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
+        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
@@ -41,7 +44,7 @@
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
-        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -51,7 +54,7 @@
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
-        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock).",
+        "PublicDescription": "Execution stalls while L3 cache miss demand =
cacheable load request is outstanding (will not count for uncacheable deman=
d requests e.g. bus lock). Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
@@ -169,10 +172,21 @@
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
-        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8 Availab=
le PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by DRAM. Available PDIST count=
ers: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the local socket's L1, L=
2, or L3 caches.",
         "Counter": "0,1,2,3",
@@ -180,6 +194,40 @@
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were not supplied by the local socket's L1, =
L2, or L3 caches. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by DRAM attached to this socke=
t, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRA=
M accesses that are controlled by the close SNC Cluster. Available PDIST co=
unters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM on a distant memory con=
troller of this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708000004",
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that were supplied by DRAM on a distant memory co=
ntroller of this socket when the system is in SNC (sub-NUMA cluster) mode. =
Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -190,6 +238,51 @@
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00001",
+        "PublicDescription": "Counts demand data reads that were not suppl=
ied by the local socket's L1, L2, or L3 caches. Available PDIST counters: 0=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In =
SNC Mode counts only those DRAM accesses that are controlled by the close S=
NC Cluster. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by DRAM attached to another socket. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM on a distant memory controller of this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708000001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by DRAM on a distant memory controller of this socket when the system is in=
 SNC (sub-NUMA cluster) mode. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that were =
supplied by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -200,6 +293,29 @@
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FC00002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that were =
not supplied by the local socket's L1, L2, or L3 caches. Available PDIST co=
unters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that were =
supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) M=
ode.  In SNC Mode counts only those DRAM accesses that are controlled by th=
e close SNC Cluster. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM on a distant memory controller of this socket when the syst=
em is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708000002",
+        "PublicDescription": "Counts demand reads for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that were =
supplied by DRAM on a distant memory controller of this socket when the sys=
tem is in SNC (sub-NUMA cluster) mode. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -210,6 +326,7 @@
         "EventName": "OCR.HWPF_L3.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x94002380",
+        "PublicDescription": "Counts hardware prefetches to the L3 only th=
at missed the local socket's L1, L2, and L3 caches. Available PDIST counter=
s: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -220,6 +337,18 @@
         "EventName": "OCR.HWPF_L3.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84002380",
+        "PublicDescription": "Counts hardware prefetches to the L3 only th=
at were not supplied by the local socket's L1, L2, or L3 caches and the cac=
heline is homed locally. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by DRAM. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -230,6 +359,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FC04477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were not supplied by the local socket's L1, L2, or L3 caches. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -240,6 +370,7 @@
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F04C04477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were not supplied by the local socket's L1, L2, or L3 caches and =
the cacheline is homed locally. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -250,6 +381,62 @@
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x70CC04477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that missed the L3 Cache and were supplied by the local socket (DRAM o=
r PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts P=
MM or DRAM accesses that are controlled by the close or distant SNC Cluster=
.  It does not count misses to the L3 which go to Local CXL Type 2 Memory o=
r Local Non DRAM. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA=
 Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are c=
ontrolled by the close SNC Cluster. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x70C004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by DRAM attached to this socket, whether or not in =
Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are cont=
rolled by the close or distant SNC Cluster. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by DRAM attached to another socket. Available PDIST=
 counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x733004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by DRAM or PMM attached to another socket. Availabl=
e PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM on a distant memory controller of this socke=
t when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708004477",
+        "PublicDescription": "Counts all (cacheable) data read, code read =
and RFO requests including demands and prefetches to the core caches (L1 or=
 L2) that were supplied by DRAM on a distant memory controller of this sock=
et when the system is in SNC (sub-NUMA cluster) mode. Available PDIST count=
ers: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -260,6 +447,7 @@
         "EventName": "OCR.STREAMING_WR.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x94000800",
+        "PublicDescription": "Counts streaming stores that missed the loca=
l socket's L1, L2, and L3 caches. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -270,6 +458,18 @@
         "EventName": "OCR.STREAMING_WR.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000800",
+        "PublicDescription": "Counts streaming stores that were not suppli=
ed by the local socket's L1, L2, or L3 caches and the cacheline is homed lo=
cally. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0xFBFF80822",
+        "PublicDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Har=
dware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted=
 in a store to Memory (DRAM or PMM) Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -278,6 +478,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "PublicDescription": "Counts demand data read requests that miss t=
he L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -286,7 +487,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
-        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -295,7 +496,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
+        "PublicDescription": "Counts the number of times RTM abort was tri=
ggered. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -304,7 +505,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_EVENTS",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 3 categories (e.g. interrupt).",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 3 categories (e.g. interrupt). Availabl=
e PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -313,7 +514,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEM",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s).",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -322,7 +523,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type.",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x40"
     },
@@ -331,7 +532,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions.",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -340,7 +541,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.COMMIT",
-        "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
+        "PublicDescription": "Counts the number of times RTM commit succee=
ded. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -349,7 +550,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.START",
-        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
+        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -358,7 +559,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_READ",
-        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -367,7 +568,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
-        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -376,7 +577,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "TX_MEM.ABORT_CONFLICT",
-        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
+        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/other.json
index c424facf1b95..a58d65556609 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
@@ -4,277 +4,10 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
+        "PublicDescription": "ASSISTS.PAGE_FAULT Available PDIST counters:=
 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
-    {
-        "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xb7",
-        "EventName": "EXE.AMX_BUSY",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM on a distant memory con=
troller of this socket when the system is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_CODE_RD.SNC_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x708000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x730000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM on a distant memory controller of this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.SNC_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x708000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F3FFC0002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM on a distant memory controller of this socket when the syst=
em is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.SNC_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x708000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts data load hardware prefetch requests t=
o the L1 data cache that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.HWPF_L1D.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10400",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetches (which bring data =
to L2) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.HWPF_L2.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10070",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.HWPF_L3.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x12380",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline was homed in a remote socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.HWPF_L3.REMOTE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x90002380",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10808",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F3FFC4477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x70C004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.REMOTE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F33004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x730004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x733004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM on a distant memory controller of this socke=
t when the system is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x708004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
@@ -282,76 +15,17 @@
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
+        "PublicDescription": "Counts streaming stores that have any type o=
f response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0xFBFF80822",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x7"
-    },
-    {
-        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "CounterMask": "1",
-        "EdgeDetect": "1",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY_COUNT",
-        "Invert": "1",
-        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
-        "SampleAfterValue": "100003",
-        "UMask": "0x7"
-    },
-    {
-        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 due to a resource in the back-end",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY_RESOURCE",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY_COUNT",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "CounterMask": "1",
-        "Deprecated": "1",
-        "EdgeDetect": "1",
-        "EventCode": "0xa5",
-        "EventName": "RS_EMPTY.COUNT",
-        "Invert": "1",
-        "SampleAfterValue": "100003",
-        "UMask": "0x7"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "Deprecated": "1",
-        "EventCode": "0xa5",
-        "EventName": "RS_EMPTY.CYCLES",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x7"
-    },
     {
         "BriefDescription": "Cycles the uncore cannot take further request=
s",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
-        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache).",
+        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache). Available PDIST=
 counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
index 50cacfbbc7cf..00b05a77c289 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
@@ -6,6 +6,7 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIVIDER_ACTIVE",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.DIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
@@ -15,7 +16,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
-        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
@@ -26,6 +27,7 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.FPDIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -35,6 +37,7 @@
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
+        "PublicDescription": "This event counts the cycles the integer div=
ider is busy. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -45,6 +48,7 @@
         "Deprecated": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 ARITH.IDIV_ACTIVE Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -53,7 +57,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
-        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1b"
     },
@@ -62,7 +66,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all branch instructions retired.",
+        "PublicDescription": "Counts all branch instructions retired. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "400009"
     },
     {
@@ -70,7 +74,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PublicDescription": "Counts conditional branch instructions retir=
ed.",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x11"
     },
@@ -79,7 +83,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
-        "PublicDescription": "Counts not taken branch instructions retired=
.",
+        "PublicDescription": "Counts not taken branch instructions retired=
. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x10"
     },
@@ -88,7 +92,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
@@ -97,7 +101,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PublicDescription": "Counts far branch instructions retired.",
+        "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
     },
@@ -106,7 +110,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch. Available PDIST co=
unters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -115,7 +119,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
     },
@@ -124,7 +128,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PublicDescription": "Counts return instructions retired.",
+        "PublicDescription": "Counts return instructions retired. Availabl=
e PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -133,7 +137,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts taken branch instructions retired.",
+        "PublicDescription": "Counts taken branch instructions retired. Av=
ailable PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
@@ -142,7 +146,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path. Available PDIST counters: 0",
         "SampleAfterValue": "400009"
     },
     {
@@ -150,7 +154,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x11"
     },
@@ -159,7 +163,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
-        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x10"
     },
@@ -168,7 +172,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
     },
@@ -177,7 +181,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
@@ -186,7 +190,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x2"
     },
@@ -195,7 +199,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken. Available PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
@@ -204,7 +208,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -213,7 +217,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -222,7 +226,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions. Availab=
le PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -231,7 +235,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
-        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x70"
     },
@@ -240,7 +244,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
-        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -249,7 +253,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "25003",
         "UMask": "0x2"
     },
@@ -258,6 +262,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -268,6 +273,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "PublicDescription": "CPU_CLK_UNHALTED.PAUSE_INST Available PDIST =
counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -276,7 +282,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
-        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -293,7 +299,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -310,7 +316,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. Available PDIST counters: 0",
         "SampleAfterValue": "2000003"
     },
     {
@@ -319,6 +325,7 @@
         "CounterMask": "8",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "PublicDescription": "Cycles while L1 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -328,6 +335,7 @@
         "CounterMask": "1",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
+        "PublicDescription": "Cycles while L2 cache miss demand load is ou=
tstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -337,6 +345,7 @@
         "CounterMask": "16",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "PublicDescription": "Cycles while memory subsystem has an outstan=
ding load. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -346,6 +355,7 @@
         "CounterMask": "12",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
+        "PublicDescription": "Execution stalls while L1 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xc"
     },
@@ -355,6 +365,7 @@
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
+        "PublicDescription": "Execution stalls while L2 cache miss demand =
load is outstanding. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
@@ -364,15 +375,25 @@
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "PublicDescription": "Total execution stalls. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb7",
+        "EventName": "EXE.AMX_BUSY",
+        "PublicDescription": "Counts the cycles where the AMX (Advance Mat=
rix Extension) unit is busy performing an operation. Available PDIST counte=
rs: 0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -381,6 +402,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 2 or 3 uops are executed on =
all ports and Reservation Station (RS) was not empty. Available PDIST count=
ers: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0xc"
     },
@@ -389,7 +411,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
-        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -398,7 +420,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -407,7 +429,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
-        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty. Available PDIST counters: =
0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -417,6 +439,7 @@
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
+        "PublicDescription": "Execution stalls while memory subsystem has =
an outstanding load. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x21"
     },
@@ -426,7 +449,7 @@
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
-        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
@@ -435,7 +458,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
-        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load. Available PDIST counters: 0"=
,
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
@@ -444,7 +467,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
-        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -452,7 +475,7 @@
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -469,6 +492,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -477,7 +501,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -485,7 +509,7 @@
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
-        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0. Available=
 PDIST counters: 32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -494,7 +518,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -505,7 +529,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEARS_COUNT",
-        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears Available PDIST count=
ers: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -514,7 +538,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
-        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
. Available PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x80"
     },
@@ -523,6 +547,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.MBA_STALLS",
+        "PublicDescription": "INT_MISC.MBA_STALLS Available PDIST counters=
: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -531,7 +556,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
-        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event. Available PDIST counters: 0",
         "SampleAfterValue": "500009",
         "UMask": "0x1"
     },
@@ -542,6 +567,7 @@
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x7",
+        "PublicDescription": "Bubble cycles of BAClear (Unknown Branch). A=
vailable PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
@@ -550,7 +576,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
-        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons Available P=
DIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -559,6 +585,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
+        "PublicDescription": "INT_VEC_RETIRED.128BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x13"
     },
@@ -567,6 +594,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
+        "PublicDescription": "INT_VEC_RETIRED.256BIT Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0xac"
     },
@@ -575,7 +603,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions. Available PDIST counters: 0=
",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
@@ -584,7 +612,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
-        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions. Available PDIST counters: 0=
",
         "SampleAfterValue": "1000003",
         "UMask": "0xc"
     },
@@ -593,6 +621,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
+        "PublicDescription": "INT_VEC_RETIRED.MUL_256 Available PDIST coun=
ters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
@@ -601,6 +630,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
+        "PublicDescription": "INT_VEC_RETIRED.SHUFFLES Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
@@ -609,6 +639,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
+        "PublicDescription": "INT_VEC_RETIRED.VNNI_128 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
@@ -617,6 +648,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
+        "PublicDescription": "INT_VEC_RETIRED.VNNI_256 Available PDIST cou=
nters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     },
@@ -625,7 +657,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address. Avail=
able PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -634,7 +666,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
-        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x88"
     },
@@ -643,7 +675,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x82"
     },
@@ -652,7 +684,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
+        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -662,7 +694,7 @@
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -672,7 +704,7 @@
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector). Available PDIST counters:=
 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -681,7 +713,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
-        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector). Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -692,7 +724,7 @@
         "EdgeDetect": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.COUNT",
-        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -701,7 +733,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
-        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -710,7 +742,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
-        "PublicDescription": "number of LFENCE retired instructions",
+        "PublicDescription": "number of LFENCE retired instructions Availa=
ble PDIST counters: 0",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
@@ -719,7 +751,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -728,7 +760,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
-        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -737,15 +769,69 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
+        "PublicDescription": "Counts cycles where the pipeline is stalled =
due to serializing operations. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses) Available PDIST counters: 0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_COUNT",
+        "Invert": "1",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events) Av=
ailable PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 due to a resource in the back-end",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
+        "PublicDescription": "Cycles when Reservation Station (RS) is empt=
y due to a resource in the back-end Available PDIST counters: 0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY_COUNT",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "Deprecated": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS_EMPTY.COUNT",
+        "Invert": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 RS.EMPTY_COUNT Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS_EMPTY.CYCLES",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 RS.EMPTY Available PDIST counters: 0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
     {
         "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
+        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources. Available PDIST counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x2"
     },
@@ -754,7 +840,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
-        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations. Available PDIST counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x4"
     },
@@ -763,7 +849,7 @@
         "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction. Ava=
ilable PDIST counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x8"
     },
@@ -772,6 +858,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "PublicDescription": "TOPDOWN.MEMORY_BOUND_SLOTS Available PDIST c=
ounters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x10"
     },
@@ -788,7 +875,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
-        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core. Available PDIST counters: 0",
         "SampleAfterValue": "10000003",
         "UMask": "0x1"
     },
@@ -797,6 +884,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
+        "PublicDescription": "UOPS_DECODED.DEC0_UOPS Available PDIST count=
ers: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -805,7 +893,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
-        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -814,7 +902,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
-        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -823,7 +911,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
-        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10 Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -832,7 +920,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
-        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9 Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -841,7 +929,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
-        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11 Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -850,7 +938,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
-        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -859,7 +947,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
-        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
@@ -868,7 +956,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE",
-        "PublicDescription": "Counts the number of uops executed from any =
thread.",
+        "PublicDescription": "Counts the number of uops executed from any =
thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -878,7 +966,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -888,7 +976,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -898,7 +986,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -908,7 +996,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -918,7 +1006,7 @@
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
-        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -928,7 +1016,7 @@
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
-        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -938,7 +1026,7 @@
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
-        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -948,7 +1036,7 @@
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
-        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -959,7 +1047,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
         "Invert": "1",
-        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread. Available PDIST counte=
rs: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -971,6 +1059,7 @@
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALL_CYCLES",
         "Invert": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UOPS_EXECUTED.STALLS Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -979,6 +1068,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
+        "PublicDescription": "Counts the number of uops to be executed per=
-thread each cycle. Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -987,7 +1077,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
-        "PublicDescription": "Counts the number of x87 uops executed.",
+        "PublicDescription": "Counts the number of x87 uops executed. Avai=
lable PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -996,7 +1086,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
-        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS). Available PD=
IST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1006,6 +1096,7 @@
         "CounterMask": "1",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.CYCLES",
+        "PublicDescription": "UOPS_ISSUED.CYCLES Available PDIST counters:=
 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1015,7 +1106,7 @@
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
-        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -1024,7 +1115,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
-        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count. Available P=
DIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1035,6 +1126,7 @@
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
+        "PublicDescription": "UOPS_RETIRED.MS Available PDIST counters: 0"=
,
         "SampleAfterValue": "2000003",
         "UMask": "0x4"
     },
@@ -1043,7 +1135,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
-        "PublicDescription": "Counts the retirement slots used each cycle.=
",
+        "PublicDescription": "Counts the retirement slots used each cycle.=
 Available PDIST counters: 0",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -1054,7 +1146,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALLS",
         "Invert": "1",
-        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops. Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -1066,6 +1158,7 @@
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "Invert": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UOPS_RETIRED.STALLS Available PDIST counters: 0",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.json
index 609a9549cbf3..3d3f88600e26 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/virtual-memory.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -14,7 +14,7 @@
         "CounterMask": "1",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load. Available PDIST cou=
nters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -23,7 +23,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault. Available =
PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
@@ -32,7 +32,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -41,7 +41,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -50,7 +50,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -59,7 +59,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle. Available PDIS=
T counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -68,7 +68,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
-        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB). Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -78,7 +78,7 @@
         "CounterMask": "1",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store. Available PDIST counters:=
 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -87,7 +87,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault. Available=
 PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
@@ -96,7 +96,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
-        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
     },
@@ -105,7 +105,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -114,7 +114,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -123,7 +123,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle. Available PDIST coun=
ters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -132,7 +132,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB). Available P=
DIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
@@ -142,7 +142,7 @@
         "CounterMask": "1",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
-        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     },
@@ -151,7 +151,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
-        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0xe"
     },
@@ -160,7 +160,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
@@ -169,7 +169,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
 Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
@@ -178,7 +178,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
--=20
2.49.0.472.ge94155a9ec-goog


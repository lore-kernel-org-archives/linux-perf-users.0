Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D919EEC2
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919309; cv=none; b=GqHT1Yx/qSCqKYxHYGjZqnqHx5t4U4djdrKsB1nxWzGn/RGGDAzP3OfQn70flNXi7j5Zs49sY2ITcrE4xZm3cs9avhM0VXZptcgnDQ1sf0p+7iZ/TG3Q3VXpDOhPpm3lVawevvR3E1LIMa2jSPVlJTU3iVCJ9argjZUrNSZR+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919309; c=relaxed/simple;
	bh=8ECLI9MH8G6GS+TQuT+0Q+DWep0ey0sdDAegVmCJBw4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IHQw984dMWwhWNEyxBuIETdpYCBpuoeKy5px+W9FnNzesSA/8s4s8lhGFKMY0p5FLpPqs8hPwa8Q23JrsNQYdV0pMKaAMNCssaMBB1TwJtQ7LtlasoLAZaY7tQHRYoz3rWzr4KMOfBic1Do5f4Lk5fZv9HZXXlmPfo8NwphRVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Byo+DRg/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Byo+DRg/"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e572df6db3eso8140733276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742919306; x=1743524106; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=Byo+DRg/Jpf01yN+mYcEidE3s1iwNH8GET5e8JWKEBBRFBC9o80R+jrn8H0C0MU6ly
         +8Taos0utPzT7LRAeDBfDVmR/XBF++KZbINJq7K/u9lkShj7mh+s9WRZKgZkibISeNOG
         FR26FbUOrXHYev9aWSdA5adNuzUx+JocQBlGFuuZ5Kj+W3cKHqat2qbCspGwNQBWKDrv
         L5WGdlkQZx+EToLF527DZPxZdyO/SNwY6NUmCxRBPtWcOMogOHJ0GVXMKuqO41xdMiS+
         yobtSGXk3REnXqp4niOrQ8O4zpKyjkgySWB7uV4I/wATURP/6E3LNQJPQJHHr5A7vzbM
         qLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919306; x=1743524106;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=Nk6/S4VSj/kMDgKdblniCL5eLhwtevGyEsPhf6ZsJb3WCFvUh9BGA2d8evCAwhFp2R
         BzfOeCKI0xe/WnmNEr1dgzyDaQSJWO38vwqBbwhG4ejhuEGZbrPxMRuEdAS0Ty8KR9uL
         Iv8mO0ps6GilP+JaDdTxY+jUC4y0yembMzh1NXzLHXdARYRhL+WdCfs9jAT2JDiemtUz
         M4nHp+dV6tnbMNGYhueFqcwlnuaHWCPCnoK3NIlSyPpfgiA1uy7WkF/deUxkKVZmOIZF
         q2YNdllEZPhyMm1sYRwv65Y5XIF6MDNrkEdo/phCVyVKhiJbYtQfw64zmVAg6g+oQt70
         Yygg==
X-Forwarded-Encrypted: i=1; AJvYcCWHDZNGA3BW59/4qC4+u09hmZfHIsc0AM8cxseYRlEBl8WjVUl+Zhv8oJgGNBGw32TTfnxDoF+opqPsEVDNMO77@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3ohbQMvP6qb1WMYTogJ8qF07lW9RxUxdsqNZgFTZhhkPGcc7
	ZVtsBPZRC4bWc6WuRarSKsOg9Aov+Vb/QVPSPD11DnF4q/rkFldhrKhzzA6H1miVH5IATByW4wD
	Nap9nIg==
X-Google-Smtp-Source: AGHT+IEtNXoWv6KEYbtcWvBOYeitom4UseomuszLQnbKoqHGGFQS9wpHj+8nfZZBN2w/KekwxeFfPG0+e8Yf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:260e:0:b0:e60:89be:bc51 with SMTP id
 3f1490d57ef6-e66a4a7aed5mr10977276.0.1742919306235; Tue, 25 Mar 2025 09:15:06
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:14:59 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 23/35] perf vendor events: Update nehalemep events
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
 .../pmu-events/arch/x86/nehalemep/cache.json  | 32 +++++++++++++++
 .../pmu-events/arch/x86/nehalemep/other.json  | 40 -------------------
 .../arch/x86/nehalemep/virtual-memory.json    |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
index b90026df2ce7..c9d154f1d09a 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
@@ -239,6 +239,38 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/other.json b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
index f6887b234b0e..5fe5ca778e9f 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
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
         "BriefDescription": "All loads dispatched",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
index e88c0802e679..accd263cfbfd 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
@@ -88,6 +88,14 @@
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
2.49.0.395.g12beb8f557-goog


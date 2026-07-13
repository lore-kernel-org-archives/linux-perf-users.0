Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126F353A9C
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966694; cv=none; b=uGCl0Y467Wg4k21BFuGXDd7uajkX55mskZDAk/VlU5CiQSyrdk6p0XE+9WBLwlYoFPyUvu05p/1qs9YqQlElXnBgIMzclJ91lOxkrkNnUhPENhBSwEqsWsg0MmVLPLAACcnrZsodVgsJiU7Sd+lE+tHY3SmCIqOnKp91ZYRuyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966694; c=relaxed/simple;
	bh=7vaVmbjxi9bdJzVqDmEDr7IGCOPn9DkI7esMtRPVxwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IzftcCypRpZ8vml9wdehDnKbsfmhhlxJ08jYg4b1+KZRjCq0eX5JNJQB4ZfvwGRqqN4VemBvBYLIrs+Tv4oFM5JQ9BurF+hxVr4vTbTp2CKCmE8ZOq7us9UEE+bShnHFfgEQ50K9COjvjuygHCs3zJe2n+gbjpIm65q4gX6v1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+KgfHJF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+KgfHJF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8486ffba174so5602618b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966692; x=1784571492; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zv7PT28vGFv+s+g5IQvKvOhb4VqlAQn14lDjoRaABs=;
        b=O+KgfHJFeNlWQOP7UXUSL8jibIxxvdKdhogJLQA6HTz3cYUqMmAlgk1sk88gcNFjsX
         3uAXIwZKHLUjJRzxrZhalPUKoeqU+RB3kxfIEnHDVNnYatCU0uWwIdgu7M9UdoS/Aq8u
         6zMunTzca6D3nK0LSYv0ToiuWT6J+pCsEbEPX/GkR6PIyA16L9aLQLq0XTio+ZngEb2R
         jEyxgfQu/snljPyUjai5sl/hTGQfBGbQHAJYvQUPj1Y9gmFw6cYyw0X+cdo0kY+NkC1N
         DS+bB3H/x06H9hXQ3Lp77Jqbw3Wl1iLYca2kspuFhiykUJuL1sIHLa6q/gBlnkmhxjie
         3zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966692; x=1784571492;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zv7PT28vGFv+s+g5IQvKvOhb4VqlAQn14lDjoRaABs=;
        b=ShdVHC+iyWI7zXfaxuS7KSGw6xMQxQ/5bawB3lAbrJ4RfrXb7i99Gnv9RsaDs4ByXz
         wm0mzkRcspqYQpHNQKjXX3pOdhuALpspZX2DHZLdxZOfpEQ3J+XmR7n1sHqURSTYTiHz
         8+Szx4Z2gL/NIenyw20g0tc6g2g0hnxqPCJXQuXceoMWZmvukpzNHhw9h+FwDhYSwI6i
         9Sl6b2hLLkJHvFimG4uOfZAE1OMizqfQ7keYp4ILmE2ETKp54DEd6DehLQwPcvMIwkx4
         xpqm5mqdQ7MepWxqFrKzbrEoZqJ864Xxrf/pQQkgZnmgKNUH/Q09cNXV1TExvngMzbvS
         c2zQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWXOWeD2VdirmSDvj3n3kK2Na4np4dqiSkA3B1+z2TEBG418Qgk4pgXbP0TyAA9HPYue3IliMd3QX4HLkNV5Mm@vger.kernel.org
X-Gm-Message-State: AOJu0YxcxrwhJTd7GmBFVlZEFuupFJUuGPCdTW0gcOHyFyxp8f2cQ2nf
	Z8CTLA+f0n8ENhcyIHZzI9E7GYnRlB0PmFf6IFdf4ztj++aF0O8WEfmRieJcvmHhnzjTvIssbUM
	yp/jYnA==
X-Received: from pfbdh4.prod.google.com ([2002:a05:6a00:4784:b0:847:7f5d:6b90])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd91:b0:848:731a:fa55
 with SMTP id d2e1a72fcca58-8488974b0fdmr8830709b3a.48.1783966691346; Mon, 13
 Jul 2026 11:18:11 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:56 -0700
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-12-ctshao@google.com>
Subject: [PATCH v1 11/12] perf vendor events intel: Update sierraforest events
 from 1.17 to 1.18
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, perry.taylor@intel.com, 
	Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/d1bc6c1e8b32e7a75c70cc939295c11ba9aabc96

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../arch/x86/sierraforest/counter.json        | 77 -------------------
 .../x86/sierraforest/uncore-interconnect.json | 10 +++
 .../arch/x86/sierraforest/uncore-memory.json  |  2 +-
 4 files changed, 12 insertions(+), 79 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index e4cc479a040d..8e4ee898942c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-(CC|D5|E5),v1.07,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.39,sapphirerapids,core
-GenuineIntel-6-AF,v1.17,sierraforest,core
+GenuineIntel-6-AF,v1.18,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/counter.json b/tools/perf/pmu-events/arch/x86/sierraforest/counter.json
deleted file mode 100644
index a92c75109e6a..000000000000
--- a/tools/perf/pmu-events/arch/x86/sierraforest/counter.json
+++ /dev/null
@@ -1,77 +0,0 @@
-[
-    {
-        "Unit": "core",
-        "CountersNumFixed": "3",
-        "CountersNumGeneric": "8"
-    },
-    {
-        "Unit": "B2CMI",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CHA",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "IMC",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CXLCM",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 8
-    },
-    {
-        "Unit": "CXLDP",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "B2HOT",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "IIO",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "IRP",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "UPI",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "B2UPI",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "B2CXL",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "PCU",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "CHACMS",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "MDF",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
-    }
-]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
index 251e5d20fefe..1f6e0970141a 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
@@ -814,6 +814,16 @@
         "PerPkg": "1",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Write Transactions as Secondary",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
index a9fd7a34b24b..8b7222a3708b 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
@@ -499,7 +499,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to (?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to page table : Counts the number of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT",
-- 
2.55.0.795.g602f6c329a-goog


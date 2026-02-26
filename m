Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187935A3B3
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128800; cv=none; b=mG+xrnciba84+cOArc+XdKolz3kBXCvAyskyyYq+T7nbZQwQk0kX4BB/smMUNqPXV/Li5LFkt8J3LaPDdu+KMkhnBFuujd8znsLzxS6SaMOw139k/bjC7z10krVkVek8n7e+G4n3zsJhzFkSFCqL0wOtLg2rjXJGhxVzXlS21hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128800; c=relaxed/simple;
	bh=QWA2t2SfpBqpm+HeFLwNfJEEbY23NbRB7TY91iiBvAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uMgwNNXB2QTju8vP5LJ+RkW9+ZzgclqF8a4SUwZ7ksR4uGb9Nz7kHTN4mpuFaK8YqgIEn6f8FmSykylB3m8yD1SzWYaHG7Nwh/CUrHcmaso1hC71un2fCL/h5i8CXC0qtFuu/BOBikkbTKzqALvkl+KPbUigSlXtuR6mzxnk2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDq2tieF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDq2tieF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd4ce8dc3so15289129eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772128798; x=1772733598; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9IYxdgBLU5Ki2XKkdZb6JYvsW9cUiH1hG77z1/Bhhw=;
        b=LDq2tieF6mQfOpl9oPYdYg6U9YE0GBVoilD02Ypf1et6yaLmcqxcqYmhXeH71ihZAO
         UpsiM7uowYM/9ijZgIryZDYceXa/mTCGpNfmq1w83Tw27gWJHSgS6DBtk8erI+8UuQ3R
         dhS5ffUBtdu6JXxprDVFPdxcK9VBdiABf1h+XMxz9vyPZ43LWzzyK9rlVZf/R4vJSQpp
         nBKbrF7I5hTx8L5JP0OP4pwfQ2zS119L7cclSolXh6FdCcL5eVfJfsB5Wm/9C+OBtK1d
         XYw2GctSKQYsg5774URPNLJY4YgKyPn+yfJMkxxs1WwlDPjQrG/h9PEhvCR9mD1n6bet
         Icfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772128798; x=1772733598;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9IYxdgBLU5Ki2XKkdZb6JYvsW9cUiH1hG77z1/Bhhw=;
        b=BDKWLVsWgdw9/ksGfZ52Xy5l0QGTfIJEr2OElgK9OYZayNsuRRrcyZBOlKXjjMLejC
         ngkk5NsOi90KOl19E/IzXyAfU/zhZcXG6W5/VU+W0Mu5LyEsh4JvGHOdhacAQlQsFb9W
         /hSGElyoHuce27YfsTh72H0hNUSiVusimfnAgdv5E9qLwmwaialu73sT2JvGFJAWaWYf
         CeN8qRsjP51zDMNmJ8OMfpnr7s1cBFOwqzqLHWzwBAuGIhe/uYjCRJ7AN0nDr/JY1Snl
         J68OgLyhARMdTB8zy1W/J1pWDtEOF/D9soUHW2b0pxCLbCHon5qxhiHYc/3Pwcl0oX7g
         1gjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIKLaIuKHU83Hi2xptK8P6IRO1IRCirKgJ4/zgKUaHBYr9FB/iLqPd59dNFd/qPCgJcB+VMHc8NdBn7nGmWCNS@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbFiIbHY3pg6RcUym4kBwyKxsI0HCWT7adFMOJBCs9WA8zglv
	krLrIPjGATRb3OJpSoB1RGhsrELElayX59r23d5lEV3Eni0uLWsyz+H7q4P1iWDjkDqmR6xTLX3
	7P6cxkS1FJw==
X-Received: from dycsb15.prod.google.com ([2002:a05:693c:300f:b0:2bd:df3a:f2c3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:434b:b0:2b0:571a:28a5
 with SMTP id 5a478bee46e88-2bd7bd2aacemr10303684eec.18.1772128798073; Thu, 26
 Feb 2026 09:59:58 -0800 (PST)
Date: Thu, 26 Feb 2026 09:59:35 -0800
In-Reply-To: <20260226175936.593159-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226175936.593159-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260226175936.593159-9-irogers@google.com>
Subject: [PATCH v2 09/10] perf vendor events intel: Update sapphirerapids
 events from 1.35 to 1.36
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/bda7f1e1839e2f9ea1ac45da338e6fe5ca6=
fdbb0

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv      |  2 +-
 .../arch/x86/sapphirerapids/cache.json          |  4 ++--
 .../arch/x86/sapphirerapids/frontend.json       | 16 ++++++++++++++++
 .../arch/x86/sapphirerapids/uncore-cache.json   |  4 ++--
 .../arch/x86/sapphirerapids/uncore-io.json      | 17 +++++++++--------
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 0839e21d4006..8ef03af9f150 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.04,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
-GenuineIntel-6-8F,v1.35,sapphirerapids,core
+GenuineIntel-6-8F,v1.36,sapphirerapids,core
 GenuineIntel-6-AF,v1.13,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index c66324d41a89..373b26c84448 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -514,7 +514,7 @@
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
         "PublicDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM Availab=
le PDIST counters: 0",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "100007",
         "UMask": "0x2"
     },
     {
@@ -534,7 +534,7 @@
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
         "PublicDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM Availab=
le PDIST counters: 0",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "100007",
         "UMask": "0x4"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index 793c486ffabe..e51f5e85ffd1 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -271,6 +271,22 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "ICACHE_TAG.STALLS_INUSE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_INUSE",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "ICACHE_TAG.STALLS_ISB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_ISB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
index 1bdda3c3ccbf..59f6fd2c7a8f 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json
@@ -3501,7 +3501,7 @@
         "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a a transaction with the opcode =
type RspIFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data and the requesting agent is able to acquire the dat=
a in E (Exclusive) or M (modified) states.  This is commonly returned with =
RFO (the Read for Ownership issued before a write) transactions.  The snoop=
 could have either been to a cacheline in the M,E,F (Modified, Exclusive or=
 Forward)  states.",
+        "PublicDescription": "Counts when a transaction with the opcode ty=
pe RspIFwd Snoop Response was received which indicates a remote caching age=
nt forwarded the data and the requesting agent is able to acquire the data =
in E (Exclusive) or M (modified) states.  This is commonly returned with RF=
O (the Read for Ownership issued before a write) transactions.  The snoop c=
ould have either been to a cacheline in the M,E,F (Modified, Exclusive or F=
orward)  states.",
         "UMask": "0x4",
         "Unit": "CHA"
     },
@@ -3523,7 +3523,7 @@
         "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a a transaction with the opcode =
type RspSFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data but held on to its current copy.  This is common fo=
r data and code reads that hit in a remote socket in E (Exclusive) or F (Fo=
rward) state.",
+        "PublicDescription": "Counts when a transaction with the opcode ty=
pe RspSFwd Snoop Response was received which indicates a remote caching age=
nt forwarded the data but held on to its current copy.  This is common for =
data and code reads that hit in a remote socket in E (Exclusive) or F (Forw=
ard) state.",
         "UMask": "0x8",
         "Unit": "CHA"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
index dac7e6c50f31..45675a1099e2 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-io.json
@@ -303,6 +303,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
+        "PortMask": "0xff",
         "UMask": "0xff",
         "Unit": "IIO"
     },
@@ -314,7 +315,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x01",
         "PublicDescription": "x16 card plugged in to stack, Or x8 card plu=
gged in to Lane 0/1, Or x4 card is plugged in to slot 0",
         "UMask": "0x1",
         "Unit": "IIO"
@@ -327,7 +328,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x02",
         "PublicDescription": "x4 card is plugged in to slot 1",
         "UMask": "0x2",
         "Unit": "IIO"
@@ -340,7 +341,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x04",
         "PublicDescription": "x8 card plugged in to Lane 2/3, Or x4 card i=
s plugged in to slot 1",
         "UMask": "0x4",
         "Unit": "IIO"
@@ -353,7 +354,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x08",
         "PublicDescription": "x4 card is plugged in to slot 3",
         "UMask": "0x8",
         "Unit": "IIO"
@@ -366,7 +367,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x10",
         "PublicDescription": "x16 card plugged in to stack, Or x8 card plu=
gged in to Lane 0/1, Or x4 card is plugged in to slot 0",
         "UMask": "0x10",
         "Unit": "IIO"
@@ -379,7 +380,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x20",
         "PublicDescription": "x4 card is plugged in to slot 1",
         "UMask": "0x20",
         "Unit": "IIO"
@@ -392,7 +393,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x40",
         "PublicDescription": "x8 card plugged in to Lane 2/3, Or x4 card i=
s plugged in to slot 1",
         "UMask": "0x40",
         "Unit": "IIO"
@@ -405,7 +406,7 @@
         "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
-        "PortMask": "0x0000",
+        "PortMask": "0x80",
         "PublicDescription": "x4 card is plugged in to slot 3",
         "UMask": "0x80",
         "Unit": "IIO"
--=20
2.53.0.414.gf7e9f6c205-goog


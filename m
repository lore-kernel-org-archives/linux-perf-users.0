Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E930F549
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821289; cv=none; b=FOJMd72zqc4lS4Ic1hjbteLF0Y1YhfJbvFiFk0WBWzN8SfvPVqkGoxTXqq6lJefxiTOkjkJvrxtr0wpppZJPk6obTns/rrOIksGKLc53AXbmNPV0gesUaB37kVfCLLCxuQ9glx1as/SzgY4JNKvYqVkqU4/HaoUknCSJ/r5kMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821289; c=relaxed/simple;
	bh=iC0TWZ2QXMOTuJvOVQ/wqrTUOgYL32EwVTgHTQ199CA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DM/xZVY2F0NdmxwFpckET8VoRCPUAWYMgoZCjZ5a+isWRz28Da4gs1meXVldl2Ih9QnU7S2PLR8yA9fIo8fjw2uHGCzZWODxRJ6kgzo2aE5lQ52r2j/O0VALiskIrS2L/ArdxUxzrJTI0IfeLxABdN6RGVo8hgDBKm8dL5yQmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvCaFufd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvCaFufd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4f86568434so961797a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758821278; x=1759426078; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDBI+/JeHBu5kMHczfbEQKZFmRmb9bCcNtaJ4aEjX0k=;
        b=BvCaFufdP1B72bzlmgveXtOvGq6G8LUvJlYBxyPb7Yz2KWobLEeQQVl0ICA8NXUspU
         yh33NHA2l7TL1h0B/+OvEckILmSc+9I9vZ8dtSaey4QoKyUaovRfNUVvDp5dQZL1Sx8j
         qS3+GPUbTXQrFfJgAt3tlXswr2PO4lLguEbtePMydlQC47Qi+vJ1D01MDxHNxYEGf620
         B6CeRSv3ajrhvTzFxKUubrmj1SwwYe8I481S+eUlpuMZJK2478nyVcMcTSd6cDOXQRYS
         aqXJsrfCIKCkAh5GRO6tD0rnHdkvPYZRpw4M368vdopcgUKMSIqHodYSUg/S6aWpbaHD
         aZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821278; x=1759426078;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDBI+/JeHBu5kMHczfbEQKZFmRmb9bCcNtaJ4aEjX0k=;
        b=MFQP6kP1rjICa8p1PaV/sdIQPzPS0HeZ9nSv7PqRbgZaPsfowCU/grOS35m8EuFJ/M
         HgG0r3PXRhvKG5gzZJ5aofh1Eb/SMQUdZaPrETYKtd8dy7/kcM4vjlSeHakuMWMeiMPX
         mW0S/dxqTh7cwKNzPV5dZnIBCrxo3m/jbMRIfry6rrmVMNIFj+cg3L3o0r2CXKcJ+KYu
         Cjs38LkG0EJZJaz6wx6S0eIKS7/tZy+2c4DtOsHmumdc3dJPeVg0OCCUCFvKm7v3byx0
         1GkXRdi7WnX2/b0OPZ1hRGZwIssPr3gblF2vNp2tfUyNSoE0lqSctGkiDg/f0CshfiTg
         NqqA==
X-Forwarded-Encrypted: i=1; AJvYcCVDJuu7hWm7XPVBTULmlMQKskGFQbwOJcrVP6avHZqzyl9QVT2QJ62px9enXfg8itMDzfhXe+iRuTwy8XcZLLgC@vger.kernel.org
X-Gm-Message-State: AOJu0YykogVgxE0nPfzXSfZ5WfmgvefWd756XP887MgZJZwmBKwexEY0
	BwklcLwHvZCHlNg/cIsWA3qc5odQ7VJDOPMXsb5Jlc51b9AhrcmoX4GpA3j9Ts4dBBcXmPQGLSC
	ef52xulRDSw==
X-Google-Smtp-Source: AGHT+IGNPferN6WKh5FwmoffK1aazW0OVl/ZF6yfkw/edPNVQ7t+gvdFjc//mihHmjvJVVgBZWrHzDCZYAgj
X-Received: from pgdy23.prod.google.com ([2002:a65:6417:0:b0:b4c:1faf:432c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a127:b0:263:b3:d8d4
 with SMTP id adf61e73a8af0-2e7bf47c155mr5485894637.12.1758821277702; Thu, 25
 Sep 2025 10:27:57 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:27:34 -0700
In-Reply-To: <20250925172736.960368-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250925172736.960368-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925172736.960368-9-irogers@google.com>
Subject: [PATCH v2 08/10] perf vendor events intel: Update pantherlake events
 to v1.00
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update pantherlake events to v1.00 released in:
https://github.com/intel/perfmon/commit/b149786b6f9db18c09e6c89f3eb4fdb849e=
ad2cf

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/pantherlake/cache.json           | 1207 ++++++++++-
 .../arch/x86/pantherlake/counter.json         |    9 +-
 .../arch/x86/pantherlake/floating-point.json  |  286 +++
 .../arch/x86/pantherlake/frontend.json        |  535 +++++
 .../arch/x86/pantherlake/memory.json          |  106 +-
 .../arch/x86/pantherlake/other.json           |   44 +
 .../arch/x86/pantherlake/pipeline.json        | 1776 ++++++++++++++++-
 .../arch/x86/pantherlake/uncore-memory.json   |   26 +
 .../arch/x86/pantherlake/virtual-memory.json  |  248 +++
 9 files changed, 4061 insertions(+), 176 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/floating-poi=
nt.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-memor=
y.json

diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/cache.json
index c84f3d9fdb10..7098ea1d6d16 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
@@ -1,4 +1,135 @@
 [
+    {
+        "BriefDescription": "Counts the number of cache lines replaced in =
L0 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x51",
+        "EventName": "L1D.L0_REPLACEMENT",
+        "PublicDescription": "Counts L0 data line replacements including o=
pportunistic replacements, and replacements that require stall-for-replace =
or block-for-replace.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cachelines replaced into the L1 d-cache. Succ=
essful replacements only (not blocked) and exclude WB-miss case",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x51",
+        "EventName": "L1D.L1_REPLACEMENT",
+        "PublicDescription": "Counts cachelines replaced into the L1 d-cac=
he.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cachelines replaced into the L0 and L1 d-cach=
e. Successful replacements only (not blocked) and exclude WB-miss case",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x51",
+        "EventName": "L1D.REPLACEMENT",
+        "PublicDescription": "Counts cachelines replaced into the L0 and L=
1 d-cache.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x49",
+        "EventName": "L1D_MISS.FB_FULL",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x49",
+        "EventName": "L1D_MISS.L2_STALLS",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of demand requests that missed L1D cac=
he",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x49",
+        "EventName": "L1D_MISS.LOAD",
+        "PublicDescription": "Count occurrences (rising-edge) of DCACHE_PE=
NDING sub-event0. Impl. sends per-port binary inc-bit the occupancy increas=
es* (at FB alloc or promotion).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of L1D misses that are outstanding",
+        "Counter": "2",
+        "EventCode": "0x48",
+        "EventName": "L1D_PENDING.LOAD",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "Counter": "2",
+        "CounterMask": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PENDING.LOAD_CYCLES",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "L2 cache lines filling L2",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.ALL",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Exclusive state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.E",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Exclusive state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Modified cache lines that are evicted by L2 c=
ache when triggered by an L2 cache fill.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.USELESS_HWPF",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests for Code Read, Data Read, RFO, ITOM, and L2 Prefetches. =
Does not include rejects or recycles, per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -8,6 +139,35 @@
         "UMask": "0x1ff",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES, L2_RQSTS.ANY]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES, L2_RQSTS.ANY]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests that resulted in a Hit. Does not include rejects or recy=
cles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1bf",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_RQSTS.MISS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "L2 code requests",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -29,65 +189,645 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES, L2_REQUEST.ALL]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ANY",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES, L2_REQUEST.ALL]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_HIT",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x44",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "L2 cache misses when fetching instructions",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_MISS",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x24",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand Data Read miss L2 cache",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_REQUEST.MISS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.MISS",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_REQUEST.ALL,L2_RQSTS.ANY]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL,L2_RQSTS.ANY]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "RFO requests that hit L2 cache",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x42",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "RFO requests that miss L2 cache",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x22",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when =
the L1D is locked.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 core has access to an L3 cache, the LLC is the L3 cache, otherwise it is t=
he L2 cache. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x41",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
core has access to an L3 cache, the LLC is the L3 cache, otherwise it is th=
e L2 cache. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4f",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an L1 demand load miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_HIT",
+        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to a demand load which hit in the L2 cache.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x38",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the caches.  DR=
AM, MMIO or other LOCAL memory type provides the data.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts all retired load instructions.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
+        "PublicDescription": "Counts Instructions with at least one archit=
ecturally visible load retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired store instructions.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_STORES",
+        "PublicDescription": "Counts all retired store instructions. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired software prefetch instructions.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_SWPF",
+        "PublicDescription": "Counts all retired software prefetch instruc=
tions. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x84",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "All retired memory instructions.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ANY",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x87",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions with locked access.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
+        "PublicDescription": "Counts retired load instructions with locked=
 access. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x21",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x42",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that hit the STLB.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_ANY",
+        "PublicDescription": "Number of retired instructions with a clean =
hit in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0xf",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions that hit the STLB."=
,
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
+        "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x9",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired store instructions that hit the STLB.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
+        "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0xa",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired SWPF instructions that hit the STLB."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_HIT_SWPF",
+        "PublicDescription": "Number of retired SWPF instructions that hit=
 in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that miss the STLB.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_ANY",
+        "PublicDescription": "Number of retired instructions that (start a=
) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x17",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x11",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired store instructions that miss the STLB=
.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x12",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired SWPF instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_SWPF",
+        "PublicDescription": "Number of retired SWPF instructions that (st=
art a) miss in the 2nd-level TLB (STLB). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x14",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were a cross-core Snoop hits and forwards data from an in on-package core c=
ache (induced by NI$)",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were a cross-core Snoop hits and forwards data from an in on-packag=
e core cache (induced by NI$) Available PDIST counters: 0,1",
+        "SampleAfterValue": "20011",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3, Hit-with-FWD is normally excluded.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3, Hit-with-FWD is normally exclud=
ed. Available PDIST counters: 0,1",
+        "SampleAfterValue": "20011",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache. A=
vailable PDIST counters: 0,1",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache. Available P=
DIST counters: 0,1",
+        "SampleAfterValue": "20011",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions which data source i=
s memory side cache.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.MEMSIDE_CACHE",
+        "PublicDescription": "Retired load instructions which data source =
is memory side cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock). Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready. Available PDIST counters:=
 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source. Available PDIST c=
ounters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x101",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts retired load instructions with at leas=
t one uop that hit in the Level 0 of the L1 data cache. This event includes=
 all SW prefetches and lock instructions regardless of the data source.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT_L0",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 0 of the L1 data cache. This event include=
s all SW prefetches and lock instructions regardless of the data source. Av=
ailable PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts retired load instructions with at leas=
t one uop that hit in the Level 1 of the L1 data cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT_L1",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the Level 1 of the L1 data cache. Available PDIST co=
unters: 0,1",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources. Available PDIST counters: 0,1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100021",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "50021",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss the L3 cache and hit in DRAM Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in memside cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.MEMSIDE_CACHE",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss the L3 cache and hit in memside cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it the L1 data cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss in the L1 data cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L2 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss in the L2 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1c",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
         "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 core has access to an L3 cache, the LLC is the L3 cache, otherwise it is t=
he L2 cache. Counts on a per core basis.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
         "SampleAfterValue": "1000003",
-        "UMask": "0x41",
+        "UMask": "0x2",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
-        "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x41",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.RSV",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
         "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
core has access to an L3 cache, the LLC is the L3 cache, otherwise it is th=
e L2 cache. Counts on a per core basis.",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
         "SampleAfterValue": "1000003",
-        "UMask": "0x4f",
+        "UMask": "0x1",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0x2e",
-        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x4f",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Counts all retired load instructions.",
-        "Counter": "0,1,2,3",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PublicDescription": "Counts Instructions with at least one archit=
ecturally visible load retired. Available PDIST counters: 0",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x81",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Retired store instructions.",
-        "Counter": "0,1,2,3",
-        "Data_LA": "1",
-        "EventCode": "0xd0",
-        "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PublicDescription": "Counts all retired store instructions. Avail=
able PDIST counters: 0",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x82",
+        "BriefDescription": "Number of cache-lines required by retired sto=
res whose Data Source is: Memory Side Cache",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.MEMSIDE_CACHE",
+        "SampleAfterValue": "100021",
         "Unit": "cpu_core"
     },
     {
@@ -95,6 +835,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "PublicDescription": "Counts the number of load ops retired. Avail=
able PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
         "Unit": "cpu_atom"
@@ -104,129 +845,245 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "PublicDescription": "Counts the number of store ops retired. Avai=
lable PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
+        "PublicDescription": "Counts the number of load uops retired that =
performed one or more locks Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x21",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t were splits. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x43",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split load uops.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "Counts the number of retired split load uops=
. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x41",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split store uops=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "PublicDescription": "Counts the number of retired split store uop=
s. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x42",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t missed in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "PublicDescription": "Counts the number of load uops retired that =
miss in the second Level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x11",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "PublicDescription": "Counts the number of store uops retired that=
 miss in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x12",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
+        "PublicDescription": "Counts the number of  stores uops retired sa=
me as MEM_UOPS_RETIRED.ALL_STORES Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Retired memory uops for any access",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe5",
+        "EventName": "MEM_UOP_RETIRED.ANY",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xf",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines that=
 were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E00008",
+        "PublicDescription": "Counts writebacks of modified cachelines tha=
t were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts writebacks of non-modified cachelines =
that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_NONM.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E01000",
+        "PublicDescription": "Counts writebacks of non-modified cachelines=
 that were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -241,7 +1098,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -251,6 +1108,30 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop hit in another cores caches, data forwarding i=
s required as the data is modified.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x40001E00001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by the L3 cache where a snoop hit in another cores caches, data forwarding =
is required as the data is modified. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop hit in another cores caches which forwarded th=
e unmodified data to the requesting core.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x20001E00001",
+        "PublicDescription": "Counts demand data reads that were supplied =
by the L3 cache where a snoop hit in another cores caches which forwarded t=
he unmodified data to the requesting core. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -265,7 +1146,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -274,5 +1155,221 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were su=
pplied by the L3 cache where a snoop hit in another cores caches, data forw=
arding is required as the data is modified.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x40001E00002",
+        "PublicDescription": "Counts demand read for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by the L3 cache where a snoop hit in another cores caches, data for=
warding is required as the data is modified. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read, RFO and ITOM=
 requests including demands and prefetches to the core caches (L1 or L2) th=
at were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E04477",
+        "PublicDescription": "Counts all data read, code read, RFO and ITO=
M requests including demands and prefetches to the core caches (L1 or L2) t=
hat were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Any memory transaction that reached the SQ.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "PublicDescription": "Counts memory transactions reached the super=
 queue including requests initiated by the core, all L3 prefetches, page wa=
lks, etc..",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DATA_RD",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cacheable and Non-Cacheable code read request=
s",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
+        "PublicDescription": "Counts both cacheable and Non-Cacheable code=
 read requests.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PublicDescription": "Counts cycles when offcore outstanding cache=
able Core Data Read transactions are present in the super queue. A transact=
ion is considered to be in the Offcore outstanding state between L2 miss an=
d transaction completion sent to requestor (SQ de-allocation). See correspo=
nding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding Code Reads tr=
ansactions in the SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 outstanding demand da=
ta read request is pending.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with offcore outstanding demand rfo re=
ads transactions in SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
+        "PublicDescription": "Counts the number of offcore outstanding dem=
and rfo Reads transactions in the super queue every cycle. The 'Offcore out=
standing' state of the transaction lasts from the L2 miss until the sending=
 transaction completion to requestor (SQ deallocation). See the correspondi=
ng Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Offcore outstanding cacheable Core Data Read =
transactions in SuperQueue (SQ), queue to uncore",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "PublicDescription": "Counts the number of offcore outstanding cac=
heable Core Data Read transactions in the super queue every cycle. A transa=
ction is considered to be in the Offcore outstanding state between L2 miss =
and transaction completion sent to requestor (SQ de-allocation). See corres=
ponding Umask under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Offcore outstanding Code Reads transactions i=
n the SuperQueue (SQ), queue to uncore, every cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
+        "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Store Read transactions pending for off-core.=
 Highly correlated.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_RFO",
+        "PublicDescription": "Counts the number of off-core outstanding re=
ad-for-ownership (RFO) store transactions every cycle. An RFO transaction i=
s considered to be in the Off-core outstanding state between L2 cache miss =
and transaction completion.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2c",
+        "EventName": "SQ_MISC.BUS_LOCK",
+        "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of PREFETCHNTA, PREFETCHW, =
PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.ANY",
+        "SampleAfterValue": "100003",
+        "UMask": "0xf",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/counter.json b/tool=
s/perf/pmu-events/arch/x86/pantherlake/counter.json
index 69f158a97707..432b6946ccbc 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/counter.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/counter.json
@@ -1,12 +1,17 @@
 [
     {
         "Unit": "cpu_atom",
-        "CountersNumFixed": "3",
-        "CountersNumGeneric": "39"
+        "CountersNumFixed": "7",
+        "CountersNumGeneric": "8"
     },
     {
         "Unit": "cpu_core",
         "CountersNumFixed": "4",
         "CountersNumGeneric": "10"
+    },
+    {
+        "Unit": "iMC",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "5"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
new file mode 100644
index 000000000000..57c26866bc79
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
@@ -0,0 +1,286 @@
+[
+    {
+        "BriefDescription": "Cycles when floating-point divide unit is bus=
y executing divide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for floating-point operatio=
ns only.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts all microcode FP assists.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.FP",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "ASSISTS.SSE_AVX_MIX",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.SSE_AVX_MIX",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of FP-arith-uops dispatched on 1st VEC=
 port (port 0). FP-arith-uops are of type ADD* / SUB* / MUL / FMA* / DPP.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of FP-arith-uops dispatched on 2nd VEC=
 port (port 1)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of FP-arith-uops dispatched on 3rd VEC=
 port (port 5)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V2",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of FP-arith-uops dispatched on 4th VEC=
 port",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.V3",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.128B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.128B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.256B_PACKED_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.256B_PACKED_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.4_FLOPS",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
+        "SampleAfterValue": "100003",
+        "UMask": "0x18",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below.  Applies to SSE* and AVX* scalar, double and single precision floati=
ng-point: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR_DOUBLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.SCALAR_SINGLE",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR",
+        "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3c",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.VECTOR_128B",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR_128B",
+        "SampleAfterValue": "100003",
+        "UMask": "0xc",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "FP_ARITH_OPS_RETIRED.VECTOR_256B",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_OPS_RETIRED.VECTOR_256B",
+        "SampleAfterValue": "100003",
+        "UMask": "0x30",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of all types of floating po=
int operations per uop with all default weighting",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of all types of floating p=
oint operations per uop with all default weighting Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 32 bit single precision results",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP32",
+        "PublicDescription": "Counts the number of floating point operatio=
ns that produce 32 bit single precision results Available PDIST counters: 0=
,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 64 bit double precision results",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP64",
+        "PublicDescription": "Counts the number of floating point operatio=
ns that produce 64 bit double precision results Available PDIST counters: 0=
,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 128 bit double precision floating point. This may b=
e SSE or AVX.128 operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.128B_DP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 128 bit double precision floating point. This may =
be SSE or AVX.128 operations. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 128 bit single precision floating point. This may b=
e SSE or AVX.128 operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.128B_SP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 128 bit single precision floating point. This may =
be SSE or AVX.128 operations. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 256 bit double precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.256B_DP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 256 bit double precision floating point. Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 256 bit single precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.256B_SP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 256 bit single precision floating point. Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a scalar 32bit single precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.32B_SP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a scalar 32bit single precision floating point. Available P=
DIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a scalar 64 bit double precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.64B_DP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a scalar 64 bit double precision floating point. Available =
PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of  floating point re=
tired instructions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.ALL",
+        "PublicDescription": "Counts the total number of  floating point r=
etired instructions. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3f",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FP_ASSIST",
+        "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/frontend.json
index aedf631e3c0f..d36faa683d3f 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
@@ -1,4 +1,369 @@
 [
+    {
+        "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Clears due to Unknown Branches.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x60",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to a condit=
ional jump.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.COND",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to an indir=
ect branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.INDIRECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to a return=
 branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.RETURN",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to a direct=
, unconditional jump.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.UNCOND",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles the Microcode Sequencer is busy.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x87",
+        "EventName": "DECODE.MS_BUSY",
+        "SampleAfterValue": "500009",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x61",
+        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired ANT branches",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted) Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x1",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. Availa=
ble PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x11",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to IT=
LB miss Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x14",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L1I_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x12",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L2_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x13",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x608006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x601006",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600206",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x610006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x100206",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x602006",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600406",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall. Available PDIST count=
ers: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x620006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall. Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x604006",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall. Available PDIST coun=
ters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600806",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted Retired ANT branches",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MISP_ANT",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x9",
+        "PublicDescription": "ANT retired branches that got just mispredic=
ted Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts flows delivered by the Microcode Seque=
ncer",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MS_FLOWS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PublicDescription": "Counts flows delivered by the Microcode Sequ=
encer Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.STLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x15",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired instructions that caused clears due t=
o being Unknown Branches.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x17",
+        "PublicDescription": "Number retired branch instructions that caus=
ed the front-end to be resteered when it finds the instruction in a fetch l=
ine. This is called Unknown Branch which occurs for the first time a branch=
 instruction is fetched or when the branch is not tracked by the BPU (Branc=
h Prediction Unit) anymore. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to Ins=
truction L1 cache miss, that hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L2_HIT",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to In=
struction L1 cache miss, that hit in the L2 cache. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss that hit in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ITLB_STLB_HIT",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to IT=
LB miss that hit in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss that also missed the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ITLB_STLB_MISS",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to IT=
LB miss that also missed the second level TLB. Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -8,6 +373,15 @@
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are present.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are not present=
. -",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -17,6 +391,134 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALLS",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "ICACHE_DATA.STALL_PERIODS",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALL_PERIODS",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "8",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering any Uop",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_ANY",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "8",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_OK",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_UOPS",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_CYCLES_ANY",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_SWITCHES",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops initiated by MITE or Decode Stream Buffe=
r (DSB) and delivered to Instruction Decode Queue (IDQ) while Microcode Seq=
uencer (MS) is busy",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_UOPS",
+        "PublicDescription": "Counts the number of uops initiated by MITE =
or Decode Stream Buffer (DSB) and delivered to Instruction Decode Queue (ID=
Q) while the Microcode Sequencer (MS) is busy. Counting includes uops that =
may 'bypass' the IDQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that when no operation was delivered to the back-end pipeline due =
to instruction fetch limitations when the back-end could have accepted more=
 operations. Common examples include instruction cache misses or x86 instru=
ction decode limitations.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -26,5 +528,38 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are delivered by the IDQ =
for 2 or more cycles when backend of the machine is not stalled - normally =
indicating a Fetch Latency issue",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.FETCH_LATENCY",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls for 2 or more cycles - normally in=
dicating a Fetch Latency issue.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "8",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_BUBBLES.STARVATION_CYCLES",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json b/tools=
/perf/pmu-events/arch/x86/pantherlake/memory.json
index 47daee8cc00f..397a15dbb964 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
@@ -1,4 +1,32 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a core bound stall includin=
g a store address match, a DTLB miss or a page walk that detains the load f=
rom retiring.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_BOUND_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xf4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
         "Counter": "2,3,4,5,6,7,8,9",
@@ -7,7 +35,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0,1",
         "SampleAfterValue": "53",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -20,7 +48,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0,1",
         "SampleAfterValue": "1009",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -33,7 +61,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0,1",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -46,7 +74,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency. Available PDIST count=
ers: 0,1",
         "SampleAfterValue": "23",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -59,7 +87,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0,1",
         "SampleAfterValue": "503",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -72,7 +100,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -85,7 +113,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0,1",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -98,7 +126,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency. Available PDIST counte=
rs: 0,1",
         "SampleAfterValue": "101",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -111,7 +139,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency. Available PDIST counter=
s: 0,1",
         "SampleAfterValue": "2003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -124,7 +152,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency. Available PDIST counters=
: 0,1",
         "SampleAfterValue": "50021",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -135,11 +163,31 @@
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
-        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8 Availab=
le PDIST counters: 0",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8 Availab=
le PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts misaligned loads that are 4K page spli=
ts.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
+        "PublicDescription": "Counts misaligned loads that are 4K page spl=
its. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts misaligned stores that are 4K page spl=
its.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
+        "PublicDescription": "Counts misaligned stores that are 4K page sp=
lits. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -154,7 +202,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -178,7 +226,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -202,7 +250,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -211,5 +259,35 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where data return is pending for a Dem=
and Data Read request who miss L3 cache.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_L3_MISS_DEM=
AND_DATA_RD",
+        "PublicDescription": "Cycles with at least 1 Demand Data Read requ=
ests who miss L3 cache in the superQ.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
+        "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/other.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/other.json
new file mode 100644
index 000000000000..d49651d4f112
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/other.json
@@ -0,0 +1,44 @@
+[
+    {
+        "BriefDescription": "Count all other hardware assists or traps tha=
t are not necessarily architecturally exposed (through a software handler) =
beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-eve=
nts.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.HARDWARE",
+        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "ASSISTS.PAGE_FAULT",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.PAGE_FAULT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "PublicDescription": "Counts streaming stores that have any type o=
f response. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles the uncore cannot take further request=
s",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x2d",
+        "EventName": "XQ.FULL",
+        "PublicDescription": "number of cycles when the thread is active a=
nd the uncore cannot take any further requests (for example prefetches, loa=
ds or stores initiated by the Core that miss the L2 cache).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index 2caf2f85327f..2d805ac98c5b 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -1,10 +1,51 @@
 [
+    {
+        "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when integer divide unit is busy execu=
ting divide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer operations only=
.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa2",
+        "EventName": "BE_STALLS.SCOREBOARD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
+        "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
@@ -13,8 +54,242 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all branch instructions retired. Avai=
lable PDIST counters: 0",
+        "PublicDescription": "Counts all branch instructions retired. Avai=
lable PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Conditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of not taken conditional br=
anch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts the number of not taken conditional b=
ranch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts not taken branch instructions retired=
. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Taken conditional branch instructions retired=
.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Taken backward conditional branch instruction=
s retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts taken backward conditional branch ins=
tructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Taken forward conditional branch instructions=
 retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts taken forward conditional branch inst=
ructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Far branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PublicDescription": "Counts far branch instructions retired. Avai=
lable PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_INDIRECT] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x50",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PublicDescription": "Counts the number of near CALL branch instru=
ctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x30",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x30",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "near relative call instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_REL_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_CALL",
+        "PublicDescription": "Counts near relative call instructions retir=
ed. [This event is alias to BR_INST_RETIRED.NEAR_REL_CALL] Available PDIST =
counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "near relative jump instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_REL_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_JMP",
+        "PublicDescription": "Counts near relative jump instructions retir=
ed. [This event is alias to BR_INST_RETIRED.NEAR_REL_JMP] Available PDIST c=
ounters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns) [This event is alias to BR_INST_RETIRED.INDIRECT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch. [This event is ali=
as to BR_INST_RETIRED.INDIRECT] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x50",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Indirect near call instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_IND_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_CALL",
+        "PublicDescription": "Counts indirect near call instructions retir=
ed. [This event is alias to BR_INST_RETIRED.NEAR_IND_CALL] Available PDIST =
counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Indirect near jump instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_IND_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_JMP",
+        "PublicDescription": "Counts indirect near jump instructions retir=
ed. [This event is alias to BR_INST_RETIRED.NEAR_IND_JMP] Available PDIST c=
ounters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_IND_CALL",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_INDIRECT_CALL] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_IND_JMP",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_INDIRECT_JMP] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Indirect and Direct Relative near jump instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_JMP",
+        "PublicDescription": "Counts near jump instructions retired. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0xc0",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_DIRECT_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_REL_CALL",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_DIRECT_CALL] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_DIRECT_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_REL_JMP",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_DIRECT_JMP] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Return instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts return instructions retired. Availabl=
e PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts the number of near taken branch instr=
uctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts taken branch instructions retired. Av=
ailable PDIST counters: 0,1",
         "SampleAfterValue": "400009",
+        "UMask": "0xfb",
         "Unit": "cpu_core"
     },
     {
@@ -22,7 +297,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
+        "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path. Available PDIST count=
ers: 0,1",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
@@ -31,188 +306,1207 @@
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path. Available PDIST counters: 0",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
-        "Counter": "Fixed counter 1",
-        "EventName": "CPU_CLK_UNHALTED.CORE",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2",
-        "Unit": "cpu_atom"
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.ALL_BRANCHES_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.ALL_BRANCHES_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Core cycles when the core is not in a halt st=
ate.",
-        "Counter": "Fixed counter 1",
-        "EventName": "CPU_CLK_UNHALTED.CORE",
-        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
 The core frequency may change from time to time due to transitions associa=
ted with Enhanced Intel SpeedStep Technology or TM2. For this reason this e=
vent may have a changing ratio with regards to time. When the core frequenc=
y is constant, this event can approximate elapsed time while the core was n=
ot in the halt state. It is counted on a dedicated fixed counter, leaving t=
he programmable counters available for other events.",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2",
+        "BriefDescription": "All mispredicted branch instructions retired.=
 This precise event may be used to get the misprediction cost via the Retir=
e_Latency field of PEBS. It fires on the instruction that immediately follo=
ws the mispredicted branch. [This event is alias to BR_MISP_RETIRED.ALL_BRA=
NCHES_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_TPEBS",
+        "PublicDescription": "All mispredicted branch instructions retired=
. This precise event may be used to get the misprediction cost via the Reti=
re_Latency field of PEBS. It fires on the instruction that immediately foll=
ows the mispredicted branch. [This event is alias to BR_MISP_RETIRED.ALL_BR=
ANCHES_COST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.COND_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.COND_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8007",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted not taken c=
onditional branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts the number of mispredicted not taken =
conditional branch instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
+        "UMask": "0x4",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
-        "SampleAfterValue": "2000003",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles.",
-        "Counter": "Fixed counter 2",
-        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.COND_NTAKEN_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.COND_NTAKEN_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8004",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired. This precise event may be used to get the misprediction =
cost via the Retire_Latency field of PEBS. It fires on the instruction that=
 immediately follows the mispredicted branch. [This event is alias to BR_MI=
SP_RETIRED.COND_NTAKEN_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN_TPEBS",
+        "PublicDescription": "Mispredicted non-taken conditional branch in=
structions retired. This precise event may be used to get the misprediction=
 cost via the Retire_Latency field of PEBS. It fires on the instruction tha=
t immediately follows the mispredicted branch. [This event is alias to BR_M=
ISP_RETIRED.COND_NTAKEN_COST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8004",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken condi=
tional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts the number of mispredicted taken cond=
itional branch instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
-        "Counter": "Fixed counter 2",
-        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
-        "SampleAfterValue": "2000003",
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken backward.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts taken backward conditional mispredict=
ed branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.COND_TAKEN_BWD_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.COND_TAKEN_BWD_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8001",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken backward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch. [This event =
is alias to BR_MISP_RETIRED.COND_TAKEN_BWD_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD_TPEBS",
+        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken backward. This precise event may be used to get =
the misprediction cost via the Retire_Latency field of PEBS. It fires on th=
e instruction that immediately follows the mispredicted branch. [This event=
 is alias to BR_MISP_RETIRED.COND_TAKEN_BWD_COST] Available PDIST counters:=
 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8001",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.COND_TAKEN_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.COND_TAKEN_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken forward.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts taken forward conditional mispredicte=
d branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.COND_TAKEN_FWD_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.COND_TAKEN_FWD_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8002",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken forward. This precise event may be used to get th=
e misprediction cost via the Retire_Latency field of PEBS. It fires on the =
instruction that immediately follows the mispredicted branch. [This event i=
s alias to BR_MISP_RETIRED.COND_TAKEN_FWD_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD_TPEBS",
+        "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken forward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch. [This event =
is alias to BR_MISP_RETIRED.COND_TAKEN_FWD_COST] Available PDIST counters: =
0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8002",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted taken conditional branch instruc=
tions retired. This precise event may be used to get the misprediction cost=
 via the Retire_Latency field of PEBS. It fires on the instruction that imm=
ediately follows the mispredicted branch. [This event is alias to BR_MISP_R=
ETIRED.COND_TAKEN_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN_TPEBS",
+        "PublicDescription": "Mispredicted taken conditional branch instru=
ctions retired. This precise event may be used to get the misprediction cos=
t via the Retire_Latency field of PEBS. It fires on the instruction that im=
mediately follows the mispredicted branch. [This event is alias to BR_MISP_=
RETIRED.COND_TAKEN_COST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch. [This event is alias to BR_MISP_RETIRED=
.COND_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TPEBS",
+        "PublicDescription": "Mispredicted conditional branch instructions=
 retired. This precise event may be used to get the misprediction cost via =
the Retire_Latency field of PEBS. It fires on the instruction that immediat=
ely follows the mispredicted branch. [This event is alias to BR_MISP_RETIRE=
D.COND_COST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8007",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x50",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT_CALL] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT_CALL_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT_CALL_TPEBS] Available PDIST counters: 0=
,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8010",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8050",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_JMP",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT_JMP] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT_JMP_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_JMP_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT_JMP_TPEBS] Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8040",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns) [This event is alias to BR_MISP_RETIRED.IND=
IRECT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch. [Th=
is event is alias to BR_MISP_RETIRED.INDIRECT] Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x50",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired. [This eve=
nt is alias to BR_MISP_RETIRED.INDIRECT_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_CALL",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect. [This=
 event is alias to BR_MISP_RETIRED.INDIRECT_CALL] Available PDIST counters:=
 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired. This prec=
ise event may be used to get the misprediction cost via the Retire_Latency =
field of PEBS. It fires on the instruction that immediately follows the mis=
predicted branch. [This event is alias to BR_MISP_RETIRED.INDIRECT_CALL_COS=
T]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_CALL_TPEBS",
+        "PublicDescription": "Mispredicted indirect CALL retired. This pre=
cise event may be used to get the misprediction cost via the Retire_Latency=
 field of PEBS. It fires on the instruction that immediately follows the mi=
spredicted branch. [This event is alias to BR_MISP_RETIRED.INDIRECT_CALL_CO=
ST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x8010",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect jump instruction=
s retired. [This event is alias to BR_MISP_RETIRED.INDIRECT_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_JMP",
+        "PublicDescription": "Miss-predicted near indirect jump instructio=
ns retired. [This event is alias to BR_MISP_RETIRED.INDIRECT_JMP] Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect jump instruction=
s retired. Precise cost. [This event is alias to BR_MISP_RETIRED.INDIRECT_J=
MP_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_JMP_TPEBS",
+        "PublicDescription": "Miss-predicted near indirect jump instructio=
ns retired. Precise cost. [This event is alias to BR_MISP_RETIRED.INDIRECT_=
JMP_COST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8040",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted near indirect branch instruction=
s retired (excluding returns). This precise event may be used to get the mi=
sprediction cost via the Retire_Latency field of PEBS. It fires on the inst=
ruction that immediately follows the mispredicted branch. [This event is al=
ias to BR_MISP_RETIRED.INDIRECT_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT_TPEBS",
+        "PublicDescription": "Mispredicted near indirect branch instructio=
ns retired (excluding returns). This precise event may be used to get the m=
isprediction cost via the Retire_Latency field of PEBS. It fires on the ins=
truction that immediately follows the mispredicted branch. [This event is a=
lias to BR_MISP_RETIRED.INDIRECT_COST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8050",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS [This event is alias to BR_MISP_RETIRED.=
RET]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RETURN",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. [This event is alias to BR_MISP_RETIRED.RET] Available PDIST counter=
s: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted ret instructions retired. This p=
recise event may be used to get the misprediction cost via the Retire_Laten=
cy field of PEBS. It fires on the instruction that immediately follows the =
mispredicted branch. [This event is alias to BR_MISP_RETIRED.RET_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RETURN_TPEBS",
+        "PublicDescription": "Mispredicted ret instructions retired. This =
precise event may be used to get the misprediction cost via the Retire_Late=
ncy field of PEBS. It fires on the instruction that immediately follows the=
 mispredicted branch. [This event is alias to BR_MISP_RETIRED.RET_COST] Ava=
ilable PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8008",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken. Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0xfb",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_TAKEN_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_TAKEN_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x80fb",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Mispredicted taken near branch instructions r=
etired. This precise event may be used to get the misprediction cost via th=
e Retire_Latency field of PEBS. It fires on the instruction that immediatel=
y follows the mispredicted branch. [This event is alias to BR_MISP_RETIRED.=
NEAR_TAKEN_COST]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_TPEBS",
+        "PublicDescription": "Mispredicted taken near branch instructions =
retired. This precise event may be used to get the misprediction cost via t=
he Retire_Latency field of PEBS. It fires on the instruction that immediate=
ly follows the mispredicted branch. [This event is alias to BR_MISP_RETIRED=
.NEAR_TAKEN_COST] Available PDIST counters: 0,1",
+        "SampleAfterValue": "400009",
+        "UMask": "0x80fb",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_RETURN]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_RETURN] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_RETURN_TPEBS]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET_COST",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_RETURN_TPEBS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8008",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C01",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C02",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x70",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core cycles when the core is not in a halt st=
ate.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. This event is a component in many key event ratios.=
 The core frequency may change from time to time due to transitions associa=
ted with Enhanced Intel SpeedStep Technology or TM2. For this reason this e=
vent may have a changing ratio with regards to time. When the core frequenc=
y is constant, this event can approximate elapsed time while the core was n=
ot in the halt state. It is counted on a dedicated fixed counter, leaving t=
he programmable counters available for other events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when a PAUSE is pending.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of Pause instructions",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles.",
+        "Counter": "Fixed counter 2",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "Fixed counter 2",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core cycles when the thread is not in a halt =
state.",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the programmable counters available for other events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "16",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total execution stalls.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "4",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Count number of times a load is depending on =
another load that had just write back its data or in previous or  2 cycles =
back. This event supports in-direct dependency through a single uop.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x02",
+        "EventName": "DEPENDENT_LOADS.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 or 3 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xc",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "5",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x21",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "2",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
+        "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Instruction decoders utilized in a cycle",
+        "Counter": "2",
+        "EventCode": "0x75",
+        "EventName": "INST_DECODED.DECODERS",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired.",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.ANY",
+        "PublicDescription": "Fixed Counter: Counts the number of instruct=
ions retired. Available PDIST counters: 32",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.ANY",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 32",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PublicDescription": "Counts the number of instructions retired. A=
vailable PDIST counters: 0,1",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 0,1",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "retired macro-fused uops when there is a bran=
ch in the macro-fused pair (the two instructions that got macro-fused count=
 once in this pmon)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.BR_FUSED",
+        "PublicDescription": "retired macro-fused uops when there is a bra=
nch in the macro-fused pair (the two instructions that got macro-fused coun=
t once in this pmon) Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "INST_RETIRED.MACRO_FUSED",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PublicDescription": "INST_RETIRED.MACRO_FUSED Available PDIST cou=
nters: 0,1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x30",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired NOP instructions.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.NOP",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions Available PDIST counters: 0,1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.PREC_DIST",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0. Available=
 PDIST counters: 32",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.REP_ITERATION",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent. Available PDIST counters: 0,1",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Bubble cycles of BPClear.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.BPCLEAR_CYCLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0xB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Clears speculative count",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEARS_COUNT",
+        "PublicDescription": "Counts the number of speculative clears due =
to any type of branch misprediction or machine clears",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "TMA slots where uops got dropped",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UOP_DROPPING",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port  0,1, 2, 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x78",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Number of vector integer instructions retired=
 of 128-bit vector-width.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.128BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of vector integer instructions retired=
 of 256-bit vector-width.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.256BIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xac",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_128",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_256",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.MUL_256",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.MUL_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.SHUFFLES",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_128",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_256",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because it initially appears to be store forward blocked, but subse=
quently is shown not to be blocked based on 4K alias check. Available PDIST=
 counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked for any of the following reasons:  DTLB miss, address alias, store f=
orward or data unknown (includes memory disambiguation blocks and ESP consu=
ming load blocks).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ALL",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked for any of the following reasons:  DTLB miss, address alias, store =
forward or data unknown (includes memory disambiguation blocks and ESP cons=
uming load blocks). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Bank conflicts in DCU due to limited lookup p=
orts.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.BANK_CONFLICT",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to bank conflicts in DCU",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address exactly matches an older store whose data is no=
t ready. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x88",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of times a load got early b=
locked due to preceding store operation with unknown address or unknown dat=
a. Excluding in-line (immediate) wakeups",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_EARLY",
+        "SampleAfterValue": "100003",
+        "UMask": "0xa1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address partially overlapped with an older store. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x82",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_ACTIVE",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "8",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_OK",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of Uops delivered by the LSD.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xa8",
+        "EventName": "LSD.UOPS",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
         "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
         "SampleAfterValue": "1000003",
-        "UMask": "0x1",
+        "UMask": "0x20",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "BriefDescription": "Self-modifying code (SMC) detected.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
-        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
-        "SampleAfterValue": "2000003",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for L1 cache (that is: no execution & load in flight =
& no load missed L1 cache)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.L1",
+        "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
-        "Counter": "Fixed counter 1",
-        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for L2 cache (that is: no execution & load in flight =
& load missed L1 & no load missed L2 cache)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.L2",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
-        "Unit": "cpu_atom"
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Core cycles when the thread is not in a halt =
state.",
-        "Counter": "Fixed counter 1",
-        "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the programmable counters available for other events.",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2",
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for L3 cache (that is: no execution & load in flight =
& load missed L1 & load missed L2 cache & no load missed L3 Cache)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.L3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of unhalted core clock cycl=
es. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for Memory (that is: no execution & load in flight & =
a load missed L3 cache)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x46",
+        "EventName": "MEMORY_STALLS.MEM",
         "SampleAfterValue": "1000003",
-        "Unit": "cpu_atom"
+        "UMask": "0x8",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Thread cycles when thread is not in halt stat=
e [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "BriefDescription": "LFENCE instructions retired",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0x3c",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time. [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
-        "SampleAfterValue": "2000003",
+        "EventCode": "0xe0",
+        "EventName": "MISC2_RETIRED.LFENCE",
+        "PublicDescription": "number of LFENCE retired instructions",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired.",
-        "Counter": "Fixed counter 0",
-        "EventName": "INST_RETIRED.ANY",
-        "PublicDescription": "Fixed Counter: Counts the number of instruct=
ions retired. Available PDIST counters: 32",
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
-        "Counter": "Fixed counter 0",
-        "EventName": "INST_RETIRED.ANY",
-        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 32",
-        "SampleAfterValue": "2000003",
+        "BriefDescription": "LBR record is inserted",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PublicDescription": "LBR record is inserted Available PDIST count=
ers: 0,1",
+        "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of instructions retired.",
+        "BriefDescription": "Counts the number of LFENCE instructions reti=
red.",
         "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc0",
-        "EventName": "INST_RETIRED.ANY_P",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.LFENCE",
+        "PublicDescription": "Counts the number of LFENCE instructions ret=
ired. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
+        "UMask": "0x2",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
-        "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0xc0",
-        "EventName": "INST_RETIRED.ANY_P",
-        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter. A=
vailable PDIST counters: 0",
-        "SampleAfterValue": "2000003",
-        "Unit": "cpu_core"
+        "BriefDescription": "Counts the number of accesses to KeyLocker ca=
che.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
+        "PublicDescription": "Counts the number of accesses to KeyLocker c=
ache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
+        "BriefDescription": "Counts the number of misses to KeyLocker cach=
e.",
         "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x03",
-        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
+        "PublicDescription": "Counts the number of misses to KeyLocker cac=
he. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
-        "UMask": "0x2",
+        "UMask": "0x11",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0x03",
-        "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x82",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xe4",
-        "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1",
-        "Unit": "cpu_atom"
+        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_COUNT",
+        "Invert": "1",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "LBR record is inserted",
+        "BriefDescription": "Cycles when RS was empty and a resource alloc=
ation stall is asserted",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
-        "EventCode": "0xe4",
-        "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "LBR record is inserted Available PDIST count=
ers: 0",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will onl=
y put the CPU into C0.1 activity state (not C0.2 activity state).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -223,6 +1517,35 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
s.",
+        "Counter": "0",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
+        "Counter": "0",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "Counter": "3",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
         "Counter": "Fixed counter 3",
@@ -244,7 +1567,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of issue slo=
ts that were not consumed by the backend because allocation is stalled due =
to a mispredicted jump or a machine clear.",
-        "Counter": "36",
+        "Counter": "Fixed counter 4",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -279,7 +1602,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
-        "Counter": "37",
+        "Counter": "Fixed counter 5",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
@@ -296,7 +1619,7 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
-        "Counter": "38",
+        "Counter": "Fixed counter 6",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x7",
@@ -312,6 +1635,237 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Number of non dec-by-all uops decoded by deco=
der",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x76",
+        "EventName": "UOPS_DECODED.DEC0_UOPS",
+        "PublicDescription": "This event counts the number of not dec-by-a=
ll uops decoded by decoder 0.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops executed on INT EU ALU ports.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.ALU",
+        "PublicDescription": "Number of ALU integer uops dispatch to execu=
tion.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops executed on any INT EU ports",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.INT_EU_ALL",
+        "PublicDescription": "Number of integer uops dispatched to executi=
on.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of Uops dispatched/executed by any of =
the 3 JEUs (all ups that hold the JEU including macro; micro jumps; fetch-f=
rom-eip)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.JMP",
+        "PublicDescription": "Number of jump uops dispatch to execution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops executed on Load ports",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.LOAD",
+        "PublicDescription": "Number of Load uops dispatched to execution.=
",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of (shift) 1-cycle Uops dispatched/exe=
cuted by any of the Shift Eus",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.SHIFT",
+        "PublicDescription": "Number of SHIFT integer uops dispatch to exe=
cution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of Uops dispatched/executed by Slow EU=
 (e.g. 3+ cycles LEA, >1 cycles shift, iDIVs, CR; *H operation)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.SLOW",
+        "PublicDescription": "Number of Slow integer uops dispatch to exec=
ution.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of Uops dispatched on STA ports",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.STA",
+        "PublicDescription": "Number of STA (Store Address) uops dispatch =
to execution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops executed on STD ports",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.STD",
+        "PublicDescription": "Number of STD (Store Data) uops dispatch to =
execution",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "Counter": "3",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
+        "Counter": "3",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "Counter": "3",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
+        "Counter": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.X87",
+        "PublicDescription": "Counts the number of x87 uops executed.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Uops that RAT issues to RS",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "UOPS_ISSUED.CYCLES",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.CYCLES",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles with retired uop(s).",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.CYCLES",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.HEAVY",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "UOPS_RETIRED.MS",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of non-speculative switches to the Mic=
rocode Sequencer (MS)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS_SWITCHES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PublicDescription": "Switches to the Microcode Sequencer",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -321,5 +1875,17 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.STALLS",
+        "Invert": "1",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json =
b/tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json
new file mode 100644
index 000000000000..a881b99be5f3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json
@@ -0,0 +1,26 @@
+[
+    {
+        "BriefDescription": "Read CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_CAS_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_CAS_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Total number of read and write byte transfers=
 to/from DRAM, in 32B chunk, per DDR channel. Counter increments by 1 after=
 sending  or receiving 32B chunk data.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M_TOTAL_DATA",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json
index 690c5dff9d9e..8d56c16b2a39 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json
@@ -1,4 +1,43 @@
 [
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a demand load that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccounts for all page sizes. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x320",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -19,6 +58,86 @@
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a store that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Accounts=
 for all page sizes. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "PublicDescription": "Counts the number of first level TLB misses =
but second level hits due to a demand load that did not start a page walk. =
Accounts for all page sizes. Will result in a DTLB write from STLB.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x320",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -39,6 +158,85 @@
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will result in an ITLB write from STLB."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x120",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "CounterMask": "1",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_ACTIVE",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -58,5 +256,55 @@
         "SampleAfterValue": "100003",
         "UMask": "0xe",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks outstanding f=
or iside in PMH every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for iside in PMH every cycle.  A PMH page walk is outstanding from page wal=
k start till PMH becomes idle again (ready to serve next walk). Includes EP=
T-walk intervals.  Walks could be counted by edge detecting on this event, =
but would count restarted suspended walks.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked due to a first level TLB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DTLB_MISS",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked due to a first level TLB miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
     }
 ]
--=20
2.51.0.536.g15c5d4f767-goog


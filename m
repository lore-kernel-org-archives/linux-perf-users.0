Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A25403E87
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269459; cv=none; b=YZYUsht156DFO0qBbEnugFaiLN7Rajvt6hPyvEIHSIxMaoxJ1I6/My4DLgOcsXMY7I7BF6cFRwyojbB/CnkCuIyrpMG37rcaY6JhBb/Jn2msI1pWiYok2UAe9oVgcYMxJBb+JIJtg3aLQqwvhWs9yUniAS+yX+agkLrYp7yBrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269459; c=relaxed/simple;
	bh=e74PXFhy8+4p5klfKxY8yz+P+6Ov14LgMK2g0BEXdYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hKvCiQS+6NZb2sxmLyjxQsaKbW7yMix6zErO7whMxP+dx+Q4HqBUoMUGLUbDGZJOEjE8HJ+dvVAg0EyFyy94tUJo3Y1lYy030x8KLWkSEDyhzwuR5x90x3KNeznwLhI4d3lAeoCdpYqjEKWfVK9J/Nu1hDHfLSDsq0akmNjloa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAtbD9Qp; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAtbD9Qp"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3807787eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269454; x=1790874254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j5sgEJaKaissKTwZtDo+q6obLB0JDlwEcg97N+pTVac=;
        b=XAtbD9QpFk9HTWyDeBCzPp0/tOMYrmbIJdvCabPw2RgHhcoZkofwGHoVDbgf0oL5R6
         NtuTnfkY1MSeHhU3FUuwvhZ/k0rWMmetUm3i66eGEHk4tKxOBOHqFUFJgJt+/YgsRF29
         3GVYiwHpP3CWat8R2gy/8rDDHy+E4yRhgKs/u3oR8EDVwuAXJq5bKqRXYfMcVkB+KooB
         i9C7zM134OMaHdeCZwJk5AjrC6+jyPPAM02+o3E9PD+2sFGEU5NoMA1A+GBbRoLsZhMF
         QntAvPssBVK/A1zNXMAsMfvi8IH0czTPDq4pTbWHi/RLKm5MVHCKOpjhn9nlj6tpkl2E
         y5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269454; x=1790874254;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5sgEJaKaissKTwZtDo+q6obLB0JDlwEcg97N+pTVac=;
        b=fYyBimHWd44JTZWbXxzeGrqqrM+Cx3ZKvhCWT0UuojR4GeJSRSZqdZ/n6qgveewL1F
         fqx4gtfWU9wwwfYunqm2Uip70RMYCiFFXj8BUAxgmFErmgF3+YTBcl8BE/MoMk43OqsR
         RCBRhkHYH7X32PbvVwqmmkgmAZqImnQyoVsLopM10WfYo6gR8h/kc0cmehkocUrTOqSR
         4+4LP2pV5KFqGP6DKcO3+e8CJrpB4bC1f8TpvgD2EFUdS7ROnC5pPMpsDa71TB1yysxn
         4WQNNNKzSBSiKzo0cIp1KLnsNjR18CAxUTjDWHM1RCiO9xiliWyLL6n4AGvoGNNrr4IG
         ZpSA==
X-Forwarded-Encrypted: i=1; AKwUvBw6P5KajgCBYMJN0xEdCi6pkJByYrtt5MYN6tiRlI6GaAhj46IhitPC75N+PQYwX2Rj634vUbh3eE3iUmLVW/q7@vger.kernel.org
X-Gm-Message-State: AFuF++lhMfi3ggTY25mdh5EVZ7URxByEYcZl8jp/lZfntNzuLPPxXIZ3
	z4aF4eQimIeHFat8YQtXphO6eTHUTA0kEk1yBHa8uK0iy8e4S7gKWDtdi/ZUXK5P/p0qcOkuvJM
	Uvuak/6MK6Q==
X-Received: from dycst11.prod.google.com ([2002:a05:693c:37cb:b0:336:dd02:97ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8214:b0:333:f73a:229b
 with SMTP id 5a478bee46e88-34001621097mr2877955eec.39.1790269453725; Thu, 24
 Sep 2026 10:04:13 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:26 -0700
In-Reply-To: <20260924170346.3872848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com> <20260924170346.3872848-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-7-irogers@google.com>
Subject: [PATCH v2 06/26] perf vendor events intel: Update emeraldrapids
 events from 1.24 to 1.25
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/0929815a4859319c27d2aa9099d394408=
29c5d7a

Fix UMaskExt encodings.

Fixes: 8c994eff8fcf ("perf vendor events intel: Add emeraldrapids, update s=
apphirerapids to v1.16")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/emeraldrapids/cache.json         |  2 +-
 .../arch/x86/emeraldrapids/memory.json        | 35 ++++++++++++
 .../arch/x86/emeraldrapids/other.json         |  9 ++++
 .../arch/x86/emeraldrapids/pipeline.json      | 10 ++--
 .../arch/x86/emeraldrapids/uncore-cache.json  | 42 +++++++++++++++
 .../emeraldrapids/uncore-interconnect.json    | 12 +++++
 .../arch/x86/emeraldrapids/uncore-io.json     | 54 ++++++++++++++++++-
 .../arch/x86/emeraldrapids/uncore-memory.json | 10 ++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 9 files changed, 168 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/cache.json
index a44e1f027c1d..fc1be5b2bff2 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/cache.json
@@ -1201,7 +1201,7 @@
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
         "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
-        "SampleAfterValue": "100003",
+        "SampleAfterValue": "503",
         "UMask": "0x10"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/emeraldrapids/memory.json
index 5e6c1f05c981..93effd1d69a2 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/memory.json
@@ -55,6 +55,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than any number of cycles."=
,
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY",
+        "MSRIndex": "0x3F6",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than any number of cycles.=
 Reported latency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
         "Counter": "1,2,3,4,5,6,7",
@@ -91,6 +102,30 @@
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2 cycles. Reported la=
tency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 2048 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "23",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
         "Counter": "1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json b/tool=
s/perf/pmu-events/arch/x86/emeraldrapids/other.json
index 21f49f609ed4..4ded9b0499c3 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/other.json
@@ -32,6 +32,15 @@
         "SampleAfterValue": "203",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcc",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT. [This event is alias to MISC_RET=
IRED.LBR_INSERTS]",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
index 1fa7957956df..035c01540cf7 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/pipeline.json
@@ -200,11 +200,11 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. Available PDIST counters: 0",
+        "PublicDescription": "This event counts the number of mispredicted=
 ret instructions retired. Available PDIST counters: 0",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -502,7 +502,7 @@
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
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX).",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
@@ -723,11 +723,11 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array. [This event is alias to LBR_INSERTS.ANY]",
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
 branch type selection via MSR_LBR_SELECT. [This event is alias to LBR_INSE=
RTS.ANY]",
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     },
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
index 3c8dcd9cff7c..8549ab2cb7ae 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-cache.json
@@ -581,6 +581,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : All Requests : Counts the nu=
mber of times the LLC was accessed - this includes code, data, prefetches a=
nd hints coming from L2.  This has numerous filters available.  Note the no=
n-standard filtering equation.  This event will count requests that lookup =
the cache multiple times with multiple increments.  One must ALWAYS set uma=
sk bit 0 and select a state or states to match.  Otherwise, the event will =
count nothing. : Any local or remote transaction to the LLC, including pref=
etch.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -602,6 +603,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : CRd Requests : Counts the nu=
mber of times the LLC was accessed - this includes code, data, prefetches a=
nd hints coming from L2.  This has numerous filters available.  Note the no=
n-standard filtering equation.  This event will count requests that lookup =
the cache multiple times with multiple increments.  One must ALWAYS set uma=
sk bit 0 and select a state or states to match.  Otherwise, the event will =
count nothing. : Local or remote CRd transactions to the LLC.  This include=
s CRd prefetch.",
+        "UMask": "0x1000",
         "Unit": "CHA"
     },
     {
@@ -612,6 +614,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Local non-prefetch requests =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, =
the event will count nothing. : Any local transaction to the LLC, not inclu=
ding prefetch",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -644,6 +647,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Data Read Request : Counts t=
he number of times the LLC was accessed - this includes code, data, prefetc=
hes and hints coming from L2.  This has numerous filters available.  Note t=
he non-standard filtering equation.  This event will count requests that lo=
okup the cache multiple times with multiple increments.  One must ALWAYS se=
t umask bit 0 and select a state or states to match.  Otherwise, the event =
will count nothing. : Read transactions.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -709,6 +713,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Flush : Counts the number of=
 times the LLC was accessed - this includes code, data, prefetches and hint=
s coming from L2.  This has numerous filters available.  Note the non-stand=
ard filtering equation.  This event will count requests that lookup the cac=
he multiple times with multiple increments.  One must ALWAYS set umask bit =
0 and select a state or states to match.  Otherwise, the event will count n=
othing.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -730,6 +735,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Local LLC prefetch requests =
(from LLC) : Counts the number of times the LLC was accessed - this include=
s code, data, prefetches and hints coming from L2.  This has numerous filte=
rs available.  Note the non-standard filtering equation.  This event will c=
ount requests that lookup the cache multiple times with multiple increments=
.  One must ALWAYS set umask bit 0 and select a state or states to match.  =
Otherwise, the event will count nothing. : Any local LLC prefetch to the LL=
C",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -806,6 +812,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Transactions homed locally :=
 Counts the number of times the LLC was accessed - this includes code, data=
, prefetches and hints coming from L2.  This has numerous filters available=
.  Note the non-standard filtering equation.  This event will count request=
s that lookup the cache multiple times with multiple increments.  One must =
ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, t=
he event will count nothing. : Transaction whose address resides in the loc=
al MC.",
+        "UMask": "0x80000",
         "Unit": "CHA"
     },
     {
@@ -915,6 +922,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Write Requests : Counts the =
number of times the LLC was accessed - this includes code, data, prefetches=
 and hints coming from L2.  This has numerous filters available.  Note the =
non-standard filtering equation.  This event will count requests that looku=
p the cache multiple times with multiple increments.  One must ALWAYS set u=
mask bit 0 and select a state or states to match.  Otherwise, the event wil=
l count nothing. : Writeback transactions from L2 to the LLC  This includes=
 all write transactions -- both Cacheable and UC.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -925,6 +933,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Remote non-snoop requests : =
Counts the number of times the LLC was accessed - this includes code, data,=
 prefetches and hints coming from L2.  This has numerous filters available.=
  Note the non-standard filtering equation.  This event will count requests=
 that lookup the cache multiple times with multiple increments.  One must A=
LWAYS set umask bit 0 and select a state or states to match.  Otherwise, th=
e event will count nothing. : Remote non-snoop transactions to the LLC.",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -968,6 +977,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Transactions homed remotely =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, =
the event will count nothing. : Transaction whose address resides in a remo=
te MC",
+        "UMask": "0x100000",
         "Unit": "CHA"
     },
     {
@@ -1011,6 +1021,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Remote snoop requests : Coun=
ts the number of times the LLC was accessed - this includes code, data, pre=
fetches and hints coming from L2.  This has numerous filters available.  No=
te the non-standard filtering equation.  This event will count requests tha=
t lookup the cache multiple times with multiple increments.  One must ALWAY=
S set umask bit 0 and select a state or states to match.  Otherwise, the ev=
ent will count nothing. : Remote snoop transactions to the LLC.",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -1043,6 +1054,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS select a state or states (in the umask=
 field) to match.  Otherwise, the event will count nothing. : Local or remo=
te RFO transactions to the LLC.  This includes RFO prefetch.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -1240,6 +1252,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local Only : Counts the n=
umber of lines that were victimized on a fill.  This can be filtered by the=
 state that the line was in.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -1305,6 +1318,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Remote Only : Counts the =
number of lines that were victimized on a fill.  This can be filtered by th=
e state that the line was in.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -3705,6 +3719,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : DDR Access : Counts the number=
 of entries successfully inserted into the TOR that match qualifications sp=
ecified by the subevent.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -3726,6 +3741,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Hits : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -5277,6 +5293,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just ISOC : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "UMask": "0x200000000",
         "Unit": "CHA"
     },
     {
@@ -5287,6 +5304,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Local Targets : Counts th=
e number of entries successfully inserted into the TOR that match qualifica=
tions specified by the subevent.",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -5330,6 +5348,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Match the Opcode in b[29:19] o=
f the extended umask field : Counts the number of entries successfully inse=
rted into the TOR that match qualifications specified by the subevent.",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -5340,6 +5359,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Misses : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -5350,6 +5370,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : MMCFG Access : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -5360,6 +5381,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : MMIO Access : Counts the numbe=
r of entries successfully inserted into the TOR that match qualifications s=
pecified by the subevent.",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -5370,6 +5392,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NearMem : Counts the numb=
er of entries successfully inserted into the TOR that match qualifications =
specified by the subevent.",
+        "UMask": "0x40000000",
         "Unit": "CHA"
     },
     {
@@ -5380,6 +5403,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NonCoherent : Counts the =
number of entries successfully inserted into the TOR that match qualificati=
ons specified by the subevent.",
+        "UMask": "0x100000000",
         "Unit": "CHA"
     },
     {
@@ -5390,6 +5414,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just NotNearMem : Counts the n=
umber of entries successfully inserted into the TOR that match qualificatio=
ns specified by the subevent.",
+        "UMask": "0x80000000",
         "Unit": "CHA"
     },
     {
@@ -5400,6 +5425,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : PM Access : Counts the number =
of entries successfully inserted into the TOR that match qualifications spe=
cified by the subevent.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -5410,6 +5436,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Match the PreMorphed Opcode in=
 b[29:19] of the extended umask field : Counts the number of entries succes=
sfully inserted into the TOR that match qualifications specified by the sub=
event.",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -5442,6 +5469,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : Just Remote Targets : Counts t=
he number of entries successfully inserted into the TOR that match qualific=
ations specified by the subevent.",
+        "UMask": "0x10000",
         "Unit": "CHA"
     },
     {
@@ -5568,6 +5596,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DDR Access : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.",
+        "UMask": "0x400",
         "Unit": "CHA"
     },
     {
@@ -5589,6 +5618,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Hits : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.   T",
+        "UMask": "0x100",
         "Unit": "CHA"
     },
     {
@@ -7118,6 +7148,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just ISOC : For each cycle, =
this event accumulates the number of valid entries in the TOR that match qu=
alifications specified by the subevent.   T",
+        "UMask": "0x200000000",
         "Unit": "CHA"
     },
     {
@@ -7128,6 +7159,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Local Targets : For eac=
h cycle, this event accumulates the number of valid entries in the TOR that=
 match qualifications specified by the subevent.   T",
+        "UMask": "0x8000",
         "Unit": "CHA"
     },
     {
@@ -7171,6 +7203,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Match the Opcode in b[29:19]=
 of the extended umask field : For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   T",
+        "UMask": "0x20000",
         "Unit": "CHA"
     },
     {
@@ -7181,6 +7214,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Misses : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.   T",
+        "UMask": "0x200",
         "Unit": "CHA"
     },
     {
@@ -7191,6 +7225,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : MMCFG Access : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.   T",
+        "UMask": "0x2000",
         "Unit": "CHA"
     },
     {
@@ -7201,6 +7236,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : MMIO Access : For each cycle=
, this event accumulates the number of valid entries in the TOR that match =
qualifications specified by the subevent.   T",
+        "UMask": "0x4000",
         "Unit": "CHA"
     },
     {
@@ -7211,6 +7247,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NearMem : For each cycl=
e, this event accumulates the number of valid entries in the TOR that match=
 qualifications specified by the subevent.   T",
+        "UMask": "0x40000000",
         "Unit": "CHA"
     },
     {
@@ -7221,6 +7258,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NonCoherent : For each =
cycle, this event accumulates the number of valid entries in the TOR that m=
atch qualifications specified by the subevent.   T",
+        "UMask": "0x100000000",
         "Unit": "CHA"
     },
     {
@@ -7231,6 +7269,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just NotNearMem : For each c=
ycle, this event accumulates the number of valid entries in the TOR that ma=
tch qualifications specified by the subevent.   T",
+        "UMask": "0x80000000",
         "Unit": "CHA"
     },
     {
@@ -7241,6 +7280,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : PMM Access : For each cycle,=
 this event accumulates the number of valid entries in the TOR that match q=
ualifications specified by the subevent.",
+        "UMask": "0x800",
         "Unit": "CHA"
     },
     {
@@ -7251,6 +7291,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Match the PreMorphed Opcode =
in b[29:19] of the extended umask field : For each cycle, this event accumu=
lates the number of valid entries in the TOR that match qualifications spec=
ified by the subevent.   T",
+        "UMask": "0x40000",
         "Unit": "CHA"
     },
     {
@@ -7283,6 +7324,7 @@
         "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : Just Remote Targets : For ea=
ch cycle, this event accumulates the number of valid entries in the TOR tha=
t match qualifications specified by the subevent.   T",
+        "UMask": "0x10000",
         "Unit": "CHA"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.=
json
index 8b1ae9540066..c2f5897ad4b9 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json
@@ -545,6 +545,7 @@
         "EventCode": "0xc0",
         "EventName": "UNC_M2M_CMS_CLOCKTICKS",
         "PerPkg": "1",
+        "UMask": "0x80000000",
         "Unit": "M2M"
     },
     {
@@ -1455,6 +1456,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xa00",
         "Unit": "M2M"
     },
     {
@@ -1476,6 +1478,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x900",
         "Unit": "M2M"
     },
     {
@@ -1507,6 +1510,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xa00",
         "Unit": "M2M"
     },
     {
@@ -1516,6 +1520,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH0_NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0xc00",
         "Unit": "M2M"
     },
     {
@@ -1580,6 +1585,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1200",
         "Unit": "M2M"
     },
     {
@@ -1601,6 +1607,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1100",
         "Unit": "M2M"
     },
     {
@@ -1632,6 +1639,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1200",
         "Unit": "M2M"
     },
     {
@@ -1641,6 +1649,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.CH1_NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1400",
         "Unit": "M2M"
     },
     {
@@ -1705,6 +1714,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1900",
         "Unit": "M2M"
     },
     {
@@ -1734,6 +1744,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.NI",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1a00",
         "Unit": "M2M"
     },
     {
@@ -1743,6 +1754,7 @@
         "EventName": "UNC_M2M_IMC_WRITES.NI_MISS",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1c00",
         "Unit": "M2M"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
index ddb0f65307f4..a574469de318 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-io.json
@@ -573,6 +573,19 @@
         "UMask": "0x1",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to this IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) requested by the mai=
n die.  Includes all requests initiated by the main die, including reads an=
d writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1=
, Or x4 card is plugged in to slot 0",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
         "Counter": "2,3",
@@ -677,6 +690,19 @@
         "UMask": "0x8",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 this IIO by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) requested by the mai=
n die.  Includes all requests initiated by the main die, including reads an=
d writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1=
, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
         "Counter": "2,3",
@@ -1104,6 +1130,32 @@
         "UMask": "0x1",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO any part to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) the card requests of=
 the main die.    Includes all requests initiated by the Card, including re=
ads and writes. : x16 card plugged in to stack, Or x8 card plugged in to La=
ne 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 any IIO part to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x00FF",
+        "PublicDescription": "Number of DWs (4 bytes) the card requests of=
 the main die.    Includes all requests initiated by the Card, including re=
ads and writes. : x16 card plugged in to stack, Or x8 card plugged in to La=
ne 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
         "Counter": "0,1",
@@ -1827,7 +1879,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
-        "Experimental": "1",
         "FCMask": "0x01",
         "PerPkg": "1",
         "PortMask": "0x00FF",
@@ -1843,6 +1894,7 @@
         "PerPkg": "1",
         "PortMask": "0x0000",
         "PublicDescription": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
+        "UMask": "0x7000000",
         "Unit": "IIO"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
index 30044177ccf8..ad32f0ccfa02 100644
--- a/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/emeraldrapids/uncore-memory.json
@@ -13,6 +13,7 @@
         "EventCode": "0xc0",
         "EventName": "UNC_M2HBM_CMS_CLOCKTICKS",
         "PerPkg": "1",
+        "UMask": "0x80000000",
         "Unit": "M2HBM"
     },
     {
@@ -926,6 +927,7 @@
         "EventName": "UNC_M2HBM_IMC_WRITES.CH0_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x900",
         "Unit": "M2HBM"
     },
     {
@@ -959,6 +961,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0xa00",
         "Unit": "M2HBM"
     },
     {
@@ -970,6 +973,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0xc00",
         "Unit": "M2HBM"
     },
     {
@@ -1043,6 +1047,7 @@
         "EventName": "UNC_M2HBM_IMC_WRITES.CH1_FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1100",
         "Unit": "M2HBM"
     },
     {
@@ -1076,6 +1081,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1200",
         "Unit": "M2HBM"
     },
     {
@@ -1087,6 +1093,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1400",
         "Unit": "M2HBM"
     },
     {
@@ -1118,6 +1125,7 @@
         "EventName": "UNC_M2HBM_IMC_WRITES.FROM_TGR",
         "Experimental": "1",
         "PerPkg": "1",
+        "UMask": "0x1900",
         "Unit": "M2HBM"
     },
     {
@@ -1149,6 +1157,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1a00",
         "Unit": "M2HBM"
     },
     {
@@ -1160,6 +1169,7 @@
         "FCMask": "0x00000000",
         "PerPkg": "1",
         "PortMask": "0x00000000",
+        "UMask": "0x1c00",
         "Unit": "M2HBM"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 27eaf934b925..3753ff64835e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
 GenuineIntel-6-DD,v1.04,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
-GenuineIntel-6-CF,v1.24,emeraldrapids,core
+GenuineIntel-6-CF,v1.25,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.13,grandridge,core
--=20
2.56.0.rc1.315.gc6ed9934b7-goog


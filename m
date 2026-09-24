Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093D3F075A
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228281; cv=none; b=GOZ7n5gloTMnoNI21xpf3xTiF32/bRGn1sBczC88iGQV4kXeHm+UbwMmGwR3O+4i42EfPcdusuBt4dFLS1DkEW/0jzh06jPWmHZk+1s/GVc4JNwtefmVWyUZCNl+WG8ZQ/6ct1SFD5HVj6bsEuh9Yxx9wMlK4+K1WqgHEZocNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228281; c=relaxed/simple;
	bh=EaocGedhmHE/qTnkmPB8mWGtIcjMADem/92XEqNCn54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rrEUrt0MWuy/KuNX7fk2k9K03C1ERxRRPI6cKyO9wbMyIP4FlOjRKgK0hCd/B1XUHCgG3pa5adAoAJnXKTQzyhqpljDxv5ofkgOd+ytwHLm7VJ40TJINh3TzItFwD2cMTXGMFwGAoIyJqYd91B6gKZPUsHeboDTnbhbHQRp9/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0itdYo+; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0itdYo+"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14388794dcfso827253c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228277; x=1790833077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qrt5btML/MFxKgb9ZINbZPwMQhumeDEOzekDkh5vca0=;
        b=G0itdYo+pHKY5gJOPlYtmfWpJgim32NDya3/hgoEAyTFIRqeFtA/GNqST4uOeO1ksd
         izq+LzvZMWPBmyCg+1Ok/saVjZTqF2kF5ajQZyJpDIe0merEzcMbA4OrdPxtOxk5kcUR
         GIiu7DKT/Qctq3viuGujr/Y+hELIEW2h+7gmWU/4qhhm5eSYjdz8zRB+9ox5eGLuDvCq
         hbh9urMH0jcby7TRKpTskSl3mB8pYZIUTRhGxV6H7wZS5Vco4z6PIdxIWiBFSdYWrYvR
         Hn26s58gdNw/7r1wvcJvVTLPMAWCV37VqA4HbbND158sumF6EdoxOlXE592P4jb7cZl2
         Xr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228277; x=1790833077;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qrt5btML/MFxKgb9ZINbZPwMQhumeDEOzekDkh5vca0=;
        b=xpHHSPpIY6Ri7fpkCnCvRqHEUAk+ztXqt5PCnleVVDa5aubNbLSCe5jINS3aEB7ul4
         Tn4h/jY66b1d3ezXuA716b+bHUfGNWKegYQw4TwKARhuGdxhvbf9vo2tLW0MHjiD42bu
         jwJ0+t1iT6VVtESYCazXspcYe8umFWamG0JHQslk6LD7n8cvW/EnCdSc9YgU01G40oLc
         /q/1xWQaouN9tn+3CrI+fabIH99JwiwUhP1m+VE8FsbV8KjIyA+VcQJkahiXl6qWJxmD
         1Q8wir5BJO46O3mawlkGowuPF2fYQLPtG8tCabXT8wkbYkbWIdbSFlqIPW77VDdwfzVU
         Uyxw==
X-Forwarded-Encrypted: i=1; AKwUvBza39ZMRqD2GWZ886udewpTz57BmOv7WosG/vUwqaSkkGPpTLHCy6iQPCe12PxHA3MU3mmHAoucsjUqjeGUbX+Y@vger.kernel.org
X-Gm-Message-State: AFuF++nVj0ZC30CXhKsQ6azBvIehTdoM40xPVwbm8QvrHMwuT3NDe1oT
	w2iNzQKXhv9bmVKAhXfsP3+VNVBO062IRXlkeX25gPjT0eOzDyEpNLcKISBQb3008BWPuVl/yMd
	+ekKa8TYbtw==
X-Received: from dlev19.prod.google.com ([2002:a05:701b:4653:b0:144:ce33:3556])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eb47:10b0:144:f480:3541
 with SMTP id a92af1059eb24-14503fe8205mr1086221c88.21.1790228275176; Wed, 23
 Sep 2026 22:37:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:25 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-2-irogers@google.com>
Subject: [PATCH v1 01/21] perf vendor events intel: Update alderlake events
 from 1.40 to 1.41
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147c7=
776119c

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlake/cache.json |  4 ++--
 .../perf/pmu-events/arch/x86/alderlake/memory.json  | 13 +++++++++++++
 tools/perf/pmu-events/arch/x86/alderlake/other.json | 10 ++++++++++
 .../pmu-events/arch/x86/alderlake/pipeline.json     |  6 +++---
 tools/perf/pmu-events/arch/x86/mapfile.csv          |  2 +-
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index 6c09da7b69e8..b804fe0a4156 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ANY",
-        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q.  It also coun=
ts requests that would have gone directly to the External Queue (XQ), but a=
re rejected due to a full or nearly full condition, indicating back pressur=
e from the IDI link.  The L2Q may also reject transactions  from a core to =
ensure fairness between cores, or to delay a cores dirty eviction when the =
address conflicts incoming external snoops.  (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event).  Counts on a per core =
basis.",
+        "PublicDescription": "Counts the number of core requests (demand a=
nd L1 prefetchers) rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q. It also count=
s requests that would have gone directly to the External Queue (XQ) but are=
 rejected due to a full or nearly full condition, indicating back pressure =
from the IDI link. The L2Q may also reject transactions from a core to ensu=
re fairness between cores, or to delay a cores dirty eviction when the addr=
ess conflicts with incoming external snoops. (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event). Counts on a per core b=
asis.",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
@@ -135,7 +135,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ANY",
-        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition, which likely indicates back pressure from the IDI link. The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index f482c06ac728..70e3c9a1f740 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -228,6 +228,19 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
         "Counter": "1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index af46cde26b54..c530f05e09d6 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -55,6 +55,16 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
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
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index eb840066a5a7..1b9482b02bc5 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -988,7 +988,7 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary run to run and not match the architectural =
number of iterations (specified by RCX)",
+        "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note: Since the number=
 of iterations within a REP instruction can be significantly affected by fa=
st strings, this event may vary from run to run and not match the architect=
ural number of iterations (specified by RCX).",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1327,11 +1327,11 @@
         "Unit": "cpu_atom"
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
         "UMask": "0x20",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index e5d90825041b..866b5fba7124 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.40,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.41,alderlake,core
 GenuineIntel-6-BE,v1.40,alderlaken,core
 GenuineIntel-6-C[56],v1.20,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
--=20
2.56.0.rc1.310.g51773c2048-goog


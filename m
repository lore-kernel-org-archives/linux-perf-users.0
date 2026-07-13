Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7823537D2
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966684; cv=none; b=R6boaagsLVYdeS7RIzqDS63XUJlQ3lOVfpW7IsD3YVryEoI7FbMRg/NQQHuAeKQsBoXM60gapjDiOMUeT6Q3qafx9pproUIgUEWHAPiUDIVFuoRoO+UYUQaKAvSyZUzbAJLigesGTTt2VpeqVSk6mhNvF1TgkuftSm9ZBI6kBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966684; c=relaxed/simple;
	bh=JJVRnZaOg6j+3qeptIBVYpgs8B0fkjyGR94fkV37ZVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bf3qBEIdSJWKl2OUx6uc8OJuYGwDisiZ6FlyLXhoIyq+x1lnlEQGMud83YAVULoTZojIVdtgVZ0fVtpIb0BC1h/nIgY5B0HPrKHFwhvWQ2b+edTMBu5sQqs5FZHndhIPOxiWvaiyEp42T0Jdw1ll0wpkul/4Jnu7UojjOlHsdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1qy7HLm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1qy7HLm"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845317fa7e6so6310395b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966682; x=1784571482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hRE24DG+tKJw2HV33oDtPK+aqIv1rzDopgjdNX1groQ=;
        b=L1qy7HLm51a36rMgFsIois8DSioCUpJk387yuXxEaYV4P8kYQ2N1sBEpphC+03N+E4
         cJGfan3AqmyxLqVJWn/b4ndTpULmOqxipPUYBj8AcaeeKRAkpMwZ9RE3vUNC99+WCCON
         NUWutFD5iWu/HoNwOhVud7nF1IAVzL4fHuNJmKJW4Ap6Do07Ie+MZ7CMpHuuH797pge8
         GfsXbHB4HyOVnKNFls1i8LO5nZeUCXf2opnSNRNn5v68nbambia4J90Bm0bwcaIW/w39
         Q49PIvuFJe/i7HDhUFTrGTFEdh32RU0KTLTO1QPvCuu8acz2KW+4UUdVyGYkRifbNcjC
         /c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966682; x=1784571482;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRE24DG+tKJw2HV33oDtPK+aqIv1rzDopgjdNX1groQ=;
        b=YBAT60vXMV8JzqsbtG8bLFDEmNNCqUUaCfNPxh/A9n+auqJgAadO1VX62DW/hgJq20
         Cd6ZyovB9N+p8esZ6dISfAUOy5n9UbQVVYdiCj8urAQ1SdGCegIUsMO7st217iPulUT2
         QfW19makIDXijx18WBM3XbEwjNkRc9h847q2Tz3dwh3+FJf/+uei6oLsPo+2L8FpDYOD
         XTXDCih8RRISzl7OTvNFzNAUHjVSUmg+R8KruAPfRHjVIAIOnL3vEFsFbjg0q7jLO3fR
         7C2f5oJy7qeOBsvlzKXVMnUh6TZO9MaAUqGT9VXrVpKg4HT2DCQclZ3BB19xl+lSMAij
         fD6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpnkypN1wayIOEeB0DbTnIIYeV1b25LeRwtNNcIKACH3hzzNMNtfTFSLJ2J1uOkqkmhaIpeRCsNxJUG437F5icf@vger.kernel.org
X-Gm-Message-State: AOJu0YybwaXfSn5rtur8KRrC595IsEBGqrVJxGdS7/F/PF7mauZzqxRV
	w1srfnM7eU3onIGuwRX+FO3Daxr7vV7TOF63pjHbjQvOWehxbo3TtmoT4xHCQ+hcSVFa4QFgoct
	BWIGbsA==
X-Received: from pfx48.prod.google.com ([2002:a05:6a00:a470:b0:846:5d01:2319])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d02:b0:845:c8f9:6ce0
 with SMTP id d2e1a72fcca58-848896595ebmr9244499b3a.21.1783966682085; Mon, 13
 Jul 2026 11:18:02 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:47 -0700
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-3-ctshao@google.com>
Subject: [PATCH v1 02/12] perf vendor events intel: Update alderlaken events
 from 1.39 to 1.40
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
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/7a14cc8feaf86772deb6708e96c8e9fee6d=
5b1ca

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../pmu-events/arch/x86/alderlaken/cache.json | 32 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/cache.json
index 0ffad953e752..b39c73614b86 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -1,4 +1,20 @@
 [
+    {
+        "BriefDescription": "Counts the number of core requests (demand an=
d L1 prefetchers) rejected by the L2 queue (L2Q) due to a full condition.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x31",
+        "EventName": "CORE_REJECT_L2Q.ANY",
+        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q.  It also coun=
ts requests that would have gone directly to the External Queue (XQ), but a=
re rejected due to a full or nearly full condition, indicating back pressur=
e from the IDI link.  The L2Q may also reject transactions  from a core to =
ensure fairness between cores, or to delay a cores dirty eviction when the =
address conflicts incoming external snoops.  (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event).  Counts on a per core =
basis.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the number of demand and prefetch tran=
sactions that the External Queue (XQ) rejects due to a full or near full co=
ndition.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x30",
+        "EventName": "L2_REJECT_XQ.ANY",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "SampleAfterValue": "200003"
+    },
     {
         "BriefDescription": "Counts the total number of L2 Cache accesses.=
 Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5",
@@ -70,6 +86,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH_L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x30"
+    },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the LLC or other co=
re with HITE/F/M.",
         "Counter": "0,1,2,3,4,5",
@@ -103,6 +127,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD_L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the LLC or other core with HITE/F/M.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 414744811c00..d82f6b3d5b68 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.40,alderlake,core
-GenuineIntel-6-BE,v1.39,alderlaken,core
+GenuineIntel-6-BE,v1.40,alderlaken,core
 GenuineIntel-6-C[56],v1.19,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
--=20
2.55.0.795.g602f6c329a-goog


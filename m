Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C17427FAF
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061650; cv=none; b=AOxfqXEDL+pmx4XaJXZsLnpPBoEQyltx342gHcZ3xmxzuD3v4vwoSZR54WyViMhGYGaGOLN8dI5qnRJYqF1pisKW6rmjxjGb0PZS3oIzLbGyd8bnzorOIUWO3XrYo1L4fIwPh2D0cdgZxUloQ1MdN7wbPvH0d5QzlFVcgrJIttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061650; c=relaxed/simple;
	bh=kODCzbyTZnW41nUmt5wrGiwZbKSNeQit74S3Et91Y3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XyQt3vWaHgrekLMR3o/RdHTIVHV6mIJiQ+Xcb8jMUl5Nn/yBS13r43IjwcaxdtIGfDObm2AnD/aGmLXjRdKUlh+E/uRhKUoM8UgFkFPHN7boC/8Xdf5M4bDNeINMoCikyO9XkvVORleg54UBQGMZ4wMVheXbXd0F3v0Su7WDTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4v+NRyn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4v+NRyn"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848551b54f5so9099821b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061648; x=1784666448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vlt2bHf09FdrzlhXYjUdFEsgvRxnDF2DA7GnXopVeIM=;
        b=h4v+NRynvrlfTT/yOivJ+/hTZjDK6yvt7JXXJhlQtoPVmM8MsrCLk8CLyHUNMFcTfk
         QQL1s4fTcoWms+MgWx6BwpzyB7ceqOrZEZy6PDjUCawbWQD0/EeNeA3vv4Okp3851S5T
         NEWU5LfwzxBAMNNSlT363i5mDcPEiCeGiD/5twNhTBUN67vSeoDLTd7kpQz5vO4kY24m
         uihIOgZjr6XIgS1BzCNJ9eJZsb4b9JcA0Tgq9FuhmayzetO9+7r/Iz+Alo1W5kRjMMF7
         dx2+9iJ0bdCf8e3sVEzZ911A6lOZz8o/wtoGr4ipOnXMAmhUCEpcyaJ7WzJ8+1SfHAyx
         4z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061648; x=1784666448;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlt2bHf09FdrzlhXYjUdFEsgvRxnDF2DA7GnXopVeIM=;
        b=omnfAyzaz3Z0S2IeWJ6w4qeqpMsMX7g13dZ1ZxrbIRfJniGEaqYi1WSYrSlqAd2vvI
         1rkKbPIeUsxavw8VtdbKo/H42gt4tlWvbY1NU8yVhN3UKu97P9ZYSX4VmzRwb4zqODhD
         5SWeZuWZEvX14lmgERO7QjI1oVCuAjV6hstEgDZ1ysBOmGPbfRSa5my8GMA//eWlmCFX
         eaDdf+D5tt8qvNWeOoZiq6Ak5d2sk3tt+8ty475GpGbGF3BzxC3ayQqGzer62txQbeFo
         NWoIF7V12pnxNoToPK81QRZTP8ZfQwoXduMG2nBdFljybuTjz6DOOxxPOVGtDP4OQ0PT
         9Eng==
X-Forwarded-Encrypted: i=1; AHgh+RqvKa8x+R905WvtGcgs7JN6tmbVl50rLrOVGOwCPL/QfAkM3p4AxsIrabzgyOxgB3WQUaY3Cbs6QuPBmDncsb2G@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQdep7sIxUhkJY42pdeD+7qE+GNHryuLMAaZ0iEBaFUsdKG+e
	VRU0xMN+wDT8bnuUU9pABlG2xL49fU5Evqg1ZFWNCvMXOaxcupKZMZy6clU2+/2PWJ6sylvPozd
	nFmz95Q==
X-Received: from pfbck7.prod.google.com ([2002:a05:6a00:3287:b0:84a:31b0:7544])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a20b:b0:84a:32a9:a5fe
 with SMTP id d2e1a72fcca58-84a672b5588mr101209b3a.36.1784061647775; Tue, 14
 Jul 2026 13:40:47 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:33 -0700
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-3-ctshao@google.com>
Subject: [PATCH v2 02/12] perf vendor events intel: Update alderlaken events
 from 1.39 to 1.40
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
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
2.55.0.141.g00534a21ce-goog


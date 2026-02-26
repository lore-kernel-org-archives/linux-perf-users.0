Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A23624B7
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128792; cv=none; b=IwTji4var6BknfiVjJsIXBdPa/rW7h4eMaDl8FryCGcCw4A3Ts86coYIaxGb5g6CIV6ALNJTB9faOUr34YMxiwPeJsiuNuH+L7TTQE62IjSri5ZBL6k+3/YX12BfRMYRJeSok9tOk5YK+EzCU45YyszWGza/ppyz+zZalWJapWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128792; c=relaxed/simple;
	bh=V812KtRxICnIqr5kjTFeDYAuOKsz/nR3zKd8fXnsoy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=k62Yyk3IMIzTscKXhhckkw0W1M9gkx73/k6PYjJDWqcnCsII7ux2dbSi1pbuEfDP+WeMfpRxUOj4xWmMQ7ZNqudKbBvei0vaP+y8orA5mxaD3/x7I80siLT5CZk8kdNeaLvt/re4iUQ2ivyq8EJA9MsgWCobkgifEPxBs/G/MvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkTxxHsj; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkTxxHsj"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12733e595e5so1695505c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772128789; x=1772733589; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0sd+ZwPNif80S6gNRMMBCY+IhDOwA5QIZbdK/H8ojY=;
        b=CkTxxHsjFIGUDgLcKTwbiXajsc/c1WXLnKaDQvAx8N8g98Xe+4jgwovbr+iz/TmCRq
         HiZj9lBVQrZy4t6lQBMg0f0wUMqzSGC/b3D5yBK+wiPcg0QwP0ic0gnLsQ5GBub897U6
         tS7APALGw5/N2bL7KPvTSdEkOXziu4H/LpRq1aYYcMj/b5Vl4xK+HLk/MU2O4eQHlQQ3
         RHP/OOsVD5XeF1WUd/B1jo0K0UVNUW3KAWdKwGe7RBA8CHBTFtGu+FXgwWhrQkiZPQP/
         mlneZrMrKxeXlK/uw4utA1g7e3N5NhYhfkpHJMDIm5ce0vSh8mcwaL/kHmThumKMz2H5
         7CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772128789; x=1772733589;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0sd+ZwPNif80S6gNRMMBCY+IhDOwA5QIZbdK/H8ojY=;
        b=cyUzpZqEfBzoEQKVUNnrQi5MTtLriyyFB+PqxQ827lDASTuBKJR6NSY/eA6rZbsxUe
         GAZvzUhPaECZ4Tw43PNm25Kr3u3kh+kXrjV0XNbNG9tpaEUKhzBoY15zHMdbW8gH1jKD
         0YFtYfwOTtbefSZ4EUj0eSrxY8mCro+ZKTDUqxLEEctEGGTHoRh1iTnMn/RGMYgkGhUs
         qzJ5C3NCFuhJb8R2TOHhrRl5BxwLJNBAlGV6EWFJGYD9tI2dbDlehj+wJd7GH2NkzvRh
         jx2puKRMFxqXJdz9buAGqfxah49HpC2cxp34SzPSyIpQjVfnOrOx6WNH9T63WSVCIksB
         7oCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbWDaQbzR9Kt5DSXhg0PE5eejcNULhT7Eq7fdYp7MyvpyasjB/fF31ji6MAEYigbVGkBcq58NYpZ5QbwuRd3Ob@vger.kernel.org
X-Gm-Message-State: AOJu0YyhLwnDs6SAlg4Jwg7pSXraYSSAXaO2wI8SlAooMdWCRsd+t0Gb
	zKRlLdFJDRccylHLlEE1aTDRV0mal4pEr0bqZ05J4vEQ3zRuH/HGIctatM+cNZmjaLFUNIFVbjG
	tD4KLHpXNzQ==
X-Received: from dlbbs39.prod.google.com ([2002:a05:7022:927:b0:124:a5f5:ced])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a9:b0:11b:9386:8256
 with SMTP id a92af1059eb24-127869d8d7dmr1648777c88.43.1772128788770; Thu, 26
 Feb 2026 09:59:48 -0800 (PST)
Date: Thu, 26 Feb 2026 09:59:31 -0800
In-Reply-To: <20260226175936.593159-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226175936.593159-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260226175936.593159-5-irogers@google.com>
Subject: [PATCH v2 05/10] perf vendor events intel: Update graniterapids
 events from 1.16 to 1.17
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
https://github.com/intel/perfmon/commit/c9ebc3ff9c3d408a888fbfbe73d386ef86c=
7306f

With new IO and SNC metrics in:
https://github.com/intel/perfmon/commit/04cf5e1e804afd775401167870d48cd2586=
4be7b
https://github.com/intel/perfmon/commit/98b2602d83de6625bae1e6fcaab3a39b0a3=
41255

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/graniterapids/frontend.json      | 16 +++++++++++
 .../arch/x86/graniterapids/gnr-metrics.json   | 27 +++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/frontend.json
index d580d305c926..1fdeaebb739f 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
@@ -325,6 +325,22 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json =
b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
index cc3c834ca286..299631fb8d53 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
@@ -143,6 +143,12 @@
         "MetricName": "io_full_write_l3_miss",
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "The number of times per second that ownership=
 of a cacheline was stolen from the integrated IO controller before it was =
able to write back the modified line",
+        "MetricExpr": "(UNC_I_MISC1.LOST_FWD + UNC_I_MISC1.SEC_RCVD_INVLD)=
 / duration_time",
+        "MetricName": "io_lost_fwd",
+        "ScaleUnit": "1per_sec"
+    },
     {
         "BriefDescription": "Message Signaled Interrupts (MSI) per second =
sent by the integrated I/O traffic controller (IIO) to System Configuration=
 Controller (Ubox)",
         "MetricExpr": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED / duratio=
n_time",
@@ -294,6 +300,27 @@
         "MetricName": "memory_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "All reads to the local sub-numa cluster cache=
 as a percentage of total memory read accesses",
+        "MetricExpr": "(L2_LINES_IN.ALL - (OCR.READS_TO_CORE.SNC_CACHE.HIT=
M + OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD + OCR.READS_TO_CORE.REMOTE_CAC=
HE.SNOOP_FWD + OCR.READS_TO_CORE.REMOTE_MEMORY + OCR.READS_TO_CORE.L3_MISS_=
LOCAL)) / L2_LINES_IN.ALL",
+        "MetricName": "numa_percent_all_reads_to_local_cluster_cache",
+        "PublicDescription": "All reads to the local sub-numa cluster cach=
e as a percentage of total memory read accesses. Includes demand and prefet=
ch requests for data reads, code reads, read for ownerships (RFO), does not=
 include LLC prefetches",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "All reads to the local sub-numa cluster memor=
y as a percentage of total memory read accesses",
+        "MetricExpr": "OCR.READS_TO_CORE.L3_MISS_LOCAL / L2_LINES_IN.ALL",
+        "MetricName": "numa_percent_all_reads_to_local_cluster_memory",
+        "PublicDescription": "All reads to the local sub-numa cluster memo=
ry as a percentage of total memory read accesses. Includes demand and prefe=
tch requests for data reads, code reads, read for ownerships (RFO), does no=
t include LLC prefetches",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "All reads to a remote sub-numa cluster cache =
as a percentage of total memory read accesses",
+        "MetricExpr": "(OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD + OCR.REA=
DS_TO_CORE.SNC_CACHE.HITM) / L2_LINES_IN.ALL",
+        "MetricName": "numa_percent_all_reads_to_remote_cluster_cache",
+        "PublicDescription": "All reads to a remote sub-numa cluster cache=
 as a percentage of total memory read accesses. Includes demand and prefetc=
h requests for data reads, code reads, read for ownerships (RFO), does not =
include LLC prefetches",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL + UNC_CHA_TO=
R_INSERTS.IA_MISS_DRD_PREF_LOCAL) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL =
+ UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_=
DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index b84035dc5b4f..96580ffda7bf 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.21,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.11,grandridge,core
-GenuineIntel-6-A[DE],v1.16,graniterapids,core
+GenuineIntel-6-A[DE],v1.17,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
--=20
2.53.0.414.gf7e9f6c205-goog


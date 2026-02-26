Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0338A71A
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081600; cv=none; b=q5Ux5eXX9u4k2yGEyGkOahmgVN1sC4MpU6WO/279ekMlA47Pzabk8PIneDckgWG1ckVYcBsiEEApDcudBEtjNOEkplXjQtaGXwFJnMKWzI0Ia9rLouWdCQWZoNIazSTwA81axsWpfX9+hJWRgcrU6XmIyvfXyCF/qNGkstFT3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081600; c=relaxed/simple;
	bh=V812KtRxICnIqr5kjTFeDYAuOKsz/nR3zKd8fXnsoy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Btbd4CXAn+IS+bHaZTa/iqhQouPi8WaSYRmYNwYVk3qGrkAVFs/UkQ9HS5Tcsn/ZNeVd7hB45FItpliYEibfUqlFQrCr96wv1UvE7ugaacmFNunyDexQS6VcpswHTe1OCZmNpMs0D3dNrur9iAOuyS2BMZcNUPYy/4epfGsDhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yj9Gmibh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yj9Gmibh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdb0c8c5bcso9867845eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 20:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772081596; x=1772686396; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0sd+ZwPNif80S6gNRMMBCY+IhDOwA5QIZbdK/H8ojY=;
        b=yj9Gmibh4jUVL97Cnl+8Qzd+VLeBXPhmwDyEzXUrX6SlAMJzJOiPrCQ0cLcnYZyWhV
         wVE6tDfYWJQxTg/g7ntfP5X/7fgAKP4q5NZM9S61TIcPhVxQ+A8+H6/cfvuNVc3jfknm
         7rFT3RjjE9Jq+ksP/ERfX2idft5TUnQzi/DaNkcl4NwA6Po0z1hDn/l0MXFhrS3jyan1
         nYSdn4eeVXph5jk0HYSUKG1dCy4iFoVkisDC93I/kb0yW3CeKPwpnDK1nt5QifakQbr7
         KsUcCXd82p+vf0lHXLUCZuUlHUMEg7xOAWjziN6D97UW4boZJGCKSQ2o1IaBX60HVObP
         usGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081596; x=1772686396;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0sd+ZwPNif80S6gNRMMBCY+IhDOwA5QIZbdK/H8ojY=;
        b=KDMlFCDOZgP2b1wVdfYnqIwyBJ542j2wJK6bWXcMwVlsyzcRxAnvpTY+xFjTj+/3fj
         j/P7B2Qu5PztvRDt3W2BTh4V+MK3VjJyEaw8wjl9can7ny9QvZzeGmR9wV29g0dS3nDj
         v6tqHwvg+GShtbxuSg2fVZCViwwmGWr7Vw986YLmeY9z2PTW9+p7sEH+2bgLWDl4xo7Q
         qcSrvPyvpkk2536X7e9ncjcTttFkTylK5LqTVtLfa/bO2BYvChYpeYYQLudMXhm4cTaZ
         nJDkUZGhkxYMt2G7xPljanFf7sUOmmWiq/eKhoU972yqlWJDoLDojkDftyRr5c1HIBQY
         X+zA==
X-Forwarded-Encrypted: i=1; AJvYcCV2bW8EbcgLCIRDy4I34UGGLy7vI8zzJ65+xaTgEg3Um3G6/4AjxeUSlPFToCIZoIS+8FZzKPUoZgyFycajA1XC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh69BO9q1swYU7bgerJtT2U2V2U78fL9Y6w/2BoLW0BcQI8Arg
	4EpoPYHxud7n3ZmxCd0CkGDfcWUMDY1Bbm/NM7865pQYwMCH22PDwFBRMZP2dZ11zBgUzlZdVCR
	KB6kOP0+0gA==
X-Received: from dybia18.prod.google.com ([2002:a05:7301:312:b0:2ae:3309:a304])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:df41:b0:2b7:1b54:6081
 with SMTP id 5a478bee46e88-2bd7baed292mr8598146eec.11.1772081595621; Wed, 25
 Feb 2026 20:53:15 -0800 (PST)
Date: Wed, 25 Feb 2026 20:52:56 -0800
In-Reply-To: <20260226045301.459948-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226045301.459948-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226045301.459948-5-irogers@google.com>
Subject: [PATCH v1 05/10] perf vendor events intel: Update graniterapids
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


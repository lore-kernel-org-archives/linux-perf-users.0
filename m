Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197530;
	b=idpiVLqsW9ssaHEMNVa0q0JYRJ7wvlxM4rBX+a9f5lSG08OGb7q5vrc9dwH+o247umxc
	 wix8bHm9m5oKLGyrbA1ncrcst4QT6JmGGofFPE+6UKr7nvYbQDKOOkKuRwNPYSjpdOZ9g
	 Buz1L5HuIFpw2rOLKgBx0koSM1Qz2xJ7RW0yPwY1OZRcMXUzoSvicr/aCFX+AEZ+Hw7+n
	 n73gy5MSzvjUpegoGXeF1ARLE78g4lEnmv5Y7SMVHU5dz//JMhwVS433gQt5HHfSeni8C
	 BwAotaBa59R1VEspdCeDhYcmhzwFU2NowFarxlYeacYpCCp8dowwEcs1/Ut1Bdf3sDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5/QV+3/iD0hbd13hdj+M98vkDtWfM2lwJY6Jp+F/ytQ=;
	b=I6m3T6f8yzMl8PY8qAm+d5vyXOlhGEj1BpJyhZG95VeflFkmW6klqG5SLRd26cR/xuLh
	 NNd6c3/LBTJJLiQKLMIM8B3qE4YHxALivpxWFRtpB3UEbXUm4nqe7U0pVLFdLuVC2QPD0
	 AKUr/BTu586GPZ3Lm7QTGKOQnF62h6C0gD9ZD8kB4neguwshHLy381JzTw96lfwJWbCx+
	 N0ggEiWDe7VCq/uy2my3zvgGjhRiHdNP8B783ZlvtA3RFGBa+TQvIMJtrSM5buw8ArO3Y
	 U6Z0c+wzdHzlm6x+gCd+HZ5AYoOJ08NnrtFET0ubP0GhR9oWGb7H3/d/ATRIbAoYebw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MfOwqRzj;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8731606A339
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 17:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8731606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MfOwqRzj
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2138936c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197529; x=1795802329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/QV+3/iD0hbd13hdj+M98vkDtWfM2lwJY6Jp+F/ytQ=;
        b=MfOwqRzj9y5Kbc3+7nEsyGolbcgKpX/rH8HOzhuInG9P0zeNNrpCj13Kvn5uRTLauO
         ly/FB3GkKwbqgHgiCbb0FU819JBoo+ul5nl10cXf12kmVs20uMuVXNQcj7q1qSJsEEu3
         +thxDFiJkpZvQsBrsRQHWi4zrjc/eZYyrmSYPrMuXnq+ms9aPaxXxVSRYRvKgaCIgrlq
         bE8ov631xlfGIrlfgH+26K7LWRkFKPNO1Ze05/Zmdqg4FTxqHCbu0CVqnSBObL5o8aeg
         01Iu+J8NWvuwPOC75TeJsKSDFiUGTltfrx9zU4Bj7hFsrr+X1Wuwh3xJTmm76iRPmuop
         aNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197529; x=1795802329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5/QV+3/iD0hbd13hdj+M98vkDtWfM2lwJY6Jp+F/ytQ=;
        b=ByixIsABTv+M3q50Dhi7o10pgXFC/k8Kcsp9SuiBFbm8wTQo0DvgyItlbaGYVQimWt
         N2rMDsJJ8I38ySA3fuSU9uJVWUKuxmywXbb/2WC8/4JkLbiH8RK1+9b/VP2DdvH5fzKY
         yiOo7YTkBlSuKt1iqK95lwpfhZKYU10ksRs0iIo4WxnllwzE3TpkneACcUiRMAwVn0dD
         OFP5T5Z94k4naQhIZcY/epFIInl7ozr7Qarqly0vcEfvavrrsplHUf3kt2RPaSIOQaOb
         y3xCIL1C1byzc6M0HY4GYLmAmpOH8h+cWI1kmGdkjhRNN5f1IhIF6XzZxMFkriXXAOVm
         rgLw==
X-Gm-Message-State: APuU4Z8jxOPRDkfDo4sYeXOFC2NFW7AvyvlVLgUo0md7L5BgFCBDXFL8
	7JOPfBVlMNTljKMFYiVufl+cgSPy7GnKoSRRr6jZ4Dhrl7kgrF7/YdNPvc+XhqHv
X-Gm-Gg: AYBFou3hfvNjSwOjp/RB/YSVTwM2co7SKhZd9/41b/j9nWTof5Ln6xF4pAywCBHU/gu
	ywItak7gU0b4ovdFY4FV/xIF+Uvc39E9jNBcrOd9sS7xtCN4sKu+5pm1tu+l/zZdQOm8TAlPq5Z
	7b9YWMeXon0+EMQhd11X9zgWnWckt3KGoga258fUy2SALLilInVApEt9yZ8NlMhsiw2fDnFRNgY
	j2Yrc0BLTtz3oMUF7ooyzb8wyrsEjfR5XrkAXbeWPG+Ykf8JJlwugfvJS0P99Pcw5tzGDbDEkkf
	xMyhhrOiKa5VtfzrJcC/qYUQmjiGN31SMmuZyzXWTq9KA9nt6xlRoJE+8Z2SwaYsuux2gcVpO7e
	zr4l8cS0APO5EQM4VlMtaH3e6uaxDl+XZvmA5JcT/FNDpHChx0unvrmvmAwtahxVBnfohuiRdLK
	trjJEWneRcbQKKmRdIYmjSiqhEc3G8YU6831TvsisBP2pdaUHsZ0bEyLnKRZjBbGwKSgo52Lie8
	CA8ynEQKvDEG8Lyle4szAqboDwHLKTXwtjJC9Per4nbb0czy6IhzC/61pJTmxJel9d33+4bKIzO
	XEIRFf22bFsKZlDiBgb3
X-Received: by 2002:a05:7022:2207:b0:166:b307:5855 with SMTP id a92af1059eb24-1b556688160mr5050309c88.0.1795197528972;
        Fri, 20 Nov 2026 09:58:48 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm681084c88.5.2026.11.20.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:58:48 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 2/3] perf vendor events intel: Fix misspellings in the Intel model tables
Date: Fri, 20 Nov 2026 17:58:39 +0000
Message-ID: <20261120175840.1274637-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120175840.1274637-1-takano32@gmail.com>
References: <20261120175840.1274637-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Five descriptions are misspelled: "Prediciton" instead of "Prediction"
four times (the BPU_CLEARS.EARLY event in the westmereep-dp,
westmereep-sp, nehalemep and nehalemex pipeline tables), and "contoller"
instead of "controller" in the sierraforest srf-metrics table.  Four of
the five are event descriptions, which `perf list` prints as they are; the
fifth is a metric description, printed by `perf list metric`.

Only the descriptions change.  Regenerating the tables with

  jevents.py x86 all tools/perf/pmu-events/arch out.c out-str.c

leaves every event name and event code untouched, and the generated
out-str.c shrinks by 477 bytes, because the corrected text becomes
identical to descriptions that were already stored for other models and
the duplicates are dropped.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json       | 2 +-
 tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json   | 2 +-
 tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json b/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
index 869c84fa7c60..af823669fe71 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
@@ -51,7 +51,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "BriefDescription": "Early Branch Prediction Unit clears",
         "Counter": "0,1,2,3",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json b/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
index 869c84fa7c60..af823669fe71 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
@@ -51,7 +51,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "BriefDescription": "Early Branch Prediction Unit clears",
         "Counter": "0,1,2,3",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
index ca2c55917e55..a3d8c136334e 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
@@ -107,7 +107,7 @@
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Bandwidth observed by the integrated I/O traffic contoller (IIO) of IO reads that are initiated by end device controllers that are requesting memory from the CPU",
+        "BriefDescription": "Bandwidth observed by the integrated I/O traffic controller (IIO) of IO reads that are initiated by end device controllers that are requesting memory from the CPU",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS * 4 / 1e6 / duration_time",
         "MetricName": "iio_bandwidth_read",
         "ScaleUnit": "1MB/s"
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
index 0267788d9dce..e50ce906ed7b 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
@@ -51,7 +51,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "BriefDescription": "Early Branch Prediction Unit clears",
         "Counter": "0,1,2,3",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
index 0267788d9dce..e50ce906ed7b 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
@@ -51,7 +51,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Early Branch Prediciton Unit clears",
+        "BriefDescription": "Early Branch Prediction Unit clears",
         "Counter": "0,1,2,3",
         "EventCode": "0xE8",
         "EventName": "BPU_CLEARS.EARLY",
-- 
2.53.0


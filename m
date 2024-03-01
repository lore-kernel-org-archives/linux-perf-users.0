Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39283C46B
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318888; cv=none; b=tDN6DBIsBhb06OJYnndtT/4kgf4LRVWVGezl1HFK45IEUpOcicE3dUO37OR6og65Z8ewnjPzBiAvR9wNDcYi4fJnj39/tITmo3iH6a3eF388YWafJi5EyYUcgwhVCfINvQUP8OV60TwuKNNu9+pdEjsYCWhjsO/JRr5BTe0yxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318888; c=relaxed/simple;
	bh=XBT9PFw4GJEI1QEQOFY5V3VQlW/6wsuXkDB+REWJty8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hHoDLCPdcjJ6PqyUZxe5/gb1+6k1r17BAg6EQigXG8sl6KZiTVm6nu04fIJP8Tbahgl893KV7UyDCzCf+I5mXh0EutkeiFvI8pCaObEvXagxuh5Tyg05BzYW/wpPuZaA+K8S3upSGhMmDZX9xM82WnYaTlaAXjwYVk4qfpLZXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SqCkYMSe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqCkYMSe"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso45964887b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318885; x=1709923685; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW5aXCnWYkSdBtfKb1tyFWz2NLyYuSqZgMPUtXRmNrc=;
        b=SqCkYMSegblOi7eJ1yNAYlydT0U/Jp1fbEVwXiQDqcgaCJD8BYfycN8NcFkjnDgAWd
         BBjJbY6VzCjKJeY9rHQZoI0HtR9xo97YAkjmeyr762x3BCH4KuyaI6ncy2zeEW6Io4Vc
         /1xCUF2EN7pwGXbRVjShjdmF2RmyQYshBqvmtwdRG9/yypINhWFT27jVN9+YujoDU3DW
         9w784GQVT2hsSfB/vGQ5MmiCMWF9rl6A2dp+cJz9GFtrfJLGl10O/C3E2G9xhfZGJ716
         LfugjHv04cf4qG2WSxRmKfC1yLcUjFs4xH1ORvuxBYmKxKDkyEhL+OKEK0IWUiHYOHjs
         XZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318885; x=1709923685;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW5aXCnWYkSdBtfKb1tyFWz2NLyYuSqZgMPUtXRmNrc=;
        b=ZFAh0c1QWG2viWrNfwVgNfsy8LPEytIqgNlo/Fi7jIbtDHb1vmdJ4cSKfmpRgTlOdr
         u9IS3gMo6S250km8+5kpVmXeSJIFLKkO0aezBef4Bx0EXi3Gnd/2FEAlA1N/5nGRoG0U
         7BGVK1b2DLUywAMw6N6mdK54ndrfAbHRZ9jJG5Pwhup6dXPHE7fxViBq9YgSMAhgFDOk
         f2j7WogZC+difPACQGQ6POMh8uixf5SL/0ktqyRgOiceV+8JGFg6jYjvQCaKVuSDr75M
         U0OU5I8wdQ052XhXZtKCX1ng6JYf7j6To+PautgRgSZT9OjBek+WaZxmiIgklmgaVsoE
         mtag==
X-Forwarded-Encrypted: i=1; AJvYcCWWBemXv+88GQdYBCxJ6Sx9W3EuW8J5y8lgWYZeKMg2OFczpg5HsCx+AGFBERzaNHrkaQAMI+5PvUG+OMSNgRnOJK9EmStbz7xUNsDoGPylsA==
X-Gm-Message-State: AOJu0YxHAdri8ml8W6QT+jgJt+cB8VhKanE1De9xd000cnZgQ4S1YprH
	Fsxyetv+pE4vDGCZoqQv947jQXQrRiuHqs01N60ih6JuBf23xHnD9PaN8idDe2WolJi3YawoB20
	NAPap0Q==
X-Google-Smtp-Source: AGHT+IHi8ll8T6N/4FKRHr3jgBpE9kBtsY0MxYnyl87W0DLqijXID3ZgAZT5SDy9eMsuZjtJbkhonmVvY8a2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:110d:b0:dc6:e884:2342 with SMTP
 id o13-20020a056902110d00b00dc6e8842342mr710276ybu.5.1709318884811; Fri, 01
 Mar 2024 10:48:04 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:33 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 08/12] perf jevents: Add dtlb metric group for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add metrics that give an overview and details of the dtlb (zen1, zen2,
zen3).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 82aab39c2a50..be10acb40762 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,113 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdDtlb() -> Optional[MetricGroup]:
+  if zen_model >= 4:
+      return None
+
+  d_dat = Event("ls_dc_accesses") if zen_model <= 3 else None
+  d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
+  d_hcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if zen_model >= 2 else 0
+  d_h2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit")
+  d_h1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit")
+
+  d_m4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss")
+  d_mcoal = Event("ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss") if zen_model >= 2 else 0
+  d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
+  d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
+
+  d_w0 = Event("ls_tablewalker.dc_type0") if zen_model <= 3 else None
+  d_w1 = Event("ls_tablewalker.dc_type1") if zen_model <= 3 else None
+  walks = d_w0 + d_w1
+  walks_r = d_ratio(walks, interval_sec)
+  ins_w = d_ratio(ins, walks)
+  l1 = d_dat
+  l1_r = d_ratio(l1, interval_sec)
+  l2_hits = d_h4k + d_hcoal + d_h2m + d_h1g
+  l2_miss = d_m4k + d_mcoal + d_m2m + d_m1g
+  l2_r = d_ratio(l2_hits + l2_miss, interval_sec)
+  l1_miss = l2_hits + l2_miss + walks
+  l1_hits = max(l1 - l1_miss, 0)
+  ins_l = d_ratio(ins, l1_miss)
+
+  return MetricGroup("dtlb", [
+      MetricGroup("dtlb_ov", [
+          Metric("dtlb_ov_insn_bt_l1_miss",
+                 "DTLB overview: instructions between l1 misses.", ins_l,
+                 "insns"),
+          Metric("dtlb_ov_insn_bt_walks",
+                 "DTLB overview: instructions between dtlb page table walks.",
+                 ins_w, "insns"),
+      ]),
+      MetricGroup("dtlb_l1", [
+          Metric("dtlb_l1_hits",
+                 "DTLB L1 hits as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_hits, l1), "100%"),
+          Metric("dtlb_l1_miss",
+                 "DTLB L1 misses as percentage of all DTLB L1 accesses.",
+                 d_ratio(l1_miss, l1), "100%"),
+          Metric("dtlb_l1_reqs", "DTLB L1 accesses per second.", l1_r,
+                 "insns/s"),
+      ]),
+      MetricGroup("dtlb_l2", [
+          Metric("dtlb_l2_hits",
+                 "DTLB L2 hits as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_hits, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_miss",
+                 "DTLB L2 misses as percentage of all DTLB L2 accesses.",
+                 d_ratio(l2_miss, l2_hits + l2_miss), "100%"),
+          Metric("dtlb_l2_reqs", "DTLB L2 accesses per second.", l2_r,
+                 "insns/s"),
+          MetricGroup("dtlb_l2_4kb", [
+              Metric(
+                  "dtlb_l2_4kb_hits",
+                  "DTLB L2 4kb page size hits as percentage of all DTLB L2 4kb "
+                  "accesses.", d_ratio(d_h4k, d_h4k + d_m4k), "100%"),
+              Metric(
+                  "dtlb_l2_4kb_miss",
+                  "DTLB L2 4kb page size misses as percentage of all DTLB L2 4kb"
+                  "accesses.", d_ratio(d_m4k, d_h4k + d_m4k), "100%")
+          ]),
+          MetricGroup("dtlb_l2_coalesced", [
+              Metric(
+                  "dtlb_l2_coal_hits",
+                  "DTLB L2 coalesced page (16kb) hits as percentage of all DTLB "
+                  "L2 coalesced accesses.", d_ratio(d_hcoal,
+                                                    d_hcoal + d_mcoal), "100%"),
+              Metric(
+                  "dtlb_l2_coal_miss",
+                  "DTLB L2 coalesced page (16kb) misses as percentage of all "
+                  "DTLB L2 coalesced accesses.",
+                  d_ratio(d_mcoal, d_hcoal + d_mcoal), "100%")
+          ]),
+          MetricGroup("dtlb_l2_2mb", [
+              Metric(
+                  "dtlb_l2_2mb_hits",
+                  "DTLB L2 2mb page size hits as percentage of all DTLB L2 2mb "
+                  "accesses.", d_ratio(d_h2m, d_h2m + d_m2m), "100%"),
+              Metric(
+                  "dtlb_l2_2mb_miss",
+                  "DTLB L2 2mb page size misses as percentage of all DTLB L2 "
+                  "accesses.", d_ratio(d_m2m, d_h2m + d_m2m), "100%")
+          ]),
+          MetricGroup("dtlb_l2_1g", [
+              Metric(
+                  "dtlb_l2_1g_hits",
+                  "DTLB L2 1gb page size hits as percentage of all DTLB L2 1gb "
+                  "accesses.", d_ratio(d_h1g, d_h1g + d_m1g), "100%"),
+              Metric(
+                  "dtlb_l2_1g_miss",
+                  "DTLB L2 1gb page size misses as percentage of all DTLB L2 "
+                  "1gb accesses.", d_ratio(d_m1g, d_h1g + d_m1g), "100%")
+          ]),
+      ]),
+      MetricGroup("dtlb_walks", [
+          Metric("dtlb_walks_reqs", "DTLB page table walks per second.",
+                 walks_r, "walks/s"),
+      ]),
+  ], description="Data TLB metrics")
+
+
 def AmdItlb():
   l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
   l2m = Event("l2_itlb_misses")
@@ -362,6 +469,7 @@ def Rapl() -> MetricGroup:
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdDtlb(),
     AmdItlb(),
     AmdHwpf(),
     AmdSwpf(),
-- 
2.44.0.278.ge034bb2e1d-goog


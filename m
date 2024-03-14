Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387317C79
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395942; cv=none; b=iULOphbAygOSdwAZH6uWj/AyQxFS+e70i75zV/kU56DaxABuqCB3vlEmL/9dnhKQVuxzioh4UkK9UY8bUhk1iOBrd01thUAMOCMQc2LPLyNpa/jnaH8UGnu4ReztsnM7IzyPGMqw4KRNciXonTXhZ5gQCjORRw7p0zGDsOg5+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395942; c=relaxed/simple;
	bh=uD+ncb3SOpzS3D4AWmHZXyW8xZjeqOQxX5jabJMPaGE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AQ3+M7g3Wkxmqh+Chd9W3Z+J6VqljXcROppcNDcEds6BrnbMSbrG5DvmbZXP8N0bZU9aGNWHHcuk3nx+QsMBTKLFFSahqLSoAKzfIeN6C5SeyrtfDp2rLM6E60Jji4OcLhhF1UwSb42Dyu9ZI3MLd//ZPgJaD+YKtrp2X9F7UmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hacqdjwB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hacqdjwB"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6fa0bso14086457b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395940; x=1711000740; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrI/1zc5BFXiIRfg2dbGhOnQNaJK/kV9DB75bXww9T4=;
        b=hacqdjwBhKl+vlnCRIlZ5LPe3G0e+aYBkieBEE/SRtuMq4s+PKUVQCZGDPV0AYpL8u
         Vn+VAugWjFMcsD90qamob79XjYCNCyiz5ulhzXvhMTn8xhz4FnQ3DO/0CkQ6pSOj54fu
         NrOP12/YffN/nGKvDc1FreQHGFt+ksAVoejJVTJ2oImiuWk4skbGfUDU3sKVzjNk3egw
         XyvXQulQNy8Y5qLpSaYkdjNnuuTkpvR6xdLyvyJt1kH/cXvx1NoOCNPfwlvrqKLfNs/P
         8MuUuBKKYQN/sY1ikkNAenshYslfG3o1qhaZqSW/o1tv/36nPG4cyLCKWV94L6D1ZVPj
         nJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395940; x=1711000740;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrI/1zc5BFXiIRfg2dbGhOnQNaJK/kV9DB75bXww9T4=;
        b=Leg0mK9zW9TGVecs/lyTNz8hHYZpmlgGbePqLh8un2dVgCS5AWIhW93x4wQJNy3pxo
         leWR4TcdFlZDkRkaenxXgzikJGdOTapAH0UiXv8h5yeZ2blE10q3PDVv79H1jlnWoXER
         rSA9VnHD/HQ78+5F0P0IsUO7RRWIVSfYnwdOEAb9tY+J6q8zjeUYMsLizcvtjExvRPc3
         GmcseovsmfE0GA/MHqup/dRS8D1gS1qpW9G/1Q0tru41OaANJG177s0d7rTKBdsZmBRF
         BEo29UTUkNVWzyY5spqaLqCMLoQsFoBl5tZDBkc/Z1Pawf8YgBcPeBd+QhwZEpttQxE4
         v0uw==
X-Forwarded-Encrypted: i=1; AJvYcCUkR1h4c3frl+1Q5aro40rwwywqsDqmg5vlJnA9j6tuhdckLsvqedcpkw76DBJSzaqRQ20SAIgkJcD8/Sir/RGGJIa+e4HCfJhbBwG4DMw+Ow==
X-Gm-Message-State: AOJu0YwVdCLm52TC4ItYAzVNB60zGjbZZ8Wc+W7MIfe+TJJZECxZSFrO
	3AfW/sd60WjVm1Av1flPtwZRl8zZ4WYZ4w+SPTvYi19fCY4GYng+z6O2/HkVkGtCVi0mblTps9x
	j3l+B2A==
X-Google-Smtp-Source: AGHT+IGs7JzRifivMIHpa34epwGOHsG0lQ9Y292XADLN/cHfUHmCJF3yE8kqtAphyDzWxZLdKzs7QO6EH2MT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a0d:d64e:0:b0:608:d045:6eff with SMTP id
 y75-20020a0dd64e000000b00608d0456effmr174232ywd.2.1710395940302; Wed, 13 Mar
 2024 22:59:00 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:34 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 07/12] perf jevents: Add itlb metric group for AMD
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

Add metrics that give an overview and details of the l1 itlb (zen1,
zen2, zen3) and l2 itlb (all zens).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 5c91e97ae6c4..519aa9ab8801 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,53 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdItlb():
+  global _zen_model
+  l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
+  l2m = Event("l2_itlb_misses")
+  l2r = l2h + l2m
+
+  itlb_l1_mg = None
+  l1m = l2r
+  if _zen_model <= 3:
+    l1r = Event("ic_fw32")
+    l1h = max(l1r - l1m, 0)
+    itlb_l1_mg = MetricGroup("itlb_l1", [
+        Metric("itlb_l1_hits",
+               "L1 ITLB hits as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1h, l1h + l1m), "100%"),
+        Metric("itlb_l1_miss",
+               "L1 ITLB misses as a perecentage of L1 ITLB accesses.",
+               d_ratio(l1m, l1h + l1m), "100%"),
+        Metric("itlb_l1_reqs",
+               "The number of 32B fetch windows transferred from IC pipe to DE "
+               "instruction decoder per second.", d_ratio(l1r, interval_sec),
+               "windows/sec"),
+    ])
+
+  return MetricGroup("itlb", [
+      MetricGroup("itlb_ov", [
+          Metric("itlb_ov_insn_bt_l1_miss",
+                 "Number of instructions between l1 misses", d_ratio(
+                     ins, l1m), "insns"),
+          Metric("itlb_ov_insn_bt_l2_miss",
+                 "Number of instructions between l2 misses", d_ratio(
+                     ins, l2m), "insns"),
+      ]),
+      itlb_l1_mg,
+      MetricGroup("itlb_l2", [
+          Metric("itlb_l2_hits",
+                 "L2 ITLB hits as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2h, l2r), "100%"),
+          Metric("itlb_l2_miss",
+                 "L2 ITLB misses as a percentage of all L2 ITLB accesses.",
+                 d_ratio(l2m, l2r), "100%"),
+          Metric("itlb_l2_reqs", "ITLB accesses per second.",
+                 d_ratio(l2r, interval_sec), "accesses/sec"),
+      ]),
+  ], description="Instruction TLB breakdown")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   global _zen_model
@@ -339,6 +386,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdItlb(),
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
-- 
2.44.0.278.ge034bb2e1d-goog


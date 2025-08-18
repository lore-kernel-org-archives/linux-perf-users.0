Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50632D248D
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543960; cv=none; b=C9heaf/KWMt1wHSI3XnU5sXFBixk1jAdx3L10M8s8iWEtiOc7dIlRAsRfT8nn0ET7L0gqUtBO7J2vbThKbgH4NowefHjlbq4C2KBqzCbHXcB0VeBoAXDA/0hH+SxreKWH+NMufl2hRxejDHkQ4zyQSWqMd7sdGscMzmQw+v8oJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543960; c=relaxed/simple;
	bh=ya0dbwWUzKMKLeRGa0TbpgvQFOApNQzPsgfDgaJe3jo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Kvwmo+K3+Q4h+/VQJMl+0o/UBqBANqTCTmZxk420KliS4a28MJc2okRbWgSSQVk9hCOSNLxIy5X/JdihklFCEzeKYZZ4oj3i5sulV1q7IvlKgE4N0AYubCPiajLCOETFgrS+TTr4OLoNzs3eujaPc0zflX/Q6GjyPvDqcXzpNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zx6YJqK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zx6YJqK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457f54bb2so107240615ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543958; x=1756148758; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPO7XFOOsTvMdi14sVo1ekX03/m/Zq/cV95OnqVa63U=;
        b=3zx6YJqKOkUTOhs7rrUy7Z0gBURcLp08Xco62y7Hvb9J0Z5Si0gD7M4DJqtUEEctBs
         YD4TWxMK9gFKVvGhKe1upPlCR5BXhlYiZ93vmFkPuiL6obq1BQHkk+M+c5xIqC7sYPkm
         on9aH54ua1BEK6nKYSXAssuSC7ll8Yte4RbWxkXoslCCvA+Mp9dsgpoUFBoOLcq9jGBC
         RH9NN52nJ83WTmc/O0RqMVAnb2pf6n0UV8h5se1EMk9eidKyn9OHbPxXOnnggykL/HhG
         T58/j5GWhY3MQx6oVqwlr8xsXZxwCloKG7qvWczaQabSrZqSBsn5WbXzxLGbwhKEVyvs
         UhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543958; x=1756148758;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPO7XFOOsTvMdi14sVo1ekX03/m/Zq/cV95OnqVa63U=;
        b=sAZlj7ipf2wARBx735suPmncls6PHSXp7KBDVvW6OTkJMEsF2KA8Szu6mcXubT1UJc
         CI8H9USk9RS/m4jO09aQN90Li5nDHL+kni978ck+JB/6A38Mrg6xQlAKnQfhcH3ps+xy
         K3jVHHalwOddyP3zedFEwx4ELBYIOKO3e+oJwl0+KlMW3odG+6HRNTffTCDYdKcl3uwk
         sdknymu8H529HDg5NHDREJ+bMxWBsPdYCS1AAZKfHpyn246WORJhMCVgJefNBglXmNfK
         Zuhdb4ddRWkz060M+v5ZialDdxLide0PFX64yjwQUunl8QXVjH7fEdFyvHyBKoT++jeP
         V+FA==
X-Forwarded-Encrypted: i=1; AJvYcCVPW1NB1h2UMH3zLFxUqrUgE8/kLXj3k4+g5NGInjUnF9ToGwOfysjLCl1r8FLG4Fsp/ov72llUkoUBVKB8RHlC@vger.kernel.org
X-Gm-Message-State: AOJu0YwLIuuUJR4Pj2tQBjKVuLV7uuhv+xZytpPfqf/3XVTZhqcmResI
	Pw10wJM3IpX8eq+5oyhzUk1FwtQ4zzmOAXHcrWbsX/t9J4fmOqjYpfRJQC+bWewcwc76AedFx7O
	L1U/fLf+1Uw==
X-Google-Smtp-Source: AGHT+IEHy4TfrMkq0HMb600V8hJmkl3do3SI7TVe489UJoALKFOP4WLU7LMYMAz+LuWy0oi1SnPpLCv7A7z4
X-Received: from pjc13.prod.google.com ([2002:a17:90b:2f4d:b0:312:14e5:174b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ced2:b0:242:cf0b:66cd
 with SMTP id d9443c01a7336-2446d8f0a20mr204219665ad.34.1755543958231; Mon, 18
 Aug 2025 12:05:58 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:04:08 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-13-irogers@google.com>
Subject: [PATCH v2 12/20] perf vendor events: Update jaketown metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Update metrics from TMA 5.0 to 5.1.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 .../arch/x86/jaketown/jkt-metrics.json        | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 6f636ea0f216..250c73b21385 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -1,49 +1,49 @@
 [
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "cstate_core@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C3_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C6 residency percent per package",
-        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c7\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -71,7 +71,6 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
-        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "1 - (tma_frontend_bound + tma_bad_speculation + tma_retiring)",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
@@ -296,7 +295,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma_info_system_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * msr@tsc@ / 1e9 / tma_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -308,7 +307,7 @@
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized"
     },
@@ -348,6 +347,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory",
+        "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=0x182@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=0x182\\,thresh\\=1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
-- 
2.51.0.rc1.167.g924127e9c0-goog


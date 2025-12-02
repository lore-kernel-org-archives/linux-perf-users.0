Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1962D3731
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697948; cv=none; b=ZJah+wjAN7n74MhUm4ZvEio/yrDfR0ltcwXSX8IZQ8W5HWKEoyQ3YNPpQnjQETDn1aSNfgudqrJywotf4C/Oaw8BgUMaLhUbrW31v6RF5pn/7iHSIXDR7oVGRRPGCNIcou+CTXHpYpZcGokccjAmUQLDjRZ1wTX2MBHVaEokzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697948; c=relaxed/simple;
	bh=ToHaD1gpwP1uWL3U7MH+po+mxnuGTW8jd1YqF5p7UWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iR5OlqLeK7g+7v3JqAK9FSZwGlwTwecLn4XXsEe4S/XHs+js365/nCrn59UOZIn79UOnYkv1o6E/39bJDJStbIaS83HsemPl/kWS0LJoMCCHHCDCzx636XhoK9PuBfww0R9bbWhgCcv5dy4zt2KQ/enDDne/wpJgfydLgxEmcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3rtjZBf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3rtjZBf"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc09a8454b9so12957267a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697947; x=1765302747; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBraLOuppoKBMvtTbUVI8ZVtGBuCTR4b8oDGHI+adOo=;
        b=R3rtjZBf2SIpI3qZ0gNzORMQLgJytbySbRx/agnMYzx7u0j8CqkbU59+VOsBxyILvR
         R6/o0sS9Ns2Vq/lFT31XeMjOkTGUJJp1VAl6ETyvFWxzzjcy/dmxuhHoSmr2p82wwhxd
         9fFzaX2P1edJYnJiAu1a/P+SsdbuSHO5F7q/GeiHDnI4rODQcs+eSLZ2A2HcKMIXqzlK
         WFWNGOe9kjFpObsl1qM3yIYUwI1p7Nx+C6vLexQOIXUgofq3mMpjCbqdxSqa9KbNgUQ2
         PeVRlxfLCDx6sCpUM3p4QR2bDCrYupG1feqB5Qq8CVAylKqskJGSNGvyhpYCX5vHck2j
         fGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697947; x=1765302747;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBraLOuppoKBMvtTbUVI8ZVtGBuCTR4b8oDGHI+adOo=;
        b=lC8C8OEDtadjgtpijBiF2pLpw+xWCEsgTw0OzvzKTCjztEuAk4srEm6xZkhqNk+nHS
         ZL4zxvwxum99Gw08K0GRR3jnC30n3ID3sXqfEGvX7zbrA1CRYDX7OYAcLzDAn71g0J/M
         XIIv4NPvmwElk0I31yvFMzD9HqWdAWL5ZSPdi7PVcpgQnIEACx6aXyWLaA4RDfgedOxS
         uCDbgoVjOFMwCGNFZa5HmSPWhmjyrj3JIgrGTk3i6DW69r3yEA6E0d1PdvWKEihgoUXb
         e8nY1OdP6gr7+cwPdSNG8NWxXSY6R3+dwtz24EoFKo0GkvXQEptKc0lB5dYS1ud4OqGF
         7r3w==
X-Forwarded-Encrypted: i=1; AJvYcCWWe8xVxjkkl2/Iu5hTVM5zoiyc6Zbi6/BELGjJL+MnW8EbMZIBQVyM3D9CT38WrAgjcOCCcpfFyQZqpxaIj5KS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8+nRDlsrS505vZ6ojVjC64Lr2VhhgNBjaCFl8UNwfqmyraBG
	GZGKQ/rlT18JBG98jkOO+3DXjbsN1ad0lnBu96/C6iZVwoN261pZksTPGW2pK+b/sxpTtXcn6iF
	crWCZSf6P9Q==
X-Google-Smtp-Source: AGHT+IHW0Cp5GyrrR3flEmMg7aEQH7+Qv/G5/JFMzVnN2vAu3XjJnL31sjK7xy4r/8WNN9p0O57Jheo5vojq
X-Received: from dycnl9.prod.google.com ([2002:a05:7300:d109:b0:2a2:2846:c4f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:570b:b0:2a4:3592:cf64
 with SMTP id 5a478bee46e88-2a9415819f9mr20281218eec.8.1764697946550; Tue, 02
 Dec 2025 09:52:26 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:12 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-18-irogers@google.com>
Subject: [PATCH v9 17/48] perf jevents: Add upc metric for uops per cycle for AMD
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metric adjusts for whether or not SMT is on.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/amd_metrics.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index f51a044b8005..42e46b33334d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -3,14 +3,26 @@
 import argparse
 import math
 import os
+from typing import Optional
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
 interval_sec = Event("duration_time")
+ins = Event("instructions")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+
+def AmdUpc() -> Metric:
+    ops = Event("ex_ret_ops", "ex_ret_cops")
+    upc = d_ratio(ops, smt_cycles)
+    return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
+                  upc, "uops/cycle")
 
 
 def Idle() -> Metric:
@@ -45,6 +57,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
     global _args
+    global _zen_model
 
     def dir_path(path: str) -> str:
         """Validate path is a directory for argparse."""
@@ -67,7 +80,10 @@ def main() -> None:
     directory = f"{_args.events_path}/x86/{_args.model}/"
     LoadEvents(directory)
 
+    _zen_model = int(_args.model[6:])
+
     all_metrics = MetricGroup("", [
+        AmdUpc(),
         Idle(),
         Rapl(),
     ])
-- 
2.52.0.158.g65b55ccf14-goog


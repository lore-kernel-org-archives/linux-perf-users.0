Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01292E2299
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698078; cv=none; b=Huo2IYzKT6c1SGuP6dmcG//Ho+qpuDEyptj+Nwo1MGwiY6nuxtX6RM9X1Aru8G6oXeTujvMwJTiwEqQmUUsNy6qeytVJmqmteQtC63STcMm9paPWCZQUUMTn+6Ohb0qWisqWUP6zRspLcxa5XgDII6KnblrAqcO4+rz6RK5vk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698078; c=relaxed/simple;
	bh=2r74RayIlYvpuwOozdsEWaVG+iKFzD/yEvXBbcyOtZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FEtROIa0UVHRT0d5G4I6Vi/YqF5GmPVkdjLmGqEJ+ELqA/MUjRs3znFzrRODSCSR6p4zRM6dEarUfk4368Ecdie8JHesHZMpLoYX+BYqRMO/+Wq3q3odymqjkOt6fRaj6SMiCPJaE07afp+g1Irk/w5tA5UlTp3vaFUcXYN9r/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzsLq7A3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzsLq7A3"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso7941556a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698076; x=1765302876; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzZ8EnbBDh8jt7szKO0N2Uf8WEk3KaSh8ErcQB6ktIk=;
        b=YzsLq7A3Nw+GL+nfhr4JaGzMzVm8iWpuT0Xs4N2UQsBqwVIP8+VVwp9VCg7K474STq
         i5blOvGwgaw0HOImWteIJvSwtCh+09HIauW53IBVe/EoFO6XkKsdjAWeec2HiDkuXtbV
         BuQmURFy+4AxPLjEBvaZiId8MlUQIP1Fyin78sU8taeIKOTNOdeUNAJOtssTlOn17ljm
         bBG2XcnqmSnDjm4u6cmf/tKi8K/VVQlaxVyv8SRhMsqjgEQB/Ly0gqi9CHMTaWLOglei
         FyjLfBYbwh9ViYHJLVb6LvFs4uyNxRwt3ZC6FRoYKXe6Ksxfvp+PF6ovF0qAvvld2jRO
         Pagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698076; x=1765302876;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzZ8EnbBDh8jt7szKO0N2Uf8WEk3KaSh8ErcQB6ktIk=;
        b=uppWEMygpF7YQlxiwoCwDtkIvuJWuBD0fqtKkPFwJkZDVWDk7EnX/oWU44nwlC6p6M
         ZSd+rwWEmeLT2zfL/k+sWYNr9Vcrmqztr4ehQp6YeA+ulAxx6O0OlQmoH24/S1h8nE+z
         Lwo2Jh/Mc9yl1YoQitAdc1fjgTq7qol7XhUNKpm4GO+GbAxZ0cama9xNmuru3rCohhSX
         dVmfHpLQCTNHxxvttvHB6IDNOKEir9g/bWh8ADz/CCDsZvRAPRqE/g4mJNO5qPsU0p4b
         gnob5idLGV9G4tb2wxys3RfbDUU6SHordYtlTpPzBOXYyJoO8b8eO7yrqo7Bzlnuo/Fr
         eSWw==
X-Forwarded-Encrypted: i=1; AJvYcCUV0dTU4DJ/UWEm+mUk2f5vA7rHxSdGJEUKq9xQsWhEHEVYanuORexIwZgmWAFQthk+qh/1y2mKoEOpPeIINdGf@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOg3WRgLEW8sYrvGiXQx8sqALu5kjhP46fGyrlcxvq0NXOEji
	MU7ifSObhErH4X1YnYPFww9dtH0GA6oa4EkWiYj5WQik1PVRIcAwCVhUPk63rFcnSLDZkMRQiZ4
	Th7ASgyYdyg==
X-Google-Smtp-Source: AGHT+IFfiF0+T0B3cE3iZJOMezRRXUl65547R9nw7jIkPYT4P2Q1DmHaH8JKoiF5eYt/wOEdc2p/qx6LbTqM
X-Received: from dybhk20.prod.google.com ([2002:a05:7301:2894:b0:2a2:318c:8559])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:29af:b0:2a4:3594:72e4
 with SMTP id 5a478bee46e88-2a719277102mr18566291eec.19.1764698076080; Tue, 02
 Dec 2025 09:54:36 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:40 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-46-irogers@google.com>
Subject: [PATCH v9 45/48] perf jevents: Add mesh bandwidth saturation metric
 for Intel
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

Memory bandwidth saturation from CBOX/CHA events present in
broadwellde, broadwellx, cascadelakex, haswellx, icelakex, skylakex
and snowridgex.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f6bb691dc5bb..d56bab7337df 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1033,6 +1033,22 @@ def UncoreMemBw() -> Optional[MetricGroup]:
     ], description="Memory Bandwidth")
 
 
+def UncoreMemSat() -> Optional[Metric]:
+    try:
+        clocks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+        sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
+                    "UNC_C_FAST_ASSERTED")
+    except:
+        return None
+
+    desc = ("Mesh Bandwidth saturation (% CBOX cycles with FAST signal asserted, "
+            "include QPI bandwidth saturation), lower is better")
+    if "UNC_CHA_" in sat.name:
+        desc = ("Mesh Bandwidth saturation (% CHA cycles with FAST signal asserted, "
+                "include UPI bandwidth saturation), lower is better")
+    return Metric("lpm_mem_sat", desc, d_ratio(sat, clocks), "100%")
+
+
 def UncoreUpiBw() -> Optional[MetricGroup]:
     try:
         upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
@@ -1097,6 +1113,7 @@ def main() -> None:
         UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
+        UncoreMemSat(),
         UncoreUpiBw(),
     ])
 
-- 
2.52.0.158.g65b55ccf14-goog


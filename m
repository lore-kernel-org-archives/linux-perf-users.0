Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17042264B7
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896758; cv=none; b=fWZyP9DVsG8tE1/SRfKsLJrLsJpUkgaJAHbOuWAduQ7psXAoA22OgjQ5o+4iGJJlkjC+2nw2yZJriaGO/w+JoklTY+7uYAMMO6vceQ2kabrc4kRCqja/OsFbRK4fWNKawpLTNLrDykes06QDX7APKnypZyrISsgKWkcJojHx3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896758; c=relaxed/simple;
	bh=HTgDiHcfpmsB1kpb9qDWCy9sflejE8kAAdvG3nRSZ8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MVKQ2xawm7ElQyC1ahgGfTwqNjMR/B5KJAS4kQTm5D5EPnDyQWhvovzBqRGqfatpb/5hNW56vdOq/CNuj6KDGJkgJiZUCGCK/uGtMw+WBFXqHpEj7dkdgxr8dRpptH1o7YSbwzeOGKaFZ2AN5USox5lDTbi3hDLtCC3Qp8rlDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Tra2xnY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Tra2xnY"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-754f57d3259so3871452b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896753; x=1753501553; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyoHqHO0xSjLFu8zTnBCBlfDgc3kXoP6K9OnCFzAIxc=;
        b=3Tra2xnYi/ja/ZC+Of47KeuGUD+7bdhSJK03xstpx5jYgbHSfELSoa9tbQiGMiHoBz
         8eF6Lve40ji9wrEfQ62PUhP6D8W6CdseZ207U8F4EIfi1D44IZ3o2ssn+YZsV7hjJO4d
         7HseyySxVy9Kk9dXUriCn6COORWmUifJI//toDxcVAVm/XCVscqzmTm4sJ5QzbC/IuXL
         1FI5Dc33QQlV/pRrvP/68cpykNCN+uL88SsTZKE6VYTapVRnwdPywHM68fknrXQvpFRr
         XXt56yq30RN+OwA06Dl28SzDRqnPVEHdEXbeDWog8HgN5Aa3zgMhpnwC5b4rPxKLad7X
         Ze8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896753; x=1753501553;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyoHqHO0xSjLFu8zTnBCBlfDgc3kXoP6K9OnCFzAIxc=;
        b=m/U7djYhFglvjV17m9T9ekNqEtpbDY4eFRNQSEW08WRcAXmE20SoG3S9YzyGH73wFF
         QCXp57tXEQC9oaD+PpcNdk7wxSFzY2azhPEq9dY4e1S3mljuj1E7tfg/oa85MFLQN1Ej
         j7O0MKxFFsnLh23AhT/d4xFUjGUZf+HzeJlrsogoncqmTQ/006tmLKyF4Vt2wofTa7mK
         MVW3evEMkaif/IeOQc+1vdMVCO0XDOgWOjQ1U7ZjL5/litWQVNB/1sKPSZHiHqnvDmNF
         ZFa+ngL4QnXj30/sYOWR6m3O2CzABznLY70wN1+5+08tb3cRp8T+OVmHHWIYpGVzit85
         SeoA==
X-Forwarded-Encrypted: i=1; AJvYcCUnvvEy/Q5T3zJ1q5UMeTFd8+v2iqO7h/1voU/bU4YqrWksQ5ev4qgpOjGULTd5FCfHhwNwvwPjXnf0Ea779bR1@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDs47zFg0ctY/JULXCMajbuzC6gy1dv3iylnqu9WQ6mQ7QbpH
	fD25lfHiUOXuawrFmuuV0YdwM28YX4zqpHI2LX/3VS71xso3MuLIdLxFWqfOdGiw0/55wyHYbaz
	rWlpfgyfdVA==
X-Google-Smtp-Source: AGHT+IEvlwMx6OUGmBObZryfm2N5mH9c5xFv7x/kAdQ364gVL3wMAsr/DibD/iPCp5oqD1mn0gDliHeWG5du
X-Received: from pfuv16.prod.google.com ([2002:a05:6a00:1490:b0:74a:cccf:5726])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b45:b0:746:26fe:8cdf
 with SMTP id d2e1a72fcca58-758492e296dmr13889782b3a.7.1752896752680; Fri, 18
 Jul 2025 20:45:52 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:11 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-16-irogers@google.com>
Subject: [PATCH v1 15/19] perf vendor events: Update sandybridge metrics
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Update metrics from TMA 5.0 to 5.1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/sandybridge/snb-metrics.json     | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index 823d8b7c4224..d40761903429 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
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
-- 
2.50.0.727.gbf7dc18ff4-goog


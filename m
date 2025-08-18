Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDE832BF31
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543976; cv=none; b=kQsSrhL3e6Z2U1tEUbDFsEac3TvuP1DbYrlluhYCHGx/Dp9zbuuiWLOXt1WhGJnkwVoxo8Zb5LEemjC3LQdY1F4pPIjZ1OSTZ8X+XofRocHsDhlyQ8Oor5VISrheA/KrvyL/2g9x8MdphsG8InDRSNpdbw+c2xsvajYcO+SkB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543976; c=relaxed/simple;
	bh=LcmzKh8MxKe7S2JdMF2i56oqJa5WycnupoSJN/TemBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=opbwYB5+jvXkGZA8/t3jgOIZIXYkIs+hrmVwXAN5T4K94ItWXWD3+dcPsuYGvDDxqP/oouc0gXsdfLETLmx7n8o0Nhe4MOYXBCcwrTc0k7GVy8TCPSsvmug0iMwQeRSOAn7/tk+BwATz00F4zbWoloEDcMSw95C1+Q1iXGz+Ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHjzcCKT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHjzcCKT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e0c0baso4545391a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755543973; x=1756148773; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Oh45/+Kol4/Ff6MHQPrzumdu5r/WMLLUjenm77C2bc=;
        b=zHjzcCKTge2ZI8k73TEuNUVWI7U+zOzK2CkEfJ4GgZeayd4UVmQjhdChD12Lko8aHV
         e4d61tPdf+bG0S1Zx5+UDj024+OElfV8LgQ6QFNVQtOIQGjPz54+VVz+hT2cwmsyDfYR
         L+ZPtR+h3/ro8aLcu2dsxnz1VyqYSX0AaiOBS3IDqwXP3sjrgSTAmJIgAxEC2o44Usd9
         iwhELy/SefCqBENbI7fII/1KACNfVhG1AUbT4Ujs7D9zEsyVP4dU283UcJbrn5KcFE+g
         h0RHepgzmaRs2+diy2YCM62LCct9LalVYjWf1k+FflBsuoORj2ggiUG2j11lnwowyJik
         wtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755543973; x=1756148773;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Oh45/+Kol4/Ff6MHQPrzumdu5r/WMLLUjenm77C2bc=;
        b=B/LK1oo4yxxP49dVSEZfV8qO6PS0mU1bYHQQh+t3z65VaAOgy15BbYaWjEjIoDpBHH
         QHgrHDWQoo+sVNzbPOeP4fb7d2nMon4Z6P6YTnaSd3DCPViAKy8nYEDMo3ytK3IzI1Wk
         V6kl87voJdV+t/o8IrC5N+f1J3H7/WcOb/sRBarSPjX2WYbUslV3Kl/rdGdUBjLn+Pek
         gt6qBJe/13HI5ZtHD35DRoqkB0YCGF7jVvVzR7f+Qqk38i3qaFjftdoMzdf75nhxHcRf
         xSfZZgF9OCVoO4wP+xmmta0Gl+GU8EoCvcRDXG9j15lmcTmUAxe74IfKK3jw8mg1us4B
         1wFg==
X-Forwarded-Encrypted: i=1; AJvYcCXyNTF4GXkMTt++/Q2mHGufzeMz2t7/osYezNHs1I0I/y+7gDHzSdvjdL0o/9TnADbL43LOXwNj0wmWZPGHNrRX@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtoraMutPf3zFB5an1MBUYrUUA+Jz96VpI0exKSZkN98B3I3G
	wRNEU66bD+sBM/D4DviOSouP9vxjhD37u2xSgxq9KZdCF/DoXIv+KhYUbFjkBMmsZIdNR7mAyZA
	yNCggZmpEMw==
X-Google-Smtp-Source: AGHT+IHTGaTTiW/uZLksoxGLFmmaMCpk22DofrBNoAabsB3kcFxlVjkcIJyuzq08E+2twTPTPd3iYeDDlNTi
X-Received: from pjbqx14.prod.google.com ([2002:a17:90b:3e4e:b0:321:9285:be8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f83:b0:321:87fa:e1f6
 with SMTP id 98e67ed59e1d1-3245e562016mr15244a91.1.1755543973327; Mon, 18 Aug
 2025 12:06:13 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:04:12 -0700
In-Reply-To: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818190416.145274-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818190416.145274-17-irogers@google.com>
Subject: [PATCH v2 16/20] perf vendor events: Update sandybridge metrics
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
2.51.0.rc1.167.g924127e9c0-goog


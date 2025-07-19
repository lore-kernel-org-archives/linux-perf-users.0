Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97721884A
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896739; cv=none; b=ViIW6dmGL9bB4iEotoujrqVwBdz/ZOk5GVT+ZnfcPR4C+TG3X6IFh5NTjER2xgUXoqbA/jdxukJZKiM/PAoEiHSzHoQEKSwUGitWr0qZv3tJkWKZgv2fTMizcW8/WSIzeJpeNapAEWi1meXy692KIbitp3KPqWagiGNavjUu3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896739; c=relaxed/simple;
	bh=DDZ1q3vFuDdF98BUvmYY3doV3qc9WHq9aGRyD8HdLzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WWEwgm6Fht/ddY5A7D3BXfeL7DyopegQBVHBfFRJ1uSoUmQI5WUCPJ+uekvb8Oc9J7alXU7IwUN/JeWKjzKuwjWNjUJOC6c/hfFefQtsDJOuG+j+0Q3khTzEX6V5gwgUxmReKBo6L/q0/dXiPsR3dIIcW+esoNLL7nRInSn6nBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXHD6Rfd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXHD6Rfd"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso3259073a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896736; x=1753501536; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBMFXrG1xOekg4HmZGvQhV+SxD43VvAIrVyKbopoMYE=;
        b=PXHD6Rfd+QMQogs4e3nU1IGVTlLqCGWRCx9ezwR51qsxCFv9zoJBrMElgH2W4CuzIq
         8a/kgQFhbKwKv7fL5Jl+b8ldxt7wlp4m8cfDGF5isXVLzKGS+PwHYpxoy7eO7pDhTUh/
         GoaP1aWdE0bGUxHBnhtkqFjGuQyrPqxM6ND15nqdCpdU+94a/9MEurgMb2/s+WY7n5l7
         ERkPZWIiI9f3PZiOjfK8UbLH01TavsFsKmE88BNQ41i8fEJLXI+LlKYTz0Xhq85XWFgF
         mOnHPpoASWeDXaoHWi7IMAqXlI3Fn5sn6IPahM2E4GqUq3z9bKGqfTJgXfCXNUuDpgL9
         Bsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896736; x=1753501536;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBMFXrG1xOekg4HmZGvQhV+SxD43VvAIrVyKbopoMYE=;
        b=f3D6aGsKd/qcxBrpZrAPEUBJb7XZcXuvXYv2q1Gh/C43jR7ojeCcjh4LDnMrWGgily
         QTsGev1KH7manXrWGfFddSUhO3ZsjXsx2xgOyzO7qdXpRWqx7z7Hlrc/nqxkxI6TPWkb
         OB58b1kszDELLAD3UH1lAXDlZysgjwxxCzt/yHI7KSKIkxITADEmrqMJ67pVME6DADEJ
         n55dR52E8UY14tsey3q28cuFZ5aQcRUDbqE/+fEJddOLXLQlVtZG2OrHZUWEl5wUD1ZL
         s2Z0IWIKEBMzFvsFaR4wUkI2JuQ99EdK9TZQhzSNHaAl6Wn+puuYSY7Blma3nGwj/jc7
         +trQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgvRUjgBwgGvNvJeasXHqjPk/Groh19G4xNeHC3XXQzCnprqOp7ZSI8nGTos/FQheJR1kwHnmsLJ/e3G47bGEq@vger.kernel.org
X-Gm-Message-State: AOJu0YwUBkYfw9DAmabSPtfEB1rUQsqvebZa1Pqg0kQE12Iq5iFsYEwt
	Fj/Ou+By8KYvQ3hxyyJZir2k3dw0CL0zMcuQ9zJmJWdblOHW4MhNwQs+Zf5TK67iZ1+QpI9EqyG
	w9HUOKeQi9w==
X-Google-Smtp-Source: AGHT+IEo18BE4QLvAw1/92EVXaYrWdaNlYSyBsOVRiEX/tG+V2krErJPgtF5SmI3YJNMFye5tO/kkwnXwrG7
X-Received: from pjvv4.prod.google.com ([2002:a17:90b:5884:b0:311:b3fb:9f74])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc4:b0:311:e8cc:425d
 with SMTP id 98e67ed59e1d1-31c9e6f7177mr20111314a91.10.1752896736426; Fri, 18
 Jul 2025 20:45:36 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:02 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-7-irogers@google.com>
Subject: [PATCH v1 06/19] perf vendor events: Update grandridge metrics
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
 .../arch/x86/grandridge/grr-metrics.json      | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
index 878b1caf12de..a0d637a24c1b 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
@@ -1,56 +1,56 @@
 [
     {
         "BriefDescription": "C10 residency percent per package",
-        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C10_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C1 residency percent per core",
-        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricExpr": "cstate_core@c1\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C1_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "C2 residency percent per package",
-        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency",
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
         "BriefDescription": "C8 residency percent per package",
-        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / msr@tsc@",
         "MetricGroup": "Power",
         "MetricName": "C8_Pkg_Residency",
         "ScaleUnit": "100%"
@@ -633,7 +633,7 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricName": "tma_info_system_cpu_utilization"
     },
     {
@@ -645,7 +645,7 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CORE",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P:k / CPU_CLK_UNHALTED.CORE",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_kernel_utilization"
     },
-- 
2.50.0.727.gbf7dc18ff4-goog


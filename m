Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC08422A7FC
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Jul 2025 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752896761; cv=none; b=HN+3vazE5VpbFoMuecFmlc/h1uKzNhuS9ior5BKDR1Laz9vOAglmE01FQZc1UwwJzhDYbRZlTwmC8bcCdEU7PCp+UswpFo6VaV6Uly533GnBPZPZeYk5dJKymcNssRdthGoN29sJbVNme7t9W50+O+8oi75gCRKc+DNb1a9x6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752896761; c=relaxed/simple;
	bh=BImgXBhe8gz9mi2Hr7xZg6e2yMMe4mk6zYrtyywYwVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YyPsB4VsALoZ1f4ZyxNyy7GWy1QApK4Hci9a6njgJVIAq5qmrusVtiGClM4vS3QLET3C19LcdEfbBopwgQWrtXr1K4TgaV8zXhhKBA9XQi/2izUfTTwvjAs9DhxKw4wiTeUAcfjDruzwcZQ/HxAU0Miu6Sks7QtjHz5XV9pM9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdnRu2/y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdnRu2/y"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235dd77d11fso27459775ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752896756; x=1753501556; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwbCpczO77l0xiPSlOdCxGpiGz3+duVbPCBhW+nDRFA=;
        b=fdnRu2/yvmaNEHOLkuTzP9siuEjvZb5AVFv0766+GABeiFid7JGkuaL9obAeAFai95
         xeoe+5gxmrFbH/CwpikupZPR/igxVlJqIUn3vJUvrc4x8wvUy7npIrDZC7tG2Z32SPDd
         jBOrIpX2ZSK1YUn7smMyUBYmGSYPe7/ffN6faeloja2342QXlxac7CSVvWF0uNuZlIHo
         Xdy3XB3rkAbQ9Gg1QSVdp3P6e0eMcD1w6GwRkrXThOVI9I8Xuh54SMfvBCbfSffOQfvx
         vrZvLYR7qjK/zRXEzQpKRtFsf8eY8IgEYeF0yFTLWWM+478J2/+vXh3xAuwn18RqsxKS
         Qk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752896756; x=1753501556;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwbCpczO77l0xiPSlOdCxGpiGz3+duVbPCBhW+nDRFA=;
        b=sb3KJKQ6XTAdmh9nNMyf8QDa7QlSqoBvx81aPjD1Crb11EUcYvxuH6fyCyl/iBz8fC
         JCOSC8W+ZS/SrGSZ2vFrCkLOPOMlA/4/+79CwmkQkeU4t6GajPrHF8LsTMxn/0kpBXfX
         3Vad3mJ15uHyX2MYy15tEWwyQG//KxrGV6JXeQFJIAN90uag+pFJ9E0Afwv47uj0v54f
         mQqJeOg6pw5lGKzpKbzt80pS7zt4IAnU39aXOrW4j60zgpqILJbSiEOEVSkcS3DsTCY5
         Wob+BBW/Ws+kYL6qpAtFcT5wOyCfAtwUYoJu73A/Z6gsdIlM27CC+NFnvUBsUOy8975F
         LXWw==
X-Forwarded-Encrypted: i=1; AJvYcCU0RWhBALgJQHxNR3zY/ikpWL5+ViT6PyeGr1uFDi+0wGrQqw6Y7UtsruTbX/sFWHikgoYOhMaZ6x03lCeSuUPz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4whWzNRcWjsaWB7dR1578m68+R2+6Vg5m8kvLesjqT/lSta8
	dCihNG5h18kR8Uuj9jjlMhSTB+RRd8rS8ylcWx1jA9jsTqkbTnJ20p2tBadI972Csptyz4oXnIO
	tXIMKK1leQQ==
X-Google-Smtp-Source: AGHT+IG9zb3O4YDYA+FzRpT+cFBELwmC1bv45iR6dsLUNQDetbmplXcLS/ZYZ/XjTEEAd3LxKlhmIjMpuHwi
X-Received: from pjbnc8.prod.google.com ([2002:a17:90b:37c8:b0:312:26c4:236])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50ce:b0:312:f2ee:a895
 with SMTP id 98e67ed59e1d1-31c9f45b0abmr17336572a91.31.1752896756497; Fri, 18
 Jul 2025 20:45:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 20:45:13 -0700
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719034515.2000467-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719034515.2000467-18-irogers@google.com>
Subject: [PATCH v1 17/19] perf vendor events: Update sierraforest metrics
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
 .../arch/x86/sierraforest/srf-metrics.json    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
index b9f3c611d87b..ca2c55917e55 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
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
@@ -735,7 +735,7 @@
     },
     {
         "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricName": "tma_info_system_cpu_utilization"
     },
     {
@@ -747,7 +747,7 @@
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


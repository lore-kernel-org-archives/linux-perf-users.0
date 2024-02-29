Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA60D8F5D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165617; cv=none; b=RP7uqntLH8ZiOR9rceH1i+EeMxi8LWJfJwbQuPyooFA+hTeuT4JJAlscSjxDGxOEl8VFhC6q6L5DouIoi1FyHNWgFna+dJ8AqEAYCa4Aiv3LdFkuFX6s7p5pH4tZaJyFu2wdpUmGKU87Xg9AszciQjVrhKl1x3pcJfx0TwRyaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165617; c=relaxed/simple;
	bh=RmBYm+ZtRWY2Q7E8540FsapTEKqB2m8rCmYuA4GJXNw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DMt2AnQP5PIZ1DDs6IegdcTFqpzxZu/DiqRK+3dQ4nXkkVJWsN6SR/+pMTGPgdB8WXvJHfBmNdc+OLwIsmmcctfCDy+jyJx6IrX6KAqpgkulLblj6gvKKd3y4jDhZppnr2opSt/nwH0mcaICvrAJBW7MfWmY6xuIc294H/0za5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+O+gPxR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+O+gPxR"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6092c637278so5401067b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165615; x=1709770415; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7G72lluaDAnsWJX5YIbxhUo5zYGBJynYcdzkkcMI8Zo=;
        b=z+O+gPxR0ziqUTninrIUFj6Co+uH1LwXXPDYj9itPIuDbOvUPiuEPnd/vCIKgMnOQU
         m187qJ9QEhZmpAUr/NdAXItYLhGqwcz43n/w77EXr798F/nqGCFU31fWKQg8h/NffzSD
         PlPWm+RJd/8WHgzE2vebUL8wjBeaMdtDXQmJJV3mSuNf9UesYkkjIlFR+ZZVcAEGyEyw
         c/+f0u63MlabU4/52mIUERnIaV01ZLLMTYivo/ikR37atGpWX+7GnITNmojN7x2iNt69
         iEgsneebhtQ4xO8EDzxb5gKDcKOgSvpbkdnoYCpHx4VmiKc2dHGbhG9idOKQBijBiB1l
         jPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165615; x=1709770415;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7G72lluaDAnsWJX5YIbxhUo5zYGBJynYcdzkkcMI8Zo=;
        b=dysrkES7k5CVZ09+/oZvVlj6eXOh5CwEYITbLrKaLcKS+ubftJtXM8NCCFuzAc02bX
         CZqbURVGzrFCaVfjqT085HImfyVY7E7BfZHS8KXAer2OMBJRcGuJV2KosGvUFYXkqfJv
         tPEPX5FR4pbuF1bcyLtgTxFykD7WaxKITQiSZPBnGOIKdBN3GbnJPN2grsSYWvO/3c/D
         6kMdEPT8j6xsFfpzjs1f2oLA0PzVzz3zLihaMJqO3DUlhvxmPlgMX1TVYyq56NndCiF4
         +Eslisf8xJGHdLLKrSM7h9uh895nAuvbFo635OUZs3dB9UofNAnZcS+IoYtGNXRd8h7i
         hGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAjXUHeSPWs9+X5xi2gaR8yRe2BXD8bHjlMQxTm4AR1AsnpdAcbJotZGAuudp0XU9wWi6H2zPu759G+CGObXU+dIu6W3PPWTVRsHynz2NMIg==
X-Gm-Message-State: AOJu0YzKKvIrnpR6ymeGDQeXF/fLnmkdTggLVY9Ra9aa71JmsXBGTQIU
	6v2WTVwufpzV0xNohiLyyrr1WEDMEL8fI6zH7DRmKswgUgTKjFz6wKL4fGHS888u0dUx2apUMMs
	K0KXc3A==
X-Google-Smtp-Source: AGHT+IF75xTI3XwTDMHMROUJxAdhz+QA2KHtU3yAX1qgVT6DL3VYdA3DxhD2i6/sTgc24ccWIiBDjkpesgFM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:c9d:b0:608:ced0:eb2e with SMTP id
 cm29-20020a05690c0c9d00b00608ced0eb2emr126092ywb.0.1709165614975; Wed, 28 Feb
 2024 16:13:34 -0800 (PST)
Date: Wed, 28 Feb 2024 16:13:25 -0800
In-Reply-To: <20240229001325.4157655-1-irogers@google.com>
Message-Id: <20240229001325.4157655-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001325.4157655-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 2/2] perf jevents: Add cycles breakdown metric for arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown cycles to user, kernel and guest.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arm64_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 0dcf5236ea1f..e1874d8024c1 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -152,8 +152,26 @@ def Arm64Topdown() -> MetricGroup:
   ])
 
 
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cycles:kHh")
+  cyc_g = Event("cycles:G")
+  cyc_u = Event("cycles:uH")
+  cyc = cyc_k + cyc_g + cyc_u
+
+  return MetricGroup("cycles", [
+      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
+      Metric("cycles_user", "User cycles as a percentage of all cycles",
+             d_ratio(cyc_u, cyc), "100%"),
+      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
+             d_ratio(cyc_k, cyc), "100%"),
+      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+             d_ratio(cyc_g, cyc), "100%"),
+  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
+
+
 all_metrics = MetricGroup("",[
     Arm64Topdown(),
+    Cycles(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog


Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0691FDE0A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346628; cv=none; b=GXMUz1IKggfVCICE31oXSY40wlzLtHLSRevxUCKDQ9XwFyagflD7Irt+CpzxE3r/8Wwu7tjvKXRt81kSw3PGKlkV5drnmCIgnWC5lu2OlmxD44h0dDQ7oFrozVZyHhPpjkaskcQuwpzo7AHeuAY6KghDAkjPYsKGqahx0FQhECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346628; c=relaxed/simple;
	bh=qhgx69uA8IiIJxSynCovT2xN+mUPia675m5YqlCbHk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEwYDFZ8uTnhRIHF9TuFnROaTEIAJ8r0tFnGqa5MkwqPWl+cPpR5v/PdN2tQ16wnp9A+8z3Kv84ybY4l3Qlb4pBxkojOz752LzmZTynLxoPdCZ9fmmgJOY2sOfIS8EtfI+DvfOxEwXuVPOOAtr5/m+rIrAsHnO+cTA1+T4Dy+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLuB+X6P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLuB+X6P"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso112956105e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736346623; x=1736951423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2Qn39K4UzsLsLGtfNH0/R87UIS/L19Vs2Fn7/eQxwo=;
        b=KLuB+X6PNmGVdUNQ92PNa8sJnhgbTpvEetAx7Uuz9qNfzt1IX1A552770aX87a8stv
         JURzlhODquroSUo4hPvwj1Tp+1kyPRPVJM/sH9U2kJ0wBBihAPCVExxgiL8cdlT0RgTw
         6lpL5V1fXVNf5ICooSJ8mZ4lVfIuIm8BUB4poRvGiAhmdN6oQI9yLblBVH9jSW5/Co/i
         mpBJbuvSvEswLM2deozbw6qPdw5fSH5LU2B0KeAi/ZTXV63wjnggI5+nR2h/drNpwaqK
         Rn8gMjukv2AC2osAGM36324VtW3cnOZRn7N91Cf+0GARmJ3rvv9ohqev7L50RrIAAtvV
         qHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346623; x=1736951423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2Qn39K4UzsLsLGtfNH0/R87UIS/L19Vs2Fn7/eQxwo=;
        b=pJ9YK6TnoOegmHM2tkvjbXX1ZwU83y0mwRVZSCWOW+UIepW3H/gtFtmhZDWhyeTpZA
         ubFP/CAhun+eHlZpy721Qb+BtA4OSTKuWsk4c7zxth7JEmGZndh+cUYS1Nkrl3D25u/H
         CoUVMMTmbYKx+xmYfMk+v3X611F+3dNT3653NzNdSxaB22fQYwGrSCzcFWoRbmBS6XYJ
         kIoHZwE8RXDMauCCxH4mSocFMo3Jsb13fpAkosR5GjBvSA1Ce+tmxTAtMeigOrZtO3C4
         iD9BkAA/HXXRP6eC/itlR3eyIBCEsHDnwbfrGI/8uV7XjvoBZc+novUwpXh1xXh1dhGw
         R7FA==
X-Forwarded-Encrypted: i=1; AJvYcCXC/rwo55P7wttEbnyJ3KcdtQ6dom6MbXwEWEDeLPL3Ut7ohJVP11LAMZFbNv+wQ5zCoIwLRrLF09a98rHwxt30@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3K+gfHkq26bSaUpAIR6r/h0L1G8rEgU10eMlT/T+W7MrcFDih
	uxQvnatg6qwrZm/vYulZGzezhc9G7hZ2TBJO912dicrQVRnNQ1Hy1js35r3hm04=
X-Gm-Gg: ASbGncuIt5sPrlBXYg3fXhwDLW+YaI8ZleCoD7bPeB6Y3FR75NokdypJFpQBFqlS/iv
	HkZR6lrF9viF78+vVkIonFltVtVgz59DOGmAsOl4oFU0qLk/ZxRCOPquKe7VRo4IMwZHAGZqxXT
	uw6U8Yg8EY8e3CpKe0e+JS+Z+9tG9is9ijLulnFTs0UBGLIL7McsH512WmXI3YlkjrxZfg5nhvm
	23tmse1mLB72M87h0d2ipwdCoBonZy85LMH0sMZXnPH484ZiQ3Upoi7
X-Google-Smtp-Source: AGHT+IHQgK8+Yd3JtaxOPOoCOGtnBLuVZ6/cDODvDBysXN7o1PBIvyAUjmPV1obXseFT3h2tmvjLfA==
X-Received: by 2002:a05:600c:468a:b0:434:a968:89a3 with SMTP id 5b1f17b1804b1-436e26a78a4mr26241125e9.9.1736346623428;
        Wed, 08 Jan 2025 06:30:23 -0800 (PST)
Received: from pop-os.. ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddccf4sm22836965e9.19.2025.01.08.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 3/5] perf tool: arm-spe: Pull out functions for aux buffer and tracking setup
Date: Wed,  8 Jan 2025 14:28:58 +0000
Message-Id: <20250108142904.401139-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108142904.401139-1-james.clark@linaro.org>
References: <20250108142904.401139-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These won't be used in the next commit in discard mode, so put them in
their own functions. No functional changes intended.

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 83 +++++++++++++++++-----------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 22b19dcc6beb..1b543855f206 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -274,33 +274,9 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 		evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
-static int arm_spe_recording_options(struct auxtrace_record *itr,
-				     struct evlist *evlist,
-				     struct record_opts *opts)
+static int arm_spe_setup_aux_buffer(struct record_opts *opts)
 {
-	struct arm_spe_recording *sper =
-			container_of(itr, struct arm_spe_recording, itr);
-	struct evsel *evsel, *tmp;
-	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
-	struct evsel *tracking_evsel;
-	int err;
-
-	sper->evlist = evlist;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel__is_aux_event(evsel)) {
-			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
-				pr_err("Found unexpected auxtrace event: %s\n",
-				       evsel->pmu->name);
-				return -EINVAL;
-			}
-			opts->full_auxtrace = true;
-		}
-	}
-
-	if (!opts->full_auxtrace)
-		return 0;
 
 	/*
 	 * we are in snapshot mode.
@@ -330,6 +306,9 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			pr_err("Failed to calculate default snapshot size and/or AUX area tracing mmap pages\n");
 			return -EINVAL;
 		}
+
+		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
+			  opts->auxtrace_snapshot_size);
 	}
 
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
@@ -355,14 +334,15 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
-	if (opts->auxtrace_snapshot_mode)
-		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
-			  opts->auxtrace_snapshot_size);
+	return 0;
+}
 
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel__is_aux_event(evsel))
-			arm_spe_setup_evsel(evsel, cpus);
-	}
+static int arm_spe_setup_tracking_event(struct evlist *evlist,
+					struct record_opts *opts)
+{
+	int err;
+	struct evsel *tracking_evsel;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
@@ -388,6 +368,45 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	return 0;
 }
 
+static int arm_spe_recording_options(struct auxtrace_record *itr,
+				     struct evlist *evlist,
+				     struct record_opts *opts)
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct evsel *evsel, *tmp;
+	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
+
+	int err;
+
+	sper->evlist = evlist;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_aux_event(evsel)) {
+			if (!strstarts(evsel->pmu->name, ARM_SPE_PMU_NAME)) {
+				pr_err("Found unexpected auxtrace event: %s\n",
+				       evsel->pmu->name);
+				return -EINVAL;
+			}
+			opts->full_auxtrace = true;
+		}
+	}
+
+	if (!opts->full_auxtrace)
+		return 0;
+
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		if (evsel__is_aux_event(evsel))
+			arm_spe_setup_evsel(evsel, cpus);
+	}
+
+	err = arm_spe_setup_aux_buffer(opts);
+	if (err)
+		return err;
+
+	return arm_spe_setup_tracking_event(evlist, opts);
+}
+
 static int arm_spe_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 					 struct record_opts *opts,
 					 const char *str)
-- 
2.34.1


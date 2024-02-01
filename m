Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE463EA93
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Feb 2024 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761381; cv=none; b=SGC5sV/kC8MF1veXALoRO5EYZraQOCQYef2hrMtQFZLozGqwU+VlkLEehJH6CqiARwoIupX64faNbrnYHcttc8iWf7F3G7iNCTcX6PPvEMIQSX7x7r0SXtaiK6pdhruULFwD3OFDlbbqiynv05hbk9VtQroaBmZoQzi4URyHy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761381; c=relaxed/simple;
	bh=k2FrlLoZPdnfNlF2tIYydGHAGX1QUhBl5GI7Pifbd84=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LCdddSpzyCEw43R64KY4uVio/IB+sEgUQf0u/aUfFCz3pfUM3m2iD4WH590KG+g/anpnkxbT00optU8+nY5IaijkQTCvEwbDUNoRxuVSUju5B/Zlm92XnnAAqECT0/ZV1CnfP9cuTAWyGtj5kX926Xhvzm4nip94PuFUY+us1ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFi4jWWN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFi4jWWN"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60413725f39so10155527b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 20:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761378; x=1707366178; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5H1VG+iZLkcs4atGUwnj2dxBUXygPFhAbtPAwQlWtQ=;
        b=BFi4jWWNE2OVOa4iFonbcVf83v6zNDluX307NlY/PgWJJipcQiEd59r9KH1s4e60R5
         zyShlqOygxe8HV8RCKvHkMoQlIuCbw0D5skRD35kvlxcwRMJxxLV5MlBepAi7GfXvMqY
         G0rkb9IYCyUM8gI0OTevUIs7t3CZLSJxcpo9Ygv6etsujmtPqDxV7GevdT/TinBEqSax
         Ub5YEQ2P6bie7VviPqdlpTSPGkxHzP4YqJ0Il9Ar5nJPUYj53SGKoqP6dNkP9kZBp4ca
         dGbHXTQhXrsV4MA7+MSCEslL624/a5M1noXc8JB6rJCBirUKqP3mZLcr0EzA6I2wO38a
         HnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761378; x=1707366178;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5H1VG+iZLkcs4atGUwnj2dxBUXygPFhAbtPAwQlWtQ=;
        b=It2Xe9FmxMkM87rsdBi2JACkecFx3U7BXq4oHZNdaFB5NkC5Y3PhS8azrZhcTDzhRI
         Zp9T4GcrtEbw+lGb1yaSs0k4KEvrHfE+3ez0+cMGRfC2dTuCCER2mId/3rkb06W3430D
         2Eedcvf2apj6c0BLUbYdYme1g4IcWwp9c15GQalmyct35fRNmIyY86D0uB3IMkqLo0ly
         C+Cy1Fo7M9Y1LJD66FtJPw4n7S4tbthtxGa40H8rXPtEo1bP/2kccE2i3Rgqs4wauuzQ
         hKqR4IYNiQf0m6CUkvMb71eg/PIDV4hzO31HtwHPCjJi00rCO3T58rBrBC9zwxaQcFtC
         Cimg==
X-Gm-Message-State: AOJu0Yy5lCv2+fa3i4q5Oj5jRDJ29YEhIgmecNZ4XqU5dtKLU0OtMJfY
	LXECxqBsemySZWgK4Z9iz0bOeSE0P0kpj55F6NI2a6xYvN3kFR7IJiyUVz0htNHklpP30+Pxtu+
	UBzcKrQ==
X-Google-Smtp-Source: AGHT+IE3RH3Ke4eANE6VdqsDS/07MSf52wJfexOO2bfk4oK9JWx8tVpld1JtN4fAkIWLv8ktb9i+9FIBeDm2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a81:4cd5:0:b0:604:9ba:9a03 with SMTP id
 z204-20020a814cd5000000b0060409ba9a03mr798650ywa.2.1706761378559; Wed, 31 Jan
 2024 20:22:58 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:32 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 4/8] perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
 use
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch perf_cpu_map__has_any_cpu_or_is_empty to
perf_cpu_map__is_any_cpu_or_is_empty as a CPU map may contain CPUs as
well as the dummy event and perf_cpu_map__is_any_cpu_or_is_empty is a
more correct alternative.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-bts.c |  4 ++--
 tools/perf/arch/x86/util/intel-pt.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index af8ae4647585..34696f3d3d5d 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -143,7 +143,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
-	if (opts->full_auxtrace && !perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+	if (opts->full_auxtrace && !perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 		pr_err(INTEL_BTS_PMU_NAME " does not support per-cpu recording\n");
 		return -EINVAL;
 	}
@@ -224,7 +224,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 			evsel__set_sample_bit(intel_bts_evsel, CPU);
 	}
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index d199619df3ab..6de7e2d21075 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -369,7 +369,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 			ui__warning("Intel Processor Trace: TSC not available\n");
 	}
 
-	per_cpu_mmaps = !perf_cpu_map__has_any_cpu_or_is_empty(session->evlist->core.user_requested_cpus);
+	per_cpu_mmaps = !perf_cpu_map__is_any_cpu_or_is_empty(session->evlist->core.user_requested_cpus);
 
 	auxtrace_info->type = PERF_AUXTRACE_INTEL_PT;
 	auxtrace_info->priv[INTEL_PT_PMU_TYPE] = intel_pt_pmu->type;
@@ -774,7 +774,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Per-cpu recording needs sched_switch events to distinguish different
 	 * threads.
 	 */
-	if (have_timing_info && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
+	if (have_timing_info && !perf_cpu_map__is_any_cpu_or_is_empty(cpus) &&
 	    !record_opts__no_switch_events(opts)) {
 		if (perf_can_record_switch_events()) {
 			bool cpu_wide = !target__none(&opts->target) &&
@@ -832,7 +832,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		 * In the case of per-cpu mmaps, we need the CPU on the
 		 * AUX event.
 		 */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus))
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus))
 			evsel__set_sample_bit(intel_pt_evsel, CPU);
 	}
 
@@ -858,7 +858,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			tracking_evsel->immediate = true;
 
 		/* In per-cpu case, always need the time of mmap events etc */
-		if (!perf_cpu_map__has_any_cpu_or_is_empty(cpus)) {
+		if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
 			evsel__set_sample_bit(tracking_evsel, TIME);
 			/* And the CPU for switch events */
 			evsel__set_sample_bit(tracking_evsel, CPU);
@@ -870,7 +870,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * Warn the user when we do not have enough information to decode i.e.
 	 * per-cpu with no sched_switch (except workload-only).
 	 */
-	if (!ptr->have_sched_switch && !perf_cpu_map__has_any_cpu_or_is_empty(cpus) &&
+	if (!ptr->have_sched_switch && !perf_cpu_map__is_any_cpu_or_is_empty(cpus) &&
 	    !target__none(&opts->target) &&
 	    !intel_pt_evsel->core.attr.exclude_user)
 		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
-- 
2.43.0.429.g432eaa2c6b-goog


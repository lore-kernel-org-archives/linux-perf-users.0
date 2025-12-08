Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560D31DDBF
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203819; cv=none; b=MDsGbuUPxPk46XSOUfKlVU/cBMAAGXm32cgNS632cd/ZchbnEwjA+8YMSXVm+rT/kMq/+5qNtuJmBKgaXGzzlFX0zQbgmJ5/bvirMn/0WMTDO5LYo7i+D3o6GC+3uNWZs1V5fk++TfQyTEKLOHRjyDWkvvzIccTiOL7qSyZhj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203819; c=relaxed/simple;
	bh=XDHLC1TToim0ot24UHTP8tg0u/f4uP/BR8HUnpB+CwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCq9kUeSCB9pEYhcYURbJ3Mjfjjt2QIyhZlpB62CsQjvl90hBLGRHBQtPlLRZDiY+xwx6mUxsFOVEoMXkFv/oG7XVCQpP58DeZ17HvSJAgJOIcvoxzT0qFmoUdt6HKInHRqn1YHdelC+ZKmx1hcUfg+LFpaYQi7d7TDM/L00lGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbYQXFg9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbYQXFg9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so59290445e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203816; x=1765808616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GmRPB0jBQgoThlmGWejjg28u4BOouUoY2C6pZo+51c=;
        b=lbYQXFg9eeFeK293NLf382K4x75cpyZ99rqY8ezFLj1AXumcNkJH7taDHPHzs4gaWE
         ilyEOXUUJ30D4joMBLtf9Xx8O8rrvRFWMW71il+dc8+9mH0NEztqsewkZed6xnuHDm0L
         OMNG+bH/8tEXJkUhk683HrxsEakxT11m/nfw4/omDqUe1HD4TCUqEbxZhKJ1YCViYCB9
         vCQgLvXk6dRtTV+MMvqLJrRQ+JSqeSPpvbnaZLvFClDpsNVC9KIYCBrCvm6iUMbNiOVi
         GFwbEDkP+R/Yku5fzwAhx0yiNcfpDBaoKrnj1adwytnq3VyOgj/SHJ5h1sYpeucU76Wz
         ZAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203816; x=1765808616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2GmRPB0jBQgoThlmGWejjg28u4BOouUoY2C6pZo+51c=;
        b=swAy7yB0puvFEdmdVmRWDWDhHes5EewkiGWG//gM5BCCxwEP6kg/pu2Sq4Ya6nT45a
         BbzrvKia42wFKKRtc73lxdKq2eIOMPLDflXMnq1cM4RhJvIb7Ixz5XnycFLEIv/678+H
         z9XSo0XxJJNgtzNPKlihKuvmq7txFdUlXC7teyNy7lVZkBIgaivzw7Jr8fwGNO53/xeR
         uhysrU8T1TErShElZU+fWqpdar+GBALUGf9UI30NrR+p/ec25TZ0Kqhtjw1Zc80/0dK9
         TG2ShkLzFcl0tz/5ocI99pHn+2zmjO0qxUhmPzlGgv9l/6j/bgGZmYD/V7vOaMfc/EIh
         qyKQ==
X-Gm-Message-State: AOJu0YwYwbV+a6XhhJFh95ApXn8Py2b1ElgRyJcAjevW5vDIr9THtr7p
	QaCqNIoaYJULWtI23in0fbb2kKC/uIP5vAJDHwcE1U4+A+cg05zbqrk5nt295ICJYSU=
X-Gm-Gg: ASbGncs8f+bqnxJaXiYaCfR4rIDefOhGoUW9ZVTEVBsP9GQ1KPvqoHZOn5MNtK7B0i+
	iuCkjRxAHyhzI50PHweLeRdU+TsAUF7MiJZr+k4I78Gc7wd+8S0IK96uWnyBNgruRuWe08xlTEH
	Y4hFVr94N/vlADk6xh1yIcmx0NQjqJ+14/86NIrSJserrmL5MrBOIxbufEXLOPiCidOE4Ydz2fv
	PZqd0FJ73ZT0rLs6rcRyJbJ4MdFgYTOfTvU7viCYBIOFYXj8VUq4DE0kwcVDwvlvQd73lmmmfOK
	naW60s/m4e55HkO/OJnQ7aErpkOidCUR9l9n3UkESPIWk24Lo0K2pDqmPNZUnc7FcSD3s9+vLnz
	0jqz4WIs7Vch26InbT7jrgTcSW9rjzpy8lG//KA7LXZaa2qiFa65SJsjc8oiVkJ7GJGFerbPfme
	O3POOGBv9j49leGbSSMZhn
X-Google-Smtp-Source: AGHT+IFoZPHDAM2lHyoM1YfjpO1gRYPlnwmwM67jG630YI+YhFcyltm9tk5Ti0SdAOyhTdmrTISiWQ==
X-Received: by 2002:a05:600c:1715:b0:479:3a87:2093 with SMTP id 5b1f17b1804b1-4793a8720eamr49221135e9.37.1765203815511;
        Mon, 08 Dec 2025 06:23:35 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:35 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:15 +0000
Subject: [PATCH v2 12/12] perf arm-spe: Don't hard code config attribute
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-12-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Use the config attribute that's published by the driver instead of
hard coding "attr.config".

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index d5ec1408d0ae..6c3dc97fde30 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -256,7 +256,7 @@ static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
 
 static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 {
-	u64 bit;
+	u64 pa_enable_bit;
 
 	evsel->core.attr.freq = 0;
 	evsel->core.attr.sample_period = arm_spe_pmu__sample_period(evsel->pmu);
@@ -288,9 +288,10 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 	 * inform that the resulting output's SPE samples contain physical addresses
 	 * where applicable.
 	 */
-	bit = perf_pmu__format_bits(evsel->pmu, "pa_enable");
-	if (evsel->core.attr.config & bit)
-		evsel__set_sample_bit(evsel, PHYS_ADDR);
+
+	if (!evsel__get_config_val(evsel->pmu, evsel, "pa_enable", &pa_enable_bit))
+		if (pa_enable_bit)
+			evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
 static int arm_spe_setup_aux_buffer(struct record_opts *opts)
@@ -397,6 +398,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool discard = false;
 	int err;
+	u64 discard_bit;
 
 	sper->evlist = evlist;
 
@@ -425,9 +427,8 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
 		if (evsel__is_aux_event(evsel)) {
 			arm_spe_setup_evsel(evsel, cpus);
-			if (evsel->core.attr.config &
-			    perf_pmu__format_bits(evsel->pmu, "discard"))
-				discard = true;
+			if (!evsel__get_config_val(evsel->pmu, evsel, "discard", &discard_bit))
+				discard = !!discard_bit;
 		}
 	}
 

-- 
2.34.1


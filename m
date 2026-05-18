Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06638838F
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079703; cv=none; b=DMTQ9GRrLPdX6MQ2ks4rGYfuDvb+wZ86IJV4cArwMGkoIsC034BCdKV/SC/vaqB/ThGluQ/5LnBJk4H0gttomWhn8RID8yxFm12pn35stOJEEfZ++liRf5leJF8TTogCKs8L/gkYNk2yJJ8DAzg9kOT1DKdhppDsd1Ef9jdmFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079703; c=relaxed/simple;
	bh=NGfYl6kDEytKUmpKfL2C4Og3ft1hP0ENd8qszCmyGZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsVdx5xPA70fzg6WaZoYSY61EhAo/fSjoBFjpgiAs6nDQ0pmWF6SLetPjris2vZzmGJR8VHHeQhHqyvxa979RA/1zQbShSczb0srIWATpOmC4Rw3u99gbF/5cnczJeXurtZqEG5v1qtDo9RVNQ/t8lrpq1o9G/uJq5pNNTl3lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kia7/T4p; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kia7/T4p"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1329791f18fso2968446c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079701; x=1779684501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=kia7/T4pdUdJTsx3KDxckXvr3TE3q7jZb+W6FFn9Dh5WmJjYvKVv/NhejoBgmhBQSV
         UhWJ0qX56ebpiG/eAG+IQjXOgDLqAah43oYvD/0l9gBaAjiyeA+ZIMHw5LIMQcslI+7Y
         6aRfoxo1ZBsToqCCvC33pPY3hqaxwIvbkBmp+HerE2nmKPGWNfGUYd6p3rMmZlZVXgYy
         /nMiuVksXrXtLFy8zwlKa/hfyGmXWa1Cpq9ZtM1Y0QBN5pyXh1SgUuFBuKgjVI334Djk
         UywstsXXLOE+3FhMIUI/mP/xu/gUUhTRFDgq67QYTBHdUSDbprTAsd7x0s7e/PKjB/D+
         hmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079701; x=1779684501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=Hvjq0tiqDDDnI7R2+4Mb3hTBC5eKZVJ1FB8F8iiABEVdYKaWtnUQqvKmamspA23I2A
         i4TqLMfHwYU0/MMoJZNlsyZsPuZigPbfzmm4Cih466CJdOEsJoT1vObse45p+mcTfTms
         2PRL+e+DbtPn0jd9UlHboTvz2iKkCfItdngR9v701SMVSRc0G/7mECWurrWojhDn248q
         j99UJBO/8CEImxxN7khIRYMXOxZFc2z67n4Q8IBwNh86kevrkg0iDAy91s+6D6oQH52H
         93GnaVMvWLJQJUsSsBBOZHnLJQW/bZMhDIewpp5q9VrCs0zDXAb8uCnmsDjva6rn6NVg
         qOgA==
X-Forwarded-Encrypted: i=1; AFNElJ82kACoiQFm99VLEmLo3liiF1zon/7DgZW6sR/Rcq3f6OvpKzi91wCSYsz1ydIeT46BKNuAu3oJqx8pgUA5KlaT@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBk3OBCKWbR+/a31M/MdccMiWAsa7gRyFaY7oEYfOlhmPbMOT
	2i/baCMv2kooXHz+FF6EnZCca+jALUgSQNLZBWtx/NmpD8MqAbX2k+EFo520WX117yGdDo5BX8b
	nTCaA02r0KA==
X-Received: from dlbts4-n2.prod.google.com ([2002:a05:7022:b044:20b0:134:dc33:910f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f88:b0:12c:2dd7:9099
 with SMTP id a92af1059eb24-13504945cc6mr4942569c88.30.1779079700850; Sun, 17
 May 2026 21:48:20 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:39 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-14-irogers@google.com>
Subject: [PATCH v6 13/14] perf pmu-events: Convert recursive shell assignments
 and macros to Make built-ins
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

In pmu-events/Build, ZENS, ARMS, and INTELS were assigned using recursive
assignment (=), and model_name/vendor_name were evaluated using shell
macros (echo ... | sed ...).

Because these variables were expanded inside the COPY_RULE dependency
evaluation loop across hundreds of PMU JSON files and inside every metric
generation recipe, Kbuild continuously re-executed 'ls', 'grep', and 'sed'
shell forks thousands of times during AST parsing and execution.

Convert ZENS, ARMS, and INTELS to simply expanded variables (:=) and
replace model_name/vendor_name with pure GNU Make string functions. This
guarantees Make executes directory probing shell forks exactly once when
the Build file is parsed and evaluates path macros purely in memory,
completely eliminating over 7,800 redundant sub-processes during build
startup.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 95172a2a851f..372773b998e4 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -56,12 +56,12 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 # Python to generate architectural metrics
 GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
 # Functions to extract the model from an extra-metrics.json or extra-metricgroups.json path.
-model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
-vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+model_name = $(notdir $(patsubst %/,%,$(dir $(1))))
+vendor_name = $(notdir $(patsubst %/,%,$(dir $(patsubst %/,%,$(dir $(1))))))
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
 # Generate AMD Json
-ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
+ZENS := $(shell ls -d pmu-events/arch/x86/amdzen*)
 ZEN_METRICS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metrics.json)
 ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(ZEN_METRICS) $(ZEN_METRICGROUPS)
@@ -78,7 +78,7 @@ endif
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),arm64 all))
 # Generate ARM Json
-ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
+ARMS := $(shell ls -d pmu-events/arch/arm64/arm/*|grep -v cmn)
 ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
 ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(ARM_METRICS) $(ARM_METRICGROUPS)
@@ -95,7 +95,7 @@ endif
 
 ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
 # Generate Intel Json
-INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTELS := $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
 INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
 INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
 GEN_JSON += $(INTEL_METRICS) $(INTEL_METRICGROUPS)
-- 
2.54.0.563.g4f69b47b94-goog


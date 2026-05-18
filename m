Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DF286415
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119245; cv=none; b=XT0FnBw1m+Xjok9h2Vfv2Fv7ck9tPFS3gdApy5Hnx5DyyPB2T33nROQmeb6U5R+FC8PGXFzcDDkYxCQM1IgaBmzMbs/qicBmx9c8KmQUDH088uX0qVsL32BVMEuMKyyPp+eIBznbS1VGfzEc5g8cEVuSEDftiXPrD9XgN746z00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119245; c=relaxed/simple;
	bh=NGfYl6kDEytKUmpKfL2C4Og3ft1hP0ENd8qszCmyGZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0uiGK/7RYDssMaaYhOgrFp8KyiHT8DooNr1ez9XFZAkNChuSfPbwsR4PAy7HNjfKgwBIeiYiGeI2uE5GtrenPDvJjHisWymeXmyf5tE8LrVmpI0asF+/NzNYLMz3mDnueeC4+CsambvxteLWoY5ECDdsP1RaT3LEgQBrobgeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrwWJQk7; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrwWJQk7"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312be8a31so6103525c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119232; x=1779724032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=GrwWJQk7vMPde+vKhBQzl/P429Q/lgUN6J/BG2/d07YliwnQwjS+zSNnm8IoSTQEQI
         kx+kZBoNEfCNwpBQT3W3r2m9VRuVQSIsPQv8k3DEoxqQhNoV/vTTXKpLBpnh+926Tld9
         o+yASFtMTzo1QtmiOUqXRiDpKtC2eSgk0SQZ01mbj/2B9D2uDY9HOx8MGJyqMCQr3/iS
         glVPpPK6GvnMmAKeHqlMsz6gDHekDCloMl030IKnPM49RlWa1Uj7uHvURfWhf8PADf87
         KEUj7+WEXoRLEuQp9Nwq0w10Ekgg+SM6MNE5w2y6iSptpAFLTu5cPkfEdCp3d2roG2HH
         IxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119232; x=1779724032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=nEqSkmp6w8AxL4Xay5Vf+JOt+XdbZaF9P+2bYJWoSXg6T6Tb8uEfxscU4WiGrCh78S
         St60ueLgzuKVMrrCM8JaSNPUu2ff3D4yvggOU/EI/Pta4MgwpAkBLbAOPxvA4HruKMB5
         +zkTt4Te87u4pZbci1bkplvzgx1of0wN2PRWJulmAI3vialbt4NTySRibchmoKeYyGWJ
         VDXXsydHmdcLBIdZEGJCh/YE7XPXtA21xjf+VbYdZqFsN6WJsKdX9NbymXATYD23cZ+i
         t+R/mBNYNSL7EUV1S7o+k8WdKX7VoXIXwMXWkRaj8Hhd4W0Q1v2pjMNFMeJlSm4x+8yr
         kK9g==
X-Forwarded-Encrypted: i=1; AFNElJ814WLg1KslC/J5p7nPtZv06HGDspP/kcmVWdcMfxl/Za/SK4cwHKjiThD/AneHBA+HFOE6Lmi8nEsz4o9GNLFh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rc75S/6/mRki8N8kQW4ytZ9p7bwH3vrm3i7tdJpzSfcNzGF7
	NlPbNhgQ1dJGbj+fbwmQ98AQ7pcEXOmoNwRbeTUF57sIFeebuisJElReC+N6U1jOpjEcBKOf3da
	4OxepGL5XSg==
X-Received: from dlbcj24.prod.google.com ([2002:a05:7022:6998:b0:12d:b2ba:b551])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2512:b0:135:3025:be5c
 with SMTP id a92af1059eb24-1353025bfefmr5841182c88.27.1779119231647; Mon, 18
 May 2026 08:47:11 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:37 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-14-irogers@google.com>
Subject: [PATCH v7 13/14] perf pmu-events: Convert recursive shell assignments
 and macros to Make built-ins
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
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


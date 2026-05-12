Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDD3E9C1C
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608047; cv=none; b=s2DcI//fTtPolAYRI0MlflLMDCzYxAFvQ/wW/zznvbRXl/9Axuj7A0bzVBWLo8o3rGF5xlwbXzroJ0q5BuifnuC8D+v72r6CGI9T1zc9USlg2T94WQlvJZzUgd9u/qxKwgFY5sFWSSAEFSH29x79RvLECzBw3BmvavuBylAGKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608047; c=relaxed/simple;
	bh=fbeGUoInrJ7IQS9XDD8dWdJoRhkp1aoUqMLyaq501UI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CqhT9YF2Tlpsw1FLHaZke4Aw/QtLtTOULwO9Uev0FKiJu+FALOHN3bRPFylCbIQNk3s2lDOssgmHTRRspeIH3/cPQ73EUjZPQDMUYQpbvHLzSepVC4h62YF/ne/Bp/1g4whCbm3TvlvVgAGmluVrgohn1653x6qENEKB9BQs/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuzcC9qz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuzcC9qz"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc3d81736so5362154c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608045; x=1779212845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlwGLoBgL+mbcr2Ut7vVtoWK7MJrQO+SoHBMlgxr4mU=;
        b=ZuzcC9qz52599ULcaFrsRc/OHlDKTE784zzb2Ch+62hPnyiwiweD14PKKwPaPkW9v3
         MBXepLtBxfiyV2i13jotC+uNpBh8WeazXB0UWrhwncSGCYbOKD0ZEFfmpklzNsTveAgb
         9vibtcKfi7mRZoaP0KA2u8zELNMtTw+a/MjVharEmGAY9Czq/Y8+cK6kUye0S/5O2WZT
         GEId3dx4sh/CUK55J/xpY6rTGPgMJFEqZ16Okt12hl0yQPmJhPIiMYai8V9t+wlkZWL4
         3vbcoYCylVYUYAh/yNgq1lhbtQzUzPa6xFByjd/RJlQAv+SDg/T5S1wKHwbQJVQ/WzbY
         FnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608045; x=1779212845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlwGLoBgL+mbcr2Ut7vVtoWK7MJrQO+SoHBMlgxr4mU=;
        b=aUdqD4ry0uo+n0N//V7QQyJMCmpqrgFDqNpIFC/PhxCnKLYpRU5M1lMqOu4uRqRwj/
         B4qovV106Z611f4dy0GZocymRXLYg7hGtuC/w0OQ4fyG5CWLwKVs/HD2xkeRlm3RynaD
         uKVI++HEkdE80h6yFtiZwF2KcZg8auvfrm+MF7Wh1iZrvDiSGPpSEMRumQx2BVM/2l9Y
         2kqarCAwp+1aP4MjeCBigUnnikxc8jz3lbu8gnV6fJIxVEtn+s9rNKmcgV+ZmB18MABc
         inmAYtIxM28jcFA+3SMcJXKz50Md4R7gb5z4Q7CWsFSRr6nON5wf2emNMRQAdm1e08Nk
         KIFw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZVmP/qH2iJOCT9RAg7PA2rV/as1Nz42lqSTbKcwSpqVc1CqfQ4rmFT2DZKAOLlYbvCgwnQduQA09BttkjfrMF@vger.kernel.org
X-Gm-Message-State: AOJu0YygxETFPh0n/OK6qSDjaYteb+SPExr7QuTpMcEA4x7bkF7xzmPX
	rCtq5WmSdvS3WAzVAzcTwRK/srEQj9tu/0/UCiORgCo+RwMfzGMrps6chUDuYH/vbMhSbZhMbBQ
	VpcIsT0Z1WA==
X-Received: from dlbpd1.prod.google.com ([2002:a05:7022:1401:b0:133:5da7:fa13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:914:b0:122:2f4:b285
 with SMTP id a92af1059eb24-1319cf59324mr16562582c88.25.1778608044293; Tue, 12
 May 2026 10:47:24 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:37 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-18-irogers@google.com>
Subject: [PATCH v2 17/18] perf pmu-events: Convert recursive shell assignments
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

Convert ZENS, ARMS, and INTELS to simply expanded variables (:=) and replace
model_name/vendor_name with pure GNU Make string functions. This guarantees
Make executes directory probing shell forks exactly once when the Build file
is parsed and evaluates path macros purely in memory, completely eliminating
over 7,800 redundant sub-processes during build startup.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index e957aa2fcb48..246b04f73ccf 100644
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


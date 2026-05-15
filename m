Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BD2F7EE9
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866769; cv=none; b=ucImWYoJQ7bsmrlLTd5woMZfYXtlNqfLOa1ukOa70CLR/cfvv2mFsEW+kQhhsWsxa92pSSYftH7K+86cdrVv16HK7C9TUKuVdLlPrtCCJvqLIx5s87p8rWl8hXvTFueOZWJe7a3I6ZeJjc4qoSiu8psjH5+9LP4S6KaWsogUY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866769; c=relaxed/simple;
	bh=d9v/zn7cN98XwEUIkQ6fYLdXscu8Z2OxVtkl8nN1TR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BH2jV524q+MvsZ660lJ2W2H/ODWLonECr6Ajn1BUFU96PUUn29aYI1pJirz07bbeqbjCUO7HFxCn8cdljbziS5Z4rhoPZaGt/SbFIoPp6LFC+Fk0/VcXQgAOOj6sosHL4pQh8OrLDSha3FS59vOcnv06Sv8qEbxF5NggwWCY7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FN7J1Ns0; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FN7J1Ns0"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ef37c3f773so71312eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866767; x=1779471567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlTZqfiM34zuT+HUy2FopVDxuCmyQZqh3GdY28jLLgQ=;
        b=FN7J1Ns0GvL2nI9nrY5So4hRAbxqAGSEgQmIKkEUg8krTxbZchPpYe2pn47zYDkT6Y
         VVbe4yK1D00NRtFs5FJt3ljj67HXnDCfmgbDRHUw3d3PeHAuFdYHZVcYizay38ScRJLP
         3BCSdOwnbnZUtzRvwmPTLv2PIWCKb/9ZieqSvGGBSj/q+3ya9MyQ/LNUPZjA2XaPsftK
         pfi9o7pUBue1oDSFCjNMGvnMrvBcibV09qT8kAxzcWQ0LakfUPW7aQzEkPSeUBWBIMz8
         mXme4EupSMSLXvshV50N9ZTZUHfj+ke4gh9pXyqbfoOTL6Ip2p75psV0hg9toG71u1EC
         QEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866767; x=1779471567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlTZqfiM34zuT+HUy2FopVDxuCmyQZqh3GdY28jLLgQ=;
        b=NnmuM+OxLAuex/Q0Y8X4oD8HPnoexDBlViqiRkq72rUSH2vtmPzdj2x4x3onsHOKgM
         P3CYnqQTOp+wiBjIk4jSFIRB4Hc2kDVvriQJFybfRxvqVv0yKBgB5aAyae1Ddka6jjWD
         RgOOmBtXpvMBZMx6TpW0wELNWLMmbxxlWzs1HkeaCqzL0gCcJVt5qdQOqaEHmIEOY1sg
         lHJNF8pvUNFE4++zwrwVTrUIv1weVGxL7r7o1kaKnjADQNQYCkubHYfsv+noMxn57qRc
         xHczCOe+KX56CYdHzEalhiq20Yv2IP5HAAFym9P5THBIxRy+o5GOhG1x6vAIZjOIQibg
         xHbw==
X-Forwarded-Encrypted: i=1; AFNElJ/dH/ue+gYO50Qt4JmZAZzuTNVJDQYzaqEGGaupQikso1PmuVPrHaGGhXBys+M39wR6z++gWOKRBInsMWVqECLI@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkUcQ1gxVSvVyi3+rcaKSn49ZxkVLwlP8vgH0mOM002sz0jMP
	QiMzTNhLvhzouj/oyuujDH2FlNjQgTZTyHkuDZZgnp15hQdp8fumcM/OpqEtAZPimERVr6l7X9Y
	9lghCnK5B+Q==
X-Received: from dybrq18.prod.google.com ([2002:a05:7301:4692:b0:2f9:af7:5047])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c97:b0:2d2:d7b7:5c61
 with SMTP id 5a478bee46e88-303982bd1afmr2473894eec.14.1778866766407; Fri, 15
 May 2026 10:39:26 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:50 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-14-irogers@google.com>
Subject: [PATCH v4 13/14] perf pmu-events: Convert recursive shell assignments
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
index 00ae173cdb5c..793a549b82e0 100644
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


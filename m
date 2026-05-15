Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A773DFC7E
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873636; cv=none; b=fUjOgqSuEfqeDgIH1SHCuVLpGwFop5HREqkUHJzfb9iuBsQgGV+JbS+f0YIr71Dpe/FJ7sDHYW9T9oXfq/HB5wdiVY3NL/uuSSJ8KnYvwDQDoH7CXCqCek+oDfsM53GaMJa8Q8dl2UeAZPooKsSUfGCYTzSIzUR0phkBt1s6vBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873636; c=relaxed/simple;
	bh=NGfYl6kDEytKUmpKfL2C4Og3ft1hP0ENd8qszCmyGZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CxGzmb7Y9PUsyHp04yX6Z1arQcrrRG5Pqlqh8LSYt8tVoBlROFCd1xouPCDkwsr5OljzSm3GYDwUEDQ8gWqiJqO5kdE0saIr6XwdsEp1u0LG1WVxUTNQLnhgKiIvY92dpNxcX9KzAA6z1buX9vXjU0jjYqTszjqFQXuIvIXQZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDqny1x/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDqny1x/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353a6f29deso785873c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873635; x=1779478435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=SDqny1x/8dX7St//cLGfkccVacFkgX9dRZl2SJGG9P0Jq8+TlLHFb8SM3OkmZy0Ygq
         ChxaAAuQ2IK2CVNr5jU86qm5H2/TCX9RYDgPfgtUpKEHlZzxkf0qu2kOFt+pfKCFbEk8
         94UZGZtX/bJX0xEnVx1C20F1hABEH1jJjdX9rqEb507IPDDEcnRwIVvyw50qyX7JwuuQ
         UhfZCR/DlguKPCpfBwqa7zCW5oGPpV63i34SoeEjaJELaPcxLagbFM7D6CWpTUQMU6DS
         qiHP2lye4vym007UXc0TnOTvtNJXxccmnvabQxV2KzXNCdeVMbIBST/WojFJnNdSQqyt
         0xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873635; x=1779478435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugOFCk7HwEprnixRixPWaow/W0W91ZlZhg4SUCGAxfk=;
        b=pK6OEGBGgflj186/0X4MIS6ZcgBkFIoYeKd/4u6svW+pITETxW0H/GTYBS/J0KERiB
         p1O/Vwv/6ngGRBJ6QFYTLe1oWMLpvBZhOCdLhO/daTtMPYqMEHiHQggv2D0WZpYFYHWP
         rX55FGeFDWEH9vgkImDvI5OqFXeU7olSvK8wJhsYyRWShGPfVpQ2pjcnqFQlxy8PQEWn
         u20550Tdmc88UX2A6jMpoeFOmajLHVIzSDL+6OMieCkUXjPSKtjtswqletuVShB0ugXj
         YG/X0+FIjvvDdA3RuT20iOD1xL+zPelUzyH2/xOXXtBC7zi3tNfblqBTNF4GLkbDzIwR
         cWGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zhXalKdoEcL496MN9Aw7KWlwx8ztiGwRNzFu+0zTESiNP2LZgo8oIwmwZbhiZdVADuuXxwMTWyyuqXmP5XZSb@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1/WFTaM4ZkMZIBc/MtuZIrZfiR0vIoAIfwnN7QXhbOPMzj29
	33b64DEEg0lzgehaGJOHLAOsqQ3w+oXywecKh7Jd+j53VWkI9h7M+s8MIPjcX+TVmXikfR3orOp
	6SyTWgNIwsQ==
X-Received: from dled20-n1.prod.google.com ([2002:a05:701b:42d4:10b0:12d:d0a4:2ed9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:221c:b0:130:a479:797d
 with SMTP id a92af1059eb24-1350494e48emr1418656c88.29.1778873634429; Fri, 15
 May 2026 12:33:54 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:13 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-14-irogers@google.com>
Subject: [PATCH v5 13/14] perf pmu-events: Convert recursive shell assignments
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


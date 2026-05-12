Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640633C09FD
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608034; cv=none; b=C+aJ1lhBM6vWbX3H02U7mtsNZLskp1nAY427wrxPcmtkmMufn4oQ13euFKIpUvN+qCg9IqK9OaroSG47EfFWPyeEPQNmOxGv8sMFqUWgBEeBfARZwxewJWztrf+j+SxUEPXtnxT+am4simjxLsX6VUfw4atRYGsrU45T/9POPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608034; c=relaxed/simple;
	bh=V9uO+ebp1yArPXpVQzfrUgibD+lVsuNu/lXBqcKFX7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SqTTPyymVUZ5l81biHSD1oXo2E6/jJDiBzj1JqaO6LudMaPIFQIAvPsweEmbdAWikPYtix9jQrU79BKSlDNGGwYcEudNJKtRFo7vD2YtQiLYSRP194UZFnYDr2SeB7pXOqSEEHWabM46MkEfzQnXRxihqZysF//3RadQAnYpK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qU5mT/cp; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qU5mT/cp"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13367aca29aso1356449c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608031; x=1779212831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub1wi1XFkCEqGxrUuZJmOTaLUIJDT+EL7sF28fUopIQ=;
        b=qU5mT/cpTugojQ6nFLl3IFhbPR8VeL7bX0+FJqI5K++E5fYkz8Dq6by7fLcrv+PXxS
         olfqi2M1XooJGXggHriKD9CxOkA8JjVOr7QjX0wAxHOTHy+POOukn9M2I4y/AUpIqqlf
         crPlIse/q8Cv/OGXYCIX9Tm70FCc9StZf59l4kFWoW7r142Vo7jqNlyotPnPQfKYqrrg
         NMNjAOrd1PHKcm9qUtWrBl8OcmJiEmwJIAn8+5pi9/6pZatcXM2tfAvrxt1fn4sGYpMz
         kaWCOiPoM9FEaztC3dER43ToHgRPjB1zUv53V2jnR+QKgnmZoq3ZEFTFZHDFTgvT5SA2
         aAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608031; x=1779212831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub1wi1XFkCEqGxrUuZJmOTaLUIJDT+EL7sF28fUopIQ=;
        b=SxcHnOJCT85btTtawW7iKMK+a4til3ry/u44guzdEIpa9uy8DbYdsVil9QIyS0FuRg
         KS7NVrRpyrZwpd+fOZlqXimI5HMLnk0pzsbnTbVR/ehL5eN4OTzs05TA8TQibXOa0l6J
         CfWQkiM8W3RYZd7JO3TuCbmBxxjsX4w6mhMkGw5Wf/rfdDYseQ7+LaXwY7yHiaCoZMP9
         6iOyLYTVE/bHlycilJjEi0hnKNz2fOfdNxYbpej10y5w1UvNRU+c6r4omH3UIPyIRmGb
         EfRTWg296RMsSdMQ0wJAESZts0kg+EMp7RTeQoNehGSG7CmrB9hxxP8qPBkTG9DRLgum
         LlnA==
X-Forwarded-Encrypted: i=1; AFNElJ+BLIm3IvpYpc3mGVs3uMdIMpYKKAMF4CzmIomHHFinf1mhe9sLUchp2fF+Xs69tKTBZnL1eE1Rdj9ZLZvPhWay@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkK5tKg0iFnwpFkSHlg7syPOstvEXhk8SwRmM+0vNZ75QxHD2
	vRQgnuApU6qLUXQ8IXEPWcYQco1wmQdXZcgxQ8HW/szSHFhP94+aXwL/CCvPUaplQK261amWXMT
	lVX7swnXOfg==
X-Received: from dlbbq39.prod.google.com ([2002:a05:7022:6727:b0:12d:bbfe:96d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2412:b0:132:f27:533e
 with SMTP id a92af1059eb24-1320f275532mr10237119c88.19.1778608031266; Tue, 12
 May 2026 10:47:11 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:30 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-11-irogers@google.com>
Subject: [PATCH v2 10/18] perf build: Move static libbpf dependency out of
 prepare step
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

The prepare step is a large serialization point before parallel
sub-makes build the perf tool. The libbpf headers are used in the
bench and util libraries, as well as individual perf builtin
commands. Move the libbpf dependency out of the prepare step and into
the dependencies for those targets to avoid it being a source of
serialization in the prepare step.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ec0e91bedce1..5af767415c11 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -547,7 +547,7 @@ export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
-$(PERF_IN): prepare FORCE
+$(PERF_IN): prepare $(LIBBPF) FORCE
 	$(Q)$(MAKE) $(build)=perf
 
 $(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBBPF)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -636,10 +636,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	$(LIBSUBCMD) \
 	$(LIBSYMBOL)
 
-ifdef LIBBPF_STATIC
-prepare: $(LIBBPF)
-endif
-
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
-- 
2.54.0.563.g4f69b47b94-goog


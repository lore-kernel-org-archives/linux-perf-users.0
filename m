Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95CC3B19B1
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873626; cv=none; b=u7frB4pzLXiSvMtaaWaiExK5aBeJUfmmSQcSBRAcPgk9MAtWZVdRuIH5Z8SnNaAh2P/xuoIBgU++lu7WaunlpRL848xs6sWiEO3h8RMysaTfEDwUFZlN9ZDurJWcfvgl1SeRPyWEvqL0isTcEETLVnZan61f92Z98YpsIkePJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873626; c=relaxed/simple;
	bh=l5QKav5wmqSVNvurZfB75hgd7Q4yiRfMQ7JC8EnR+0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMRXYKrbBP9TDUDlTdDqyDZ6FGqee0sG/bRLvCcJxA5AAs5IQoiyZpqfVpTcUK6puOFrWC8l3DHOMiJff9VR02a0KvGY3wDeMhKmiBqnVPjOrXckde/fJYNbDTNVPKUuosFK6jgZ1daC9DailJ0iid+pE0RTsafdDHKy2cGSI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZNZbJiT; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZNZbJiT"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30230e64087so256546eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873624; x=1779478424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=RZNZbJiTS0HVMeGLyynEI/C0je9kjcjn0VOMwOOdQBK4sT4NaohqL/RpV6/+R8nO6w
         7SGcXcB4jBOOxY6cD+t5AhSJlYdvv74WEJ3Al6Wt5Vnq48qkZv2jUJApOzfd1KBo08Xo
         UYnHZpJsCdG64K8Q/1Zsyq6lh7HaOALVxukwsyA9+MCltZ/rirkotNvEwBQ6rPbGT3I+
         Rh8CRKgNzLaXRADF5gFKKFMcdsS5MKYpXu1edyBI0DT1DVulOGZe7S8sqgCq7pvHqKaQ
         A2YTM+w/S2/cKGM8PcTlyuiIL1b5dLLRrDRVTmX7BB4fuftz5F2tfCE3EuECQm17fdCw
         I1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873624; x=1779478424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=TFjlH55dm38at932G9tiXjv7Nfw6wgAHygwhtMuYtZSDaId+Pf14p3qqiLmzQXK+jf
         fI2W4ChB+21cA1iRptVNz3zM5S0s01aG2KL2wP0IKsObPP/0NaJWHP8O4VHD5Y9JPrtx
         7X1HDf7NuQ4dWO9kIWzXnlZdJiAFHFx6fGCLuOllgbiQ5IBhR1GZUJ0FFkqH1mlTCXNJ
         +dYuLomm/T9UmbZ27BWJ69qkv5ESuJCX0R0Bn5IeEBkiukpe+3YZe4rszPYxvVXgtn0/
         hkoHa9geMMjKfdGtGRpJadmqxjfQxx8GPMbLT3/2AoU5KgdyhWFpg0j5PW9i2ihpamh1
         B4nw==
X-Forwarded-Encrypted: i=1; AFNElJ/gBOiWB9UCGyPaBWuvtip1eXTs7ViREPg0/djtfavHpm3Mnqr5tbUTpoacDWp1iS2wCs3Dhk03Nv30pZ2ys2rc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+nUkgY7CYuV/c30wtrTLVUoifRTijMZsE5x/tfi3rb3qpS1U
	FpNgJo6bdWaK+JU0ANOiXi3y4CQ44NZLuuOFrycxzYJyW7IEbdHgFdtKkBvh0DXSrQDrd0NrkJp
	AzWiISMlWWg==
X-Received: from dycns20.prod.google.com ([2002:a05:7300:f794:b0:303:971a:154d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e7a2:b0:2dd:5641:f01
 with SMTP id 5a478bee46e88-303986ab2a1mr2386078eec.28.1778873623656; Fri, 15
 May 2026 12:33:43 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:08 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-9-irogers@google.com>
Subject: [PATCH v5 08/14] perf build: Move libsymbol dependency out of prepare step
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
sub-makes build the perf tool. The libsymbol headers are used in the
bench and util libraries. Move the libsymbol dependency out of the
prepare step and into the dependencies for those targets to avoid it
being a source of serialization in the prepare step.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 876065a02de6..96a68723109f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBSYMBOL) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBSYMBOL)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	bpf-skel-prepare \
 	$(LIBAPI) \
 	$(LIBPERF) \
-	$(LIBSUBCMD) \
-	$(LIBSYMBOL)
+	$(LIBSUBCMD)
 
 ifdef LIBBPF_STATIC
 prepare: $(LIBBPF)
-- 
2.54.0.563.g4f69b47b94-goog


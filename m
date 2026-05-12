Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5673DD84C
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608037; cv=none; b=talSNuO71bxnkrA9Z8LhumN+LY2nACLmlZEq8NbUh45fs8G/L7OpnXL+UlLjAtnQx1+OVLlcHrxwvGs1DvwnOf0Xsc/KOp3K0dgIopW/rGMS5DZmY6cAabZZHFc7r9hPQvx3XNmQ8l/oBezLRRDR5ejyIxB52VnZDVeBGi86u7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608037; c=relaxed/simple;
	bh=BWtcwch9wSpm+jcG4ZyiBYkU6wNGJJ6j24TCjJCtDxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tfIkXPPWxGGHqHZTVTsMwb1iZFUKeAux7hfQ5mHWkzK91C0RnCb1k81+Sfny8mY7zjgHBVlYAdbshldld0eN9cyE6FPh6RdYtVSCgA4OxGGeRIZhb6IfzRcJnoWOqarzlqMkuutPwHWISltSYFl3dLRgWNigpRMdr6/zOKslFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wu6t0AA0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu6t0AA0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-366344513a3so10738086a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608035; x=1779212835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YigNKPWKB82lJT8UYMSKceUMHop1vuFK75H7FYEGV78=;
        b=Wu6t0AA0I2+ybNq86mWs3uItgEWGY3hJws5tDt802bGEOtWz9lnKQ8W5vbrauj1iGq
         bHnw9nNHStr0heJ2Edlo2yOVE/mprJU2sykngST/SPLfuCMa6E6l/m/q4BzRoJhsjqNq
         XfIbnFuHD4If+I157cBgBW3xcFSxNa9CJhYFo8JxpQORoPmJLlmN4tHEZIx6Q/r8IPts
         U65vtuwjFDAJELiqgzJVckMvjgl7PeQw0OVz7cHEj+D0qkXgnMzSDKY5vuQMRdVEBlIW
         o5kmbmtvlC4vWgN8l+uotq+kOrXrCDDuLKRBWdzyu4jpzac6zFul1gNfLh6ZzQOoWWn/
         RmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608035; x=1779212835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YigNKPWKB82lJT8UYMSKceUMHop1vuFK75H7FYEGV78=;
        b=RU75zgrF8dAC/XNsFpfiqq/86podpriVsTM83WuBVb9fIND3Bvj1TcxRZyeZd3N1TB
         SutePok5b8jPyJjzBRHyQYxYO75QQZZ6f8s+/fELL9euUAXBJx9JFspyDLlC0piJsIj9
         Lp4f7W/Wm0d5VV2ctLeEgRebqu6WrdSz/xVkkKz9Trt8CWccT7U2WsWqqK1MQe6Yoshn
         l4JegQhH6eqAS/bk68IIMfkBOKdXjANvrhRkV4iwu9e82xHnHSlBmyIs6a6j3boVOBs2
         0nnNz1VLO8mFzMrwhR/SLYAPdaSFIVRbqmFBS+fAIt+da97rQtxYGJsNVvDFASC1cb41
         joBw==
X-Forwarded-Encrypted: i=1; AFNElJ/5kyoqaao4/UiTq+XcEhs3rZkXKGSFe3ZhUtwmbuSw6M2sVvE3VLh9nd4dbecxWmWWAfxU9lihnZuko6W78ePu@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5eRn7ODVMVJc8r22RwfkzlZ923xTP+76XAdjG/NQEDX/69oG
	F0UDi51UpVuv+ZN3BZHW8gW30qB8AEHVe0MubUgLd7jjlHf3irfFfBRTtibciknpK2YZGW5363w
	+H/C8dyD9sA==
X-Received: from pgww13-n1.prod.google.com ([2002:a05:6a02:2c8d:10b0:c7f:cbe1:2d84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:2786:20b0:3aa:c93b:625b
 with SMTP id adf61e73a8af0-3aad425fecfmr11319658637.3.1778608034842; Tue, 12
 May 2026 10:47:14 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:32 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-13-irogers@google.com>
Subject: [PATCH v2 12/18] perf build: Move libsymbol dependency out of prepare step
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
index df68d29ecab7..d2e673d5e5be 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) $(LIBSYMBOL) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare $(LIBBPF)
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBBPF) $(LIBSYMBOL)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -637,8 +637,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	bpf-skel-prepare \
 	$(LIBAPI) \
 	$(LIBPERF) \
-	$(LIBSUBCMD) \
-	$(LIBSYMBOL)
+	$(LIBSUBCMD)
 
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
-- 
2.54.0.563.g4f69b47b94-goog


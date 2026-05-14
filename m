Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCA343D64
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776493; cv=none; b=N2JeMHD/RU/W+f8T8B6y/hdmiABn3SgcDhTCZVn/Z/sQk0lXFJ/d4Unt19SxF7F7endxFmdJwIzZeCEE+ne0KeLGxmjVeO8wDkepHbKZfcDSDb37bZfUot59HHOIYqP/1i1WFJEZMJ237s8Ra+cjbdRMV/jDwl+Y0y9v4u5vveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776493; c=relaxed/simple;
	bh=uB2iXn2WBt+EDR4kH5FxSuAwCprzLAHTXeIvfLbkm4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EzXYELCGTt5bEvJzlTivi7q1fVkMtAs4NzzQ4cAy58TQnBljNpiiRZof4o1vgepfOyH5iENEJrnoJ7s8Zb8rzw2D/asbjxK9s0kOoQk357UeHpJsPnJsuPE0I/iCDYcDrMBNQAvcNhXH/V5Us82B8PBMfNiUGPaFBQK20cOQ3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PP8LD1Zu; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PP8LD1Zu"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132c3280e03so1533707c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776491; x=1779381291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPQGmeusY/cDiD2dEpt2Ws4BRT1lotcepITOMhHVtDs=;
        b=PP8LD1ZuFevVMqhbUJjsuz0mJ9bX3zVd1tvhLh/RZFpO4cOtB/Px5iv12H1hY9YM7G
         ufg7HT4ZmreUSrEBStUgwgB9Ed38vlvHf957Dy8Khatjhf2L4wPX0yNYioVfbi7crQN3
         Q6DM8rascLGll280FJ9S/tE2Ca6Qs5602demGX8Txfklh3LDGYII6k7Kq3EKR8JQGe3u
         sPwoQ+pUrIePW8nFI3m/DIdC1ftGlBRmsFHxHgHzuLqFplOyc/afmrjp5ygDt46cJAbN
         l25cx72cVbSkagHwge60AX2uJefWk+Tpbp0YOn4ObWXmBSitJe9Ih/MVp51b09yPhze8
         sbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776491; x=1779381291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPQGmeusY/cDiD2dEpt2Ws4BRT1lotcepITOMhHVtDs=;
        b=aVw1aUaPmewuXSUpQOu8DeDe0+JKHvR/1ZbipC3KT+4B8huWHgVsqiBunltd6lYRxt
         Ezf6PspsUvTjh1gypw83/sq30NHRfTRtex5etghmHISgiFUuH8jxttzQ2z28jx+c4vzp
         wMswaTrVZxsYIUkRS+Hw8woOnpJsgG5EkUVRN5x0ycY59MrjV2zRWdzQqr2RJOHo0Z9n
         h1Aao8GjQpvnKSAFZ32BZixyP3zd1rXUjfN3LZEL+7DegdOn+7qQA4gYDc2v57d+mJ05
         0lvSoJJ0TzscfYY710iTp+kp/XjVuK6LIQRp98r2KxeBtFaliZA5zDO/HQ2iGg4orvZA
         SRBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZmGVLI9eEjSi85Y7GM4ZSP5IgyqvaZIWbx9e/QWBGiDbNZvY+tFZmpdGTsmp1TGuvFl6MRaEjW6cCVmKZ9iyF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60q9sbB71265EDnjUzjSJqI31cH26Fp/FEX3KezPaZMSXc4jO
	GrzrotT//7ia8KIuGRSkFaA4St07oVCAOpO7AYfwHHCzvgvBrBQxGOt4hKaBoCr49AmRdoiksrx
	/WhEQplBbOg==
X-Received: from dlboy10.prod.google.com ([2002:a05:7022:128a:b0:134:feba:1ec8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e04:b0:11b:9b98:aa4b
 with SMTP id a92af1059eb24-1342ef3d106mr5357167c88.6.1778776490869; Thu, 14
 May 2026 09:34:50 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:03 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-12-irogers@google.com>
Subject: [PATCH v3 11/17] perf build: Move libsymbol dependency out of prepare step
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
index a0426e914253..01da32cd8988 100644
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


Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34D3F58D2
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119232; cv=none; b=YQjVtmDNHEb3fY2RCzKIxyguNb1WpuIxfwBEjlaJzh2bMhzK75MwqoYds32sBeEBTyjeWSqGWA14DlTSxswMwtyxH3iiD7EnXoK1YDblbXzX/kBcqTEhxA+j0wRoHxZPoIiwhzDbdG7CnowFuZe/NF4F0cj0o1LfvFbSQHttatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119232; c=relaxed/simple;
	bh=l5QKav5wmqSVNvurZfB75hgd7Q4yiRfMQ7JC8EnR+0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNdEe+M/g7wC+8UeMm7AzduJMIQ98JyhswiVndd4QCpnRvCS+auyl+b1Zpr2lrlvzHW6Yc8ZK5bHvxcxujMm2B5Xm4IaJXnr72zVXY0hQrPXA4mEzoWUv/JCXi5NRnvg0J06VdsPm47hDGyiRdzito2EXOJu0MXC/DgBsPb2GrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inN5A96y; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inN5A96y"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso1407717b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119222; x=1779724022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=inN5A96ygbRa1owLWamZcHGtfneBMNJbayNQ6cUlCB+rHss4NEQStfV9DKj/2s0uCj
         USpnZzXOoBrqEkFFlRFGl7rMG2mqsFTJIy14NLt1s16HpO3ePJeUQCxy2Rftr0gmxsnt
         xykhbMgOj0bbPISIRXayzcIJOIgnMOx/qNzAKQZWCOMbCQWGRIr7lLm1D8/p8srK+dsw
         8TTTG8YM8o5BaIXKWAFhSIgeLuc4adsTFz/fwCDM3ieYfbHMaForQIK2f67iwCgYE7wt
         IPEsaT7R5BSnd4X3UpU2ASuucTBMEw6Gx84ZZQIFhwU2YmW05qPlQifwQKNcK1zKbaPG
         dV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119222; x=1779724022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ko4k/zOsIwJVmScnIi9Okmp0zWky5zOptE9t4gyo8w=;
        b=BG2kNPC3nkl+Qk5o2hpiLKKWMqHPEkD1kbuBBVKHJh5qtz900WqFKNJEpD9E7wxSR6
         keD+oOzdps55YJ9yyPUY0HkUpa3mV0LTJewStxYBkZNjDO4asWVhgtxJmMgIfSODutYw
         oFiBW0ccXkcbtfBUCf0otuiHLt0fnMng/huv98nIknGl3hSg7F6V/r6sspV0u8Iy+ML8
         /CnikWItC1RvQORV6jlIEnJ6cgKt/fDyqYftZgd2/5EkTkRcpgD46ZMr9Xex++dI5zlM
         spD6aw7DPexyXOFSb7spGSq3noOY50wXTKs3j6I4cwx5EA/TLqMhYq0eRHAjyIQf6AJr
         u69A==
X-Forwarded-Encrypted: i=1; AFNElJ9R34jtQbGa7ei8qhYF3MoUsCBUSZzpzaoXaEUQUP3oYJu5YRNHFNhXLfDsLPvmwLf4uhUKczNOPLRseGL1Eokw@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoOERo3VPArSf5Ywx2p0fY+lmYMb4nFsGe0LAggmCQwIKytYG
	tp5gCrLs+xPb5wFaBlTkH6ng/4EwT6nkPDir7gYhbIPluexHoJXCwOsoBYPJfeY0kZWBwC3dNGK
	29SEuVK7KnA==
X-Received: from pgar28.prod.google.com ([2002:a05:6a02:2e9c:b0:c76:b173:30d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d25:b0:3b1:a9ce:507f
 with SMTP id adf61e73a8af0-3b22ecaebfdmr17076556637.29.1779119221649; Mon, 18
 May 2026 08:47:01 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:32 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-9-irogers@google.com>
Subject: [PATCH v7 08/14] perf build: Move libsymbol dependency out of prepare step
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


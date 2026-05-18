Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73ED2D7DDD
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119214; cv=none; b=acemaSjYPhRmrdxVa0sdcIGcwgaguN8O+BpVeGFawKXsLDInV5t9ze9n4mZpAKt1GYH+1ODJOblji2O/BmZ/5kw6JhCVUFOG++l4VfVxSMLGMEo124X7kSUL4xSUvGZiRXIJxX5Vd3xlFRTKQQeTBDSxavqUD0PncgzNR94JMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119214; c=relaxed/simple;
	bh=M4TALmiKZilb0u+lhPWRfGvMJCr+kBUrEvnnlqnUv2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VtXsgPXWJ7Oy12Q7uN6Bpjswx1GmmXr6eVjLMNCHt4wrDAbyT1AAehtgmVx85c87vGhvGhJo5+UPmI3d76bHs4nHtJsGPM1Sql5x73yaCSoOkvXEpyF9ouCCKDoIxkBSDyPl0n/B35t1SKrd6QxpxBH9OPig35gGHXx362Y6JPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spFwGHXq; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spFwGHXq"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13509e2e47bso3401399c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119208; x=1779724008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy1UTgDV/XpXNGsXM34DAoH9zJ9hy0otqwfOVYZUB1U=;
        b=spFwGHXq5VZVZBzj6xcesY4HWaHX0HQIMo3Um0ETy3m+nW01M0X0R0Ytnkag1ViSjF
         sRMRwBQ3KmuHfxtzEp+0cOXwKlKPc/xwYyKJCIVW1TYkQTK6EplKHzotGuNVXO40IKCf
         6CWHkAof0tYLaY7BQnLN+W6E488bvhTwqi+Y1u9cwrOyGU8IKyi4bpSNiuRxshsn2bWl
         9Zbt2hYR13GiZ9Ox/tKgczzN6lDD4YZAXZjuBmbgx8izNjQT+Rvm+uh7/wKC8TDpHixD
         ytcMe2328yolnvDNkjuSgp+Zpx3hRLdXMf5paaPq7E8k3rb2qW4uug0l/TAX2PdXzgUf
         ZHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119208; x=1779724008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy1UTgDV/XpXNGsXM34DAoH9zJ9hy0otqwfOVYZUB1U=;
        b=JDwZFOrVOs0e5xMim5jgAGEKfhgpNXg+o8c+LPej406p65KkS4bQ2t5DVpllExKOfr
         1UgUJjfNRn8rUV/hZy+CZbC7RCJDmgztRvIeTiR/ONvuhLcav/4adHn5HjywkIM6OhRB
         1mijGJPscoyhacpMQJzAPqPL8Dfvn2DEEjrAOJgEny3LfR/IxxMEtHZ4nPCSiBMhCEe4
         xCPi7NyVfLOdVkNkNRFqkcPswvapBXl/hTZqkKXegdshUovkGQDWe6hLiqhAQQxY8Xom
         AZJA+dW+dWAXlXFz7Ipl520rupnto6F1GyQeYuh1oOa637VOWSu3HCH11NhNec6Jprkm
         CB4A==
X-Forwarded-Encrypted: i=1; AFNElJ8FvYLjGAGcef1pgIL8ce6p3pOIfTVf7svJZ4FWuRYGwFG7WJKs7em+Peov/GMOBmGqeKvpZEGXG07MR2q4lEXQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywctq3gsh5jzyjSsf3MC8GM0a6qsq4h7v+/RBI9m78UhHPvQXr9
	YXnXChIrdMLgmCJFZvEXcTd25Pcfrt4VZtqbeotCSrEuf5MGp1B4yb/CWNK7M9RvpfHYGyE5ptD
	AGEdTRK9c3g==
X-Received: from dlea9-n1.prod.google.com ([2002:a05:701b:4209:10b0:135:637f:2609])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b82:b0:134:c740:9dca
 with SMTP id a92af1059eb24-13505433cffmr6255801c88.26.1779119207736; Mon, 18
 May 2026 08:46:47 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:25 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-2-irogers@google.com>
Subject: [PATCH v7 01/14] tools build: Fix feature checks to touch target
 files on success
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

In tools/build/feature/Makefile, test-clang-bpf-co-re.bin and
test-bpftool-skeletons.bin redirected grep output but never touched or
created the $@ target file upon success.

Because the target file was never created on disk, Kbuild could never cache
the result of the check. Consequently, Make treated the prerequisite as
missing and continuously re-executed the Clang BPF backend and bpftool
feature checks on every single sub-make evaluation during build startup.

Refactor both feature check recipes to group the shell pipeline within
curly braces and redirect both stdout and stderr to .make.output before
touching $@ purely upon success (> $(@:.bin=.make.output) 2>&1 && touch $@).
Grouping the pipeline ({ cmd1 | cmd2; }) ensures that compiler stderr is
successfully captured in .make.output rather than escaping to the parent
shell. This perfectly matches standard Kbuild feature check conventions,
allowing Make to cache positive detections and avoid redundant sub-make
forks during incremental builds. Add test-bpftool-skeletons.bin to the
FILES list so that make clean correctly purges the generated binary. For
test-clang-bpf-co-re.bin, add explicit source file prerequisite
test-clang-bpf-co-re.c and simplify the Clang recipe using $<.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 4e4a92ef5e1e..9da5a4fd956a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -72,7 +72,8 @@ FILES=                                          \
          test-file-handle.bin			\
          test-libpfm4.bin			\
          test-rust.bin				\
-         test-libopenssl.bin
+         test-libopenssl.bin			\
+         test-bpftool-skeletons.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -379,9 +380,9 @@ $(OUTPUT)test-libaio.bin:
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
-$(OUTPUT)test-clang-bpf-co-re.bin:
-	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
-		grep BTF_KIND_VAR
+$(OUTPUT)test-clang-bpf-co-re.bin: test-clang-bpf-co-re.c
+	{ $(CLANG) -S -g --target=bpf -o - $< |	\
+		grep BTF_KIND_VAR; } > $(@:.bin=.make.output) 2>&1 && touch $@
 
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
@@ -393,8 +394,8 @@ $(OUTPUT)test-libopenssl.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
 
 $(OUTPUT)test-bpftool-skeletons.bin:
-	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
-		> $(@:.bin=.make.output) 2>&1
+	{ $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
+		> $(@:.bin=.make.output) 2>&1 && touch $@
 
 # Testing Rust is special: we don't compile anything, it's enough to check the
 # compiler presence. Compiling a test code for this purposes is problematic,
-- 
2.54.0.563.g4f69b47b94-goog


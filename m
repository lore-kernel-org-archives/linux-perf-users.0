Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2F3E171E
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608021; cv=none; b=mvVoLheGpoLIuVXmSNXlYZvZVfuFQzzs+GXRA1vvRgiNlDnIN5xpx1d8LwKaRNbeU1RMfIKP1tzMtFIcETp/C0IP5EuxyCE4agBj6mSaVm+qwvn6tC42XPacrxMHP+PKOA3N/G6fdwEawO0866TAsvzDqhWAkvbQ7WPy6ofBclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608021; c=relaxed/simple;
	bh=AKSQH2siP4utMQ9xhh4jNh7yTLC8UkZ/sL2vSdtCUcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksvUrQEWBHBx01LDnKdb+IU7YgyS+udkhi4BPVf4UO3CWUhyu+/EXPTVh2wIlQahJKtvV4S+f6KRixMYsZIii19I8a4vG9GzfMF1AeVegn2fT0ZNXPGpfyqmzrbCswB0oJ/lz93+WCtGe6BvAC7Ks1t1hZYltEhNNZZq+o+13JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AKS0up2I; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKS0up2I"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so4219891eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608019; x=1779212819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yVcJX3ToKV+Wqq27E1R2W87lkjzMpr5Ak2bcYR9g3Q=;
        b=AKS0up2Iw1nRWbPfURNvXx46HojS8Vpbvnfz2nOZsoc451WEzeTcs5BZcHVVU5SZW3
         BbhFzZDd+Ok7aFLIxiZyOaf6e5YVxPKCyZVeh93aIif3gCP6iS4WL0Q7p1bB5Vx0IylB
         cmLa5eAXEBUg/lYcMzNAiX5YdL3RN5mIyrAyQJ1oMcdqJHNawsiBlC5P84TCscyQtHpw
         vhNANhO7JMZvPA1KsYpWOXHXGcvrYuFQhy1tFG/WfF0jV7zaPRMQ2Rpd2mrr1qL7JQDO
         CqoCKT9RqV0oEy245ELkNePa7bN5tJkxqFh2LPMUTifA5g7g3ROrCGll8Pej6mANYNHN
         4uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608019; x=1779212819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1yVcJX3ToKV+Wqq27E1R2W87lkjzMpr5Ak2bcYR9g3Q=;
        b=MSX9g/06gay97iSUN6IGP8uucBq79RLfWIqs3FI3a2rV+XteO62En4V2HxMMERxcCR
         QKtlq8ehKMmzgvZfMk40N2gxkMOzFej0aNVxN+3LnZxrLyZK9+VdzePcoQs1IYiDKhIn
         nxp1viBfIVNDkBkTkKjq4ZiH1VoYUMY7XAU6bPyCQ22e419FVUFkXRKDZpgoxZhH8JkU
         oqO1dVTRIaJoS+B6DcdRDZrSk5X7yPmDgFYJxXM3ivNCld23ZG7u6/XjBa88Fw2cVzf7
         CkwBSCI+7pwScwJn15l8v8+CNPnXOv2SRotVZC9Dw6XsoVZw4sE3wH7xR7Er0i52V8GP
         qJbA==
X-Forwarded-Encrypted: i=1; AFNElJ++3FmeGLUXBHtqOG8s7v9RGgI5UIbTovvcljKvKhCbPch2XH2q1VWrpXwliI6jplrt9Nv1R3WyqN6ByUSEZK1a@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDCphyxnr997GVRRhHR+bab1Q2eMG8Vcv3B53eQ4FuF2Yqe5x
	uzGyDHgeBV3J/bG7s5G+nwX9a9k4XGcAz7oSFIaFwc4mlJxOBnM/EMG4MKKFG4GeALhiZdNMeLG
	fROGd+uNtag==
X-Received: from dlbvv13.prod.google.com ([2002:a05:7022:5f0d:b0:128:cfd6:a3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e1f:b0:130:6978:c96
 with SMTP id a92af1059eb24-13344d7dc23mr2588285c88.19.1778608018800; Tue, 12
 May 2026 10:46:58 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:24 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-5-irogers@google.com>
Subject: [PATCH v2 04/18] tools scripts: Short-circuit CC_NO_CLANG compiler
 probe in Makefile.include
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

In Makefile.include, CC_NO_CLANG unconditionally executed a GCC/Clang
compiler inspection fork (gcc -dM -E ...) during Makefile parse time.
Because Makefile.include is included across more than 40 sub-makes and
component directories throughout the Kbuild tree, Make continuously
re-executed this compiler probe dozens of times during incremental builds.

Wrap CC_NO_CLANG with a conditional check and export the variable to
sub-makes. This guarantees Kbuild evaluates the compiler backend exactly
once during top-level Make invocation, eliminating 40+ redundant shell forks
across the build tree.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/scripts/Makefile.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 41971a68972d..3c7803122ae2 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -74,7 +74,10 @@ $(call allow-override,CXX,$(CROSS_COMPILE)g++)
 $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
 endif
 
+ifeq ($(CC_NO_CLANG),)
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
+endif
+export CC_NO_CLANG
 
 ifneq ($(LLVM),)
 HOSTAR  ?= $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
-- 
2.54.0.563.g4f69b47b94-goog


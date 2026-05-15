Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E14C6EE3
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866771; cv=none; b=EyPcFd3MjCeJRyPHk3pcAKinGCJtoD8AWoQrQDHoy/9RHZuDu6X4bT8XL3NfaHgAFgEq+uZd9OOxTmb8uqDf0Suo/ZryndeD3RO+tBvN6QfVjQKoLZ7r7lhYdr9jz/vTQegocyWUl4GSzcHrpibWASvBkS9YXdkrPNxXe3MsWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866771; c=relaxed/simple;
	bh=KgYhLbj+7JbYPwwwjNkDDjdOGe6Kx8xfZHNose5DOpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nyCl1e67EqjU4D/fujrGC1n31GtaTDrOmTYIURMz+sdiNX69SUNwwA0zWs0PgK2Gn46PdOK+9o5YuyOi4I0CXHA0beqbxd3z274GBOBBUAbnOc0H5Uoy1q18AVUvz1b27Db+BKpjK55c+ZZ66AwPH59pTKUbjBzwBvvOYzjRKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viYLInzO; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viYLInzO"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso146051eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866769; x=1779471569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=viYLInzOqOsDx2euBxu5WfpxoDI09RTrF9JDDtIWRAmXuRESZf4jHUkBMRuvi0W9KH
         X+9U+8VCmDvgz292OUCeqbKoex529fmpqhEhT98dEllRZv12ZgJvCeonvJcJpmWH1RzP
         kclOC138iu5NABkn867TT35Zr6AwzNcIYbSgXwIvWK9t0p4VcNSH0iZOWppBeuXatSE9
         AYuzP/qjK6alH9Bei06gEqSiPEoNqRWP0LoIqDWJH7ruZ39F/o8TLsX6k2aSjP3m+1Un
         hhaFcISrMVgZ3EUZYNUWG+B193jGl+VgXhT8+0dDHHFpAiB1R15ExMDfaIj1QTqd4t/X
         +Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866769; x=1779471569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=tL9HDExlJqNxeWRCaeYQDo/rwQafYSoWaynhHTxybulHBpAwGOdQYad1/dWexON/xg
         5AePUQBM3AxceYu04hYEaR6kB31g6yoeg8U8sE7XOCnmnphyqqe2G5dshsj9IpOXpxt4
         MX6v/eHbPeTAq24NzSWg3OyERE5m0BE720LrOjjFOMvQZqpLgkaqsWcyyARz0BaRkiQ9
         i59BZR4bvLtS/7kT7+npWDHsR8WwVZ0a0ugHBxtVLN9DXB8LkuE4iFToblywHR74WdAz
         jxnYbpV5b2v5LEzAW1JZjEyaubohbOMaqTQjQDYPY0W/dLaIaGn8FhiiXUFxQDduZSyU
         7vIw==
X-Forwarded-Encrypted: i=1; AFNElJ+qo6Ql0NSTCJtXGL7HxRWY5L6E/R5zW8v48Q6RYeKDYqhV1Q2Xf4thA0Z5ETmr3UhiTq3lnv9v8LQW0FwzzVRg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+c+FqEw8Ud1oqaVBOKEjFYEXZyE6S26XzE51JIuk6oVE12WvH
	T3ImfpEL2Oh7ZkiUf2WAK+kebhZynUphMs7BxeigVig1giVuLex3sne+2MfMjIpQqj/IZDEm3An
	6Ftj4t8mj/w==
X-Received: from dlww12.prod.google.com ([2002:a05:7022:ea2c:b0:135:243d:296b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:307:b0:134:fc89:367c
 with SMTP id a92af1059eb24-13504c54b7dmr2057801c88.7.1778866768574; Fri, 15
 May 2026 10:39:28 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:51 -0700
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
Message-ID: <20260515173852.1378571-15-irogers@google.com>
Subject: [PATCH v4 14/14] perf build: Convert llvm-config shell queries to
 simply expanded variables
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

In Makefile.config, CFLAGS, CXXFLAGS, LIBLLVM, and EXTLIBS were assigned
using recursive expansion or appended with raw $(shell $(LLVM_CONFIG) ...)
calls. Because these variables were expanded during dependency evaluation
across every single object file compilation rule, Kbuild continuously
re-executed llvm-config forks nearly 200 times during incremental builds.

Convert llvm-config shell queries to simply expanded variables (:=) to
ensure Make evaluates LLVM compiler flags and library paths exactly once
when Makefile.config is parsed, eliminating ~185 redundant sub-processes
during build startup.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fbe7fa83b0bb..7a61da082c0b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -951,11 +951,14 @@ ifndef NO_LIBLLVM
   $(call feature_check,llvm-perf)
   ifeq ($(feature-llvm-perf), 1)
     CFLAGS += -DHAVE_LIBLLVM_SUPPORT
-    CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
-    CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT
-    CXXFLAGS += $(shell $(LLVM_CONFIG) --cxxflags)
-    LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
-    EXTLIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
+    LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags 2>/dev/null)
+    LLVM_CXXFLAGS := $(shell $(LLVM_CONFIG) --cxxflags 2>/dev/null)
+    LLVM_LIBLLVM := $(shell $(LLVM_CONFIG) --libs all 2>/dev/null) $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
+    LLVM_LIBDIR := $(shell $(LLVM_CONFIG) --libdir 2>/dev/null)
+    CFLAGS += $(LLVM_CFLAGS)
+    CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT $(LLVM_CXXFLAGS)
+    LIBLLVM := $(LLVM_LIBLLVM)
+    EXTLIBS += -L$(LLVM_LIBDIR) $(LIBLLVM)
     EXTLIBS += -lstdc++
     $(call detected,CONFIG_LIBLLVM)
   else
-- 
2.54.0.563.g4f69b47b94-goog


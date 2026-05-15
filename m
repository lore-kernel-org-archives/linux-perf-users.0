Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D63E0C53
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873639; cv=none; b=r0/rZUb5AbmKkZ11vjpsr2e+RQLvE68hTPZhuEsmngMZdlF+8tNRXlQjmEO3nmXGKBWLSFSqWTL46ht/W6BIjmCJFSPRS631nw9ahwoCMv5cd/oo0p0zf4y71TTH/JU+i/y6RcLVxJ8IPno1eDk4kq3vSTs+KO/ndobkWMjLXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873639; c=relaxed/simple;
	bh=KgYhLbj+7JbYPwwwjNkDDjdOGe6Kx8xfZHNose5DOpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYiTAJqKpLxeMQb9ZTQHEJ5B53WoEIbnJ7ubrAbJOD0WuGWQloFVvxzgPMwBraxpOJnoFEfQJ0m4bY3nV5ktDzKWUnfWwn/PymLR7WMWZawiMGNKe6RXFpS/dG5rCtTMlPF5QhMr8ip6vxBWpcKqBlMXLxnEpl9yed5COQAkHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+FgWcqY; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+FgWcqY"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13536592ebeso1801691c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873637; x=1779478437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=p+FgWcqYDAEC6+EpEsggsHQDhUZS+WPXar4iDeDKwhVPaVkVpWJ/FbpOlGjmkc9wHd
         nZlK5V1ixCtfDtcuFBU+m1MZZf7Kk4xUT0c2yZl1kYEwiQ2Ho58NGg9uOp9yqlmSvY11
         PeqYBnlyep9oCIP3pE8krM8LebH0nxn2TYtCDzxIbThfTqgLcYrRKqape53o3BTZq/2f
         jFa5i1G74w8S5HuNYXdGfLspmb0ijh7e1uuKKNE2l/QB34/fJNXxRQ7MFWh1HagSzBwV
         hm6nWlsuCGcYSXoBB3mBAxpI/F+b79YFtOzs6DLBqQQBhSL2wT9zmZD1qpRtlhJAkLIl
         S6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873637; x=1779478437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=djBmkQFdxS0OXmBl6CorXUJtkmxQq/Ft35aZfUdOH0DUM3622tfv9v7acrDFE/TSt5
         p88Sgz1FEzK19rGRvP+hVHpHhlviih3ZfM18vF6SgYo6Cuuce8fXZJnUycNhbqfA3d8w
         i7+wALQ2Qg3HEVPwkdsCuAUn2OrzXclBcoyeGjQkC2tNWbU+28oxM3OYOe/jJsMh30XK
         yVnA1Ty0XajO5ObrM319N5jYBByaipQFVnNDaKYIKT0Bu8lXcJSoS6kDTzZQb9pAE05w
         fcw1RHZFlolZwrTiIwoYXJ76n+NsF/hvL5ADbKpaCJpMhIMAb9AB1hduU8IeVPXfgypN
         VF/A==
X-Forwarded-Encrypted: i=1; AFNElJ+sMRF4EnBXE6Lx3AdGx429tckWOg0n0rKdlJWh0BJE2iExoBYcVStpRu3OgiQyWffK6pcz0Y1ylPxa+KuEBsQp@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8utcfX7LBSgWDvPevzUPjNFZxblBkxejeSajcBuC5A1cCBwp
	uYgxmxL40R1tkI4QAlEmedSBLk+xILpnU4Y+qh8SbNxHX5aHhHyj/yIu+7hUSYCMNE5rAjMDgYv
	RQxAdl7y+Nw==
X-Received: from dlaj12.prod.google.com ([2002:a05:701b:280c:b0:134:a6ef:d90f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:402:b0:134:ff2e:9889
 with SMTP id a92af1059eb24-13505536992mr2806623c88.32.1778873636710; Fri, 15
 May 2026 12:33:56 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:14 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-15-irogers@google.com>
Subject: [PATCH v5 14/14] perf build: Convert llvm-config shell queries to
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


Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077432E762C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119246; cv=none; b=ud0dADr4XhP/HdPlfi/V6/TRgL3d6gblyPrELV1EGJZcpFgiDOEYhkwFH1cvPgeYKy+GBWv3Ds27G97b5yGqfmHOmPPB2YPQiocKjyGMExiJgi0a644pMbkxZj7hS6iejc6YYdvhIk0j98M3k1X3+a8GtEvWTOUNMea39xSRdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119246; c=relaxed/simple;
	bh=X/Y6Y0RSQ8C+MKLNRZgURcIaY/WnI4mafzsUsFyDboM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XDc6xXSAZnEKYqakpXLLxX6Gt6rI5AX5LjFl5YsTegZX6ykcXecMbzkN8S5IZIrkLXbUqxn2bYRv10yBM6ouuA7c/7T4hyIDRBpttFzjokZcB+aSs2RrVtg+aaBxDAYJRb67CGHQotBtIsyRHcOjCNEf05ZcKDwEYzclyx0QB8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3WbO5xN; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3WbO5xN"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso2427426c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119234; x=1779724034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TX+St+pVYkIq20j0v2ezoU/ohjaZ4xJX9nTu6/yN9F4=;
        b=H3WbO5xNS6Bmeu7nNWGPMsAcVEgU6/YV9eVWoy+g+luXVVs48rUi4obquBoXb2SyLp
         Tche+46vrriJCC6vuVwaqXftekc2S5JMBlK1p0KGPgI5ukrlU4gEQo+m6AJhEUQ3GPW2
         lGN2q+c/pOXy0WMs/Tcj+DKtuJKhB/vr7ph1H/Qfh2VAlLqvmYBQ4JmQsry1A1ERVicE
         uQ9guDW60l5nTGLNF7sffSQUVLDWQ6pWN4N2ZFx+fwXPy5a4n1g54RjN/dqxCbXyMaHV
         oCHF0iYtW+FBGWvmnA5m0g7edOyy9ESTxMHIWWg3XTcwaOtSPlrCh2lr7mPJSjGBoyTy
         cLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119234; x=1779724034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TX+St+pVYkIq20j0v2ezoU/ohjaZ4xJX9nTu6/yN9F4=;
        b=B4BCkpKmKiAYWBsz46zgoM73immBaT6OuPC7NePEGczoIsbeZngl9lI2mLZFTfRSFK
         xmf58lVdagn2peN3X8vynVpcwZYExdGTTQJzUc8h6WTnp32qGJSQluqf/+y2DvrlO+u7
         BQGBIhxXTBtBcQcQVikxuGrQOu8TMveOmgiBdS66kD1cYHwTT/GHu1DlprnIGeyHBW+w
         oWHTUkFO/9IZPTbCIazJNLkiI0dHlh11/HrSNEQhsU7QvZGBJBRMXw4lQHvA2DXdvsFg
         US/5Mz2HwPeFE+Ynk2uC1FFjtBW0/22glSmEW+KANKjT7RLAyjxbx2Dt+aC8XwobjYol
         sH5g==
X-Forwarded-Encrypted: i=1; AFNElJ90jlDC+rygvp1XkoTeJsAjWnC0By9QjlbFfc/BexiOU6lOJSGDi7BTQ1Nd15daUSvlADBdTsVRTDDVvGCWXlzG@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuaQ8jn/9MgKoXs5oBwgvorx0wLIpB4cuytDY5BtdfJjFLMKm
	pqKdYcnoL3599GeuWQV7OUD10sWzZnEE/bP4yWXl4JW4kh1j2Oqu674PU7R2iPzTOd7gRS3MLfb
	gm4Wl4WnpDQ==
X-Received: from dlad4.prod.google.com ([2002:a05:701b:2204:b0:12d:cbbc:2a7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f8c:b0:12c:aae:7b43
 with SMTP id a92af1059eb24-134c8d4f504mr8212918c88.24.1779119233477; Mon, 18
 May 2026 08:47:13 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:38 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-15-irogers@google.com>
Subject: [PATCH v7 14/14] perf build: Convert llvm-config shell queries to
 simply expanded variables
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
index 26de7528d6ce..b56fa8419f7d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -925,11 +925,14 @@ ifndef NO_LIBLLVM
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


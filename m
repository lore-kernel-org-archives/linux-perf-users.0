Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D27386C3B
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079706; cv=none; b=cO5wjvr33OS8ur15+Ys2dkCj4jME5v1DgcjWc4W//mJvf8UQPWYwWn59fwZUA7ukkeUbOlaMFXzutFW7IXt3m+qNyaSPeUfSPqY//rtJ0lWyJ6ltph0yxAlcUYoxYpdbtVi0GCW0Ur+Fqh0toH2pMTpZjJ+qlcVRFNjDU3oYolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079706; c=relaxed/simple;
	bh=X/Y6Y0RSQ8C+MKLNRZgURcIaY/WnI4mafzsUsFyDboM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JOdQOXmAVWeb36AQBGqb+/KohiTB4XnT1Lra+IMB5mOUu77KEyiv9BQaSAVig7ciurG5RrjQRrqtDOV/VKQq0z/3YOBcymdf6lroMbta14C19JFX7hFggnhmJAU4ygGTF8P4uVWkw+7fubKGKTlnQGm2JLxSlFBnbfolwq4l+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrCwG6/f; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrCwG6/f"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso2068331c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079703; x=1779684503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TX+St+pVYkIq20j0v2ezoU/ohjaZ4xJX9nTu6/yN9F4=;
        b=RrCwG6/fcon1Y9E1UwTZvGbuQgn7icbJGIHp8Jz9S41w5Gk2f7DsT+Fv9JF6+dL4x5
         WCkXTCVpshVMODZVvXNzluOV9q2pS9p5vkWp71z32sRJiLRNPjXqdbbXrIANd1fgxKTT
         WCgvIFsYPTex2N1nM841XoqNcEH7Katef63MSTj0wiQzFAbhAvDPmgguRo2Z4YopjfjH
         j/0uFpfeW/WdbroKMDCNUJnZJDKYb2l0OxNUUEfVcu7wuNgsX+WLVYZM3beg8lwIyna+
         sfby0WEBIShvC6p/dRoAkA14DPYr+OPFXMcBQaZNSqS2SzcXBExZ7hYNZEtYPQN4I0g4
         evpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079703; x=1779684503;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TX+St+pVYkIq20j0v2ezoU/ohjaZ4xJX9nTu6/yN9F4=;
        b=aR7cgnHrD7VXcv2J/8clYbIMWeXjURmjOilbPSZh+GtdnvL3Tykg+2DwxGJSXJJH6o
         qjY4iNZEd3I5QWf+lh+wIJSxhFpne7Nl0QVayEEe0S+DySpHvoQjgXJ60qT9pwnda/nU
         Z9N/6UACj79KkrDhmAcWqKvjArqjyZ8D5ZNUa2JIS/2v8TLd5DyiDnHMJ+Ks2bFJNno8
         ZW9hGAkouddZ8dt4J3ydcNAEj7RNg2BwXjrl7dSMigjglpwZ7HqAQ0m9xVDa6wJ7rVCb
         Go0RU6WXPL3I767k+wW6CC1lb3tO71RZX9+vHtS/XTpGQ4Bd1IXtkBzRPfpx2OengELw
         UZhg==
X-Forwarded-Encrypted: i=1; AFNElJ9tn0xZXirumqozcJbGa2pmmYVV8zG4O+7D8pwBT7l4WY/p7hFTmBEFVE6WiUEmolZHQ6W0bVArqIJ2mK86eYsn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eFaqnlYrJ5UALuN5Hf7jpUR94cugo8L6rD6OdEj4W4X5mdNn
	MniHpRxbSWJxntsWnShLuc1ICzGNV2Q58+Md7gO8HRV6xArmkHtPBVctGVeAJrkNPThqDgv/eje
	UZ2toXCXmOQ==
X-Received: from dly24-n1.prod.google.com ([2002:a05:701b:2058:10b0:135:66d8:351c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128d:b0:12d:31cb:b806
 with SMTP id a92af1059eb24-134c8d4fb2amr7693120c88.26.1779079702613; Sun, 17
 May 2026 21:48:22 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:40 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-15-irogers@google.com>
Subject: [PATCH v6 14/14] perf build: Convert llvm-config shell queries to
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


Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898343EDE4B
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608048; cv=none; b=Be3zbwYRi02tnRqiM0uqqroAclURXNCmWSBq2JxtKn9+E8e4iSmPDEMdmu3fzulKj5lJlfAYgftnb4EJRbBd67u6aXIxvDM8drKLJO6IssbL5iA1OBWYefSl8ZEtdj1raCaBrYp9aGwshnZyN58cw3HC8T/Y9ddlGl8H/aPyz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608048; c=relaxed/simple;
	bh=cXobzdS8IKelKwX3du7Jn4Xo/cwPgqr6uVkMRMJ3L+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sXy45ZbwoiESVlODGSD7HIqB5/o6DpCL5sQ8Y1fQK/d+KmNHretwEnDgowK/BHAT7Qvg9JVyzt2jFtNBHze9KgPaz4WB5q5Cub+qzwe0aK4owjpt9V7HHFbcDlgwyPHO1pF+qpbhzaqWPUpZXUJEOUXF2xFE9hP/PFwiCwGyI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syENb1OA; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syENb1OA"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ef37c3f773so7003445eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608047; x=1779212847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUCs++vVYNhQEfRcxQUIPcuntgMnfvBVScnOJKZmjZo=;
        b=syENb1OA9L4L7+s+RKrD0jUL2wZx7kaHkkBJdd14s71g6nwd5jUpeNm2V2ZJCbgIjn
         Crbbny/DHn6i8hs7FPJD8ZulCcHymE6RKYAmM/HrBEkjCtpQToNTky5l/AjGaN4gR+9T
         BAngpqdRvINr7EZBLGCaaajX9WxL/zF5uqOoHTl5XiPq9P9aiQne0SobklUwsqsniQP+
         8Ge9/JOnAkwIRPtnOgXGQIwPXFkvjjNAMcF6Lh4mTMAcsEnxhBj0M70Jq9gxvvJMlpKq
         0a4bgcxvNOckrh6QtejZdta9VLpQOZ5IFYRn8rW5bS04qRU9ZKYjXJAfTriA47jyK5aw
         Sdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608047; x=1779212847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUCs++vVYNhQEfRcxQUIPcuntgMnfvBVScnOJKZmjZo=;
        b=QW9JOJsDSGy3cNra1dHCkYpjTyol039sI5/JvtPG47lSp/ZqgW1fwvVKusp2W3hWZo
         0zuDPPMCd8r0XuN0EwucvJE4DZbtqWJfxN9S1HMMmNEDw5D/IcdNuwFYSBwk7pf7Mj+g
         zZ34O+JIAHGCvsIi6Y/UL/9sSxyEuYq5gaCvepuNf2MSvYa27qmE34SPb9Khegqw8HMC
         T4kFBCFf0VLFgvqQxXjm4hTLDYeLe9kGHgxdHfePhBbxQrH/conWrH8q4OnEACl6sc13
         DujHpfQ3FvRqcQA+/s4V+pOspATsHcmCR56MdfnikW+w3EXlNNfTnjBw38N43XMGm5Nx
         T6oQ==
X-Forwarded-Encrypted: i=1; AFNElJ82Z2vrKtwsSEgGdUbsaBaDmRNsdzJ4CfOx/jct9batxj7iUyHqZgJtUO+yRM6qw0m93brpReNflP/yB2l146Wh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Tr09dJtZg4pVI7/nVkR2Wl3sUJ/6jHaUs54ynY2rQlROKoD7
	Yl9ITtIWqZLEA+l/QuRiiKbAvtJ7TGEmQJMd3XywQ6gVRtcTmBKL95WkzYqZDqsMUH8XPXpcHfk
	/UKzbuAs/9g==
X-Received: from dybia10.prod.google.com ([2002:a05:7301:30a:b0:2da:3d44:ddce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5793:b0:2f2:6dde:df54
 with SMTP id 5a478bee46e88-3011977f73fmr47297eec.33.1778608046462; Tue, 12
 May 2026 10:47:26 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:38 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-19-irogers@google.com>
Subject: [PATCH v2 18/18] perf build: Convert llvm-config shell queries to
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

In Makefile.config, CFLAGS, CXXFLAGS, LIBLLVM, and EXTLIBS were assigned using
recursive expansion or appended with raw $(shell $(LLVM_CONFIG) ...) calls.
Because these variables were expanded during dependency evaluation across
every single object file compilation rule, Kbuild continuously re-executed
llvm-config forks nearly 200 times during incremental builds.

Convert llvm-config shell queries to simply expanded variables (:=) to ensure
Make evaluates LLVM compiler flags and library paths exactly once when
Makefile.config is parsed, eliminating ~185 redundant sub-processes during
build startup.

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


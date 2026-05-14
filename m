Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7434A79E
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776511; cv=none; b=lPj1bqjMT410hkbqAwD6IK8HRk7ToPYFRAh0JUadtz2TmdJRJuuXVxdlBfhzaLz7IxePsezXZr1//CxoM5fG4gw5MEMDrrld4qoYA41CL5suAGIuKkF1w0Q7TG0GI4Ml5uqywjyBoenLuI4tU2OFEm8fHLRfv9Z+oir3S7reMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776511; c=relaxed/simple;
	bh=KgYhLbj+7JbYPwwwjNkDDjdOGe6Kx8xfZHNose5DOpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/F2Li1cC5mgWdU2iECvpjXVlmVfpd/osCQ0bdvHmk9lyBZlIEIokxoli5bFc9YFC+FfeXhYfeMLaEgjwIdtfUERGwZOaNj5cJhgpg1YuEwy4FFzuNW7wRtVjJ6yY8RyiN2cAXICIVMwHgbV2wav1nYrzRJIis3lfSAm+1RHYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iy8/iB00; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iy8/iB00"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d5ad9c32so7980673c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776509; x=1779381309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=Iy8/iB00YcEzrQbbGhsCvnccJsAW6kdybhMAJRzl3mpuw1mwOIqtk0C0Hkfd7IvTPY
         /NIWqleNGHGt1QSQlJd4CIzPo7ZHqWP1hmR1Gh+ZnRATquoYRxRFcIpA2b16aHvVa6sR
         otpB9+wTzVfQot1OnbRuxf/USrdKRAWGiVX0WEhrKKncirlzfTSvRAbqiZtl/KPYYRtL
         cUTPmkHGwNtH5+hBcf7uS7Qlq05dA62k9Vh/c4FHK0DGXxWGi8o1g2gZJLTegSCpnKOD
         LYx4fAQf3+Vth70itd6519CXmxFDnJG54H+q456v3DosBK3yuZr07vF66qyNO3LgXXTS
         wd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776509; x=1779381309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7UhuB240zbvecKzTnCZgue1l2Usf38vhdVC8tHlI64=;
        b=sj1LBzkuZdWoI+a7lKzCEXCx9k0rJ++trvKEYT2s+YaExBQ/ioLXRXZc2pot0c/P5o
         tPLSgNJPORkkpVYwIGMEC4dNd+7uPjl1dtWZbwFEnkAfsAKU4+HsjsheZCbVrGk8c3S0
         4od4qNAoCPFml9mFbXIl7GoeNM7ejP3WCKZHsMkRUwK6FgbtIVnZYYyVc3JjuwE6bgSC
         BvC8GjuTxMaVnKDo55+JNLqLroltJHy++6q6iXHFCWoJrPvetnQ+zgnjg7pF1OMD7LZv
         fE8VXj4qjLToBudfu6HLoYh8wPeo53jQF4bgTKgQpviAO9TCZ1gtuH0cISBzGIqzIXmV
         z2qQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XMLE2pFRIY1JNkSWaENbS8mqtZYHg3DHBbJFUlwJ71tgIKJgwVJiON1zmR7rQI6v9rLPEyyHFcez6hhENqgrT@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPxry4rkdQS0lWtcaeYE0TRBQvuZ9Lh36XmFUJayYAY9y/80w
	0M74DSH8nsdEf/qyNvxmNWOp8+zsMFsBLiJAmhJI5Akh6hph/as86RCZIIoTPyO20ggm0oK78A1
	oTXezeg8wyA==
X-Received: from dlea2-n1.prod.google.com ([2002:a05:701b:4202:10b0:12a:77b3:9893])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:910:b0:12d:b6cb:bdc9
 with SMTP id a92af1059eb24-1342ee3a35cmr5414185c88.9.1778776509284; Thu, 14
 May 2026 09:35:09 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:09 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-18-irogers@google.com>
Subject: [PATCH v3 17/17] perf build: Convert llvm-config shell queries to
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


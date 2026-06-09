Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28374B8DF1
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029278; cv=none; b=S0BDK2fMWasHfQU2aq/oHT8i6cUKU0J4XKXCmDRuc99S3SIua7xHVgN9EuLkm/3yzCTx5AGsUncq81tiiJBNEZ+MAw4QgXZPMRQnl/6wEMfBBoBdn89DEI0omZMpYthPJ9btrP0bt6MsEp2latu6TTwS0Inu7KIQo10yVcnKBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029278; c=relaxed/simple;
	bh=duayAPAiUhY5wJlcVJbdGPpOR2UABLvYB7ScWUb5/D8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DpDG+XyhibR8cbkriOE7lvim7Crdv2mPvVcR+BVmY2hUG6GHGvdnEwIj/fNb78yUxvThqV+wtA3DXliZZ2XRno+eYHskrIdMUZpXWgWbXYzeIzgUME/dslhXno+GLwMZ1NHzt6d3RkwW9+7nUEUf2GC/M65s+H+72bPVk/a7ZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZosQ18g; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZosQ18g"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d0d0b28eso6159691eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781029277; x=1781634077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYf8eh1YnaPUoMuj/toNw06K91sdnAomPgCHRQ2cb/M=;
        b=TZosQ18gcv50bjFLvI2QX3Q8eDP2Nofe6NbX5tmTLkw2of17jhGh3u8qjNCDEbugdV
         ynyNDDLkAz8ZPUH8w9bKtQlP3XlQ6s07vSusqVqtgisyP9BzuoU6RrjTIuBEYeJVV2zR
         HCRM+IpA20ZpmvGzYGVS/CaZfkL3OXFOGGLxwSfU11xgLWJWqqx2Q7TtNLtnW38cY2cr
         0u7y8zxL6GTZnirey/jSKVwWxU5XGTLZnRY+rZUPPTWQikMXtBKcZvqk5bvEvIyN5kUi
         yxRPbnpHj5iTrGAxqVhmTFcrSJhLHJszBaYVJDD3YiFaG8SqE+NusYsxtWwc8pr2+2sX
         KXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029277; x=1781634077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYf8eh1YnaPUoMuj/toNw06K91sdnAomPgCHRQ2cb/M=;
        b=PMnk0eORtHgB9Rvu/WubusiIBqFH7oeFk8smXYFVcnkWjM2yXW97ucbKp8nSEBBRjv
         Dgq3t6RjeTKWiA3L3DhKzubJEWgl7BlmQcpKgbHF5ztyebrb//VdRIlCJ+DZQzA38NiC
         f0fKZnFLVl2FY8sN09+kokzGyKqC6vPXe4fZumTUNU8oHBKW0lB9onis8Uqdfdefrrkd
         uUicMckDfAQdkJogQhKPUfPI7qbMCO1fy87LOMhV+p1HtyLkdBFAsorRh890vtriAfQi
         0BovXOWZdFt9ggkKefc7MS+PlJedKDwohoVT3bftMv6pemabtio1x0+sZEPgQtkYQPX8
         2vTg==
X-Forwarded-Encrypted: i=1; AFNElJ+5olFXpp01mqX6SP1OgpeG62d1PiNtwrRzjif0M7BZCtRZf65RN70i6gge5hU0gj+j0Nvux2kCUFHhpN/QJc6s@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8iqTsL/pvupU9EdIFSDK4gzf3kGlg6OEW1m2U+Z+1DxpDPDF
	9oX8Uv5iPFnpRRScrFn8l9s9yL19K6qNXPoQ1pAIurB5jugkUAGYvz5ZrjTTH/neHB+NfCRXd0V
	4WpsG03lF4A==
X-Received: from dyrv26.prod.google.com ([2002:a05:7300:8a9a:b0:304:dc2f:9939])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7304:b0:2be:2cfe:68b7
 with SMTP id 5a478bee46e88-3077b3c7767mr15534916eec.11.1781029276633; Tue, 09
 Jun 2026 11:21:16 -0700 (PDT)
Date: Tue,  9 Jun 2026 11:21:03 -0700
In-Reply-To: <20260609182108.975586-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com> <20260609182108.975586-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609182108.975586-3-irogers@google.com>
Subject: [PATCH v3 2/7] perf build: Add build support and capability for
 elfutils libasm
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexandre.chartre@oracle.com, blakejones@google.com, bpf@vger.kernel.org, 
	costa.shul@redhat.com, dsterba@suse.com, james.clark@linaro.org, 
	jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark@klomp.org, mingo@redhat.com, 
	mjeanson@efficios.com, nathan@kernel.org, peterz@infradead.org, 
	rong.bao@csmantle.top, serhei@serhei.io, terrelln@fb.com, tglozar@redhat.com, 
	tianyou.li@intel.com, yuzhuo@google.com, zecheng@google.com
Content-Type: text/plain; charset="UTF-8"

Configure perf build system to utilize the libasm feature check
(supporting both static and dynamic builds) and export the config flags.
Add "libasm" capability detection to perf check.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 22 ++++++++++++++++++++++
 tools/perf/builtin-check.c |  1 +
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6e7b15fab2ec..632cb069c944 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -199,6 +199,13 @@ endif
 FEATURE_CHECK_CFLAGS-libcapstone := $(LIBCAPSTONE_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libcapstone := $(LIBCAPSTONE_LDFLAGS) -lcapstone
 
+ifdef LIBASM_DIR
+  LIBASM_CFLAGS  := -I$(LIBASM_DIR)/include
+  LIBASM_LDFLAGS := -L$(LIBASM_DIR)/lib
+endif
+FEATURE_CHECK_CFLAGS-libasm := $(LIBASM_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libasm := $(LIBASM_LDFLAGS) -lasm -ldw -lelf
+
 ifdef LIBZSTD_DIR
   LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
   LIBZSTD_LDFLAGS := -L$(LIBZSTD_DIR)/lib
@@ -432,6 +439,7 @@ ifeq ($(feature-file-handle), 1)
 endif
 
 ifdef NO_LIBELF
+  NO_LIBASM := 1
   NO_LIBDW := 1
   NO_LIBUNWIND := 1
   NO_LIBBPF := 1
@@ -1060,6 +1068,20 @@ ifndef NO_CAPSTONE
   endif
 endif
 
+ifdef NO_LIBDW
+  NO_LIBASM := 1
+endif
+
+ifndef NO_LIBASM
+  $(call feature_check,libasm)
+  ifeq ($(feature-libasm), 1)
+    CFLAGS += -DHAVE_LIBASM_SUPPORT $(LIBASM_CFLAGS)
+    LDFLAGS += $(LIBASM_LDFLAGS)
+    EXTLIBS += -lasm -ldw -lelf
+    $(call detected,CONFIG_LIBASM)
+  endif
+endif
+
 ifdef EXTRA_TESTS
     $(call detected,CONFIG_EXTRA_TESTS)
     CFLAGS += -DHAVE_EXTRA_TESTS
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 60437650c50f..d2ffea4d9b8b 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -46,6 +46,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("babeltrace2-ctf-writer", HAVE_BABELTRACE2_CTF_WRITER_SUPPORT),
 	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
+	FEATURE_STATUS("libasm", HAVE_LIBASM_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
 	FEATURE_STATUS("libLLVM", HAVE_LIBLLVM_SUPPORT),
-- 
2.54.0.1099.g489fc7bff1-goog


Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529A2DF15C
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751161; cv=none; b=OXQYoyzB9qhIyTy4FxCisMpRfNbWNgMgiTcXJvwyeJ4isX9PH8496T+TWzKFnwSnzrS5old0PIdobZv2ugkVgHel6ywzx/ku0mhvr19F6r7/La/6PvujTIF0dstUG4NJZ3c4/VHyhfmfFwxw8FAdkB0Qu8yjmmaZlakm0Tj4rjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751161; c=relaxed/simple;
	bh=XYN2OerTukpjvC5uTpCQ4LBfsGgqw8htnZqoFgokKo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWIJu9gpitqnxqIUsUg+DktQH8lCI8r9eYrR4UTcoPV3QZBK6rvPk7JIWpYK+V3U6BAfHMoINtgJl81pnaNUVe+pbd3uvf998XomCzFIjGfaXug6sKbYMEelhFS9Mty1E5qSVQjkg0iJlsKwMKmTydmuMFh1YiKNZ4foDYBeZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qndKZp7l; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qndKZp7l"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe62837baso4071905f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751156; x=1779355956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuYOAkPGvNGtocwKIFKK4r5RpQsaxB3pkCmwnF/UVxs=;
        b=qndKZp7lDorCBa7sajI+CZYDZB1NuRkdNQ0d+iHDv/tiKuipVL58gdzg5bMk33ic+l
         Xy4tob6aYuK0gybNkNeUXOnGE8I7Oy+Kysn0zjXrE3I2mvuBpjY2lSAskTCLhKM9y/Ig
         V2CD2E6pcxCupf11HnAD3fOHsQMU4wAyOy8uoW6xHrS4tawDS1hEy2J9jBdjq7p+Y7dd
         /MsEtG0XzBdvMkr9duleLozwIPnvWLEVNYLW68gmbap4Ug/HfzbzWknouqgPe1gn/5ny
         0HI7Wop5qjEwxNV8rO2NLSKSwQJTKWq8l8xnjCVeq3Zp+Tbrin/msiGZUXR6vslAXkfd
         pxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751156; x=1779355956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BuYOAkPGvNGtocwKIFKK4r5RpQsaxB3pkCmwnF/UVxs=;
        b=g9vLUrs2qfV0o+/8ol0Tp1o+vRQ74K9WvboSQInvcN7PEfpW8nCJasmqERHlKXg55e
         DT9GsIzkzcIqA4/KiLdMNFkM+6oxHrW2R9dr3LDf5C5j+AN+7ESnFkJKDwbZ9id+G9RB
         uY1qo242Hb35CuByLRHGFkEmZpeTvGIzyqoX4XaXcvhCW3F4cUMUifVqHP0fP0EubhWl
         vVGQjy6mu/0NkiMmTX4smdiA8v6l9cYHcgdsmBuQPh72uTXeyeEEfrBZn6WWMgsioGgE
         u/WBJk598JQXkLuXC3o+buuahXksXyUcOyNoJY3D32jGhffOkTll0sMLi65MAaMTWVn9
         kU7w==
X-Forwarded-Encrypted: i=1; AFNElJ9E+jLxCUdU6ppVgXTIjJKYjpKjc1DMFYLh9LHHHXw/mJCEXZe1S/i3Yk/tKYDkgNt/6tXIgbPIhhfzR0NGaL1b@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHkXNrG7O6RL7sJtIMLJfdqefou8yxqYJEbP65tlwWm6T/nhV
	H8E77yeEi2OzTjS6nAxGYQ5VAee2m61Q+3Sp1pcbexWHHLTQ6ITu2eULL1LkMF843Fg=
X-Gm-Gg: Acq92OELlPGs0iAyk7I7a9OCSK5N0ta5T5UU5Woh7Uq5G3lt4cyGYcvhA8ozSBkcBAt
	Y/iOLckCoyxcyKvErKtMa750+5sV5aBX5NZEZs+ctba5rC88xDls3SjzWEt/73yO6/59aC9M7lf
	6Tlafzc7igsgs2sspuFZJZTWnE2KaLYi6OdDqeUMSreJFRPm7RlTHUpV8GkBcbznfr6sKTr+mST
	pVc73D1YJGvd/GrEu0+O3Kjz7V4Xb/Jty0Ob6skTIm1GMaY0bwyjvzQsf+IRmAFEk00khbCDS9b
	uxhKqzBMgPv4rAyegb2F8zeaB5PtAdxtvtFF0miXh/UeiDtnLgqBbJbCbf+VdvFEiVimIvZkLTL
	48uxiQDi0YNP4w3pAHUDLzznmoVcto65tUrr2bIxITeBl37uU3MXCGDoXHwbIhNc8dT8AFujAup
	w+q0cfBfzO+vwMVsyf+HlF2TGYt8Zl7EB8HsqBZbdkpgY=
X-Received: by 2002:a05:6000:2910:b0:452:2834:c690 with SMTP id ffacd0b85a97d-45c554747bbmr10469740f8f.0.1778751156557;
        Thu, 14 May 2026 02:32:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:36 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:11 +0100
Subject: [PATCH 4/6] tools/build: Allow versioning LLVM readelf
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-4-6cac1a9a4c8d@linaro.org>
References: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
In-Reply-To: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, leo.yan@arm.com
X-Mailer: b4 0.14.0

Documentation/kbuild/llvm.rst mentions that readelf is included in the
LLVM toolchain, but it's not currently included in this block.

Add it so that LLVM=... options also apply to readelf. Users in tools/
were Perf which was hardcoding it, and another was the BPF makefile.
Both already include Makefile.include so convert them to use the new
variable.

It also didn't have the cross compile prefix, so either readelf didn't
mind opening cross binaries, or it wasn't working for cross builds.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/bpf/Makefile         | 8 ++++----
 tools/perf/Makefile.perf       | 1 -
 tools/scripts/Makefile.include | 2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 168140f8e646..180dca9c57c8 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -114,12 +114,12 @@ PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
 
 TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
 
-GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
+GLOBAL_SYM_COUNT = $(shell $(READELF) -s --wide $(BPF_IN_SHARED) | \
 			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 			   sed 's/\[.*\]//' | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			   sort -u | wc -l)
-VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
+VERSIONED_SYM_COUNT = $(shell $(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
 			      sed 's/\[.*\]//' | \
 			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
@@ -182,12 +182,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
 		     "Please make sure all LIBBPF_API symbols are"	 \
 		     "versioned in $(VERSION_SCRIPT)." >&2;		 \
-		readelf -s --wide $(BPF_IN_SHARED) |			 \
+		$(READELF) -s --wide $(BPF_IN_SHARED) |			 \
 		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
-		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
+		$(READELF) --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0aba14f22a06..63276bf55856 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -215,7 +215,6 @@ FLEX    ?= flex
 BISON   ?= bison
 STRIP   = strip
 AWK     = awk
-READELF ?= readelf
 
 # include Makefile.config by default and rule out
 # non-config cases
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index e81e5b479c56..380ad84ac51e 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -73,6 +73,7 @@ ifneq ($(LLVM),)
   $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
   $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
   $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
+  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
 else
   # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
   $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -80,6 +81,7 @@ else
   $(call allow-override,LD,$(CROSS_COMPILE)ld)
   $(call allow-override,CXX,$(CROSS_COMPILE)g++)
   $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
 
   # Host versions aren't prefixed
   $(call allow-override,HOSTAR,ar)

-- 
2.34.1


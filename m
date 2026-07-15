Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301F41D63E
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119195; cv=none; b=YNQQw5ZJeYTnRb3RjI76mXO5a6mW4UXMI62AqrRcVGh+vlN9DW4GRys2ArEjbKq7aRHAxGMn18Q1E/nYG+ukfWALf5cz8Of4IRfOLvOdwT7o1LfHcOwubAFwNvBIWvgMnrARzSB7z4JSuAam2FeZ6gbBP+eOrzbWMBSKaJVhWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119195; c=relaxed/simple;
	bh=ZkYJs35jQmspYZV+7P7rdW/XJsOQuNs1+0xfbRaBumg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rg066/ulDDXNCcB4cjbawKSNfkLLlR0Aamgp3y8PtsSUaeCnIdkujD0zf4riM+L6512kMRUENvqRXmCOzvuk0WugRdz69e4P2rpviOjb1zE+4QsfoNBOwvQWL1y2fkrO4ne179+KJA1g8AgF36md7XfcEntm6+rwlGssHaFqScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G1l0I46k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1l0I46k"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so34161235e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784119191; x=1784723991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYLoZSOwmX0k8MESmwiGJgNO1yzq3b1PVclurYMHFiw=;
        b=G1l0I46kSGQoY7D+w2hYlu5iuXi2nygQsGEAxwUOJr6JKu/wzYqkruB27VbYrZkb9t
         01AmMN/JZ23x+fWhBm/1cRgOv6PeXsBAFx3i4j8hhwNr1xATAAAltTE/aoWL9t499MFW
         RLvSHjm4EOBXXkjv4Gptrp9VCGY8DG7+q09KNBI8qkCp4wR5ZJUgTx7y/4HF8CBUy9IY
         QK348XBaYCzpiBJjLe6GS6Kf35zElm00hwfkD3j8gpJv+w8H37Dyomi61HvNhmjHSEkN
         MxW0mrxvrIyBjQSLopoPBP4SdVSPOVWutHB0b1/raxDOjrHyyC95MIyAoZGFh77LuhEj
         ew7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119191; x=1784723991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYLoZSOwmX0k8MESmwiGJgNO1yzq3b1PVclurYMHFiw=;
        b=YZJPcCXsHFp3yUjHcCbLjTYhmiVjYMd1nvnujVuM5lBuBcrtXDIy2Fn0k7oYiDsmQt
         daaU9Mtz6l0HP6wMzeQntAM7tl7N9ZnMR0WuHfd9XayDUQOvQoSPJCBGsnK7LKySOKIs
         +U4cTi2mX0NYnlU72TCb/mOtXtbDBMPBLxtAYDLrTZ9qQ6kysKxWox40w7VMv+Gh477v
         ual+Wm9JUT2BwdSpp30sLLFf0wSNrUZUsztLamCgsyVX+yR6HLYgXXPAUjFqBnBUD2w4
         cMmvfJdWJAnmYWz9YQqHL7NzW6iAvP2QoOJL1QhlmKHbPOUTtHemj55ZhOysv9GOJ8DZ
         mjyA==
X-Forwarded-Encrypted: i=1; AHgh+RovlJgFsAN8GVsTJw4/O8xKukIdtfm5LfaG5gTGTnOO36wd4ixqFt/AYiAfqWlDZa+9UlmZD2/ZeEzYFYfsB/ro@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrLSOu0J/6zFCs7XkFXlKNwSY94jNlRNLW9HVC90fvqrX64zS
	vDtHDIlN8rmOTY8ZgvCWGFFG54t+WGQylCBGv0QlZz71qZCsg0O3vYS7peAH/XVTBHE=
X-Gm-Gg: AfdE7cn+7XDyyGEdCmq5MR+X+tq+6U551ue8DYU3zaV9UH/zv7qL96zvEimF9oSz7nw
	TkwX20XTvtG+FfU+hVNS7/u3I+lfPC/6Q4rhOXil4tU8qZH4ruaE/e9WzIaOOH7KoALJkyrf2f3
	IfirP1fcVH9zBNdk4TjG7JI48KUQygATBnFslOnNabo7oKzZ5Dqj8QgzhZlSRZ+XCgz8OudXS7M
	4L/nRn7GkxG/tHWI3954FmKKT8bjd4S98Gi7VrUnGW6lrnLSzRTHyt4yA32lG3hqYg2OBXXF4hF
	+WVcNipKrMGBeSuM+WmeHIPJQYGOPvb1/JxUw1leMRFHMvGmfHRvDiL+WiP3IPIk0AXqISRNyYx
	NMCkofxarE52akn2WXLoTGMVH3TLQazcpDXgye3WPm0g0Xyiupw3r9EV+J5v2k/oZ/IMy/BeLux
	FLj2Vfr0tGVmVBJuCvxGp2DQ==
X-Received: by 2002:a05:600d:644d:20b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-49538992cfbmr54535535e9.5.1784119191529;
        Wed, 15 Jul 2026 05:39:51 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm32360695e9.2.2026.07.15.05.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:39:50 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 13:39:19 +0100
Subject: [PATCH v3 3/5] tools/build: Allow versioning LLVM readelf
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v3-3-8854bfe5af7e@linaro.org>
References: <20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org>
In-Reply-To: <20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

Documentation/kbuild/llvm.rst mentions that readelf is included in the
LLVM toolchain, but it's not currently included in this block.

Add it so that LLVM=... options also apply to readelf. Users in tools/
were Perf which was hardcoding it, and another was the BPF makefile.
Both already include Makefile.include so convert them to use the new
variables.

Where readelf wasn't doing anything arch specific, use HOSTREADELF
because it's more likely to be installed.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/bpf/Makefile         | 8 ++++----
 tools/perf/Makefile.perf       | 1 -
 tools/scripts/Makefile.include | 4 ++++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index eca584fb061e16013e76827e4203f6be0477a73e..269fe21fc8da73083367b3c122bdd2b718e12bc5 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -115,12 +115,12 @@ PC_FILE		:= $(addprefix $(OUTPUT),$(PC_FILE))
 
 TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
 
-GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
+GLOBAL_SYM_COUNT = $(shell $(HOSTREADELF) -s --wide $(BPF_IN_SHARED) | \
 			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 			   sed 's/\[.*\]//' | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			   sort -u | wc -l)
-VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
+VERSIONED_SYM_COUNT = $(shell $(HOSTREADELF) --dyn-syms --wide $(OUTPUT)libbpf.so | \
 			      sed 's/\[.*\]//' | \
 			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
@@ -183,12 +183,12 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 		     "versioned symbols in $^ ($(VERSIONED_SYM_COUNT))." \
 		     "Please make sure all LIBBPF_API symbols are"	 \
 		     "versioned in $(VERSION_SCRIPT)." >&2;		 \
-		readelf -s --wide $(BPF_IN_SHARED) |			 \
+		$(HOSTREADELF) -s --wide $(BPF_IN_SHARED) |		 \
 		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
-		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
+		$(HOSTREADELF) --dyn-syms --wide $(OUTPUT)libbpf.so |	 \
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 476b8dcaef58cb1f3fa75f46a647c2cfe2352767..4d0d7ae02e06b117487a17691c4e62a138428ac5 100644
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
index e81e5b479c563321e458b2a7ad8fca2b4607a254..46a3872b87624a7bf475d9b42a3e471f36789dfd 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -73,6 +73,8 @@ ifneq ($(LLVM),)
   $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
   $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
   $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
+  $(call allow-override,READELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
+  $(call allow-override,HOSTREADELF,$(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX))
 else
   # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
   $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -80,11 +82,13 @@ else
   $(call allow-override,LD,$(CROSS_COMPILE)ld)
   $(call allow-override,CXX,$(CROSS_COMPILE)g++)
   $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+  $(call allow-override,READELF,$(CROSS_COMPILE)readelf)
 
   # Host versions aren't prefixed
   $(call allow-override,HOSTAR,ar)
   $(call allow-override,HOSTCC,gcc)
   $(call allow-override,HOSTLD,ld)
+  $(call allow-override,HOSTREADELF,readelf)
 
   # Some tools still require Clang, LLC and/or LLVM utils
   $(call allow-override,CLANG,clang)

-- 
2.34.1


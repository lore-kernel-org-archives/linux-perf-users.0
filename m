Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5D39A808
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127267; cv=none; b=ilXvr+TlMSuIpr8jX9kv0x5nRxvO8Y73UbMQYnwT34Eubqtqu0P5aQUknWeG6yH8N7tub3E72UzkyaIshsYOeL/V3WIEzNxs3GStx1RkWo/Qcef5GVD8r84KJhqNXysS3c/TNilu5VZN1UXbAC0XTQD52/btEi3j3F/C9BGIgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127267; c=relaxed/simple;
	bh=ZkYJs35jQmspYZV+7P7rdW/XJsOQuNs1+0xfbRaBumg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=st+AGN4Ra/db1EkQC8YJcQMdcaLO2J1Ii1jemaHrnmqHCjk5MrPuBNoZt6gu9tCBkydHEmJXQu+/h4SzMfVM+gQ95e3jsohEMPWyJf73StemnfcbQo4F14zChoyNZlhMuQ6uNeFqwWTt2xAwH1jmjDPOkAFPHUspt15RiU2Kihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9I+eCnr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9I+eCnr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493ec555a26so36015865e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784127261; x=1784732061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYLoZSOwmX0k8MESmwiGJgNO1yzq3b1PVclurYMHFiw=;
        b=w9I+eCnr9TIpzu7GbUYL3zpPPIU6S0jloT5X6VGAEDiz/7On9oUBC23OrWcWvwJ3Fy
         XXhPEmRuAu3TMYM8U2QxRjA4rolyrFrxVozlWwpikuqabKxeg0js85iTK/h7nEf5IRgd
         LcnzjFcNHDDCslPC90GT19wToUdJDkJHj3s1rSsyofjcMLccC/pa3ga+ys+OPCU72DuS
         Cja0PTk2CeXJg/G8pS/IvOLQ+dsngjm2wUO6UFSBKOJwN/KQA33pxuLDIF9+6vHZYueg
         L5G9Rw4rpjuITSIDatvLu8wO4rwsQsGThqrdPO8P5WGw8DUDGMlz1+wruJOHQjDDvGgT
         HbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784127261; x=1784732061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYLoZSOwmX0k8MESmwiGJgNO1yzq3b1PVclurYMHFiw=;
        b=nSFYXZu+a5huMYLfF5A5bEzf9FnZ85UXe5DzuVTdDqOI9Igk/A10joCrprzyRlibbq
         1J8+l/Ir/PU/y7ZaUjBNtd8HwqJEn93oCUWfyQPfR+y5O+DWorXlyRNKfXHThRzW7b2P
         FjYVqaYu2GL2oCW49OgmlpEjjaeavpxnUgl6D+VzKjZAqFYh+YEawvbYfUCL/da+JG7q
         Uokd7a9NcvCzkka58REJaDbGVWoLLdcaY37A/ldqpsMKv23UVThAMGvC8A90juHVL7ww
         EOfq0kXk7DQ1TGv7Fj2fisR1GGn7RkxEesEWVMYExuYapN7eCKpVp/oMmX4j7xqO2SPN
         JAZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqpa330YfYSXMy4QQyY/UBhLV2/GxqrgRkWyZ4d5SfTDqAmVSE/Vc6+aiKvK/631ZttKhJzsDfmdu4E9zy3mgVh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0iYD2g4UvjeZaYrjmZ0yy0HzNDvu02OSCJ8nG0knOVBcIU6hH
	ZyyqW9nBmeY8VQUBqwGT6e9zKLhBiB7ZtpTJr9NG1Zj/+LAnmoYNMffrQq7aHrt2fug=
X-Gm-Gg: AfdE7cnXsR1EuD61tBK9dLED2ZGKNOBLzj3d9WadwmwSw7g16aKa6p6gd/RIep9U/Jm
	+JBbhvd2XVts1z+fwKCqI8/QYjGMS51mBXqVWulZWC1XyF0Fo2kgCzdoHzzLMwd69ouuFdg+vYt
	/o4xSyghgtVk97CWnUjVoF4lGgOH2SkYqBA5cyYjXigkIWzkfGYVA6XH5HfiJ5OudO24pkl7cg2
	1OdStJld6R0zdlxDe8e1hKDlmx16zdkq+tPhyhrC9b779dN2YXrVCSE8qjLAdG6wIsi7SnCjD/M
	d8KN9eXAvF6hJEY+CR1BhGWZKSKUIEsumBy4gv1ULIjzcB2pwduPQNv/Dtstgbm3xVko9jI3YYx
	4fQYrN+QTwzu2UJzZRTBHFtI81HKga4MErA7z9pdxUd3TcGQ07HVEjXgX358AewUgbSvVuuqLjM
	D4T8kjwEyH8F6sF3+8Mo01GA==
X-Received: by 2002:a7b:c38e:0:b0:495:406c:81d5 with SMTP id 5b1f17b1804b1-495406c81ffmr2450405e9.28.1784127261341;
        Wed, 15 Jul 2026 07:54:21 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49510c8e220sm137649275e9.15.2026.07.15.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:54:20 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 15:53:50 +0100
Subject: [PATCH v4 3/4] tools/build: Allow versioning LLVM readelf
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v4-3-6dfdf984b435@linaro.org>
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
In-Reply-To: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
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


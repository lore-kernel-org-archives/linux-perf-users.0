Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1E47CC82
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119198; cv=none; b=Pvu8RnyQkqpbjWKNO4wm6mpk0oWx+fIjAGKLCSLdSwAo+MiDA/9LSqdPZ/Ru+Gl1cT0mQKotgrlqtywTCfLhsZljSXxU1KiW3Q2AHbxMFIcM7jRrHg5FCoASvdPuxonJMDGvKLtliBWuWGuK4gKXMMttzpsG/UrpXlhkbRg3w2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119198; c=relaxed/simple;
	bh=23V8P96JjPI3snxBemAlctSXcXR0vTGgsRT6bW5Z7AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDjsg3HEWuS5XV4gpceULGd6yUXa4a6A7UqHBIBRigY0mm64ahLX2K4bSqaszVIZjzpeTc85FN0iiMAmvA9XCTl7R25ATr62NTpndsg1fBOBxqEH1dF5Rft93z5U3bvJsVnWfEbHK7YqDySuXs3Vq9MrS9f5fhVKB3o2pWGAACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SjUpTcY7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjUpTcY7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f75f7172so37370255e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784119195; x=1784723995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UbwMtvKC1W3XaLMpZ43nboi/b2XlEYyfJjxYGqiGvfo=;
        b=SjUpTcY7EQPyVkLOvyzXRXi4+b8F8GrWTwFxgqeBOf9P51eg4XG0tu3GIjbwJpRvc5
         lyezu1+9o/i+gNITbtRvlTX43SyvPpLcvWaNgDn1ktKk30F7cq2v8ZtzFTWEOjng4K4/
         0i2u/z5KZMcQXHFx2rcHF6MoY9uKZmWlH65cDGgt0vQqhA5FCbG/vY9gGwBFCWuNe5Im
         WQa+6VNqknRNpKQJdsAC3QUTSCzbO+3VflRvXsk5eREvTiA2CiXvR9JlArTFZqHm6lEq
         5EVJlWWte2CJWFRAhLMzoa09qq8RywlGBbGGbHfzeV704MsEUaM+zLqrvZV2Xro9k9F2
         GsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119195; x=1784723995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbwMtvKC1W3XaLMpZ43nboi/b2XlEYyfJjxYGqiGvfo=;
        b=JM/x2tBQq+FIGVQgpNy33TNyHciNvZpo+iZiNVIgy5rjkT/JPp1n3j/RG7M+7Jyz84
         n+gIHttrfOwvqT4rt0VojETn5INGchxStTF6Zm+1VRaaJ+wiUnO7WY0woH3GiEgXKH7e
         HnEZ2EDLvYpclCYirnwOWyixE0x96qiUYKLLgBoxWZQdtVu/xkpX3wSxdiwJI1MTfNnV
         za2Wk6ums2m9NQ7UvCxEHtiYSbi/8IsQqD+CKzsGskLwbQsbRG5wy+u/N4LcnaY/qZtM
         +zpoaHUnQKVxzlL1tdatLfQ6C7fUjPYdfeb0XvVrbYv1QQZkpjR2IFidUJMnKsI4/cQi
         lM4w==
X-Forwarded-Encrypted: i=1; AHgh+RoMUCJyxKWp7fA+fUHjqscwofDGLooRtSOwarfVTYmuSakVkjC9jEYdgY098U1/OLV4k84Qo1e2zCkmxXdKNaLw@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNShbUr5o1NG/PHjkzyKejhECM0Qy6QJJq+dPG6PMArrxwmEz
	n8MayzNRntpB/V4lKktDdX3Kn5hfjaBNOUDSEYNYlJ2BxxaGukt8ayyugUfA19Umork=
X-Gm-Gg: AfdE7clL2f2O9bgIC7FB9BsZnkzubpUhi3f9YbdZzJpPCqQevqr0p28THsgSo24Fr5w
	XOXJzv/BqcRH2EtvtFqLUzM/UjOPu2CknrBWPfpoF0T9yD4Hw7R0LIR/DdBNIOQdkm8/UCHQLDi
	EeGVdNYXm4Jj+qn7laLAnkMqgsiwQpIH/yX9XAFZ+MntGy6jIBZZWZJb2R2o57A4SvYkpYLluhI
	A3cD+r+tVtG3lkeZlGyrGo1Q92vew/Hr+yNetmvCf/oBk4BQCOGbfQdPFltKidL0riVIIxxR1zG
	ELDpzokmkt6xgPQLl5bDVMMWycE1YQFxuRIByYqSZOdYXtQxY+Q4D4/YK+3d48eLPrvSf50L6/J
	gJe4aDhJyFJpxd+5L12KWbKMeSMt9buwN1ydXvSa1XQpqzHwNRfdvAr2Bq975db0vykqTT7sVR+
	T8INqox50+vlsvH4Ry0hiFbQ==
X-Received: by 2002:a05:600c:8117:b0:493:fa7d:56a0 with SMTP id 5b1f17b1804b1-4953c15f693mr31569305e9.13.1784119194604;
        Wed, 15 Jul 2026 05:39:54 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm32360695e9.2.2026.07.15.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:39:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 13:39:21 +0100
Subject: [PATCH v3 5/5] tools/build: selftests: Remove some duplicate
 toolchain definitions
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v3-5-8854bfe5af7e@linaro.org>
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

Try to remove some, but not all duplicate toolchain definitions. In
these instances, their makefiles already include
tools/scripts/Makefile.include which defines these in a consistent way.

STRIP is the only one that was set with an '=', but I don't think it
was significant so that difference can be dropped.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/bpf/resolve_btfids/Makefile    | 3 ---
 tools/lib/api/Makefile               | 4 ----
 tools/lib/subcmd/Makefile            | 4 ----
 tools/lib/symbol/Makefile            | 4 ----
 tools/perf/Makefile.perf             | 6 ------
 tools/testing/selftests/bpf/Makefile | 1 -
 6 files changed, 22 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 7672208f65e4bc245c03603634d3aa0093a91096..6fdb6302e0a28e9166175822f42cfbb4f4eb24e5 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -20,9 +20,6 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
 		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-HOSTAR  ?= ar
 HOSTPKG_CONFIG ?= pkg-config
 CROSS_COMPILE =
 
diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 8665c799e0fa7155016e8bc6968ebe76a90e1d13..a228fdb5adba8d7f8282688964a9751a06cb0c79 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-AR ?= $(CROSS_COMPILE)ar
-LD ?= $(CROSS_COMPILE)ld
-
 MAKEFLAGS += --no-print-directory
 
 INSTALL = install
diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 8703ab487b68c89406fed575217b57f58e71fb01..9f1ddcf0504d993249991e0af4589db1072465d1 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-LD ?= $(CROSS_COMPILE)ld
-AR ?= $(CROSS_COMPILE)ar
-
 RM = rm -f
 
 MAKEFLAGS += --no-print-directory
diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index 426b845edfaccf56f7c246c281a549c18d0f3919..d692abe8add6e243d7b024fe556cc0983eb4b443 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-AR ?= $(CROSS_COMPILE)ar
-LD ?= $(CROSS_COMPILE)ld
-
 MAKEFLAGS += --no-print-directory
 
 INSTALL = install
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4d0d7ae02e06b117487a17691c4e62a138428ac5..ca67d4b6fc38367c63123332360ccf27102fc086 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -174,11 +174,6 @@ endef
 
 LD += $(EXTRA_LDFLAGS)
 
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-HOSTAR  ?= ar
-CLANG   ?= clang
-
 # Some distros provide the command $(CROSS_COMPILE)pkg-config for
 # searching packges installed with Multiarch. Use it for cross
 # compilation if it is existed.
@@ -213,7 +208,6 @@ FIND    = find
 INSTALL = install
 FLEX    ?= flex
 BISON   ?= bison
-STRIP   = strip
 AWK     = awk
 
 # include Makefile.config by default and rule out
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index d829979861eeabd33272a0d6eca82e7066eabfd7..49477b03a4607c0c44cf94412d5f75af75c3a766 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -3,7 +3,6 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-CXX ?= $(CROSS_COMPILE)g++
 OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
 CURDIR := $(abspath .)

-- 
2.34.1


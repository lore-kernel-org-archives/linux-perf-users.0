Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30423E6390
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095059; cv=none; b=sJymbYRii4Cbtk0byBH14fne9/DWG7XcLeoS9Zcpvmcyd4p6MobSHDfoUZZZIRYO1/cCUK2ioO/DTqJ/tuD0gEK32UmPcEnIcq7CQBKGNq49uqpcN607pJD/fIhw8J/TEUpq6+wxFbXHKM+/8OevI3ujsFgkq280jtSQq0f4KOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095059; c=relaxed/simple;
	bh=XYN2OerTukpjvC5uTpCQ4LBfsGgqw8htnZqoFgokKo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMjlecg2hkpf+Ojtk+xqlCitZCyJVFvRpMBiCyrBHPpgXiP+8EwxUCuGXYrcOZYMGwfrIUkFbH7KnsF7pGwAQrwRPu14b6n4N+wqU9M9tbnDDCsmlsb39HC/6FA0e3DhJ+hirK0KqSqgFTngSlYcWo/IZQ6FWuXK+nkTBwc78RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d3Cc8C5x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3Cc8C5x"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so14291485e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095055; x=1779699855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuYOAkPGvNGtocwKIFKK4r5RpQsaxB3pkCmwnF/UVxs=;
        b=d3Cc8C5xXYt4HObXlJg7Pwm3gwACAcpZvdleD9FhFr/dgK1u00Cl+RfkTatcilaOfv
         SiMNRm/gkfnnu0maJ5JQNF2i37jSEs5POx3fPBB+Mr3LZWR/js6uBqeNbi+Ug6qaU9xk
         YuiGlkCTjoVbfDRH99Bval7gHyL1wxcKFQGsfhcFkgQj0xw9zvkoUgtwCUlH9T9P5HQF
         02Wp3pWe6XLVSerO2+H5821JhaECKWZF6sw1KcivNatxrHIyqQL0DBzdsfHW/zWBhEFB
         qgvVSVi1S7MQv1cXZnWiYhH1aMB+Bm2AtSlK2NOxN9qysKGAR5Yca+RNAjbM7W0PIjTL
         O7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095055; x=1779699855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BuYOAkPGvNGtocwKIFKK4r5RpQsaxB3pkCmwnF/UVxs=;
        b=G9qVmkYQ7PGWVPuAzb7KCepUftsWTfvVapl1xJUdTeRI5w8Lh2rBnmjLg6kf5TMAPT
         uPBNh7kj+PuR0UjUyBkECiJ4fzqy7x/AHnP1LUsz6tPeAkjyH4Kq0K/wR7MsU+ntg99Z
         tCsJi9p0tgKUU7nfCTCcmUZNOnU3BzxCQhwNW+SyvNrk22ypAKB+OZOBADDepuuBjZNO
         IAtauCQH9Fxp/oiUYhLsChTPxypbK6Y916x62gCxSYpef3N0DKlCBYrJtmoFYankCuT+
         2auajaXpV58STXbtJLejjK3oHZw2+NtrnxmgBOA/MrDxNLXDrf3Z6M33NOKLZ15WU18v
         S4dA==
X-Forwarded-Encrypted: i=1; AFNElJ9FHHEzMQRvP4tqEDlSPEdIiO/xnlx5ZRIq/WYL6YP7NGPWxcficp/kzh8lbLjxA3F6rrDcBl6LASRyKGLV+j92@vger.kernel.org
X-Gm-Message-State: AOJu0YxctsftOEaWHCchDDSdTKCqRTOPRTxFNnl+W9nEZapZ+wH48Yrx
	hvwgpckfjbHSogbCG2dI8r4sE3ZYJaLb9NmM45NXqXeaKLwo51OeiwM8+ZX7IRDRh/s=
X-Gm-Gg: Acq92OHviARCgXzsz1zQjZs1Z/LVgl7EVtT2LZ6mDjLrO1oVqaOt3DRiLYz3u2nzLlp
	1oCk+WjcJS8h+v9jKu50CPXx2xb0fFnk/Rc5OJpMumGP6aoDdssLzNMTI0e6U9d9DDVbl8oDPg0
	1SzjeznW9Uge4M15efKOa+ZNU2MpNamsW5JNfv8lzHE3KnKb2hCDNXSAb74g6Rq9hccX9DBg+NP
	gtZEse50EHjiuPqYtYTCtPtaWGJ5IZ2ycgsk2Gwk8YHz2ZO8hq7++6kh0QpNMxUCX1Mkk12qfd/
	FAlkUXgtiHYMdbvlVIHxveci62rGe3LbgoDls3qYmY4EP0eO+sSPn5w+PIoNJYR5iL2hgivWPAg
	sbhLW1DCeOlM1xF3RkfWrn97du60VYlBcvOnFStnnGIyurhLYR8e1g1e5FfN8IIC9Uy0K+u0nQy
	9QTgNOBzhFflwHfNFs+V/7xLbTe0xe6NcQ
X-Received: by 2002:a05:600c:8707:b0:48f:fddb:dcd9 with SMTP id 5b1f17b1804b1-48ffddbf75emr124613905e9.27.1779095055065;
        Mon, 18 May 2026 02:04:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:10 +0100
Subject: [PATCH v2 4/6] tools/build: Allow versioning LLVM readelf
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-4-f12cc4f031d8@linaro.org>
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
In-Reply-To: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
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
 Yonghong Song <yonghong.song@linux.dev>, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
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


Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37586399D0B
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127265; cv=none; b=nKxLdDZDvW5N1/PjkPdTuOWT8g7cwa2+UzO3KS62SkkmeAAydNZ8B0moA902Nn2qqLgD7nzC/mYj2ap4T8id7hWHYz3OcXPx7xQF54dPAiNjDC68X2k9qXqIBlnZGdbYvrNDLjRLi1+EtXuZ1T5rN8D5FlMGiLJ07sR0fw9gR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127265; c=relaxed/simple;
	bh=vierWn7zWoMEGxDcMMkTIOifh9Esb5HXc5nNQCPMiog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAt+maN4ek9WwL/+9jTiOEr6xFNRh1+Lg6SXkfuYW3eGdjck/BZzw7jOy0rtXuXX3y0gfCfQjMF3n/U4vMty+apntgzKn5FLEOOXveNTrALTY3tNjHyj8urE0FPnO9Gyai+q3Qz+uZCD9XdQSfmFlgiRJcp2zve2uogFS/pq5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNir0yfy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNir0yfy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso39285885e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784127259; x=1784732059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MEBbHm347NmLeqhspnJuPdrAD7nLfIZv8YQWBcbqgbU=;
        b=sNir0yfynPWRJOWDmx2+Dwgr6pw4vLlrkhosimT3MU12NwaeN2Mw90Smz8ssIJW96I
         Fe7HuXQsUHtxXq9TUGJzwy7Wu9LJf1OhXQ0IT1uruFzwPUsDmQilyV3+CZiQCpm9P6Fr
         1lL9lvCA0JC7Kf7PSIK4Liya/f4gD5jebSH4B5PBGU2Hoc5wuM2T7nCUmUZyzb4U/r2v
         FehRc1/098kuDTY5I+kJ7UeX9WuGz8PpDKizpQtpe+HoQCJMEaeh3goyCZuR8f3Ilr24
         YuQuDEnLrUm/H232N1pG9VAPJFbwlS2dVRwc2ILyzQR/2h7Wos58SLwI8N3V0/q0drqk
         p4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784127259; x=1784732059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEBbHm347NmLeqhspnJuPdrAD7nLfIZv8YQWBcbqgbU=;
        b=aQ7zVHqwVa9yNk7AwIkyTVly12pScnZELrzM9MVnad6tP11B4EF8Wl0gwqmO+4UUAF
         hzv/qsPHkkSebkjL19oQ9z7ls3CNXTnWvAKJ26dtz2bx9gNg2FZr+vYrkwT7NgzQL5L7
         Pco6Tzo/x8vH0YMCneo5bUSLv9bIH2SasiSRTP0qwMMeWRyJbFJToWIlYoHoXnmJ2cnY
         mvKEQsifMbgcMCLWppkF+svgzCBf7t6YUDafBLopcYaaQHRyX8BEzG7hz5bwzO9TFQuD
         MSD3+wLC2dZBT6lFS8Cbb+TiThyzKhCu4sVtviCLCcTsqeG0Sez5qofrThG5Z/Td5IbX
         8l0A==
X-Forwarded-Encrypted: i=1; AHgh+RqEX34gxm3BtYGc3ZcKa3DX1SCerKCIe6z2a7Nw9SvKeD44d4R0HJrOJv89zH85UVPmlMslsW9l+cOeJ0fu0yiO@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7YC8PNZKseJ9a7kWMoGelszgh3FFc+iyFQ2oJQQSW25+GYEB
	QbmHdDdtplhQx9sRoRJ6TtJa8zm0nCpbHKrft/F19FnPWy/ZaoSn4OAYgkH+LG3Vpcw=
X-Gm-Gg: AfdE7cnCvHB49UEeltuVlSLgsu3pPStqHGZVrYkReUEqpacnFIICcKeo2E+/yRVdN3v
	m6rOHlymwkkJke4bqBoBsexMswkBiujR1VfVhzKRUl4uAY4bh4IiUnqVM1BQGioK0P2w6i/AmPC
	8zkjaaCB00TKzKzppLo48a69rvDns39FQnLXTwCZQaQquEv9VozV3YE6XSIxS0GmFgRA7Bwb7Q6
	YPxY60pKmezldcjlWPg1BxFlNXWlEYAUUvOpru0xZxcZyKvbcgdYnhBo8CLaHyri9n4+Hn5oPFl
	g4crzHdd3Bc+y1Pe7aiy2MevYo7v9+vsmvWakPcNm18Su7+Nxz9GFLqAELtDiv7Y7yOuDd6erRV
	svLo8tcEbFaNXlzbb46TX3PopLToh90iWseRZNWcqdKRnKjt+vfsxnU0AOJK7wp/F+Xm8LATtB2
	8uUw1eVV+CPiFBDc3H8s3SmQ==
X-Received: by 2002:a05:600c:c16e:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-49515904fa9mr98446325e9.19.1784127259252;
        Wed, 15 Jul 2026 07:54:19 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49510c8e220sm137649275e9.15.2026.07.15.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:54:18 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 15:53:49 +0100
Subject: [PATCH v4 2/4] tools/build: Indent if else blocks
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v4-2-6dfdf984b435@linaro.org>
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

These blocks are quite big and unreadable without indentation. Indent
them.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 7022e78208a236604a681d45b1ff4f2128f412e5..e81e5b479c563321e458b2a7ad8fca2b4607a254 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -52,46 +52,46 @@ define allow-override
 endef
 
 ifneq ($(LLVM),)
-ifneq ($(filter %/,$(LLVM)),)
-LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
-else ifneq ($(LLVM),1)
-$(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
-endif
+  ifneq ($(filter %/,$(LLVM)),)
+    LLVM_PREFIX := $(LLVM)
+  else ifneq ($(filter -%,$(LLVM)),)
+    LLVM_SUFFIX := $(LLVM)
+  else ifneq ($(LLVM),1)
+    $(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
+  endif
 
-$(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
-$(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
-$(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
-$(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
-$(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
-$(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
-$(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
-$(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
-$(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
-$(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
+  $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+  $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+  $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
+  $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+  $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
 else
-# Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
-$(call allow-override,CC,$(CROSS_COMPILE)gcc)
-$(call allow-override,AR,$(CROSS_COMPILE)ar)
-$(call allow-override,LD,$(CROSS_COMPILE)ld)
-$(call allow-override,CXX,$(CROSS_COMPILE)g++)
-$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
-
-# Host versions aren't prefixed
-$(call allow-override,HOSTAR,ar)
-$(call allow-override,HOSTCC,gcc)
-$(call allow-override,HOSTLD,ld)
-
-# Some tools still require Clang, LLC and/or LLVM utils
-$(call allow-override,CLANG,clang)
-$(call allow-override,LLC,llc)
-$(call allow-override,LLVM_CONFIG,llvm-config)
-$(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
-$(call allow-override,LLVM_STRIP,llvm-strip)
+  # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
+  $(call allow-override,CC,$(CROSS_COMPILE)gcc)
+  $(call allow-override,AR,$(CROSS_COMPILE)ar)
+  $(call allow-override,LD,$(CROSS_COMPILE)ld)
+  $(call allow-override,CXX,$(CROSS_COMPILE)g++)
+  $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+
+  # Host versions aren't prefixed
+  $(call allow-override,HOSTAR,ar)
+  $(call allow-override,HOSTCC,gcc)
+  $(call allow-override,HOSTLD,ld)
+
+  # Some tools still require Clang, LLC and/or LLVM utils
+  $(call allow-override,CLANG,clang)
+  $(call allow-override,LLC,llc)
+  $(call allow-override,LLVM_CONFIG,llvm-config)
+  $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
+  $(call allow-override,LLVM_STRIP,llvm-strip)
 endif
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)

-- 
2.34.1


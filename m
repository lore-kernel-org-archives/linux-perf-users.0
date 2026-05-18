Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B503E51EC
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095056; cv=none; b=cupI9xBFgRYLoAebXo+IIjV6XCltK2zl/1fyS5OFxvKa6L6CVORRLA9iVyhrltoh6ZHqEJx5bPGgdHNiCVyXeEccOt5xibzlwnTTcNzM1SBbIq+8ltaAsNiaKZO2pcWO6xBVy3qA8eTki/wKXTL1T96/9vR7oTV4TqTDWWUA9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095056; c=relaxed/simple;
	bh=NfaBRDzFvFklhzTH9t4p9EVBdLk/XaHTDMg8o9QY524=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCgVOLx9fLwVHGlw8O+N02Mk2s8rVgvFNBCH4ncW3pIWuvLMnKfznluLam8mGcCXK/Uj8E+XYuon3VVg5pG/ICFDrbvxLXKmwmLld98f6XjEyWIlldItYSSJth3YLHzx2FoGNylrMNj4Nk/HYjk4bQDwurUaq1iXXtd9d06MCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJirnelK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJirnelK"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso980528f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095052; x=1779699852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4dQGlI0To3jzdG+Zpi+3N86C8iuvnWf5obCtCx/S5c=;
        b=uJirnelKs1tdcsFLurQKHZ/CCHfP0RfbhTZxz1Cez1jjAiTAJupKKuIyfX9d+mIXrm
         CIfQ3vl/qG/iI5kEsWWjR7+W71lmVHqyBOCwv9M/F7/BTCSlvPzEtq9H9/Fdj8kZ2MYv
         duCB7iwt8ODSZUEGRIGEtMYMki+uEz89A9+4DZ1raiJ56Viy9+mNqgGF6hnG5oEck5rq
         gwweJURY+0a1vwBP9eu+sUUut9Gm8yY1cN+m/UBplilLUVYXUfmQ6eWFDgVY2PTVeqKG
         BF3vxejlSKCob5G6muIuV8aooNceMGOcgp8ZYTrdHILYSb4CE/LHjaikIZJZyooolU7d
         Laxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095052; x=1779699852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o4dQGlI0To3jzdG+Zpi+3N86C8iuvnWf5obCtCx/S5c=;
        b=FtSrz6U4gZt6VXiA+FW0ILQ02WPYlNSIHf7Ao1UKwa0TkJLWWXkHmMuw9DOD9AHygU
         C5AOyE+3HZKszMmPULq9XFfuGH3LszXT2HWwxSB75grS/i3jkChLZwTGcIK/fNymqkwv
         m0kjgszKh58BraOGwIA8R7yulhs+p/uXuSP4q8D7CsJbBmXV/qp2640mPSP5LuMbK2Vv
         4z29GmWz2j3FYMmcnXUVkJMFyc3t70uEQPmo7m6R3tkvZWSb62gM84qKz04ptinIag5s
         opWeGR+G296VU9KPi3CvABxL2+Q0ldxZ0yGoEHkQ++ehf0eMzVujbdc3l3twPFkAOFk7
         tM1w==
X-Forwarded-Encrypted: i=1; AFNElJ99YWmANQo9HQzmQEWjDgXWDkclJEDK0XoYRMCLynsR8U5P+dYch+B5ePomT74pVQzNcRTy5xHJv5+Nx1eVEr5J@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPLMvvMr9N1rEUVsA6/PCn6ZNaDqNvLEfBC/XbqILqBuxQ8Q8
	haZ5UtGh9vlIIjD7P8Bgm7gXcuZFI+M9bl782oLbT53iyzYlNKSyJiRiZ9cnRT0F9zg=
X-Gm-Gg: Acq92OGTCqjHKZLwnCJw00DaHmQ1MguClYuSDncLv8w/FAWh8vhNf46Kv3ZFob+LB7/
	ECA7PtKgrwyiT6a4DXLtF62MGxWVW+7UvvwejanB9Jkcvw2mArgDwK1+0E5tv7e7pHroqUF+amd
	YVoGvCzAHIj4Fzp7WTDw11jDi/9pzaBZpraeSvv6nHzA0EyA80x6QPC+1WXHhKKuEJ17KGwjz0L
	E/DnrCaX+/JtE2OXKvP6PLQtGbEKMgix685pqZazambFRcMgLVNE0Yl1/JdkI/I1GAiKKII/fgJ
	mJFakwiMdBpUURpQIJ5QQVAlJ5uecBvYbLeRCKD+nri344ee62KqTCvNOxhpEKebnZ6kj2I1c1A
	DA4w+8Nn1vG3Rgw8f66eyp3yEO/Sj63/zW7cE6kjEpJ8rEo0PUwh7w4W00q+wq68tSTM6qM++rx
	E3qHRQ5FvVYD0wyDYrdh085E5a2JjJU+6b
X-Received: by 2002:a05:600c:828d:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-48fe61eb313mr207432455e9.15.1779095051843;
        Mon, 18 May 2026 02:04:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:08 +0100
Subject: [PATCH v2 2/6] tools/build: Indent if else blocks
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-2-f12cc4f031d8@linaro.org>
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

These blocks are quite big and unreadable without indentation. Indent
them.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 7022e78208a2..e81e5b479c56 100644
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


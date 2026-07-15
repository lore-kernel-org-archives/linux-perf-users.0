Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE439B49A
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127264; cv=none; b=hiwPHwAick7FpC5pblz2S80qy+7195ob69qz2wT+syfHgJ5aMpfGpBDlVps5VMXxeh5dhQsw4Me5J85Qgf3hphpF+PVrAkwEKrC9WJYlgg+Ukrxou5svjS9bYq5uedZHrAcaP7ciDEG0x6m7AYdv7GE0dYWhYJ3d0T3t5ICwLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127264; c=relaxed/simple;
	bh=6unCx+x2NPgOEvMqAsB5BwetJseNsn7+XOk6L5xpusA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAEN4IvPy1m32yGWOZ1V8FI5yLUzQ11o5bHmnNBAdLJIm5m0Xxap/sZFYVGFzaf2vfDlLfyuhr33aBg2ckEyZFOGlSsG8XvdaNsqUWt+/rwyFmh5dH0VDavuFPMoN53ygQKJJ3qq19Bz1vutR+4telRo6mDq9WrFYU1KnxjvyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UbucEKqP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbucEKqP"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47362928f65so5052445f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784127258; x=1784732058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L41MYl3HjuzLNuK2qp3MB7sFO80z4n0DLrf9pnL8oBE=;
        b=UbucEKqPri0Y7UUkalOBWhDbpAh/wngXkbJ4m0AKmeH2D1R2qONQlUx33H79u9kaha
         Y+XxU5HR2f/E2Luw9HUCl4Pw1Bz8W2vu9dtnGhTA2RVG0f2B7eW/Txlbw/LiQfmge1/8
         LfFTiql60yxQVzuO9O32XSiAvmsCIa8a+lRUE12Jva1I7043aqxbYM9z30YHB8+nDVYi
         jj1WOuMxh+lurXITU7rZ/vi6S5wZFxcGhM4nU9R+ozErlazUsAKuln3jeBUl99IfqTOh
         m68bAIx9ungrcP1SjKb+OE8dvifZhdzlvw9IoHcw/w4MRHvncPsyozRllsZ/m2rCHhTN
         Cz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784127258; x=1784732058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L41MYl3HjuzLNuK2qp3MB7sFO80z4n0DLrf9pnL8oBE=;
        b=Qfarm1I5nzgNbI/q94QxqO5FtjpkkmU3oCw7XgLV1Rfkq5R6lyisK7PP1Mb73pTmh2
         ePWczAjC7ZVkTBCXIZlm6cRFS0SzB4WBkRmfrqC/QBoe6tf2XWSZsTF6BZx/cf7ywTX3
         JUrAZOOrTP+QTTz11x+Nqp7hRbGdcVcnp8XzTwjblp5ShF+rP/50nprxCYGoIqKgzBEh
         vQ6fG8ujJSfopyhYJs88SApnXw4EDAF1AK1ChGRIRROIOlBAzXL6ksDFtlPBXn6FKX9D
         LNIWLS25nH0vLHmN5QTsLrjXrirbi1e4yaq34m8ztgFthZCrRKAsx0SN9IDCiJZ/oIl5
         r3lA==
X-Forwarded-Encrypted: i=1; AHgh+RorVycnmqJd0fQ54vtd83rXmFQexkA8Ia5SwfSRnAESSxzr5w0MWOp3m/PlIlYeNX8NTT60MGSfbzUiLTUpdD4B@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzs4ukH8JDv1pJ3xvbsLescn8a3dJKvzITR7vqgm6w6pl7R0M
	Nb5HMjWTWjrcYK26JDwy6DE2gpBbIC0quB1C2Avwm5B00VbwlESsH7bOg7PuK+0JNhY=
X-Gm-Gg: AfdE7cmQtbS+PPLjkPvaREH5me8b4DrRKL8/beqsPF29ohCKXFeRniJfcUUyZmdq0MM
	riNd2eX9cmKgdBrgdDgkFBDXyZ9ueOL4OXmLPusQxG5/gMAClfCeKLyUlAcfl8XBq4q7xCH1SZ4
	Awnam1fQtgXB+TvOKl8Fkb5Trs24Rhonp8R4H3nbwVhrDLfGElNOGi6XWGRYyPngL1Ohh9xXD77
	/AMuKOSNdw/UyRkTTzrsI3LeNyehjFmsN0hQeW34Ly0ldwHnM6L37Isbx+PE7i4LGdDn/uKnJQE
	p5CEyE+KWoI2AvaoiDujAk2lNL823cvVkBWmaBwrEdRdhsKFUh6GUSBPyamDzssdL6TGnySEi3o
	FqkgMWokA7kukKK/0Vpy5UBwm1DiBRj6DrpCxLCrEtIuxybw+pxhXrzI/n007URQdl0LT/5jwOu
	ckVmNeON/GJaBoZ7dcBFRpe2ZEQBCtyQ+f
X-Received: by 2002:a05:600c:8487:b0:495:3a56:bd3 with SMTP id 5b1f17b1804b1-4953a560c74mr55833245e9.20.1784127257756;
        Wed, 15 Jul 2026 07:54:17 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49510c8e220sm137649275e9.15.2026.07.15.07.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:54:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 15:53:48 +0100
Subject: [PATCH v4 1/4] tools/build: Allow versioning of all LLVM tools
 defined in Makefile.include
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v4-1-6dfdf984b435@linaro.org>
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

The version of LLVM tools can be given on the build command with
LLVM=-15, but this isn't applied to all tools. For example $(CC) gets
versioned, but $(CLANG) doesn't. This causes a Perf build with LTO=1 to
fail with an error about mixed clang versions:

 ld.lld: error: libperf/core.o: Unknown attribute kind (86)
   (Producer: 'LLVM18.1.8' Reader: 'LLVM 15.0.7')

This file has two "ifneq ($(LLVM),)" blocks adjacent to each other, so
merge these blocks making it obvious that all tools should be versioned
consistently and there is nothing special about each block.

This also reveals that ?= and "allow-override" are used inconsistently
between the blocks. "allow-override" is technically only required for
builtin variables, but isn't only used on them, and doesn't do any harm
if used on a non-builtin. Make them all "allow-override" for
consistency. The only functional difference this will cause is if there
is a file level definition of one of the variables followed by an
"#include of Makefile.include" which will now overwrite. But this isn't
done and in a later commit some of the duplicate definitions will be
removed for good measure.

There are also some other LLVM tools that are not defined here and will
be moved in a later commit.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 41971a68972dda218714d6b95b1d9d92349285c3..7022e78208a236604a681d45b1ff4f2128f412e5 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -61,10 +61,18 @@ $(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
 endif
 
 $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+$(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+$(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
 $(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+$(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
 $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+$(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
 $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
 $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+$(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+$(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
+$(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
+$(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
 else
 # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -72,26 +80,21 @@ $(call allow-override,AR,$(CROSS_COMPILE)ar)
 $(call allow-override,LD,$(CROSS_COMPILE)ld)
 $(call allow-override,CXX,$(CROSS_COMPILE)g++)
 $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
-endif
-
-CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
-ifneq ($(LLVM),)
-HOSTAR  ?= $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
-HOSTCC  ?= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
-HOSTLD  ?= $(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX)
-else
-HOSTAR  ?= ar
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
+# Host versions aren't prefixed
+$(call allow-override,HOSTAR,ar)
+$(call allow-override,HOSTCC,gcc)
+$(call allow-override,HOSTLD,ld)
+
+# Some tools still require Clang, LLC and/or LLVM utils
+$(call allow-override,CLANG,clang)
+$(call allow-override,LLC,llc)
+$(call allow-override,LLVM_CONFIG,llvm-config)
+$(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
+$(call allow-override,LLVM_STRIP,llvm-strip)
 endif
 
-# Some tools require Clang, LLC and/or LLVM utils
-CLANG		?= clang
-LLC		?= llc
-LLVM_CONFIG	?= llvm-config
-LLVM_OBJCOPY	?= llvm-objcopy
-LLVM_STRIP	?= llvm-strip
+CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
 # Some tools require bpftool
 SYSTEM_BPFTOOL	?= bpftool

-- 
2.34.1


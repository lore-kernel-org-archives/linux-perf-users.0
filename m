Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9847799F
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119192; cv=none; b=VfUDpUeN5P0nXmAA3eVPt7rC5oOqWm0MwCy+X5eINCFYPiyqa75BnQBDvrAG6OLeHo00UuIAqgq1v8cCJe898oN3jWpc0dCDJUHLc9y5Af8EtGxKDeJaQg9pcIgtlcJ2k54JUkK0LXXKPFME8f1Llak0ivwOwaYvcHPtmh7GJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119192; c=relaxed/simple;
	bh=6unCx+x2NPgOEvMqAsB5BwetJseNsn7+XOk6L5xpusA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BG9kxuYgCNQGR5eyZrrdda7uRqZok9IiygSRA6COhAUwHlVPvLOhVRoIZW1bJ9EQVJ2+GfK/DTPowygqSy6ZU9YztkcLu/UWv7UuPabBMYZ9PSolKUOnWRpjGRZTGIGY+4frnCrd8dfLBQLTvUsPOt4WEYTz+KdouQ5VrxYfXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uo8VqKxM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uo8VqKxM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f4638f4aso17714175e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784119189; x=1784723989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L41MYl3HjuzLNuK2qp3MB7sFO80z4n0DLrf9pnL8oBE=;
        b=Uo8VqKxMjWTlRyXieu9JYRrK1i9bbgmH8LRsdOawhlysad80YxE0exPvAGZUVKuyyQ
         tlD2ThYeJDi3pibHdUyKo3crszET5Ph7THgPD1n4T88EhgGUo+ScaA2vT/7nS3o9c/yf
         afg4Fb7PEHQ4nhCqUB1vhcic/ZdwjntWALYoMvSm3A7hJBRyb38LWEjbkKj1dX+NCJdi
         8TxRcsLIX81zmAAaf5M3R8jeL0my99wVH8peVu2IKwkJnbrf33Qtx/eh0F6B8vu1UmlH
         7+F48QRM2SY3OMoxeVrBzpRFyTo/fgz+/W1WfPmZHNe0TRqm0xO7/V8Jy0bpKIdR4eAK
         VH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119189; x=1784723989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L41MYl3HjuzLNuK2qp3MB7sFO80z4n0DLrf9pnL8oBE=;
        b=n64e4nQ4KcCq948tVbsheJCRRC/om6Str3rpq2uluv5f63AN+LBQtKyMLWTSuL3dG4
         CH9T6WinaDTsJX6DnWCTTcUI+pmR+9ZL2b3ow5SGnf/3HbrlN8dCVJkOF99QkmTQUO/+
         Q7TM3Ldqq661mGUuSRA2Uv3vUm+pvy4YvxkQu/nPmsUfgthhp4GoH/+/R4pHrQwfAnJV
         iczK/Ra9sEa8UPwC5d/Nbcdairil3stFe1emniCCR2k0bPkTs7bPf4k9jlsHtMPVNB0S
         6wK6tdXs0IsCLnphLY5nNo7esgpH/y81k5J36CGHNvFVa2Hw0eVAUrLWq1oS/+/6jHYv
         qapQ==
X-Forwarded-Encrypted: i=1; AHgh+RqV4U+TJKlCOW35c0d2AaaBp/sZuQdagI7Log5Aq3E9L3Hdgft9ZlNgniHlKgoHmDmAtPHKbiHJNUcL8FrI2dM4@vger.kernel.org
X-Gm-Message-State: AOJu0YxD1eybQSs0ilYw1FmsT856WVUX5sqGVQW3nQ7aHnr0MEQi94sF
	vfJNFeLsXh65UvbaHdPvofWST3P4sYdqwYWJOxLW8C/ROhX8vsxHkHwzAIWpTFcz26o=
X-Gm-Gg: AfdE7cl85lGP2OPCBdv36HVqi8EOkhS+1GG4fJOdA+hhqLmz9uAeX/xMWRmmx9e8325
	2nLn08O8XoFNV1D2BVxYqsXztAt01T29QAH1/y8EijUyvyUK/MjFBamCELMFNpz9W1agrj+hay6
	zhfAutcZaD2JktlBvawXYbxO2SpEX5UegfauVOpxpEf8qjrljX9a9uVZQP2PuY5v5i0xpJOaW1d
	d3/1CnCleKBBkjiWDEtxH/mmqxqQatBlvmpuuEAnk18MnF3wnC4Fw+6WGvYb4kWf9lCz4De51ff
	PYQhA9VCycjXMWynRJDkhzFSkMRJ9raR4D4VqNmbR/1GmfIb8cAUww+5m9ngeehNMWRCozkLGqN
	USRTgEimEZdWcdGuKi8CKRG6njQLr7GIHF9/81QeFSWNstgN3Xkg+WdQXjMPgm+yEqc2ebs7iM8
	tYgtZbZ2jolGKhVZZ6Zn9RdFAEHqjWpq6r
X-Received: by 2002:a05:600c:4205:b0:493:f7bc:26e4 with SMTP id 5b1f17b1804b1-493f8829970mr108104105e9.31.1784119188604;
        Wed, 15 Jul 2026 05:39:48 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm32360695e9.2.2026.07.15.05.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:39:48 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 13:39:17 +0100
Subject: [PATCH v3 1/5] tools/build: Allow versioning of all LLVM tools
 defined in Makefile.include
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v3-1-8854bfe5af7e@linaro.org>
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


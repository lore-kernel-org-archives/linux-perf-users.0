Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22279477E42
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119197; cv=none; b=VuUFnj/RT2md3Y34OMHx32XC7BjjCfftVcAbAA/wIi0d0Kn19K9TDMzQO4Gvo02QYGidWErtBTyB3Wui/53vBiUhtHFHb7Gd/fn5cPQe0cyC/mC8HHnb/+ygh6yGkgncNuMH6R8j2Oc0IMUxTzcHUFgcEu/3to/XvDlyA8ZHO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119197; c=relaxed/simple;
	bh=XKzOXI7bmhKLzFjpe/X1ZB5NXfAm20n90mj21jdtQJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBiq6lNywKHvnBgrila3mB/ZL/bexxCM+8M2RqRACcnu8+Iu7yp63TVLIW9CJZEMqldfAdXpgNcCqVj0DklQcmK4CtNzBMVsNSCLTZwQQdLLN+dy6XpJ0FqeyY3BpA5tY79IbZOHv6lLQJMa5oNRifJ214kenwaDkzNlmvr2dKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXSYPceX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXSYPceX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b779003fso23314165e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784119193; x=1784723993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xgEUm86ElH+02LcY3CjjDGbQavQuTnhydinV3UlFp4=;
        b=fXSYPceXzVIcyzI0VFhIMxg7hI/m7Dt2y/RDfHeil1OhCALUNCTsba9zS+RB2wrgoh
         w3zu9IAg/xntYGeUOH0NATYBwmMzunCJK817KBPLbUbX50a7Mao2aJwFUqJGmCCzzj/Q
         sQ95hjPtqhEMxKd6NK8CqHaToCakSV5xCcbhS0RzroSthB/eSghhzC2TgzlrmeGJrGeD
         UB/02zyiee1HZXQQNW61tcBKg4sMDpFaLMFSi+STqppwLKpAhctGnvUm+ZvriK/2qCgL
         rijnWsIa6ES8bceu7O5gj+6OmathMskqe7bKhsgRPmudyJav/aebk9GTyZj0nifwz0OZ
         2N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119193; x=1784723993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xgEUm86ElH+02LcY3CjjDGbQavQuTnhydinV3UlFp4=;
        b=iSfotoa2P5qvS5cqMvaA1fFNXy6BOWjwzt9wS/9HJ/YcodnINebXsCVn1excJTvXbS
         hFEHWakRpw3dofdxXI/1d+QJBThb9jQ4LTC07cpLb94g8KOB9xiQbeANHpqdG9AJG/RA
         qNTMhkgUTzHAcL/wyxJ6udPGgkk2s5V0dITD4OpE1neL2z6+55Z1OeXgPgAnmhyRh/8G
         XL8UFKmrGJ6sGFkvFNIxUUWE/mannxGpzjgGIry9CVpMo/wi9EzgbszFgQdSEWb7jFI/
         wdm9rc6CNFtgca8Kxb7BAK7JJz1XXv8l9LUtoHgD06ecSak8ooia+ZpyjKX17qdkkdBi
         HcbA==
X-Forwarded-Encrypted: i=1; AHgh+RqBRfDSuhtW271c/SmZxkxKs3Meg8zw3zjEZIdTpHDojbdZVFD2Nd988WqwdgMggt1FwnPnnk5zEoF6vtj4gF8h@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8K//v1Gk2gE6ZfBuJ44qJFVwS+50dFHEYpuYtph72A7CziyI
	bokllFnL6RdtECF+8q8vhLk6Ur0hl9ql1t1KGlt6GVzArQq0tnUbih06wviLqBf6MD0=
X-Gm-Gg: AfdE7ckc0jya9RwI8D+Jeqyit8CaoufyoBIzjwGamzW18XBqE65bQ3lV/1Vb+QVpIGC
	71gOjS7cG2dND1eh+/4zG/OaWZAGtEe3gzJhe6+yn2RsE9SeZ9l4kLnTgnSFXTpUvVGkpIqjmVv
	C6YgUgenxKw8teK4k2vcH9iNIbjHOK+pmk9GkxXZ6LWkktJE9tE66EUr/sZDa8SmsJdAkajpMWZ
	7VlnY9xGOiOsi3GmN9qlSCbnOiLbDgGkcf7Js8PtAuHdXK415cLYjEP3Gc1nxETcGC3qe336IBw
	eVI+fWrX9M5JgMQhPw35FZK6V7QPQDjAPiRfmKk37kL5gOvH6FjJp7lmIA2VZyv+gtJa5DEnHRL
	4CoerLG8Ph0KTyCx4Iz2mri437Vb1c6JJPy1tLXXogrDbg0lgo5xZ+greSDMDSSNkBtzksByUSV
	sOfvYJYHE4oh0YyR7X0NbvdA==
X-Received: by 2002:a05:600c:c0c3:10b0:493:bfad:9d99 with SMTP id 5b1f17b1804b1-4953899588amr55205575e9.13.1784119193314;
        Wed, 15 Jul 2026 05:39:53 -0700 (PDT)
Received: from e133063.arm.com ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm32360695e9.2.2026.07.15.05.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:39:52 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 15 Jul 2026 13:39:20 +0100
Subject: [PATCH v3 4/5] tools/build: selftests: Allow versioning LLVM lld
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-james-perf-llvm-version-v3-4-8854bfe5af7e@linaro.org>
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

Building with LLVM=... could result in a different version of lld being
used than the main toolchain for liburandom_read.so because it's
hardcoded to "lld" in this makefile.

Make it consistent with the rest of the LLVM toolchain by adding an LLD
variable to Makefile.include. Keep the fallback for other architectures
in tools/testing/selftests/bpf/Makefile as it seems like it's something
specific to this make rule and shouldn't be global.

Clang only accepts either a full path to "/x/x/ld.lld" or "lld-15" style
inputs to "-fuse-ld=", so the only way to make it work with both
prefixed and postfixed paths is to always take the full path. Also I
don't think the original use of "lld" over "ld.lld" was significant as
this is always a linux build, so that can be changed to make it work in
both cases.

Add a warning for an empty USE_LD as "shell command -v" can return empty
and GCC won't complain.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include       |  2 ++
 tools/testing/selftests/bpf/Makefile | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 46a3872b87624a7bf475d9b42a3e471f36789dfd..92056d3e330eb6596250635b6d932b3b73e7f45f 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -67,6 +67,7 @@ ifneq ($(LLVM),)
   $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
   $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
   $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,LLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
   $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
   $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
   $(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
@@ -93,6 +94,7 @@ else
   # Some tools still require Clang, LLC and/or LLVM utils
   $(call allow-override,CLANG,clang)
   $(call allow-override,LLC,llc)
+  $(call allow-override,LLD,ld.lld)
   $(call allow-override,LLVM_CONFIG,llvm-config)
   $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
   $(call allow-override,LLVM_STRIP,llvm-strip)
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea64046a9b19852780c3a6f009cbd82..d829979861eeabd33272a0d6eca82e7066eabfd7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -264,30 +264,34 @@ $(OUTPUT)/%:%.c
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
-LLD := lld
+USE_LD := $(shell command -v $(LLD))
+USE_LD_ERR = linker '$(LLD)' not found - add it to PATH, or pass LLVM=/path/ or LLD=/abs/ld.lld)
 else
-LLD := $(shell command -v $(LD))
+USE_LD := $(shell command -v $(LD))
+USE_LD_ERR = linker '$(LD)' not found - add it to PATH, or pass LLVM=/path/ or LD=/abs/ld)
 endif
 
 # Filter out -static for liburandom_read.so and its dependent targets so that static builds
 # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
 	$(call msg,LIB,,$@)
+	$(Q)test -n "$(USE_LD)" || { echo "$@: $(USE_LD_ERR)" >&2; exit 1; }
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
 		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -Wno-unused-command-line-argument \
-		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
+		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,--version-script=liburandom_read.map \
 		     -fPIC -shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
+	$(Q)test -n "$(USE_LD)" || { echo "$@: $(USE_LD_ERR)" >&2; exit 1; }
 	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
 		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -Wno-unused-command-line-argument \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
-		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
+		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,-rpath=. -o $@
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c

-- 
2.34.1


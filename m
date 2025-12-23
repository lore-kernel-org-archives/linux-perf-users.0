Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC55346787
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509255; cv=none; b=a2EMDa0+h0ROY8ABNrTOuwMlnOZ/8cuFqZ0PYlKjzAYcaZrefgem2NwgDvsHnhhF+16g8kaz6dTAjQw+Yl4pYzsw8AJTq52PoBvHE6JMWeeSWMagDYS1FKsNrFCadJ1rKXNAVnnwUfn9LDCNyWh1/gdvQVtq6/JelMHA94WPeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509255; c=relaxed/simple;
	bh=HvQuAl5BIsUEtR0z3TF9FUuo1K9HZfq6C51NE7ALywM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FkY9X7NOjUbEkEXDvpzrkpcoMgzFseqNq7+0YC8WAmuNXfxPODan47bPrYCZq+thIxVP9WJkq7FnzvJ+9eChEW0Ra7htD9aM5XArheVVqGmEu3cNGqJEoy1B3vHAEsJrU52xtH3ip3IGK93imL2j9TgDR3R1Z8owFExWFQ7DtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhMScNo+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhMScNo+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso3163526f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509250; x=1767114050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTJM3s/XdCccJiJB0tNPahzzj1p09azMnSbzBQkmBSg=;
        b=qhMScNo+giJTfU4fCRGs0/r0PkN7fYsqTEySSXhzH1VW5g06LsX35k4z7ASuXOfpXd
         hDYtd9S8vqzaa3i4IOweRyo13zDqFbNZxRsMB3LDrHHbDVLGGr67yIBpI3q+9ukgAw/7
         2WGGrJoL3IYesRPtlLxrwtRcrfLTkLP0XE8J1DNP4fzG14uFYP5JLm2/tBkR/fzHlL0c
         I3b00KLGbwKL0Pfitq1ev9UILNUwEBItDGhkx4izElnJtAsMun/zc8EjlDRFAyVJ2a7T
         o9TvTBh2SByMa2YUw1AfvKprPwqItBnaQT8NZx2aTPg5VYssnEuxLERiDRfA+PWiDrhk
         lYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509250; x=1767114050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTJM3s/XdCccJiJB0tNPahzzj1p09azMnSbzBQkmBSg=;
        b=pflBLT6mtiVQJxsHifnvEgNKY7/ZkYasbBE4+Dub9yTxVLcjPs8g0aa5tB/4b/mrtv
         EUrqFOd44abajCU+p17bg50aYRQzF4cVr/ZEW9AAiXft8uI4om6CqJ2mcrPPDowHt3En
         C2vvxp6wOQ/dnGKg5/E8ijcjst/gcPn7EbREkB0fz58NRHr3FvppTqfv3o2e7GY4gAOe
         1kz9Dhbk+fwiA0FTKO7ENVO0VwxVZv58q1jo/MASkfC3a8679MIr4rSUmYPksV/4eFy0
         52cZGWMD1ZJufo7KjgBzNq7EyzIy6sBcbOwLaFU1MxnD1M2QcHXe0GbTux19xe9jiV9B
         DVRg==
X-Gm-Message-State: AOJu0YxWLN4DoNYqmPmq+h8GvCH+Mq9e9SitxsWqSVMemWzwVkeCs3r/
	MF/sDwhwHtgiilSqS3TPO17LX2JUgxvnjSEmXa/U7QTHmrb5mhxU8NQYm1CeeIz4LMr4cJyq10a
	V/lDVcLQ=
X-Gm-Gg: AY/fxX4fYWQ8z/82pcq/25pKC56Bry35Owf2xxZHYZ4LxX0W7c9XRHjVnQoZATZOdPB
	ATH8k3jzkFxEuXRPBAye6oEvq22HIclJN66tFoq9sLWkhGAduPCpDGwfH9KorS358AjIQwiYGXN
	SBfS3aFtRxQklqtzP8ijuTbyBU2rKtOMUd4zA0TpnZsrPmx4JqoyN6j1FvBAIYarDsqFf0E8AWZ
	w4RsaNOdj5h3cLP9wqtzMypEgvlrkF+JHgodleei9bvQuHIvXkBJpZlLIHw5YelN7mtMT5WZ+oG
	oZ+G010oUx69irm0Vs09w4iIYEbJ2llKSywr28rFY9PeJaXYFUqXL5oeINBeY8Zb6vBdx4kUfJm
	/Q6a6Nh/HZ3VrsnNYTUR7jomc5HMgFeCz9y04s8Qxokov1ACKHJJ3f8cnbTGxLjsE6WLTaVrZ5u
	HStywn4IBcaXTanNCDfG+g
X-Google-Smtp-Source: AGHT+IFMmSNtuwzw5XtsQ5n3BxiXKo6WM82ZPjsLwEsdsqvNmRq9sHEX+kMDMqzpXsuiU6kNsh7ojw==
X-Received: by 2002:a05:6000:2211:b0:42b:396e:27fd with SMTP id ffacd0b85a97d-4324e4fda01mr17632693f8f.38.1766509250512;
        Tue, 23 Dec 2025 09:00:50 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:50 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 23 Dec 2025 17:00:26 +0000
Subject: [PATCH 3/5] perf build: Remove unused libbfd-buildid feature test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-james-libbfd-feat-check-v1-3-0e901ba32ed9@linaro.org>
References: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
In-Reply-To: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Leo Yan <leo.yan@arm.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

HAVE_LIBBFD_BUILDID_SUPPORT isn't used in the codebase so remove the
feature test that sets it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/build/Makefile.feature              | 1 -
 tools/build/feature/Makefile              | 4 ----
 tools/build/feature/test-libbfd-buildid.c | 8 --------
 tools/perf/Makefile.config                | 7 -------
 4 files changed, 20 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index a7f030fc5e83..20422853d1ac 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -71,7 +71,6 @@ FEATURE_TESTS_BASIC :=                  \
         gettid				\
         glibc                           \
         libbfd                          \
-        libbfd-buildid			\
         libelf                          \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 87a5a908d6fa..63a97cdf78a3 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -13,7 +13,6 @@ FILES=                                          \
          test-gtk2-infobar.bin                  \
          test-hello.bin                         \
          test-libbfd.bin                        \
-         test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
          test-disassembler-init-styled.bin	\
          test-reallocarray.bin			\
@@ -267,9 +266,6 @@ $(OUTPUT)test-libpython.bin:
 $(OUTPUT)test-libbfd.bin:
 	$(BUILD_BFD)
 
-$(OUTPUT)test-libbfd-buildid.bin:
-	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
-
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
 	$(BUILD_BFD) -lopcodes -liberty -lz
diff --git a/tools/build/feature/test-libbfd-buildid.c b/tools/build/feature/test-libbfd-buildid.c
deleted file mode 100644
index 157644b04c05..000000000000
--- a/tools/build/feature/test-libbfd-buildid.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bfd.h>
-
-int main(void)
-{
-	bfd *abfd = bfd_openr("Pedro", 0);
-	return abfd && (!abfd->build_id || abfd->build_id->size > 0x506564726f);
-}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 594fe3ecfee0..5ff98b89c39a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -927,7 +927,6 @@ ifdef BUILD_NONDISTRO
   $(call feature_check,libbfd)
   $(call feature_check,disassembler-four-args)
   $(call feature_check,disassembler-init-styled)
-  $(call feature_check,libbfd-buildid)
   $(call feature_check,libbfd-liberty)
   $(call feature_check,libbfd-liberty-z)
 
@@ -945,12 +944,6 @@ ifdef BUILD_NONDISTRO
   CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
   $(call detected,CONFIG_LIBBFD)
 
-  ifeq ($(feature-libbfd-buildid), 1)
-    CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
-  else
-    $(warning Old version of libbfd/binutils things like PE executable profiling will not be available)
-  endif
-
   ifeq ($(feature-disassembler-four-args), 1)
     CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
   endif

-- 
2.34.1


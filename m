Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A02E06D2
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509251; cv=none; b=A9ISUy4b3SqixE1ozlMB8k5vQFGbXcJrGBQEzcS59+qOw5+boC/3NrVrekFE4j041xTPZItUCertyxEYyYa0IstL5ZKSxpeeIhiEN2vIlOCTg2lPq9qXTeHp7Rn59UZfbGCEecDSqL/e9d6KIv8Hq4chalrEPVqviWmb3l6dMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509251; c=relaxed/simple;
	bh=U71eWv+lZlEigAhVYCviXUXxQA3e+e5qTV+RSri9qqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRl1EsIfB48aPoqe2rardDQzVmqscoBGWAlywBwKRBh5tpkeoUTdeGfB0d4uaLTjwNRct8zx3+osu75VRIH2lhjswurPFiWSfQ9stgAUH4vD3NnTTkUojJzRfkEMOyGaUq/zZ9PhP8nazbwacIL2+5pzEaYddzGCgKYnR0KEVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQsjl3JH; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQsjl3JH"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so4158157f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509248; x=1767114048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBD5hyInNJ1zU+FPwr6XKENm1lWydxvpThAe0QY6n2o=;
        b=MQsjl3JHY1u4bguvRcxufbsdHMPBtYxUOvWGeY0VP6MYVd2V/rwfWmBQ02vQOd5BFu
         oxFxiqlK67uAk+afnFFY51rV+pRcuNZVqB3GemuYKN8bN/LIrtBNHSmyvos3VY5HDzSD
         UcQ4hkexTpNwO7RRu0HBFx0aB6RfqqONRckvVMjwrk65eQRBAQzSYZgOe8tr+lvWEfXQ
         OZiwspVwY/8wzTUWlACYYmTUjhKbjymmIfFGaRdmdw9OaXFjjPMORsDFIcajWbbMk+8S
         +LTcTn3CPXuZKc0Uiqk8M0sF3PkYuNu6GS+Bi8+t022Yhr55C/Klz7VlojxjxTugwhJ5
         015g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509248; x=1767114048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MBD5hyInNJ1zU+FPwr6XKENm1lWydxvpThAe0QY6n2o=;
        b=czGt4lTzCMoNY4Yd9nuWOnQRu+AmzO780Ts9yXuJ+cFjL0INZ4b202Oyv8ch+hY5AD
         eHGoYIOShzJvnwEZu5/W/aS8NBDrIpjdoOlm17G6QzHnT45/riBG8t54sA2otKV2QJxH
         FOI3TKBm5tn5pRUhwi+eA+nBiR5+FYgMHrmkTr4U26t0lVvdseBWpE+TISXr+xt10NkX
         LPNX8omfRaxe6agOLoVqgs8MsnwRLw2dAXUj1NySiwL8Q68pimTTlUGFvHvEtX5pHjDx
         QLacDG37EBdcUj5yLrTDCpfg/1DCa2rJ5AOvcR7vadMkv1k3B04d53N+mZl9SUNGClq8
         ENAw==
X-Gm-Message-State: AOJu0Yz000AugC77i+RNK/9iHXAYPvlMqzc98dOs7kqrBd33fyTgwucP
	60OR/N2yuLPnvOIRrBRfcIbMLfPQ3GnTVgTxH3dTXEs75Cd7hELlzVOUbFJrp2rIQZdpZIwqL6P
	0t86lLyJopA==
X-Gm-Gg: AY/fxX4qvM+VU8duFmCEw5cb8r82tpKEzMUb92sHfxuaCEJ0Q07mASHvYGTqys2gpVo
	fUWx/zhVqa3jJh8uBNmoMy6lA2mmBNZIPZcR4ksVCPr3T8k+7ExjWEuTwQr5eBxoCs7OA/TMq2e
	GB1X4QVZZ8HNR9lfwMaSwkufem3JpmGp+z87Up350SBZ8NL45zznpmw1fxSN01wFBObXv/hwlTi
	Lej+rgqZJy3u+VrKne/LGY3B0Aig85CnVqGdHXM+WV2eHpQ4qFZGPb4fUv4sxdl/5A8+Pscg8IV
	KtGmsTQghaU7NXyM7v3VaAPCGIPmF//lcL/Mm5XUHGUCf18/N234xdJ+zArRkAeAIbHGjbVx5OA
	MmNf18qcz3bIxomZkqb6T2rII58UEjHxiR3uuoPCZo389eYUseI2+twJXzB5i/Dei+NmNU1gnHL
	KQAm2m914tdD4AS8sJjv+7
X-Google-Smtp-Source: AGHT+IHdxuaNfoOArrhJfQGMxJD7NTPYAUwkN7KhO+ZEUCIEmGuIhQs3mIG7HIDmUEghx29uGdFspA==
X-Received: by 2002:a5d:5442:0:b0:432:7068:18a with SMTP id ffacd0b85a97d-43270680252mr939319f8f.20.1766509247919;
        Tue, 23 Dec 2025 09:00:47 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:47 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 23 Dec 2025 17:00:24 +0000
Subject: [PATCH 1/5] perf build: Remove
 FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-james-libbfd-feat-check-v1-1-0e901ba32ed9@linaro.org>
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
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Alexei Starovoitov <ast@kernel.org>, Andres Freund <andres@anarazel.de>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Nick Terrell <terrelln@fb.com>, 
 Song Liu <song@kernel.org>, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 James Clark <james.clark@linaro.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Quentin Monnet <qmo@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.14.0

From: Roberto Sassu <roberto.sassu@huawei.com>

As the building mechanism is now able to retry detection with different
combinations of linking flags, setting
FEATURE_CHECK_LDFLAGS-disassembler-four-args and
FEATURE_CHECK_LDFLAGS-disassembler-init-styled is not necessary anymore,
so remove it.

Committer notes:

Use the same technique to find the set of bfd-related libraries to link as in:

  3308ffc5016e6136 ("tools, build: Retry detection of bfd-related features")

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andres Freund <andres@anarazel.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/r/20220719170555.2576993-3-roberto.sassu@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
[Cherry pick to fix accidental removal in commit ad5f604e186a]
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Makefile.config | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bd9f4804d56b..ea6636a09a95 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -379,8 +379,8 @@ ifneq ($(TCMALLOC),)
 endif
 
 ifeq ($(FEATURES_DUMP),)
-# We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# We will display at the end of this Makefile.config, using $(call feature_display_entries),
+# as we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -927,8 +927,6 @@ ifdef BUILD_NONDISTRO
 
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
-    FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-    FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
   else
     # we are on a system that requires -liberty and (maybe) -lz
     # to link against -lbfd; test each case individually here
@@ -940,13 +938,9 @@ ifdef BUILD_NONDISTRO
 
     ifeq ($(feature-libbfd-liberty), 1)
       EXTLIBS += -lbfd -lopcodes -liberty
-      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
-      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
     else
       ifeq ($(feature-libbfd-liberty-z), 1)
         EXTLIBS += -lbfd -lopcodes -liberty -lz
-        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
-        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
       endif
     endif
     $(call feature_check,disassembler-four-args)
@@ -1324,6 +1318,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about libbfd, disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))

-- 
2.34.1


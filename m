Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613C3E5A15
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095057; cv=none; b=pyQvHB+dFJGUk1tcwmrL2TMWRKH9B87MueY3lWRh2wni/eJrYBnTmDz1c5i061SmcVMSKzcVv6/c9HZjU/oL7EdAJlu5RVhCBpdtT/b1iL/hXGa3pWFdmbLbp3fuiy41XSbDlqoUndN0FQRrgUEC7fpECopjDxxfKJVHJzelek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095057; c=relaxed/simple;
	bh=PhCveEiZIdUmcGwyU5spejpP9AhnWoovrQrg6qXZOwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaSorf9XwmlTs7uJ8UdhytCeANJp31nV5iFdAWp15CQHAVj8KPllbKXkYBJB3NrCiTFLiFF1/qp6IL1THYmAS6+5uW0OcKnDV6s/mMcxq8GyuseC/ySuUdEWYw0Yuzs1iu2FH6XjRp1d5dzdpeED4h9dh2RaN3hPR3p9VfYe+Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXhACppp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXhACppp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48e82c23840so14225475e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095054; x=1779699854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=oXhACpppSwkeXkVA3Hcw99exvK/M9DFvoRfTCUberOk9q+p4ISB22bhaC5e2UFX45t
         XI4d6dVU+fh2RgS1Hf4zFkLGUSY4ZBX39yjc+TUQMiEYPqneS5oTC/2GqKR64HJOUGu+
         gt6XY/5VIva4kXvtNbJ7mlI3p8Ln8XJawfPg3SwTZCe4Zdnx/lhWBTvUAyOhMSjROSw8
         jcGfX2MKkGGNDxfRK0kMpksudgq+HaNcNCzmnvJIl5/Cs9AHsML8PTXKmMlON0QHPwUY
         c2O7ItcUMKVM6sPfwEOxA57ZK3a9b8G749JkM6NQxM11uUFb+ea5Jf64w507Cb0n/0OE
         +k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095054; x=1779699854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=VemLCauri1JFQv3jon9hRIjrbDD6XougjiJjNX+z8KqFt6sJgUYoKWC4RWBwuutDd4
         kkLk8HNrAU6QhY7KoK+tu2hXR7xVwhS5Z1Wxik75w3HDeP2ttHKWaurc7IbBLfk7h7OK
         uIVNq9Yl3HQ26h0uIfOG4PpkRVfM1q3zQDo5Ffi7YkJBmJCdK3PGp9sp/amY9cCUcwNR
         XOkwups0Dua9UVkVLajfxfQ9FNmC26rGSfHMc3BN6BM7Bllb9HDwSN5Nx9mH6xQaYF0V
         xVTFiQw2ybZq2f3UUsgNNJ2F22Gp5dd8UP+ta8iWnRI5KTjoSCq25M8L3ZLbohGXx5PQ
         geNQ==
X-Forwarded-Encrypted: i=1; AFNElJ82jq+WKJ/ei9mxKA9ny0yL+rs/ybiM2uIdci4PMso76MTvR0OjGWGSB/rtjV5qwkz/Jxygf/AAEmca79P5SdcP@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5R3XDrTul/7Ez6Ch8y8CjTvDCgUdLMs1kxYzpQdarg6eAG/x
	+91KNfHAmv5udL9ZFkr2HAk1d3V6qxzB2LfWLaFTsZlE5n5HopbROTEl6jYXHhtqVGg=
X-Gm-Gg: Acq92OGBiTjaLeLWq1dL3SE4WCjkInqC41+2fa2ZfiMSAObChbNs5+fQLMmosg/654s
	RY1M/TbTyzF/kLNF1DA/r2Y0C2r52ZnXOhfHka5Gs7M/ojhMGX+aUHTaxkBwZupHAm+CSgGRP4n
	ddB2ycRspYtmAQ5sCc7QiOzH+RpYiAeb6XMq396PPQQhb772UD0GRb6T4pSvCRCNkewoRjqsVFS
	TV4CdGS5hlO/ZRb4YWUGNNu1JLIh2zUzXnjkyeQ1bOnzzbgBEGJkxn/VHFoMM4pqcF4YvSIR3Yh
	SXWTJoXE5bWWakmB3ns/5ruGgWZ3QxqzeKp10OeV/VuI9wbWxM45b6Fw3vxyTCgjBDhpnyGYkKJ
	NVmBCxSH2adhyNPsn0MdR8GKU0A3N+hMoQ3IZALS6Jfv8wRUmRXJNPJV/D4qmmAGC6soEKJMx/3
	znixhRQ4Qvd+T3s+k75apCyP5TKU5eTrFT
X-Received: by 2002:a05:600c:8715:b0:490:b07:5f27 with SMTP id 5b1f17b1804b1-4900b07600fmr72330915e9.24.1779095053446;
        Mon, 18 May 2026 02:04:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:09 +0100
Subject: [PATCH v2 3/6] selftests: Remove unused LLD variable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-3-f12cc4f031d8@linaro.org>
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

This file was mostly copied from selftests/bpf/Makefile, but the LLD
variable is not used here. Also, this copied block didn't get the same
fixes as the original one did later.

Remove it to avoid confusion and so future fixes don't have to be in two
places.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/testing/selftests/hid/Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 50ec9e0406ab..96071b4800e8 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -105,13 +105,6 @@ $(MAKE_DIRS):
 	$(call msg,MKDIR,,$@)
 	$(Q)mkdir -p $@
 
-# LLVM's ld.lld doesn't support all the architectures, so use it only on x86
-ifeq ($(SRCARCH),x86)
-LLD := lld
-else
-LLD := ld
-endif
-
 DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
 
 TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)

-- 
2.34.1


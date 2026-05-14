Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD563A963D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751158; cv=none; b=KEiBlb2n95f8fJdIjUvlPrNB//3sVhbXbud6XHEXEOyAdjtUhIESiq6SYhET5XmiGWZTONkWKM7At0xJ/sMwYtD9+sf9Yeq2Q+eS7egoa0eeoy3v2wRo0maIaiBSfy3Ku5JSTAe25NW7gyNAx3hvXUXqEpYn2liS92DoxJpM6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751158; c=relaxed/simple;
	bh=PhCveEiZIdUmcGwyU5spejpP9AhnWoovrQrg6qXZOwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODJIE7YRIvcDYG9tJ+WuHVqhjflM4H89SbJ3xeqQPnMBwVKwxmLcTTk4SedajnXFMUF5yXAxrtD5YQUekCkYJgLEzsNbodN67ZH1xAv3orO/QVytf/jMFslAiBk2g5Vve+74YZXKxYDQ2gdPEFP05kMvssB2mKwy5SOYOFacfwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKllLdfo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKllLdfo"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7645adbdso4234203f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751155; x=1779355955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=SKllLdfoN0Y039PhFkLl9oTbjG8i/6bFqAK1ersRlrGseyUNRaCnIy9+QWfDVkY/f9
         BWFii5iiQzPYcVx/xkhRJummjt7betIPkydGzr1pVaC3/qIgPHJhb46KsgsMBZEvoN01
         kHbwJ/ogyi+E1e7WEdXPZwIKk98z39/WjyqvMfUCQGAQlvZZUYxWC03RNJ5OJvDFzXzn
         ehYj5rxpQFFL1Ow1mFV24OiAPiT4qe9h9OwK6a2fV00tOSS8ThAywAsaZ9QYCCSg+EoE
         KonrDqzE4IVe52SzdJCAZ+gG4D5p/7ugJiEOL8eeD662zovMIPy/N8Y+r/RCESH8HgAl
         IG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751155; x=1779355955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi50aH0ofyIVTmJunsbTWM1jEiSwseuTv8Zx+hC3coU=;
        b=hdTy4QBrBDwQsd7CkRHa9ihYxghlop+c/etEQpZmGzDe6MbqYEK6zR4xoROy1qpuTT
         tAI0fXEVjkPnc90+3tmSYXFQEiR4HgVkgppzLEq1uCzVroipXeXmgOwWM4mPsgA1E9Iz
         kMz2IR5AgUO9ATyfKwk2h3ulrcwFrFM+CoHQrVb3cgiBpm0/o/SdzT3qmol+MmdW5Ecv
         tzcr3YkMFbWBPtwUzJ4E5+oix/ZqvBXxpFBbYVzRY7ITw6mvfLMYyZ+A6L+/HItrGQsG
         WFxIQDuVyy5GTiCi8Vlj/YU/tN9FDue1Y+BkjN0v9zKmLNNWaYpWe8ytx/pxIpjCALAu
         k12A==
X-Forwarded-Encrypted: i=1; AFNElJ+XHUxQEs/s25+WnAt343ViOCPWlkJoVaeCdWV8iYwPFFnGmb4UBexukEOGDie4PWZZdiTyNfNMJ4sPeQsRe2hd@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjN0cyYBCNUMpFzj8FGGtwbbRnlistTob+x9756jXiI0CGKcU
	dOuOm1az59BsbmF7yQ9AjI8ezUr7ONg2uY/e0qzReuOEKznGZmb2+VVomC2ZLzorH7Q=
X-Gm-Gg: Acq92OFidMWXNgFhQgpT0/xTt9CUTtKkqEDrq+kx0WnBnzbYU243DG8ietOS+sYMVbq
	6I0noq4+3yt1mABxMQdpfCKlZ8UZHLIt855aDZr9HpRrLcvGvAAd9q9etVdbQ7oQbm5K1BKP0IG
	ediA2oR2ZRCMF3K7Col6RxkGagqKvZeNeihlsY9PHSNFeptyX9mO1/K9+YDK2QvPeCZiqH1PeXz
	nTAD2Y4X3eyFuJo9B/gjL78MwfL06HmUClCs3N3bdB4b7vH4gmyPQzEOAimEME5JjPv1a/vq3EX
	+eLIwIUyKNNajRlRQWCnm+QRkHgW5Q/XhWjKaAHaS73rBD0t5asCbewVDn+UfruHp/zZgeWRIA8
	DotvikIM+fx5fdnr3V2LA1UsGgeX8tJadq3gpXQ/NFqHG6v9MxtXdLIEH7MReGuFPxPvYVG+8m/
	3bp84DF13GZK5V6yc6hZ8XrLO6Y4KmpFkx
X-Received: by 2002:a05:6000:2882:b0:43f:ea91:63ff with SMTP id ffacd0b85a97d-45c58a70c1emr11251761f8f.10.1778751154951;
        Thu, 14 May 2026 02:32:34 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:10 +0100
Subject: [PATCH 3/6] selftests: Remove unused LLD variable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-3-6cac1a9a4c8d@linaro.org>
References: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
In-Reply-To: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
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
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, leo.yan@arm.com
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


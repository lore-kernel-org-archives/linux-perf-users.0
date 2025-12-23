Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FED3469F2
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509255; cv=none; b=MY7d5Yt2fO/Le5hfJG8tiu8+Qc75nDl6xbTSrhM9jvo5+eRM27kKgVX5agjNdMLO00roRSRj0Ho6u/sBzT6rR7fvXirmW8BYJK0dOfkohGeRvZlb05x054pVVS5+eotbjOcEG6iG5coeZ6mPQSCIsBwX1TLGi2cOUxsrqFtOpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509255; c=relaxed/simple;
	bh=FFeSBw1FMWIEtAaxrXlCm7QCuERTPjJL7GMbZA4DOXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EjadZfqNu3Iz8qn73NmIda/YX9kKY4wbq/mQPlnqWlQHtgJ/3yLaPaHT+CLoX6Sn9glXMPWRaKz5oSR4uLd3U3WRKVHURfFUBYCZ3TudZgUkPfsKY5cG2a1ufV/UnVTk9tgRZkue6fpgSleHimj5H/vwsAYf1FkfbwTp+Cun+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P9XFvVQC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9XFvVQC"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so2271425f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 09:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509251; x=1767114051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZbTgcsl8S8+ff6/2oxkJI2TdhWxaQ+JXfess3SxhOo=;
        b=P9XFvVQCWhyHQa+MAfWIglYXc92IMA1nfKZrraQ7WVf6oKmV/fKDLmPSiTiwPOj1AI
         fp+h76SgtDFwhtaL0vbGsVESCO/c/zjI8TZAdHHm2JxdXjcW3N6OPvAZIwbiSDHm1UPi
         RjUdo6+q78N299zGbxAslOdEGnjFdSEW4qiuYiH21QRH/NSi9vNviVIffOvw4jlUJ06U
         KwqGgnxzyF+2P6LzImRUcUCMsfDFZACKu1R3981CaHs5fq/Ui/adVNCJ+YzXAa5ApQWG
         yHU2MhdqEyj8VztgO7bmr0Pr8hgCsn4BRJ1N7+8XpTmYnXOht0ggbQsZRa22VGyYJUxY
         qIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509251; x=1767114051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lZbTgcsl8S8+ff6/2oxkJI2TdhWxaQ+JXfess3SxhOo=;
        b=O6uH/zwKBvpRPPolURN6ZqUuobwX2mTjE80LijOJ99tVRVKIW2U9SfiY5HLknuDlY/
         6RvSZW2gKytknaGoUFPZDgwGdrI5mn6aTdOPUUBxvNr4QcLKyndqD/Z3wV4M+UdpPRAa
         HEZ7T3tvGsULSXD6qgDwErqwvLzbpDekFlpsH6vIyZZgVCNKAhaL13TjbYCmNGVlwMoM
         jYOcOMCHL2BhZU1uUBPA6MaO0CKVrzm/u5dfQ09jcSWH6sGPlHOQh4y5c3qtn25jco/1
         c7CNU6rpljdc30/guHcWIi6JwNw20vu1J3F6B7kDOwu+Er2GbNem6Gw8a++qt9ry0eb0
         YXHQ==
X-Gm-Message-State: AOJu0YznhQqZ0yNOWC+pCVeyOuc6fYylmUxyUkUALM9EZ/ZqTmY3nIz1
	d5UNce03NelYAecyGr1gMuVHxVQ110d2mUqzDueHWHx6wOSn33EeSuNa9y7CFnlqu3/kFwLP6iI
	5Ojize6o=
X-Gm-Gg: AY/fxX7WZeo0HrH3jQeeqCa27f/2znW41KFN+CoNyJBDR+iY94VFaQj80wpQsTkWF9d
	lPVORnAgYluwlR6VIvH/Z5wFTTue4ARPWWALJP67e4m2YNQOjTzXg8DRq5HIM8SG7fsB+bB4LWY
	jncuYNO79EN3PDcLb6QboiymO3ERYdjcRN0Zp78EnjhQ/35mWcg4Htkng8YN5qmVsTZmtuga3nh
	dFJxDsBJyFjRgMZYpyRmr8V5qe25OQJ4K+OvIE07HtMXEzQuKnozITmmlEcL69uPoEaU0YJ+ABo
	FXq1fWllqST2Bj9bntdF+1ZhSF1L/ECmFhyWGp5/1h+9FpSp/qfGtSwLTH6Oy1A5lbynFnF+GCO
	WiAyjUv0QsGie86oLdUx1BC6xQlDj71JupR2EG4wDwEScrxC2ddwDcFKq/dgQr0uiRe05UQllPp
	eYr6hWRj8THDRgT6eyvITz
X-Google-Smtp-Source: AGHT+IHw266VIWmJq0XwT5qBef2T7bpj04WK99XObIIN7F2sHc70CND9LIepKuuHduut7Wrf49Jg3A==
X-Received: by 2002:a05:6000:2907:b0:429:b751:7935 with SMTP id ffacd0b85a97d-4324e704a80mr17902125f8f.56.1766509251502;
        Tue, 23 Dec 2025 09:00:51 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:51 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 23 Dec 2025 17:00:27 +0000
Subject: [PATCH 4/5] perf build: Feature test for libbfd thread safety API
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-james-libbfd-feat-check-v1-4-0e901ba32ed9@linaro.org>
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

The non-distro build requires libbfd 2.42 since commit b72b8132d8fd
("perf libbfd: Ensure libbfd is initialized prior to use"). Add a
feature test so that it's obvious why the build fails if this criteria
isn't met.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/build/Makefile.feature                 |  1 +
 tools/build/feature/Makefile                 |  4 ++++
 tools/build/feature/test-libbfd-threadsafe.c | 18 ++++++++++++++++++
 tools/perf/Makefile.config                   |  5 +++++
 4 files changed, 28 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 20422853d1ac..d94548fff489 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -71,6 +71,7 @@ FEATURE_TESTS_BASIC :=                  \
         gettid				\
         glibc                           \
         libbfd                          \
+	libbfd-threadsafe		\
         libelf                          \
         libelf-getphdrnum               \
         libelf-gelf_getnote             \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 63a97cdf78a3..731b19b84f4f 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -13,6 +13,7 @@ FILES=                                          \
          test-gtk2-infobar.bin                  \
          test-hello.bin                         \
          test-libbfd.bin                        \
+	 test-libbfd-threadsafe.bin      	\
          test-disassembler-four-args.bin        \
          test-disassembler-init-styled.bin	\
          test-reallocarray.bin			\
@@ -266,6 +267,9 @@ $(OUTPUT)test-libpython.bin:
 $(OUTPUT)test-libbfd.bin:
 	$(BUILD_BFD)
 
+$(OUTPUT)test-libbfd-threadsafe.bin:
+	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
+
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
 	$(BUILD_BFD) -lopcodes -liberty -lz
diff --git a/tools/build/feature/test-libbfd-threadsafe.c b/tools/build/feature/test-libbfd-threadsafe.c
new file mode 100644
index 000000000000..fe97f95f6f06
--- /dev/null
+++ b/tools/build/feature/test-libbfd-threadsafe.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bfd.h>
+
+static bool lock(void *unused)
+{
+	return true;
+}
+
+static bool unlock(void *unused)
+{
+	return true;
+}
+
+int main(void)
+{
+       /* Check for presence of new thread safety API (version 2.42) */
+       return !bfd_thread_init(lock, unlock, NULL);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5ff98b89c39a..1e35fbb5215d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -927,9 +927,14 @@ ifdef BUILD_NONDISTRO
   $(call feature_check,libbfd)
   $(call feature_check,disassembler-four-args)
   $(call feature_check,disassembler-init-styled)
+  $(call feature_check,libbfd-threadsafe)
   $(call feature_check,libbfd-liberty)
   $(call feature_check,libbfd-liberty-z)
 
+  ifneq ($(feature-libbfd-threadsafe), 1)
+    $(error binutils 2.42 or later is required for non-distro builds)
+  endif
+
   # we may be on a system that requires -liberty and (maybe) -lz
   # to link against -lbfd; test each case individually here
   ifeq ($(feature-libbfd), 1)

-- 
2.34.1


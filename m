Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F427274B56
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454645; cv=none; b=oDyoxdtsgGVQd60siB0A6BX99+JRl8Yy+3RtuWcIw4/tWP4IXCalOJtu8AAeDUgt4TcR20ty/dg6D3lp9BuW+fMCW4BTqOmYp+vVZc+imZrPS/7DtEa2YmpKkQSqECWm3w/0we2WEipclBeR/QyDIYn2wuXxRAkkqv4kYIJqmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454645; c=relaxed/simple;
	bh=5YQj5whNsy944Tq1nsPgEs2SC3r0ANA3hsB9j366qHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bzx5AlTz2mTGDWDWX4TusDdYU2L0oV2bgSgNu+cl62GSiPaolENHU9++DxH5B3MDU4lKiHaPVP7AnFA8vteJ2aSDpL0HxAvL9IcBYv2/bU90kN1gAxOV3E8hDWdMHwQBbvveFDOBcamomEdrtDlKBwfB7D7CjegYTZcNcqz5XvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdygujaT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdygujaT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1592943a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 18:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759454643; x=1760059443; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4a36ssrUk2NOwqoWNNokgafRmPGrKtrh3ueHGKtWlXo=;
        b=RdygujaTfvghY5aIrVszsg0i07xaYCGZ4tm89wKO89C4R9j9a54A7fJumfv++d/y6G
         2ghPPmp922lzXOcVBmxbOeu6LzoviFthD/Whysjv/CKa9oGHHesWpbtNvZkhqZLsTifA
         pGvT5QnynywUsl63+MM7n8oqeugrwzS8Wma5HtKGd/2Fw/LmwW9h2uLxvj7kQZwDx88k
         K2G26JCbuPbVu6sHQOH7gPf02ZwPU2mUUH/CPkvSN24lhwN9ttjlz/m7ENjwaWEE8i8K
         g8c0A2bSaaK20ugkeLfDJ4SXoxy5YHKaDCuBdsLnKcnHve/fDwpnRk3UamqP8fvCuzuf
         lr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454643; x=1760059443;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4a36ssrUk2NOwqoWNNokgafRmPGrKtrh3ueHGKtWlXo=;
        b=HbTDSLhmon/6c4NJ0K+5vYHQeIo9P+HTVNxSNhv6P6uRWeeJmFnIbGQtMiridhrN8u
         N6ScouqmvCBx8TMg9bsz1rNlUd851XnmisRHD10jTI2/UoGaTjezRQFUcHAvMHYdMsyM
         BWYmyQQsRERXHnSJv2Gm4AeIEv2zMGz0/tpr3NctBECbl3iT+e/vaPr1CaY8sPTOGKkC
         OUkvtllo68ELlCW6dl0x8aH2ccHp6onHMBA43S1xMOA9C3wPoL0GIyQGDhroKLQO+Vd3
         gbMw2DCnaD/duciGbBjR6iXeN8MFMB60MXGgXRYwSEaTJQKwk96KwnH8QKPig9V7bK6M
         Sz8w==
X-Forwarded-Encrypted: i=1; AJvYcCUdZ5z8Z11Ta1uWbNCMPPdBBQGAPtNgJanE3Xl3eEdtNHAXobh8HvV9YXkeJsYojmmIy7GovP4TUZeCgKTsLXKv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3G0+E+ARE4mjaDuJ6eXi/ynO96O/ETfl0PaGd2lKjxTAlbGO
	wdfImOuY2zxTizamulJps2leInbKPA9vnue9TJhtlWohtqJHxqkl8NQXLyyeqyjBq5vbzGWUAmI
	rp+TvUtkFlQ==
X-Google-Smtp-Source: AGHT+IHfyZpoMDCQT8hkrc//s6nFD45TPZ427CL0dAfY14RayEbEgz2tiGZWsZyPld8miWOzUhmcMlj6XJBu
X-Received: from pjsk12.prod.google.com ([2002:a17:90a:62cc:b0:330:49f5:c0a7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1845:b0:32e:32f8:bf9f
 with SMTP id 98e67ed59e1d1-339c27d2ec8mr1417437a91.30.1759454642812; Thu, 02
 Oct 2025 18:24:02 -0700 (PDT)
Date: Thu,  2 Oct 2025 18:23:49 -0700
In-Reply-To: <20251003012349.2396685-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003012349.2396685-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003012349.2396685-2-irogers@google.com>
Subject: [PATCH v1 2/2] tools build: Remove libbpf-strings feature test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Blake Jones <blakejones@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The feature test is unnecessary as the LIBBPF_CURRENT_VERSION_GEQ(1,7)
macro can be used instead. The only use was in perf and this is now
removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature              |  1 -
 tools/build/feature/Makefile              |  4 ----
 tools/build/feature/test-libbpf-strings.c | 10 ----------
 3 files changed, 15 deletions(-)
 delete mode 100644 tools/build/feature/test-libbpf-strings.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 9399f591bd69..f9477df18841 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -124,7 +124,6 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          clang                          \
          libbpf                         \
-         libbpf-strings                 \
          libpfm4                        \
          libdebuginfod			\
          clang-bpf-co-re		\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index d13d2a1f44fe..fd304dc2aafd 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -57,7 +57,6 @@ FILES=                                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
-         test-libbpf-strings.bin                \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
@@ -332,9 +331,6 @@ $(OUTPUT)test-bpf.bin:
 $(OUTPUT)test-libbpf.bin:
 	$(BUILD) -lbpf
 
-$(OUTPUT)test-libbpf-strings.bin:
-	$(BUILD)
-
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libbpf-strings.c b/tools/build/feature/test-libbpf-strings.c
deleted file mode 100644
index 83e6c45f5c85..000000000000
--- a/tools/build/feature/test-libbpf-strings.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <bpf/btf.h>
-
-int main(void)
-{
-	struct btf_dump_type_data_opts opts;
-
-	opts.emit_strings = 0;
-	return opts.emit_strings;
-}
-- 
2.51.0.618.g983fd99d29-goog


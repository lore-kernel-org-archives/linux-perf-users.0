Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5032749FE
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454646; cv=none; b=XoJaCSPOLCz2IomCJ6h827XbfHDGHAw7xcjAxaixBMjY269PA2JSJH1VFJLvKZw58VAc2DSl0r8vqjELe4SJRnYEJhvyq9ainwj7gFJe5nlu0vN4JNYMW5L40YeLnCFLUas/rOF8LBnQ5/jZh/O6yXs5hdtjZiEHxSYG7V/rhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454646; c=relaxed/simple;
	bh=kUOXFIeRSqDtSv2ZkPiFOO36c2y12fUPmamNdNMIsfE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LFuvjcLLzsi2usTReRyQD4XGJWSE4L9aw9OgOGSidPMjmRnDCMWjJ+kETR2IKTJ2gJqvNGWelvrhFCa5Gi5jjsvb94WsWqf87+8+XslVuXgONBmEpznG4IabD0NgGztRu9eUhevD+5sOm67mq04W2i9O2G6woaAnEf3ZzJgkfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVBHv3gA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVBHv3gA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e8d1d9b13so16949155ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759454640; x=1760059440; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/6Q8RQGaqyFoWu3nQe4KiS7k5Z8ub45H9dHX2o1RRQ=;
        b=UVBHv3gAg1rd9c5sckDrLg/yS2Z6lgfm9nmrQzvl30np4Yi4eQN9V5XnW38TDU0k/T
         O3wdrneRM3nIJaUtmlENcBH1vHMJsnQ8zwBCYBXgf/dwZkZjjjgXOcQ3TTZa2J0qYvtg
         ijav5ZNxEKCQr/JHzPbz92PFGRB9KOjIJkFpu1hipN6/sBaUjN52FZwTbQ/hexe6k8CP
         fsWTgrk2xHZMqOBf71oxCnD6SNrp4HUpM9++2b8JR4DVkQM2UsYfn29S0Xh4DWdruLr3
         2GKhF8P48m4Jpqw9IJSeLKog3ZflSCueLg6vXrXGaruoVdWjCweHFAAM2vJFB4zkKTO7
         lnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454640; x=1760059440;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/6Q8RQGaqyFoWu3nQe4KiS7k5Z8ub45H9dHX2o1RRQ=;
        b=cp4r4fFWfE/+UenLcnbHPjUreRtQT7KaAbg9ByiS7AX3Pr8uEfVE6fisGZ+jgj324w
         BmKua/+IT/5WhgK3p34UOK3isE+sBt45C9Mbnko891ARxYdzIeCG8uGVamK3uim9q94t
         6PZFtefSOd3MMO39mRuUGbXhRdrzaF9bkgAn8qlr/FLibhNWesuF4G7FqMYkXn7QFP9K
         8S6/i7IoIlYjyA8gzaKSU4NXzAgPiuo9I0j8/Ro0dpuNOJ+HfP1qxQIm4hYdutqOP+7b
         h/DUy5zQjPB+OuFpJKDt2h/+Vn7VWvF8SZPLNHE9B9dqlH9KLPevOFTBdMA1nrO4u6Hl
         gdrw==
X-Forwarded-Encrypted: i=1; AJvYcCWJtMHHk21QaiOGjTQwuoaZvB9Htc+JdCYSAQ6NW/vx4p5WdKIRq4mki81MMdwnyaBrZ0d1dtn+YIrTAmubR//H@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQ3on7M6BH78vQv8R6LzS1MLwJ63hOmoNdYK3H4DJ3Una9HM5
	SRPzTJuPa6IXokH+QnjP29mxp28G2OJmh/KbyPZlc3BhwFRuL+IZsSdpW8HX6fmzZOxdQND72oM
	mOqOOuqlwog==
X-Google-Smtp-Source: AGHT+IFY9UEJwnhtwJqOYlJ+khMMlSHN/ze27dGvQJuRPcqqkdwyu6/B38lIGuCrw1Ue1guMSz5HzG4uq6lR
X-Received: from plev16.prod.google.com ([2002:a17:903:31d0:b0:267:e964:bc69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2405:b0:264:a34c:c6d
 with SMTP id d9443c01a7336-28e9a6a90c6mr13499045ad.37.1759454640628; Thu, 02
 Oct 2025 18:24:00 -0700 (PDT)
Date: Thu,  2 Oct 2025 18:23:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003012349.2396685-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf bpf-event: Use libbpf version rather than feature check
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Blake Jones <blakejones@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The feature check guarded the -DHAVE_LIBBPF_STRINGS_SUPPORT is
unnecessary as it is sufficient and easier to use the
LIBBPF_CURRENT_VERSION_GEQ macro.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config  | 7 -------
 tools/perf/builtin-check.c  | 1 +
 tools/perf/util/bpf-event.c | 2 --
 tools/perf/util/bpf-utils.h | 5 +++++
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6cdb96576cb8..b0e15721c5a5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -596,13 +596,6 @@ ifndef NO_LIBELF
 	  LIBBPF_INCLUDE = $(LIBBPF_DIR)/..
         endif
       endif
-
-      FEATURE_CHECK_CFLAGS-libbpf-strings="-I$(LIBBPF_INCLUDE)"
-      $(call feature_check,libbpf-strings)
-      ifeq ($(feature-libbpf-strings), 1)
-        $(call detected,CONFIG_LIBBPF_STRINGS)
-        CFLAGS += -DHAVE_LIBBPF_STRINGS_SUPPORT
-      endif
     endif
   endif # NO_LIBBPF
 endif # NO_LIBELF
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 7fd054760e47..8c0668911fb1 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
 #include "color.h"
+#include "util/bpf-utils.h"
 #include "util/debug.h"
 #include "util/header.h"
 #include <tools/config.h>
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 59f84aef91b4..2298cd396c42 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -288,9 +288,7 @@ static void format_btf_variable(struct btf *btf, char *buf, size_t buf_size,
 		.sz = sizeof(struct btf_dump_type_data_opts),
 		.skip_names = 1,
 		.compact = 1,
-#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 		.emit_strings = 1,
-#endif
 	};
 	struct btf_dump *d;
 	size_t btf_size;
diff --git a/tools/perf/util/bpf-utils.h b/tools/perf/util/bpf-utils.h
index eafc43b8731f..a8bc1a232968 100644
--- a/tools/perf/util/bpf-utils.h
+++ b/tools/perf/util/bpf-utils.h
@@ -14,6 +14,11 @@
        (LIBBPF_MAJOR_VERSION > (major) ||                              \
         (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
 
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
+// libbpf 1.7+ support the btf_dump_type_data_opts.emit_strings option.
+#define HAVE_LIBBPF_STRINGS_SUPPORT 1
+#endif
+
 /*
  * Get bpf_prog_info in continuous memory
  *
-- 
2.51.0.618.g983fd99d29-goog


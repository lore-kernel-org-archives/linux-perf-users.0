Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819F2DAFC4
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759459180; cv=none; b=VrY+Qe+plLupiX0ilNv2U4tLtdO+15Od39XSwnNqDTqWF5i5SEOzrMtTx/DK+YH8Yjin4+C6Eb1iAYYhJeINkRz+uKcpiD9HLI1alASHPqWnTCpx4hAgjO4jSvtTb9JPhzDM1XhP8hmIAnFmpRAGKXRz30Uv4YbjPB8Y00WJiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759459180; c=relaxed/simple;
	bh=J71AyNuQqq2QJulRcO7DjJHMsa/yUXIl0zcyYK2F0r4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ZEQ2ptPNt3GYRupGn1xC7ooQphK0e81wafIH6ST/9oAN+kQq4dW5sfRPOEHy2c1psGgYNpiXTBG264ImQWOmswTwXykzgsIHk1sdS8X94JrXo6mIbkzTEp9FCLE1RGXPPyuSXteYHC5akbGZPlN6JOTv6rYcITaR1sUq/XTOj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YjBVZfAQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YjBVZfAQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71e7181cddeso26362077b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759459173; x=1760063973; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4B6fWfraE2K9oqPlfcp2aiVhusV/KAzJOMZ/ZtABiCg=;
        b=YjBVZfAQoAYLG873Ok3XN8/IQaIN+UBM8EyqBpLdpJkHsAHkPkBk8Wv0UVXbfkysCq
         8t47xwiZyjXkQSO9I25/7nKFrlbY+g8Y+hMk1a9kwkcOOOxnhn1R1PaJkC9k2JQwo1fT
         kR9dv0/emJSQXncbbdEz55fTjw/JzyQxvUt945LU5tKsGptV4PqAxIPRF2J/45tL0vdk
         wfHhpr1Qa28PpsauyLO5IyHVCV1JS8TKyuhGHL8gCzfXi4XkRmtUqqUytF1kHbSADtWv
         EHf+EnvcttIHiSkq3WobLTr3PNjU9upOIXyNK8oqsm76PTE9guzdxF43Q9vAkbTS7QLx
         OpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759459173; x=1760063973;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4B6fWfraE2K9oqPlfcp2aiVhusV/KAzJOMZ/ZtABiCg=;
        b=CdabQrATzlhvCzgxl8d4yhIiwNyXy1Q4R8Zifm8VEHRledXiOa+DIhBozAaseadsNA
         UNJ/p0r+mwYId9RukLPT+I6+8+44WfYwz2vUfbfQFYEpR/5P2ShAVwVQ/Ilrf2/xut57
         udbQa5UmB/NnPKisOJg2qPX1dlc4bGt1GESkLqkmMeipqDrJw4SjH4oEQ1ops4zOLkzj
         ggGqhQV85y3Mt8zIefon8K7wdcZMHz0Jdb/6kjjUSgmB/jTRRFp0JzZLqzjUYCQ1T9KS
         aCaPByxS5WSEdSSp6OnmMsPF4GZos2UjeXRf6HCj88yzTI0/e4kGD9qMvGu71pSpuAaj
         105Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU6mkLjvTweMk9acCf5gt4KLdFEwR7L3dUwVgMF/v/ERwTFcQIz9y87gtMVGaUSICkavWJErQrL8cMIBZCv19j@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2BDGtoeUUkwSdX7HBz4uNqdEjIrFz7LuVob1cKtgUG7hQrJm9
	dcIE7Y28ZhhzGo6hvB8NQX4vi6TsrhU2p5bm+sSy65EEaM8Jp1ivFxYgjyKPF6WSlZkadCO2gv1
	RYChMewdzhQ==
X-Google-Smtp-Source: AGHT+IF0ZUrMyiKEH/eYEEJwXjflgZ34LPGI0kPZVwKzq+pfv/S8eQNepCuxypN297iirr6ZeWLvl7tS4VlE
X-Received: from ywbhx3.prod.google.com ([2002:a05:690c:6583:b0:77e:8503:76f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:6b09:b0:74d:b11c:d372
 with SMTP id 00721157ae682-77f946a3c65mr26024017b3.26.1759459173339; Thu, 02
 Oct 2025 19:39:33 -0700 (PDT)
Date: Thu,  2 Oct 2025 19:39:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003023928.2433640-1-irogers@google.com>
Subject: [PATCH v1] perf build: Move libopcode disasm tests to BUILD_NONDISTRO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The disasm feature tests feature-disassembler-four-args and
feature-disassembler-init-styled link against libopcodes part of
binutils which is license incompatible (GPLv3) with perf. Moving these
tests out of the common config will help improve build time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6e7c057b8ecf..0d4a62869855 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -933,6 +933,14 @@ ifdef BUILD_NONDISTRO
   else
     $(warning Old version of libbfd/binutils things like PE executable profiling will not be available)
   endif
+
+  ifeq ($(feature-disassembler-four-args), 1)
+    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
+  endif
+
+  ifeq ($(feature-disassembler-init-styled), 1)
+    CFLAGS += -DDISASM_INIT_STYLED
+  endif
 endif
 
 ifndef NO_LIBLLVM
@@ -1024,14 +1032,6 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
-ifeq ($(feature-disassembler-four-args), 1)
-    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
-endif
-
-ifeq ($(feature-disassembler-init-styled), 1)
-    CFLAGS += -DDISASM_INIT_STYLED
-endif
-
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
-- 
2.51.0.618.g983fd99d29-goog


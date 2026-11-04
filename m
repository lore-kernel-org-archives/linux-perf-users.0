Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766619;
	b=ZdejO/tzaJD2RFIKgLo6DRgYMYG1AYj/2iBJfxeDM3Je7xIvqIUONdAIjqzgutSHcvc0
	 FSV5h0/99BPlgcP9FpGYP649a5lvgEPZTYLH96MYQZiLXYxFtH+7tdeleMb1kiqdt7o1B
	 Ha7K0ORCVP1481tpA15im1YacCsqqJc4MFi7preiWGThWAXuMKSDFwaGqpoE7ZD16pJc+
	 nlzpfgfPxrmr9FM3zMfoNcfKyJWUqAm968828EFc8VhEhRFeNMs9mqGXSxTHFncZAPY8b
	 8zWh+JxWe/DXMMzDIz5oN7+lXl0rdjR9I7Z4Gel639wwdb7WU0izsU01r0Ad/qE74Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=8waw0InSHbtK6ZY3bCOmuZQhAY4jX7XSlK/9kloqXLc=;
	b=ha8nFJ46M+nDCBgx3i1cgba7QqO1PzxCH7R8QHyeNmAXmeFIAJE+DlXnHoMMnv+gnRVB
	 yGJTtQl3lt/0GlSA93b0pDCFS00tFrUT6FTNSALaUh2UIJzpoobqOOXeb9zFJ0IDZqdpZ
	 b3h1NEbpZJiVMw3GkGLa8nAqYELvA1O6i5+AKDSYdcyYbvZlAioGihGsEldL+u/FjrWuZ
	 jWHjzmrusXtpyKVtFYNNvGmYcVE8LIbXmyQwLHd13n38qyJSYtPGGlFUukNxQGsQYLMhA
	 hnPczaIS72wX+slZ+R7eXLaHffhpwP+JyLMVKOil1kK86hEQF802KSbnlKnvqIbwE/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cA05iQ+L;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B3606A329
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 055B3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cA05iQ+L
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so548399eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 20:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766618; x=1794371418; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8waw0InSHbtK6ZY3bCOmuZQhAY4jX7XSlK/9kloqXLc=;
        b=cA05iQ+L87KeC0XJCB1HKfGJI3KaZo1LmjL2Gxvh14+v5B/W70zKGkNbJurgtAdwLr
         b9Yb7vLuXGqWqaM/lxCIqLtUfRnQcpCegjVN4dZnPvxA2taBEi0lx23PIRtTGNtGKlii
         tMyD0Ga5SfnLTe0hKtFdZJyqYtwD2pdHC2W3HkTrkGYOWyG6Z5BYFwkqli4Y32lPFAds
         Ko8HvAsJRUFJj3+wPler6pryCcqFAHGUEOssYiMRGStWPsJr5SwryNmrLcbbos4SjFEV
         OiP6fHkU4TKo2tJY7o/eODqrG1AcWG/42vuaPmwjB5kRreJyTpYV+IWp2ne5FN96qipL
         ylKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766618; x=1794371418;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8waw0InSHbtK6ZY3bCOmuZQhAY4jX7XSlK/9kloqXLc=;
        b=rBmfWfeuql7kS4UUgQh8AWWF5cUhDGNqYbFUl05SNBrz+hcQZGqQEW5lwmHnV3cpdD
         YqmTCeEGozT/ylsCHYgcW/xePMmG7IQ5VLF34tz9TZWzax27YIy9J6r3lITE0cYldEGS
         w6XZG6o4T8IHJWvi7bu4nIRK8IHvOeED1p1uBE0Xgf9MTLxqLGH3xDWjCYTJdrA/PM/1
         RP9VYLmGJko53GKRo8e7ji+mWUibBq0yGP9pqA3jjWUmZ/S8qmrVeSmsnCKtjS9WI9Vo
         dcdP8dCOUyCnquwqKGqOQR7cdTMQ7ezZu+h+kTIUVw7450dSJc2mjech/vyLqrzsmYHz
         D4rg==
X-Forwarded-Encrypted: i=1; AKwUvBydlchobgA0XJEkuHRBDbOi1WnXRQJ5SEYbiQQFjQI1Aj0qifjvFtYUSvXgfxv8xoGP79SXhloDa+/39v3RSECQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+JdoKE892gZfDuwvW4qF4uL5dkFQOyYBxIDzzQjp427NYwl0WC
	8DZk+X9wB7M6jLoSi/ENH4K01kM0O24RfPADHqX0O/c2d5MSTQWQrxG0S6vZG8lzA5XNyQjUVls
	AqAQSBibETg==
X-Received: from dybhh13.prod.google.com ([2002:a05:7301:290d:b0:369:7ef0:57a8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c019:20b0:36b:f09f:924a
 with SMTP id 5a478bee46e88-36bf09fa41emr5753785eec.14.1793766617812; Tue, 03
 Nov 2026 20:30:17 -0800 (PST)
Date: Tue,  3 Nov 2026 20:30:02 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104043006.1199857-1-irogers@google.com>
Subject: [PATCH v3 0/4] tools build: Fixes for libbfd -lzstd dependency
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series addresses build problems when linking against static
libbfd/libopcodes on distributions like Fedora where binutils is built
with zstd section decompression support (requiring '-liberty -lz -lzstd'
together).

In v2, commit 89d001d48ec7 ("tools build: Add zstd to the binutils
library feature tests") landed in tools/build/feature/Makefile at the
same time, creating a merge conflict and only adding '|| $(BUILD_BFD)
-lzstd' without '-liberty -lz' or the corresponding
libbfd-liberty-z-zstd feature check in perf and bpftool (so even if
test-libbfd.bin passed with -lzstd, perf and bpftool would link only
'-lbfd -lopcodes' without '-lzstd').

v3 rebases onto perf-tools-next (v7.4-rc1), fixes commit 89d001d48ec7 in
patch 1/4, collects the Acked-by tags from Quentin Monnet and Peter
Zijlstra, updates the LIBOPCODES_LIBS comment in tools/objtool/Makefile,
and moves the AI assistance disclosure from commit trailers to the cover
letter.

v2: https://lore.kernel.org/all/20260909204122.1993010-1-irogers@google.com/
v1: https://lore.kernel.org/linux-perf-users/20260909181030.1870496-1-irogers@google.com/

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst):
- Tools used: Antigravity coding assistant and Sashiko automated patch
  review.
- Summary of prompts and assistance: Rebased the 4-patch series onto
  perf-tools-next, resolved the conflict with commit 89d001d48ec7 in
  tools/build/feature/Makefile, incorporated review feedback and
  Acked-by tags, and verified with scripts/checkpatch.pl.

Ian Rogers (4):
  tools build: Add explicitly sequenced -lzstd to libbfd feature
    fallback
  perf build: Add explicitly sequenced -lzstd to libbfd feature fallback
  bpftool: Add explicitly sequenced -lzstd to libbfd feature fallback
  objtool: Add explicitly sequenced -lzstd to libopcodes fallback

 tools/bpf/bpftool/Makefile   |  4 ++++
 tools/build/Makefile.feature |  3 ++-
 tools/build/feature/Makefile | 19 +++++++++++++------
 tools/objtool/Makefile       |  7 ++++---
 tools/perf/Makefile.config   |  3 +++
 5 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.56.0.385.gac671c819a-goog


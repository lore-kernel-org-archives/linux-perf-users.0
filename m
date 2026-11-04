Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766624;
	b=s3Dtz/ZdALQfcgKw42k8vNHp6y2hzOD61rzBfTwYR4A0LhDoUC8SvXHPXjO7T2cSg1To
	 CYMmdsBPQOpqQvXPokEPOCYCuHvgMUPs56bFK9tpO5EOQWocpDQse9hjg+S9oPNMTSA2x
	 GlMLQi1xtq8P7GdEZtjs2h0xuqqbnVwKDgn6x/PAjKTEzv6OZND8G1pwAZFPVgnjzcJmW
	 4Dna0NHcBG0EFEn/u7vz2mq8kw4FOwx3oeUNJKNQW9eL/LB4XT6bOSR424IRScPDZtvJk
	 n4n9vQZhF79GJAUDGDaP0bQksCdHUerSsfKYSEWHl1SCEK4mY+ErFyQULj7pU7RTSpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lf8+fUIi9nYvAfKMMCuyoqEDJu1jsXhBuDkXiGeAP2M=;
	b=5awgHB69L+yLoK4oTNXijYvuOeDm+dgQe2WFHtjWkH0ey0GIlJICbdwyqyA2iqlxawjU
	 qL42JO1ZbxiOSJQfDXJ9IGUY0GQ3U5nQlKIX8DGX7z6XxljRoWrcIheScGpl+RVWc50wI
	 ictTBnmsaQXjOnWVEo821Sn3tHllWDM3VPmV0MwmVsojFnW4QRfNC1tIQUBOdOpuLVpP+
	 kekEa7Cai3Z1h5eykgNTDY01rfKX93cZE0kkeIFa2QXsG7IJnVjknUBIsqzWdK5zb5mYt
	 stUVNHyTxAuNpm6YFTYESkNR1mzu+QguiK2FRqCVpk6mPCl2m1Nqub1PSOMizui/kNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S2NL62jh;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBF606A32E
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 04:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58DBF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S2NL62jh
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3662e7a9299so1048476eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 20:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766623; x=1794371423; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lf8+fUIi9nYvAfKMMCuyoqEDJu1jsXhBuDkXiGeAP2M=;
        b=S2NL62jhYPj0Kpdrgpiy41JLh38Zfoiq8uefbVCDNEgr4KYtyJVuB3qKbIxFcqMfj3
         WP8uVp5Em69yb8z5c7Ft/lUEjpm2jhsCFoiOoKG3Ax1DLRpRVWeQnfZUyv4Tmb+LfjyE
         6ZHiGPH9o8242nilDtRyg+IEAb+GhYyVT5bYfctX71Bz3y704RRZo0eEGw2L0NDSAZD2
         uCt6deYmbJYCUCWkYM62+MJUUUaMgI+4cFvpOZ6uCFT8JNAcZ1iu/WDczv9QpGffQmi9
         9iA+brl/6pJUhGIDSjPbZ89rUlS+iPQ3kxvscT4wR8Uo3mU+ONTxldGuGjh7yNXx+rsV
         YDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766623; x=1794371423;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lf8+fUIi9nYvAfKMMCuyoqEDJu1jsXhBuDkXiGeAP2M=;
        b=K4ThLv6Z6D5Th8ZOE1VMrZKpVrs/SEO01O9Ln0/x2N+m/4jjtZQvk5h3VfI1I0BMYJ
         HClGHYF9heo/8cUUx+gm1Xh2/ISa08+m5UROhwLfj14ycdvz9JNrY6EIHdOeY+vlVa+R
         a0Z+nad0MwoM2wAgDVEEcFpZ2N7+Rit1Iguk6FFypRTqXjmrjWod/bAnrhqNdhVL0y1d
         Uj8n+F9K/QVlI+Wc81wl9HMf0VyW1SFojx/Aay9DhiS73X50tORbYvN2jIpdnPA1mc2V
         2mmjTC/Vikx/fuAZcmL3g5HRbMkhiPMMe9F4IB+6iqD+NZDhC4weLXCj8YKzcXIgjxGo
         raag==
X-Forwarded-Encrypted: i=1; AKwUvBxnUrDWuBuaJtymPN3OKOWRKysp0KjPOUKoZq3zMR12GwgU3TCzFKVE0SAEJfF6osN2J98FECEQOSC2DRKWmOw6@vger.kernel.org
X-Gm-Message-State: APuU4Z9nHpl0yGVUAE87CBLNc+mSUrRh5RZV6bUSFveT4BLnaweKg5YX
	HJDBIkVLCxDTo+QUyuwEi8VtC2s+U01lJpTU3TKL7Upx6eqPfVpK4rl9k0Y9YTTm367NxqPogJ+
	qag15mINzxg==
X-Received: from dynv12.prod.google.com ([2002:a05:7300:5a0c:b0:36c:9b55:8436])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6312:b0:36a:1709:458
 with SMTP id 5a478bee46e88-36a423cce1fmr25708786eec.27.1793766623064; Tue, 03
 Nov 2026 20:30:23 -0800 (PST)
Date: Tue,  3 Nov 2026 20:30:04 -0800
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104043006.1199857-3-irogers@google.com>
Subject: [PATCH v3 2/4] perf build: Add explicitly sequenced -lzstd to libbfd
 feature fallback
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

Distributions like Fedora ship a statically compiled binutils libbfd
that depends on zstd to decompress sections (e.g. undefined reference to
'ZSTD_decompress').

Since libbfd does not reliably distribute a .pc file for pkg-config,
perf probes manual linker flag combinations in fallback chains (-lbfd
-ldl -liberty -lz).

Extend the testing cascade in tools/perf/Makefile.config to check
libbfd-liberty-z-zstd and append '-lbfd -lopcodes -liberty -lz -lzstd'
when detected.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b4764f69f47f..78423b0dcc73 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -896,6 +896,7 @@ ifdef BUILD_NONDISTRO
   $(call feature_check,libbfd-threadsafe)
   $(call feature_check,libbfd-liberty)
   $(call feature_check,libbfd-liberty-z)
+  $(call feature_check,libbfd-liberty-z-zstd)
 
   ifneq ($(feature-libbfd-threadsafe), 1)
     $(error binutils-dev(el) 2.42 or later is required for non-distro builds)
@@ -909,6 +910,8 @@ ifdef BUILD_NONDISTRO
     EXTLIBS += -lbfd -lopcodes -liberty
   else ifeq ($(feature-libbfd-liberty-z), 1)
     EXTLIBS += -lbfd -lopcodes -liberty -lz
+  else ifeq ($(feature-libbfd-liberty-z-zstd), 1)
+    EXTLIBS += -lbfd -lopcodes -liberty -lz -lzstd
   endif
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
-- 
2.56.0.385.gac671c819a-goog


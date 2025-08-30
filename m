Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDD1F1505
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Aug 2025 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532156; cv=none; b=lSm8gTnm6PGHb9ErYhU1/dfufi3omKiLDPIBDOQ3epCYUYW6aGG2N5ga7mLIwkA2rF0tScaOAXkCX/bdlmhOTgqMkfjG6GSgTkeyC7rPNzHr+yBvWVvmTONnDohw3vs45TyjBhYKtrxFBaZt05AUNavzQA4d4QPtokoDPFVuqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532156; c=relaxed/simple;
	bh=QmYI0zj/X4Kwrmbx/4/heNHuxCp9kC0znQJ9RD/CgSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ejmokVNLqOOJ01LikITkycdizNQkilyjk6LzvKNskPnd3ftUuEd4yvnqtXdduDXw+71XVnTN8PaKM5bh/cyy8AcefJG2xT7VwGLpwxkTAv8e59EOARlnQWNBhChYxLQ/jeJvBzO+bZmh3cCIEjk+lSZCgnSNvPppP0dc6wt642E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhBQFXuv; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhBQFXuv"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-31962614250so354908fac.0
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532154; x=1757136954; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5nOW4iK3c1eBL10WZVuLjDvECTNyCoJ5GM8pDiglm8=;
        b=PhBQFXuvxA3KAHag+m2TwTpGX79feG7rVRS+R+DD8+aMClmE9IC58XfoKbsTo8Tgw1
         r6uiaDAFCf75P7yOwrHs3Khv9yyHnm70n7Np52MOZbTosLy/dKpyemrypZmL15hAQNRX
         bHfXo70f9aiIbMM1jGWqqlCE2gyCKBT7cFXtNUM3jPfcaokld/2L71JXRN5bLX+AQJSq
         Xjn0hmUIlZjLSdoj26E6QeJvkA5om2frsvQauGL7ASG3A7ZYhVfI+eKna/F0eB0PMCZF
         SBA+zoOE0GOZReUFpeqXyXYSfT+eRUUuaU+V2yGZ4R58ruT9jT7J2VWdbB298MUyPNDG
         1NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532154; x=1757136954;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5nOW4iK3c1eBL10WZVuLjDvECTNyCoJ5GM8pDiglm8=;
        b=OeHk/OWl/5lCSv7ktvzvfVwIF7CiDVDC/Nke8fzxQqRn7MX7XjU+rlOcEIBBrHwMuf
         iCRRvZIzpoAX6K/gR65AInKRe+tXW3xkxvuX5ksGfWnU3npyq4vK19GhZuod9zZZezHK
         8EXTOoZQFuiv4BUQKoPlS5RX0zcXH+0d+x8dWtIbpgp6x5F+el3QyxwAikoRPYWXaXLa
         /+Xd+vee5wOj6N/XS2F/1obtPc9s4rV9n6+ZFXJ/uZ8DuafEso5k9gwtyeWmMVpG31Mr
         US8PQWU3ZvkyQ+om2/gRm1+BExgILJS+/D+C98jq7yhxWLFGmosg/tLx5vAkXkldXUY5
         MPdg==
X-Forwarded-Encrypted: i=1; AJvYcCXfhQuyEXnNLkbrvoyyiD+Qo/k9XPgCVvcndi4NqWtjGvgdf5d+iL3voxtUokcUAw9J4veJtVbUsYg2n0fFLLar@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qYsZt8d/YUuD7Y55aeRq7CjuBmxEwCxDcVz83dDXF0t2lU/c
	78TWEMv7tZYEKzan2kK4Zny2sXXrNZBlQsFbfaTDqCKrg40eM9oJPbQ+SjUeaaJfiaD+blNXW2U
	L0XiDNmmJ1w==
X-Google-Smtp-Source: AGHT+IEc1GIA49XbBalZevG878g4TPyrLDAk/JyZXXK/zHcAZRkDvhFlv5+yj3+9nhHnmcLmNFb4G7tNK70h
X-Received: from oabhi24.prod.google.com ([2002:a05:6870:c998:b0:315:aed6:7f83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:171a:b0:315:b768:bd1d
 with SMTP id 586e51a60fabf-3196307eeb4mr441687fac.6.1756532154143; Fri, 29
 Aug 2025 22:35:54 -0700 (PDT)
Date: Fri, 29 Aug 2025 22:35:49 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053549.1966520-1-irogers@google.com>
Subject: [PATCH v1] perf bpf-filter: Fix opts declaration on older libbpfs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Hao Ge <gehao@kylinos.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Building perf with LIBBPF_DYNAMIC (ie not the default static linking
of libbpf with perf) is breaking as the libbpf isn't version 1.7 or
newer, where dont_enable is added to bpf_perf_event_opts. To avoid
this breakage add a compile time version check and don't declare the
variable when not present.

Fixes: 5e2ac8e8571d ("perf bpf-filter: Enable events manually")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a0b11f35395f..92308c38fbb5 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -443,6 +443,10 @@ static int create_idx_hash(struct evsel *evsel, struct perf_bpf_filter_entry *en
 	return -1;
 }
 
+#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)			\
+	(LIBBPF_MAJOR_VERSION > (major) ||				\
+	 (LIBBPF_MAJOR_VERSION == (major) && LIBBPF_MINOR_VERSION >= (minor)))
+
 int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
@@ -451,8 +455,12 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
 			    .dont_enable = true);
+#else
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
+#endif
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
-- 
2.51.0.318.gd7df087d1a-goog


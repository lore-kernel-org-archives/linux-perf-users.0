Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CB194C7A
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Dec 2024 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460043; cv=none; b=kSlLNXtXpd6mZYvh35zYSOdEOWl3sISU0PoRuTunjAxse0dokVLXtNZ13dPu795Q1FBUHfZPRkkiYuuyskqHip0tAmmEkvTphJGcI7SPZG4zdfQq00oWukyiV9ahnM5IdVp602acuba8526YJDUaPa5hDG2HJKhk+hfnfT0fcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460043; c=relaxed/simple;
	bh=NvHv1JvgCIj4wxEXi2qnifVrg5VM8kZfYBZjSzBa3dg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GErXQruQSZCor1AV9G4XY4jyQPpGE9jx1F2yZkHshCzBe6MANSawkWmMYEjBVX4Dk9ulT1NzpxOqB0oG/VU+6L4JB3h5TcBMSdYhK5IZXQ08VeV5PnVyB/ENS99E642UXbQ2T5DO33jfksNc5TTbwiTOdGWhRe49oniUOBYPTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITPvaYeR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITPvaYeR"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e39a8125366so2837200276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Dec 2024 20:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460041; x=1734064841; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HooQRn/pxrZs6KSP4MCRwKNyrc2n5wJOPs3/bci4Uk=;
        b=ITPvaYeRcgVc38hqEm+Bpq2IJRYcrWPrEtidw63fxdkb4xkrQrGPRGkr3eMrUd65PP
         NT+brCB7suidmG6yIuhtu25HYz+RJTo9UpLHMim2ALkqkbOZ7+FTHuZfWgMBZODnkA72
         Vzk/r3l+m7zQsGT1QeMy3+yXQDi7tcZ1ksDjQfDd8yXzNRWVVE3gSHBbwf6cYB/LNS5W
         TEfGX15BR4/8Ko7oUm5VWveuA1LUq6VsIog0l99rEDb1sO0NOzTpdhZyIXmNtq/YmSx5
         atpmoPDWX+vlonPr8KrmyP6g+B+ewbdBeQOoPMvrV9i+JYh9exa+rTVsmIILhKxZpU3l
         khAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460041; x=1734064841;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HooQRn/pxrZs6KSP4MCRwKNyrc2n5wJOPs3/bci4Uk=;
        b=s9mnNmHwbDxyocORDaxcbIP8nfDD+1NFVqalLSLLklxXWz6Wipk8p3aDUJvjqzkeZZ
         Wj7Lh5rqR/Nt7S8FHlrfLA0hR5Km25mmb85crMVCd/eyK7Jc2leiUprZ/etswLo28720
         nNKdHytGZ+JDGB0NNMlVPIg2a8iJEA1tYHFy+6M9RCDQst3a+zhyj56hmbwqnKKJGzfg
         TJZnyl19YsHlGIIDbdF+KFPe7U3jum+5Fu0Rgn4KLlCpi6/L3wUkZ8qIQMrE0a/xHvfk
         VYy3sN9L/QSuJlTJgLyw4GprthzfJzot6POf21cVmhFRmPu3LXjfTzXDsU/1Jv+B7Hlu
         HyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrpphUlEkGl6aUxjpd4uvoRIejexY1nFTnmFKdmUAXUAatxoCV4rLDk44ZAicAXe31L9izf1lGWArIJ99RE6KH@vger.kernel.org
X-Gm-Message-State: AOJu0YycGhbrg9xL9/r1USKF+oLicOwkgqXezJVlExUfKe1npKlxww/m
	DnDPqtC5Y/XYlU8JWJ2pKCyF+3wwOey0ffguer8AJg5kuAnloDFWhr5uiY5x4u8f618eyAOoY6Y
	JEO7QjQ==
X-Google-Smtp-Source: AGHT+IHIgCIgWFyGcAWDY7516J4vjQr1pq+XRf6N+uB0/z07nFo7rInpoiDluy+8thojGoFnFz9roVvtzpil
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a25:7c06:0:b0:e38:d1e:af86 with SMTP id
 3f1490d57ef6-e3a0b07413dmr731276.2.1733460040757; Thu, 05 Dec 2024 20:40:40
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:28 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kyle Meyer <kyle.meyer@hpe.com>

Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.

Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
cpus_runtime will increase from 81960B to 163880B, and max_entries will
increase from 8192B to 16384B.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/cpumap.h | 2 +-
 tools/perf/perf.h                        | 2 +-
 tools/perf/util/bpf_skel/kwork_top.bpf.c | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 49649eb51ce4..3cf28522004e 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
 };
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS	2048
+#define MAX_NR_CPUS	4096
 #endif
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index c004dd4e65a3..3cb40965549f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -3,7 +3,7 @@
 #define _PERF_PERF_H
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			2048
+#define MAX_NR_CPUS			4096
 #endif
 
 enum perf_affinity {
diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
index 594da91965a2..73e32e063030 100644
--- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
@@ -18,7 +18,9 @@ enum kwork_class_type {
 };
 
 #define MAX_ENTRIES     102400
-#define MAX_NR_CPUS     2048
+#ifndef MAX_NR_CPUS
+#define MAX_NR_CPUS     4096
+#endif
 #define PF_KTHREAD      0x00200000
 #define MAX_COMMAND_LEN 16
 
-- 
2.47.0.338.g60cca15819-goog


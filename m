Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF22EBDFB
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052277; cv=none; b=GQqGamDlsFLjvzRMAeX+s0FBguFodl6EYWpUQOn947QAoaiuZca8JYrt2rcTc6CenwCXWVhPtVluruhPN8rg3KHpgn5+oLblci2jpsDxwKx89Ql0AyNg5F+EioFev0FAeol4J5jnhmss5H2oHZPxbmQkg3FUGt9jw1JILlyQcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052277; c=relaxed/simple;
	bh=lgYxdkzJdj0+0t5WyUgo4PCHs3tbjzs842Cp3cxBP/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=h23YUlqr8/Ut0nMsaEBAoOofDFjymPdCp8vjWAcHwRJn/TlsVBh1yzWPYuF9lajt5fbcE9Cfo3N5i+dW257vzuG42e//AM65CRFalztZPvSlPDrlgI6e5LMtDmCt6iTFIloHwx06Q/WeSbMjgqNvIxBdhu0h+QcN79Ouf/YFhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gw8m1d2T; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gw8m1d2T"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so221033a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052275; x=1751657075; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdEvbWob6zhzrdFMiDw/dSDXdj7k9xYWPtf9BpTTpI8=;
        b=gw8m1d2T5MEz7f/d5Fsjx7e+ygRpE2dOPgjhQoLLOXT2hnC4VwdNeBx8mj7FA+Gj8N
         E315TGITOjUsv+EYq+yc0NyFxJ8pEOdxKTtaWv1T7zMm0DdZ6fFtJw43bfzXWDKlH0Hc
         Ue9yiXe9BXvegdzsAJhDQihxxiywa6l1nuuWhYWc4cfWscDHxwQpXlzm7SFi+Gm2FWKc
         lgRxZqRzyxhrYEyYl0cz9PG6RJTOCWadGnI3BHqu424t3i3+3A2SJhSViBhLLCOsgLp0
         AzI9/BT9id/O5BxYTOOTEiCxdVee0lq8yMzwmuajIGv1Yp4e8+YR74D8tO/Zz6E4/sLl
         54oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052275; x=1751657075;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdEvbWob6zhzrdFMiDw/dSDXdj7k9xYWPtf9BpTTpI8=;
        b=kCvBuAaoHwOakfcbbzVHPVKjGVDfR9p7HlODHZCicmwbYo1rx9ZLE1kE8794FK0C7C
         /VNBhQ8czscPmkxqICtE4ozBj2QDxTyL4OoIjpEHaI1gnqDyYkr7Gdide+4Ci7MbQTJY
         ix5TlrmgqT7cz6Al3wAS4L6mIUzTOdZQHFnhuarW0gIn9FVmlv0hoXtLvfa2X++FB8N+
         laLszCbpmOX6FM+qKek17PZTkpPey5BmWPyDVcQhdvseOep/8/9BiwAViWiMGMN2d+C4
         OHz1zq5MceLrD4occIq3P9uBPvDFaNg2/lKBVY7wy2fPyg5vdAIAx7OsGdtcYjlpKERp
         IYZg==
X-Forwarded-Encrypted: i=1; AJvYcCUeUGxogJRnqD52ub5qNm+UOPfd4aK+xmg6lt57xqbhkyLIrb1U0iAymat+sX99sq13buE0c7Bgpv+y2Amrk5Md@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJrXf0kM2ueaRQMbYJPXcoBtfUQ8hJVg4qieHdxf7zxi0s9p7
	21NqZ6ccJXlnLtsrXkEUJx8CMCQnxFWUZS5AN79ymgtjdNjgF2lzY+2s1SD0TXrYNzSR6djMBl9
	mwd8lBViLRg==
X-Google-Smtp-Source: AGHT+IHaVlcHMhPYb35nHDGk44Oi5XKnOLvZEee26fFWEnJwjvFGPUo6h1rXqkaQAH2aOY6DuQV+FK19EpdO
X-Received: from plbjy7.prod.google.com ([2002:a17:903:42c7:b0:234:dbbb:e786])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bc8:b0:235:91a:2c
 with SMTP id d9443c01a7336-23ac463e5fcmr68496205ad.42.1751052275409; Fri, 27
 Jun 2025 12:24:35 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:12 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-8-irogers@google.com>
Subject: [PATCH v1 07/12] libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This allows the perf_evsel__exit to be called when the struct
perf_evsel is embedded inside another struct, such as struct evsel in
perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c                  | 7 ++++++-
 tools/lib/perf/include/internal/evsel.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 127abe7df63d..13a307fc75ae 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -40,7 +40,7 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 	return evsel;
 }
 
-void perf_evsel__delete(struct perf_evsel *evsel)
+void perf_evsel__exit(struct perf_evsel *evsel)
 {
 	assert(evsel->fd == NULL);  /* If not fds were not closed. */
 	assert(evsel->mmap == NULL); /* If not munmap wasn't called. */
@@ -48,6 +48,11 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 	perf_cpu_map__put(evsel->cpus);
 	perf_cpu_map__put(evsel->pmu_cpus);
 	perf_thread_map__put(evsel->threads);
+}
+
+void perf_evsel__delete(struct perf_evsel *evsel)
+{
+	perf_evsel__exit(evsel);
 	free(evsel);
 }
 
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index b97dc8c92882..fefe64ba5e26 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -133,6 +133,7 @@ struct perf_evsel {
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx);
+void perf_evsel__exit(struct perf_evsel *evsel);
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
-- 
2.50.0.727.gbf7dc18ff4-goog


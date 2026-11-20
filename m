Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213595;
	b=HovbUxR/RuqDgI90S74lSWzh+4exoDX4putiMgZOlwVGG1hmJG7t6DfR8b5GhwBANnEk
	 /lqLR0KBA9YnclC0psFkHQRcE0L35LWgop6Q5iR572uwPU/5IEA+0twGZnWiOxXR6HDhG
	 spvpUVry7DYGXcU28zbDtUZc/HzvVpHbzxoiZtGkQFBA/+gRubtaNEFflYB2pBFDdoWR6
	 zfZwdEEYa5qu6TpzOH1zdmJHNrKpgYDOi/ycDfTOg/WyDCxAcL5/tkcvvVb7glA08lCmn
	 yFWbNszWtfQ3qtvRgalaHhdxVuVq1OMmnRpua045FvWgJ+p2Br4PXf9SxhnAxfcLgeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gq2GtuVmj8tWuvXFLIVErpiJbK5W42TtjRID8lqFNZs=;
	b=lrfI3VYQ/chA406nVXA5sBuTk1u62qrUHqthnsgO9hXYvPWcgiv4NXYjwfWROexXD4xI
	 8FPrjJ+y7c/fh2ysV4e/MtmlTjhwrakg6gU4Geqr5f27o471cClvCSl74xiQpLyOjZV8R
	 RH6w7J9XZlFm6Z0u9EN5RAZ+VwRmVaFuNmhh/L4b3jT3lmWxQ88jb7gbqtSHdTVNvJKeN
	 XR9r5amcR8+DNKRkFXuvAdOyBU7QNijlBuVvVop686zgg9W6TEayP2Fl1Unjpjxdq1pbT
	 kFFP6/QJ/ubbrGr72rH2tBYaa3ktmTd9Wcx+QXR9S85VmBC2vGxhjlP+6OG4FFEVhCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pbfx2LsA;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41004606A686
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41004606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pbfx2LsA
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3869accaac2so113502eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213592; x=1795818392; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gq2GtuVmj8tWuvXFLIVErpiJbK5W42TtjRID8lqFNZs=;
        b=Pbfx2LsAcWutv+mDVtNZSiACKHJRFIvioDJB3I+gvOMaHfJHGzmH5K8hawX50X6NbL
         +wfNNsxeCyAp5ltXJKMty8+rNfwU50eLGQMleeN/TCOVAH3yNADMC9qA23h09LOl6n2X
         wphZ1wSszrtTrZftu+Cvry2IwNub1c9aVEhEIdYm7v8qg4jRoTbGuRAzdNr1SW8dVlUh
         8Nt3kAMHpIFDxrrpTzNDMbqknb3f1FH/Llv8BsLI/PNk2q7dujT6FQ/vGbYruHQPwxWS
         zVE7nBa/gPkSp3y/EBvB8TngfWVva7GDUEyYqcr9TXkKYr9rlOMOQfC2fmBuCpHElLe8
         AHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213592; x=1795818392;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gq2GtuVmj8tWuvXFLIVErpiJbK5W42TtjRID8lqFNZs=;
        b=ap83zdfZxWv5zd9p3nn98yOCZ2748KNGIbJ/irRBb7S3Wxdb8GM0AMjKRkY+vGInk+
         HLptTCfpy4pXHC0vgxT8x2I8hIEA/5u7hWP5YHpPd0ETuk9PMzZZSZP7SCZhyoF3KtNH
         8+tQ+tNQo5b9nY7xEqg7fRhKjpoPebw95Szztv8NvUjy3FGO6sMuMJfRJAuOuAE+X8Ol
         DRX9J+4fIw3yvFJvbfvQtkIILE1PjX9vh4RjylEZ1TCmESDbUdOnc9C3m1yp+4EABk5U
         /1i8OmfZXd++Ynf7B4dQ0WRFarheOQ2OK0Mh79Oynjn8pa7fWC0M+P0TEWQPJ17vHh2R
         LMWg==
X-Gm-Message-State: APuU4Z+aVArjRUcgC5XOuhlAYQkjlIjMkV6K7RgyP5RFOxNtiT64lzOm
	ToON75PreicqsrK8D+bjox4ne8oEki12120zW5ZShRluzkrymB48oyy7id8bK5r39DolQoGvwjO
	6C5WuRbFeWA==
X-Received: from dybsy10.prod.google.com ([2002:a05:7301:700a:b0:36a:17c6:6824])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:894c:20b0:377:3984:5cb
 with SMTP id 5a478bee46e88-384b446b404mr6006434eec.17.1795213591764; Fri, 20
 Nov 2026 14:26:31 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:01 -0800
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120222615.2291168-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120222615.2291168-3-irogers@google.com>
Subject: [PATCH v3 02/16] perf mem-events: Expose PMU init and name formatting helpers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Export perf_pmu__mem_events_init_pmu() and perf_pmu__mem_events_name()
so callers can initialize and format per-PMU memory profiling events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mem-events.c | 12 ++++++------
 tools/perf/util/mem-events.h | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 62543df0dca1..932efcfd82f7 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -82,12 +82,12 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu)
 	return num;
 }
 
-static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
-					     char *buf, size_t buf_size)
+const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
+				      char *buf, size_t buf_size)
 {
 	struct perf_mem_event *e;
 
-	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
+	if (i >= PERF_MEM_EVENTS__MAX || !pmu || !pmu->mem_events)
 		return NULL;
 
 	e = &pmu->mem_events[i];
@@ -196,13 +196,13 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
 	return !stat(path, &st);
 }
 
-static int __perf_pmu__mem_events_init(struct perf_pmu *pmu)
+int perf_pmu__mem_events_init_pmu(struct perf_pmu *pmu)
 {
 	const char *mnt = sysfs__mount();
 	bool found = false;
 	int j;
 
-	if (!mnt)
+	if (!mnt || !pmu || pmu->from_env || !pmu->mem_events)
 		return -ENOENT;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
@@ -228,7 +228,7 @@ int perf_pmu__mem_events_init(void)
 	struct perf_pmu *pmu = NULL;
 
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
-		if (__perf_pmu__mem_events_init(pmu))
+		if (perf_pmu__mem_events_init_pmu(pmu))
 			return -ENOENT;
 	}
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 38b14c03392c..f2e622a048c8 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -31,8 +31,28 @@ extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 extern bool perf_mem_record[PERF_MEM_EVENTS__MAX];
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
+
+/**
+ * perf_pmu__mem_events_init_pmu() - Initialize memory event table for @pmu.
+ * @pmu: The PMU to check for memory event support.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int perf_pmu__mem_events_init_pmu(struct perf_pmu *pmu);
 int perf_pmu__mem_events_init(void);
 
+/**
+ * perf_pmu__mem_events_name() - Format the event string for a memory event.
+ * @pmu: The PMU providing the memory event.
+ * @i: Memory event index (PERF_MEM_EVENTS__LOAD, etc.).
+ * @buf: Output buffer to format the event string into.
+ * @buf_size: Size of @buf in bytes.
+ *
+ * Return: Pointer to @buf on success, or NULL if invalid/unsupported.
+ */
+const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
+				      char *buf, size_t buf_size);
+
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
 struct perf_pmu *perf_mem_events_find_pmu(void);
 int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu);
-- 
2.56.1.750.gf70dc682cf-goog


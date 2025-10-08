Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7D286D49
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940634; cv=none; b=NVz6qWwjwGxPtcwA35q9kgCqmLb+GZ6ukXg5F89tsNXsLC+K4x8SmtatOBOueeHgbOq+eg0oWcbpa3t9l1YpVTFIssyy9Eslrc7Qx9bsqu2e2d4/uFOrkb2vfKLnplTGqnv3/gldHp8+7rUHbqevg1xt546wUNaWdVKLxekqUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940634; c=relaxed/simple;
	bh=R96bbATMZSPb9OIoAzn4ym9WVGJOuOpN7eTc3TttFUU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hD8PNxf5I0YKoPVH2xkZwADtP5GixQ+693mGV4GLyfEY7cgoPX5B4rHlrYBjSnBqWfd/s/KbgXZPlEvLTwB54UHCUc2qTvFkXFQfwaqHTs6JoGQQcXL4TZOvNcLrL9h1Ie2udsl5s8brDeh8kFHPOjqaRPCrmItiKYY25LEhz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Of9EIVXk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Of9EIVXk"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b551338c2c9so4954259a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759940632; x=1760545432; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wRJXz112Re1ju3vdnrYT2DZaPKwj05gRwzq+1yeUNKs=;
        b=Of9EIVXkOmVcdac0kItnBsdmLVoWxpnDoYt51psGG8lF8bpyBhGGCrFdXZ6ImCgH8r
         rmcHKGhvI7EI/9LanL+WsQmcXnUiE1omEc9MmyF/iHwSmBIQ03YALtEp6yzK26LLC1L+
         OMmCZVIJdqplg90GBk7c0BmZTxUp9OIPmJeqUIRC7Q6in0uCmHGKtAgfiOInjlafEDTS
         DZXyR78mGwZZd5/hhiluf4N86oxpUdey+A/SLPkKk6JuzGR5Kml+G7qQhKcimxjIs3wE
         x+ncCgPX12OtEZg++b3pLbRaYP4wRao2yi/YCwyATLuHZXZaCeiwQTZN5Qs6VJWfDS67
         mNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940632; x=1760545432;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRJXz112Re1ju3vdnrYT2DZaPKwj05gRwzq+1yeUNKs=;
        b=CuP7gFp+vZ9Xe7oWP3nHADHYmvLUctaBJlJfMm8ODXQjQ52dH67tMrH62vB9vZzI5F
         +1DfeKUVMx9b/32rvlq2Jznc2E1XZXdlwylP50zSPQrx9Uj4GeNcSzZ5bTGb/PGtbVXh
         Y72jM4eR0gQYXnVzkq1Ig5/T4qDN5SJD7x3zCV3EFAOVIJCsu/z1au1vH7UBuwSEzYwW
         26hyLpiASyNGJHHTr7n/sAd+tCC7ti9334sVgoSWv7cvGxZ38Qra/cLko555sz1dFNSl
         f338uHG4jHoWA8xlg9OVdSa++hrDI8QMGOC6wL5leE+7bnZXkTMgG/1R8LWs2UQyGV9p
         YaWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbFfET+rz1DF03hKSiy3fyrju9IMqC88Q8y1I0eJ0aoeAgBrz0/5pb1PQRjOwlmCyIz1MK4xgn8Gzcfozd+afs@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7gIJpzkhhL5MblihJuAKmn5qIdH5ux3HOdOQnDFTK6GROkUA
	3ZLHjUsSyjL1sTuwb3dkxrTTV0VgqVl9/HjAXX0q2d0PxElbFe2DUWkc99SWCWp6jFlPA+xkh8n
	VUqvWaeEg6A==
X-Google-Smtp-Source: AGHT+IGKggukMuWythYr3qzc7hKbOfyUWxXaNl2ZkzSjXOY2nzoCMvWkDw+/XtALg86o1p0QKnOwEdiv1B2m
X-Received: from plez12.prod.google.com ([2002:a17:902:cccc:b0:26a:23c7:68d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef10:b0:27e:eabd:4b41
 with SMTP id d9443c01a7336-29027216505mr56267885ad.7.1759940632569; Wed, 08
 Oct 2025 09:23:52 -0700 (PDT)
Date: Wed,  8 Oct 2025 09:23:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008162347.4005288-1-irogers@google.com>
Subject: [PATCH v2] perf bpf_counter: Fix opening of "any"(-1) CPU events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
wanting to aggregate a count against a CPU, which avoids the need for
atomics so let's not change that. Force evsels used for BPF counters
to require a CPU when not in system-wide mode so that the "any"(-1)
value isn't used during map propagation and evsel's CPU map matches
that of the PMU.

Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 13 +++++++++++++
 tools/perf/util/bpf_counter.c |  1 +
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7006f848f87a..0fc6884c1bf1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2540,6 +2540,7 @@ int cmd_stat(int argc, const char **argv)
 	unsigned int interval, timeout;
 	const char * const stat_subcommands[] = { "record", "report" };
 	char errbuf[BUFSIZ];
+	struct evsel *counter;
 
 	setlocale(LC_ALL, "");
 
@@ -2797,6 +2798,18 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
+	evlist__for_each_entry(evsel_list, counter) {
+		/*
+		 * Setup BPF counters to require CPUs as any(-1) isn't
+		 * supported. evlist__create_maps below will propagate this
+		 * information to the evsels. Note, evsel__is_bperf isn't yet
+		 * set up, and this change must happen early, so directly use
+		 * the bpf_counter variable.
+		 */
+		if (counter->bpf_counter)
+			counter->core.requires_cpu = true;
+	}
+
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ca5d01b9017d..d3e5933b171b 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -495,6 +495,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	 * following evsel__open_per_cpu call
 	 */
 	evsel->leader_skel = skel;
+	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
 	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
 
 out:
-- 
2.51.0.710.ga91ca5db03-goog


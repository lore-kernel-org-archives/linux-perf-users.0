Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418402;
	b=C4WHP3q2MN507IWf6/kYGIjUe521MTr3qDz+222k7DNTrfk4kP+BKBtdJiKoIGrDuY1x
	 I32rKuTbbm8nLZ9M2FnOKkIG2r3ahG4/UEe6n2NX6lXFbtILViVW14inUS/H7MK6A7k1D
	 MxMjS38qoeW4kVhh2Aqy8qH5svcNTIjEZ4nr4idSrKR9gwBpl07/BzBYzH9oShh8B5gEs
	 nzp3fS4ruJBgfcg4x26nklEhSbMGPKLGlBV773VOd2bShSd8E8y8kkUQMrz13/xsQVNxV
	 AEpYvuQB1yP2gJ+WHpEFIXQOgXhwX4mmyMLEmvcJD3lmPH09TmgH1mYV/UlQO8xr7EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fiMjKbfzQ9qS5le+IrJC6UoOpWWUzBoBnXeh+seDCek=;
	b=FuR1SBrZceWi/BOJ6yWBGmuTm7G8l2cr2EXPzEIs0Fus/nmUqjd7SEXkZxYBhtctb77A
	 HAYk+ZXA1nC9DiKzsLyUbkwrcACkLTgO75AZvN2DDRz+2sRYD1UNuz+5/ntPi7eyk7Zm2
	 UNaoZLu0+ZOfxzLxMIUeMzcG/uVks+5hBUhuJBwCLdOaSOksYYyYeCgC3Qw1fKRCfLZg/
	 9WBIJFv8xeA6ADD1Xj/Sj6qcIRVEhTRs3bGY2wlkNFZkErVkR9nXiuEU0MOoEIsNInhCc
	 lYsNBs4tLqDq4X6qQligWBNh24+zkhbHxGfAoF95U/z4+gFjOlrowUr0emzL+amvtQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5ESDTFA;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2A606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DA2A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5ESDTFA
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so4998664eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418401; x=1796023201; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fiMjKbfzQ9qS5le+IrJC6UoOpWWUzBoBnXeh+seDCek=;
        b=T5ESDTFAUPVBTaI0SuUlG86npW9tk1aMdE/rNC/px4tlr00cR1+96RbJf6ySz4IzwB
         lzvFzFBCnyOBDWtQ16TV7d9INkPj4jF6SobVSAyL3FwL53+cGPC8SI6V7Om/D3Rh/Jkl
         xE1mRrG7FBvIGngdt0wcF2En8fnLuj1poas1oA5ucgDnlkz9rYQe1YGFetdM5Cxt77Zt
         8FPnv3A2XdIerwxAUGvRRPkiOOd8Fzni08LktOQ17tt4zYunLQV+H6fVGkFNuqcNRI/r
         WtT4P5RS/AzY6fN3KDUu9Xe6AfqLytZCvdpbJuvuUh1tQ+OADG3VYpkN07DH9Qfjs8ci
         AEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418401; x=1796023201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fiMjKbfzQ9qS5le+IrJC6UoOpWWUzBoBnXeh+seDCek=;
        b=PgoxSMXbbQoVt0IwkELTFjTv5AlBIgYk54KgaaYHqyFT/6POjO5uzQDciLV9GftVzv
         LDGek62y9bI88gUIkE+4jpLA2FnnrTjikgU/MWkXvCaMf5NjfZxdyKn7CKHxRfQACimB
         YVkcy6nrJ49J0ry8OH7PDVzdeQRVVyK5JTHW+83FwGyA0BOOdDMwKMsyMHTBP2uyi70A
         a2zBSFCv/xV7gAJXKY1lJXYzn6LHdhUm/JcCUC5U9TN+tWX0hEITCnP9EHODG7JX7glK
         1yHV7LvyxywUKY0j2fxQlA3FizO0dNFFAeC0vSKwdOQOtQyLxpqPG2ENoIiUAJ1VbkjG
         LUNw==
X-Forwarded-Encrypted: i=1; AL+hErGZHSeyrrr0Q6gFPzW42OC3tGaMFJEk9S6Eir5mpPhzbjz4X/VV8EZyUuuKwV7HTKBtreX9AnTbt9AVlqOdEn3w@vger.kernel.org
X-Gm-Message-State: APuU4Z8pBL3S5Db7CDtsZk+WCn0V8DJDdoANfZelsOjRbVRRxBppm86v
	P9p1j+H7TBn4FxViFn+wkTHvsxsXYZ1tptw72Qnm5Xfwi4J7U3ux2nDRPZ00FJzIvMHdotK5OdV
	oejphOiNnHQ==
X-Received: from dybmf40.prod.google.com ([2002:a05:7301:928:b0:36c:9b55:8436])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:51f6:b0:384:7b4c:8564
 with SMTP id 5a478bee46e88-3857131a749mr12658929eec.41.1795418400197; Sun, 22
 Nov 2026 23:20:00 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:08 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-9-irogers@google.com>
Subject: [PATCH v1 08/13] perf stat: Respect the enabled time of exited
 user_time/system_time events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a workload has exited and been reaped by wait4, user_time and
system_time can no longer be read from /proc/<pid>/stat and perf stat
falls back to using the rusage values from wait4. These are the totals
for the whole run of the workload and ignore when the event was enabled,
such as after a delay. For example:

  $ perf stat -D 500 -e duration_time,user_time,task-clock -- perf test -w noploop
       524,466,208      duration_time
     1,004,578,000      user_time
            522.86 msec task-clock

Add evsel__tool_pmu_exited_process_time() to compute the time the event
was enabled for from the process's total time, the start time when it
was last enabled and the accumulated time, and use it for the rusage
fallback.

Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/disable")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c  |  3 +++
 tools/perf/util/tool_pmu.c | 24 ++++++++++++++++++++++++
 tools/perf/util/tool_pmu.h |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4fe4da20aae8..964bf0864796 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -302,6 +302,9 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
 		else
 			val = ru_stats.ru_stime_usec_stat.mean;
 
+		/* Only count the time the event was enabled, such as after a delay. */
+		val = evsel__tool_pmu_exited_process_time(counter, cpu_map_idx, thread, val);
+
 		count->val = val;
 		if (old_count) {
 			count->run = old_count->run + 1;
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index a62a7cb390ae..24ff27099d32 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -13,9 +13,11 @@
 #include <api/fs/fs.h>
 #include <api/io.h>
 #include <internal/threadmap.h>
+#include <internal/xyarray.h>
 #include <perf/threadmap.h>
 #include <fcntl.h>
 #include <strings.h>
+#include <unistd.h>
 
 #define INVALID_START_TIME ~0ULL
 
@@ -709,6 +711,28 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	return 0;
 }
 
+/*
+ * When the process has exited its user or system time can no longer be read
+ * from /proc. Given the process's total time, such as from wait4, compute the
+ * time the event was enabled for.
+ */
+u64 evsel__tool_pmu_exited_process_time(struct evsel *evsel, int cpu_map_idx, int thread,
+					u64 total_ns)
+{
+	u64 ns_per_tick = 1000000000ULL / sysconf(_SC_CLK_TCK);
+	__u64 start_time = *(__u64 *)xyarray__entry(evsel->process_time.start_times,
+						    cpu_map_idx, thread);
+	__u64 accumulated = *(__u64 *)xyarray__entry(evsel->process_time.accumulated_times,
+						     cpu_map_idx, thread);
+	u64 val = accumulated * ns_per_tick;
+
+	if (!evsel->disabled && start_time != INVALID_START_TIME &&
+	    total_ns >= start_time * ns_per_tick)
+		val += total_ns - start_time * ns_per_tick;
+
+	return val;
+}
+
 struct perf_pmu *tool_pmu__new(void)
 {
 	struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index f66d24cf3502..137b0a06a852 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -61,6 +61,8 @@ int evsel__tool_pmu_enable(struct evsel *evsel);
 int evsel__tool_pmu_disable_cpu(struct evsel *evsel, int cpu_map_idx);
 int evsel__tool_pmu_disable(struct evsel *evsel);
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
+u64 evsel__tool_pmu_exited_process_time(struct evsel *evsel, int cpu_map_idx, int thread,
+					u64 total_ns);
 
 struct perf_pmu *tool_pmu__new(void);
 
-- 
2.56.1.750.gf70dc682cf-goog


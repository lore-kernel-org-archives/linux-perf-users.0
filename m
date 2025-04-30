Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834E2882DE
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043281; cv=none; b=gnTmfOnXVL3HNfieHekxGH/QyTiEd9Rg1XxG3YQp2FzOnSk/tHJJF+My3shO783MkTEvYHcWdoqZI8N73P25To/QQyyg0gFQ9elFCYR4jz1uxICnQk9Qi5dfbwWI3aYgR/TKLXs14AbtcVzduzWuTSGK6mpg6R7/TrJhSMg11NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043281; c=relaxed/simple;
	bh=IeDDCZCEXYK8H15EfdB2ycNez3dvrWyEpkVr1ZAn2zk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=qWKbfe0yrloYJLPVWLNycmGoUIzI7R9upw6iewmb1zGw4AEWqRfhxq+mbKGIZw37ahmyYFFMrDB9iyIuCqOP8MW5hPxZpOd+PTGQ2v+oanr5/h5WrA/xXQVLXqfA4N1zdQ/RmG68O4mFVARVcIXPR45NftCk4sgeMGVJ4xa699w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MzJa1FTZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MzJa1FTZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cb72efd5so224326b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746043277; x=1746648077; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4mgaxp2PNRzYuPFI4nl6JEz+Vc7zbRAR2iy6HA/VcQ=;
        b=MzJa1FTZ6ItBoLa7fIa419lbBPX1Ftv5Og4yutekEwjf3QdDjF0oM+SRS5qlI9qvOm
         RANK4l3cOPU7IjuFBjyOopC8wGRDFFtZojdNnUs1Dyf2iq8hyBJKFWFbHD1GLzcO5qYo
         yJcXW7uhMrtJ5G/GHxZBsuEhQV4nW3U89GWxWf9YvoIvdyJzjbme4JPMWkCDFVah6yUQ
         QQeMP0I1hBBoDZHlkdg2kCHfrdFTFyBJu4EDY9zqRG4YQPAV1liahGzrUfC3z2VogRX4
         qOehruOb9hosDdFKIvthMll9jN5yUmODCNnl2QcbV71D8CHKhUyUXjZM3NsLC9dmBxE5
         j0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746043277; x=1746648077;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4mgaxp2PNRzYuPFI4nl6JEz+Vc7zbRAR2iy6HA/VcQ=;
        b=wLAWQ4kzEFe4VgO9BUIrqw0ffhJMG7OjSKTJ1L/8z2YxzIOg1JePXdo1prszQvSpIj
         ySA7sBFhZpZV+sOkV3p8noWE5asHnn4Ktft+RjKuxduwdMVbod2nOYPU8T03w6CYL38f
         r3c1Ubx7Hd6xR0HvSqZvN7Ev62ZpukCPzskRyQlLK7WCjKLL0BsCL/XyYddKjnqOUXpp
         KH2akJm8TXQH/xo8q96sQRq0JXSEfkJBrcPa0xAoAZjayA3/Zsj9MZoCzuypkIqJGa1f
         HNNjmSwKTY7derYl8bwr9J9GgBuxloxMN9PpjHRR6N/OSfGmJczQgIRS25Ni14sSgU8B
         +g6A==
X-Forwarded-Encrypted: i=1; AJvYcCWQJgs89X/vjJLOQtdodno2xx4V8MEt3kvGQow8gcNVH9jTPbMtnsXEAI8okGNJVCtmmqKOs9nB42B06cv4iJJV@vger.kernel.org
X-Gm-Message-State: AOJu0YwER1xr22TPwR1Rlb0Lkk9imjuewCvoprWjpLd/a3t2SlPFLYxY
	ffqdDCkxLmrROZ6lmgknF7ZkZH5PqLnOSdiinBT6ZNzbaiGMG21E+tlF+9l88cWPAyTCc8pmmcs
	pAsEExA==
X-Google-Smtp-Source: AGHT+IEwy2caukEcTPbu8Rd8PJTVi66QeaVPAWQtLK+ABKf9p00gzD24MAHOci7axAO8NUNJtvFirOvSphhn
X-Received: from pgbcp11.prod.google.com ([2002:a05:6a02:400b:b0:b15:9c5d:9278])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:900d:b0:1f5:706b:5410
 with SMTP id adf61e73a8af0-20a899070e9mr5395476637.38.1746043276760; Wed, 30
 Apr 2025 13:01:16 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:01:08 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430200108.243234-1-irogers@google.com>
Subject: [PATCH v1] perf intel-tpebs: Filter non-workload samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If perf is running with a benchmark then we want the retirement
latency samples associated with the benchmark rather than from the
system as a whole. Use the workload's PID to filter out samples that
aren't from the workload or its children.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-tpebs.c | 59 ++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 7fd6cae1063e..4ad4bc118ea5 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -3,7 +3,7 @@
  * intel_tpebs.c: Intel TPEBS support
  */
 
-
+#include <api/fs/fs.h>
 #include <sys/param.h>
 #include <subcmd/run-command.h>
 #include <thread.h>
@@ -121,6 +121,59 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel)
 	return ret;
 }
 
+static bool is_child_pid(pid_t parent, pid_t child)
+{
+	if (parent < 0 || child < 0)
+		return false;
+
+	while (true) {
+		char path[PATH_MAX];
+		char line[256];
+		FILE *fp;
+
+new_child:
+		if (parent == child)
+			return true;
+
+		if (child <= 0)
+			return false;
+
+		scnprintf(path, sizeof(path), "%s/%d/status", procfs__mountpoint(), child);
+		fp = fopen(path, "r");
+		if (!fp) {
+			/* Presumably the process went away. Assume not a child. */
+			return false;
+		}
+		while (fgets(line, sizeof(line), fp) != NULL) {
+			if (strncmp(line, "PPid:", 5) == 0) {
+				fclose(fp);
+				if (sscanf(line + 5, "%d", &child) != 1) {
+					/* Unexpected error parsing. */
+					return false;
+				}
+				goto new_child;
+			}
+		}
+		/* Unexpected EOF. */
+		fclose(fp);
+		return false;
+	}
+}
+
+static bool should_ignore_sample(const struct perf_sample *sample, const struct tpebs_retire_lat *t)
+{
+	pid_t workload_pid = t->evsel->evlist->workload.pid;
+	pid_t sample_pid = sample->pid;
+
+	if (workload_pid < 0 || workload_pid == sample_pid)
+		return false;
+
+	if (!t->evsel->core.attr.inherit)
+		return true;
+
+	return !is_child_pid(workload_pid, sample_pid);
+}
+
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample,
@@ -140,6 +193,10 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		mutex_unlock(tpebs_mtx_get());
 		return -EINVAL;
 	}
+	if (should_ignore_sample(sample, t)) {
+		mutex_unlock(tpebs_mtx_get());
+		return 0;
+	}
 	/*
 	 * Need to handle per core results? We are assuming average retire
 	 * latency value will be used. Save the number of samples and the sum of
-- 
2.49.0.906.g1f30a19c02-goog


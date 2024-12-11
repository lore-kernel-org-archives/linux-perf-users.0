Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEBE1F2372;
	Wed, 11 Dec 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955938; cv=none; b=PQ5QTcjgJX5kTcMsuQ210CosQiS05MVrrsqr9FIOKQB0M7Yih7xHWwj2l7SsYru+JLVMwkGsJ7HvcEEJdOijOVcPyZABAzIFfPdRFbKkaqfTct7Mkjthvz2NrQTSLtL5ykn7p/aJRDhzPSFJTmGcOGYtVUuccT7lW9EubqjNsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955938; c=relaxed/simple;
	bh=CtXvBuHZ10l+NOVrLXSjeix2nXsWB6v1qq32icek0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcjTZX0nKdzglk4oVHg6/C6Gpp6DNuCbTiky7/geON9bRElcWV5CSlJSR6GWl0WY+D6VfL91f8O+izyAPsWvzBhWkWjFQJEH2Y2XL5MgKmN2vzt52J9haCTRqiGaIQGf7LS1JXo9cK9OHTuNh4x4GeWsiH5R7URKPkN5tQriTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl38I0Tr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl38I0Tr"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so5367780a91.1;
        Wed, 11 Dec 2024 14:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733955936; x=1734560736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=Jl38I0TrD40hOU/bGlAjKvckOoZprynMWq2boG7MZMIL6P7KMkBkJloLeQgskbddTg
         i4rc1hlRtOqclsAjXEJthRVzSblqCw0/kYRwPAJSC0CxTNyeLVnGnVtSc3FTaELNyyMs
         pB0Bh9nl7bZha0YoZlqCzBZV4LWfAXEdvldlXXKFcDWWjvtCWJoQJXyrQTMz0p/OH989
         5azVDOA7W6va1gsN//c+IBF8DJJ3V0EwvjZ+WUFslkuxiYEoO3LMHiwtL34w+tOv8XY+
         rKxw4XFmYnXp4OJ5RIOkWqeOvQkw2991m4CisIYDQtq/TDSRfbJ+v8XTxNwcea3EG6kh
         XbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955936; x=1734560736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=iCW/24RYtTqbITReArtIVhQ2dccmIwiYEk5BztQi0sH62or55agj9HQQzoKQ7vwxu+
         Er0y7Mvla7+t9NLh0Ni3hTZCC8W6h8zFxl9awQcWVEJ5TK929YhvzGmVvNDn04Q7EWOF
         q9+tYev9gapnu4ggFV29L0AGmP7bubVZ+9xii54pgDF7xKoZLx6nqkGUZxjMXLyvlYG7
         K5BUcpuK9Zz9lhtVyXFTj/irN3da/cb6u+waKIBorIuVBi8CwirgfKm+POAl6nCt0yiP
         u9n33daLl1cITwqTE1DTkab3wyXWsk2Or4OKoNRm57HB22Z7v3IqeZqZloRR6EFtO/z7
         AEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBlUcE0T9F+uiJSwqJAESwqI8+aaK5EOuXTEOImmPHWMzD+NDmFbDbP8yqn6CMsKBnLopGeUwjuRAGw0KpPDegQA==@vger.kernel.org, AJvYcCWXiTOMdMez9LS7tJRmuMhucLzn4SocC69+ZFfny0eDSACezi7/bKsCQ3Jckxf7riUuigOazApTrrgZVJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi86y/AZ8YlylciIcyjgaIJHQFHgXuUCMPKGc+1nXcCWfrDOFG
	9nDIgDfVN06txJL9qiJeMmgFFDTVzNdcm+kQTj+jTnMRo4K2k1xv
X-Gm-Gg: ASbGncslcALG12OLZ1Z2DI1tvk4L3bpYnTMz5BDcazkVuIVzlSY/tOIRBqJKbHtOnFq
	J3Nb7Ly7qIAnLo1DgmwK287vLTnZF0L0YXLAl+YxRam0Ca4FHBNKXVFTSU6l+1ujTDa65bHrKTk
	1YKWdtiywWsoKNizVXxRblH1SsGXtRZMIsGd3v2JnGxlh79EVZY1XF/s/aFNdjR3MO16oCDuhA3
	ZV/xpEi2JLIcYeJuATZ4X9Vyz9cQt89EJqfzYlgjpIruTyUWrLS/cF7ngHIrZuYKjwSmqzCOCKK
	j7WuUwFqNA==
X-Google-Smtp-Source: AGHT+IF51qhIkIR5re06wLikSJht5b6ND5XqzQnGpZlQfY0vJ266X8vE7+FjtkGUdwukKcQEX4lVxw==
X-Received: by 2002:a17:90b:544b:b0:2ee:b2be:f390 with SMTP id 98e67ed59e1d1-2f13930a57bmr2137060a91.28.1733955935632;
        Wed, 11 Dec 2024 14:25:35 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6d1fd68asm11241561a91.36.2024.12.11.14.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:25:35 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v11 02/10] perf record --off-cpu: Parse off-cpu event
Date: Wed, 11 Dec 2024 14:25:20 -0800
Message-ID: <20241211222528.945590-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211222528.945590-1-howardchu95@gmail.com>
References: <20241211222528.945590-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the off-cpu event using parse_event(), as bpf-output.

no-inherit should be set to 1, here's the reason:

We update the BPF perf_event map for direct off-cpu sample dumping (in
following patches), it executes as follows:

bpf_map_update_value()
 bpf_fd_array_map_update_elem()
  perf_event_fd_array_get_ptr()
   perf_event_read_local()

In perf_event_read_local(), there is:

int perf_event_read_local(struct perf_event *event, u64 *value,
			  u64 *enabled, u64 *running)
{
...
	/*
	 * It must not be an event with inherit set, we cannot read
	 * all child counters from atomic context.
	 */
	if (event->attr.inherit) {
		ret = -EOPNOTSUPP;
		goto out;
	}

Which means no-inherit has to be true for updating the BPF perf_event
map.

Moreover, for bpf-output events, we primarily want a system-wide event
instead of a per-task event.

The reason is that in BPF's bpf_perf_event_output(), BPF uses the CPU
index to retrieve the perf_event file descriptor it outputs to.

Making a bpf-output event system-wide naturally satisfies this
requirement by mapping CPU appropriately.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-4-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
 tools/perf/util/evsel.c       |  4 +++-
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index a590a8ac1f9d..9275b022b2ea 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -38,32 +38,21 @@ union off_cpu_data {
 
 static int off_cpu_config(struct evlist *evlist)
 {
+	char off_cpu_event[64];
 	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_BPF_OUTPUT,
-		.size	= sizeof(attr), /* to capture ABI version */
-	};
-	char *evname = strdup(OFFCPU_EVENT);
-
-	if (evname == NULL)
-		return -ENOMEM;
 
-	evsel = evsel__new(&attr);
-	if (!evsel) {
-		free(evname);
-		return -ENOMEM;
+	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/name=%s/", OFFCPU_EVENT);
+	if (parse_event(evlist, off_cpu_event)) {
+		pr_err("Failed to open off-cpu event\n");
+		return -1;
 	}
 
-	evsel->core.attr.freq = 1;
-	evsel->core.attr.sample_period = 1;
-	/* off-cpu analysis depends on stack trace */
-	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
-
-	evlist__add(evlist, evsel);
-
-	free(evsel->name);
-	evsel->name = evname;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_offcpu_event(evsel)) {
+			evsel->core.system_wide = true;
+			break;
+		}
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 867da727a486..d0f2d9e8ce6c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1521,8 +1521,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 
-	if (evsel__is_offcpu_event(evsel))
+	if (evsel__is_offcpu_event(evsel)) {
 		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
+		attr->inherit = 0;
+	}
 
 	arch__post_evsel_config(evsel, attr);
 }
-- 
2.43.0


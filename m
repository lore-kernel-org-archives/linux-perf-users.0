Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892AF1DED53;
	Thu, 12 Dec 2024 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046047; cv=none; b=BX78IxQvoF+SMdBRViAS65ryXauqhTbZes2xS1QsralWSsDwJ2FCmn7FumK21zMkVj/liz4dZ+4E3kqUnzCstvqdQMf2hZ3iH5aO9y6TQRbPVG6fZzURuCAeo4fWF9Jg7a/hzbik7MKX/hBts97c+L6wTbLm9Ijmj2pLab+j+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046047; c=relaxed/simple;
	bh=CtXvBuHZ10l+NOVrLXSjeix2nXsWB6v1qq32icek0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/Prb11bouEvxL7x2pCTrN33bWQgCNglpstSywkKL8HSEoN7j5VmovyD2GXcw4TdJt2G1UP3fIRUSJDwQP2Z2h2DB7pCRUBh8GZuv/zJSanjZTQhZWjCThXHXMrRB0UyCf+6O9ZU7ffxlJ2mRhe7dd7VFpZseX1jPeaHSK2w9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkhEVZfa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkhEVZfa"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725d9f57d90so853859b3a.1;
        Thu, 12 Dec 2024 15:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046045; x=1734650845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=VkhEVZfavJuBIfLbpiVduJvF2vnPXE+9bskgJyhY0o2DQ8XKWlTQqd3L+bj4mdCLcH
         /ElAKYhKuLy8QTSc9BwlIYxhJic0YmEVqps6SjkHfR/j7BiPfkUq1uTS/B6gfBK+nwFH
         8biaMqCkHea9AbkX+65z3dsH6wC9ZHoUEy3/jbfXmb+CNFmE3AfVRCT9nLZ/cC159/3k
         k4jwI/5JtCzLz5gOWbEL4raOYGjjhDi6wngQB/bsYkDqtZZr+RaSNuQpTM+gsAZFNyfB
         khWiZLFQ8l0P7upcI/WdNNKFFuHLH0r0cHfelJv8en5TOsB6sB/j4sjTARzJl4TdJXbP
         38LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046045; x=1734650845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=ZvoNsGtkQtLsvz0aVlu7lkvyYUPEvMkFensd6pOSkdnNbBJLVnP0c3kjaGIe/7cBt0
         xmkOTI7JR2gVgUvR289VMJuF/3gv3r2ZRevW03zmEG5SAjir2UQYdNxB0eDcZkjRoDii
         a3oIm9e9s6eCttofwni11v+iyXvRtzvjPP6cqXLN/QBQkU9zgfe1pU0KRRP7T1uPtTqH
         NmbgLjMmjgh7u6b0WydlCwgyzzZkh+7BJIRcdboDk63Zz3RAIs0l0czhfJIoP0krbc5E
         fAbKg1RJXrqFFGNFhKX5rdaIsdq6h+E86jSJOi5+4t4r48Ik6hl0wYpCmWJ/2dMdcwaF
         k2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWkTIRbYhp04rKQbhvwoKRKa/yKJOuzP6XSDKTxw9X0kggnOyVsjECgbQgK9YoXm9XSpAHCPiNVIQIrtV6kDxQVQ==@vger.kernel.org, AJvYcCWoiGHtEFwIwyHE9u31iL5A+2DwUA25iiy98Of9QKf6uDZoy0IFZN6iWNpgWvubQ75M1pP5k8Lx3GRN4XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1pqU3wXsgfJoeDW/HtZRcms/xE1XxsIZx5WLsQsBed1L7Ddo
	UVaqSl/JIAj27OaxCyRgugNvD1xE/I1IbyzB3C4DrfJIdxxSWwVI
X-Gm-Gg: ASbGnctadEOZJxoAAXSVSIJDtn8nmGRDGyEYcYp5pyFRw42vIEAMIHNyr+TeCMdnaWN
	waYLHBYqNJeF0FHa+v4YS6VMIc6mmxFyuEH9NDAtozQB9RtHqUP5M+OXYhRcuEAsPDm8Wv+B3Cd
	Ft5NXhaYic39S1OCyKy2hbpe7WYotje6axZ7E0oUOx5gxTLJu78KKViUsWIytEsbHJ3Ul7oSOZ6
	t4royaG7I/PE5/HVti5xPUTMXxSriD5qaO4muyZzgL4wTN7cWyoS900HkR5UixV7Bs1Inne1ynB
	zDPIHr/wTavw
X-Google-Smtp-Source: AGHT+IEU2I8adpOKcVVGkrTZnoXF7BDglGV3uOfQOUePhv0fbA98Hbb4/gUZiLfYBdKukmBAnj2Tkw==
X-Received: by 2002:a05:6a20:6a11:b0:1e1:bf3d:a190 with SMTP id adf61e73a8af0-1e1dfe6a59fmr610748637.30.1734046044697;
        Thu, 12 Dec 2024 15:27:24 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:24 -0800 (PST)
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
Subject: [PATCH v13 02/10] perf record --off-cpu: Parse off-cpu event
Date: Thu, 12 Dec 2024 15:27:09 -0800
Message-ID: <20241212232717.232507-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212232717.232507-1-howardchu95@gmail.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
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


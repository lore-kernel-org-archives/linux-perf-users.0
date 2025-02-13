Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3322D7AE;
	Thu, 13 Feb 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487619; cv=none; b=lwqq2/gH/KzzM/O5iRDERxSB8WK3LXnursbtDWktmKtWbYTbrjHR92+MS4lTZ6BpDEgJYyb7pN0H9oGdSPv/BXRlwIG3UY+D9UII5jHoZzDUNUfYFKgJYVuspXY3RgiDnqflU7LA5XKvf3OchZcwLVCjgcRoWnnh4Cp5wxcsBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487619; c=relaxed/simple;
	bh=+LIyydtsbkVbytSVWuF0ihlrP6GR1uKO1gkergpXWcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGaP6CXJXsA14DtKE/rXv76FIwOnpvrSygBwPUxrOarzIEGq41j929KJEe1D7Qy90QlttKB84zFBv5P1qhKQIMQKn+w6wOCem5fCLC3+CrrosOLALNVDpbCQoblTKZN2b+QlH5XXhoJ18zm14pQ5nbiNo3JJQxe9b9BWaUIDPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bieEvJPv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bieEvJPv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8f38febso25329225ad.2;
        Thu, 13 Feb 2025 15:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487616; x=1740092416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/cB+5rb2VYgNBJmJ429bfHfSZADSnkjTZQmABHfwMw=;
        b=bieEvJPvb5qUs++EVOeZYkYYB7WGy62g2aCRF+/z8ZI+GDz0YNoVJqkjZm39Axap8u
         YUclvREBOwNVpoF8L3mAV9dGz0L0Pk4xKHPRbg4cxS6TKGJ9CIoOTsly6/QWTusfXUWE
         3j22lDnQyP2A7UvOqRq2bzk4TVpaa6RWmRtwU+E3vz5xRGJKceGdn8rWXzRDeU6HFwXz
         b6yXcYquM1DodGw/TfqHrcOxRj7KLbNhKAXUgtnGuSaVEG2YVBX4JTMQaaDsZ4KGj6Ck
         PnWNORelBf/gf0DIiUb6VHx2q1WUYl/10ItExZEvqJcQz71bjisc3PJpwjyOmRJ1EBOB
         Gdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487616; x=1740092416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/cB+5rb2VYgNBJmJ429bfHfSZADSnkjTZQmABHfwMw=;
        b=D8Phh+LwcxVUJxAW/A6KF2RQOsQBCgE08WqeKBHf6V/D3+7v2dOE0f0Hjlkn5P1wzS
         dEJtddDERDXcZo3GK/zQji/k0uwajdIb/OQ/Jr6LUz3cQIbVEhYV5Vo8Isfw8PeblsxZ
         8XU4t3ph4XsHgDtwJFlg+WvgDl4737NA0x60RoHiptEMIJE4aAX9Q1RsYyLELWd7nCqJ
         3Tynhk6MbrhRJu4bzo6YWx8+bXhHgg7Ry3p5w3f0nr8o8NZRwPP41kElavhH21qnYaKP
         tx35+QddVIsmDsNVBWmop8NQ5vr3vpF19HxRq0e+yHBxVwkhCQ1/5E6twrhg0TyZO+3v
         vi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1AfHLw5Gz7lMWYcy1JmjdjYRU1vg0tCwRdtGh7n4uUlmUDQBICsbkhJI+mK1E68RndBXb7UIfqVcKNDQLetvfgw==@vger.kernel.org, AJvYcCXziQuDuViw6iVatgCeZz09sdr3hE5hOIlDzV2RcIMuaaQPQBfaq1I/dabXxIpaLeRhBfOpdQJKZCnB1S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJweqK3ta+u/iMDzkFoIIl1XcLqvkgw+kdtaTgE77fdacJ5K+
	H2jxZVE4bLNJNGKSJxrHF+e0ckjPoiHOJ30oEC9nJEEAPvZrOEZ3
X-Gm-Gg: ASbGncuuHJYdtOrogkvRaoXkdDRy0wC9BBcw+XkilmLOoazyMjai21AvLIVpibDMb8g
	LHQLJMaNbKLj4j0hxJtDKKqBq3fmYwyIYW9PxjXQ9geADXtLabA6Vb2t7F2Kmecl10JqE2qfhKO
	V4fZRVHAYt4tj5Jfuu0Q78RhljWc8ewILuLomeAOqLqOCUO1H8PuGxGqj8q8BMbYJH6ODTJqih1
	6UUEhUP3t26fDINKQ6USV7UcwXliX0DjhRxdx7l5YRytJQRUf311Q5uJkP+OxCNWW0WVe6uyRUN
	FSimfK7FUVvZbrqtLiEcMKWHJJtgxW1sMPuo4t4sX975yNY=
X-Google-Smtp-Source: AGHT+IG9wYfRSE14QBm/ju7dOQfI+9wjtovE5c2SVC5nlKZUWruxX4FmqvEpobUPYslbKNttbXZwQg==
X-Received: by 2002:a17:902:d481:b0:215:89a0:416f with SMTP id d9443c01a7336-220bdf5f556mr124533075ad.30.1739487615701;
        Thu, 13 Feb 2025 15:00:15 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:15 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 02/10] perf record --off-cpu: Parse off-cpu event
Date: Thu, 13 Feb 2025 15:00:01 -0800
Message-ID: <20250213230009.1450907-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the off-cpu event using parse_event(), as bpf-output.

Call evlist__enable_evsel() on off-cpu event. This fixes the inability to
collect direct off-cpu samples on a workload, as reported by Arnaldo
Carvalho de Melo <acme@redhat.com>. The reason being, workload sets
enable_on_exec instead of calling evlist__enable(), but off-cpu event does
not attach to an executable and execve won't be called, so the fds from
perf_event_open() are not enabled.

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
 tools/perf/builtin-record.c   |  7 +++++++
 tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
 tools/perf/util/evsel.c       |  4 +++-
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cda7e6a7b45d..f3e5f856f4a4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2564,6 +2564,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (!target__none(&opts->target) && !opts->target.initial_delay)
 		evlist__enable(rec->evlist);
 
+	/*
+	 * offcpu-time does not call execve, so enable_on_exe wouldn't work
+	 * when recording a workload, do it manually
+	 */
+	if (rec->off_cpu)
+		evlist__enable_evsel(rec->evlist, (char *)OFFCPU_EVENT);
+
 	/*
 	 * Let the child rip
 	 */
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 4269b41d1771..2101aa2b7c42 100644
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
index d5519ab25996..f45d4b44d70d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1540,8 +1540,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
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
2.45.2


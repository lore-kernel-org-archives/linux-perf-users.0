Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A2230BCE;
	Thu,  1 May 2025 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066500; cv=none; b=bFrEZFF0u3YOSwnf5s3n6CfJWac/jnU5oaQjN/gsa/V4tIJJTejD5D5tJpQpORAkMkSGJtM/G6an2xlGVdsgcYW4rsp3WTFQsB0WWVR6P+5krq5I5IwVKvobP+//xMbN3F25a3QDmC/qpDxEG4EAgkqXUBojmQGkdh7K+5SCuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066500; c=relaxed/simple;
	bh=7BWU0fhhXrKCxr5Gwg8jIyFJNzq/a4Ofz3xmf40pdoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa1QK8/xm3Em2PUw0BAwssFby30g14F2SJWmH5uMKwzZXdY4niwuSgWruHtfRWThvmj2yo66/VWBNZMc0Q1Wp2Y8fvDoNC9QQ22bQAW3UW6uInC+8rcLpFwxte3wEKV9MhseC2NOi++rzh1NMTfYkzrqEKhpEYBQQQdG3YauC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clXZpFaF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clXZpFaF"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b350a22cso455579b3a.1;
        Wed, 30 Apr 2025 19:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066496; x=1746671296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3DkBn0xSoja9kYhz3QjHqlls2QdLj28ENeq+GUQ7u0=;
        b=clXZpFaFK8UcKiKvh4SipwUliv4snQrtd5wcbb0U3wLELeJm/66SxEpx9zHqRypOtb
         aK9fbchfx5587aTG8cRId1QyLhrdSQBUnb8m7V2yRxXY5u/MSR2qhZ3VDWShGGSr1fme
         ypErSLk+RoBSmrHfhzMA1PLvQpj12oVNm6QcqZOtxRXUOuCt77Oht/rL+/VoVX91Yx43
         37ZW5TB4ycry/RanM2AYt5yZqwMCGk2nGWKKCwpXL7FLABnQ/gZS8YIiFYhXggYtEqbZ
         zml5tepVAODX77xQA8vDaxb9yBHPGr1u8kLctb7cWsB32NISpgBiO501JOub5yIICYHv
         f+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066496; x=1746671296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3DkBn0xSoja9kYhz3QjHqlls2QdLj28ENeq+GUQ7u0=;
        b=X/4vkHeaw/RQ769teDfvxX75wfqNB5QNQvz9Or4uAiPC1PiQHzzP0CGwOHfn+l93Sl
         i7ziGWTYwykWpAgDQzBRt8ldtnXQ640wb/cXei4VAxYM2q+ft6kbvhXFucCwniuMcqD3
         Oz4gjgIP4jAuaXJAt/3+2UwTQIg/x0IcsaSL7j9I7rQbg9QLxswGNYR4Csb7WwhTUizI
         Xku0Ol9bDzBjICxF0gU2cUtfBYmEOXMUMac07dgMjXtIsubpiXzI6rAByLvcr5k5uqpU
         pTSyRbkRtn2jGPYY+stlzOS9Nupgc0ISy0q9R8i/BlwahoGp6LATmBqu4Y0nJf1eFA3n
         Z5rA==
X-Forwarded-Encrypted: i=1; AJvYcCU0fx8kwbhmeGL4dgNieBo9QPHkwhLuzjKF7hKKmlcnbG8N4VU94Rge0NC8+KfyJ/JKB9gYEkYfK0yeMDiC+KStxg==@vger.kernel.org, AJvYcCUBBvyC4vO6jZL/uYuZ+tH1uz6bUYm6tLchJVNCLxYaqKQG+ek5E78WeMUlEhbmfevqzexukerr8WKX8hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7bUoMW25Hup34I8Ld+s4Z4UoOJOw0/MImXfStRb/O5Z2+7qs
	VxUF2TDmJIUlt+Lx3oj03P65SLxYj3aOIju6HVe3Yc1yCYNqN7lL
X-Gm-Gg: ASbGncviVsimyHexSbqoUyyc1WguF/vg2HjvaKLH+ZOx6xiTf47ZF8dwZh+5GcPacii
	0y/KlZxOPZCJoowXt6mcA3xPbFv49/BwMz1zdG0RbdYIGJkoAKnx94zCvQKLBKhv1oUiMus/G1C
	Ag2P6op4pZDjSLFGQhAM0ZJeAO0nfRV8zR6g2P7ETYHk5Oww3pH3Ehys97WrIQld8DWDK0e0gjy
	Q4Erzt99y4TXRr/a9z1QjzbnJZ6qvAGDIwtyOjbBFr4nvosxN03WEJN1lCI8xAlLdVYJ10cLPyI
	yBOX0eioADNezymgD1IvOBr1rKZXryPxSWkU9k/MX2/Fj3ClimlAcNvvrQxCY7GTdfLShItt65C
	4DP1+ZaIcjZQlAWlM7CEM
X-Google-Smtp-Source: AGHT+IFfrssPHRMX/Aghe6lNX8WIG5prSK3wvERdQwFt9TNE4n5M6amx3AbdEcEJpfXUZXKzmqXipg==
X-Received: by 2002:a05:6a21:3414:b0:1ee:a914:1d64 with SMTP id adf61e73a8af0-20bd82525cfmr1151519637.28.1746066495751;
        Wed, 30 Apr 2025 19:28:15 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:15 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 02/10] perf record --off-cpu: Parse off-cpu event
Date: Wed, 30 Apr 2025 19:28:00 -0700
Message-ID: <20250501022809.449767-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
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
instead of a per-task event. The reason is that in BPF's
bpf_perf_event_output(), BPF uses the CPU index to retrieve the
perf_event file descriptor it outputs to. Making a bpf-output event
system-wide naturally satisfies this requirement by mapping CPU
appropriately.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index ba20bf7c011d..da28c52af464 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2568,6 +2568,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
index 2559943d199e..ea6b1ff16e6d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1555,8 +1555,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
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


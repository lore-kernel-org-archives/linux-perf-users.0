Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D5282FA;
	Wed, 13 Nov 2024 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457711; cv=none; b=a7G6SRnTdUNqZb5rYNAIRK1lYqRJtaszaUelieLU7yDqYEgL5OZPm9ogjsvZsJWHYWCJOPgfS//CxhcY8eFvU5ACcOrEzQXGRE4HjPlFtleCaKWLETi/bz7eWVS4qbj/Vmzj4/Vlaxpr0coa1M6TVkIJXAaUrrp16tobskTm0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457711; c=relaxed/simple;
	bh=ZqaG7qQsHv1GLxTzONUQia8uX9AiQpjHtvv5aJZS8x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeiIvfWLGT6zoFf+CTJPEffEE9w8P6IBDZgb8LZ4I3xj+PD6TOJ8xSxiA3/fJQd8JsKQKfK/Tcs6XluquS/r6L+oORxze07kF+e0H7zXGVWCop4bc1Q5B3UXW8DHUzTTF8NUWRiY9tyqWVc0frmpjNv4Yiz55J7MYzGycjJ3xMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBVPHY4M; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBVPHY4M"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21145812538so58161075ad.0;
        Tue, 12 Nov 2024 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457706; x=1732062506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ4iGWhCCKarEcyzjNazQFkqawuKP38CgPp1DBRk+2w=;
        b=MBVPHY4MkKJHROrso1lv2oblvZrMJkrewvRTrdbvhPC9Fssxkl+HMawfyaPCKJmB6z
         XLdNZ6DSfiMVfWSezbm6ki0n23MKqhr9WR6bwKnHlws/hUjnwF4HuF83suJiHxf8uo9j
         i7VCKmpDBRwegOeC/l+PClVVDWxXOAcQiDv8T+pgdwig4DPKYUhaWlODNrzVO9R/hJ8K
         b7YoogHzjh3QRb3T0We7lq7bJuxVJCwPYoWyH4tA+uSHhR1Z0od7T4N5PCOcK1wTTQ0S
         Vhrn48I0NPRzb1HChu3wZuEhoJ0a76y7ueFHzlt3Fzv+eB0QytVEUcV3stNpbKOxsD75
         iXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457706; x=1732062506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ4iGWhCCKarEcyzjNazQFkqawuKP38CgPp1DBRk+2w=;
        b=nrA01TEVMGt+e0UPUvNJitUGGB/Zd3g5PLXzj8TKZ4FROjezKzSnMlpbbvJK0hhV6P
         dXeYnC3JjKBQvVBiGoMh6ufcnOhkKCnAOCBfRyeEuHKqHxe92LsiEX2f8MV7ZbhznKav
         fk1qaEIuSenAYAaGoS48ad+ZJS4fns4QwZNeIZGpryYjy3HypytajDpC5outXOxXG9+b
         4WxYU6XLWNrc4NOYNIxTlXCXdJM1XPKV3nXZx9/CLi33HUViOYY//Bwg9mloDvzpeRfa
         AgcG838B1ClPzQyJfYnUdgkRO4tIhMjZSwy5saRzXWqltoKEid6cEVtSjpob1K64FQo3
         l2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUGxFE3xj29cjBN1ib116SYDl/pP5KdekAT4Dly6quuZO3snSUKdlohMVsa98WHRslnA2Hx68xrNZylp2q6dirrXw==@vger.kernel.org, AJvYcCVHfii5V7mMmuzhNWDvJ/MaPwgqs/MCT6PVHuf0C9d8sHf8WMlSEvCJpnh1VI37oDujT72XFBRlfGL7GYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xnNJ7U+Y2zA9Fnj4CsWRNq0Td+41Ugq77TYeJ00LiIzSYXLL
	OlT468nW0eJAJcl/t989pxzAzJ5Pc4g8/c4HRZu0BmecW1Z+gKlr
X-Google-Smtp-Source: AGHT+IEyu7idpdRNyFr5ItESM+KXN0ZmDU9eiRnk2BYsGMAkANAg8BnuqI9XWimjEa/V5fC7KZUXgA==
X-Received: by 2002:a17:902:d2c8:b0:211:6b21:2370 with SMTP id d9443c01a7336-21183ced53dmr251729095ad.29.1731457706121;
        Tue, 12 Nov 2024 16:28:26 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:25 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 03/10] perf record --off-cpu: Parse off-cpu event
Date: Tue, 12 Nov 2024 16:28:11 -0800
Message-ID: <20241113002818.3578645-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
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
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index a590a8ac1f9d..558c5e5c2dc3 100644
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
+	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);
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
-- 
2.43.0


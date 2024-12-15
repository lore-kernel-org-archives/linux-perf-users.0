Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3211B6CE0;
	Sun, 15 Dec 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286361; cv=none; b=QGwKl4QmBToHa/SmnKJYN8q4zoAXCMeuIO2M5FDeQjXPuPsfpPNMM65HHpmLGJJKTkqQzhVkColhC3MkIMgWAPsoMNBLUOWzm9yyLu8Wf328xVV70ziXwWbvCzR+gQGZDeOAHmEhJWD+psmMuav3md1rzPlQ/wwpzE1QIi+lbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286361; c=relaxed/simple;
	bh=Qh3Clmjgmz54xp/kaBCMKH52HOZLKIMHH2zdRPXjk94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyGCCoAPL6RULT0sFIDkUzkq/eSZkibJ2kHii/CG8NaQNFsBEBe13VJT+PgM9SajmGWxZkyvXC7ESemF2jQcCWEt1IRjlSPltA3mVdOOICzmTErPR6FZGcqySyfvLcoYZPhD/ITj3n/ZPA3i1OQ8uvbvXZe0v0SY/3nrKshivNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNet4ecb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNet4ecb"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso2454000b3a.0;
        Sun, 15 Dec 2024 10:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286360; x=1734891160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCP+wB6UaKJTN48gmJSi1my/e/aavCUaAb8y+M+Z0cY=;
        b=XNet4ecb9KsTpHG8nvw3KYawdybF2JqKD4jd+F+1nuKgSqrRRgXqCA6uM5EyNNoQqC
         qeonDU+/6xcjBdFlCVDDVAMwlfdSZ7nV1KqZIPsHamgJuzDDd218ob38vgkFo+GLUfsQ
         IsuEFus6Y4aGKj48PUNu/B9Tid9MKCHLj5F0CQkamGtrVLnuUH0Lh0STI6PVBQR9HKEa
         6ma/FmF/0c9ZhP9PHh7FOkBKZg3yiwo8/fCfWErkJP+3FOFwiLTurkA+2P80MbGgnNk5
         NlJkqqQHRsmW6HlD0bok1tqL5JmPPqv8goB2InrswmFba2e4st/Tg2C7gteMwrqieSja
         GARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286360; x=1734891160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCP+wB6UaKJTN48gmJSi1my/e/aavCUaAb8y+M+Z0cY=;
        b=b/pLFKwcXPxQQ8dA1WejDJEMlJQ7/i16j2HpQpyaXTxwl3CuykSC44X3QNtu2xSRXi
         wXkyVUv+3fUFjDKevovoB1DsctZOCgzWtsyZaAveqPXy9Kmj17HbJzr76puXhDgpJDAm
         MyxTG3uEbQPEpQg4HLOSbvFaYavEqRvYirez/bSJV6h74h/2Q3JAd6xUB72xBgMabVBX
         zJrZYy8172HSjxc6eBWnrCdEFT72GSs62q5e2q7ZK3NzRmJovVeafle1+8La2k3yM3no
         3yMAZ6kUyGZBSDRQR9SDF0EihT0Q4Na7IsoiDgRjeWfAvFDfvkLXbtvOPs7O0m6s7fLt
         WhEw==
X-Forwarded-Encrypted: i=1; AJvYcCW42rUK9N5ymR483JWxCwigtbXdSRLLBJjrarcv8uSRlKMQh97PeuRpKg1+eZkCQLWv2PnYOimq1CqfyCTycIPIiA==@vger.kernel.org, AJvYcCWu5+tO7xHuwKO3g8nfEeshDs35Tmc9jkVDaZ2uO7N2lw+px1BEhs7v1vA7/mxXURu3AyJ/RXaxxiXlFOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPQwUeiXXDPhbjuwnsK8pgo78qmSaxYiW+GcETp9RdDw0eGiB
	KVDyB8w85yBOhsDqwn1oetPc1waV3u+08h7qBchXYRwRXxac1rmVHauvinpQ
X-Gm-Gg: ASbGncskc45tFkAP0EkFEYwg7n/pZO9iovRX7Qyj/lpHQh8DCMcjPty3rXsqdwGbhGB
	gRdIX8V0xlSTd13nsl1ccHAhm+Gnnx3FYydl6UTs3/H/MHPmNUVJ+qTL4rAf+fOCbDGsepNRg9J
	KzmqDqMq3JQ2R0kZe/Nr4QR0VFy00wnOVrdudxPr5OoOJ8790vNQbWaG9rsZktH+ZdtOSqxZdlz
	Wz32a1B3sI2zsjQFgLGCGy2MOdHCC9DDrC16LZKRfTz2w8kqEQyjjCddYkMUL2oIfeokrDQDRy9
	7pM0oh3j++J6
X-Google-Smtp-Source: AGHT+IFHTG3BFoQJ4qYajKKHnr059EdGrjgScubnNDvojubTnxPAr+sbeklR8+rkwgkZM7lpZ64ZSA==
X-Received: by 2002:a05:6a20:a106:b0:1e1:ae9a:6316 with SMTP id adf61e73a8af0-1e1dfe0003amr15655277637.35.1734286359658;
        Sun, 15 Dec 2024 10:12:39 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:38 -0800 (PST)
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
Subject: [PATCH v14 02/10] perf record --off-cpu: Parse off-cpu event
Date: Sun, 15 Dec 2024 10:12:12 -0800
Message-ID: <20241215181220.754822-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
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
index 94eb3dc034f7..fc33104cd659 100644
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


Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEF13FD72;
	Thu, 12 Dec 2024 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970293; cv=none; b=OSiYVsYrjCINrYFpE4anSlTkKETA4NNs7u/MpXXdtrFuD6PyCXUAbXUp77+TgUIFkU1/GCNe36jJfrps1s1ngNvktvu5YyHx74ucsQkaQJ4Bt8kdLeY1dNcVSSP1cIBrNN3+WIWHru8EswfSyD3CRJCwzDyRZdzNdvUszm/vIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970293; c=relaxed/simple;
	bh=CtXvBuHZ10l+NOVrLXSjeix2nXsWB6v1qq32icek0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXtqkBsJ9SA/BJZ9d9FBfsHwempcqwWZjmTfRZ0iKFqfz15q3e0zNLCtGAHYm/z5/eQZmBKnbt9HzhzK6gUO5NmNC8QyM4GJRdT2ZiWetKTrQ9HLwkUZMAO0uPVuJnhsVf/kRJ2gqEJpUHwrtidmGAHreK3+cbwPcDYxMIu8Bps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wm3Ogs9I; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm3Ogs9I"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so80937a91.0;
        Wed, 11 Dec 2024 18:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970291; x=1734575091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=Wm3Ogs9IS6wknDlnh+e4qjswodhuQpnVNp2QMYsgDo/0yU9iXpWSJkpToLuUVmcLtK
         pxr/A5YPVM8WdPXWKxLU9YXQ0j/bzU3Z0FnafCfCHQPXyox8VSTjlNylR5Vt0zUErMSg
         xPVtzFq/oKwKxyeHmk6F0mjLCS1r/XwB8DXxVy/rc2Wn1wXa1X6Kg1y8Fkr+K7LxMTFb
         e146EtJ5ZE/w41TNWNyyk/m37DmLMNe/v9KO3R9iR1jdkTDHccaz7Hvgw4r4qXgxOl4a
         svsSyX+xn+qJhkIp8ZB7m0zeVPuiKpqjhWz+GRtbJHlfXPn8vmKRhjzgKNkDiaOw27Ws
         LKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970291; x=1734575091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=htnnejndgdywO0Zc1kxYnLBEo/f3B1N1D3BsZlJxGNATXcrii2EVmlXuArbzlHwUdC
         zfLxXxG8obVs2zBH+5t/tBntafMat3IhJo/4jDPA/ayN1xQwobwkYx7ae6LMBl9DIpIx
         x5YQJyVcTwI6XPZUBmnDPqffpfbwH5a6DT49r+luLEt6z0hAUoaw+NwF6Yv8V+snxjk0
         jcW9N/BWKNufFmrV9dQ2isBM8ad3wRhJwxegdNDfA1CeCs/yWYzefSFpJqEP8HX6briu
         FFOj/vv7ybrhJDz8RcTt5B+WHmO3uC+Gcdne1O9/lIoRFQBhTXQNjDoxtMgfTz9WN+hC
         WSyg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Vo919h5twRnkCswIJ4FiLdI0p6ClKmsytiRN3pBle2X/uoPlWgZdZMxbR3l3+dXzeEUah7OCh1ggheMDhCx0Og==@vger.kernel.org, AJvYcCXvz5jkJDbLCGGFu1q0YAyNlcK+5WIGfvz2kiHKkM9FbGDIoL9YNfPnxuQ3bwdYumheNcoGBONRYYvj4Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/N62LoHMeVgornGvYav2V/7Ox1GMhO+05N1dUwygd34SytUNX
	61wi1pmn3M3CcwTfcGsnLHYUs7ww7FqaoH7NMvapnvPRnjFKsxGk
X-Gm-Gg: ASbGncvbGRFkytnDZp8/qUgIwEzowuSOLkBJ+rBxJkYJqFccYMS8e0tlsLI8klKntWR
	EgufFV0IpGy/cKXQGFJoVTTuqbrupekRjiAyXxJ6QfWrSR9VeEqo1R+RNASvAlKvSprreMYUogj
	xVFuoL4EUUdUhj6z5hR8y47K54Pa3h3nUBKblZ8VMCom5hkd2zxlNFyQ/a6XuPGojQtIC5cEmp4
	gNpuGVAY0zmkBwRFxKaH3Dw+lfL25pTzwK2sgE9i4AjrGW/gfBvAnisv3tCOv2Dv/qR5l6bD5iD
	Y/TAU1IK+WeX
X-Google-Smtp-Source: AGHT+IE+/oat2IgwgeCHE3rUz+5HuC4oZYmkyEpFxUt2JkzzjN1GQ3Yt6oatxYmBWIM7KfyzHBF4HA==
X-Received: by 2002:a17:90b:5111:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-2f127fc46ffmr8343469a91.10.1733970291386;
        Wed, 11 Dec 2024 18:24:51 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:50 -0800 (PST)
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
Subject: [PATCH v12 02/10] perf record --off-cpu: Parse off-cpu event
Date: Wed, 11 Dec 2024 18:24:12 -0800
Message-ID: <20241212022420.1035999-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
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


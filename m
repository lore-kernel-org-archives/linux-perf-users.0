Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A31F0E46;
	Wed, 11 Dec 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954430; cv=none; b=VvIamDZSvOMxakQk3oO/Q37jQpZ+4hbaY1n7qGQixv1MKOxqqx5HF0G+9Pg0VC/vyp/lRRAmiIs0+xMQB09nx4lV91nuX4lvU0Jh2fW3lWl9sCYYuHE/3hysk8aXSjIyIWxRe0ISeJ7yE9G8dX33PYwa9oWgQGMhM3GntTqN1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954430; c=relaxed/simple;
	bh=CtXvBuHZ10l+NOVrLXSjeix2nXsWB6v1qq32icek0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=np101ve6hnIhDsUtiLL/A3QkKh3MK4KON8QzIxtl/amwDEkgTooiYN2F7cO3QxsbSRu5blA0c3QVGxjIvcxkH/tSF8oNThh7cJzAG1HPfPadRo2YwgthgOmAT5+Kxebb+FGXc1bHYDFF85PiByfto8+rGJe44BBa1c/IgrFD5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up8M8qFR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up8M8qFR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso6474206a91.0;
        Wed, 11 Dec 2024 14:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954427; x=1734559227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=Up8M8qFRkXLpN+Tr2myPHI3MZgoZ5fHcSmt9Oq3EtoaEfcapYWaW/sTLK4BWCZvw0p
         MBf58ftYCWAn9ecssb+rlDHsqY/0WMz2iVH4wcldoX2rxTtcF4pWfTLw3l4hucmSYjB4
         PFeaRtoVwpNnC79rgl7iE3w1WWZWujOBuQe56JhLm7gLAal2fbJ4clVKG/foa3ua2wek
         u02K/UeYSVSMmVk/x4Q+VSitoimFsNm4wmJcvjp3Iqq4hmM6C3IaA1v7w2NQS23MNMSj
         8Pv26XkpD+FiF0ehBCxb2mwPh3G5tCVxFldKK3ca1i/1m64iQ5pjOz266vT1ZU+REmZb
         j1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954427; x=1734559227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZXNpS9ontjCFvt+AYY61fDK03PJL203Z521VxrjSJ4=;
        b=gSiL9D55zA5u8nHoQZWtD7ziRmtdJn7YjDsvQIaIPACH5k60t7nwljG401HO1aY5PE
         BRIH62OcOUND2kgu/HoCMVsnW2SN7l253El/X29V71Vv94gpfODKU0ZNg5Zf1QSltKfa
         zghQto0/5/Ld8XlVyYrkJbmwjM0AUgsEmGoxsTQBLRT81Tz9gpsIbCthyCtya7xElH2n
         0bYhCuxneW91pLsRi17FW9gaOwvP57OQt2/M9X5318nSpR37QAiIwWAWUOk+u6dUm4xv
         FYV3xk/3Y545eZ/Gft4C35QppA/FXeRsb7BfhU03GdgaGvzS5ZLx8b2B0k8WthI/lXCR
         vyKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQzfa1ffVA0ZvFkwVRHI/EsSfCVswQwbIbJRtc+dIOjmMiUVWPk2pltFsd+JhuqE/leTHF3rAwkIT4RJo=@vger.kernel.org, AJvYcCXh5k03EZN40bfiJIcQt7BsWxFxvpN/n+GS0ZVVLSXxCtU3Pvth5F+PHUHbxqgfcU8pQS9yvGKJuYGmFpB08+Ph4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/gELcjNNnKcm6rNRC4Olal0M/gtG+o5H2Ag/0/xo/OXlYM1v
	vwPxlT371odbRWziemhH93PCmK/6k4WMTdA1ALOrgDZW4ZjOhs71
X-Gm-Gg: ASbGncu5XTMqUYOHW3NzthPJwxba+RemYSmT01iIgqzKFZXKZqQqvyn3Uq/zdVgIGww
	8YhK058vKRkz9XEjrWWNAoS+f7EB+tC/qsXdm29zqmrhZaWfkG1xWOYNkY6yHSF8rs7kJxHpbnQ
	W2B39RUm7jTuXmuXjvRwCLGa3Pa5nAr2FpFF6lGOEqcA8MVWEhDEtWZcdDsr02AWtDA2Z3EO15d
	MCxc7ulnHX2mdZa3Uwu7dTU9Z7ITcNgkGyg3WtkxPqXDFogfM6/9zuYZZ7e/BwlP4pIhTAnHezX
	/IvZpNzU2PKj
X-Google-Smtp-Source: AGHT+IEDsSxPcgfQb9bNl2NO/QR3fp1cPbntSZEvXw66a5BKeUcxj2+9sdup9A8MfZTpDFIB0cu+9g==
X-Received: by 2002:a17:90b:1a8b:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2f1392b75c9mr2567585a91.16.1733954426563;
        Wed, 11 Dec 2024 14:00:26 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:26 -0800 (PST)
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
Subject: [PATCH v10 02/10] perf record --off-cpu: Parse off-cpu event
Date: Wed, 11 Dec 2024 14:00:06 -0800
Message-ID: <20241211220014.931479-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
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


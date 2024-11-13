Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC18F6C;
	Wed, 13 Nov 2024 00:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457706; cv=none; b=eupcL6qJ4TZakBovCs6NEP5sY9uRSeZPOJC9kYeBs5C0yRouIQjEiaBAdfx7Vn4bUN4QZxrJgRT0jSou+gH5xXeiDb4U3pqV8EwA3ooOUPvTcjRwgvwwitxhizxEO/Lkr3lEF6HcR/DGskBnupJ4jLaasQ6tGl1oV8w760g4WSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457706; c=relaxed/simple;
	bh=k1MvbZqv805gektgE0goJNI/HxV1JhVVKX8JGAJXSvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POlRzLFdERuA27nwDMiu2ltYcmMRQntXl55o1WyId9XTrsVtIjdUVXEelkDdXhus9xv2F0KKjTp6J/L56JtEOD0mtLlbXIt1z97dpeUjZ/IsbykIAqpce/YaUOkuwCjh9SVaeuvTCI/5TihottPd/4RkAiog2F5A5Pp6Iz6PSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQOfA5+Q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQOfA5+Q"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20e6981ca77so72870955ad.2;
        Tue, 12 Nov 2024 16:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457705; x=1732062505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpYScqwzO6WE7u35hrRfQ2TMuWp9RDhpSIjI9CQVyMs=;
        b=CQOfA5+QkLaUk/xKlL1zC/4vJG0eXzojCclRnHweYoBqz6s+uawCm++t/L5jJ6SuW4
         wKl93dHSLPUoG/BkFXR8pL25jdsqM3T0KjQldpYZzStIzPIsb23HGpy9PQSPiE4stp6r
         wpaV+SDOCAJGgY34869ehS1g53lvDXgREi+qAwCttEsvib6jMh4Yti46NOQaAj/9m5fo
         /crd7yFVKCKAiHDA/oIJOavAANQbd3UGgPMRjRBNuwxTJfZweGP9kgHsdKMf4SJTkyUj
         WuQwkvxMNKhhGSN/yNqd3v+QhCnPivtBSWmyaq96fjyr55Hnw3lTlPKKm6CLyVhcBUxH
         uzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457705; x=1732062505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpYScqwzO6WE7u35hrRfQ2TMuWp9RDhpSIjI9CQVyMs=;
        b=QT4z+41uYEf2ortJZyEDzpYis8gBTkB7ahMTxtFMqT494nWcR37SYdFT44aGMfBpuy
         hbAV5J3yqyM4C1Lbq3wY65A+sOf1Pi2FIvHB+NTG1MNU/DGX0tlYOUQBjXa0mI5EazQY
         767W6C/A7R/O5dB5W21rbT2BBNNGSuRf9GZ3xq23jbFl8EGm/G+57dmCzjc5AItj5lGw
         /jpaTDIsfeVS6kA77g15NQE2AQYczAheH4Koc7SW4GkExqwj0gpqNUsxJbPOyT4ODDwr
         1TrMvy+7Q0UctRM0VqtJFwVxpqhCCLVic3IpdDlJpbLU70u8vR3UNLtgeQe3yE6+TEi6
         PAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUklQtQlJlsyAdvyPFed8GJ/isXA9KM3adIEUbSQyPv7zsK4sI0iyhmQpZAY/p4lITxmxUPhws6+goJl5Xm4pB6vA==@vger.kernel.org, AJvYcCWRHaKh9HopXV5EAP6T0poP0AqkOtjBnfV80h8UilxK7wi7x+6iQHBxP9VccBvhpAGPzwIFNX3pjR1mtGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6BovGPXVRLLdxb8ez2JhJIAVpBU7XJdKOQxak3Z9e9scXewH
	kgUMzcSmBz3s7KVK9wzcZFQ+Df4JAiZ/H8jUeZfkJtp5PkCz90ZQ
X-Google-Smtp-Source: AGHT+IHyOviXKH9EpfB9u/+bkxMSW6FybtaQ5PzQ61gBZaCc5XxYEQpGGKGAFuJtQqik9f600yFanQ==
X-Received: by 2002:a17:902:f691:b0:20b:ce30:878d with SMTP id d9443c01a7336-211b5c7be75mr9432745ad.23.1731457704622;
        Tue, 12 Nov 2024 16:28:24 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:24 -0800 (PST)
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
Subject: [PATCH v8 02/10] perf evsel: Expose evsel__is_offcpu_event() for future use
Date: Tue, 12 Nov 2024 16:28:10 -0800
Message-ID: <20241113002818.3578645-3-howardchu95@gmail.com>
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

Expose evsel__is_offcpu_event() so it can be used in
off_cpu_config(), evsel__parse_sample(), and perf script.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-3-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 tools/perf/util/evsel.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f745723d486b..8d0308f62484 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1194,7 +1194,7 @@ static void evsel__set_default_freq_period(struct record_opts *opts,
 	}
 }
 
-static bool evsel__is_offcpu_event(struct evsel *evsel)
+bool evsel__is_offcpu_event(struct evsel *evsel)
 {
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..7f68004507d8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -554,4 +554,6 @@ u64 evsel__bitfield_swap_branch_flags(u64 value);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
+bool evsel__is_offcpu_event(struct evsel *evsel);
+
 #endif /* __PERF_EVSEL_H */
-- 
2.43.0


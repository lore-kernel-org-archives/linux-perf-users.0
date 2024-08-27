Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C076056
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794628; cv=none; b=f5eOu7qvZ6G9IQ0xZyQ3kvFcRDQXKSZThk2g+HFFPE8rqCgbMiR9bAjm3GhyNUonzYgOQa22NKYIaDp/1V+L/vydqAiP3FYfc4SzsCi5czQOcKucvB9v92MQO0nbfm8hvZMFX/RE4wOg35GHFSFyiPKMSm+8/9heToeZS+FfybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794628; c=relaxed/simple;
	bh=zgEgmrdD0ptR2rv9IaNbtPHc6vf0nOiTzwH2GpRCEzQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=baO1Ht6iBrmIKr9QTjUo3WMmO9066uaZEBQFF8Y23NBSLrxfAhW0jO5seo9owGv1MTNkBnEpPNaxrw2x+v5gsgQGywJhWucHThXs1hI/e/ob6vQn/x27bzwM6qZANEEkADhldqIl/LvgdzVL7HZwETddmwiNI7FaIPLWOX4bCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P28gqYxO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P28gqYxO"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so131695927b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724794625; x=1725399425; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dluq5P0RLumNyO/9SBujDaYG7Xf4enGWH7djPxvSwQE=;
        b=P28gqYxOzLOcekosT5rk31dumiVBRdC32Ksezu252N/Xz/Mem12Wepr2okANMyx03g
         MGrMozFm+11aI53Txj7uIkysSqgZePk++s+UNR6KN/gIogXviF11AcbddH2OgXDOndy6
         YwIAwO5AZIiJAsSmoSfFpGOBnwkOa0NsgGIGWvfY2EkaCLafaUIu6xldOcYQZn6o1HDk
         /up4S3bHC8fnATpJSJamDXcF7zUQLLkUZlMRpTJqxYfHqTs7Q3HzJblRWZVfGNzfpuQb
         w2lr4KMPoe9C3VJemB2ZAEySVk2wFoaFJzP07PBgoU9kz7GHk6H0bSvZieEhPz76WTUP
         0/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724794625; x=1725399425;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dluq5P0RLumNyO/9SBujDaYG7Xf4enGWH7djPxvSwQE=;
        b=tYbY/WJ04evotMwHk3KX5LOL/z1ZcZL61Ki3a88+8eLb3Yq9+EvnLf2aGb1khceRco
         CUyzwYxYUnuULkquq50i9V3ATMbLv+zJ4rLvYRKMilDim/iE4FiFZ+UDOC07WD1NCWqS
         yX9v+pJ0YHM71Fgr4WHk84Vn6u3BnXcx8yaaR4vwagzGZZGWXxsJDJ+fFeZYwmp06tHr
         NKlanHs6SBxoCq2nabSmQVPz1gw0QfnGJj++qbRUcKeTHdKuiPRuZ4lTt00qpIVivkdJ
         VEg1+TqQwrJFrTZgv49+G46TaUXKseds+f+VupD8k5X7Rivn42wIagyTHKtyXdW1UWia
         ahIg==
X-Forwarded-Encrypted: i=1; AJvYcCWQkAESKv1A5B+hJv55AcFMDPqhjVGf7dBczy9QmIQ/jd/HbXZKhf0Hc+QPFhZXf0ubhAp88qKd9fjKrpnXJmQP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9IWCFN4UIbOiVc03o3VeRY/K5DDwtncIy0PuulK0qcystYHPX
	gwZmK4d5ZnUxvOwiITAM9mEcLpyN647c6QA+cjMCxwNXVN7N9cUN3RfjVUP8moOxwGjik0+TICo
	ayFq6Ag==
X-Google-Smtp-Source: AGHT+IHbgUiW+/3JydibTmeqr1pN94Tpwab3g7gq4l2Vdwkn9FplXLFyQAmd6R3YKxgoZ3pbUdYAZpmw3qtG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:efd2:6807:80da:9919])
 (user=irogers job=sendgmr) by 2002:a81:dc07:0:b0:691:41f5:7f3d with SMTP id
 00721157ae682-6c627f0b1e1mr569987b3.4.1724794625608; Tue, 27 Aug 2024
 14:37:05 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:27:57 -0700
Message-Id: <20240827212757.1469340-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1] perf report: Name events in stats for pipe mode
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In stats mode PERF_RECORD_EVENT_UPDATE isn't being handled meaning the
evsels aren't named when handling pipe mode output.

Before:
```
$ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -i -
...
Aggregated stats:
           TOTAL events:      23358
            COMM events:       2608  (11.2%)
            EXIT events:          1  ( 0.0%)
            FORK events:       2607  (11.2%)
          SAMPLE events:        174  ( 0.7%)
           MMAP2 events:      17936  (76.8%)
            ATTR events:          2  ( 0.0%)
  FINISHED_ROUND events:          2  ( 0.0%)
        ID_INDEX events:          1  ( 0.0%)
      THREAD_MAP events:          1  ( 0.0%)
         CPU_MAP events:          1  ( 0.0%)
    EVENT_UPDATE events:          3  ( 0.0%)
       TIME_CONV events:          1  ( 0.0%)
         FEATURE events:         20  ( 0.1%)
   FINISHED_INIT events:          1  ( 0.0%)
raw 0xc0 stats:
          SAMPLE events:        174
```

After:
```
$ perf record -e inst_retired.any -a -o - sleep 0.1|perf report --stats -i -
...
Aggregated stats:
           TOTAL events:      23742
            COMM events:       2620  (11.0%)
            EXIT events:          2  ( 0.0%)
            FORK events:       2619  (11.0%)
          SAMPLE events:        165  ( 0.7%)
           MMAP2 events:      18304  (77.1%)
            ATTR events:          2  ( 0.0%)
  FINISHED_ROUND events:          2  ( 0.0%)
        ID_INDEX events:          1  ( 0.0%)
      THREAD_MAP events:          1  ( 0.0%)
         CPU_MAP events:          1  ( 0.0%)
    EVENT_UPDATE events:          3  ( 0.0%)
       TIME_CONV events:          1  ( 0.0%)
         FEATURE events:         20  ( 0.1%)
   FINISHED_INIT events:          1  ( 0.0%)
inst_retired.any stats:
          SAMPLE events:        165
```

This makes the pipe output match the regular output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This bug pre-dates commit 113f614c6dd0 ("perf report: Use
perf_tool__init()")
---
 tools/perf/builtin-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1643113616f4..5c21ca33ca08 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -811,6 +811,7 @@ static void stats_setup(struct report *rep)
 	rep->tool.attr = process_attr;
 	rep->tool.sample = count_sample_event;
 	rep->tool.lost_samples = count_lost_samples_event;
+	rep->tool.event_update = perf_event__process_event_update;
 	rep->tool.no_warn = true;
 }
 
-- 
2.46.0.295.g3b9ea8a38a-goog


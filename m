Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFA27A47F
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874548; cv=none; b=BhyfNBeV2uGlIaXWMq6Pl9JouAmLezFoY3terB+4WzQW4PD35U/8o9jIQAPCQpbGE2fqBEfFqz9COYcdeDpyxdmfkMa7PfyfajDYGh1mHYK6sKFHk502Vk/bTNqpihCwzdhiemQ4IMAtcntMFknO7dtiQnBg74pVB8+dLj+LRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874548; c=relaxed/simple;
	bh=+i4xQMP5N+7tTEJLjyp4Lzml52ZZB5eYnS6qu0gy9v4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KivvP+rnkHR+FkekHupnHGFIzeuYZZKovhjkHeA9yWcbKmCf6fnfj4LWuETmc52a5REu0zxYnSQbEdDD2TXMw1OzB0+CrRt9IREPNkMXGc9HEWLJehH3Af1t5NxXh40gwYakhvLhfmz/3rW7/mfbIm/vo+GbI0vmMuBpETqyT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJ/HxC1H; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJ/HxC1H"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-252afdfafe1so37303735ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874546; x=1758479346; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HAiy3Nfgo/52bieljut+UzYUSPPtF1Iok2zeSkSwug=;
        b=gJ/HxC1HzC+beIGDqBSrl3LA2BA4UqboVMyWGWSae1UzLukO3d+FvWz5TV81egPBUF
         ZQ3ICgDXhsS6V4rqbdpftVcApTJR8mVUs+SJ5DTqwGpuG+GffU8+knVHKeY9DUrQNp21
         mHonehYRZOJU9rTPgaP0eofGxGAArXB9h9oCNC+j9Mt2lSj8UIgD6oKTkLJizSa25fLA
         YfyBzodNTxoE4eohyfIu/MpJ7S6lX3am5vWVvm0c98eG6gGkMn8+prD7DMWLczRRtoPm
         JDcFQvMBjD1PAugIWpFKpyxNHDwN0+aVdpQwKZOPJtSOLjj8eBj8LHQOHkVPcBgHijz/
         Mj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874546; x=1758479346;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HAiy3Nfgo/52bieljut+UzYUSPPtF1Iok2zeSkSwug=;
        b=Oap30cSIJeHeIng2bp4bnQT36NKwoG+VviwdT1k0ABMmDy5LMaaR/3BqeOtv7TT9i8
         h6EHkBMJyHJpmpZEBAItlz0OV0vzwNlZzvyO/bY5HjMOmJTNZl35nxdrWbH5Pusd2Cdn
         K7KiUv1m/qlK73XC6VvwEW/RCTDK+7z87RZQ0DFIrPQ58YuNv5vzSProjlvFTPv5d8gK
         TGgeoZDRuKiRHRh+fdJFA6LxVPpLth3y24oJjLFEeNFX2XJ/uMIJnNHo9PxIPZsTGDB3
         4LFGPghNUWc3o640t7xfATQXUfbhmy/WWUgJOVfj7h0dTcod895k6wHTH/BGl9c3N4Cb
         o39A==
X-Forwarded-Encrypted: i=1; AJvYcCVKd3VyOjEze+yy8fS8cQw0RH508qbMQI8QkVwz7C4QTSGI/Q4ePlCiQHJIjnirbYHkLsf4Heff/Dh/rlTF/5iT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/RkDm9BFqBPHvhjICMmc34rM13P5ZJ5/ubVHDUQDDqZm9YOX0
	WDScoxZnTKwqkxYkfRNNQoKULBueWAR3ogT1BmLJP7cWvoWtgomJiGzo5KA+znJxILOr/tNHnNB
	ZjLnkkVP3YA==
X-Google-Smtp-Source: AGHT+IHnyivzNtqrN3wSUVPkTq+iybkdIGO3uTylpMD8cdqzOFZYHwsBZlnbxQepi11eeRvtVPHlAeTVjPxF
X-Received: from plbmb8.prod.google.com ([2002:a17:903:988:b0:24c:b394:50e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78f:b0:25c:8005:3efb
 with SMTP id d9443c01a7336-25d2703b924mr126822205ad.54.1757874545977; Sun, 14
 Sep 2025 11:29:05 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:28:57 -0700
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-2-irogers@google.com>
Subject: [PATCH v1 1/4] perf test: Be tolerant of missing json metric none value
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

print_metric_only_json and print_metric_end in stat-display.c may
create a metric value of "none" which fails validation as isfloat. Add
a helper to properly validate metric numeric values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index c6750ef06c0f..ff90c23d1d62 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -43,6 +43,9 @@ def isint(num):
 def is_counter_value(num):
   return isfloat(num) or num == '<not counted>' or num == '<not supported>'
 
+def is_metric_value(num):
+  return isfloat(num) or num == 'none'
+
 def check_json_output(expected_items):
   checks = {
       'counters': lambda x: isfloat(x),
@@ -57,7 +60,7 @@ def check_json_output(expected_items):
       'event-runtime': lambda x: isfloat(x),
       'interval': lambda x: isfloat(x),
       'metric-unit': lambda x: True,
-      'metric-value': lambda x: isfloat(x),
+      'metric-value': lambda x: is_metric_value(x),
       'metric-threshold': lambda x: x in ['unknown', 'good', 'less good', 'nearly bad', 'bad'],
       'metricgroup': lambda x: True,
       'node': lambda x: True,
@@ -65,7 +68,7 @@ def check_json_output(expected_items):
       'socket': lambda x: True,
       'thread': lambda x: True,
       'unit': lambda x: True,
-      'insn per cycle': lambda x: isfloat(x),
+      'insn per cycle': lambda x: is_metric_value(x),
       'GHz': lambda x: True,  # FIXME: it seems unintended for --metric-only
   }
   input = '[\n' + ','.join(Lines) + '\n]'
-- 
2.51.0.384.g4c02a37b29-goog


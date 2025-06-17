Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684B296176
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199662; cv=none; b=evLpmHXt9KlUb8wmCuWTu5bc2HJ3kz6PFWGmttp0aEXPZlIrG+PNFS2XnSUWtXH/7I/JN4kBj8kg6ur9/2+ADqTU1B1iIjTUq+FIRwFEqcZ7jFsjrZ2gCvY24AuQlLrboogbwL4CevEPGa2xRI+q9fM/4WlpnG3pntgL3PKrnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199662; c=relaxed/simple;
	bh=DKWqAmVnI3GhwlYZzhOitEiQvCeNAsT71ZBhSUmrLho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ss5Axxh4BSSjqLkbE4025dsVIf7F/cq5HOBtVK4FVVo2VVFy8D6eVXcwt/eJNsvsvhI44913rFS9sHe5uzaJR8MA7Ep6IOxlNX5d5Ain9el86ExZSGfLErqcQn3jysrjO+Wahrh/LfVET8WtsOeKaC2tEz6or/+3gDFPeHCjeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gscKJxkT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gscKJxkT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2355651d204so51921175ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750199660; x=1750804460; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NVdRomOVcTP2K2Aa3QZ6be5ElrMwK+HxvBHDmuw/Uo=;
        b=gscKJxkTOqo+J9APwZV2yDVLnYOlJoZgGIXVAKFRdrZkKittyA+KS7Kav+iSTPYDoy
         WNYCekVW9nFNvkN5fmAWnSSy3YBgSw1cA0FbYAjr5Ol2t1akeTaaDuHL/m4g1N8SyIF+
         qkkVUTS60LlEixihFvwNDMyAn1gALMC47lDrfVvA6V3cTq1OvrAu6ZSyiThysqBiaHv1
         Gg41RChBX4A38k4ll18HbaYMsuZK1yfJlcTkBpbPAiCCrXnLNSh74spiGP4yVj/vP5EZ
         0gpxW+IBAsv/8Ja0wZyw4fyFn3F7tzOlh/V5EMpXTT50/HumzoQ9wAJtjMUxTFokTgzD
         W0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199660; x=1750804460;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NVdRomOVcTP2K2Aa3QZ6be5ElrMwK+HxvBHDmuw/Uo=;
        b=syBq7c5DyyMSa2rhf28RVPFb9Mb/moSArz0co6zqwxLOaNjprfn+WoIrhlKcRKlT6D
         672GdlqnOvMA0I4Zl1RmQY8i2wflme2Mx2QWjNMr35yS0Kzr8QQ4OHKBC2JZhBEg86ub
         UCXE3tHLKI+9VBCkgZaI4bBSFnGj2e6xL4JxLnfZ2PMH+Q/LH5WGox+BYtshQqVvzj/X
         V4eH8EDQm4cqnDHoeKiZopW6AbcChn2ByfwqjTZ5Kkl+onujJRGjgVPgiKc4/KV03i2t
         pe2LKl0eaa6HItuoJGZvSjyoABjgnuDzWbRYJ3Eak6CkwBqhsJwXHzMh1rUTiBrimgKq
         Eh3g==
X-Forwarded-Encrypted: i=1; AJvYcCXk4aitAUgDHn3wFil5S3TQnKywAoWZ7sFnWq8dLxHsj6G2LJgNOdQD9j/kHLtsWk3L3gBWL183PFtaRVovMvxH@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbE+rO+TYIZdfpNFVGgwO6DYhq+3KPB4IHvZ0mL8YOQHXddt4
	UC5H7+ORHsjUHSz5J+3GzwbsDIOyw2QhfGIW5EZ1aMP2p2iAnktAeJj0Xg72zJ5c2fmzAGkZSWB
	j84w1fRjA3w==
X-Google-Smtp-Source: AGHT+IE8zs/nB6Hv+1AZHqCM7YWmAHfa0nQQJL++2TtoGouKHvd/x1WiGB2F9Nz1dWP5IiUzlZNkHFCgj5im
X-Received: from plxd13.prod.google.com ([2002:a17:902:ef0d:b0:234:b2bd:b68f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc1:b0:235:f45f:ed49
 with SMTP id d9443c01a7336-2366b12216fmr215565525ad.33.1750199660075; Tue, 17
 Jun 2025 15:34:20 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:33:56 -0700
In-Reply-To: <20250617223356.2752099-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617223356.2752099-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250617223356.2752099-4-irogers@google.com>
Subject: [PATCH v2 4/4] libperf evsel: In exit add missed puts and assert
 close, etc. were called
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Andi Kleen <ak@linux.intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A missed evsel__close before evsel__delete was the source of leaking
perf events due to a hybrid test. Add asserts in debug builds so that
this shouldn't happen in the future. Add puts missing on the cpu map
and thread maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c475319e2e41..2a85e0bfee1e 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -42,6 +42,12 @@ struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
 
 void perf_evsel__delete(struct perf_evsel *evsel)
 {
+	assert(evsel->fd == NULL);  /* If not fds were not closed. */
+	assert(evsel->mmap == NULL); /* If not munmap wasn't called. */
+	assert(evsel->sample_id == NULL); /* If not free_id wasn't called. */
+	perf_cpu_map__put(evsel->cpus);
+	perf_cpu_map__put(evsel->own_cpus);
+	perf_thread_map__put(evsel->threads);
 	free(evsel);
 }
 
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


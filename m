Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28113634C
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523307; cv=none; b=lzaZ4GBAf2+G792j/WkEUJatqA7uW+HTkAGqGru9+EPeSNzOUlkNVk9omjASAVsdxVUryRYoEPUZxC1gaNhqj+MuvWvPtgqj70dXr7PzRswnML6BUe+vjePPS2iYXaAs4pttp5U2seghVfooeqvOtlnv9Jr+GkNkbPf/l8Pmoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523307; c=relaxed/simple;
	bh=K+iLRNmPq7pFFzgCwk+WDV1uDJdmXtPtLhF5jSJiB/Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rtogEZ5MhyFjVjfO1+4HpBeh0yty0fgazyWbJwLvxmVXLbqOnLo9M+yNKR3JoUQ58Nkvfuza5M22halFyggHGrnId4x0RcaGJ6w7+U8UVvBUMrKTCfozf54KUo+4FPr9DBF5TcPQcpdg+UUVLk/XXssqmQtG7ByKsucWeG6TqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x5xIBqVF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5xIBqVF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e30fe2a9feso6172887b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Oct 2024 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523305; x=1729128105; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ1kKijNUBB3h6Uf74qin1j8xVsGkQayF3LcGNTjFTk=;
        b=x5xIBqVFeBxtBJdwdHQEq+nnoA5B3ufa8P1FP9ZvPFNTVXl+b6KcLx4l4DBH4imNYk
         pUcmXtztjwyByctOxmWsEPHnh2u2ArBUC6lJAeGBvHw2VIE90WxFsumojuKwHQPv81hU
         ALrvS8gaH3zpHvo6oqwkWs6hFTfkwn2TfQhlg7+0HmN6lvNWngadZtxr6soXUXS0qJUc
         KOGJneq7rQC9neCi1Qvx7ohl30emiIgNfX9Y61mCoqNMJXhYSNSQg8KnFD2MAxkeWf1C
         oQ5r7DEvYWk2mAFPfNHXuIrjXMgaseVyJddUUoPU2h2i0aSS2WV+4yZ+mLFFuqEHy4p+
         vcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523305; x=1729128105;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ1kKijNUBB3h6Uf74qin1j8xVsGkQayF3LcGNTjFTk=;
        b=W/nCgYwIG8aihse5NXQyllQEJtjUOZOKbI5YJp1rJwAYMAUlvACYib7usNYgNTfmAL
         cEkUjZGZsoIBLU6Dq7UKNaxAFyfEF3u5ZE8CwrmeNCeSNsGvajUJqSmMfNhe9vdVIy8H
         T1eJTKnu20RhiP6tjG/b9l4fyK/xBF+5KEkKLdhJIIJRcE6vvp6rUeRDevTur0CzJoQz
         6uZXGuzfXF32+cw3orIKVK0ZpkgGcTouk1NGkAHmPdyowXdmIgIZx5Q2K2wHv/FwG/PJ
         MiH1N9oxSTOF4GZwa7bb+CUT9d4XFTFT4jFVLQUK/J9YoUBtFJWkmzpyj8g8TYrcjTZk
         dM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcckryIgAULosl2SnTjGEjLKhTDnmgmizIAWiSVsGUvrMsuCD1O+/voqX8y869D9oFixX0EOofANzK989dqFzD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1eJl6ukLRNKCAugI+Y21Yk6blPa3OXfaWssweWQhkhYeZ/HZy
	nBfR1TUlwocv4rLwpD2wJOtOs3YTl6SKehPZjdJ9y73OkBNX1Ia0mIuZg46FOdBxRi9xYt9qmzT
	izKvCFw==
X-Google-Smtp-Source: AGHT+IEJypg576UbQ5VaDO0MPAIHZNmppJpIj8JxQULvGLPW7W7ttj6J21OnaqDWDcmGmHFVb5umycK+sA+N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ac:b0:e28:fe07:e7d8 with SMTP id
 3f1490d57ef6-e28fe439b20mr61632276.10.1728523304658; Wed, 09 Oct 2024
 18:21:44 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:29 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 3/8] perf stat: Display "none" for NaN with metric only json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Return earlier for an empty unit case. If snprintf of the fmt doesn't
produce digits between vals and ends, as happens with NaN, make the
value "none" as happens in print_metric_end.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5402998881c4..e392ee5efb45 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -609,19 +609,22 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	char buf[64], *vals, *ends;
+	char buf[64], *ends;
 	char tbuf[1024];
+	const char *vals;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
+	if (!unit[0])
+		return;
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
-	ends = vals = skip_spaces(buf);
+	vals = ends = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	if (!unit[0] || !vals[0])
-		return;
+	if (!vals[0])
+		vals = "none";
 	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
 	os->first = false;
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


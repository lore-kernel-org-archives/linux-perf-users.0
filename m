Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F661E0DC3
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781452; cv=none; b=IfGtb8TzjGllXkbDG2lV9oyiCm+3GjizVyjXiJgqI0C4wE/rlvwC6b3U13F45bKkjUEqFPsCrdLEyhdUX+E53bhWp5q+M/njsuN1Hi6Rmr1bbjPyhlmajrwDSFOZBbFB6XyxFU6L9ePf9LlCVfUz5+8vYZDISWoEcOEHb9VGiow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781452; c=relaxed/simple;
	bh=SMz5hMAzgWKP7lTvIai1pMYw2CR0WUilsImxdukqyKc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Xpfypbum4JfiGZB/FbwgK1nxgv7j2NSXxr44N//kOvMkP4Y83VeNnikUgsxD4Xqdzttr1H9HgEiGIe7b1Fb+DmL3R2TQMX4VgUO4BREIVByuXUGGvqW8RYC1UjzMn3HDJFeCj/vQ+8t2dnBDiYQr8G+jyCWIVDUBY/jeZ+O57lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vjc+zr1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vjc+zr1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5740c858beso3236930276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781449; x=1741386249; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Ck10qS4AIVni+TJE8pJGK1gpI9LtVGv/HWjv7OGFQ=;
        b=4vjc+zr13Dtlbxf+Nk/7DSapnrCHFwSJ8sbCYkZVgJnSRgvK+AjQAt0XR6V5bV1o/i
         f6TDU6wH3SJefurO7rLWlBwUUqT74VG0MsPULJEazYZbc8G1uzBNlWXUlEbbJhtpFGHe
         XsX7LO61+9z5y+OtJ3OikoJ04vtKEnkk5z7cXBB7xEGD5NsuRpRzc0x+8S/PJyR2cJIX
         gx+67HT+bc5afjJrtZZCb+u/cfOyAf2z4DWXYbtBdoQ2hkkn1Jqo+z7iLa1N2YNGZx2A
         +Yw75BN8Wvw3jNGvI76vRp1JNbXZGrkVNQDKqBYigBsi2LdE79TxLc9Xx9SrtBdK/z2W
         DPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781449; x=1741386249;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Ck10qS4AIVni+TJE8pJGK1gpI9LtVGv/HWjv7OGFQ=;
        b=cxh7QhRSbjzRgjafhpnxwxx2vu0PDgd3e+fNvuuNP8S/VyYdekPf0ZLhziMaBPMoXP
         h1JFhdCyDCEJ3Gq2+0LjBZgB0bSgeRXBlTXokF2aAgKR237/LGfP7zDlYLGUo9CwBMhq
         M5SvBzWfhekY5BQpsGMkVUmU6uAgkP49jurc3at2LzBgHAUFGPYbeNKVjRmY71yrfmuj
         SnKnlEJ64hSjnYmOgAKN/vGuAoJhUpWgdbUkxs31EBaNE3J6XdW8jL19pXBKFCJ6/a3l
         LKAZa8rUSgMMA0s+BnnbvKxoqBmzwPRiAV0zieqPoRI2QhfeQ6OgR9nDFIdgNA7sx1r1
         glGw==
X-Forwarded-Encrypted: i=1; AJvYcCVbAlaWR6YF7WH9EZf62ZzOfowKY8B7IkunYfCAEHbp1HjpfsesPFApybd1wiE1aQBZ2VZWwHeORiIv2SYOMOJ8@vger.kernel.org
X-Gm-Message-State: AOJu0YwKf48a3WXPiz3ac+704F37sjSql4vPEc7OKzRJINlw+47pNZbz
	A/gmJn0B11AygQnJfbGf+uVWf09ABXWLu6wXqmZMLw5xlL4nY4ANwbMe+ry+KZGlUufFmyf9qAa
	cgIokwQ==
X-Google-Smtp-Source: AGHT+IEfAgbSFD2GZxEPGDtfX9Wvdb3Knr+OFfhlJnykxtIBlfOzAQ+++VosFQ1ujFxqWDc9HGj4dSXR8grf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a25:a126:0:b0:e5b:1032:bc4f with SMTP id
 3f1490d57ef6-e60b2e8e35emr32930276.1.1740781449510; Fri, 28 Feb 2025 14:24:09
 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:05 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 08/11] perf python: Avoid duplicated code in get_tracepoint_field
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The code replicates computations done in evsel__tp_format, reuse
evsel__tp_format to simplify the python C code.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e244cc74f16d..7f2513ffe866 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -342,23 +342,14 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
 {
 	const char *str = _PyUnicode_AsString(PyObject_Str(attr_name));
 	struct evsel *evsel = pevent->evsel;
+	struct tep_event *tp_format = evsel__tp_format(evsel);
 	struct tep_format_field *field;
 
-	if (!evsel->tp_format) {
-		struct tep_event *tp_format;
-
-		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
-		if (IS_ERR_OR_NULL(tp_format))
-			return NULL;
-
-		evsel->tp_format = tp_format;
-	}
-
-	field = tep_find_any_field(evsel->tp_format, str);
-	if (!field)
+	if (IS_ERR_OR_NULL(tp_format))
 		return NULL;
 
-	return tracepoint_field(pevent, field);
+	field = tep_find_any_field(tp_format, str);
+	return field ? tracepoint_field(pevent, field) : NULL;
 }
 #endif /* HAVE_LIBTRACEEVENT */
 
-- 
2.48.1.711.g2feabab25a-goog


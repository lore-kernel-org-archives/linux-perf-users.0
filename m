Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857A2153F3
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409097; cv=none; b=p8xSRrrqmZiCXFpxrwnOOEN6kn4qlir3HFE7vK7UGdo/+bCP7lX2FR1tIPMTi8m1r5T8I8qgp1bkHpn+xeL2dHOFCQKUssdyNccEX5Sx7i2Rfcft3pDEYtuOsMbEM7BoUTZspZXTNnN+uRAzXhMKsEinpc/y05GdX924jhP4mCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409097; c=relaxed/simple;
	bh=N9g3XQ+YXWEEo1w/ZtVTJnGqFkpfljKRoNayMFh1r4s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nvLYIsu3V3o0/d04M4ab/9hkdvgkUT/SXLlsbzKfhshF2b1x9bcF63uZl8sm0AwHlR83kONT/EPxVgcISJyRXFCeGYuLNw0Baiz+G9QtB2YnHgQ4xRWtG0mvcDRMXCDz5BoXM0XShTnbFQCqclZ/VgOixRr28GIjNTx5BWKUD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAqAEBJ2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAqAEBJ2"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39fd56398cso1454560276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409095; x=1737013895; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCIaMmE5oTQbNNVByMsLybBR+kGnWCllU9xpHtCnpII=;
        b=sAqAEBJ28Cq2QOiWmdF8JjjDXEuP0roU5Iy3RoDP17mqJjhQiNVvl8magbu2p9WdHW
         qNo870hsxrpd6bt8RwukWXB5Cj+QPga+7GoRC8MXygPANqp0TOPRD81/V6DYD8PbQu8F
         KiQ1nAIfBC/yNzCvwOKhVHo1gQuFssDkdVkCkc+yMF5zYL32GNV0fuJoXjPT8EHqdUur
         6PIk+tN3hq4hvzL3Ii7XqkCNzZmihZP7h7mm/sAwhikioYfijhk+B+f4aUBjzsuvW859
         HByfQFAPjQsyvH5AlSKhggJIXOPP8pQSGNEQBpvbuXKE7UcYNhp/+4ZkJxK4I7EWfaBp
         CbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409095; x=1737013895;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCIaMmE5oTQbNNVByMsLybBR+kGnWCllU9xpHtCnpII=;
        b=squrVZaC2uQLoYR9DRfykYtCrxkIMf/amN3tR3eeNySyBhUlHYdvfj3m2736ltr7B+
         OnUBGVz6EsFTVTPrb2+kzR7mzQKIGjJ1MjjccXlK3gSsrITvZo96I4F+yVLBOFymlOOZ
         EVlGm2CpZZZeZAgH/VCkr/UnC/y4qAkH6HljygKh1e4jjLoqoHZ3CcjFdm0POl3MKROJ
         Ajldd/abg1fLUczz7KcRRwyisjwpRpPzLBndzWBOrLrjkbUQ5w52aqZddmYW0jkNEnXN
         ZI7NAvBoRStorRANq59y1nLn7XsX4LdUYrPXys3JHWC6tdBynmqurMkycgm5ZhlDl2I/
         pbRw==
X-Forwarded-Encrypted: i=1; AJvYcCVm1WnNQ+7Uw2zaoC3jSsX0N8pKY7CcSlRIri+RrZelRZv8YFG3VWfjv0TnBo0QXRWPJh/HnkY4+qVf4LJ6gqBx@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrmshOHIjYLBR0vYBNCSrcj1XxYs8oWBP+5togPCSNBmKeyQy
	bzTgTryhLu8WdiYEErarITQx0Jiu205nRxEUYw/ipNBfhAATf4XaEEh4oTOOF7jFBc6ysKyF5M0
	YdUb3kw==
X-Google-Smtp-Source: AGHT+IHnypm3vAAFk44fbCiNzj6pbujk3ELry6s/fGfOOKb1n4y2H0Ml9tahNKZCNxrCOVZnTpDoTmUQsfSJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:c4c2:0:b0:e39:84c6:562c with SMTP id
 3f1490d57ef6-e54ee2413femr12379276.8.1736409094896; Wed, 08 Jan 2025 23:51:34
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:05 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 08/11] perf python: Avoid duplicated code in get_tracepoint_field
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The code replicates computations done in evsel__tp_format, reuse
evsel__tp_format to simplify the python C code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9ffe1b633027..d1ce3b6b5bf1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -336,23 +336,14 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
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
2.47.1.613.gc27f4b7a9f-goog


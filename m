Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83713793A7
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994178; cv=none; b=GekwcHKUfB/IWVReu2PpytDeiD3U/CS6Ioo+qLrtTumXFwnmAhUcMjRnHl2yioUbI95JJLh2819OixjKCS+Cm7nlmBZhlFtQ+UfRMgaQn0d4fX42sRr1SRX1SkojEcjYmKN2f0F/mZx1bQ4PkCppOCjfUp9nP9iH7EGci/NpQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994178; c=relaxed/simple;
	bh=qecOfwpAUH4LCxy4q1KK5VFozu/cb87R7uHRJQazbSo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NtX6/dKZ/sGbCVRxkeZNOXSgKO98VSaEr0ZdxtgFzdEvFnIZJSTHNaaAYjWC3mlvKx4517HsYYLv7UNThhpYiFFaoVVhAwQfi+tTlQ+m/nmSG0G+4zQqJZBbPH7UGh/C26zniVlro/+O2kGycfH6Yj/7GPj4iZKITNgbqetL/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovJCI9sw; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovJCI9sw"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-127133794b6so1633015c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994177; x=1774598977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXRiuDxBBnCQgq4Atxtx9TgfBpdePMN/zFN+bnAM7Ac=;
        b=ovJCI9swZRtO7hWCSvNxC/Ko6fjXJAImq7DAdF52g+jgB382+o/cYHKuXl+c2Nh9np
         mzZGXWPfljICm8N8wARFe4NF9KEmSBpPvVqDUghQqW4loi0MYeKJ/hymPL8lGNxj72X9
         yb3nYiY45XssA+EsypAoAfVdtiOd343FZ7BXBkR9alEXIlZ1+G3/YwJyiGOGKGcMmZ5v
         Oj74+nfXSfsBoU09iJq6586RTS4pLIc9RE05JdBbde1H8jXxTEz7AWiQpKkyerkJiyTB
         1tFz+iCoVfROYQwFNZgrADOXDRbD3WP5ME4QBZoqz+7ovKcWUFeyXlUB/wJdSkH5LCRa
         R3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994177; x=1774598977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXRiuDxBBnCQgq4Atxtx9TgfBpdePMN/zFN+bnAM7Ac=;
        b=VgaLJCaw0Hlt00lny8Acs2kqkyfoE1L+i4mnH7p5AGgQNbYYv3bSn4+EUqO0zk2hH3
         2zZAGxkTRt4ZSvr6UzPalmXfbEOBrmQOOp7F1EVIOrXAfDYNWPR8+baBuVoe0PgGHcio
         4pvtLbd8t/hTzmgL1PB0RBLiwS6MFqB9iyo4xv+SXG4gkfXjQxger5gdFIE6LW+sYQeQ
         kJWXOMdjC6QwuInfIsA807tnOQvnm4h/Sf3hIGQDYoNttfPiDwHBd9iv60iEl0qZGuk2
         63FcettOHevyFNnZ0gUw+NL6q6xuNaHYY22XH25a8C69YYl0AKl0l+gpoTQ9ZmW/kyxz
         XOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4fOL1dTLGkVXClLNjKQ/uuwRVITofNuaKcm8hR8R2IgRnp/IRyTYC7HWheAIUJ27vTfAEWkn8x42pfYUArBjm@vger.kernel.org
X-Gm-Message-State: AOJu0YwD19014g9cgJ8eY+wUomGEoJql+qK7VKG+XnQGScqJtGh5wDPR
	Hd692WMexu0mRjdb7jTYm6AnlWKMThgvUDRMywbZge/wDx0gDH6sDu7IUXF/aNti1DINLESorM8
	pwy7dGwuIPQ==
X-Received: from dly4-n1.prod.google.com ([2002:a05:701b:2044:10b0:12a:6ede:96b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:127:3f2a:af21
 with SMTP id a92af1059eb24-12a726752cemr902547c88.15.1773994176702; Fri, 20
 Mar 2026 01:09:36 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:34 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-26-irogers@google.com>
Subject: [PATCH v3 25/25] perf evsel: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1074eebbda89..9508d9430174 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2997,10 +2997,10 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 	return ret;
 }
 
-static int perf_evsel__parse_id_sample(const struct evsel *evsel,
-				       const union perf_event *event,
+static int perf_evsel__parse_id_sample(const union perf_event *event,
 				       struct perf_sample *sample)
 {
+	const struct evsel *evsel = sample->evsel;
 	u64 type = evsel->core.attr.sample_type;
 	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
@@ -3239,14 +3239,14 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 
 		return 0;
 	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 		return 0;
 	}
 
@@ -3608,12 +3608,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		struct perf_sample data = {
+			.evsel = evsel,
 			.time = -1ULL,
 		};
 
 		if (!evsel->core.attr.sample_id_all)
 			return -1;
-		if (perf_evsel__parse_id_sample(evsel, event, &data))
+		if (perf_evsel__parse_id_sample(event, &data))
 			return -1;
 
 		*timestamp = data.time;
-- 
2.53.0.959.g497ff81fa9-goog


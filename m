Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2051DED40
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781449; cv=none; b=O1FTT13pvcoHqS57zPaKa9YtZeGwo6pH4q7kKabVswqhs9TrFCT7K2fzstS5wHIWxEMctJ0vImYiTQUFrPuHKmS6IsoXJtQ4gYk0yoz694RtW9o4JrsN8fm2nEvHfnfUsc2JeZ6FB+EjfWKjXXchbukliJ10m4SCCFGzB8OD1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781449; c=relaxed/simple;
	bh=3U/cYgmD6vAgcdgCcDMxQT27dA1CrOHmVEkNQlnQDdI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=C/bpxpLoPuHea88utuIfe/v9s/LbAQOvMpAAasKtPU7GAkkw8VoU7exavbdvyjMs6Ww979ljA2izREZLT8o0qTdeIvUU364UU/xxfZg1ur80L3/3HySK+Zhr7QKof1Jiqyw67Z3s/e0xZDYLpXpbvtYwbiZtdiyJwcNtSr3nmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/yhMBqA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/yhMBqA"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e60b18e8e7aso2160135276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781447; x=1741386247; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWmfzvWfvxhIoKLCku8WgoqMCrsFvtRSiOtbgh4saZ8=;
        b=B/yhMBqACBFJJh24GUEWT+8YU919pbVBSUrdp3A5B+UzucdXmKjRAS57PYTAx9CVFk
         3fdAokpTSCoGnwY8exCYr/Ixs0FcXyHfQegaaz69lFkjsFA6OTpYs2Rly2NpLxF4hxdO
         qFnYZeQ7V9MJXepFyGtnVBD7GJCF5tHwznmflyghTb5ntqyM2oJtM4UDWBQVE9IPWCu6
         G4clIQy/aXNPiJagG4MUwOxKxvfMSm5keFmcBZVEOmGdmVo50SV6oCjf8rioyOjRkfmM
         xxK6SwaX+GY+MHO7ez+JMIO9aL6ZZZxgVvQ8D4qymdbsc4eKhQDpoBaACs7Lc7M7Evh0
         nmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781447; x=1741386247;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWmfzvWfvxhIoKLCku8WgoqMCrsFvtRSiOtbgh4saZ8=;
        b=PWpLg0nvQ+UfRozY03IPx4APkCCa2oAvCQjnoZorlh9QAB/nvH0uW0pIPZj89aKxPp
         851RD6zl2kV1/U+jPrXfVHzpCmnliEONX3+DhkpOSXokC+aF7Iz11TTmzEKNs4FbZwvK
         GLQSrQMX/oUicxG/+EajhoC6OCIvqLfGfZ8Rh4JyWgelUWLruOgf1D3Z5mMKydVX/5r8
         hjbJJJN1doKoh+659pqyof+ZpeY7V1b3zsFDc3evMPPJFfuednSGffC635cqB0Rfd2Ux
         7NHPmgO1IqkK60kvKSBVXrv28ZnYsV0hobH5Ly5wKBSNmjuztbpFFvm/5FRCiw6Ts5v8
         uzVA==
X-Forwarded-Encrypted: i=1; AJvYcCUO5lEIWShRk0LmTgy02T5i0KaoBRU21IWtHonCfVnxsYBTB+P5yC4RcvOh2El6vs9EKF8t09FDmWFifaqgLZGg@vger.kernel.org
X-Gm-Message-State: AOJu0YzMT4MSOBYQxXUDkLtPi+87RvlnirRt0BexmZHZx1Q1pem3IXHx
	ZlWe6oLwZiKF4K+nvj5sDUxkqBx2IszF5xa4dsPZrusg6rkq9OsGT7y+S3H9bgI/+ZTHX8u7ZrM
	dsZFF0g==
X-Google-Smtp-Source: AGHT+IH/nPjC9NzM/le3+8wxGvd2HBBDieU4nncgkyyZl5u9QM2UhIqdpSklmjOPeDgwQUJFXpb0phg9zS0z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a5b:b43:0:b0:e5e:fdc:88e1 with SMTP id
 3f1490d57ef6-e60b2f347b6mr514013276.4.1740781447186; Fri, 28 Feb 2025
 14:24:07 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:04 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 07/11] perf python: Update ungrouped evsel leader in clone
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

evsels are cloned in the python code as they form part of the Python
object pyrf_evsel. The cloning doesn't update the evsel's leader, do
this for the case of an evsel being ungrouped.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4a3015e7dc83..e244cc74f16d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1312,6 +1312,8 @@ static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
 	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
 
 	evsel__clone(&pevsel->evsel, evsel);
+	if (evsel__is_group_leader(evsel))
+		evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
 	return (PyObject *)pevsel;
 }
 
-- 
2.48.1.711.g2feabab25a-goog


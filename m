Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965888;
	b=jsz1dh3Ay1/PpJI07IaDCOKuKCIiFSk5dpAzqwRx5au2L++xilrJEQ16df7r3tLjVX1a
	 gW7rpuYLcNjrYT01UANaD5h2sgzSxYaIzUk43wIQecwVtrkKOnb5YII8RtD3fiAmdP1WM
	 zEIZPB/ICdXvSrYXKF8QU6gMH5TXy3ANjB03xMDG0cWlDrjZUBaV/otasGWGFSuTIg8zv
	 JlOpsIPrbeLmoIsRC5WS6zit3MB0Z87JBBZ+HbIwR4JdlO4Uf6786dV4oh/4dqtknbXYz
	 GBTfbY2yT0j922uoTg3HZfqtv0cHuCpr0Qp2UoqHXkLLOKoJR6hUNSCxs45Kjvreing==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=P4+5Oq0nOjNp6fO4fditjc4pY9SodPe+Ia1vUoXZX4g=;
	b=wx8pg9qPjNVWwrl8qsDHRI+pKcMnQJZdGNGR0ICn/7tdfy93Hqdcvhcl6Ig9ht7668YV
	 Mw/uJ0lTDD6n3VeBPIeximYBJmNgVk6UDKhzq8OMsOmn74VeOYjqrhcvTyz3yldxNi7q8
	 q7cBu24DUkvRaeNzJLr+VU72kW4VyoGpfzd2N+Pj1XfAjTLdQhYzB7hbNR1Sbt0BjW1Yg
	 T64QC4Hv4mV7KW6wIoN4jAZCoPHQScEBXUszsDllqyRDC3zkeDKPkCWkPDgC6p+PVCU9K
	 gqx97YmIRdNslsS6hVE2Am/lCFNOWu5fRtaYlamrG4JdV7ekp7z8iOrS8dsTD27mKIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cvrl1h99;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DFD606A31E
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58DFD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cvrl1h99
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso6051722c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 15:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965886; x=1793570686; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4+5Oq0nOjNp6fO4fditjc4pY9SodPe+Ia1vUoXZX4g=;
        b=cvrl1h99KW2jrjYwxZymFWRxxcePibcWIhet65tp/IrnciMaLTkvx0mt9iohyegtJh
         u+9V+ftDhNXpVUcs8Bv/a+wS/Zed5MNBcSZyYOaappbWzd0vxB6TVitxR+ipmDSI4ykv
         IWK+wsmwDnb+r5EtMHAZXmN8U8ydhd6haip4bMIjatjallfM2GRexn8jU3SHU4iu+4sM
         8PcAFwhG72O9gr3Dh85YZ7LVYWvkDFlEez79Ft1RK/2rYNaCwmiRc/tcFhxik1AfXaZP
         TsbGtTMVkPwH9Enkaa9v9px/WVTTthp29y24BIUuJcffb01sQVUuS/puvFhH6Hynv9pt
         e9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965886; x=1793570686;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4+5Oq0nOjNp6fO4fditjc4pY9SodPe+Ia1vUoXZX4g=;
        b=YXBr5wypN2Aw4vEfSQoC6L7YzWpeI8Fk1j710RLI3DDHddGYjCh1J3eTlqmR1XwHAR
         icVEK2Gh/+3pRpZzaoIyGUgyCuemWa6RoltCedzO7Yw/vQ7sylhm0K42crHigCdu8ZAF
         K2m/9Jtzb3zS5eB6nlM/3Wuc3upFiaGxeCL99HeAZga4D54E57j0kgbr3Yato9BM/gS5
         yzMgK409xO4Ut2Sa3xftXKa4Qzt3OV/Vpwu+LZlDwT2eqm8mKoFajVjQsnZNYS6NmvyG
         T9jaHn35oAVF+fJwPid5sEMt0PvwhgSTglw92FaxQZzmd4Oh1XwXupNi8fQpA+ycuhSy
         3iRg==
X-Forwarded-Encrypted: i=1; AKwUvBynaZkeGgzy+8dt4sIJo/g7zv06KILOiusDwogS23Pa1nOeASrus353hexZoSQ4iEjapbS/OVM0AhdIeRzfPa13@vger.kernel.org
X-Gm-Message-State: AFq9FYLK6g9uP34WqY16Ec54RxnflyxlO5heDmtBm2QnMZyM/JOcqplu
	T/sM1pgdi5748vy9+/bmIP3LDHMS/b0fOacWd/Pk77wYErgsVF313Wz1Xj1cL9jXJ//vXwBJZKz
	l0/U+JyIihw==
X-Received: from dlbpj9.prod.google.com ([2002:a05:7022:3809:b0:18a:a95d:606c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:204b:10b0:187:eb7f:bb4
 with SMTP id a92af1059eb24-199378d0778mr7890733c88.46.1792965886138; Sun, 25
 Oct 2026 15:04:46 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:03:44 -0700
In-Reply-To: <20261025220349.1244499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025220349.1244499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025220349.1244499-2-irogers@google.com>
Subject: [PATCH v1 2/7] perf evsel: Add bounds check for PERF_RECORD_CALLCHAIN_DEFERRED
 ips array
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In __evsel__parse_sample(), verify that event->callchain_deferred.nr and
the trailing ips[] array fit within event->header.size using
OVERFLOW_CHECK_u64() and OVERFLOW_CHECK() before exposing data->callchain
to callers.

Fixes: da27c4379ce6 ("perf session: Add minimum event size and alignment validation")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d060fca8090f..64f090ebaa5a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3474,9 +3474,12 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	if (event->header.type == PERF_RECORD_CALLCHAIN_DEFERRED) {
 		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
 
+		OVERFLOW_CHECK_u64(&event->callchain_deferred.nr);
 		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
 		if (data->callchain->nr > max_callchain_nr)
 			goto out_efault;
+		OVERFLOW_CHECK(event->callchain_deferred.ips,
+			       data->callchain->nr * sizeof(u64), max_size);
 
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
-- 
2.56.0.307.g5fe7bd680c-goog


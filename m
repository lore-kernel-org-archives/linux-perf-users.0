Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965316;
	b=LbVlkoDFrs6fedK9G2dFdqsuXIjZn0hmKfuIeMkdutcrKmcKeP1Hl6PHBi38/b08t/Dk
	 /oSln75fwlpkOEnw4hjvAIppbg8WcjpB4iw5Gx82YkwIg9quxDK82CKbB+tEN3p0qfeQU
	 u5U+XauTTggg5f2zcrC59A4TovyoUvI/jatfK924TKP1gEDFkcEQXc/wrSNsDoExGIKJg
	 CXuo+CL7SyOhbtuLbNJiwbxPaO/8ykLdw/3JnkNqUR3QOzHuOrvqF0cbx943OhIXtDsIP
	 2vCZVlK4b68eZ5SNSvE0XiSpj2HEoeCgs9kDW+GOXcokWe+DDpTEsODxt5vg2LH8y4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=be+eoT3QXvYSp5cD2UBO8L2IBVcg5ae12G53Zlbjp1A=;
	b=UzGtoipfOyXicnTunOUBHsCOOhl3MyOmk60XHF3jv5myx5ciXosHEfsijovlt0bVbVj0
	 ue+O9Wa35ypD16YwpTnoDUFTjrO422xXNRUSZ/2i4QjJxfgMk6VPMVNpe9RU2k2HWR7vZ
	 WKOV42Wqr2WNQ7nEICTF6CIvflrk1lF7ZjibL/tUGuu7SMeEQ6X/mhh/SMKODV85VZG2m
	 JrWX202vpt9cCGfSD0g+4bLrz4HeSKOnRsWWGE7305/3I6HcO4x7N5x1e6NDm5zsbiC12
	 Veb1NiJX9wzK4vAfTpOhzllM/8Py6sHKMdyNm7eFxjpqA4fzcnbJSBxvujpdi3wXGsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VHZNMs9X;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA840606A330
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 21:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA840606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=VHZNMs9X
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso4052431eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965315; x=1793570115; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=be+eoT3QXvYSp5cD2UBO8L2IBVcg5ae12G53Zlbjp1A=;
        b=VHZNMs9XcrJQJzmv9ySJ+QK7YaF3BopioLtT1jqlmjNamn8uKjO8B63GQQhsKn7jUx
         Cli249SJ26BQw4zQ6B3AuZTg2GtLSusoTK7Pbfjj3bYxmbV90ovqGRXgsFwY0/m8JSOB
         mv+MJh3zFZXcxKJKJCwLe4ZPZd8hC9zSCbUmFbcuUi33X0073PWx1GHzkf4StHySsAWR
         4rcTIrDH6yVgdhCpuTtPsoHt44O/C2WsMF05mGc//fmyUlx/SZcN6VS18vQ0nW5z/fxf
         HWlyHX7MfWb8Qy2uhHS4+2SpvgGcI2bBxEUYKChuD5O6TR0/dL/xXq1UT6bau1N7NAyL
         dDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965315; x=1793570115;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=be+eoT3QXvYSp5cD2UBO8L2IBVcg5ae12G53Zlbjp1A=;
        b=SMpAzfR7z1nbN0Q11SxBrstqzFFaM8PiTmKPGiczk3+T503zznv8lQJSFYBk/r1AJ7
         XYVS0l9TH0en3BjLbz22BFaVv7o4XMGncHbnVh6jJ22yyvjeF53Fvw2/cAO/7NHgb3mE
         SQ1u7XdrkxgjPBsqStmMOx7SetHQdnm+X9f/bg2rBLqvPra+DDTup5BD81JQXj7O1tTT
         5gLSZhd/yK82TVrkIm3TBpMHsGgPuqqER16xKeAFKiUTXqAHAreXkJrkfolPmS8aKePA
         0KIn4FwRIG/LsoAxchvDtfvwZ671HEl2QgcjmNWWJZ878a4NrXJYpjn2Z0q5P+n0x6RY
         tH8g==
X-Forwarded-Encrypted: i=1; AKwUvBySeF7DFaSyHtOQ1WkclssAUGa4aFvSq9OxBcAKTFKM48p7JwzTeYfTlKti8u/dyQiOKdXFLXy0ExPQLQUlL748@vger.kernel.org
X-Gm-Message-State: AFq9FYIgT8jHDe/o12+iHULNcj/E+RGH+6GZtOVi02t1nOdHQnPmjuvH
	jG357mvatrA3i9Y4cVDaBCcaqTs4/XpBzeONZPWHxgJnGsxU9hBkypCloemVYXrE9kLiW4CNNQm
	WNR8qau1MuQ==
X-Received: from dlad18.prod.google.com ([2002:a05:701b:2212:b0:17a:1e54:4da1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b887:b0:144:fb31:a597
 with SMTP id a92af1059eb24-19937bb1b5fmr6558543c88.47.1792965314300; Sun, 25
 Oct 2026 14:55:14 -0700 (PDT)
Date: Sun, 25 Oct 2026 14:55:08 -0700
In-Reply-To: <20261025215508.1237480-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025215508.1237480-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025215508.1237480-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf/core: Clamp deferred callchain entry count to fit
 u16 header.size
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In perf_callchain_deferred_output(), if trace->nr is large enough that
sizeof(deferred_event->event) + trace->nr * sizeof(u64) + id_header_size
exceeds U16_MAX, header.size wraps while the output loop still writes
all trace->nr entries into the ring buffer. Clamp nr per event (accounting
for event->id_header_size when sample_id_all is enabled) so the record
never overflows u16 header.size.

Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b43883a42566..37824ca7fe97 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10385,8 +10385,6 @@ struct perf_callchain_deferred_event {
 	struct {
 		struct perf_event_header	header;
 		u64				cookie;
-		u64				nr;
-		u64				ips[];
 	} event;
 };
 
@@ -10395,12 +10393,19 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 	struct perf_callchain_deferred_event *deferred_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u64 nr = deferred_event->trace->nr;
+	u16 size, id_size, max_payload;
 	int ret;
-	u16 size = sizeof(deferred_event->event) + (deferred_event->trace->nr * sizeof(u64));
 
 	if (!event->attr.defer_output)
 		return;
 
+	id_size = event->attr.sample_id_all ? event->id_header_size : 0;
+	max_payload = round_down(U16_MAX - sizeof(deferred_event->event) -
+				 sizeof(u64) - id_size, sizeof(u64));
+	nr = min_t(u64, nr, max_payload / sizeof(u64));
+	size = sizeof(deferred_event->event) + sizeof(u64) + nr * sizeof(u64);
+
 	/* XXX do we really need sample_id_all for this ??? */
 	perf_event_header__init(&deferred_event->event.header, &sample,
 				PERF_RECORD_CALLCHAIN_DEFERRED,
@@ -10414,8 +10419,10 @@ static void perf_callchain_deferred_output(struct perf_event *event, void *data)
 		return;
 
 	perf_output_put(&handle, deferred_event->event);
-	for (int i = 0; i < deferred_event->trace->nr; i++) {
+	perf_output_put(&handle, nr);
+	for (u64 i = 0; i < nr; i++) {
 		u64 entry = deferred_event->trace->entries[i];
+
 		perf_output_put(&handle, entry);
 	}
 	perf_event__output_id_sample(event, &handle, &sample);
@@ -10430,7 +10437,6 @@ static void perf_unwind_deferred_callback(struct unwind_work *work,
 		.trace = trace,
 		.event = {
 			.cookie = cookie,
-			.nr = trace->nr,
 		},
 	};
 
-- 
2.56.0.307.g5fe7bd680c-goog


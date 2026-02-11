Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DC2C15B5
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774778; cv=none; b=jQz1puBhc9ovOtTs9owA/0T8fi/IynENd6azw3Kor0/3HDOaOBQMu2RwIS5Lm97yO3jltoCARVWs6uzMg6QJ9VSNb91e3XEl0bn11SACI+fvba3F0iGCaVzDa238CqFmgqrGEpnqUMYbvlkrGM0Kbc3tIVGVzIrTlNyNGCgtVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774778; c=relaxed/simple;
	bh=GtzZQe4Cyczg2thV7yGZJSLtC9TeQUSKesXkt8zVUEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=X9xxhNmtsO9/whuRhCk0r3id9i75RMJ5/7jBBiIYigIWckmsIM6xpOZyK/ttYVjM9WuJ+E1EV4tv4igd8qvSAsopRQBkONIqkxepvivlqwakNoEps4CCjpMwMmfHwDNipPKn93WLIJ896EOKA8b/Y3pAncgflTDoxc6K4RIDQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=btr48qNI; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btr48qNI"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124aa710af7so28038802c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 17:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770774773; x=1771379573; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/qLzlsqfHs+dLny8bu5w2UvyZ2sO7c+56V79RBEKH0=;
        b=btr48qNIUCx57yBoIEB8H5cRgXMvr/pGAh4IzBphPReW2/wgAahkcw6mcelaCDN4Pk
         Wf/Td8dS6A6VJDXvxUdmNtGuBUfwR+pBHyP6FHy31HtYiiQIM6bm3z61olD49RY48w8e
         bFCDwnACKwfyMp4TpQ5BysAqKROjBidhUIR6QC2p0azUJ3UHsqlbTdLqpJImXngwsmBe
         aTHyQQ9VH2ANa05Bht2XiZTRgUU5MnU8fA2FUz8l7LsfpJx6MMSwDKCfkkB515oJf50L
         smQ2h5u/pgfaLboBSu1hebpqPF9of0F9G1LL4hj3QQ8TStOfiGFpwUllyw+McTWN5AXF
         oGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774773; x=1771379573;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/qLzlsqfHs+dLny8bu5w2UvyZ2sO7c+56V79RBEKH0=;
        b=hx3vlitbcSwBGikp+X6y+/SVz8909FRr4Pik61coNqIX9HSvKOP03kRSa5kbT0uQeW
         KYcXTN8pGnIxgBFTkk6+eQCsbs3WHo0PlbHYGng9UmWAASMsIkxE5r0zkEi9baFZexmr
         CpuyKMjugyRCA7+yFYwP/Uls00JNMpEJ0MuIHZaA+m33jAZiF1qOpxBYpZaPojGg0aBG
         P0KossC+8S10p1oY+L5sOW9X0HeG7ua4WwSHHvkMPppSxWxz+hA3JTi7YedhraomccJY
         OocfJcDNOMQrGf6IGRbEZSHtLnHNy3gQKPoY7xmpBy+f6Omzz43XjT8c1idHnA8Ydz7t
         VtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvd4J8txZ1KfQY4bnZlqJukdfUK1xvyTb81sMHnnoPwieAKFe8NldVP8lQ1XvAHduWEuU+Jd9vWfqPlIayH+yo@vger.kernel.org
X-Gm-Message-State: AOJu0YxylAjOkztRRyxiOkpc2Sn5mGk+oKSyjSldJcwGT5j1AWpkljOm
	JCGJ5m8/wBFIDbvmuJCz8D+ps1UuksbsZhtUZG6yRAFqw4lc2pO5tlQQJiCEzwzB0W5CYBEXS2L
	PS9bVRnFZvA==
X-Received: from dlbdd17.prod.google.com ([2002:a05:7022:a91:b0:127:cec:12cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:102:b0:123:34e8:ae96
 with SMTP id a92af1059eb24-1272437e6fdmr2166858c88.37.1770774772750; Tue, 10
 Feb 2026 17:52:52 -0800 (PST)
Date: Tue, 10 Feb 2026 17:52:39 -0800
In-Reply-To: <20260211015242.2700218-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260211015242.2700218-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211015242.2700218-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf json: Pipe mode --to-json support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In pipe mode the environment may not be fully initialized so be robust
to fields being NULL. Add default handling of feature and attr events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-json.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index eefa3a94c813..6a626322476a 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -48,6 +48,9 @@ struct convert_json {
 static void output_json_string(FILE *out, const char *s)
 {
 	fputc('"', out);
+	if (!s)
+		goto out;
+
 	while (*s) {
 		switch (*s) {
 
@@ -71,6 +74,7 @@ static void output_json_string(FILE *out, const char *s)
 
 		++s;
 	}
+out:
 	fputc('"', out);
 }
 
@@ -322,6 +326,16 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_format(out, false, 2, "]");
 }
 
+static int process_feature_event(const struct perf_tool *tool __maybe_unused,
+				 struct perf_session *session,
+				 union perf_event *event)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(session, event);
+
+	return 0;
+}
+
 int bt_convert__perf2json(const char *input_name, const char *output_name,
 		struct perf_data_convert_opts *opts __maybe_unused)
 {
@@ -360,6 +374,8 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
 	c.tool.auxtrace       = perf_event__process_auxtrace;
 	c.tool.event_update   = perf_event__process_event_update;
+	c.tool.attr           = perf_event__process_attr;
+	c.tool.feature        = process_feature_event;
 	c.tool.ordering_requires_timestamps = true;
 
 	if (opts->all) {
-- 
2.53.0.239.g8d8fc8a987-goog


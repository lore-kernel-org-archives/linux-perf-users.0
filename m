Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902552CCC1
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766393; cv=none; b=J/Ks+yk8zs0rNBQFAkVRxMkTeIkPZDwcjlB2JwGpBHsbLv7Jb3EOXh7QInyJFZWsdUZawGxVZdmhuRkX744sxUhFetNU3YdIUQ+MzpraOCC6AezeukgkXFdG9eJyLahNjeSK1TOgzVKMNXON9cPY+MEIjBL1g3ZVF0GY9ma/ngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766393; c=relaxed/simple;
	bh=TsjciXmWqrprKQmPUDQvCle3hS8U2TnFcaL8HSWbgjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cfpzw9/MkpfVBJUUvafXy7uKWbZsZShHuq6G//uKdSVYDBYCaocNGiA2NXF2cm+LMQo8szX0JbiStWkiH5OoBgeGGkBqAXf0yDOaB9GOt4G+4/BVzSHpOmjUZtmiFH9ST6IOrLo25oFlbPeWkwISPeMmUmJN9/cjx+VOIujd8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRjemjTO; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRjemjTO"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396901263b6so2128615a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766391; x=1790371191; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5xBOq/t+pD7MkHskvUYWbSjmSj1yyzqP7nUm5783BE=;
        b=GRjemjTO1G9Jtdw8NpXPAgHESLLS9s/lGKY7diF0kMXlCeOdUIA6kQIzg4CId/nRkl
         rEDPhdj+N1DTVLxAIB/uwT62+HkYV5dbv9ezLeYHkihTnE3XWnEXc1GCK6tUaK5Q63ET
         OP0NwhqFFR3eFOMcg1qDJJDdkGKgcWN+Fp9+hG/2yJg98g+Emp1rSGMS/X+77gm6+FVR
         WNUjT69tmmzlPZGBBppWETUFpvMLMbjKwyMY+fbmUaUQH9n2Lhyhi1vxjuaaA+C7/utK
         aqpZzWBHwQxroGuq8j2cLPUTAN3iBOoOW2l+594UNZsyX1a0k9faheNokTdwozxA9uY6
         krKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766391; x=1790371191;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5xBOq/t+pD7MkHskvUYWbSjmSj1yyzqP7nUm5783BE=;
        b=Q4b+D9eNGKvcKIcB6cEz/NXNwuSM2+6llX6oHvo0oTtcDFIefRrRISQFL1PA64hQSq
         3VRLnKMu/bdKHf1ImQ72E7f5IMsM+/QqVl9A+gIr9kTizQz6n9SRDK+ibDcoYM0jTuaM
         jpoBkfKQnnbhBj5emjhq1I9npqRJAX+lklcNTWOdzopA7demsRZR/NT1ccZFZribtbFT
         rfPS+RAOZEQDYsABQP4lJxWLH/u+AKqU5dwva2LDi3EeyEMn0Am71B3AUG+PNmrhXcjM
         ExLckPZp/LoKgRkQF1cPX8B1XQlvp8E83nMI23yDMA26mJ6yROqzki+Kft8B/48irTtd
         Lrtg==
X-Forwarded-Encrypted: i=1; AKwUvBxzeUzKWXYsOlDLCCbOCb/6y1Lbanx84ahILDUmzoo2HmQMoI0vwL0MiiDdw10drMqzwPQ6O7T3gg2B//6VvsIA@vger.kernel.org
X-Gm-Message-State: AFuF++luU2OZ+VXulb35CyuTn4+lB/HoCgCiBAmZK7B3z27vRfL5Wq8w
	WLX8tkLIuoYmB1E+3ceUCBR9utQNs6mcFNC96+IYBRixL/mIMOQj+gq8q1j1+/V7+z2u9W9NnG2
	n3kBUubfQEg==
X-Received: from dldyr1-n2.prod.google.com ([2002:a05:701b:4501:20b0:144:c737:6f14])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5305:b0:381:6c5:3f63
 with SMTP id 98e67ed59e1d1-39e54dcd917mr13198461a91.6.1789766391234; Fri, 18
 Sep 2026 14:19:51 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:17 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-4-irogers@google.com>
Subject: [PATCH v4 03/18] perf evsel: Report an allocation failure as ENOMEM
 when setting filters
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

evsel__set_filter() and evsel__append_filter() return -1 when the strdup()
or asprintf() that builds the new filter string fails, and
evlist__set_tp_filter() and evlist__append_tp_filter() do the same when
handed the NULL that asprintf__tp_filter_pids() returns for the same
reason. In every case the only thing that can have gone wrong is an
allocation.

Callers all test the result with "< 0" or for being non-zero, so -1 has
been as good as any other error so far, but it is not an errno and so
cannot be printed as one. A caller that does, such as

	str_error_r(-err, errbuf, sizeof(errbuf))

turns it into EPERM and reports a failure to allocate as "Operation not
permitted", which is no help to anyone trying to work out what happened.

Return -ENOMEM instead, which is what these failures are.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 12 ++++++++++--
 tools/perf/util/evsel.c  |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c3d784727810..d403ab610bd3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1232,8 +1232,12 @@ int evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	struct evsel *evsel;
 	int err = 0;
 
+	/*
+	 * The only caller that passes NULL is evlist__set_tp_filter_pids(),
+	 * where it means asprintf__tp_filter_pids() failed to allocate.
+	 */
 	if (filter == NULL)
-		return -1;
+		return -ENOMEM;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
@@ -1252,8 +1256,12 @@ int evlist__append_tp_filter(struct evlist *evlist, const char *filter)
 	struct evsel *evsel;
 	int err = 0;
 
+	/*
+	 * As above, a NULL filter is asprintf__tp_filter_pids() having failed
+	 * to allocate in evlist__append_tp_filter_pids().
+	 */
 	if (filter == NULL)
-		return -1;
+		return -ENOMEM;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c663aafa88b2..6836156c2a7d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1872,7 +1872,7 @@ int evsel__set_filter(struct evsel *evsel, const char *filter)
 		return 0;
 	}
 
-	return -1;
+	return -ENOMEM;
 }
 
 static int evsel__append_filter(struct evsel *evsel, const char *fmt, const char *filter)
@@ -1888,7 +1888,7 @@ static int evsel__append_filter(struct evsel *evsel, const char *fmt, const char
 		return 0;
 	}
 
-	return -1;
+	return -ENOMEM;
 }
 
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter)
-- 
2.55.0.1082.g2b9226bbc0-goog


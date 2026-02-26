Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FC37104F
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069748; cv=none; b=lpGfWkClu1m38PzcLOo0EPmPi6D0cJ7rQ1B+huKy5bqhp+U/cjULw1R+4MWcIJYY3Q/QoQ8tn53O+AzvQ6ZGSvfLG3rzdF3QcgDUaUTU3HZB1wS99QEvI7eGXb6VrF1ZS94lpk9dMSe9g31VSXDH0TdQqJisdUzgGhWHhgNGhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069748; c=relaxed/simple;
	bh=3JJGfY5woUOx0TG+OwEWhTR6OLBQHwrZtwdkVNqVpyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LQqgDVdjIBxO1AZKeCKRShbuU4k/oxYlQsxej8B6lcGEKBHnNKYxijK04J6ETfzb047F91bkt8W0h3KSyjs4FEoNIrEuGuRs7EPKAdrH2u+5dIyuYz4QzcPgzKmYUyHYaR9s3uQVyVInlTYdHs29vIt3qZrihH8kSv34FL3F6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+cRS9Uc; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+cRS9Uc"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12721cd1a2aso7074980c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772069746; x=1772674546; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWZ6y6IFxHAgFeyLM3ooC5TMMGVf3kLN1hG+BiPigK4=;
        b=p+cRS9Uct+HVUHUfS6dZoFPqvrFIZBlKJVrvc4KPXVbSB+ttmJWW02cdn4ZdZszM2s
         Y/Zvu9LbxpEJ9AvUreUsgN3Y0/dNJVakRf/rJtlDtMjgPksPomxwLmSVJCCGxsF8IogZ
         rNYj3fCB0/XXVzPmHGApDSnGfuhAaT7c8Kj/Q9xbp46aLd46qHjaS76pTmIKU6cp9Cbi
         yQbdBHFcJhvi/oSf78lj4Aq2HKy34GaMBenQ4B6k2IBZJyVyoyZxlTV7PX077ZvNL+uN
         ruqQft91dixHivVrg7stSiXLh/SfJayK4baJda2HqC0f48T71cbuByYoHxPQ260vd+me
         Qhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069746; x=1772674546;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWZ6y6IFxHAgFeyLM3ooC5TMMGVf3kLN1hG+BiPigK4=;
        b=cJBWgZx/aU3Ptm+RcPGp7h0j8ybHi59AVyV2C2yzPBVsbMmrIsNfpYasLvDBmeS6U5
         BDpkLT1cm2PeJp6annmW+TpKMfY1+ocgOI4WIVr9bCfrHSZ9FKC8CrJZZJWGttrykLxG
         BBabPPvAPpszvtKEftZ+pkIGe7toLEmuN6tjNP0nRjZ2jbjbQABnn84j+/Ks+rp5sw7Z
         eANslHJCJh+zLKr7D9SW6Lr9AHn5PuPQoBPo6fjH0wuWd3kH53ZoGQE1NWvMnSmhWqEG
         Zv8GwTiUkq1SOX5QF0107qX8468FYYMgScpYX6dknw4dzAj9cnYQdoFZxhFUOYbBzeFH
         va9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXThKk6mA6o7BBuuj7cEeCSGk1xkYHrUG7ZCVC9aPSTWUV3rPGbNKX1aVGMFFbA5FyKhXYCoZXc7Ywy/DN0Gguq@vger.kernel.org
X-Gm-Message-State: AOJu0YysDOJJKdDwzX0eQumbjOsrq3mqrmgLyVgRWpJSi1kBY3npqCqK
	XHnsD6eC/p+YKynAiuzQmm+OtqdB7gDcQ9lPv+hRKC3mHU7OMaxWoia8UOCFz/Wa+1/ezGKUL+E
	I30HspdrZQw==
X-Received: from dll11.prod.google.com ([2002:a05:7022:20b:b0:127:160e:f9d8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:160c:b0:122:2f4:b24b
 with SMTP id a92af1059eb24-12789cb3c05mr281498c88.25.1772069745742; Wed, 25
 Feb 2026 17:35:45 -0800 (PST)
Date: Wed, 25 Feb 2026 17:35:32 -0800
In-Reply-To: <20260226013534.2028272-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226013534.2028272-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226013534.2028272-4-irogers@google.com>
Subject: [PATCH v1 3/5] perf session: Extra logging for failed to process events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Print log information in ordered event processing so that the cause of
finished round failing is clearer. Print the event name along with its
number when an event isn't processed. Add extra detail about where the
failure happened.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4b465abfa36c..7f3ffbe633af 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -131,10 +131,17 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 {
 	struct perf_session *session = container_of(oe, struct perf_session,
 						    ordered_events);
+	int ret =  perf_session__deliver_event(session, event->event,
+					      session->tool, event->file_offset,
+					      event->file_path);
 
-	return perf_session__deliver_event(session, event->event,
-					   session->tool, event->file_offset,
-					   event->file_path);
+	if (ret) {
+		pr_err("%#" PRIx64 " [%#x]: ordered event processing failed (%d) for event of type: %s (%d)\n",
+			event->file_offset, event->event->header.size, ret,
+			perf_event__name(event->event->header.type),
+			event->event->header.type);
+	}
+	return ret;
 }
 
 struct perf_session *__perf_session__new(struct perf_data *data,
@@ -2110,8 +2117,10 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	}
 
 	if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-		       head, event->header.size, event->header.type);
+		pr_err("%#" PRIx64 " [%#x]: piped event processing failed for event of type: %s (%d)\n",
+			head, event->header.size,
+			perf_event__name(event->header.type),
+			event->header.type);
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -2225,8 +2234,10 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		if (size < sizeof(struct perf_event_header) ||
 		    (skip = perf_session__process_event(session, event, decomp->file_pos,
 							decomp->file_path)) < 0) {
-			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-				decomp->file_pos + decomp->head, event->header.size, event->header.type);
+			pr_err("%#" PRIx64 " [%#x]: decompress event processing failed for event of type: %s (%d)\n",
+				decomp->file_pos + decomp->head, event->header.size,
+				perf_event__name(event->header.type),
+				event->header.type);
 			return -EINVAL;
 		}
 
@@ -2382,8 +2393,9 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, rd->file_pos, rd->path)) < 0) {
 		errno = -skip;
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%m]\n",
+		pr_err("%#" PRIx64 " [%#x]: processing failed for event of type: %s (%d) [%m]\n",
 		       rd->file_offset + rd->head, event->header.size,
+		       perf_event__name(event->header.type),
 		       event->header.type);
 		err = skip;
 		goto out;
-- 
2.53.0.414.gf7e9f6c205-goog


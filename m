Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBB48C41A
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713178; cv=none; b=DN9fy+mI959b0+wEIM6E2GrHWjNeqQw1af9QN74IUGFa9QCmRo+QH8quOihgNFJl3SFFBg1AIt8gidOVl7/KwyRL6OvW6N2Wvm/0ON5Q+cpQ17Okh9HDR824CIFPLq4/kvVHQ7RztbzlEUaKLk86TMbLmL0ez+4Y85/C0fEEBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713178; c=relaxed/simple;
	bh=QmcWkstS/VbcAPK9L4G/fLdvRUQbvBjPfNeBDPtpFz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZmqcwIls6/LDoG2FrouwRO6UqmtKOMaL8piKxa5eHMAlq/6ZCwrC/S5RhT+behpOd9rw/M2H/PrwojGoYmDgOJ/RBHbbUKX1aNkake3ohivsy9fGK2Vv9gIuWBng79KS7y2jesIDsXG/aTR24A4v1MhSidcp6oEJV2wbJcK3ibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Spz/pbu8; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Spz/pbu8"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so381152a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789713176; x=1790317976; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C7OaLonc0zyBcjmW5hXHqgzNGrY6TsdzALumXRwiAzU=;
        b=Spz/pbu8GT59okuMvd1xGBox/t1YxDxshpS4v8DzqgxILc8dPqYX1vB/FbvlxkaOdG
         3LimXWY2pQzZHolRZHpxuemojuq3ztY74napXw/NYWxL/ekKI4vgmRzN0ut4uAvq6MId
         7JkspH3LqlUKpTEhY4O2t3qIvEvc3W/ZpbI9dgm3wh/HAVDorT/8ZtxWvMy4YVTsQsPB
         LKfOXNXG00zi345NnKelmEvnb9YBJRX6L1i4yl6DXnQ/3VT+q/RLkZiUVRC3X+fYnbUE
         YducRHxvjtXTB71KrK8RkNcOAfkRN4tAEsN17kfK+gtgVu2k59lBy/3GGowmIzxobVmh
         cQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789713176; x=1790317976;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7OaLonc0zyBcjmW5hXHqgzNGrY6TsdzALumXRwiAzU=;
        b=l2xMlM7t9m3ZoH+s5zJ/ZQPsdJIevdlY2KV3VcPYss3XkSSfz/iD2jTyt4xlZpvlgK
         ECmCNcynESzzaip7B1AW8BA5jkm7cHWf9Tx11a+t6lj6OZdY7zUb3m5mqzu7iPCeTFvx
         yfkF1kwLZhPYt12CdabDYoDZAcUGCrw0cHO751UNUNk5mUx8Mp9ac3iDjE8lJNY2x6iL
         J6u+Fi+Z7peENBB77LnmSHiHQDnPzzr9f3Wjb6H/6hxd2duKJDpTqyInmag+CuiRhxRm
         JtBjWau3RVb6A1IqPo3VI61HotWZDqG3oN7+xxQ26TGaclVgKGiW7CVGUGkYEugSEwnY
         gEBA==
X-Forwarded-Encrypted: i=1; AKwUvBzQwjap4YnBHcNCuVpffSgvf9d64DCcZrVXjUWIGx6aSfEgmH1qD4gGWkCELUz/IiNFbuaV7YhvnaYOeQvDhTBM@vger.kernel.org
X-Gm-Message-State: AFuF++kFADolrlU97FvYLsfHxiiReyu7yEOn906pWCho0AMLww9YRroL
	DJcZySgfjkRbptn2mnWBy1pcCO57EvoWMZM2OMjYrWOvu151QCelJSOToKnDLeCkmTM0WqhZnUt
	oWafbz8Grqw==
X-Received: from dldyr17-n2.prod.google.com ([2002:a05:701b:4511:20b0:144:c590:e885])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8e:b0:39e:2065:5f60
 with SMTP id 98e67ed59e1d1-39e54f9d37bmr3632270a91.18.1789713176440; Thu, 17
 Sep 2026 23:32:56 -0700 (PDT)
Date: Thu, 17 Sep 2026 23:32:46 -0700
In-Reply-To: <20260918063249.2172589-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918063249.2172589-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918063249.2172589-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf trace-event: Reuse an already parsed tracepoint format
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

tp_format() read and parsed the format file on every call. Each parse
registers another tep_event with the global tep handle, and
libtraceevent has no way to free an individual event, only the whole
handle, so a repeated lookup of the same tracepoint both redoes the
work of reading and parsing the file and leaves a duplicate behind for
the rest of the session.

Ask the handle for the event first with tep_find_event_by_name() and
only fall back to reading the format file when it has not been parsed
yet. The handle holds formats for the running kernel alone, so a name
that is found is the same format that would have been read.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 10a7652f0305..826f75464171 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -81,14 +81,25 @@ void trace_event__cleanup(struct trace_event *t)
 static struct tep_event*
 tp_format(const char *sys, const char *name)
 {
-	char *tp_dir = get_events_file(sys);
 	struct tep_handle *pevent = tevent.pevent;
-	struct tep_event *event = NULL;
+	struct tep_event *event;
+	char *tp_dir;
 	char path[PATH_MAX];
 	size_t size;
 	char *data;
 	int err;
 
+	/*
+	 * Each parse adds an event to the tep handle that can only be freed
+	 * by freeing the whole handle, so re-reading a format file both
+	 * repeats the work and grows the handle with a duplicate. Reuse the
+	 * event if it was already parsed.
+	 */
+	event = tep_find_event_by_name(pevent, sys, name);
+	if (event)
+		return event;
+
+	tp_dir = get_events_file(sys);
 	if (!tp_dir) {
 		errno = ENOMEM;
 		return NULL;
@@ -103,6 +114,7 @@ tp_format(const char *sys, const char *name)
 		return NULL;
 	}
 
+	event = NULL;
 	err = tep_parse_format(pevent, &event, data, size, sys);
 
 	free(data);
-- 
2.55.0.1082.g2b9226bbc0-goog


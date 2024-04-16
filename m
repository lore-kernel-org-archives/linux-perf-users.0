Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB71598F7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248182; cv=none; b=LWY/LUCVlifxqCcU9XRU4X2qWjdUdclneQl6+yMCyOGPUA0NQIR7OxySP/nlLoz08tzGHwmNYm8wgO94XggnQ6XYAL2VS/2CgquEahN1ch71PXT8P9dtRSWxpZJ1DSnhLulZXT8KBeUrCqE2RMKTNzlN+2h/tmkAWw0POfgeSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248182; c=relaxed/simple;
	bh=KaJz8yoO4z8kzF8PImegTLz6lTpKAp/f4nY2Hi+9ZYE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QFs8E+kGetspQINA2c5uI0Hwx4FaDBshCufGsk7575tj4luwGnZj0XGHrKXGptgntFTcHJDEPnTUN7+LmB1zbliiVmIxpMFKQHsY4IofNRLPRBXhCVQlRPfWbz1I5JxAgKYGqVC37PZoI8edLdG+0jUGnTwDO8s5eQgsK5+CyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L86ujXW4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L86ujXW4"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd933a044baso5741164276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248179; x=1713852979; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VrQN7n3xmbjqa9xka2YhMJJYnp++PDb8jkPaxpbY/Q=;
        b=L86ujXW47MrrrUBU6wy2Ce0+FPpX97SC3vv1D0VGToXbMm+AeAUXPYi7gkmHty2En3
         p4QeiNHegkTPB7XpAKoKnsyuw0/NnLWBJ7AcrPTq5wu7UA9YfeR+R3BCz9vYTVEOII9c
         aUW/hB/SVsV3KFczD3ZjqROsazjPOCjAhwGWGYz3cjAXmHhY5VLSlnF2YOo120/DmxxG
         M6mQhdWGv75Sd928kCpZZ/G1gM+BWFgDiK3QOdbCYVBkWwWA9jz4qEH3TSpuGeNARNV9
         TEQ7pMVmFl3qd0ZjgKcN9+xoH5visKlTHC8WDnkGtDEBzT6wSXnJ6AZ81kTZXXFVVJ+t
         HOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248179; x=1713852979;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VrQN7n3xmbjqa9xka2YhMJJYnp++PDb8jkPaxpbY/Q=;
        b=JF7udBPZguHJyUD4lsaiGQI2DSxXxP8Biujh8vLYSPbAXudrthWzikqwz1wgaWWLbN
         4zWCrHJ2TNfAq9b/DJ7sNHuDX2e7ayH3hUq5GJE4qBp/ZlVWwplooPRBtmolabRGNISD
         PVKyKuHTmQEKqe/UKDR/EgdC1x9mcCOsU9HoNG4qPzOeZyWOEy0w7tIXiG5DCmV/zRPN
         AILN3HXlD3gxW0v/jvd10jJN+GvIRA5b4ybEv50lhoJtfbunwplaDK002kBcE47bUGXQ
         WC44QG0EXrCsDheMUC+lm/+TAcnWM4RBOHN5gHRN+o1WbDt9kXdYaqabk7ig5d42Uz56
         0pzw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ehn+LG0fojEvWOeuH3MldRElurlCNSTuUXt8FwZ9aap1tPgUVd3ZWsCkrMR4HzSkNegHRBp0IT7Ct+Ec7gl0FG3SH+1OuDRLafh/pDp9Wg==
X-Gm-Message-State: AOJu0Yyp9Xdn8cE/WmDAn3kIGDwVzMAGOnxb79Mohqbm2V1BZqBK6FJY
	rSuZZsSTbv/lH0dj6s3YHyHi+Ip19KOLEy05u4MAbLmhFTIhTulIW1d9IeSaz+WaEjss9AL80A0
	SHnHvPQ==
X-Google-Smtp-Source: AGHT+IERSGPTpkVgBfw9PFFOt/D0ky1G3+P1qSBu4bKGGyUriqoLEpK5IFzVUX9JSbM2dKNl22D4bBUM9mgq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a25:2054:0:b0:dc6:b7c2:176e with SMTP id
 g81-20020a252054000000b00dc6b7c2176emr369458ybg.4.1713248179377; Mon, 15 Apr
 2024 23:16:19 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:31 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 15/16] perf parse-events: Minor grouping tidy up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Add comments. Ensure leader->group_name is freed before overwriting
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 1 +
 tools/perf/util/parse-events.y | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8d3d692d219d..1c1b1bcb78e8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1711,6 +1711,7 @@ void parse_events__set_leader(char *name, struct list_head *list)
 
 	leader = list_first_entry(list, struct evsel, core.node);
 	__perf_evlist__set_leader(list, &leader->core);
+	zfree(&leader->group_name);
 	leader->group_name = name;
 }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 79f254189be6..6f1042272dda 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -193,7 +193,10 @@ PE_NAME '{' events '}'
 {
 	struct list_head *list = $3;
 
-	/* Takes ownership of $1. */
+	/*
+	 * Set the first entry of list to be the leader. Set the group name on
+	 * the leader to $1 taking ownership.
+	 */
 	parse_events__set_leader($1, list);
 	$$ = list;
 }
@@ -202,6 +205,7 @@ PE_NAME '{' events '}'
 {
 	struct list_head *list = $2;
 
+	/* Set the first entry of list to be the leader clearing the group name. */
 	parse_events__set_leader(NULL, list);
 	$$ = list;
 }
-- 
2.44.0.683.g7961c838ac-goog


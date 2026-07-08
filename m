Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683142BEC2E
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554424; cv=none; b=Z/6IhDqwPG5ztn0IzW4NbmYmDbALKQZ3cGbfEwOePZPnSxILtPmkyTDOfdv3Y3ztjvVsZE82zrPV8y1Vu5T7xSzSo/rLstcVnoC1AfqPoxLx7sEuse0TG2eCRx64Y5K3aNtzmOTMaPhBzfsQaKAgsxBA7tKmYW0S3zqkthe8OR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554424; c=relaxed/simple;
	bh=zqhII9pIIg1up9u2s0T3nyYMp8Nuwcx+oic1cmCY3Og=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kk3uXnQBvCuRWb/FyYe7Dt7cbD4EvP/80r8bBm+zGUxKBDGZ9YYGDDAXCgrVXSd+V8N5G5D2lodwYSyDClYtzsUWRnGSksPThlZtvBznTvmP7CaF7N72uSafZDZSfrB5ZFFVaeNifGy7SoAwk6r9s5mbEWnrPG44d1lBRsuLDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJC4PWgC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJC4PWgC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so339898a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 16:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554423; x=1784159223; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IW2Krk1JBTo+ci2ZZx0kx/gVLoo7HWWPBLR16dqq0Y0=;
        b=XJC4PWgCQYnVVmzfHMb+XckrjiAA4SKs3bISP3GUi7nX8GHDVjTY+5bREbqJ1w9Aab
         WOsvhB6JfhnQum2RRU15h22sXabetAPEsAb8CJg49z7tSproRiz9PzcLp3ohEZ/L9DZS
         bszBNmfP8ULb6aFtBsGYFY6mHu/VppO8G1mAgAY3tCIxmBcgQ74xrG1QU8fA2KX8g8Am
         9vP52Txur+ux4SEspOgshOnmZn6oOBrFWwbhOdBX9yDaZ58JX7QVy5ZtWr3YGWFloc06
         +4B/kIf6qJsYnXzsTlIxD+Ufc9iw+Geyc/LA6XM8jgmwLq0pWGsXZZteOGoIZb2hOvVJ
         yCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554423; x=1784159223;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IW2Krk1JBTo+ci2ZZx0kx/gVLoo7HWWPBLR16dqq0Y0=;
        b=nFxb2kGXwaCein5OaRCdzdPwPvzB3WoNB3lYcp7gSuqC1Ub00pIxWC8ebn8SPLBCpJ
         p7tfur4kGT6mbvA2itemM7WneQIIHuBnLjhe3mHtA59mYAvvooPsd7ObcrYs9vCmvdH2
         utJh62VvjkXbV1o15l9FgAjw/DPKwADb4YCvwlPMqfJJleb6ZAHEeW39JOaiBtcrgLxA
         HkE0GxiqlCAKaI8yb/QlbZOAnzooqVMS/UTmViVLJyTqtRf+ubVGkFjIu+e203jJ3ZLt
         m6robC9hmuTFSit+owAApKUsXvN7jwjacB0+Xy4Pw00ZhKtBSUjRM/ytv6QK3MeoTlQx
         6RCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNXObzQxXsOBpUAw+3WsDtRbIA92O80qfvvjtaN3+EQ0nXz0O1VzHmSw/JQxwLJG6peIyArxFysZDEssuZ9KjH@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfOReUNMUq6c4SFSH5HXcTSy6rhNOzzNULrEvIqnTTyhf+5hf
	C7sYo7/8zYlAh7cKwy6NcaoTn8cir88r94G0KXLhw7jwdqbZRtoUo+5jwsDzRk4xuaoBswuWt77
	uUc5b4OoxHQ==
X-Received: from dybb17.prod.google.com ([2002:a05:693c:6091:b0:30c:1aab:2586])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cf:b0:3b4:b216:2b26
 with SMTP id adf61e73a8af0-3c0bcbe7824mr5802033637.5.1783554422610; Wed, 08
 Jul 2026 16:47:02 -0700 (PDT)
Date: Wed,  8 Jul 2026 16:46:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234646.1040003-1-irogers@google.com>
Subject: [PATCH v1 1/3] perf ui hists: In report UI ensure thread is set
From: Ian Rogers <irogers@google.com>
To: Josh Stone <jistone@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Tianyou Li <tianyou.li@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Zecheng Li <zecheng@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A map_symbol contains a thread that provides access to the wider perf
session. Recent changes used the thread to get the e_machine to better
support cross-platform disassembly. Unfortunately the UI code wasn't
populating the thread and so the e_machine lookup failed early
breaking the 'a' for annotate TUI action. Populate the map_symbol
thread to fix this.

Reported-by: Josh Stone <jistone@redhat.com>
Fixes: 0e26ba5a8774 ("perf disasm: Refactor arch__find and initialization of arch structs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index da7cc195b9f4..f8ffd9b73582 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3155,10 +3155,12 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 						continue;
 
 					actions->ms.sym = symbol__new_unresolved(bi->to.al_addr, bi->to.ms.map);
+					actions->ms.thread = bi->to.ms.thread;
 					actions->ms.map = bi->to.ms.map;
 				} else {
 					actions->ms.sym = symbol__new_unresolved(browser->he_selection->ip,
 										 browser->selection->map);
+					actions->ms.thread = browser->selection->thread;
 					actions->ms.map = browser->selection->map;
 				}
 
@@ -3173,6 +3175,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					continue;
 				}
 
+				actions->ms.thread = browser->selection->thread;
 				actions->ms.map = browser->selection->map;
 				actions->ms.sym = browser->selection->sym;
 			}
-- 
2.55.0.795.g602f6c329a-goog


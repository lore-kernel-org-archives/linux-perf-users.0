Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A691391512
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568253; cv=none; b=HkWKxZDhaVJ0Dx/Q5NOi2BYKMZRBqqKN3DQZ0zGHQ4cz6fy9uYBU5B7dRJorqhClied1vtzIhYe3bZKZuRwTkTUyRLoIP3xmZlIO/ELn4fGM8F+2YaSH7PiKBBsB/Zhf8Oaf46KflkZmGZ2a3MyHRD1nF7XcyvTVs5jNL4e+Jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568253; c=relaxed/simple;
	bh=zqhII9pIIg1up9u2s0T3nyYMp8Nuwcx+oic1cmCY3Og=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZnUQMyt/uWnlGrVSqm9qrd1eMhhhcDa7lWclyiRIVcZkM4x6Tfgwc4ME8g7tNJG/BcbjuvlqoTW8w1LQnzCKkbHMofkjBwdk/gJEsTA8aYiLYZca8+cqf0D7ykBzB5GKKgwg/Ui/B59Rup/zMb3q7iOQ1KykdIkDzvghSpDHSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWgYof0p; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWgYof0p"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ca3b314193so11191035ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 20:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783568251; x=1784173051; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IW2Krk1JBTo+ci2ZZx0kx/gVLoo7HWWPBLR16dqq0Y0=;
        b=JWgYof0pZ+l+GZobxlTG1Kmm4cxajo3AosjuInuc7cFfYJ56wDFYiZ746+BHnyewG+
         kMj1Af2KNS37ysGAu2b7qht3P9i39FrjWMnocowI2ELh6va7J9znGP4qY5QTUQq0OMTo
         PNHAHSqqhmhR+LCZ8EMK8J4FSrnF0zyjqBNIGQdbw3207OapserukSvRBrsIXKhCuv2K
         1Y+RAo9osYfV01d4bGqbdAI846KBThfOD5v6kJC88g/7ykwmsBpUvmN0CmpEKYhwKTEQ
         dhJa8ECKqmvkbOqIftsNwcZtqYHHCCGJY1JUPtd5X1rbtAkKrzMM3PGyUHcYdCugweOj
         8kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783568251; x=1784173051;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IW2Krk1JBTo+ci2ZZx0kx/gVLoo7HWWPBLR16dqq0Y0=;
        b=YErZDN8znopcyAWm4jDBNRXtucuYEGRta68ivy/Z2kCxgvvjyd/+vWNGAsQJD5856X
         APhdy6pvdSzK9fkzXQT4SxefKOdnTJrbuyEGSX9ZHNbpKo3/5jpH2XuuO6jK0r2J10np
         4Cx2Y3V4MYcMQ7ME3PMQ5Ot+2IZiKXELH7S29ShJAny4Ow2Vv2AmscL1JK/T3RCIZH65
         KUDRyBNyL2Xyq+hwsMLE6voIJw1O9X68D8VlGoZ0dDMW1f5/NiHIqDClBZgsbiiKfVxe
         y/6qhnLXcVvds/N0wGQVwej3N/c4vyeeX0CnaYHa9QptLdiImPeH7yKTRf3mLL3iItTW
         UFZw==
X-Forwarded-Encrypted: i=1; AHgh+RreT9s3Byh3RDiSJdHXYGm0YKgawUxAO/eRAqCb6whMB81p7OIG/jtY9EE5fy4sIdhYofJEMqzuMNL+mb9Elksg@vger.kernel.org
X-Gm-Message-State: AOJu0YzENXBhORxtVYH2WKT5sxf3MuScadZ3W/oBm7TUoUDP0xvG3xhx
	P3wh92AhMCeNt6clIebD92Lu0ltYsMiG0cotsePiZWnN0AYzJy66qyYio96WMwNsRrCE3vIdQUa
	fjxlsi3wjbQ==
X-Received: from dleb8-n2.prod.google.com ([2002:a05:701b:4248:20b0:13b:2930:18fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4e02:b0:3bf:d1f9:b1db
 with SMTP id adf61e73a8af0-3c0bd158f8fmr6517730637.52.1783568251072; Wed, 08
 Jul 2026 20:37:31 -0700 (PDT)
Date: Wed,  8 Jul 2026 20:36:58 -0700
In-Reply-To: <20260708234646.1040003-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708234646.1040003-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709033701.1117943-1-irogers@google.com>
Subject: [PATCH v2 1/4] perf ui hists: In report UI ensure thread is set
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
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


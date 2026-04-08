Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB040DFB6
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607424; cv=none; b=oJCc+r2HpN6qMA+48N7DjDb9oQasmJ0DIPY8I0S5IVNaxK+J83bs4L3gArSi7aksLWEGv/+4DKakUQqqFYoh4pliPYaSBtaJobk8tUOrIYxIK2g8Pn8NFSmCLzd8BrbD9YdJUAfkxHgNYr3jq3JIyrkg6ydd5o4aifO0xy8BEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607424; c=relaxed/simple;
	bh=+od/pv8U9SPnqABn8T5vvA6IegNaRSsOs9j1AAwCO+Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=YTHDZf3C+aj09L5yE9+ZBxhGf1ZJMdWXoM4t0v2eFTuuWy8B1SFCfofe/jdzGMDTWEZVYvDqPsI/WitUHzkIYz770vz21VRvsUT3s6BMYoNqTH0dSObq1E1hMbTCRHk6jRb8Bah8LQaRzh05RAJFa+SrQcvR1cj6NXyloore7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPGMskNt; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPGMskNt"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c20a91932so3043060c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 17:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607421; x=1776212221; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dDo6txpKcG/dWZi4YklRd+yQl0suoQaKKPebb6oTLYY=;
        b=SPGMskNtJjYpg+q5wn3XSxvwFwUInBJLypPVaTC3j2GuonoIW6knKS3vqL5DnWXOiY
         bT3X9Cv9WAxpKmBOssYCCvCnFF9U0RAF1npzV7gHTXrDK9iHhSHI5tnkBlee7KxeAW6S
         SILNWkJV9ntSUdkWauT1OnuB+f7AQ0LSs5yaB9SL+tS9YlP9+SpS9SrE+0LqDQTet+6l
         sTCKrPVXr7fpqFL8UcgYdGpwM8GZWV09FntseXen6yX05lJp/y4WsfVjl9h/twOGnK6H
         fuoetFTs/Vqh6sjQalWDV3bHClIl3hRpxo4/ybYn8S8Bt8UG9cOEhfQapP84MWoVzwkY
         hbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607421; x=1776212221;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDo6txpKcG/dWZi4YklRd+yQl0suoQaKKPebb6oTLYY=;
        b=ZBYQEU1s7ZAa5CaMeA1FHPyci3GZLhkzAeiRHi+a2xsqhOL4JeG3EqvTivN4QRX6Ds
         P6A/v70TAbSE/rN5nBbqWWirnsOGFcsgvtXcVIrEfPB2+Kfb73X9JuxSwmCgXdlFzwQs
         xiPZFwZDZs/M/xYmUQ9KSfCZqzUIGLp9ZANVwGA6F3tb7OLrbrTe63uuCHfYMXPeMtB3
         c3ABZMV3xvaly34aVNbVtykIgembhNQUriJrP9QEfifA2D2eolLhbPPwtsD5Iv3ZjoAu
         uhYiumNkZba4cG+9MXtPdNXba+Wpr9+2VXFOGf0RzpfmwQjJXm6WIdogpL7bclW7Kj3w
         AtfA==
X-Forwarded-Encrypted: i=1; AJvYcCUeEQCWCzQdvpeXQpx4AliMYLAXos41HQVexkSMZf/ziJbUmM9nzbknMhViIi20XyBmx1ozi/nYUQr55Yop31S7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ATzDP3Efzzk38dqDbAiDKIUPFqdnATeIl6gPR9UIzSB4kHvY
	qWMKvhZL0aMkRBfESP7AL6VfxiwTj9tqJm4J8TnB8ySoxy+ZLz47RCnKGvtbmv5/QgWFjrfix1e
	D4rFrAl1e2Q==
X-Received: from dycc15.prod.google.com ([2002:a05:693c:60cf:b0:2c6:415a:9023])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a10b:b0:2d1:d434:d005
 with SMTP id 5a478bee46e88-2d1d434d88dmr2700023eec.20.1775607421346; Tue, 07
 Apr 2026 17:17:01 -0700 (PDT)
Date: Tue,  7 Apr 2026 17:15:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408001521.102140-1-irogers@google.com>
Subject: [PATCH v2 1/2] perf maps: Move getting debug_file to verbose path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Getting debug_file can trigger warnings if not set. Avoid getting
these warnings by pushing the use under the controlling if.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 4092211cff62..7dd6da9d1e4f 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -844,7 +844,6 @@ static int __maps__insert_sorted(struct maps *maps, unsigned int first_after_ind
 static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 {
 	int err = 0;
-	FILE *fp = debug_file();
 	unsigned int i, ni = INT_MAX; // Some gcc complain, but depends on maps_by_name...
 
 	if (!maps__maps_by_address_sorted(maps))
@@ -872,8 +871,8 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 				dso__name(map__dso(new)));
 		} else if (verbose >= 2) {
 			pr_debug("overlapping maps:\n");
-			map__fprintf(new, fp);
-			map__fprintf(pos, fp);
+			map__fprintf(new, debug_file());
+			map__fprintf(pos, debug_file());
 		}
 
 		if (maps_by_name)
@@ -894,7 +893,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			map__set_end(before, map__start(new));
 
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(before, fp);
+				map__fprintf(before, debug_file());
 		}
 		if (map__end(new) < map__end(pos)) {
 			/* The new map isn't as long as the existing map. */
@@ -912,7 +911,7 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			       map__map_ip(after, map__end(new)));
 
 			if (verbose >= 2 && !use_browser)
-				map__fprintf(after, fp);
+				map__fprintf(after, debug_file());
 		}
 		/*
 		 * If adding one entry, for `before` or `after`, we can replace
-- 
2.53.0.1213.gd9a14994de-goog


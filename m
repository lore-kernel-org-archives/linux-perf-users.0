Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A4309EEB
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604102; cv=none; b=p2O7bUpJj7+EUeihbaGSV5BZaE2ISBdCbjTv7TSqJgXmOid7LMwDS6zQq/jOhij27ck0+W/1cNlonREvGoLRe/1R2xDODdyG8IVSxnZqp875GWZ5NDR40yWJLfv/2ap8TTIFtTPV9mJMCYn6Vv7DDJvCS6XzrZNHtkW6VKkOPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604102; c=relaxed/simple;
	bh=+od/pv8U9SPnqABn8T5vvA6IegNaRSsOs9j1AAwCO+Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LikSw7uj/pyEXqHU//foKQM4oxTVgKJ9DMlA7D/uhST6IXslqczEm74052BHWo3WToNfOIMbDt25nsjOI051n0JHXRujqPPlXnAf63OPLWJrjdcJhxwWz4Gn2ieQCMzmEwmal9DiVYoGC6ki8wctD5e0eceLdDVw8NZe02rz0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlRLw5Lp; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlRLw5Lp"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2cc9118dc2eso16571855eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775604100; x=1776208900; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dDo6txpKcG/dWZi4YklRd+yQl0suoQaKKPebb6oTLYY=;
        b=SlRLw5LpAPDuv/gpIm7tkgM5UnGUiFhrFcLWTFxC/PQPstdW4e1va81BRMZAesgDQO
         yBnicR/AZdClcHzvDTaUCIFDToXF4QefWCQR/ODBS3HYxSS48xEoDVvzsvqNexLF42ln
         tjCAwCYRyZcKALdAUy32W1g99o39DGSxgLhWMCiCm6yXoT9+B8xzETraw2XlTllLNlJv
         gHVm5Kc6myt1VNJE76w1p0k9k0hDr9SvzdoLBY4U1crVQQ1raB+OH60LTC8q+O2l1i5y
         byzQQi+4IrNGODWgnwEtNis2717LgHeY6Zu1pvsZXJRIKbRYAssNo8d0HXKYIIu0iu7J
         e15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604100; x=1776208900;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDo6txpKcG/dWZi4YklRd+yQl0suoQaKKPebb6oTLYY=;
        b=Po+l0w1fKuioJumuXaKmkGXcvfVxY6Ucm5DPgqghbj7yLSBPAD5/qw3Zcqh0dIIToS
         8LZ5fF58OWjdKZgaiq4MRXdUQsX3A45lTGTjtN58fyJlGYRDvG/nCZM7CCroM2urpOCP
         2pRp07Wgopuguoe+dyX0Wdd28PrcckJb44lv46oasSHZPm2r44iPw3EQAcQy10AJIuMJ
         uAozLJmSfZqVQEAIlafw1L51mjB4W3/Ny5qsnTrVdlplWCwEs41KaE218xbJBG/vvFNR
         wjvtAVNXmzgm+d1bRbki2gtmEfcMqv6xa3CrRClC93UaCSaBC/eFvK49yiXO54Q9bln1
         tIwA==
X-Forwarded-Encrypted: i=1; AJvYcCWG/4BMfCemy9WI/g1O8nm4Em9N1YfKpC5E2jVBkFRFDcXCIflDHKaAcKpnyvIh+u83xOKh+uIOn/lkRlstjC5L@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4x8x3Jv44ms8ekQQXGjdc2AwahnfKTtyra3hUSi6FYGRHrda
	6gS9EgdTXtn99PYaHoNu1jtyTqT0HT+q3iRnCRSZthbGxaojPLamRKIEVnldCeJOcJ2bBn06Onh
	f4d447h1mCA==
X-Received: from dyb28.prod.google.com ([2002:a05:693c:631c:b0:2d2:f6b4:9b78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc88:b0:2c5:3b87:2fec
 with SMTP id 5a478bee46e88-2cbfca5c3c3mr9417163eec.31.1775604100091; Tue, 07
 Apr 2026 16:21:40 -0700 (PDT)
Date: Tue,  7 Apr 2026 16:21:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407232135.4120645-1-irogers@google.com>
Subject: [PATCH v1] perf maps: Move getting debug_file to verbose path
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


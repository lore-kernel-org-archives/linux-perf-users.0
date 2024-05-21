Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2E1482ED
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310285; cv=none; b=rbLk+Zmb4NCoevh7j3xZLGvWaZs4i/SaK3mMqE43NWOB7EiSsJMZ1fKAs1Tta94WuxJK4moSX9DL/mPQrQDik/BjxUTMzbxpS+jyg2/H4cWq2Hb/wq9Bs97dfbuF/SIQQuT4uAK8FDs/OVzp8rOt+gZ9PNSeItLvccGwPa70YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310285; c=relaxed/simple;
	bh=tPSaX4kgNdawUQHbzIdUZTi3pOEIe8Q/D+semVgAOx0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AdcBXJWNA1pdiLFzAinDICRtEwfM7EYjNNDM8jnOkhIeGSnI4ago/b83tZirGX65TGnPTPzpViPP0PjIrfg+9tju60OA6vWtbAMy5z8tuxFB1fso9MOtm8cP4E3dm69ZX8uO6XoW1fEcjC96+ZuwGrsLE85doOZuBo4DvYPxZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oH5M9QeO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oH5M9QeO"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4da3446beso395892276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716310282; x=1716915082; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GALuswTvDeGvafJWqEPTd/XeiOrV3kZLnFJgLvJhAUk=;
        b=oH5M9QeOWNJ5FA32CxInPMESnNIyVjCjh/aLTTsj6CqTrWrYTUuFj9iy8yHmUkJJ8E
         B9MeDbzvriMI11GPyS0TKouTQtBOWYKFRumAh96PoxEFUhISwzlKuKSWbdY3iXnboT+3
         5rtZTI8Lsna1Y3UdX24N/V1aRzlO07p/sDupKgTBMBmaQ9dT+QirLKdzK5+4a4MbpLsv
         vgpXEldtscNcLE07NcfdDtJkEXVXLRtLVOeQu/QP2tMJQgL3xHNnIMdwn5lwa/2TsD3K
         7tvtliCDI6aNBhWWwvMBeWGDjWLrRdO5JO4g7mFZe6K65TabhPBv4Av4z8+3W7isIGLJ
         zI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310282; x=1716915082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GALuswTvDeGvafJWqEPTd/XeiOrV3kZLnFJgLvJhAUk=;
        b=SXmvNn/HH8XBjVneNyKzezlvQVBCH6MP8P0B5nBbeUf4is7yVPZ+RPpMjYXHZrWoCU
         AV4hpfA9wCTrlLgFb8DDZL4rrx/VWtoj7SYM/uNiKXW8zmKqvhEdx/Rjnf1eqBOcsFqq
         YDFmIxLfpavMGH40OPkWG3xa3SiwNQhohXwae7wY9KuYJe5rUw31lekPb+ZAnq6cuGjS
         RXBtVWNMfGerZ78CrpxNEsXQWBq5fn7fXJTlo1x7I1L+XB6ffaJjpbx7iiiI2ovj0AoZ
         PYYR2fVszr6/emdjLP9MBen/VPDvuvR/MPmkJ3ZelJySrXPH2yUk59AtZ2nLH/2ppkSl
         Qjig==
X-Forwarded-Encrypted: i=1; AJvYcCU/Gv7L624UeGyfDjNZg//foP6g/Mo9klJahAW0PpoIIqpNep5aO+D9Ws5KLKjyXoylffeBGsfrmkaMRae/tlg2+cal9KZflDp7VDMS9Q+WSQ==
X-Gm-Message-State: AOJu0YzbMus77eoLpNx6tXqJFW5R2H8XvqaOcI32gK8H6dOvvyDS7Y8V
	qxJEUFH5CU0ExtW09v+kdpWXiekJqHt5wN1nSZV32DyAtu5gsoUfUE+Cwa9Is6VKkX+l2ilNUk6
	k/yyK9g==
X-Google-Smtp-Source: AGHT+IHyxz1G47wF2s3bV2sJZ7BCwtJ5wIApcqKBerxN0xjf64+D1FZUO9DZ+jkVlmIRif26c1JY6TzDlsqS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:6902:c10:b0:de6:1301:600a with SMTP id
 3f1490d57ef6-dee4f374414mr8390517276.9.1716310282509; Tue, 21 May 2024
 09:51:22 -0700 (PDT)
Date: Tue, 21 May 2024 09:51:08 -0700
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
Message-Id: <20240521165109.708593-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521165109.708593-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/3] perf maps: Reduce sorting for overlapping mappings
From: Ian Rogers <irogers@google.com>
To: "Steinar H . Gunderson" <sesse@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When an 'after' map is generated the 'new' map must be before it so
terminate iterating and don't resort. If the entry 'pos' is entirely
overlapped by the 'new' mapping then don't remove and insert the
mapping, just replace - again to remove sorting.

For a perf report on a perf.data file containing overlapping mappings
the time numbers are:

Before:
real    0m9.856s
user    0m9.637s
sys     0m0.204s

After:
real    0m5.894s
user    0m5.650s
sys     0m0.231s

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 55 +++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index eaada3e0f5b4..f6b6df82f4cf 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -744,7 +744,6 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 	int err = 0;
 	FILE *fp = debug_file();
 
-sort_again:
 	if (!maps__maps_by_address_sorted(maps))
 		__maps__sort_by_address(maps);
 
@@ -820,36 +819,54 @@ static int __maps__fixup_overlap_and_insert(struct maps *maps, struct map *new)
 			/* Maps are still ordered, go to next one. */
 			i++;
 			if (after) {
-				err = __maps__insert(maps, after);
-				map__put(after);
-				if (err)
-					goto out_err;
-				if (!maps__maps_by_address_sorted(maps)) {
-					/*
-					 * Sorting broken so invariants don't
-					 * hold, sort and go again.
-					 */
-					goto sort_again;
-				}
 				/*
-				 * Maps are still ordered, skip after and go to
-				 * next one (terminate loop).
+				 * 'before' and 'after' mean 'new' split the
+				 * 'pos' mapping and therefore there are no
+				 * later mappings.
 				 */
-				i++;
+				err = __maps__insert(maps, new);
+				if (!err)
+					err = __maps__insert(maps, after);
+				map__put(after);
+				check_invariants(maps);
+				return err;
 			}
+			check_invariants(maps);
 		} else if (after) {
+			/*
+			 * 'after' means 'new' split 'pos' and there are no
+			 * later mappings.
+			 */
 			map__put(maps_by_address[i]);
-			maps_by_address[i] = after;
-			/* Maps are ordered, go to next one. */
-			i++;
+			maps_by_address[i] = map__get(new);
+			err = __maps__insert(maps, after);
+			map__put(after);
+			check_invariants(maps);
+			return err;
 		} else {
+			struct map *next = NULL;
+
+			if (i + 1 < maps__nr_maps(maps))
+				next = maps_by_address[i + 1];
+
+			if (!next  || map__start(next) >= map__end(new)) {
+				/*
+				 * Replace existing mapping and end knowing
+				 * there aren't later overlapping or any
+				 * mappings.
+				 */
+				map__put(maps_by_address[i]);
+				maps_by_address[i] = map__get(new);
+				check_invariants(maps);
+				return err;
+			}
 			__maps__remove(maps, pos);
+			check_invariants(maps);
 			/*
 			 * Maps are ordered but no need to increase `i` as the
 			 * later maps were moved down.
 			 */
 		}
-		check_invariants(maps);
 	}
 	/* Add the map. */
 	err = __maps__insert(maps, new);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


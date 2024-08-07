Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D51B1428
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013509; cv=none; b=eEYJH+ADNxkdJE/brEH6Ef8mktFJeCSmBp1/v9ixLnuDG1C3G+yIplZdEbCTjPG429R6kqcdv+Q9nkAU+yPeB/qEMFRX6JWF1gVXfbYIvi7YJynPS9OR07ptqh2uvU5yLRJeiIZCBSAQVwiN4t6s/KjcRlVVcBcqYNua6u3FNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013509; c=relaxed/simple;
	bh=gTOAqZp5+RCZOOzD26/kBMue4AHQwpYyelIeBnhzOtM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=g8xulq6/D/Rh7DLi4ZXm9MKfUFwcyDnbhMlcke0wykUQKcnIhaXMffVn4mf4djKw4b/jwcSKavj7qEQP1m0bIDGbhJJ4iFjhZe4HcY4bCfqOyrvL6hLndZWGvYv/MAwv05x7er9qx0Uw3di1ezGuu7Linl9Yf7lYZbXjPa7K/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oE1DXGnZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oE1DXGnZ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66b3b4415c7so36519727b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723013506; x=1723618306; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HjmYdkWfQIowxx0w0AYxN2hHrndKDApWqMTg9jBZXEY=;
        b=oE1DXGnZxK87u7P/L/2xZfXHlfYwceodN+Fo7rMD6V+I191dLAAoR453dHhriV1vLf
         DeOaOQFc7GwDbqib3j83QWAzro2Vl/tzSaILB/GFnvaD5iZkRuu8Ujg/m2luhrYe9F1W
         vjIyOdfWbclni4QtNzaJNuQhTdokV3yx133d4tj0ZMUL33kogKKzCfVMlpU/uEX10jp/
         y2OtFod3Vup1G4CsjanKMnFBurvVsxlpIw3BrnE8Ewvjj+BhkS95mSIFyKRdZANepnlF
         cPpoOXCnk1tkudBtQh9pVvQBAGjp3o2QHGNnazxEXArIHaSot75hsNmDY8Tg+4FvA9OS
         lhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013506; x=1723618306;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjmYdkWfQIowxx0w0AYxN2hHrndKDApWqMTg9jBZXEY=;
        b=qx/O15JHQK7bufwB+oV+N2ZTP45yYb/vBcHnB1FBk/u9rpT3NN4CTHHYbA7wCRxJtR
         VO6WXp9cfJXrdph575/BxXLthWVGvfO3EKfE5gorkHSpVwGDWo1VYsfX5Kn5BhinP+VA
         Zjvjb5nc7N3ZRCkdfMm7+XeKpO91rNnIy3IcAa/skudS8f8Tv13lU01jiO5kV9pKdnA0
         9Eq/n2E2iwu3ZlMoH0ORw/HOES9FLk/bRayWiB+tPzzSjgpBrBRymOEDUcI38KNnnbEz
         +TcL6pRbFCK08yVOOz4FUf8zp1RjDrLZdK5ZYKArwuimFCnbV57ChkDem0xZXZpjLQxa
         jKxw==
X-Forwarded-Encrypted: i=1; AJvYcCWHDFxXx7pXWED1oGw6/gXZlCqsznbzS91Y1cVM+eeZoNWoJsSnBArM9qw39sVHbxL+BadeRhC6apbVVowt6/n7x0kM8ihWcjTIROWy9kntXg==
X-Gm-Message-State: AOJu0Yzz1uc0I0UQMImUmGFMEHrwwnWakBYXxVhi34Tu6C0U3EqEbW9J
	vGvJpcHUL0Unq2mKgI3lB2VnjdLEcVudvmQFU3EIjLOJj4mkKDycTYGfitmD3Ys/Jf3PmLGeGP4
	spR/dSw==
X-Google-Smtp-Source: AGHT+IGcn1HOgBgSZkUpCZbcE/TbyQezcf+ZGodx1D+51ukk7eDDKya8x6COgzWgq9jmcueW2BMp1k3u6BVd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dd5:8e3d:1f0:1ddc])
 (user=irogers job=sendgmr) by 2002:a05:690c:39a:b0:65c:1db1:9235 with SMTP id
 00721157ae682-6895a1e4babmr5641287b3.0.1723013506514; Tue, 06 Aug 2024
 23:51:46 -0700 (PDT)
Date: Tue,  6 Aug 2024 23:51:36 -0700
Message-Id: <20240807065136.1039977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1] perf hist: Fix reference counting of branch_info
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

iter_finish_branch_entry doesn't put the branch_info from/to map
elements creating memory leaks. This can be seen with:

```
$ perf record -e cycles -b perf test -w noploop
$ perf report -D
...
Direct leak of 984344 byte(s) in 123043 object(s) allocated from:
    #0 0x7fb2654f3bd7 in malloc libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x564d3400d10b in map__get util/map.h:186
    #2 0x564d3400d10b in ip__resolve_ams util/machine.c:1981
    #3 0x564d34014d81 in sample__resolve_bstack util/machine.c:2151
    #4 0x564d34094790 in iter_prepare_branch_entry util/hist.c:898
    #5 0x564d34098fa4 in hist_entry_iter__add util/hist.c:1238
    #6 0x564d33d1f0c7 in process_sample_event tools/perf/builtin-report.c:334
    #7 0x564d34031eb7 in perf_session__deliver_event util/session.c:1655
    #8 0x564d3403ba52 in do_flush util/ordered-events.c:245
    #9 0x564d3403ba52 in __ordered_events__flush util/ordered-events.c:324
    #10 0x564d3402d32e in perf_session__process_user_event util/session.c:1708
    #11 0x564d34032480 in perf_session__process_event util/session.c:1877
    #12 0x564d340336ad in reader__read_event util/session.c:2399
    #13 0x564d34033fdc in reader__process_events util/session.c:2448
    #14 0x564d34033fdc in __perf_session__process_events util/session.c:2495
    #15 0x564d34033fdc in perf_session__process_events util/session.c:2661
    #16 0x564d33d27113 in __cmd_report tools/perf/builtin-report.c:1065
    #17 0x564d33d27113 in cmd_report tools/perf/builtin-report.c:1805
    #18 0x564d33e0ccb7 in run_builtin tools/perf/perf.c:350
    #19 0x564d33e0d45e in handle_internal_command tools/perf/perf.c:403
    #20 0x564d33cdd827 in run_argv tools/perf/perf.c:447
    #21 0x564d33cdd827 in main tools/perf/perf.c:561
...
```

Clearing up the map_symbols properly creates maps reference count
issues so resolve those. Resolving this issue doesn't improve peak
heap consumption for the test above.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index f8ee1cd6929d..c8c1b511f8a7 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -472,7 +472,9 @@ static int hist_entry__init(struct hist_entry *he,
 		memcpy(he->branch_info, template->branch_info,
 		       sizeof(*he->branch_info));
 
+		he->branch_info->from.ms.maps = maps__get(he->branch_info->from.ms.maps);
 		he->branch_info->from.ms.map = map__get(he->branch_info->from.ms.map);
+		he->branch_info->to.ms.maps = maps__get(he->branch_info->to.ms.maps);
 		he->branch_info->to.ms.map = map__get(he->branch_info->to.ms.map);
 	}
 
@@ -970,10 +972,21 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
 	return err;
 }
 
+static void branch_info__exit(struct branch_info *bi)
+{
+	map_symbol__exit(&bi->from.ms);
+	map_symbol__exit(&bi->to.ms);
+	zfree_srcline(&bi->srcline_from);
+	zfree_srcline(&bi->srcline_to);
+}
+
 static int
 iter_finish_branch_entry(struct hist_entry_iter *iter,
 			 struct addr_location *al __maybe_unused)
 {
+	for (int i = 0; i < iter->total; i++)
+		branch_info__exit(&iter->bi[i]);
+
 	zfree(&iter->bi);
 	iter->he = NULL;
 
@@ -1319,10 +1332,7 @@ void hist_entry__delete(struct hist_entry *he)
 	map_symbol__exit(&he->ms);
 
 	if (he->branch_info) {
-		map_symbol__exit(&he->branch_info->from.ms);
-		map_symbol__exit(&he->branch_info->to.ms);
-		zfree_srcline(&he->branch_info->srcline_from);
-		zfree_srcline(&he->branch_info->srcline_to);
+		branch_info__exit(he->branch_info);
 		zfree(&he->branch_info);
 	}
 
-- 
2.46.0.rc2.264.g509ed76dc8-goog


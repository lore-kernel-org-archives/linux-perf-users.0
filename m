Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9C2EA754
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614144; cv=none; b=EJxpqDkifuK3WQSDPU2apZzY+J6b3sM2dDSdKdFjjgHIW0Ru5xVORuoJVM6E8nbIGYKDzoeRvZ5X1ByTavLoWIo2F0lEJk1Uwf1/iqLk523Q7/rJte7FzHlIbbyfII9afQ7oM6DMF+DfevTiZ/IA4QNCFSmjjZKlKPQWqxu3a2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614144; c=relaxed/simple;
	bh=+od/pv8U9SPnqABn8T5vvA6IegNaRSsOs9j1AAwCO+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/iv13w+WgIVwHUXEaAlwZTTYy+UJ6+NZfuyEwHQA7pSfYD5HGHOhfbx7Rr8x8IPdL+djkvoe4qcNq+ABZ+GDXvJgjYVEGrwuxyVlgaIKPXOqSLDX9Ur7Emo/XCytOlrVjkw2gMbbf98gc2neRliOzBRthtFyM30cwawwCH7o4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSMSo0JF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSMSo0JF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so8001484eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775614143; x=1776218943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDo6txpKcG/dWZi4YklRd+yQl0suoQaKKPebb6oTLYY=;
        b=KSMSo0JF22zhiEEkypN2APlqXCII1Cq+k3bgdQ3stUwNt+KrHmdpbBM9cEOkAUR00w
         oHn4n1FTZkWG2Gzd1gBJo1D8Y6fPjgF+xokkOE2P4nLNKFAZJvpXQV8k65mKIQltmOiR
         6IjPNqta//41VxibndCwsbesvvjiH/2hY7lK50TBe3IoRhaDXGLBmc3nqGPY2ooICYty
         T6EwU84MdElLUYwOkjxMqDPyVJSn+xWXTb5sMcgLFbgwFomKIU02nCebrJxxBlPiZ/Kz
         9sNMMjN1Cjj2uFRewBjEckEqQ2pCx2pI20cx280mkzIcpSZoX7cpLeUpQq0VuQ9tNHaU
         lAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614143; x=1776218943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDo6txpKcG/dWZi4YklRd+yQl0suoQaKKPebb6oTLYY=;
        b=rFyxmDWDFXJHBLKcC9kL6ExA4CXFFQ9qMpl/XF/EXqa8DtyC1Fbv5ECD7IEB9HpM0U
         UBKXuZHBY+ZQZAmsA9oJ6Eq9tle7jhxHOUxIl2+1ePwVr6g6N2xKpudMzpYwPFcLF4qB
         BVhn8cjH5brkG9ldd42AHu+QeZQLKncSR+/t55+yqhueWtMAKMHYi1NGjrcrM64kKvin
         bC0VLO2v9pQI/7mwih0QJHQddzjSJV2asFfYIBYr6+juja6mJkJk+XOzhaUrDSbiGx3I
         fjNMFEhOxR96g/A/D7vk/nAp7M3XwiIZH9Exl7JikUHqi5YaeRbeYBiR/HwLyfDDgZqt
         2dqw==
X-Forwarded-Encrypted: i=1; AJvYcCVlQjoEEck8gvfoZQ7epxqn+vf0RTS9kn8ywZ6V5jRVAQYJpCP3rVKvhhV2t+gN2xDPWBE9CJkbWaRGM7GLJhty@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSzH8jIONx4LmhD8GWI8sZNFDfO7x7h93W2qpZLnnSGxFvVJH
	v+HfarkbeAqVsHcf8QQUYyQ83DZVqfh/pdmcaDP79ShYLM0UbQeKrj5C8hG5eE40K0uR14pWCoH
	Gjds8t62tMg==
X-Received: from dycnr6-n1.prod.google.com ([2002:a05:7300:e9c6:10b0:2d1:9f26:a370])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ed13:b0:2d1:815f:19c1
 with SMTP id 5a478bee46e88-2d1815f1b7bmr3127413eec.15.1775614142543; Tue, 07
 Apr 2026 19:09:02 -0700 (PDT)
Date: Tue,  7 Apr 2026 19:08:36 -0700
In-Reply-To: <CAP-5=fVqaqNo1VyGPWhZ+DvEv+oRUU=sMtBtpFbm4D-sJb-JNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fVqaqNo1VyGPWhZ+DvEv+oRUU=sMtBtpFbm4D-sJb-JNA@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408020838.166906-1-irogers@google.com>
Subject: [PATCH v3 1/3] perf maps: Move getting debug_file to verbose path
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ctshao@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
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


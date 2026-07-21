Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6F439359
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667488; cv=none; b=DeM4IBHqAjGny4XRu6L5qzAn6GKDyUUTZU1YUzzG53kBbW9piLAM2kSNjOY0OeBPaEKVm+ZdNb7AzhN142vZEmAr5XjnsrR7CiaxyauICWoYh/JXA5/H64RVhVuG3jHA8vdU+Nb8yyDHiMcMilOB3GZsveowZm4JnJVibBcHh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667488; c=relaxed/simple;
	bh=pj0KjjICAGQcYFvJa34O/R6iaQNWxgcdqHf3gBWUcgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0nlkF2tHHo8mdNcGbhskoIywZbpA2d1bc+xvK903SrgQ8yacylJUUv3nwxG7CIKYskjTOvk7IrybDMNW2ytm7+cTeYEJ+zdZo4104ydJxm92YKcRv1DSBRYZWPWqF9KO1Qvx2ioKi5iK8gLhf1GdV6jSuxxq7aZYOC/ZMB1BIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNZyYdEt; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNZyYdEt"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso9100286a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784667472; x=1785272272; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=FNZyYdEt8bN0HEwMQs0a+gX2ynSbNjSniMmYqMhMEnaKUO9Hj0lu/EH/uiDTvhH35x
         oIiziAhIkVEUKH+JH/bDVm3C9QNxQZ4CRrMVJpgu/WCjjlwhCiF5NlBMfCl+g7bKbP6T
         ycm3zG8yidhCyhVesV2FVkicrC/cZq7xoAPNrW3xwYs13nZ7M5NiqLdxvz8HiCaezBPz
         bL6hGRfGa8/+MTK3cUTp30+S2pP9V8MtYmOZ0vB9aLn4xowhPG223zZ+Dcb/5DNwRpff
         x5x8pPB18/ePHQ/sQzkJulZS7j1Yxld+N08BQYorGQk0MH9fRIiFW5mG268yQ7cbcqib
         kmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667472; x=1785272272;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=bHlqOtNrm9DMvSGLaLcxNhr6rlCFzwClsrRISTDLLJJCYrjZe5GlkZhx1AHNgRESn7
         2LPMhNrtIOsZsK6uHcUg4ZK0wqkbOPuaqsDirKGxyo/ozK7bo4jV9qtO7qSJNmK+H9SP
         Hd9/nhZSUL5Vg77/l3DJqT9K+/pXSHeAs4+tqbMvEfqKpKQu5HFObfGtbKPtaSDGrJEM
         1oKyjMZz0R4+ZwR7PUzB9b8h2oNn1YhQJW+p79W6EvAQxLLr8ApQ3K/27WB8mthmuP/t
         KSL77/CFNLXKu5KwzXsWec7IMJtzhN6T3HBwEKjJLA50BDrD6Swq4M1LXhge0yCXPxCv
         qs1A==
X-Forwarded-Encrypted: i=1; AHgh+Rp7LqkfcBo54RSp3v5m7PT3/2oatzf9kKSsm30fKV7DdOTPnmPUmj0bjdr1qO66ZL6hD7Sl5blfgB4YZhgKqLrG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdiv9TtQlKU3bHbQPyRgDoPEvK6GdmdY8iPrA0j4gR58aYrqoo
	RS6uevHCFdd99SRa2DVd2lqoou0D4t2z3BC1InlRmWyQq4P6h9+8E7RqgyzBSZnvwsemSMIo/+5
	gWDfeSHw6IA==
X-Received: from dlyy29.prod.google.com ([2002:a05:7022:69d:b0:13b:54e0:b3ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f94c:b0:38e:4e62:f998
 with SMTP id 98e67ed59e1d1-38e4e62fbfamr14129699a91.23.1784667471878; Tue, 21
 Jul 2026 13:57:51 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:57:43 -0700
In-Reply-To: <20260721205746.183206-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721182150.94016-1-irogers@google.com> <20260721205746.183206-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721205746.183206-2-irogers@google.com>
Subject: [PATCH v5 1/4] perf find-map: Remove PATH_MAX 128-byte stack array restriction
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Use getline() to dynamically allocate the required line buffer for maps
parsing, guaranteeing bounds safety and avoiding compiler warnings
by evaluating the return value in the loop condition directly.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/find-map.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
index 7b2300588ece..bba511795a69 100644
--- a/tools/perf/util/find-map.c
+++ b/tools/perf/util/find-map.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
 static int find_map(void **start, void **end, const char *name)
 {
 	FILE *maps;
-	char line[128];
+	char *line = NULL;
+	size_t len = 0;
 	int found = 0;
 
 	maps = fopen("/proc/self/maps", "r");
@@ -11,7 +16,7 @@ static int find_map(void **start, void **end, const char *name)
 		return -1;
 	}
 
-	while (!found && fgets(line, sizeof(line), maps)) {
+	while (!found && getline(&line, &len, maps) != -1) {
 		int m = -1;
 
 		/* We care only about private r-x mappings. */
@@ -25,6 +30,7 @@ static int find_map(void **start, void **end, const char *name)
 			found = 1;
 	}
 
+	free(line);
 	fclose(maps);
 	return !found;
 }
-- 
2.55.0.229.g6434b31f56-goog


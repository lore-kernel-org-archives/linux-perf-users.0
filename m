Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7F46D0BE
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655246; cv=none; b=XEr2wmrxKm9JaOb785chu+QjJr4QHoJXc314PUezb2X22b152Nm9AFgJMUu61KRWObO82QauE1KiyfFIczeOvQqJs2pO3jmtqAPew7cDc00bju/+l5xQ6eQKLllN6fR04NYAV9q/CrJRO31R4m5Ox5HT8nM2Lm0xs+3emUFU6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655246; c=relaxed/simple;
	bh=pj0KjjICAGQcYFvJa34O/R6iaQNWxgcdqHf3gBWUcgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9/HHQhiPt/ED3mSjezv5MdbC5ovlWookHNOf7B9IVVUzb9xp/KguMuxsqKr6Bii03j5nWh4WnerHuuKQIZl2gyB4QUOElcfrKDRKOshNF0rhqp6mf2R24a9gXIj+WU8uJK1MPuaG3xHT9BWEEu77934/ZPKb0jFv9mKqiBoT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBbrvtTK; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBbrvtTK"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so15000592a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784655243; x=1785260043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=FBbrvtTK5N94NskrK0GZ29oSfu2XTZX2j9SlHfAOoPiCYjoXjqTp8jJm3NlUqAjusM
         RAG6dV0QPSbhq6GQBqRKpjDKifSyAeizFtQdv8q0BFkw3yMVxk24SDwnDFwoxBOztDPH
         R+aiwamAXTvdIGbplWDvNnjED14YjqRlRoSG8KjOMbhvC2/pgBvKYY1WBQuSjFto/oUh
         9m1KV/UB4WYSZPcSvPfO3hE/MIiO7Hr/rdBLm4oWpBsvH1urpU5KmjjSFpxupFub8cGb
         dfT9AXPJz3BEB371A5NjuXUgsqN4In1dJjtlrCsTiC3P46SP/KBBj6oh4jQvtQe7UtVz
         sMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655243; x=1785260043;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=gD1LM2fAuLaVKiku1uXplbtlanW7SRNUY7UzZYs0MzoeIHMTDOBXwanWxqovOZhdZV
         RM0Gv/tCWRAPgCzhaCQKgY1mXJ5i2GHzbsqbKzEUPTwMk5kIey8PKVolS9oHJFmeTDCw
         yY9U9ryuSgUuXMjWe05MPKaPHpWnY/vgSrBKpQQw5YYTlZkmAAg0+CmSdauEpQCoWq9Q
         XOSB6r7sH70wtGOapcn4pPJSi6tHW+/BIV1FxwUPzrXv/sHisDUI6qaw9UJpQGuaIE3p
         oPG31CvhMwfnFQyz6FmUZYJvcgMLdSW1+avvjZ7FnfqELFUV564OKzzslmi+RuAk9VG3
         IdPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpdmUxkcZAIIPQLtcrzr9XWdIWNypKMGm0cu8Zkbge3oahCGAO7IWtJsmdaTdHiw+sFdF+Sk1A/chVDTRAZ4yAO@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZZzTfScIiHqxs1ttTnkqXzlHVatVIFlRgVrG0HNDvlplPCiT
	2kcvOet6MtajOabt38aRTJf3cJ6s5IDKHx/R9EnKVhQGqTS2wTSzy6wtrjAPPLO8QQvl2FlJMFs
	v7p06hcw/Hw==
X-Received: from dlbqc12.prod.google.com ([2002:a05:7023:a8c:b0:13b:9778:570])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528d:b0:381:9028:5945
 with SMTP id 98e67ed59e1d1-38e4b44863emr20480602a91.14.1784655242600; Tue, 21
 Jul 2026 10:34:02 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:33:44 -0700
In-Reply-To: <20260721173347.9163-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720225200.3810501-1-irogers@google.com> <20260721173347.9163-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721173347.9163-2-irogers@google.com>
Subject: [PATCH v3 1/4] perf find-map: Remove PATH_MAX 128-byte stack array restriction
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


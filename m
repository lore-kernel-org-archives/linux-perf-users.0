Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A1442FC3
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675399; cv=none; b=I5m2YbtWtlsvm7d6j9MfrC7ZZGpGWzQbVDu9BsS5BlMnvsRZOherXGTyFNTLWRUytKKVZ0ytKzf9nP1TfHy+ELQEjJ/FWA0I8rk1oidzxgUQOe2WS4n4fuhlEJoGYxsvn33MUM1/F2E9TRvJ3t/j6CqimxJxldc/oPukwJViNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675399; c=relaxed/simple;
	bh=pj0KjjICAGQcYFvJa34O/R6iaQNWxgcdqHf3gBWUcgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UGuNV0Z8yK+wwSQLqXncbbpZV7GJEmwVNvdMWBQjTJ0iI8LUVfo2/bP7DiJ9fUCeIEMADqMlaW13P2k/ssYtEMhXe5I1hf/DzmPQYPRoGxO6Dwu/ee3uO0CPrc8H6Rxoj9Yt1UFDaz8dkhkLs5cw/kjkzQVb7zK5xjg8XcdQwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRTG96et; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRTG96et"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so18191180a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675398; x=1785280198; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=rRTG96etRwL5OP+7eMF/P4/HdhL1PAus1G9lfvuADKRcwXjo3xWd0sTxDk5yQMZBLH
         LCzSxQyx4oWhDP+VSChoXQWZ4PwMN1Ly0vV1+C8ldeaxazaUdn2vBgbpXcrHBzBH05Gm
         FcxO4oOKwvu5KmGkVoRo/MBfw9wJs3VDpZoZDSZSGln3jUktIyB7Cta1Pq9Mnnr+6Qvj
         /JKPt+Tf7nc0ib06NnRCOkJbnnRjqWbBJ4SsR9GgyWe823oXOQV8CAPUPlq5SP3s+yTh
         5flUlB2tRifcH83Y5opgjct6bhif6k7YsCcKXZUydZRODbpm1Ngrn/Yu80XdPSzS8YJh
         bJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675398; x=1785280198;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=WTdmSG07rMhIhHO3IqUVFKQtBhhU4cQStDuiwVic1eBomytMfaYcelVOoBIo+Gn2Vb
         LQ4i/o5Squ1Z3w1mNgCb12r81XcvPTMd6v8FYC0skHCXmUwtKn3Ae1dOAjAj4uyZg6VI
         znuMZPtHdCOIatAUGchnNbDTTrO40H7ym2DyJhn05Xtw/Kf+/lq0fq/7SjQyTDkp9Ryk
         1NwIP0GoRCqX35e7zqkc3RKLSYwnb2og3npWOfVqAN0fochVxhUjqJP+NpuIxyPRXo2+
         zafnPT3kob9DNd/U7+IAfJwOk2Vz/7iHnmzSkJaJQ/Zb1UCsBBrPJg5PXrUve+OxnOMS
         kqSQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4IQ8V92JfEyFXKb6S2dtsZn+GcacQcLFx5SFYRloC5VOd5T3wcYEha7cEeJZXcPLAc9R7xSjzPWbOhavPLlJQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0yatKrFgBB8NJEP4xNjFJKe8fbkgwzorFnloRx+f/A05tJse
	Hb/ghlTfV7ymSEQSkA29soXidFOgNNzSXFu0WukKcuRPg94bQkw8Vl3g9zfBXWh7EkybMa+1SyK
	LpZq9o/WuiQ==
X-Received: from dly2-n2.prod.google.com ([2002:a05:701b:2042:20b0:13c:bfe9:dc09])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2583:b0:3b2:a809:1000
 with SMTP id adf61e73a8af0-3c3ad6042d1mr22052434637.3.1784675397536; Tue, 21
 Jul 2026 16:09:57 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:09:49 -0700
In-Reply-To: <20260721230952.267754-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721205746.183206-1-irogers@google.com> <20260721230952.267754-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721230952.267754-2-irogers@google.com>
Subject: [PATCH v6 1/4] perf find-map: Remove PATH_MAX 128-byte stack array restriction
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


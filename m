Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E039A7FD
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677983; cv=none; b=GJIy5vmpQzM8vBnRPp0Jb6TiVW9fVRRTaYe4U7vKxuBTOjzHjnluYgbGwL7ibFBcHaTCvGLZFYynoRk9/6Qpt14bzAmnuAbarvi/UPHCRaW0y0FWpTLuAbhVju/9Z4sRFISNbl+kjeECj6cFEEwEPPA5SKAosVQLPawjrTU6g8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677983; c=relaxed/simple;
	bh=pj0KjjICAGQcYFvJa34O/R6iaQNWxgcdqHf3gBWUcgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eD5xSdlyD7qXLmjVQri9mwLtc4sQ3hrHEhGQn0OkfchCZvMP7GzhXqC9VPWinDjTvUhhcMh7SRslHVvzE4P23jKARh4SDmmguD/YGUYgr/04VMnIm9PibN1Gr1fWDwBYKXN6LbzswqKY0xkNFiN63lb5trRV7yUqR3j3hLNdxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usekTC5Q; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usekTC5Q"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e667368f0so6134795a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784677981; x=1785282781; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=usekTC5Qql84gIKMQz/ij6PxMtjlMlLEf+WVoyFVaizSwbXvXxzYo2IGXIJDFwdWCj
         YmEAD9yKd/sHHl6/KH1jR43mh880t+z340xa5XbNzq5SQp5+IH5bE2tqBORRyKBMN65x
         sOBAACZAQfEDg0vB3pUp7YCaoUN8wXHFiOItCPHk0qWjcHRDcVLLvjDv3rck9BNgFHRC
         LMQUR+kCGmlcNRP3qc0NR9cZRuLcbi69IuRca44+O5HTO3NJwacLNToYT+0yjMi3Dlyw
         jNWi1X2cKXC+VNMeZAfVStgOSamYoVfS/ty5LHjna9rpiUgJ6ySh4hnm1P+w6nP2BkmW
         p9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677981; x=1785282781;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=AOLpP7osV0i7adEZmi1exe073PU3YD6IAlg5LmwMUKmWa58Rizi8n/No1y7qzBwpWk
         BtucluC/xEQZNnHBgX0hbQTivpDLV+4AQALEJxBqUc9vXtTIO2cJT9MbkPF8ZdH1MXZ5
         NcLSWBPkxe4PH0IFQfiLJ4MAPQNd2O4F/WRPAcgPRtJ7sPTQ00U+kEbOK0chlc3w+JyM
         gxZxcc6UIyUqFKhKiEpUca1KTBBmpHkTfRMsc5VjK2+8bbMGXnJUZ/ip+mVtOw7hoM81
         R7sEsypcmmzr4+nz+NnllSiedkgfg9u+4L1RgPc8is2bhrCy1DHiKKRkKUWPGHAMUF5X
         g96A==
X-Forwarded-Encrypted: i=1; AHgh+RrWpnWOREKB2qQXWsUtpL2qgU0EbT+2crUtGsUbjwwvNCnlH95M9UdF37Etv0LMynorPklCy9ttehW+UsG0+LzX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/TZt+7ix7LvqhX3quSYzRG2NsHcGMFzIQFrh5umFWp/6yMG9O
	02TGkRpV94HTgaO6w9iN3f4OtV9Bd6G2PVOpe/XBibW0qpsjYHgp9nw6ukV/i686RwgEMQAsMRo
	mVYHTz/t+Ng==
X-Received: from dlbtp2.prod.google.com ([2002:a05:7022:3b82:b0:13b:9fe2:1c73])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc1:b0:37f:fdc8:71b4
 with SMTP id 98e67ed59e1d1-38e4b3e1424mr20258148a91.2.1784677981089; Tue, 21
 Jul 2026 16:53:01 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:52:50 -0700
In-Reply-To: <20260721235254.294053-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721230952.267754-1-irogers@google.com> <20260721235254.294053-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721235254.294053-2-irogers@google.com>
Subject: [PATCH v7 1/5] perf find-map: Remove PATH_MAX 128-byte stack array restriction
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


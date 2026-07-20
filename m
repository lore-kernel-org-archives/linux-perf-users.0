Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36C44CF39
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570120; cv=none; b=n96xXwN8NF/sZA3XqVslGQKJrBJWoGo8hrPqf/b9S8nF1DOBiueeIoNnDpc3jqV4HO9NUE7IL/EfRJ57OBF4zO5+chMei261KS9nHS1rATtp6Ksq8kJKtm2rbqFHKgqnox76D3JltkVdMvnZL1w89T5CrAmOeC/zd5dLxO8QOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570120; c=relaxed/simple;
	bh=eZ+wX04/zXyvzuyqM8J6sRBfyy1fmlZivY1CAvP+j8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BPexs88KIAGBp30mmVkS7/HBEcTlhQcSjLBKAGhm2RCM9I041Nh2iYgRwz9FoA7Fg5J1IBvQic5Yb5yErNRIuplNlvIzGkq2H92YreNV1UIJjv/Lz+vt/6q8003V9goTeIfodWosFMHLmMPJ01YILgrTGxCEKc8Q5p/5vpmiUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhcK0eeJ; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhcK0eeJ"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e095fd889so14635984a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784570114; x=1785174914; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hh+7obFCkE+FCg9itWlLHX9/KW1VGqY0DnXombaQNIU=;
        b=PhcK0eeJ8uKl7KuEHOpaS7x8ugPjxajY3qjkg8ec9nQA106azZafDg81M4/Jk1Ub/F
         nAZBfRhuvUBRbti4SwdAum1ZvnIkJVamTg2AVUEJ5CRvI4twqkD2RiLOCdCKnfbS+jGy
         5/D31wx9sn4bKWH6aZmDnbXovL0MXsxYzhVsFnLcS0L83orJZgGS/N2PCtvug9z8FPhd
         oLk32Jwyn2S9R+u+8b6/zWIFs/oGrgiMAEnYDIvDvhLNVBjP6Dttukv1rTmUkSWECife
         ImoboMibh0RYqsiqaMPX2gCmabo7Eg0XEyX7/Dov3f/oK2Gw/q6J/pL4A3ePKyIhR7iZ
         JTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570114; x=1785174914;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hh+7obFCkE+FCg9itWlLHX9/KW1VGqY0DnXombaQNIU=;
        b=hg8i1W2Ll6Q8+hviSuuHLDowzEVgWbZmoZq3WPP9+1Dz1Y4keV8FUmf47OiwJXNm1U
         /+/mxqEkOwpKWwl+DtCquWARmib4SJDpVqWkBjTkyl+VUxUZCm2A1StnMmbXnBBmklnD
         +/jnZq8T+oN4tJlWopA4Z43qhWDcKfTaznAQB7ufpovJzgJGWR1oLbruWiamlnCCcLVt
         AT/778cGxUiT7uLvIm3vm2Obq6jRVYaY+N+rg9x8OdjhR+mU+mXfAMSb0v52apwKKGU0
         NnqNDj9cwKk6ccTSBmjxUf2yWC7wIAWoc0bRnQki3lTOBmRIP+WqEqD84S/ywsmKKD2B
         Zp7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqYdss+BoUH3XusIDH/vfdGXq8CD3eySBKMpEo5v9ae9stQygDtblqnZcl+AQgNHc3jWIGb7TjxuZbCxTKyvlms@vger.kernel.org
X-Gm-Message-State: AOJu0YzDqASUTu0MH4c/mKTzfLcg3hVVIwDh/1VQm8qxfkQNzWqtb4s1
	xcrld6738E0bHBkWmSxNfRUY27ga3pEzMrpakOk4ezLLdbyU0lO0Gf7/d+jqVvuEJAt7xqtKXXx
	CJzdjtJUCrQ==
X-Received: from dled9-n2.prod.google.com ([2002:a05:701b:42c9:20b0:13c:d017:a244])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dce:b0:387:e0db:3fad
 with SMTP id 98e67ed59e1d1-38e4b5d3ec4mr15642504a91.38.1784570113414; Mon, 20
 Jul 2026 10:55:13 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:54:52 -0700
In-Reply-To: <20260720175455.3645946-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720175455.3645946-2-irogers@google.com>
Subject: [PATCH v1 1/4] perf find-map: Remove PATH_MAX 128-byte stack array restriction
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use getline() to dynamically allocate the required line buffer for maps
parsing, guaranteeing bounds safety and preventing buffer overruns.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/find-map.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
index 7b2300588ece..4d740b32814f 100644
--- a/tools/perf/util/find-map.c
+++ b/tools/perf/util/find-map.c
@@ -1,8 +1,14 @@
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
+	ssize_t read_ret;
 	int found = 0;
 
 	maps = fopen("/proc/self/maps", "r");
@@ -11,7 +17,7 @@ static int find_map(void **start, void **end, const char *name)
 		return -1;
 	}
 
-	while (!found && fgets(line, sizeof(line), maps)) {
+	while (!found && (read_ret = getline(&line, &len, maps)) != -1) {
 		int m = -1;
 
 		/* We care only about private r-x mappings. */
@@ -25,6 +31,7 @@ static int find_map(void **start, void **end, const char *name)
 			found = 1;
 	}
 
+	free(line);
 	fclose(maps);
 	return !found;
 }
-- 
2.55.0.229.g6434b31f56-goog


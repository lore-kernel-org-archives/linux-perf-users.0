Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3073415F09
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658122; cv=none; b=XDxRUKM9J3FaVzGhfTiix93hc+d7Vq22oFVyVO2xXmEfNcj/lavKNFZhI7o8mlAVc0aqmwce7WVrr1ZVnfjkyXbrX0CJw8tJZr5KIaWctukizcLRyK7RW3N6OC2CleDO1dGiNoSFXcbMoP5bmpzUjIpcVx/EPuVVULdCSQJ0bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658122; c=relaxed/simple;
	bh=pj0KjjICAGQcYFvJa34O/R6iaQNWxgcdqHf3gBWUcgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGPs7bK/ToD/9L8cXBu26sYBgNiaqaU0oU9UyMEKPZHS911DkDX6A8WzbELFxCmW5mB9k0v3pJMtBNqH91tXT0C+6NpyJ6NFd+cnntHmi02yVesAhXVBOBSODX/ogcunX5SR3pxIIWSRly45DXcDny7+XNwI3lOCJO8HDVf0yX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3Yy02rF; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3Yy02rF"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e667368f0so5702104a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784658120; x=1785262920; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=c3Yy02rFw7nHjaTA/cEdX+8oKZsYsMYHSG7x+RRprzauU/kvVnDnneMkA7RKpuuTVM
         oHa2ExeXiA+paJeMkeaMvvG20oDUN+43sGCDI/nbk+aaFjW691FCDDPdgDHDbZhuBDRH
         nolvuNkV9T5ufytNm+Y42LMMebXJROWW+/dplVdURUUo2YH1iWJZZEWS24Di9nrFfNqQ
         Z9tVcfMmPxMvUdETXeoPGn3XrX24F/JaX4aCFf3nE0PZfPNO5eSLkE7X3/EqOC+6dj0c
         aM+axGY1zXwU/XbWewSZwjf+jBdxL5uq3WaIcX/rqndYbgwkJxQtQ754WfBv2HnBRmsx
         5v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658120; x=1785262920;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=NeZcg7YlnBX8djzWdsuvDuJUCzlh6Aigax/QWUiWXbxUjqI+xwz4qzn0qCbdavCF9w
         MPGUQa3bjjOn3Su2hfXyjjKK5TEG24T5sWKX5w9HThh7kaQZ86X793eCH+UQeLikS8O5
         CofMgF3GhcIfJpXrECHo21rlhoQP9y8YBL/1EpI9wdcM9M3uLExp/EF67XWHd3IrfiFq
         dnSbunWKbhTVREy+diIdWmo+HLfomIo4ihWSmRIoUKJzTDYuD9b8ogFtEPiZeH4v/YXJ
         rP2bXU9WtjHhPL/QWhFgGbkXTY2gwGHLHjyYXDZA6Bc2uZKffI8JXIdoK2ylT5fqXb1E
         0/rw==
X-Forwarded-Encrypted: i=1; AHgh+RottwfvHiUmdHPPZqH0TvkCkBtYEYSordJU8INvOamOpFruT4Y7j8htKH4irnX/c4NzRcQr/1NlzWzfwxltxN36@vger.kernel.org
X-Gm-Message-State: AOJu0YxGyRb7RMrdtHE9BE7U4TE2n0k9iAsMoFS1dbXsiCi823oXMfRX
	eGOvYlm0u6kFqlmOuWZbR8lMILNcmwxHXHkU2MqQeskkCDoqk8aDfI2QHUbRvrJLPrkl4wUCR0I
	I1rQ79C4c2g==
X-Received: from dlbem11.prod.google.com ([2002:a05:7022:100b:b0:139:b9a8:f222])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2244:b0:381:bc4c:da5b
 with SMTP id 98e67ed59e1d1-38e4b43cb05mr18989294a91.18.1784658119436; Tue, 21
 Jul 2026 11:21:59 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:21:47 -0700
In-Reply-To: <20260721182150.94016-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721173347.9163-1-irogers@google.com> <20260721182150.94016-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721182150.94016-2-irogers@google.com>
Subject: [PATCH v4 1/4] perf find-map: Remove PATH_MAX 128-byte stack array restriction
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


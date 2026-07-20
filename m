Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EF439325
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587939; cv=none; b=gumoKrYdV+Y2QG0qhBrUbiCJC4LTQR1fSCtt5W1sBv8uP0QpgCSz9ITmS9Y6Bf4QYRuim0/VXwtJ1t6ohnYseJC/J9hyZNYTevRpV9oFX9ThKMGpaPla2eYCj9atbDytj8TEz1S8J7oCGP5rMKXRsUVAnRuSjTbL+lERzJRooGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587939; c=relaxed/simple;
	bh=pj0KjjICAGQcYFvJa34O/R6iaQNWxgcdqHf3gBWUcgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OEohAtrujtHGH86GVCTNHvuDIwP6zEhYlkoacUcMgMsPs/vlAev6Uj95zfo6N9M8566e2MclZwQ5OOfe/94oCakmURMmbgcn/kOl9Gg8bGDZfPvLbP7zIU2A7aVi2i7x5GLbhZOetIKm2AKuvCKiYTP9Sx6R5Vqe7vDX9CyYLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wW+HIkn3; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wW+HIkn3"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e6f71683bso3338170a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784587937; x=1785192737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=wW+HIkn32DjVUwEmvV1hVvTjyEQvNTzL2SYbK26opS99JabGE4UiIQcrp2/nkbsXNI
         DIbcPSVBl2CFj6/Mbi08uKw/w1DRz2SUPud4+VXt2C41V2AYrSwqXz55K4AAH3KPWKKA
         IjqUTeuIF4UUDCxweT0miYvXThBfPiMiyHWRQhTbRXLkJNaOc3/54wrViWxhCR2lnpRd
         Tl4pnMtX9s+cxWGOYpQk6aZQkpaw+Pz8nmx2U+GWwk4b2qmXrBYN9IHCGVzD6DXaJIok
         zMYTnEevCCN+c7z71xG8hh2TBh+U0doHwcrYShp1EC57w0rJcqgPRYlcLau7ZD75Tim4
         Gr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587937; x=1785192737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jG9NVpjcGT0OyijdNnlD4kEtCaHdlCbuAaGu1kfKk=;
        b=UInwzi1uiDqMjvCSWcOs3PdVRsBWWzV6sJc4hzr2EfMlezqFeyr3RY4eEvi1gevrW4
         p/IcDqVAHo2GAiuOu2kykk9D+RIGEvAlEeXL8VjwrYjfTD/MDZOLeFaKWQ4hvceZ01vz
         tie8MCmxmdKgyKqnSXlvFotrSUTxJysJ8bKdXgBZ/Hh7gWXswxHtJevXN0SgV4EtwZgC
         BmCU8MxgfdSdGvsX8cYXiXAFQX7ENUdAuziuuhqvPzmYOjAqltgw+cp3/ccR3gUN4Thf
         KEb4JfDQIc1uSoQU3KUUv85sy6HGemvD5liFF3DcPb2nCTWwEXUXHXA2Az4BHc4kfV3Q
         oIUA==
X-Forwarded-Encrypted: i=1; AHgh+RqSnVrCwNxeTqyQg6bw/zrZ9Ktd+5pKnXCXVgu9MAvTEyjfZSz+zmKmxd1qPuD4mk0z9ydxz9lv0gjaLYwhYJa5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Cmf4nOe3v6J+WpKqKtpmjI6v7Oyr0cZG6Gp+L78+n0QdqC04
	owIE70F5GsxPI31cYNz8eylBHp6xpq07KJFMi77oq7/ZWyRXF8+YsvV/Ls+tfEYZjxI1i7nRoPT
	APxVt7Dc2QA==
X-Received: from dlbbs9.prod.google.com ([2002:a05:7022:909:b0:13b:2b79:dd1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558d:b0:38d:dc13:6f94
 with SMTP id 98e67ed59e1d1-38e4b586170mr17190141a91.37.1784587936937; Mon, 20
 Jul 2026 15:52:16 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:51:57 -0700
In-Reply-To: <20260720225200.3810501-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com> <20260720225200.3810501-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720225200.3810501-2-irogers@google.com>
Subject: [PATCH v2 1/4] perf find-map: Remove PATH_MAX 128-byte stack array restriction
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, Ian Rogers <irogers@google.com>
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


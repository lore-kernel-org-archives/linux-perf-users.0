Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AA306DD1
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191514; cv=none; b=iJzjbYdDCzbbdmZ5UIWwNUC7jKD13dZv+7h/nhdTHhoVCD5t9BQd7WH7O0KlajOdksILcWDHwlaLNjwp1XWK2THNvg8a5T4HGF/nCNi/YjxYL2IveF+eI+MGvOCtvfiGAM364Pmg8DAOVC/NdFXdovG2hT6Ez2KiNOi4pZ8t9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191514; c=relaxed/simple;
	bh=4RhnUIdDBTq0pKyjxJeOi7qIuV8UBI3E2+4jD3YcP7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UEsUH5wGnPD0RrwQOxVxvhQIyUSJnJWqrQNPF6pipjnkuw+DDcjpHOeuqHhXjIs4PxdzDkmMzFdAtrgvDSM6/E3DrxGutQTVaM3gS6WUEkFg3sMVnWDaRI7EecGpV5K+gqtkS7OqdpaF5e2p/k13GBgz4pWlrp4gpS+KScOngLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHsJ89L1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHsJ89L1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-234f1acc707so11221875ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191512; x=1752796312; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=lHsJ89L1kDJvdPXp1LYvPU/cvGMxlERd5bJIycrz8YsKd0zBgTM9ZEX18R3Rm0NptA
         4G6klv4+J3oIgfwLLuV7iV/SrE5PU2Q58aW7/OHWbPoGoycGbU43flkv34+OKDkVIxur
         NxDe9Cq/Dx40OZh9MzyakPEBFggpaqri39PjI8Q3ecMBNpl1ybS2BmctxLj4rTHkFYrV
         8MzT7fkI1su0PEC8aFfkwzzxUyf/hkSTFOF5iqd2bRzWWVKAkjCy+xo1dnlAeBBl/ZsO
         nieXQQBUwUTP1YiGefDGVih9TYiPiBpLM6YPeQjYI7azJyHO1gU9OYdJnZpjPX43Lfd7
         4Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191512; x=1752796312;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRZkm/myoY8JXQXFYiK3d6FXz7MSloychwQltzDxXbc=;
        b=acPa5e39p14vDZdibMOjZl3Bh3wFsBMRrC7YJBkmSUtxIrwjR6qxrIxgWxb+/UySOo
         5zzB6nch2qbpeO9HA5EGQETMJQT8KTZXGczQi8lBPR4iWUslWovdi3VayeZJ8PwjyMTw
         6LGHJHSDHfipOQjh+xr7abeNA2sL7es9M1yMcP7nmeEl1YM12wHgzWBIXMUf8ii5rWbx
         TCbN2FDv5OT4AskhkMZKYPFdOPdGdAviDN0mvKo8ur1M7xzONUmsrf07BiJQU9yZ4vsH
         T1q9+rkavHrNcT0iNwzK2bKvbmVNEg3et8dA8OFA07o9k9dUFqngpE34QgKtW2X6IOs3
         8H1A==
X-Forwarded-Encrypted: i=1; AJvYcCW4N/EapT6T4zCA+cla0r6+HgjZqx5dSh4Ov4d0AL5Ya1Ny6j9O/m2cQc7OB84/oQoF9CfaNC5i7rWGGMuNgE7l@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwaI6Evz7i7errlBzxt52xfv8NmpmbQcZNPqELGYfWpM05jic
	3LQA2/BGodSYsZOKoz8+C+I40pz+UIQGi+ScuLsk+ccue+nivDTWsKWaaBYUdgx64EyhObyCz9b
	Z6dP+YXWlMw==
X-Google-Smtp-Source: AGHT+IGLTNBJqqNRFe03rtohHZtVjV3PGAjgEaeS1rjfmd9WiCQvjWw/Kq0cU8IwP5OHRC196EtcxUqGNwTt
X-Received: from pjbsi9.prod.google.com ([2002:a17:90b:5289:b0:311:485b:d057])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78d:b0:234:a139:1215
 with SMTP id d9443c01a7336-23dee28fa46mr12324755ad.35.1752191512306; Thu, 10
 Jul 2025 16:51:52 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:16 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-4-irogers@google.com>
Subject: [PATCH v2 03/13] perf spark: Fix includes and add SPDX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scnprintf is declared in linux/kernel.h, directly depend upon it.
Add missing SPDX comments.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/spark.c | 8 +++-----
 tools/perf/util/spark.h | 1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/spark.c b/tools/perf/util/spark.c
index 70272a8b81a6..65ca253cc22e 100644
--- a/tools/perf/util/spark.c
+++ b/tools/perf/util/spark.c
@@ -1,9 +1,7 @@
-#include <stdio.h>
-#include <limits.h>
-#include <string.h>
-#include <stdlib.h>
+// SPDX-License-Identifier: GPL-2.0
 #include "spark.h"
-#include "stat.h"
+#include <limits.h>
+#include <linux/kernel.h>
 
 #define SPARK_SHIFT 8
 
diff --git a/tools/perf/util/spark.h b/tools/perf/util/spark.h
index 25402d7d7a64..78597c38ef35 100644
--- a/tools/perf/util/spark.h
+++ b/tools/perf/util/spark.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef SPARK_H
 #define SPARK_H 1
 
-- 
2.50.0.727.gbf7dc18ff4-goog


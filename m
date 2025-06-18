Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7025F7B2
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281323; cv=none; b=FuXH/FO1xq7GZqHG5XzV2tjM09o2u2cybT/bKK4cW4t6HHyCPoAhgHibUs0uasnQZ0qAuQTPhaV2A4uGNIxR4RKAjfhpK0lE4AJND0mbPf2znWUS+hRFwyQ7bVHCDmLXiYFY4s/f51eq/2mM2Ced67DaMHVfodL1YIZ/HNGaUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281323; c=relaxed/simple;
	bh=AGPmAlAQR0g0Mmcs/uRlA5H54exkEzkBJEzy8rKw04U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=IVM/Pfbengagq3keQc8xPMG+CArLezWq9lqYLqq1fziTGCHBSENPhKfCqDxl6cNx3NlnOEeiUmM3zd6CWbfopQ8PS9BIdNjoPMUIs1hhDgYbQMR7d0PxFjgP0c5n+7Mjn5LIfiY520qB6zA0kBnMjlwNaGH2nn8fvLrfSv0jftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abDxen4y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abDxen4y"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31c487e1cbso80860a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750281321; x=1750886121; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kugD/a6Oq01nl8GXZYoQNqMpzVqYE6IP/zMN/oH7VXg=;
        b=abDxen4y2dF9+RPkPxSjkmi4NZEnxIjmWg2sJO7As/wctNLexTqTm4WPYECqOJPY+E
         WmWyyDM8opUiLmvwQxJUhWSc8EByYhhHnu/nBE9VJF+DS8bilfMVvSVMEG8pNm5zuqXw
         DtFF6h9Zy+fHWMRMIMLRmO3xdAuBvUh90GCrLuTl3MiBZdjHoCpdxUnKXiy1esFK/J9u
         6d4/DGEEPRJB4QjfHCsssbZhHtzXxvHAhkV1mYHhHWUaqNCsTp2MXboaQlZrvxBqfu7G
         7kZlytJz32aTx8ooDOX4d/iUWzHmXDSuNezI4hVpZOmbxBKn+XP63rjlk93u6tu//AaN
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281321; x=1750886121;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kugD/a6Oq01nl8GXZYoQNqMpzVqYE6IP/zMN/oH7VXg=;
        b=mEAUu5lFMikUOEpjBebqYg9QZ3NI3oKhOzxX025Oei614fz+YyHwI34L0Z6A9b6Hg0
         1TnqzacdbzWsgbs5OrcpAC9u/+xE3fazYVEKkTV8Sd+z5MByPkxKkfJVWfAN1vUSsYN0
         qgAB6oymK/t6ZpInR3k8pWrEZIIXsYJQ7MiLqHOYSUfSN1pu3VpX7hOcFgXccJY3UuRn
         TlokH7qKpf6uThALTmWVrhL8+KfQ2a96jxUfkiMa4mVNBh3TM623zD+B9qs0vnZ09p7F
         exdnnLJO2ntF5b9dUa+J1Vwn/kSxaALCOdKpDJAxjTcJ4xETIs4MrAIMnDdIdC5oX3T3
         HTdA==
X-Forwarded-Encrypted: i=1; AJvYcCUPXxBjw0yVOsJbvTXCmLhbminWc+c8/JrDpI1k4pWOebFTquH5ZIudr+fODwRMAPrF6x6Z7lYhtc4HlJ4bdsbs@vger.kernel.org
X-Gm-Message-State: AOJu0YyXP/vT4cGGIMYT89FXrM96c5iHWXv1YFqRHo/zh7bOGNJlV1R3
	HBD/2FV838tTq2ea766vuFyPG9kp1TYv4irkXIfI8NKvsjpzx8+ftHPznuwmBID2ZUTuAY3ns/m
	7UoTnMj8Bqw==
X-Google-Smtp-Source: AGHT+IHklB2h/YWXJUEjk47SGrDIP4HwXRROJ0w/r5CagrJNn+dueEakf3gzfgt+ISbJZxBPMjRlUdCylAf+
X-Received: from pge23.prod.google.com ([2002:a05:6a02:2d17:b0:b2f:5023:640d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6a0e:b0:220:bb2:6074
 with SMTP id adf61e73a8af0-2200bb2608fmr2512209637.11.1750281321071; Wed, 18
 Jun 2025 14:15:21 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:15:13 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250618211514.3084483-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf test workload noploop: Name the noploop process
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Name the noploop process "perf-noploop" so that tests can easily check
for its existence.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/workloads/noploop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
index 940ea5910a84..8b954d466083 100644
--- a/tools/perf/tests/workloads/noploop.c
+++ b/tools/perf/tests/workloads/noploop.c
@@ -2,6 +2,8 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <unistd.h>
+#include <linux/prctl.h>
+#include <sys/prctl.h>
 #include <linux/compiler.h>
 #include "../tests.h"
 
@@ -16,6 +18,7 @@ static int noploop(int argc, const char **argv)
 {
 	int sec = 1;
 
+	prctl(PR_SET_NAME, "perf-noploop");
 	if (argc > 0)
 		sec = atoi(argv[0]);
 
-- 
2.50.0.rc2.701.gf1e915cc24-goog


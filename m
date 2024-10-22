Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C91BF811
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618259; cv=none; b=B3BgOhvBH8L0RzUgBEfFifQx9ZhvRgSJqRK0dUNx7KBDU4Ox1OsX4NawMcfXoNYU8ZT1bGfIOoE+lB+FvGZs8++OuV/+skj30yE864ODPUzEqvgatOzPgE+4CCmWDOspPybyP0fSxlTUB15O21V2kDGFLpClbC6o9Lzg5gVhbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618259; c=relaxed/simple;
	bh=GYxmpcXArXMONJWsRe5WPl7DZqsyI1iL6F7x/lVFYsI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Cdxx0kyZ/5iCnGj1WM+NhpfNUw3az4o9Wm+0++OIkoOUG5ZnkrvlYa+QT1lKX0rjb52D4qmCWC7xqiC1L5Rdw7Dc/qsGgHBK40hiVQDviUkEUggsO+Sam5uuCvAfpPhMo1FhPW79ibgRoeyXa1ZYV9XYSj5CgQqPTGyiOvS+OoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnhyOn2a; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnhyOn2a"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso78947247b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618256; x=1730223056; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=gnhyOn2azr4kRVP169J0IKEj9kxRbxU71BVnPd3XFaS/ZDv4QcdTe3qreIy3a2zUUt
         M1Lqr2GBGhUjbcD8c/yDQnLE1qgRHrmBLMU+XNRI0ZKJdMa+XEjmZ49nZKsnW/W6SdvF
         LwZr3Np+br7++FL/8PHQuzRd5b103AXzmZOYtpI+zFxqkDYIkQiwOVP2Qg0WJ+rXiqht
         lsU/WM0YOsIC9pqqBBt2dxdE2hFe25432l7PQfZAvoeLQ9smDz3gQpvQe+xNWgE4pA+B
         +HCrtGDLhveRNTG6X2fuOH2rorC2pxUlSSxaAFvCepFv4QdIDEmYrK6cYEzUqX3aQaRZ
         j+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618256; x=1730223056;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=tiBWg77smA+NA+fl2DZf9e5WOuab8H3pHIEm7GYmQWgGpgRfsYFtZmZw1c7HGqShEv
         U1eKjebFhcxu2BoJzANv+g1OcMUcWXbsePMs4aFb9tRLQkYLZzkmx+TYs2e8RgquaIKG
         L8JsxIttcUycCF6oxmvy/GFZ83Hn9odaayoxb23i0oBU8JpSL9Wax5hCEXL1W9Dz6Bzk
         8g+PW0lGKlHvoVPVL1BpYSLjNwgbEJD7E0DHxWU3G0/M0y/tOWGFKAs8SPj54L4ZZUjd
         RXDYlUearItJMKFaWbnlxYwn9nHe4zWIQ906ql91cdgpoXe2NOdDlUfr73prvN9b/9LZ
         3Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCXOYRWR7B6jqvyH/N68ykH7dAX6GtXSMzz6yfKU/jx4ZwpH10/xYl7sGOE685+Anomw2svrvMKc2Q5apG+Ln4FT@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPjRIAhUt6z8WuPJ3vZ/Ky2OWAGVra5qNIJJXJ4lTY7W/hRyf
	GL4cq2983kuN+w6S9iZPM5x9taIoqM46jYW5lMf294hjbun8rvLQHPKCvHxlikBuPRKc5xVp4Kr
	PP9Xknw==
X-Google-Smtp-Source: AGHT+IHOiwWXO2ZHbTfv88EA0bDyZRXW/88QCQ9qRZQo6GdNscne5yPWZzbRQcgZmqadb3XY1CXrBgj64hyZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:360c:0:b0:e24:a393:bb8e with SMTP id
 3f1490d57ef6-e2bb158ba76mr21384276.7.1729618255720; Tue, 22 Oct 2024 10:30:55
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:01 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 03/16] perf python: Remove unused #include
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 13dad27169a0..974578a04099 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/kwork.h"
-- 
2.47.0.163.g1226f6d8fa-goog


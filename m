Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B012BF24
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979034; cv=none; b=VIw4z61I3njx4QyXmq335KQsF+4p51i8SF6NHwotYyG2Ayv+rtRDyHwVbUrQB7lCv/cJ0FgcLJgOE3V96rQc36i+LzpMs5Pik6/3xQSpGw1r8tF3WSmwRvjkyUJv6xtaHHmoTNl+mHmsAOLZjOIwVyNkeIcS0pzjqxlQIg7lgXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979034; c=relaxed/simple;
	bh=S7D5C+bJCAzeCBN5GGs2u5xl+eAkYpdmeT4lCCcMaUQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=I6QGud9gZNXz9ugqSNqIGj9WUrynSRJEVEn3/baLFtuqhWuFS1ZlhhOl+4y3629eHh0YXlYolGUgyGtbXAwU6bq75aICwNiut5bTyTzc6dJ+1rVdqdZG7o0qn/QTv9CWbMeIzdfqEa3gy7EO7qpqivtdh2QdXYbNSRdmDRu7EG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PeBEjwDP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeBEjwDP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e862eso64360157b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979032; x=1732583832; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3DnKYRzLOBQKhpteQUA9RyoAZyPDDZS21UzXGtb/zXA=;
        b=PeBEjwDP2QVlC/QgMOtFUZs2d0FfrktZLMm75AcSr2Vmlpm6MVz/6NVosce507R5lR
         UkWNfXCoB0HCc4tba4ucJzQs5Tf88NgV5I+6HYzqOYDJ6aJAw2EP29mVrqs/AhFMlyZJ
         I2O7DThR2djeADJUiPoI6DcXjlVbgM7HcEHOokcm3eo3ug6hSiagMhCAbZm+38NPbJkA
         vfPUxEha/nl87TCkrqXpR2RGlB+optM+TuN5J9FYu7VslYFV8rjU99OrP00hFpTAUlPV
         2q87YKsHY59QxuHhqjTQyhuB2Ricjbdka5V9dcpI/ZGLi6/MiAkie0qyE2ckOGE/ysLV
         +otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979032; x=1732583832;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DnKYRzLOBQKhpteQUA9RyoAZyPDDZS21UzXGtb/zXA=;
        b=S1D00PMXaeQo55LZgjHcUyIqukTpcExOR76Lx5WnnHCd4uIXt66O61Hdb41KDHr5+y
         Dk/pAE6LnzRJ2JihxlvH6ekEAM001zb2ETVwE2eiGmkPmb6SO4prrHo4+F7GXFR/hqof
         lynxf6CDMqcIadoJnHiy+WlZTSBWyQk01PHMBMBTLsJvuW2TC8KIVYGX0+sXuGUg5y/8
         jF03Mz+WjOQ06e9B0L0P4SDqPlHVujlURQ3cOjWh4NYX3W8LF+dahmuUdd+Ctu0yA5PR
         Z3DgP165ZFBGWp2JgqsoQ6LNgRJFSxzZVpgELkDmP3OVpjLmylfC88EWuCoQ8WXZPCTG
         x7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJgn7ycfQantnGRnG5qNfD0pbKRrHa9XcSR8vy36IhQg0egPkLx1+rE7/vxeUGqEE9wOx6iKJyQeaeykOxS+B5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JxO2SSDzzYKN8loQzFsKyjJxWIOx+mvM0dcAIbebDFnUYH0Z
	XLYejxZNcUIBMvU+aLfbQEci2MRa9sRoaasCV7rb1WH9J9rxU/RUCtgSYWxtQEWty1Mp8fXZfGf
	rHVjFPg==
X-Google-Smtp-Source: AGHT+IHd/+TZ9+u78b6TEoIZfyfyrMfN24E3uv7SGJBfMn+KQioUQ8Q0p8Ds6Xew41S+Veno0J/9F7rO5Vrh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6d0f:b0:6d3:e7e6:8460 with SMTP
 id 00721157ae682-6eeaa3008b1mr489367b3.1.1731979032547; Mon, 18 Nov 2024
 17:17:12 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:25 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 03/22] perf python: Remove unused #include
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e04c05612830..140437042a73 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/stat.h"
-- 
2.47.0.338.g60cca15819-goog


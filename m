Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825C202960
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Sep 2025 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757046414; cv=none; b=WK2J0hnmzF0kWcz32Xk3yU4BdTZbvMgeIMdJys8f/BT8u7Y6xZw5xP+v6YZh5zko33IdqJebnsM53d37/GExQ2V9iqzV4FY71OpVXQn5RJFYRmJI8Qb20K7w51QkM12Ugkr7QRw2kuwrcIa4XuqEk7HVg2azCPkGA+FuESRjN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757046414; c=relaxed/simple;
	bh=APNifcqQvfmAxTsXFUVhrjk1zp/wjo6B4YZkY1DN1rk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=N+1mW6DrS8rHcPjxvIpMeowxHVVQP6h1g1GsXXwIk8+CutBSB5kYKpl6fx6cxle2p89Fl5GbddIYHxEJ6LSwbGOrB7g8JoAzUKAuykOF05jBB6NpfrldaJT8LEVH3rWGs9Fjaxhib4ipC+ZxiPxHRwgjEpjIrDMWsgPoDLToQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nORc1PH9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nORc1PH9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32b58eeb874so1637424a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757046412; x=1757651212; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JrjDrt8f3iYutO9Aif3XhcPkZcgFbJj6wCjcJ5rxTAU=;
        b=nORc1PH9hM/o92KpS3OI73e5YVUtuC21u4rnD9Qo73k3AMJ0Y025977GPnDFybkuOm
         vJL7ekzZ/SzkWagxT6F/ydr1K+8CjN8DXaRFoACDjl+WEgJDvokSb6MoY4cnt0XfoWJQ
         0iZkc8rlvN2FkGdcAQWT370O1eL52o8fQdZGXa8i6lLkhjRSVZoJKhA6LbNvvDZbySfw
         rsmXsO9zAHx78CVDO/u54MrLK+SKODPmwKPvecL440NaWArozPcDqA15wOPkNnhK+VuM
         GjGOTfJAYVNwFlpU3cq6JuqrRwT0iAYLZGjwEP8JhqxRlXRdKfQ9S7pkOZoe3ZOTmI+H
         Letw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757046412; x=1757651212;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrjDrt8f3iYutO9Aif3XhcPkZcgFbJj6wCjcJ5rxTAU=;
        b=e38y+Hq0wupLkU9S22Xx4WcVZYcnyr6XfvC2ONnW/yhQ8N72WwLCZ/CtslgeMQYu5V
         IpeU/hQGXnXBv57usnBNMXaGZO6M0SBTsc3yYnbvwi+TVQBWzOB6qm7DeMvSpuPjmmk5
         chcIjsFikadViqPHfEf3n4JTpZZykNKQDh/wtEr5du0+zlS2PPeiBTDjg0gpolxOLpfz
         reukLUDD8gzLJTGF+HfikCQmSY8jd+tcuCjsYszhFLDF/Qo5Qg6LwMQxO+5iBisu3Nd/
         tW53EDDxRAWWaekgX6iiK4I/0FM743xHNPgTCOOnO1AuiJf6XNhbN30Cjl7Y4A82f93N
         ziEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE8uWKckSPbcrav72pvAnGWTu65ddsQLfsw2AIflc8+WmXOQvt/5RUiQs5DY0vBlRJ5bVhWWwwXj3dsAZcPyJM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6tIu04dBq7wsp3Axdi5mVzu0bBA3EVodo2cTiZf98hiKR2YCk
	bXG7slckZUoI129faQqYwK0S9liDXGTqZ/IboQA2swQj6nxFtX7oQpsjNhne8n/YVtMG3U9h+AG
	CIuPp/Nh6dA==
X-Google-Smtp-Source: AGHT+IHjJ0NyGFd98AipmwG45xziFo0CHhw4GWBiIpBRC8vXAqJYlwZi9f7hz4LTP7S8Y1CK3Ae+1S9qSXb+
X-Received: from pfx28.prod.google.com ([2002:a05:6a00:a45c:b0:772:14a5:87cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938c:b0:24c:2fa1:fddb
 with SMTP id adf61e73a8af0-24c2fa200edmr6080614637.53.1757046411920; Thu, 04
 Sep 2025 21:26:51 -0700 (PDT)
Date: Thu,  4 Sep 2025 21:26:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905042643.1937122-1-irogers@google.com>
Subject: [PATCH v1] perf parse-events: Fix parsing of >30kb event strings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics may generate many particularly uncore event references. The
resulting event string may then be >32kb. The parse events lex is
using "%option reject" which stores backtracking state in a buffer
sized at roughtly 30kb. If the event string is larger than this then a
buffer overflow and typically a crash happens.

The need for "%option reject" was for BPF events which were removed in
commit 3d6dfae88917 ("perf parse-events: Remove BPF event
support"). As "%option reject" is both a memory and performance cost
let's remove it and fix the parsing case for event strings being over
~30kb.

Whilst cleaning up "%option reject" make the header files accurately
reflect functions used in the code and tidy up not requiring yywrap.

Measuring on the "PMU JSON event tests" a modest reduction of 0.41%
user time and 0.27% max resident size was observed. More importantly
this change fixes parsing large metrics and event strings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.l | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 2034590eb789..1eaa8dbc26d8 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -5,16 +5,14 @@
 %option stack
 %option bison-locations
 %option yylineno
-%option reject
+%option noyywrap
 
 %{
 #include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
 #include "parse-events.h"
 #include "parse-events-bison.h"
-#include "evsel.h"
 
 char *parse_events_get_text(yyscan_t yyscanner);
 YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
@@ -222,10 +220,6 @@ do {							\
 	yycolumn += yyleng;				\
 } while (0);
 
-#define USER_REJECT		\
-	yycolumn -= yyleng;	\
-	REJECT
-
 %}
 
 %x mem
@@ -423,8 +417,3 @@ r{num_raw_hex}		{ return str(yyscanner, PE_RAW); }
 .			{ }
 
 %%
-
-int parse_events_wrap(void *scanner __maybe_unused)
-{
-	return 1;
-}
-- 
2.51.0.355.g5224444f11-goog


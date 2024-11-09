Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52613B780
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133113; cv=none; b=gb78eiRlM6+ekmmNjaQVr8+IHog0+14/BAOPsD8ckkrOSVMsRs06CGs45/nEx+z1SGnlZqM0s8mY2WSPU9PaQx2IU+amXnxDYYd/J0ma9ldz9T5F9EQgGeeeS2RD4hoq06txHO/wUDwpaKMV0kss0a6tz7kWWpg/WZqGKEoo9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133113; c=relaxed/simple;
	bh=jjW/Mdo4ZJpee7DWegXh1qo6a5tS0N+f/pHHyUDeYmQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=duHm1J2HDnTkIrB/uqmSkbAUNfDhsDFHk8gO8+3Y27BkufjhVWe5b+mai2KgopkVNFxkcjDUAqfvl0HqjSiqrZH7vumRmx+ixQhbOrlKlrsMcSr130Rpi84rOpA6Gx5Zp8iizPxrcg/giud12znZMvvqU/dM1wdEV0XX7o+UlcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJGqfvpE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJGqfvpE"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e6101877abso58317187b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133111; x=1731737911; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKtLelHwLhS+FdJ2cDeNqQNGycDHJZPn6HtFfn+lcrc=;
        b=aJGqfvpEzZ5Z7Njz5rl5JeSQ++2EwJ2zelI8LiKlksDY7/PbfXwIXyK7NBy71tXEtW
         L9dYpAyJPhiBkDiLvDgAq7cfQNtVA0qGsVOPW1QiBdk8NA7y7kTFYWvkeseHT4cRwxOz
         3YaCfny5odP7hdzljA+ryvsyFcVyGgLQWOKXys3G8I4t+YCSDdQi8Ci3TkMG87swafgY
         qYsm5OPlSUwKr98sR8Vh2doi4ES0N9fivIaNZAzvSMOrVY9rPx/70gCzYieH9pY0BPv0
         THjR1/s1aoBY/KOh02lsAAVoqwB+OOeFFzY7rQXVpTad2WHfeMB1vhkyJqhVfiTy4N5i
         wzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133111; x=1731737911;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKtLelHwLhS+FdJ2cDeNqQNGycDHJZPn6HtFfn+lcrc=;
        b=rni8Tic8pv58VcddzSONjoibRpeCiK21lYlqfjK323lxjofDJlZF13S6K71K5Y8lAV
         de7T3RR3ohiYvW/oDsrkJ+Nz/C1p9bFwLn1RXjdcOibG2KEzL2dCzS0Z5F133458Kegw
         0MUfSPObCKTHFBnnYJGa0oEk8ezQbZf2lqm/pZyDUrSKtYnTHGEF6onS9xZkvoVZxA3a
         /mglgSCbwsu0UNg7GxhD8kWW8y3WGwXugtlWVhCR1NDXjG0E02JoG4+nnq1TecNtPlM8
         uUbLwcY+9XT7E1T6wugP6kG0LsmuSLEOX9BJxNDNvuoID7cm3Qkl1rJiiaIKyIPFTwda
         HItw==
X-Forwarded-Encrypted: i=1; AJvYcCVlc7ipo4S8axEXzBuHuay9cKt+PO2gRzymHHXpjhkOmdBGNJ2PQ5MGvgleVgbIIlg+VMlC8wZ3TbFi7aA1JzTF@vger.kernel.org
X-Gm-Message-State: AOJu0YykeGon5pVnPUEZ9Z46BbcoHFFbVnrMWC+RdE+NKzRld2JRg9yM
	p9pF5e/jZubHWvS8+xAJddWvtNtOwfy5yhWrlp3WAZOOasFxGeU8MS7rlF16snxmXbYfTGOR3oi
	W9FPaZA==
X-Google-Smtp-Source: AGHT+IGhIeNLPRZK5O/PYT2qqHEwmo4Z8fY+bYdkwDZDWI3k5DZ9o8bTRsCOjM4Mj3m73yhcoJua6oaDQxoH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:aaea:0:b0:e2b:d28f:bf28 with SMTP id
 3f1490d57ef6-e337f844036mr13186276.2.1731133110711; Fri, 08 Nov 2024 22:18:30
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:51 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 04/22] perf script: Move scripting_max_stack out of builtin
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

scripting_max_stack is used in util code which is linked into the
python module. Move the variable declaration to
util/trace-event-scripting.c to avoid conditional compilation.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c             | 2 --
 tools/perf/util/python.c                | 2 --
 tools/perf/util/trace-event-scripting.c | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6b6d4472db6e..5d5a1a06d8c6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -92,8 +92,6 @@ static struct dlfilter		*dlfilter;
 static int			dlargc;
 static char			**dlargv;
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 enum perf_output_field {
 	PERF_OUTPUT_COMM            = 1ULL << 0,
 	PERF_OUTPUT_TID             = 1ULL << 1,
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e2109f6c7ead..f82e8a968e24 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1307,8 +1307,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 #ifdef HAVE_KVM_STAT_SUPPORT
 bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index bd0000300c77..8abb7a7b6888 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -16,9 +16,12 @@
 #include "debug.h"
 #include "trace-event.h"
 #include "evsel.h"
+#include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include "util/sample.h"
 
+unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
+
 struct scripting_context *scripting_context;
 
 void scripting_context__update(struct scripting_context *c,
-- 
2.47.0.277.g8800431eea-goog


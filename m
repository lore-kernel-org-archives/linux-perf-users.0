Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89E1CA84
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979039; cv=none; b=tQaRYm3/C5qh6P/ATaYP00s9xG6MbNxzHi5SFhG8giO8PrAguJ8i2yOA7rVzh/N6RPGTYLwUM1fvW6gWykozdss7kOkSd8FEMeRigpB6eBMVDb4E0zTHfMrQDdeaj5q3vRdSr+QLb/btXfrUzgvv4mU1Y5IZ3J9Nxx/EXV09/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979039; c=relaxed/simple;
	bh=VhNtNpqyWTEY8C3GHcgOI2AXz6yHFJu2f13WAuVuTq4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=ZZNC/BcFWYyy2NubalwOdqFwf34ALam6chWZyiDFpRVbTIxhc2f3xDG2sRiZfnQWJ7oFC1F1Xep5Faj2dJjRYHtkn37QE/tls3MYAioFDtGGd3siTCIGZMa3JId+3NOqtsBOge7SbxcJaNs5KnEdjcTNGXTGZMHCKGRiF56d47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaBgaLVo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaBgaLVo"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee6a218044so44984887b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979037; x=1732583837; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0328NUHtrNZJQm86x76xiznvoVOH1WYLNLC3OdZCsg=;
        b=PaBgaLVoomZECZ9Aw/pIM/zvdD3ON000cr2fQpWHPxbUtRLcOCFVFaNSpI1PjzREJW
         a4MEzjFhWgRCLoXBD+9A5sOFTC1/yc0/ZF+y4mT3pnFoLVv8+XGYw4um11iNFSqpHWs+
         AACfsFIExuBMZmxS+wambFmGnwjAuaCr+4PfB0qc9AJbIVe2dP/u2jmFgdVTj5mXZJRv
         pUg5K1mYbFr1KmZkUibxutlxmLyv8Hk2fyFx72Z6CCL+GMBpuuM+wzuhm5tlziqj5ylM
         crCjaw7dXulnu7gqifBSnsI8dY4dDvlwLISNUbVZ83JvoXiClbzW0pWHgBlHqZhYZfCt
         oUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979037; x=1732583837;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0328NUHtrNZJQm86x76xiznvoVOH1WYLNLC3OdZCsg=;
        b=cpK3kxTtO7491ZUCvwWF03x1nYOQTtYyGg+Jscl73lxqhToghCV0I6UumMFw/5/fVE
         /FkbLV+5lr8OTwycSj+B/ZHM0SoL1Dwi0L9RBk2dvNIul0IGomm+eJ+065e2RIqIGwrv
         So0gniwE9MUyz6fPEzNgaihw47h9lPhkP//BD55D7NIhxVIRdiJ0dBKA2O3SSfdjf0SH
         4kyoQyXhLP9xVyqhgzMMybLnwjauCbaHliK4HluBfI31GT85ESY81nwcvLLEL8VSR2ks
         3bMWh3W/ebTDVV08+WtHWr17NE1LnkIwLYiZcLFpXEg7N3rW/MQh026K+/LcPgZpL3jp
         yzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUML1Ka+heNiYIgsHji9Lw3xYudRMAPpmTsNBzcHaLeMgvgUOMYP/HBaIvf1b8BkSHNsLWTrjUn8axT1E3WyFMa@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmxHZ0DmjBUk9IA2Bz5gL99JTx+FBS2PV9aGaFBjMXb/jMk7t
	k2p81eTZvX/98xcAtasd9WUhnroruPIlT8bt9+O4nzPWxPF4x9GqZDLF8bhzjJ+lspyZXnrWOih
	cbZnyng==
X-Google-Smtp-Source: AGHT+IFFILUsD5rAHW7HYokLe9DALJLU6QVneLadKpvxX95BkXN6BnzrHQz86joi/76PNMJsY6nit++nZQf2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:424a:b0:6e2:1ab6:699a with SMTP
 id 00721157ae682-6ee55ccc2e3mr1091367b3.7.1731979037241; Mon, 18 Nov 2024
 17:17:17 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:26 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 04/22] perf script: Move scripting_max_stack out of builtin
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
index 9e47905f75a6..2a7e704c0a54 100644
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
index 140437042a73..029536c1fabc 100644
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
index 5596fcda2c10..d514db1df27f 100644
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
2.47.0.338.g60cca15819-goog


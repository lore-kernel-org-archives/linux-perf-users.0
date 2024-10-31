Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B150126BE0
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339010; cv=none; b=cepUFhYFPOvb8Sx2JJfR2vJQ7hNPIfyrH6I8uCwUwBzXz3f+P44BFl9Nh1Oo5jOg2nGslyXPFFURC1hpuN9vQLJNy/jtzKfymH4n7p9FTwOtuCAYEzSywDjXuH3xBPDsbl3H5aUdHZSWfL41riNx3jR5p9XX+VW/bSSWf4PE1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339010; c=relaxed/simple;
	bh=yvPuFAfJaNIVJqiiJainkQUGB6s3nnX48VfIsgR6iK4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ohRQVLAOVgWTr6UpTCgXL8/7ioatfV3zwfEahAYWadp7xiw/IXtyaixnt3wwwNpWmTB565T2eASM8lrkZLdD2xzH1pzX1hu6TT2XjP9JpqMKG4iyBS4RqC4CjwQxinGznQxTkvgmcxMpr+x1LaCm4lU1KpTn4O10EP7sVQc7844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zL2CAq25; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zL2CAq25"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e0082c1dd0so11184437b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339007; x=1730943807; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8V2yhtENQ8jLHM+jOYAUxP+5ml2lCB5CR/T0xGeIOrc=;
        b=zL2CAq25NX05mv9plYTW1rXFjy9pxRscrqtj3TPQ4MSBbZ0JVkLjHysVdB+n8XomhZ
         DSxR0c80xKd4gjmZmJlXGl8wvs884p16VEuKKo+g9Ue0bIMaA3gTja4JdRdZ+yOsuNeT
         i9L1jlLqDmQqJRZft47sfIzOZyT7QRbFT9CoNKbcq0t42u80pIUJ45z99iGlEF0RgCiK
         FGAlYlkJoSMxRT1ml6x/rxUXGBagUIXHkS/tn5VhrQEPsi9j70vt5ytvUj1J0FynROzr
         +4twEk1kHspvbUsG6aOnrJ5uElYXzWbiJ4g15Fiw0Ves3gGmXrN+N5ZcfqdfACp1cI7K
         ZHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339007; x=1730943807;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8V2yhtENQ8jLHM+jOYAUxP+5ml2lCB5CR/T0xGeIOrc=;
        b=SMVuD3E38eQeOLP7Jbj7PZmD/71LhSFAH8dKbJyJWUSgYQn+QvAMQ0cpEreHOjURmz
         JbwNSfzFb64VuNRyrD4othoF0J9FFIqroB3ili27wf00XoPwu5hEfPNt3ApIk3ArDD5p
         PzHI9hE8uEkpDHI8d93KCGlTu81TN0wLVaCG5Hl9Zb6SP8yyDLBzOu/qw6ROW3JnIGY6
         V3XoAasZgdn6irLGLeJ+NrGBgCCKioTPVi2Alv9IGUn8AD2GoraQoq3Es+McrQ8hqZOx
         Nx5SY55yFBo08FCBnGCdBSCDHcbk2xGC7HP6DRvnXKz4ZxVCagI5tQwi3sPsxllYqkrt
         ih+w==
X-Forwarded-Encrypted: i=1; AJvYcCVV/3HVuOiw9xysyPwovKnVzYc7UYGz5UQvR0/I9w8Zy+OqDnxeVLEBHQ3BIVjt7GBV/qn8dAXdFI7jaxt8kUC/@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHwnQz9j5IzKqsPBMaewNkBhHJbo7gCxqjuyNnw6Na2tdfb1e
	mEc2ky6q6rMr0I+I/kJSTlvxtbXdfw4fblDENcbewhrxLk5iXoo+5EgdHpIlCc+U+WBCwBiTzg5
	LeKTE1A==
X-Google-Smtp-Source: AGHT+IEMd9R2AtMT95ukzXCTLbKL2p5xzh40NAoOkgE2zBkm/4QxHvXtyWzIOxcjRsyYO+fDNfVRcxPlBGLM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a81:be02:0:b0:6a9:3d52:79e9 with SMTP id
 00721157ae682-6ea3b94f7famr1085127b3.4.1730339007150; Wed, 30 Oct 2024
 18:43:27 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:35 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 04/21] perf script: Move scripting_max_stack out of builtin
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
Content-Type: text/plain; charset="UTF-8"

scripting_max_stack is used in util code which is linked into the
python module. Move the variable declaration to
util/trace-event-scripting.c to avoid conditional compilation.

Signed-off-by: Ian Rogers <irogers@google.com>
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
index 974578a04099..298f43981fc5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1306,8 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
 bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
 	return false;
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
2.47.0.163.g1226f6d8fa-goog


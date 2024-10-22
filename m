Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8971C1AD4
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618263; cv=none; b=RAY0BND2j8Bfn0663TYTbmkEU5jU8VmgyKGMK5V/VwuNPZ+MRaBBcPHHBZn15nhNgg1AszVZkTJMAuvSG3jNCV2OmZHy732m2d/LMAyypbPCuNKAzgAG9kyu5xtZ5cT5JN/7ZzLEYQTlgDoKZY1j1SzVnFRCE/dZj8Xxu5lz1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618263; c=relaxed/simple;
	bh=H3R8MsSWGSQnGeDZaFT2V4GrMZxhd3Tz/afE2tKUxgo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KqNSUdwOS4DNgmAsBpSC0OA1KM3UyOAYMxp9dNTICBTa7LxfSCvjdiXAY/vp5GSFCKTjB6NpOBMpNgFGPRfmlshXEjQ6mXsj1aAZqJPXBcFi01YzjuAWh2eBfoUNP06Hp3qVfkoQxhvqQasM91hnV/NqfaE5Wm6EkCFGoSE7z5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mz3TnOc1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mz3TnOc1"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7e7568ed3so783547b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618260; x=1730223060; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9/j+c/KOCVX2XapkXz1QeJCdXQcJtU2BeNP+j/8p1s=;
        b=mz3TnOc10khTI+QcvWKvlR5R8pyeX1seg1pD32hws8maUV2QsJwGi0+4oSpJLnzig+
         tHlApGtnUdHezxB8pwuVLJK+7J/UBTVZDkPFvA8IB/H3/u8SN1UbiJTHfMrm+jAqCKSx
         Idj99CzW6S82V74x/wRCQ7OlG1cbdn+ISWb+zd4JDX2mWFn8jI/afOAHrO92USgEbNsL
         xFlK1qEUx11f4MpLOKkJPYZsknVgXBthHjtdI5i5KXBReSfGO3ST2mk/XGjssJcrsR8E
         9zn24PyGv4LJ/tOZe6L3SW+fyafdriCdD/YhNwBkcLzcRrOLgu/bTRkR+SmHOo4S8hqH
         FVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618260; x=1730223060;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9/j+c/KOCVX2XapkXz1QeJCdXQcJtU2BeNP+j/8p1s=;
        b=HYt21xvFIT2kCQhTHBwazkJZh1KMWT5NU6ZBdzyz3eUmL8AakKtP9mAPk4jqRqo6cp
         6/3IXak2dVvWbmUqsqZsFh+Crp9H3dmGHpczx8N6KsbVp+FAvckBzFNXl564qIiRvye7
         MZq/t7cIdhg0TgJUwU29hJKhtzCfeBnqAriINFBhPJkrSdBkvxDoZ5DYg2ZlkaykYxgb
         C1oypN9GtxhJMGyh2lZAdwfXTuQYdX9ng6dC8kU/u33ySKYOHThR4o/g2DIPl7b6Zyf2
         zpiw+W8t3mlSWrwol0mkZBiquSdXrSCpYvWn6YDLQ/0o88K66rbgNiDxpMBatdfTx5s5
         kgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTcG0zwVqbBCpJIgNDw40jo1PNs7eZxzYCj6hIB7HNf66m0z6QG+oMGxN0Sj2SOIQaic6hQtiz5q+0kcWLh5Fl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jdOkcbIckx1eIw4I9RUfNnyLJnb0z2dfkGDZ9WbMGa1GbhJl
	rdvUvkDwTFclKu6vyYEDL2AIOYqn8BMlpWtNvx7SFMFzXu4/G9wlnbTULyNDLUejZOuiriqO/vp
	dh5D+Sw==
X-Google-Smtp-Source: AGHT+IHN/IzuKCIDhR9euB0F74dwGBIUGCqlmNTqScwZ0hD19IOV4yCWNZdg8WjDV+It7qMsAqOF+V2/L3RF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a25:8445:0:b0:e24:c330:f4cc with SMTP id
 3f1490d57ef6-e2e24859f18mr24476276.6.1729618260257; Tue, 22 Oct 2024 10:31:00
 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:02 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 04/16] perf script: Move scripting_max_stack out of builtin
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
index a644787fa9e1..621c26c388c8 100644
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


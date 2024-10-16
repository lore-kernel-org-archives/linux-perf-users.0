Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547418BB8A
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052686; cv=none; b=hks546dSs0UcPJS/sMQJOWJE635kRPfse8+Mub8lONEJt0SHguXTixz8Zpm6aKBD43yiLTjnCaYOlCNrAHJjXhJLKB9dkr3oxThpgM4zfzqNH2KimngpCt9PPuRUlM249Ogg2ePgoOnkKOOnwEVigFpHedcHU21ulVXj+GQ8jsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052686; c=relaxed/simple;
	bh=zLV372V3NqdgZLhhP3Ug7ewTDMXX2WZU0AoI5q9l/W8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=s1QLLXZUzT6i9vxY3MshMV3nFB1Q/hbATXBhQ0x2pedcg1iXkI/3gDzv3zM6t4fIeoVcJJ6rk8bm1WDRigoUJruRXBY6rma7UOhU56yhUNvj6HgKEixoVoJKXSkAm4WVfPr+FCOGF0HdQFvL04bAkHnryk5mfseKIaF6yvdWXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lESikxwv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lESikxwv"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e383ba6763so50111487b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052684; x=1729657484; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3AUkqayHUmU4e0+n944DcuSfXi0VxOxh6mXGhbne8U=;
        b=lESikxwv4CDUGMvoJqrGR0bTIUaHfbjo6bGiuAGx7laFa6qfwMOZv8vy/g83iezMcv
         o3iDQJvRfJBIs0iQVSMueb43P+VS3gSx1+UnfEcGV/+Ng1kd/tulVibLRl6lJ0AbFFAo
         npDaHTiV9JGISE7XDQZ/c0hi/vrwAna9Yf86rT4Jh7cW6VMvnRt3ER9G4mEHw/vIVuMJ
         lSTu5PvYEY/2FYjYnLiO05OQUEA6EYrexLgmiP68PNhsKmQgcLBJVnt6ZSSKDdURgHxo
         NAa6m3R7ODnIcLiX15XQDDCNteRoZDdxopIyMJGb8MuuubekcI3j3fjdBacMa0QTaaLp
         YYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052684; x=1729657484;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3AUkqayHUmU4e0+n944DcuSfXi0VxOxh6mXGhbne8U=;
        b=kWoaZvEV0rAgs4wufsNd1zz8HXR3N9eLxllblVi/aUT9if40mX89+fBZyfo0NCt93A
         ndUDDe7ACvEgEZE1B/nO3S7D4T7sbPXcQXfLuEXd1BhRKQbB7RCxaF1PDbK3I9/v3Woo
         F4hqDqazrswd2gQcCkQIjd2HrXFqZUTZAjiGz/tTcUZqjd5yb4V53bNoIUAq4jxvmxd6
         bhAwAxPa5grBbgbRohbXlFvosWGsLDKIyRGDPy5CuqLreilYpdUubj6g32dWH1K60twf
         ajN5s83Oda0gpnUVaM/CVCVtAevcNp2ok1Rbe12akadOZahNgqa6Db1eot1HhmWxdNdU
         5L5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW61QFgoEeYOOfQ6tvzppY/kqVSAAeBX+FN8YpR9jii2AAw6LoYKL9fP4/Y8eUqH/YTo/SNgng4fBgSLLnO6Pr6@vger.kernel.org
X-Gm-Message-State: AOJu0YzMADtG3vGlsMRY+X7xbOlvTiqwSZwByJyM6sTplUtl3I2b6SLr
	hCPtRw0t0BFZJ5sFlc2uM70L21GRCJKcNLQsgyQkG8UFQLbKYtIFxbxP1l0z+gHCVrNy2WIClD6
	vFEPzPg==
X-Google-Smtp-Source: AGHT+IH+B/UstQTaBPNWylRCfG5c7G6KjVDSfo/SEGNBz24zXUN6VhnJfUctTb/L68W/BCQ7jhbH+DG86Cpy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:2502:b0:6e2:70e:e82e with SMTP id
 00721157ae682-6e3d41cb4aamr547127b3.6.1729052683538; Tue, 15 Oct 2024
 21:24:43 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:03 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 04/16] perf script: Move scripting_max_stack out of builtin
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
2.47.0.rc1.288.g06298d1525-goog


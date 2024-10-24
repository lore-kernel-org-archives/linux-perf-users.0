Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AA1AF0A4
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755217; cv=none; b=qF9KUuMhw6AaBFIUqr7rmOfCQKrYPtV1bt+39mx6p+3K5oJlWyx4n3Ubwp8foGM+/HOdGe/n/v5ReNZtPFnEuJs2gwiKl7VVn3K72AC3plv7kdh3dvGnO4Rp62/rgwJs65uIW6hrhgQekUO7mjia8Y47VTPr/R71Kx3/w8ljeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755217; c=relaxed/simple;
	bh=bl0TwbExu4G349NNkk4dquZriD14f6vKBPjGiiViYyk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=s0UVqw5Hlb4IE6nijQ4kd/ofq5BndycEUcisCONMQiXNxWcaw5f4sJr2sy6c2jKWuwVpbUmtv4DtD/GgUulvEGHHN6vJR1err79JBb34P8F+U9Otio15PQVQz53d3mg58vpYn6Wa0MH2d+t2av/rZ8iLqhDwoML9f7lJYSt3R9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekG/xcrn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekG/xcrn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7e7568ed3so21371557b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755215; x=1730360015; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yVnPqZ8RpP/8r+vCUjKwDzk1QDMtk4+iGqU5/U/LQI=;
        b=ekG/xcrnDqq9cTA/iiFLKRbhy2VEQpERIDNrGShuwpJYyNxZlcP1hBgNMaWr6Qkp8a
         4jzOSM9ZmwSyo2pLq6L68MKpQL1EwyQbhkhecfW6oUni1lD5yyakzmMoZlhVhu4VlWs0
         pjXa9yKYRRwWQPPHaA4+g1lfAdzbqD1PgXqjIJFL/YqEacOSM3uUe1tHWkbSHh48KpRu
         eE1VWd1PR9ZpFIWyDa5akuwPQ7+UzPbgLuVOz8hSGXnoCiTTIUyqHkbJ8p0+xFglvYLi
         Ols8upXCRFUGC6HD73ZOovnmf/6pdup8YzAHvHSZEQbQc9KJjzEgyOJ9HRRFlSFZR/0R
         dEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755215; x=1730360015;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yVnPqZ8RpP/8r+vCUjKwDzk1QDMtk4+iGqU5/U/LQI=;
        b=JWnsafZal0KOpqqw0CzR0KazLNQjCzf2rNGnB68Hu/GwRQSJ7jcmSYQj3B7riSWwnx
         VM1bgIoJECGs0Jxh3A+b1BvzuIHmyeqhjVZRPxi93yXmNcvBajNkFDbUY35ppY7YfbaZ
         0INzuED7B2jBZ6/o7NrMNk0EQlRuPP3l1ZGKB7ftM+9Lh0sgDgc04Z+cs30XINUL3Xrs
         1Q2LJZ45+ld7uxQrxCZ3Ha6jd1SM60drwmCmgRqjbXnahzAXg/fBrmL5mHCD/Z4f83Cc
         MCiKmtLwE+hXGGypH31hfeuCeqe5sqbdA9YUkfMv19d46zwHWBpxfa7xg9dCnjorhMTy
         syuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHXjSyMM1hWfQFfTN/UXbrOM81a4xcX2MSIcG0o8EZRJ8ZT5byXE9pp2MxZhOAKhmlEjYf89yi6uh8YwLCfpDc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpyox7WfbDzURDeTrnMuIlTVbUyzNtqSpsPRHibPdIWiTLWXpL
	kkixx10wRB/n+QExgdMsUuaVyMZV8ba4yCw3odV3RC5BrvovA4QxNmsxm3Cxu3dIKAWQOIeHwek
	3UwfZvA==
X-Google-Smtp-Source: AGHT+IFhAeOq6ksfdCCDp5Gvm3pCls8guQL8J1bSwHwpWmahAPhyCJrGStCtgKeRCOJldq5aosIa1voblhde
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a5b:60c:0:b0:e29:7587:66d6 with SMTP id
 3f1490d57ef6-e2ee7b732efmr5876276.4.1729755214276; Thu, 24 Oct 2024 00:33:34
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:17 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 03/10] perf test: Reduce scope of parallel variable
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

The variable duplicates sequential but is only used for command line
argument processing. Reduce scope to make the behavior clearer.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 57d2e9e03fbc..0e8f877f4b1f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -41,9 +41,6 @@
 static bool dont_fork;
 /* Don't fork the tests in parallel and wait for their completion. */
 static bool sequential = true;
-/* Do it in parallel, lacks infrastructure to avoid running tests that clash for resources,
- * So leave it as the developers choice to enable while working on the needed infra */
-static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -578,6 +575,12 @@ int cmd_test(int argc, const char **argv)
 	const char *skip = NULL;
 	const char *workload = NULL;
 	bool list_workloads = false;
+	/*
+	 * Run tests in parallel, lacks infrastructure to avoid running tests
+	 * that clash for resources, So leave it as the developers choice to
+	 * enable while working on the needed infra.
+	 */
+	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.47.0.163.g1226f6d8fa-goog


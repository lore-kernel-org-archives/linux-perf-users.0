Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27018BBA4
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755228; cv=none; b=Z8jhTYizkP7Ez7FueZ1DzXQeoXBGXSfLHjue5xYuO2HTJegKG2cDkvDiKANwe/BytJdmeZOiw/Lgr1yP6IoZR0ZVUFd/VxuN+f+RGrojik8gX7NCQnI1qqIeoSecEftbiHUw12JnISPdUURw2tF0eTQpPrOHnAVDk/FwOOnnMLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755228; c=relaxed/simple;
	bh=M0R3zHDAes8blHNNb56eB/dYrJt3dM5C0cEG6y4au10=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IYhZg0x1LolebujJNJqJo0yOiF7zmak7F3nCI0+XqYRCsSiB2+J14L8ekEFxb2oko6g3KbkVXlnh/gw6iL+OvIRwteZcR9V4SxLuClCv/SjwVPrhP36Z0+Zn7uQTtUCjVXJmB4BwGv4aPYsXWqNW8wXx9+0nF3xJsTLG5kVHFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1QXGdYh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1QXGdYh"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e8436adso9475337b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755226; x=1730360026; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2We4CvxKfLkecfrv/oDL8pHcCSPB/kc+5ogezpwpnuw=;
        b=u1QXGdYh51wCk4m5cIy2szxKpMSn8cOQm196pTl+DdOTqYiDTpnCJRt1wOutVyBo2F
         0jwqY5DEb2JOc4G2Paq8AfW3DiLbtrL9mNuaJ0NFQJxROMJF2aen8H0v285OrSGqnb0F
         AtV7QE4Uc16/c/021T2wLck1lMg4BTGowg7d2jSTqZrIaVqFJ9TxOPrh+vbPmr7CuSxP
         twwi4XjVT3F55224P4jjt3CJgrpkXL+9Kw68738+eqXEUWxISPg+zntp2GleDjXErFKh
         9AKWmGhS2FZo2dOuZqWH+Zufy9irpKWI6xBPExr54MmqOBB+Z7JNGlSviJ3HBRePkffE
         9XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755226; x=1730360026;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2We4CvxKfLkecfrv/oDL8pHcCSPB/kc+5ogezpwpnuw=;
        b=Y+Gz6ES0MfmC74hIpjDrkRKCRD9/+HVvsPDPlpQTXUGSmco74F5WnVEaYPsuxxEBlZ
         HzxEDro6MX6PzLk8HpkgSawDIECtbngttUP835VPAO4GgngkYu2TmsEsPZRfux7ErxQl
         jVpehv6ODqX/lS4yopelTvqySIrJOet7lja7ETK3gMSt+WiQ+0aIW+I6B+gLnFGu6jNO
         YaR463+jJGt4sNHWA75x8g1tSOri4Vv4NsxeMl6EHfCpFGQsS9ivoDlEAeMzun8AdDTe
         Rb8uf8g1HabPH+LDWLa3e62p0T8q+8Je7u68ulW2vrWFe+HIZZG8sRtbqOnn7piW+ABR
         Fzcw==
X-Forwarded-Encrypted: i=1; AJvYcCXE6kjKkoV01h7mMWeaUCJBt5MAjvw7ApkgtSjsxZ+N5oelJ0bWSWeWKdm+Yk0RpslJngO8GOAxhjdmjeJdHRuW@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpXWLRoIvONAKEZ9ndekvFdx3emlg0RzsMnK8EQG+fkf+8apD
	YhaacT4pEoI7zTLHH+IiKQuf/hfm+UuGSfh6KIaYJ87a/Cm7COJO/XQ33hNPC++ThiU4EsPJOwJ
	aM6MhTw==
X-Google-Smtp-Source: AGHT+IEQF3XmUMfnQFWXLgOqMIZJcZqb0suCDYaD0YRwhNPawy5pg39Y3574SaLRcZwU19FWRca8TDWM5lw2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a25:bbcd:0:b0:e29:76b7:ed37 with SMTP id
 3f1490d57ef6-e2f2fc0f2c6mr17376276.9.1729755225660; Thu, 24 Oct 2024 00:33:45
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:22 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 08/10] perf test: Make parallel testing the default
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

Now C tests can have the "exclusive" flag to run without other tests,
and shell tests can add "(exclusive)" to their description, run tests
in parallel by default. Tests which flake when run in parallel can be
marked exclusive to resolve the problem.

Non-scientifically, the reduction on `perf test` execution time is
from 8m35.890s to 3m55.115s on a Tigerlake laptop. So the tests
complete in less than half the time.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b997d0a68ca2..a0a678facc45 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -40,8 +40,8 @@
  * making them easier to debug.
  */
 static bool dont_fork;
-/* Don't fork the tests in parallel and wait for their completion. */
-static bool sequential = true;
+/* Fork the tests in parallel and wait for their completion. */
+static bool sequential;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -639,19 +639,12 @@ int cmd_test(int argc, const char **argv)
 	const char *skip = NULL;
 	const char *workload = NULL;
 	bool list_workloads = false;
-	/*
-	 * Run tests in parallel, lacks infrastructure to avoid running tests
-	 * that clash for resources, So leave it as the developers choice to
-	 * enable while working on the needed infra.
-	 */
-	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
-	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
@@ -688,8 +681,6 @@ int cmd_test(int argc, const char **argv)
 
 	if (dont_fork)
 		sequential = true;
-	else if (parallel)
-		sequential = false;
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-- 
2.47.0.163.g1226f6d8fa-goog


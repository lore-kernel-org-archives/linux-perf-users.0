Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8B11E7669
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684265; cv=none; b=NMOwXbi9b6YVI/TCOiuvsWYymI1k/vRh69vJScmGbJnWqa+329jskXXOxTZaSw3m7N+jvOXZ7LV9EsUOvfpPhYRDdVqgj2oxEv2F4pUbxYx8PwvpIIQ361PWG79pUZNp6Ta3xmPE35mNQm+Kl1Iw4AMPVzeF/GbqzjqdSNsBGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684265; c=relaxed/simple;
	bh=Ynefxe454usJyeyyMAcQNEBhGJRvDFG9Z+/0i2QGlHw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qqe2E22X6jDQgoVwzUmJebscD37dcHOdWx8kFcGOrDy3UEJoYOf/ocn+zb39T19xBhpMDEA78FPEyrr/T0zk4Ew4fgKVjWt2lPM/4afK/lG16IuTXKzvM2K1B2PU3RJ8QiTlrRUpUaDGiy6Hu0TQk9HXPm8/2r//HDJnU1LIzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJTucdHk; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJTucdHk"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e292d801e59so1117577276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684263; x=1729289063; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEuXgYPl/U2CWZEkVhwuy5Ym3mV6u0SmGmtbuxgYEPQ=;
        b=qJTucdHkSK+rA15RY+1hLCb+2K3FCdQg2+bKyzEwIsLOoa9qaHcZBbDiA6kyWDwEKN
         GrE11786stb5BbtQw3gOfebvLVw/SRxml092R2oE5EhAyOXy3+bCHFeeyIRCFOd0zIfT
         Xif5jJss8UjTZeR+W0Tot43+5zmT67VXgEyYqBMQ1Pp9/9yMpzDjoQbkYl1+uLwVqlR8
         3mOCPl+H5Dcx87jbhzEJPdueS8YbVGCZ41xxortNBvavpIGqUGarCnnNrKNxVeZ//e0Z
         /gVWV+0+LpgN+VzftBMAMe3aBZWQk/qRpqn2vw8ScDFRtYYO4UCvsaA9YPvu6uV46/1B
         TJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684263; x=1729289063;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEuXgYPl/U2CWZEkVhwuy5Ym3mV6u0SmGmtbuxgYEPQ=;
        b=IF9alOrVE2W6fH4jjRh4ZCgOX6kvQMiRl8sPnpLirt8vp9Yuq2p2jk2z5B2t/EhyR2
         lj1GUndRsb7Wsgcahps+iswBYqSdoQJUUFJbnYowofbX/l6iLiodAvGxXGu6dZR64FSv
         y/1NBpd4qYxr6Fdy6gBEx43UfUstB0sc2r/q6FHTWfqDfcUb06fUqg5pmmPd49B1tQ49
         f4vWRiQyffcn6h2jyZgbURKzkfDPWZZMXc3eRIcmQRfNuAxCysYmwpPNTQ67sSA7T8/a
         cw38RtDEe1dP/XnneXOY8HFm3WQ0k4wVR8FiO+GO2Npbrgc6iVeLdscZLOgt4Qy+gn93
         0neg==
X-Forwarded-Encrypted: i=1; AJvYcCUkJeUIf5GIZ8tX7Y7mmTWF9+1IWMsa4uVnS1FwcKxQBTPTaz/fMz9K46NHcwTuKUtGujFH50q/HKBA07lZjKTJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbvxEl1OvjO+/mBlJMgiu4dM3gYgxxJVV5g0UWEjxzoGUVSv2
	vzDXOSobUvJVjNvDNtjeLr6PdEAN24FbCvIb0XeHGCQeX8m5wq0zBMNCZ0/pzbuW9BaFJYsuplN
	+VDTSKA==
X-Google-Smtp-Source: AGHT+IH9THODVVrpmCzbhLdv1fo6+IgLR2Fi1CErXBsI9e05aQFfRTQnK3sstlhPsF5ZWof0Cx+x1vnPEWw3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a25:c593:0:b0:e28:ede2:d060 with SMTP id
 3f1490d57ef6-e2919dd2c51mr2727276.4.1728684262837; Fri, 11 Oct 2024 15:04:22
 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:54 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 8/8] perf test: Make parallel testing the default
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
index ba3797521d79..09afe884a987 100644
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
 
@@ -626,19 +626,12 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
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
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
@@ -669,8 +662,6 @@ int cmd_test(int argc, const char **argv)
 
 	if (dont_fork)
 		sequential = true;
-	else if (parallel)
-		sequential = false;
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-- 
2.47.0.rc1.288.g06298d1525-goog


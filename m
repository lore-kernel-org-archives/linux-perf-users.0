Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBE21767A
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884095; cv=none; b=KtgNIBtlLDKhfLhqw16H553RYoGCU0j/ARD0aHYm2PneAtSOJMne7vaIVaDfqe0OYNOI4wTmmXTmAWUtJJarl9tSJ/Fhxskbr38hkEy1cpbd0lg6kiqfX9dPH0DiESEi2WFu/Lr41SxHO8/rNuuoJcYSS1LZqjCN1Snfir9kZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884095; c=relaxed/simple;
	bh=M0R3zHDAes8blHNNb56eB/dYrJt3dM5C0cEG6y4au10=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ByxKuPbg+ZoiQP5pUHEPJaWaY7YPjgZZgK3CAcg9X5lB4YxbliA5bM2qTsJ1xLmWpu7bOuJ4Do09peQRMcLM9/DWrwlOLSSg/hyGBpJAvKXS5UvGC6cTm1Q/g+SXe8oH/vaJRJw56AlAKwcXvVhCmdIl+ntHiFC6SMryK9cmSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhxcI1uS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhxcI1uS"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30859e1580so477260276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884092; x=1730488892; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2We4CvxKfLkecfrv/oDL8pHcCSPB/kc+5ogezpwpnuw=;
        b=BhxcI1uS+vhJyb81zgOgyRIi4fp23e5Vr811vV0JtcQ1HmeXjPDdRJRvCEq+iMVA02
         Dg+xPo3x/QHmfMvDeKbXne+46Hl8OZs3rJ4LWWwh0zP3lsG57Je6TWoAPgEA8By4T6n2
         sJ4mL/TmnPe71QLCP15adnhE0v04bwbf7TMNsp5lGhBBkk5NQ56eHhj0qbXyVDuAT4Pl
         Rbr1HWWUZaNAh2YuVJBun+pchjfH7VkFtT8fnmEX0Ah/mXb+11PTI/gGzyn+e1YzFTYs
         LdQy7nd995to4VIBYUpjWrAdDuJiwRQXhBZIOSazyY+Dy03OSw5ysR4vOwiqZWdv1ptP
         3yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884092; x=1730488892;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2We4CvxKfLkecfrv/oDL8pHcCSPB/kc+5ogezpwpnuw=;
        b=oP9B91YGgDZn+KVUkp/p6L8XtZl2O8D5JwcVqSuaVGlNprwRXQuv8vdPzqHN/Lqt6z
         QCdMshITG+5IJbWgPylZQNe/QIEuMvN5Lwhz9a/XXFa1X2UjS5IiqDMaXy4HK5sdp3yE
         eTqbuo2v4wmibp5m3WthgXwh0K0k2s1PaptREP78Tk17wHGSL/GL/SZpKGrBLvqrscXh
         syVLqRQgt6ED2i6AQd9pAtISzb8bl733Fjl2Pul3JhB5ntNZBb1/Sfclxr04p8DC6EF9
         p8dmkLJ+MAyx3Y431E0El27lvUS477w/Lbf2NsFIXmW5I5VExE8S+1hFy5DBIvPZwvNk
         wakQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT3ejckHMDrY38UeYGk61YoDdusIUVsKlle/VveKgXDAl8UXk/aXOUwSAGW74gzVJOoGEwm+4sV/lUW7ueqrLE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BPDb65IY83m39zEv6EVyf1Im/vfDR+KtJT8ZTtV9gxG86BUR
	/+RMLmUKOxVQPg82cSQtHUldjpiW/msWyipgcletsqYsGPdkkf/g7XGy+gHp+S8GdRSAK2uk5/x
	8CrCucw==
X-Google-Smtp-Source: AGHT+IGJEHY3lpv9skwMpXCghaw8mJEpvCc8FiYb+27sBIOY4jXADQLseKXwEZ5QTsnNU11tYSiM5O7qKwV7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:6902:686:b0:e28:ef6f:3624 with SMTP id
 3f1490d57ef6-e3087b82cecmr276276.5.1729884092472; Fri, 25 Oct 2024 12:21:32
 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:07 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 08/10] perf test: Make parallel testing the default
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


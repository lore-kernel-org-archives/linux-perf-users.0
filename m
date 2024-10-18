Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FD188901
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230469; cv=none; b=uwnrm6v0MzuOVmAkj4QGHjAh96AcbU5T4gJcsbt8/hVTrs2vgRvP9HdSiUKdfE3IB0AJOs/OYFZc+3xLPksLNPreSz1YWHvKRs7DTqqpTvP7XBArneGkC5U6grOs86rwWzx2HTXr6cS1qYX/iBqD4PtUoRkQnLY0E79rQpo+5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230469; c=relaxed/simple;
	bh=NyBi4ldcotgRIWXy+pyJqk7L/008dIgRW+IaUmHndKE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aaWLMK+YQtmrgArB5zZV6Qs37/4dD0Ik5ULxcvuLfqMbxCJiXOJLl/4JaeiVTu4pqK/4oy3wv/ywPVBsMB1oMqX0Ylp/3TugxFL0FyeEPK9nDKXVkDQxUQ6xniirctbI7rZ7Rj7ygM2k/a5w7hpkqJT0o/D5HoQzvHzGFer6+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czd6LNOg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czd6LNOg"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so39353697b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230467; x=1729835267; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRFmLYGgcJHBSD8LI17iLRO0wZ/dUkGCXCceddIu4Nc=;
        b=czd6LNOgd2AiALcqvDeRRgjrPDTaeqk3BWv31pOzU9R9x11JG+6XIUPmdUKrb2935r
         /5o3MhbN+X2bjOhKybfhjbeLIUaEXkcvUusY616c2/rSc1/BH0MaBevEdqC9Sc27oAzO
         3k1hMozzdDd6c14jm28bzmZUwQRQZmd6TH8tqlC3xrClvDgD9xZN2/Z4yte/yx2NI85e
         iFEykiMcHt1UJDFcndsBdlBNoesX1JC+I6QJyIQZhtGvxjY9PQ/aWBz+8WqzFqd8DGdB
         smNW8AAT/r1IHWTa3Jg6di5ybV1kcKhcfhgMD/jPjS25cvj9lWZzH/GrE3PkPL0RmH0G
         0ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230467; x=1729835267;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRFmLYGgcJHBSD8LI17iLRO0wZ/dUkGCXCceddIu4Nc=;
        b=JArG4g0RfzjjktagcxwKVuU7IVR3SGMokPvSmaHZsrePgMrZztJzSOSl/8BEIOP27N
         Cedbrtv5ih3fc7c8mW6OUmm33aWiOerBnZX79Np3MvcTXl4hniIx8waVB19kz1zewS8/
         J5xQMd0qp9ciCHborIKOBHAYS3KD+A8ZTVez75TxZzRxKaIrRS0r+idOuvvYs6jeSs88
         KSvLlGlhwVKtME0hzJH41932LOAHGYm+vv8m/udifoDTH5ITKHd+YUoNLyUlRfRpeuxL
         jd95aV6NKtPIqFXRhGXP034+2k7PE4tJWoYX0Xfoqod0WAtzeXCfFXdtAmJD6BgsAfCP
         rL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4jG9Fiv8xwAr+xplMfeX2UYvasb0C4XmlE9g3hQozvlSx4C4T3AWVQcWdz8UB3+HEZeabzwwKFO1swZX5ZiMd@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYOIBZs+XH6nhbrQEH1Bttbv+/DIMpVAG2IAmh//IDO2Y3Yfj
	2wRB9eO/gs9QOCkLlUA8tMe9LWlxLcUVXMpIdfhQpzLtrDtklsPrxKsBJ5Y9p+etEb8SMqTZRJf
	/PmaCFQ==
X-Google-Smtp-Source: AGHT+IFKrEsf9oi8iVB/8vbj394g4OdfsAGDRVko5LPfw+EWI4ka0AKsPwGUvXWJfCgWkVrCA2e+ufqmm8lm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a05:690c:640b:b0:6e3:b93:3ae2 with SMTP id
 00721157ae682-6e5bfbd5bf7mr108587b3.1.1729230466217; Thu, 17 Oct 2024
 22:47:46 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:18 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 8/9] perf test: Make parallel testing the default
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
index 258dd97c122b..78ff7862845a 100644
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
 
@@ -627,19 +627,12 @@ int cmd_test(int argc, const char **argv)
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
@@ -670,8 +663,6 @@ int cmd_test(int argc, const char **argv)
 
 	if (dont_fork)
 		sequential = true;
-	else if (parallel)
-		sequential = false;
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-- 
2.47.0.105.g07ac214952-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65452198A0F;
	Fri, 11 Oct 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666915; cv=none; b=A/9qN3c9rowhIrRw2gJj3zmRsstvd1FJQzVb2dTYhbCBKCsFF4FIJi70QwRL69QGvjxtkIrgMgVrfeBYh5BnA21KnLUXVEmOzzpVxRvEwg9ik30w0nw2QV+NJGO3fbtwSZQunnsf8FLXIHwyOEYxHVw0fb9u9llsDt0uQb7RYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666915; c=relaxed/simple;
	bh=CVF9Dlqb+HtbklOe8N7XqFOa2lO2QJAFF865A1Pp8kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWs4s3397pWMUnPiQ3f86CZFYy8zdkUS4dOfNl5Zav8sQvQXuwMJUDgNJjzxnoqrxh02tHwRwRKKjFnugC/9UOxeQdznJHuzYYEjLZyTOyO+KCXsJitXhb8jBkGIhzoON0Sodi2XV7SJOmfWQE3lNQFfFOPNJ92Wav8iWod6C9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ3I2FLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ3I2FLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27001C4CED0;
	Fri, 11 Oct 2024 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666914;
	bh=CVF9Dlqb+HtbklOe8N7XqFOa2lO2QJAFF865A1Pp8kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJ3I2FLjs9eAoif5ThpjwKJQp1XYa+8xW2LE8IK1Iru1LR0wJXwH8FAw1ByZpaRtW
	 DuzEEkKvojayHd/yOwzp9XRT40xXSYrN0rYjJdZb+PoXB1RqbMYdQl3FPaJV9xn6UY
	 jssq3YCAaVQH6rSgRa2w+4G4tXRVCdfH+in2b3xxX+nJTUODhi6mZppyAmeIBa/6de
	 qrX0jbdmQGRmkiS9prwdCKVqFSS9WFJPwv+LCZIBoh2HfMBDEneB5VQgsnSajnH1W+
	 RoBsupeWeS98jRkqkxS+Zg/6vBkOEpyE2tNJujOjD4w5yxQc+S4vJpTxsKVHumRbpL
	 m+aYZLyTawixg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 3/3] perf test: Document the -w/--workload option
Date: Fri, 11 Oct 2024 14:14:49 -0300
Message-ID: <20241011171449.1362979-4-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011171449.1362979-1-acme@kernel.org>
References: <20241011171449.1362979-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Wasn't documented so far, mention that it is mostly used in the shell
regression tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-test.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 9acb8d1f658890e9..62ce705d365f0442 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -48,3 +48,17 @@ OPTIONS
 
 --dso::
 	Specify a DSO for the "Symbols" test.
+
+-w::
+--workload=::
+	Run a built-in workload, to list them use '-w --list', current ones include:
+	noploop, thloop, leafloop, sqrtloop, brstack, datasym and landlock.
+
+	Used with the shell script regression tests.
+
+	Some accept an extra parameter:
+
+		seconds: leafloop, noploop, sqrtloop, thloop
+		nrloops: brstack
+
+	The datasym and landlock workloads don't accept any.
-- 
2.47.0


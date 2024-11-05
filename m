Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81E1D2716;
	Tue,  5 Nov 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816796; cv=none; b=uHivL9KFIQLkthTC2d/6uPnam+kvLzGxWxGpdDcUNZqt61hl6X0Bs60E91dS4klBliWvAzVOAvnIGgS8L6sKaxvtQq2zCiBccAIgMaccX6k+n31XBtk3iR0aY5VcpPwtGkmQypmQfb8zHQ70kxLehEUQPw6ylz1sCz64nWkhYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816796; c=relaxed/simple;
	bh=9Qx32ibOQahsytcxZpIWtr7v9jYW23YEBF9AKP4Z5Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV08Hvz7L0fBbK56wFNGHdj7Cr14Wf0ejMHwWZTvNCFmm5+9NEoX3RFpveoCR1+cwe6JpFr1isb8oUOuV3maVebyBqS9hVNGx9egWtr5qdxLp7kp3g+Lu/uEei8bBpsk3qWMroaWlWoIU4DPgirC815i4Ybqy2ZD+2S31MqMH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY429oE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY429oE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACE2C4CED0;
	Tue,  5 Nov 2024 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816796;
	bh=9Qx32ibOQahsytcxZpIWtr7v9jYW23YEBF9AKP4Z5Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oY429oE8SG/SzY+hMqjar89Z2Vma/ZAEZfVGQU4aTOLDomZ/+Qa6a1Ya/MqOCcG8x
	 qiIrIn/dCh2XlfP+gYAxv27ZlWpPSrz38cr9yoLCd0eDJyW+ZK2uv88zWZn6Dg+e9y
	 CMggM6wabGt9xkg3Kl579HyJ+dMRI5DPX9/ETkBONQoMp+oU2SJZxn4qr6pEpliDEL
	 QBWH3+taEWv7TPj7oycMVTDF2A3QeIc5a8jcPrXQxObG+gwEOcU7qhsv7uJsQEpRav
	 ygVkDQ8fJ3dbhgFN+PyiB1U2LUhNrbwknzwWk7XDX6LUwO1sDGLMxVTXuK0Zzx4xDR
	 BJm44mg9dQurg==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: [PATCH v2 1/4] perf test python: Robustify the 'perf test python' test case
Date: Tue,  5 Nov 2024 11:26:13 -0300
Message-ID: <20241105142616.761042-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105142616.761042-1-acme@kernel.org>
References: <20241105142616.761042-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Even without any python binding or support for loading it present in
perf, the 'import perf' 'perf test' says that testing that feature
somehow "passes":

  $ strace -s1024 -f -e execve perf test 17
  execve("/home/acme/bin/perf", ["perf", "test", "17"], 0x7ffe99ae5d50 /* 38 vars */) = 0
  strace: Process 519319 attached
   17: 'import perf' in python                                         : Running (1 active)
  strace: Process 519320 attached
  [pid 519320] execve("/bin/sh", ["sh", "-c", "--", "echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |  2> /dev/null"], 0x377ba9a0 /* 40 vars */) = 0
  strace: Process 519321 attached
  strace: Process 519322 attached
<SNIP>
   17: 'import perf' in python                                         : Ok
  +++ exited with 0 +++
  $

It doesn't matter if we fork a new perf process to run just that test
entry or if we don't (using -F).

The system() call (that execve) will return zero even with that echo
being piped into nothing:

  # sh -c -- echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |  2> /dev/null
  -bash: syntax error near unexpected token `0,'
  # echo $?
  2
  #

If we instead avoid the echo and use 'python -c' to pass that simple
python script just trying to load the non-existent perf binding we get
less processes and a more consistent result even in this pathological
case where PYTHON="":

  $ perf test 17
   17: 'import perf' in python                                         : FAILED!
  $ perf test -F 17
   17: 'import perf' in python                                         : FAILED!
  $
  $ perf test -vv 17
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
   17: 'import perf' in python:
  --- start ---
  test child forked, pid 522859
  python usage test: " -c "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" "
  sh: line 1: -c: command not found
  ---- end(-1) ----
   17: 'import perf' in python                                         : FAILED!
  $

The next patch will sidestep all this by plain not building the python
binding test when the binding isn't built, i.e. with NO_LIBPYTHON=1.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/python-use.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 0ebc22ac8d5b47ed..b7325caad22bab10 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -14,8 +14,8 @@ static int test__python_use(struct test_suite *test __maybe_unused, int subtest
 	char *cmd;
 	int ret;
 
-	if (asprintf(&cmd, "echo \"import sys ; sys.path.insert(0, '%s'); import perf\" | %s %s",
-		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
+	if (asprintf(&cmd, "%s -c \"import sys ; sys.path.insert(0, '%s'); import perf\" %s",
+		     PYTHON, PYTHONPATH, verbose > 0 ? "" : "2> /dev/null") < 0)
 		return -1;
 
 	pr_debug("python usage test: \"%s\"\n", cmd);
-- 
2.47.0


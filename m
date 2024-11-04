Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02198224F0;
	Mon,  4 Nov 2024 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743212; cv=none; b=Fd9uA2ry221H76OxCsIl7C+I4IP1roXdB4VXACSXOcDIJayQ2HsHnAne0jyW0VfkAF/P6Vvi7nprwFDjzLOWjlWLKAe3cxuB+m5mK+EO5EbZ68Snbwne8pvV3gyyeHGEqwuz7LnUHmx4LFEB165PWwQSLaWjH+b8t2FAiD7oXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743212; c=relaxed/simple;
	bh=Fxu93FpW7yH4xNEj1+55fYSFb+Dsm9yIclT6WJXEnvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeUoeCBV8iA0Bw32kR4nDRuI8owMPRUFJNswDw8jCzWHybcy/aoHi6XoOuzbPkQTcD5VlVLrEGVfhNW4gbiuqJn60kTcnUcmGnLp/aVc9FgRALSuWoM/NByOl9H7j0/7X2mLzICe4BTxfIMfkUUTYDNbwViL72mRlyM1iACC4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvcsAwY0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvcsAwY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C7FC4CED1;
	Mon,  4 Nov 2024 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743211;
	bh=Fxu93FpW7yH4xNEj1+55fYSFb+Dsm9yIclT6WJXEnvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvcsAwY0ooF1J4DDoxGphzcXqIhDZaXjgUFb95qPwEQxiFtsK0WhhJUZIeOCcgwZZ
	 iGsB9ru2AEBN3oipqxzRkg+1R1olKPSvnQ855egW+/TpPC1OS7AtWgnGLnCEgwZKVi
	 8ajlOJCKCgg7Qg63VSHIpPSRkKK7uBJ5io17ZLs6IuO9jk4857gh/GsABMMPP6hOCW
	 43uxGW0kcUUolTBiSwuPiFvhniVcmbHJFaqgkqnUS8q5eqpJQuo4NOSBb7pkbyOiZw
	 q0j1B7mZwl+Ma7hjfb8Uu8+I3zAq4PReTzyoUZoFevoo/hhLqa3gdrZfRK+Fiw9uCK
	 hgAflmfA3P8lw==
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
Subject: [PATCH 1/2] perf test python: Robustify the 'perf test python' test case
Date: Mon,  4 Nov 2024 14:59:52 -0300
Message-ID: <20241104175953.535202-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104175953.535202-1-acme@kernel.org>
References: <20241104175953.535202-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

While working on a patch to not build the 'perf test' entry that tests
the python binding when NO_LIBPYTHON=1 is used when building perf,
meaning that the python binding will not be built, thus no need to test
it, I noticed this inconsistency:

  $ perf test 17
   17: 'import perf' in python                                         : Ok
  $ perf test -F 17
   17: 'import perf' in python                                         : Ok
  $
  $ perf check feature libpython
               libpython: [ OFF ]  # HAVE_LIBPYTHON_SUPPORT
  $ ldd ~/bin/perf | grep python
  $

Even without any python binding or support for loading it present in
perf, it says that testing that feature somehow "passes":

  $ strace -s1024 -f -e execve perf test 17
  execve("/home/acme/bin/perf", ["perf", "test", "17"], 0x7ffe99ae5d50 /* 38 vars */) = 0
  strace: Process 519319 attached
   17: 'import perf' in python                                         : Running (1 active)
  strace: Process 519320 attached
  [pid 519320] execve("/bin/sh", ["sh", "-c", "--", "echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |  2> /dev/null"], 0x377ba9a0 /* 40 vars */) = 0
  strace: Process 519321 attached
  strace: Process 519322 attached
  [pid 519321] +++ exited with 0 +++
  [pid 519322] +++ exited with 0 +++
  [pid 519320] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=519321, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
  [pid 519320] +++ exited with 0 +++
  [pid 519319] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=519320, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
  [pid 519319] +++ exited with 0 +++
   17: 'import perf' in python                                         : Ok
  +++ exited with 0 +++
  $

It doesn't matter if we fork a new perf process to run just that test
entry or if we don't:

  $ perf test -h -F

   Usage: perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]

      -F, --dont-fork       Do not fork for testcase
  $

  $ strace -s1024 -f -e execve perf test -F 17
  execve("/home/acme/bin/perf", ["perf", "test", "-F", "17"], 0x7ffda8fafed8 /* 38 vars */) = 0
  strace: Process 519336 attached
  [pid 519336] execve("/bin/sh", ["sh", "-c", "--", "echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |  2> /dev/null"], 0x159d99a0 /* 40 vars */) = 0
  strace: Process 519337 attached
  strace: Process 519338 attached
  [pid 519337] +++ exited with 0 +++
  [pid 519338] +++ exited with 0 +++
  [pid 519336] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=519337, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
  [pid 519336] +++ exited with 0 +++
  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=519336, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
   17: 'import perf' in python                                         : Ok
  +++ exited with 0 +++
  $

The system() call (that execve) will return zero even with that echo
being piped into nothing:

  # sh -c -- echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |  2> /dev/null
  -bash: syntax error near unexpected token `0,'
  # echo $?
  2
  # sh -c -- echo \"import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf\" |
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


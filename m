Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566881D2716;
	Tue,  5 Nov 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816789; cv=none; b=PwawziCI0x0/JY1yEEvjKrU1j0YreHHzTmCKqgib/mvQU7rUpZKyygBTlo2tFdME4HD4BHaSnIvXkA60cYuAA/Cn5Wb1MLmqZ6zumWMykUV+6AQGOTz1DsXvtIm0zNc0NG2WXfS3ZqyFcRCCQs65qa1jyU/3Xf4OqMypSS/Wru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816789; c=relaxed/simple;
	bh=d7rXzUbVAgba3BtlPKq/MgQUjhkS/4L0KrjmRUIsuPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZWix92zHiKfKRxptnK25o2m/HZ+MIXMhipzC3CMj8F46wN2h21lVuBlRbkCO4tbNFV0O6Mj2ic7Q0BadqYSgZh38NqubXDQdQXEyC8ZoqRFdsbkOteqjl4d6zFgI74ktFsYk36cZplRO0R1UQiZtTxYJi7Z7XRYoOO8OWqqywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbS+ZMJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbS+ZMJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC6EC4CECF;
	Tue,  5 Nov 2024 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816788;
	bh=d7rXzUbVAgba3BtlPKq/MgQUjhkS/4L0KrjmRUIsuPw=;
	h=From:To:Cc:Subject:Date:From;
	b=VbS+ZMJKoAvvEPVZ8qgHAgyz4GMg4XQUx+5RhSyhhTRrAWkau+Tjo4luy9q87g1BC
	 r7xAt0eQ1RZNCGJayswrSK5IodSCVAEb6Ftu2yAnjzzC7OQ3LaqhzYY1+/TPS+PHb7
	 mpaskduUVgVrcMnHoKzs/KdFe9a3WW55VHRf+yQ1kgYmbu4TXAhgLUCUbgDfDlumOc
	 tCAbt/LcWKWHOdFK/Hn1qVkHwV6RAYeJXAv2MopC03+2wM1QnsaqkFU/z+T0u/DVP8
	 OzPu5/yQopMprLNXtteRB/0QQd+s7q5EyBZzD5USEOXgUaTA77OC7VGTO1qFeBXWj4
	 7PNgkyyEEbAZg==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: [PATCH v2 perf-tools-next 0/4] 'perf test' fixes/improvements
Date: Tue,  5 Nov 2024 11:26:12 -0300
Message-ID: <20241105142616.761042-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

        While evaluating what is needed for having shell tests that test
python functionality conditionally, i.e. so that we don't try to test
the python binding if NO_LIBPYTHON=1 is used, I stumbled into these
problems.

        The first patch its more for documenting that strange system()
behaviour and to check if this was something that would have
implications in other 'perf test' cases besides this python one, maybe
somebody will spot the problem, but at least it seems more compact now
using 'python -c inline-python-source'.

v2:

- Don't suppress the python binding test, instead skip it and tell the
  reason: the binding isn't available.

- Treat NO_LIBTRACEVENT=1 like NO_LIBPYTHON=1, not suppressing tests, just
  skipping them, warn the user on explicit suppression of the library.

- Also reduce a patch description verbosity, as noted by Ian.

- Arnaldo

Arnaldo Carvalho de Melo (4):
  perf test python: Robustify the 'perf test python' test case
  perf test: Skip the python binding builtin test case with NO_LIBPYTHON=1
  perf test: Don't suppress the libtraceevent tests, skip them
  perf build: Emit a warning when libtraceevent is explicitely disabled

 tools/perf/Makefile.config                  |  4 +++-
 tools/perf/tests/Build                      | 12 +++++-----
 tools/perf/tests/builtin-test.c             |  6 -----
 tools/perf/tests/evsel-tp-sched.c           | 16 +++++++++++--
 tools/perf/tests/mmap-basic.c               | 26 +++++++++++++++++++--
 tools/perf/tests/openat-syscall-all-cpus.c  | 11 ++++++++-
 tools/perf/tests/openat-syscall-tp-fields.c | 11 ++++++++-
 tools/perf/tests/openat-syscall.c           | 11 ++++++++-
 tools/perf/tests/python-use.c               | 24 ++++++++++++++++---
 tools/perf/tests/switch-tracking.c          | 23 +++++++++++++++++-
 10 files changed, 120 insertions(+), 24 deletions(-)

-- 
2.47.0


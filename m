Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596816F907;
	Fri, 21 Jun 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008642; cv=none; b=T6mdvpaJCh9YjKWvjy5KgXTSOg7m3Df4sN7mnoAB3TGxbeutrtMjpJ5amylgVZbkTYFNA1ad4HJ9/drvKWLut6R36CXxP46fHvSLRXc6yvwinCBe+gIUqS7WRVPlyXVvoe0cV8V1ZU8sXoKEf+4mn0vH/jxhF4BHnCQYilqyjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008642; c=relaxed/simple;
	bh=atSs/tRSRRAIPe/BSsP+YIRgCS9mtgue7bFyinAh7kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDtf53IPoFl2aGIvjLoTW+CpKceB4afAkKucs5WZctRolzHacSSSI8+QO5PcVdzdlAcqs+kPTeQg2theBIyzRo41oDxvjZwnHFQegmeew7MDrIpVDWuzlBtTyFrtm0l0caS/ipledFi2VXtzph2Wbx+n+A5iTE3s7PHz4e2WPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi/ROPRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi/ROPRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1209CC4AF0C;
	Fri, 21 Jun 2024 22:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719008642;
	bh=atSs/tRSRRAIPe/BSsP+YIRgCS9mtgue7bFyinAh7kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oi/ROPRIQ6aaqy3ukSpzi+iy26Z3fMt4gV5N+sh2qtcqGMg+iXME3OE4221mSkFD1
	 Vi5DF5vnX0XfIhZPzQWazmN4/Cj3rABdaax6dM5ON0CvQWSWgXMRVgtFjq1lJApuQJ
	 gzb3RNiEK+7T+63SWdhrAQoVCoOgBYnHQFlMgTDLOKgCm+s+1MBLRqO+KmJdzjYt5P
	 mrHYLM7fMZe4OcPuQ8DZKDGDUqyLZ6P/4Fno+TgQ4s+rJo+IVlphLDKFkrEZ5qWExz
	 d9JMF+yBLcgfieuTcB6Qr1Dsye4nYkRpuGoq78NyxRvR+UO+Cej9LhiRBT6ZvxB2mu
	 U3JOyN9y1kXyA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 8/8] perf test: Update sample filtering test
Date: Fri, 21 Jun 2024 15:23:57 -0700
Message-ID: <20240621222357.717374-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621222357.717374-1-namhyung@kernel.org>
References: <20240621222357.717374-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now it can run the BPF filtering test with normal user if the BPF
objects are pinned by 'sudo perf record --setup-filter pin'.  Let's
update the test case to verify the behavior.  It'll skip the test if the
filter check is failed from a normal user, but it shows a message how to
set up the filters.

First, run the test as a normal user and it fails.

  $ perf test -vv filtering
   95: perf record sample filtering (by BPF) tests:
  --- start ---
  test child forked, pid 425677
  Checking BPF-filter privilege
  try 'sudo perf record --setup-filter pin' first.       <<<--- here
  bpf-filter test [Skipped permission]
  ---- end(-2) ----
   95: perf record sample filtering (by BPF) tests                     : Skip

According to the message, run the perf record command to pin the BPF
objects.

  $ sudo perf record --setup-filter pin

And re-run the test as a normal user.

  $ perf test -vv filtering
   95: perf record sample filtering (by BPF) tests:
  --- start ---
  test child forked, pid 424486
  Checking BPF-filter privilege
  Basic bpf-filter test
  Basic bpf-filter test [Success]
  Failing bpf-filter test
  Error: task-clock event does not have PERF_SAMPLE_CPU
  Failing bpf-filter test [Success]
  Group bpf-filter test
  Error: task-clock event does not have PERF_SAMPLE_CPU
  Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
  Group bpf-filter test [Success]
  ---- end(0) ----
   95: perf record sample filtering (by BPF) tests                     : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_bpf_filter.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 31c593966e8c..c5882d620db7 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -22,15 +22,16 @@ trap trap_cleanup EXIT TERM INT
 test_bpf_filter_priv() {
   echo "Checking BPF-filter privilege"
 
-  if [ "$(id -u)" != 0 ]
-  then
-    echo "bpf-filter test [Skipped permission]"
-    err=2
-    return
-  fi
   if ! perf record -e task-clock --filter 'period > 1' \
 	  -o /dev/null --quiet true 2>&1
   then
+    if [ "$(id -u)" != 0 ]
+    then
+      echo "try 'sudo perf record --setup-filter pin' first."
+      echo "bpf-filter test [Skipped permission]"
+      err=2
+      return
+    fi
     echo "bpf-filter test [Skipped missing BPF support]"
     err=2
     return
-- 
2.45.2.741.gdbec12cfda-goog


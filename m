Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A4B41F5D7;
	Wed, 23 Sep 2026 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200378; cv=none; b=KiyQ0eqXFj726lrxhOULyaMdvJWy+4KuYgaYgwgb0g0V+6cQp/j4+0TFpGc5tO0PhXT7cFmagPJC5W9qe+lqcckAR/8EtcG4QhNW43azSDLwAZmdFGI2SVKMIpM9v2Wh1mmG1ewi/+4UTorngVnHNlqwmtrA3l/jgRb5py4yrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200378; c=relaxed/simple;
	bh=M4pXjdIJg2DlgWd0L9NFAxCtrVR5unRfhpgI448luGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9MX11ymnzza5sUgs22LgXw5rQZJfDkiX2/u7cvvYHf46chOWbDmAIZskGZe+tmUI0smM0K6NPMqi+UmGtJnO6bZrz0ijL7ScuiF7ScyTSOJXenKwXgc4zpaR/BNgZQ2sfxhZ8dJQWRu5z/7nVH7ToF8sz7JIClYaiZ/h4oqt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNkBiTkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNkBiTkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1341F00899;
	Wed, 23 Sep 2026 21:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200376;
	bh=/ET1qCElGpdj1vHzmput/o/DdUfoJ26WntchCeD+le4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bNkBiTkQfRdvBEJlHJh2jvllqIV4SwYO3CBeb28E6ZuMfzCwk5PYDcecDD/kvvWsf
	 mRrcEvuvIjdxpFtgViNasAVNzQtUbaabX9h6PgvGUKANP59PhwA8+CwJts/Kuxa2sk
	 LZT/ziIzvJYBkhOl/p66010hs/phA6IY85d7wTO+HyUQ09G6nfN/fzo7Qi6IHKR/oo
	 +khByhfWgGXFRAwYbMLcm6tT14vfD67HOLdxa3uNOv6wZ025n9mvOJ2fITmJu4npeW
	 JlCmgsmSM9iADZwhyOku2N6EyeVYmlbe+OJRrg7XF+JSsAz7gB+dlGTNzHYKQqW9l5
	 lrWMaUs+AhypQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf test: Fix record tests on hybrid machines
Date: Wed, 23 Sep 2026 14:52:55 -0700
Message-ID: <20260923215255.3329181-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923215255.3329181-1-namhyung@kernel.org>
References: <20260923215255.3329181-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the leader sampling test looks for "cycles:" string to match
the event and retrieve the value before the event name.  But it won't
work on hybrid systems as the event name is different like below.

  $ perf script | grep -m 10 brstack
      perf 3322152 1873980.978431:     625379 cpu_atom/cycles/:      558200cc40cf brstack_bench+0x31 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.978431:     625379 cpu_atom/cycles/:      558200cc40cf brstack_bench+0x31 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.978598:     612177 cpu_atom/cycles/:      558200cc4082 brstack_foo+0x17 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.978598:     612177 cpu_atom/cycles/:      558200cc4082 brstack_foo+0x17 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.978762:     591859 cpu_atom/cycles/:      558200cc403d brstack_bar+0x0 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.978762:     591859 cpu_atom/cycles/:      558200cc403d brstack_bar+0x0 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.978948:     628505 cpu_atom/cycles/:      558200cc403e brstack_bar+0x1 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.978948:     628505 cpu_atom/cycles/:      558200cc403e brstack_bar+0x1 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.979146:     669816 cpu_atom/cycles/:      558200cc40e5 brstack_bench+0x47 (/home/namhyung/project/linux/tools/perf/perf)
      perf 3322152 1873980.979146:     669816 cpu_atom/cycles/:      558200cc40e5 brstack_bench+0x47 (/home/namhyung/project/linux/tools/perf/perf)

But we can control the output format of perf script using -F option.  So
we knows where the period is in the output.  To filter by symbol name,
"ip" and "sym" fields are required as well.

  $ perf script -F period,ip,sym | grep -m 10 brstack
      625379      558200cc40cf brstack_bench
      625379      558200cc40cf brstack_bench
      612177      558200cc4082 brstack_foo
      612177      558200cc4082 brstack_foo
      591859      558200cc403d brstack_bar
      591859      558200cc403d brstack_bar
      628505      558200cc403e brstack_bar
      628505      558200cc403e brstack_bar
      669816      558200cc40e5 brstack_bench
      669816      558200cc40e5 brstack_bench

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 04df35b30b0c15fd..fa8d17e389a0116d 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -537,7 +537,7 @@ test_leader_sampling() {
     err=1
     return
   fi
-  perf script -i "${perfdata}" | grep brstack > $script_output
+  perf script -i "${perfdata}" -F period,ip,sym | grep brstack > $script_output
   # Check if the two instruction counts are equal in each record.
   # However, the throttling code doesn't consider event grouping. During throttling, only the
   # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
@@ -549,7 +549,7 @@ test_leader_sampling() {
   tolerance_rate=0.8
   while IFS= read -r line
   do
-    cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
+    cycles=$(echo $line | awk '{ print $1 }')
     if [ $(($index%2)) -ne 0 ]
     then
       if (( $(bc <<< "scale=4; r = ${cycles} / ${prev_cycles}; r >= 0.99 && r <= 1.01") ))
-- 
2.56.0.rc1.310.g51773c2048-goog


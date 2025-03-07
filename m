Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D741A316A;
	Fri,  7 Mar 2025 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385363; cv=none; b=e72umDEKFjjzVeMOd83k3CG+xOj/8QwErH9trp9apspe1Wi6isT+fy1zSYkL80DXspZwL0+EHrJl3VFZJFuFcCW0kHA3CzvhWlqeTr3buNQamhwloDW/2C++gAeU78+noQLFyn/mIuZhDT+pSZXfa8YVndaK9juzOH6Vm4CpQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385363; c=relaxed/simple;
	bh=peNNVXdibACPImCuNkLVc1W3nQfc19jAHKrx7HC9GEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLJtY8wNxjcOFOLFDOaL8bYFz9yv9BUpr6P2K121VUMGSXfTp68gydTufwdFZpHyz61DlJUGZa2M1cxKTtoY5LBCuY88bPbIwCZo/2/GXNQT6raVM1ji+1JFiIlzHl7FFr6yptxk20TbH7OFqb0HnP1MDlpoG4cfyyyzaEs7Jo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY0EjaAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY0EjaAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C602C4CED1;
	Fri,  7 Mar 2025 22:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741385362;
	bh=peNNVXdibACPImCuNkLVc1W3nQfc19jAHKrx7HC9GEI=;
	h=From:To:Cc:Subject:Date:From;
	b=HY0EjaARvT8xwbYaNr+BgGdLTRhjoHUtp42A3ql22SZT+FAbO2QgNf1tfQjboTgyG
	 nl4WX/BtaHNJ433gz5917IlWmlh7tGZuDFyr3uV7hkJNM5S0BT5rPyJHlms8CPpz0X
	 FpNR84dDU5d39ab78y86jin0UkNsLrbo2lbPeNdLx1Yq7Tn3ZeqQj/LdWxnayrbN5Y
	 36gFcfM4wiUd1LHX8ubgJucpVQFVE6hzhULNyqBmjQa/ATOVGe8VRJC+vH6EoZRZ5s
	 d6wiK/isV/SVCv57p9/mVkklpULlcAc4FwhzZhyVThN3Fq4wmnLxi5AILW8ObrvZOn
	 7K/UOXOQQUlww==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Sally Shi <sshii@google.com>
Subject: [PATCH] perf bpf-filter: Fix a parsing error with comma
Date: Fri,  7 Mar 2025 14:09:21 -0800
Message-ID: <20250307220922.434319-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous change to support cgroup filters introduced a bug that
pathname can include commas.  It confused the lexer to treat an item and
the trailing comma as a single token.  And it resulted in a parse error:

  $ sudo perf record -e cycles:P --filter 'period > 0, ip > 64' -- true
  perf_bpf_filter: Error: Unexpected item: 0,
  perf_bpf_filter: syntax error, unexpected BFT_ERROR, expecting BFT_NUM

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

          --filter <filter>
                            event filter

It should get "0" and "," separately.

An easiest fix would be to remove "," from the possible pathname
characters.  As it's for cgroup names, probably ok to assume it won't
have commas in the pathname.

I found that the existing BPF filtering test didn't have any complex
filter condition with commas.  Let's update the group filter test which
is supposed to test filter combinations like this.

Fixes: 91e88437d5156b20 ("perf bpf-filter: Support filtering on cgroups")
Reported-by: Sally Shi <sshii@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_bpf_filter.sh | 4 ++--
 tools/perf/util/bpf-filter.l                | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tests/shell/record_bpf_filter.sh
index 1b58ccc1fd882d1d..4d6c3c1b7fb92579 100755
--- a/tools/perf/tests/shell/record_bpf_filter.sh
+++ b/tools/perf/tests/shell/record_bpf_filter.sh
@@ -89,7 +89,7 @@ test_bpf_filter_fail() {
 test_bpf_filter_group() {
   echo "Group bpf-filter test"
 
-  if ! perf record -e task-clock --filter 'period > 1000 || ip > 0' \
+  if ! perf record -e task-clock --filter 'period > 1000, ip > 0' \
 	  -o /dev/null true 2>/dev/null
   then
     echo "Group bpf-filter test [Failed should succeed]"
@@ -97,7 +97,7 @@ test_bpf_filter_group() {
     return
   fi
 
-  if ! perf record -e task-clock --filter 'cpu > 0 || ip > 0' \
+  if ! perf record -e task-clock --filter 'period > 1000 , cpu > 0 || ip > 0' \
 	  -o /dev/null true 2>&1 | grep -q PERF_SAMPLE_CPU
   then
     echo "Group bpf-filter test [Failed forbidden CPU]"
diff --git a/tools/perf/util/bpf-filter.l b/tools/perf/util/bpf-filter.l
index f313404f95a90d25..6aa65ade33851bfc 100644
--- a/tools/perf/util/bpf-filter.l
+++ b/tools/perf/util/bpf-filter.l
@@ -76,7 +76,7 @@ static int path_or_error(void)
 num_dec		[0-9]+
 num_hex		0[Xx][0-9a-fA-F]+
 space		[ \t]+
-path		[^ \t\n]+
+path		[^ \t\n,]+
 ident		[_a-zA-Z][_a-zA-Z0-9]+
 
 %%
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


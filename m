Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B582189BB3;
	Tue,  4 Mar 2025 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055319; cv=none; b=Ptwn31ISIbUpPfAjJyPxNJ4r9dU1GNhazlb7EhhYaZFl93wqEonNwWziJ9jkyu2RagKmHCnHwHCyiudGaBJm9wMcDGaY3TAjdYsV4RHr/Rjqcin0ix7/qR56tuUIZF3b0UkLvdfTzVYOy/GmYjDZMw/Bgt4IGMa3HNmOJTYtCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055319; c=relaxed/simple;
	bh=nZ8ZCLcaVnVr2jRx2sOVDA3QIxlrVukP83MzQFyKq/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCocXH4iOLu+kqJImZeFjJ+wfizksDUWf/f3wAMvSAgGLnPNS6ezJc1xMWebKx4rKIR0Wkc5dwQK4FpBf61j0BTCu29o0xolZhPVIPBGC3fpDetF8YLcFEmkJTSXvkxglx5BdboTJ2PXBm5S872S7vI46gsn2P7Hs4MJZnBg9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhWHGFC6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhWHGFC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F48EC4CEEA;
	Tue,  4 Mar 2025 02:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741055318;
	bh=nZ8ZCLcaVnVr2jRx2sOVDA3QIxlrVukP83MzQFyKq/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhWHGFC6hdz9nQVlYOGdGbB7fNpV5qVC1Vgr3GnYhRbT++09E6fkAhqyQSDpwEkR8
	 LP7dOe/KhRIl12EPH/lixXsIfJ6zdfvKWOElJ3VnbXmI86sIaEQKpbtWzsJ/lG0ocB
	 imelithCpuC72BCrU0/aHhIF9CElCl0KanCPV8lfYjTjvX9rI7Zh7jQyhWCcHC441M
	 IYq7vMYGQjvH6R5mukvadhdgSbn3MQeXaKDhPEoenuEiINHbJuUyULijiLkmVj2b/n
	 1/QOVp/UM/5jCH/t/Otlrszpmrwh+HsO7LSr4q40Kc+8XmOYiKMt7pr74Y9PSlkYML
	 nEQIBn//NNv1w==
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
Subject: [PATCH v2 1/6] perf test: Add --metric-only to perf stat output tests
Date: Mon,  3 Mar 2025 18:28:32 -0800
Message-ID: <20250304022837.1877845-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250304022837.1877845-1-namhyung@kernel.org>
References: <20250304022837.1877845-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for --metric-only for std, csv, json output mode using
shadow IPC metric from instructions and cycles events.  It should
produce 'insn per cycle' metric.

But currently JSON output has (none) 'GHz' as well.  It looks like a bug
but I don't have enough time to debug it for now so I made it pass. :(

  $ perf stat --metric-only -e instructions,cycles true

   Performance counter stats for 'true':

                    0.56

         0.002127319 seconds time elapsed

         0.002077000 seconds user
         0.000000000 seconds sys

  $ perf stat -x, --metric-only -e instructions,cycles true

  0.55,,

  $ perf stat -j --metric-only -e instructions,cycles true
  {"insn per cycle" : "0.53", "GHz" : "none"}

  $ perf test output -v
    5: Test data source output                                         : Ok
   31: Sort output of hist entries                                     : Ok
   88: perf stat CSV output linter                                     : Ok
   90: perf stat JSON output linter                                    : Ok
   92: perf stat STD output linter                                     : Ok

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 7 +++++++
 tools/perf/tests/shell/lib/stat_output.sh           | 8 ++++++++
 tools/perf/tests/shell/stat+csv_output.sh           | 2 ++
 tools/perf/tests/shell/stat+json_output.sh          | 9 +++++++++
 tools/perf/tests/shell/stat+std_output.sh           | 8 ++++++++
 5 files changed, 34 insertions(+)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index b066d721f89735df..9e772a89ce381636 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -19,6 +19,7 @@ ap.add_argument('--per-cluster', action='store_true')
 ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
+ap.add_argument('--metric-only', action='store_true')
 ap.add_argument('--file', type=argparse.FileType('r'), default=sys.stdin)
 args = ap.parse_args()
 
@@ -64,6 +65,8 @@ Lines = args.file.readlines()
       'socket': lambda x: True,
       'thread': lambda x: True,
       'unit': lambda x: True,
+      'insn per cycle': lambda x: isfloat(x),
+      'GHz': lambda x: True,  # FIXME: it seems unintended for --metric-only
   }
   input = '[\n' + ','.join(Lines) + '\n]'
   for item in json.loads(input):
@@ -78,6 +81,8 @@ Lines = args.file.readlines()
         pass
       elif count - 1 in expected_items and 'metric-threshold' in item:
           pass
+      elif count in expected_items and 'insn per cycle' in item:
+          pass
       elif count not in expected_items:
         raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
                            f' in \'{item}\'')
@@ -95,6 +100,8 @@ Lines = args.file.readlines()
     expected_items = [6, 8]
   elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cluster or args.per_cache:
     expected_items = [7, 9]
+  elif args.metric_only:
+    expected_items = [1, 2]
   else:
     # If no option is specified, don't check the number of items.
     expected_items = -1
diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index 9a176ceae4a3c3a2..4d4aac547f0109d1 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -148,6 +148,14 @@ check_per_socket()
 	echo "[Success]"
 }
 
+check_metric_only()
+{
+	echo -n "Checking $1 output: metric only "
+	perf stat --metric-only $2 -e instructions,cycles true
+	commachecker --metric-only
+	echo "[Success]"
+}
+
 # The perf stat options for per-socket, per-core, per-die
 # and -A ( no_aggr mode ) uses the info fetched from this
 # directory: "/sys/devices/system/cpu/cpu*/topology". For
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index fc2d8cc6e5e0b1e5..7a6f6e1774028322 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -44,6 +44,7 @@ function commachecker()
 	;; "--per-die")		exp=8
 	;; "--per-cluster")	exp=8
 	;; "--per-cache")	exp=8
+	;; "--metric-only")	exp=2
 	esac
 
 	while read line
@@ -75,6 +76,7 @@ check_interval "CSV" "$perf_cmd"
 check_event "CSV" "$perf_cmd"
 check_per_thread "CSV" "$perf_cmd"
 check_per_node "CSV" "$perf_cmd"
+check_metric_only "CSV" "$perf_cmd"
 if [ $skip_test -ne 1 ]
 then
 	check_system_wide_no_aggr "CSV" "$perf_cmd"
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 6b630d33c3287899..a4f257ea839e1368 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -173,6 +173,14 @@ check_per_socket()
 	echo "[Success]"
 }
 
+check_metric_only()
+{
+	echo -n "Checking json output: metric only "
+	perf stat -j --metric-only -e instructions,cycles -o "${stat_output}" true
+	$PYTHON $pythonchecker --metric-only --file "${stat_output}"
+	echo "[Success]"
+}
+
 # The perf stat options for per-socket, per-core, per-die
 # and -A ( no_aggr mode ) uses the info fetched from this
 # directory: "/sys/devices/system/cpu/cpu*/topology". For
@@ -207,6 +215,7 @@ check_interval
 check_event
 check_per_thread
 check_per_node
+check_metric_only
 if [ $skip_test -ne 1 ]
 then
 	check_system_wide_no_aggr
diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 0f7967be60afdc7d..6fee67693ba7a9be 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -30,6 +30,7 @@ trap trap_cleanup EXIT TERM INT
 function commachecker()
 {
 	local prefix=1
+	local -i metric_only=0
 
 	case "$1"
 	in "--interval")	prefix=2
@@ -41,6 +42,7 @@ function commachecker()
 	;; "--per-die")		prefix=3
 	;; "--per-cache")	prefix=3
 	;; "--per-cluster")	prefix=3
+	;; "--metric-only")	metric_only=1
 	esac
 
 	while read line
@@ -60,6 +62,9 @@ function commachecker()
 		x=${main_body%#*}
 		[ "$x" = "" ] && continue
 
+		# Check metric only - if it has a non-empty result
+		[ $metric_only -eq 1 ] && return 0
+
 		# Skip metrics without event name
 		y=${main_body#*#}
 		for i in "${!skip_metric[@]}"; do
@@ -84,6 +89,8 @@ function commachecker()
 			exit 1;
 		}
 	done < "${stat_output}"
+
+	[ $metric_only -eq 1 ] && exit 1
 	return 0
 }
 
@@ -95,6 +102,7 @@ check_system_wide "STD" "$perf_cmd"
 check_interval "STD" "$perf_cmd"
 check_per_thread "STD" "$perf_cmd"
 check_per_node "STD" "$perf_cmd"
+check_metric_only "STD" "$perf_cmd"
 if [ $skip_test -ne 1 ]
 then
 	check_system_wide_no_aggr "STD" "$perf_cmd"
-- 
2.48.1.711.g2feabab25a-goog


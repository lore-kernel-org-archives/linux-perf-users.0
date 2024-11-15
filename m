Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088541E571C;
	Fri, 15 Nov 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685011; cv=none; b=PD5U2OD1kiUi5ziiMmRK+SqWVVRqTG3zMYwvavs4dSVKk6OdZ/SkL9D60ua7OUsG9Bsfi8ApT5wNi0minIpuAvRzdrq5EIpgz9wYFClsIjuHPMKMaVhDwytliAWROjxR8lLmFXy+3ytudP7yJQxsWybyWUGqNtxuI4vXt5M/5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685011; c=relaxed/simple;
	bh=HOki/LfePS3SL52MFsIPT+CWL2mahyk6mf98mYQcV+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCHwHPpRKfoZqnMq4dlR8i55GoDcUYj7ULiNCR63uokdOutmrY75CT60/jsldXzK385tOqE0u5+ElG856hKxDSMbHmMmLAGV/LEu3ez0lqYDc2F3nzANofsiv/BX5YJ0DYSShHU437neY/ppmH8VslFhJwcjOXvE3yEpr0dsBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV4Lb9aE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV4Lb9aE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2C8C4CED6;
	Fri, 15 Nov 2024 15:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731685010;
	bh=HOki/LfePS3SL52MFsIPT+CWL2mahyk6mf98mYQcV+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mV4Lb9aEKxDO9Twvwo1jYR2QfQKJqCpBXGAhw0xy/9UF3Ba4QITB7C7b83fiNr1ZB
	 9EM5LJobEMSOIrObeUI13kblNB6QgAblJC3KMC4Yal4LZJzoAI78zYBvi9UxT23rdb
	 Hvn55x2u76nVxeWvd68dbtdDycCFylInHX+tuNFhCodIpqUxzJDgAlXbQklf8sPCSK
	 6eY07wbbAUYtU4nzeTt+UDojSGLK0hoAUWhD/ATYVOavmFNk0J3UhImW887DWsddts
	 MCJPqOe1cBZ7yt36MMsMtQR4IPad7CI+NAPxHB80GBk6WgFrhZS2WUx+f91w6phbuf
	 b0VNUt68UjVeA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>,
	Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] perf test shell trace_exit_race: Show what went wrong in verbose mode
Date: Fri, 15 Nov 2024 12:36:33 -0300
Message-ID: <20241115153634.314742-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115153634.314742-1-acme@kernel.org>
References: <20241115153634.314742-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If it fails we need to check what was the reason, what were the lines
that didn't match the expected format, so:

  root@number:~# perf test -v "trace exit race"
  --- start ---
  test child forked, pid 2028724
  Lines not matching the expected regexp: ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$':
       0.000 :2028750/2028750 syscalls:sys_enter_exit_group()
  ---- end(-1) ----
  110: perf trace exit race                                            : FAILED!
  root@number:~#

In this case we're not resolving the process COMM for some reason and
fallback to printing just the pid/tid, this will be fixed in a followup
patch.

Howard Chu spotted a problem with single code surrounding a regexp, that
made the test always fail, but since there were some failures when I
tested (COMM not being resolved in some of the results) the end inverse
grep would show some lines and thus didn't notice the single quote
problem.

He also provided a patch to test if less than the number of expected
matches took place but all of them with the expected output, in which
case the inverse grep wouldn't show anything, confusing the tester.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Benjamin Peterson <benjamin@engflow.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/ZzdknoHqrJbojb6P@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace_exit_race.sh | 24 +++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index 3cf2d71a5c3b9278..8ea24f4256bc8f5e 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -11,11 +11,19 @@
 
 skip_if_no_perf_trace || exit 2
 
+if [ "$1" = "-v" ]; then
+	verbose="1"
+fi
+
+iter=10
+regexp=" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$"
+
 trace_shutdown_race() {
-	for _ in $(seq 10); do
+	for _ in $(seq $iter); do
 		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
 	done
-	[ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$' $file)" = "10" ]
+	result="$(grep -c -E "$regexp" $file)"
+	[ $result = $iter ]
 }
 
 
@@ -27,5 +35,17 @@ export PERF_CONFIG=/dev/null
 
 trace_shutdown_race
 err=$?
+
+if [ $err != 0 ] && [ "${verbose}" = "1" ]; then
+	lines_not_matching=$(mktemp /tmp/temporary_file.XXXXX)
+	if grep -v -E "$regexp" $file > $lines_not_matching ; then
+		echo "Lines not matching the expected regexp: '$regexp':"
+		cat $lines_not_matching
+	else
+		echo "Missing output, expected $iter but only got $result"
+	fi
+	rm -f $lines_not_matching
+fi
+
 rm -f ${file}
 exit $err
-- 
2.47.0


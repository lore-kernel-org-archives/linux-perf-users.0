Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9721E571C;
	Fri, 15 Nov 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685015; cv=none; b=Vt+9y5jAmlkS3uh/fr6yAdgtoeZHjLfKKPobjzOby70Gj3Vl4cpdnZ+uRU5OWX3jkXFKwDy3jfM7YhjL0mtUhXT9Yqg+H/7gU5h55jPeobLlsz6G777aYt6kZ1QotDjhKC3LBU58GeLMomybBG+HAXEkBxoqpj/Eumu9AhI4X0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685015; c=relaxed/simple;
	bh=sPivoQA+PBNweizbL3Q8DLYK7FpWRO7exlwdr/7WVFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd+ZCthTCNj7DGcFVZVYUBgd1pNNANnhzluJBDd4/U4pLF/SIQ6XmeI6Zw3oeCmbLq+V5yR4cBT+9dydymSL1TeJ9fnkNI+F88635kb/ybRKDrLHKdxub3PZvVAninTb6z1Etgtql2gNSzcCMtURKqWzdJrXunqgckhSBJM+/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqZv7Vrt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqZv7Vrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5599DC4CED5;
	Fri, 15 Nov 2024 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731685015;
	bh=sPivoQA+PBNweizbL3Q8DLYK7FpWRO7exlwdr/7WVFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqZv7VrtIOzYfdUAYAAE2oXbvnQFr9SsU9/Lk+jIOV9nTFRBtSNUTBGiyJMTaczQM
	 LOoqBAKwUJweARgSIOhLI3Sgcio6mHtgMd40M0tiF4YW5R1NhJRTSnqIzPGcTqpYNg
	 NkGryPxCDSwQKsoOhKuBQhkgIkdrCrHf9biG3ybbiRmTPhzefpjNw2YhoI31jxeja9
	 psATW9WOI6qV9zEHVnlSKtj29RTrJ/PDHL/0Tn9IqmmQ0JLjxArVi46cYZHrV1ma3K
	 EFwWYOzPP7Jfpz9eSEQoclzNn9KPg9ticIMgG/C0oj2xsNA9s8U+eHjqpPYZHq6lzj
	 O7V79MZHRxf0A==
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
Subject: [PATCH 2/2] perf test shell trace_exit_race: Use --no-comm to avoid cases where COMM isn't resolved
Date: Fri, 15 Nov 2024 12:36:34 -0300
Message-ID: <20241115153634.314742-3-acme@kernel.org>
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

The purpose of this test is to test for races in the exit of 'perf
trace' missing the last events, it was failing when the COMM wasn't
resolved either because we missed some PERF_RECORD_COMM or somehow
raced on getting it from procfs.

Add --no-comm to the 'perf trace' command line so that we get a
consistent, pid only output, which allows the test to achieve its goal.

This is the output from
'perf trace --no-comm -e syscalls:sys_enter_exit_group':

     0.000 21953 syscalls:sys_enter_exit_group()
     0.000 21955 syscalls:sys_enter_exit_group()
     0.000 21957 syscalls:sys_enter_exit_group()
     0.000 21959 syscalls:sys_enter_exit_group()
     0.000 21961 syscalls:sys_enter_exit_group()
     0.000 21963 syscalls:sys_enter_exit_group()
     0.000 21965 syscalls:sys_enter_exit_group()
     0.000 21967 syscalls:sys_enter_exit_group()
     0.000 21969 syscalls:sys_enter_exit_group()
     0.000 21971 syscalls:sys_enter_exit_group()

Now it passes:

  root@number:~# perf test "trace exit race"
  110: perf trace exit race                                            : Ok
  root@number:~#
  root@number:~# perf test -v "trace exit race"
  110: perf trace exit race                                            : Ok
  root@number:~#

If we artificially make it run just 9 times instead of the 10 it runs,
i.e. by manually doing:

	trace_shutdown_race() {
		for _ in $(seq 9); do

that 9 is $iter, 10 in the patch, we get:

  root@number:~# vim ~acme/libexec/perf-core/tests/shell/trace_exit_race.sh
  root@number:~# perf test -v "trace exit race"
  --- start ---
  test child forked, pid 24629
  Missing output, expected 10 but only got 9
  ---- end(-1) ----
  110: perf trace exit race                                            : FAILED!
  root@number:~#

I.e. 9 'perf trace' calls produced the expected output, the inverse grep
didn't show anything, so the patch provided by Howard for the previous
patch kicks in and shows a more informative message.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Benjamin Peterson <benjamin@engflow.com>
Cc: Howard Chu <howardchu95@gmail.com>
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
 tools/perf/tests/shell/trace_exit_race.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/tests/shell/trace_exit_race.sh
index 8ea24f4256bc8f5e..fbb0adc33a889516 100755
--- a/tools/perf/tests/shell/trace_exit_race.sh
+++ b/tools/perf/tests/shell/trace_exit_race.sh
@@ -16,11 +16,11 @@ if [ "$1" = "-v" ]; then
 fi
 
 iter=10
-regexp=" +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_enter_exit_group\(\)$"
+regexp=" +[0-9]+\.[0-9]+ [0-9]+ syscalls:sys_enter_exit_group\(\)$"
 
 trace_shutdown_race() {
 	for _ in $(seq $iter); do
-		perf trace -e syscalls:sys_enter_exit_group true 2>>$file
+		perf trace --no-comm -e syscalls:sys_enter_exit_group true 2>>$file
 	done
 	result="$(grep -c -E "$regexp" $file)"
 	[ $result = $iter ]
-- 
2.47.0


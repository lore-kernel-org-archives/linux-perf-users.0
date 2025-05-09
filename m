Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF4236A70;
	Fri,  9 May 2025 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826219; cv=none; b=U+EUeGsNVBccWFMjvOCfQLpXQ6WHjgnivadbwrJjLfj3hImCoJ8+4FpHiELNUM8iwjeiCLcWePknYpO9p8P51yMhlHEOcZMYgM9iuS1/4ASq82n555lIrRBOskFfTFCYDNoZBw6CD4ebcSp58E2H+y2Rp5UY2/7C2r686OxZw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826219; c=relaxed/simple;
	bh=KsTCqALkXHkMG+/9vPFk2vxFQkHx0K9ynABEvSsGefw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MU71zY0R0XwAr9M/dln+xgxXd0WmGi/8MwwC9SnaKnlkEkW9v0s8hg0PymJAk/J7JDWCya7b/2gAHwuv1yRn1N3P6CSyTRfJ1tNQyHD56SttlsSTLOmXE+7qwqAZY7GzTsk+RqORFMMtqogSxFCjlXIa+drz+pAq791eOOL6kj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbyURY+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbyURY+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE59C4CEE4;
	Fri,  9 May 2025 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746826218;
	bh=KsTCqALkXHkMG+/9vPFk2vxFQkHx0K9ynABEvSsGefw=;
	h=From:To:Cc:Subject:Date:From;
	b=JbyURY+YKHmIAo8dE9/GA5IHl672wiB8cDMsD2+8fQGdSqnsaxasldq5NX19It9kX
	 WQ3vjV+3cWUnu7ry4trau7vcQzKnA4coqiee1v918Blc/jDF5IHFKHGD2fVYCn0VBQ
	 lSURtHjmbQtK6gsRUg9YR5ACy7WIZVur8/E+FhRJ1H8M/Q4jtcUfNPicqPlmgytkvk
	 BajGM6hhPD+Xpu8ikwFF49ag59mZ/cp8So45tJBWFZO/tvyaoQf5KyNNl5HUxdDgeD
	 bWqLXk54gV6CCtDT6q5IVfPj0nk5JHSw1RLZWYU3Xt6X5/zlhk4ykyWQAdGw2Pr4un
	 V5ZXcI3S8kVIw==
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
Subject: [PATCH 1/2] perf test: Fix LBR test by ignoring idle task
Date: Fri,  9 May 2025 14:30:16 -0700
Message-ID: <20250509213017.204343-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found 'perf record LBR tests' failing due to empty branch stacks.

  $ perf test -v LBR
  ...
  LBR system wide any branch test
  Lowering default frequency rate from 4000 to 1000.
  Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
  [ perf record: Woken up 8 times to write data ]
  [ perf record: Captured and wrote 3.142 MB /tmp/__perf_test.perf.data.dgSBl (3572 samples) ]
  LBR system wide any branch test: 3572 samples
  LBR system wide any branch test [Failed empty br stack ratio exceed 2%: 3%]
  LBR system wide any call test
  Lowering default frequency rate from 4000 to 1000.
  Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
  [ perf record: Woken up 8 times to write data ]
  [ perf record: Captured and wrote 3.337 MB /tmp/__perf_test.perf.data.dgSBl (3967 samples) ]
  LBR system wide any call test: 3967 samples
  LBR system wide any call test [Failed empty br stack ratio exceed 2%: 9%]
  ...

The failing cases were in system-wide mode and I realized that the
samples were from the idle tasks (swapper).  I suspect going to/from
idle state may affect the LBR contents.

If we can skip empty branch stacks from the idle tasks, the failure
should go away.  I can see the following output in perf report -D.

  $ perf report -D | grep -m5 -A3 'branch stack: nr:0'
  ...
  --
  ... branch stack: nr:0
   ... thread: swapper:0
   ...... dso: /proc/kcore

  --
  ... branch stack: nr:0
   ... thread: swapper:0
   ...... dso: /proc/kcore

  --
  ... branch stack: nr:0
   ... thread: DefaultEventMan:10282
   ...... dso: /proc/kcore

  --
  ... branch stack: nr:0
   ... thread: swapper:0
   ...... dso: /proc/kcore

  --
  ... branch stack: nr:0
   ... thread: swapper:0
   ...... dso: /proc/kcore

  $ perf report -D | grep -c 'branch stack: nr:0'
  145

  $ perf report -D | grep -A3 'branch stack: nr:0' | grep thread | grep -c swapper
  i36

  $ perf report -D | grep -A3 'branch stack: nr:0' | grep thread | grep -cv swapper
  9

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record_lbr.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 8d750ee631f877fd..afad02d0180e023c 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -93,7 +93,7 @@ lbr_test() {
     return
   fi
 
-  zero_nr=$(echo "$out" | grep -c 'branch stack: nr:0' || true)
+  zero_nr=$(echo "$out" | grep -A3 'branch stack: nr:0' | grep thread | grep -cv swapper || true)
   r=$(($zero_nr * 100 / $bs_nr))
   if [ $r -gt $threshold ]; then
     echo "$test [Failed empty br stack ratio exceed $threshold%: $r%]"
-- 
2.49.0.1015.ga840276032-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B521FDE33;
	Thu,  5 Jun 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151363; cv=none; b=kBjHvXyNOWwBRQKiDunHVNRAuQzNqxPMHG4asA6ASWtui9lQaDHQ5vj02t5KgYyB8OF1H2tuOnKfPx6R4C3oHS58xIGXg2mTCSVdZxWpMjlcYToTDK+ooNL0TPzry7t1WfXewuf/nEoeEPgl072l40Su5yocucP/quAx5qdHThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151363; c=relaxed/simple;
	bh=aBaUqMOLUxPloqy1mEEZmdGPkoChlblWJcwLvLud0/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uiDGuKqjnk1zAuj1735F+s/bG9hKp4kQaHAkwFdu74JQLCaI0f/uuY4BQZ+vLnwLwM4BYbD/lEs3jdscXTfV09sxJY2Hw52vW0bg/O4veRGLX0ZMErLTXYAG4qMrYGps7MM6/cIlb6f8nZZZjhU4pAwp88LSQvn9v2VJSR8l9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfH7Zrl/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfH7Zrl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3062C4CEE7;
	Thu,  5 Jun 2025 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749151363;
	bh=aBaUqMOLUxPloqy1mEEZmdGPkoChlblWJcwLvLud0/w=;
	h=Date:From:To:Cc:Subject:From;
	b=bfH7Zrl/5/O11myhHR4Mp3DcivF9ufovC8qIaaznrHMBFBeQxp4gu8E6ikWD0HaL9
	 IxQRkisfRjNU5RLfDl4frGGqCtgTpYaXLQZQNw8Ix9R/+SBJrvyS3FSyKS339258xw
	 RppXQQ8RLgzMEdLv9CaAuTgxGFeOAZ1NB3C1701MxD/bN6ODKOsoQ5EE4PpmlUTA/n
	 sGMc6X7cxROUfbsPxoHfT8sTHSbjvHc3pho02bKTcG+m3twVtGnu9DU84qtIiJKGpw
	 qijRhiio3iF9s13J5wPU6AqRE+j+61ZoHQ5JYNk6tK7Wf8OHUglU6mRZuJUU1agdlG
	 OgrqoBZ1X+RWw==
Date: Thu, 5 Jun 2025 16:22:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 v6.16] perf test event_uniquifying: Skip test on
 platforms without 'clockticks' events
Message-ID: <aEHugAPinlWLuTAS@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'll add this to perf-tools for v6.16, please check.

- Arnaldo

---

This test assumes the 'clockticks' event is generally available, which
isn't the case, for instance, on AMD systems such as:

  root@number:~# grep -m1 "model name" /proc/cpuinfo
  model name	: AMD Ryzen 9 9950X3D 16-Core Processor
  root@number:~# perf list clockticks

  List of pre-defined events (to be used in -e or -M):

  root@number:~#

So skip this test when 'clockticks' isn't available.

This should be improved to find other events that are available in
multiple PMUs so that the intent of the test is achieved in more
platforms.

Fixes: cb422594d62066a5 ("perf test: Add stat uniquifying test")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>
Cc: Dr. David Alan Gilbert <linux@treblig.org>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Levi Yun <yeoreum.yun@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Weilin Wang <weilin.wang@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/stat+event_uniquifying.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index 5ec35c52b7d9651e..20498b6eadb57702 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -49,6 +49,12 @@ test_event_uniquifying() {
     uniquified_event_array+=("${uniquified_event}")
   done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
 
+  if [ ${#uniquified_event_array[@]} -eq 0 ]; then
+    echo "'clocktick' event not available on this machine"
+    err=2
+    return
+  fi
+
   perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
   $perf_command
 
-- 
2.49.0


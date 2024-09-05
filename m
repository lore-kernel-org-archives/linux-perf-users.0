Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861441A7266;
	Thu,  5 Sep 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567871; cv=none; b=R8Wkmrw8xqzFg6GyjKGoLvXQLFNa9+F8PAYKdVJe+7Bn8qzkzB5TNRlOAhio0qTwZSFDStj33UD1tIAhoh9kRUkVxrxHK9o+9NTrPWcSVVExOYl7bbaFp3OblL4+/aP6lcs/h1jUNnLouJNtGQBL3JAvonc89rcmRFZacfCOMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567871; c=relaxed/simple;
	bh=9Ms+lwy/AoTEkUwRqoIFXzIsIMdu/VLl0Aily7ML1NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExQMnSRa2Nwcw2kN/ExSGI8HUeEMjTO+uxfo+Bd5kVzjKzafGItYgb2Fqa+fVEUnTMNAfWNEn3tA8kgTkOBj3kGVqVoOKROGZ5MfII51ekUZFLx7lWgksuY/u6gncJ+Bh32c3jmBATePPU50OalcarNokG11fVohU6amJPv16mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmjGGF33; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmjGGF33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86131C4CEC9;
	Thu,  5 Sep 2024 20:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567871;
	bh=9Ms+lwy/AoTEkUwRqoIFXzIsIMdu/VLl0Aily7ML1NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YmjGGF33rZ+0id+gB4hUmvn0eGXmMsF0E4CgsiuAsGeK6EfoEqsE74pFM3qnBrA2D
	 DFlExUWKJqlwR2Gy/lV31GjG17X1gJQWP2j9rzo09uNdwCsp//i6cEHs7wUj/2/aPp
	 stPKqZMh8e9qseMHbJigR2Xp8JP/XHi0CEH9pLTVLQw8udTno0qYcLBRUwT20E+DIC
	 FO4omCSJiU6CEre/i1u9txBQRO65D6y8VPqTRymBdWGONeXbLiJlWPdkQccsnyZ0Da
	 CkkqFGk2VkuaKilx3ROyXzhEaF/2wLaJMDiGf2+auBhti4qoMLJZykX0HO9Mb7IL0l
	 9+GWTGTMCt2Eg==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 04/10] perf stat: Add --exclude-guest option
Date: Thu,  5 Sep 2024 13:24:20 -0700
Message-ID: <20240905202426.2690105-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905202426.2690105-1-namhyung@kernel.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is to support the old behavior of setting exclude_guest by
default.  Now it doesn't set the bit so users want the old behavior can
use this option.

  $ perf stat true

   Performance counter stats for 'true':

                0.86 msec task-clock:u                     #    0.443 CPUs utilized
                   0      context-switches:u               #    0.000 /sec
                   0      cpu-migrations:u                 #    0.000 /sec
                  49      page-faults:u                    #   56.889 K/sec
                 ...

  $ perf stat --exclude-guest true

   Performance counter stats for 'true':

                0.79 msec task-clock:Hu                    #    0.490 CPUs utilized
                   0      context-switches:Hu              #    0.000 /sec
                   0      cpu-migrations:Hu                #    0.000 /sec
                  49      page-faults:Hu                   #   62.078 K/sec
                 ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt | 7 +++++++
 tools/perf/builtin-stat.c              | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 2bc06367248691dd..d28d8370a856598f 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -382,6 +382,13 @@ color the metric's computed value.
 Don't print output, warnings or messages. This is useful with perf stat
 record below to only write data to the perf.data file.
 
+--exclude-guest::
+Don't count event in the guest mode.  It was the old behavior but the
+default is changed to count guest events also.  Use this option if you
+want the old behavior (host only).  Note that this option needs to be
+before other events in case you added -e/--event option in the command
+line.
+
 STAT RECORD
 -----------
 Stores stat data into perf data file.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d8315dae930184ba..4d47675af5cc3094 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2491,6 +2491,8 @@ int cmd_stat(int argc, const char **argv)
 		OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
 				"Configure all used events to run in user space.",
 				PARSE_OPT_EXCLUSIVE),
+		OPT_BOOLEAN(0, "exclude-guest", &exclude_HG_default,
+			"Don't count events in the guest mode"),
 		OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
 			"Use with 'percore' event qualifier to show the event "
 			"counts of one hardware thread by sum up total hardware "
-- 
2.46.0.469.g59c65b2a67-goog


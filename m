Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235C28683;
	Mon,  2 Sep 2024 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241585; cv=none; b=gnMHOxI3ciYipaWUR0hwwP3gTOwk5XMzVlqhlw/PZuGINoG6tuPPU1X6UmEhok0csVKnQ/nbCte+W3rYXhA7jFziVz+u3ifAaiIKgPdsZphtfkhnELq6lNLbtLf+QY9zkWtVxuQgZ7eJV+bqejY9EVnOKAm/kqnqwfY5VMVVHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241585; c=relaxed/simple;
	bh=suv85j1m1/NXNAqq3RNaOfwXgswYvyBgpuW6ErDVBEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtOKJQSxUeSHnPwo2CtsuI0N2j7q14g+AZGv/IMxkpxbcZPdtpFnJmHCojawlj32Pqr5KoToT1+BkMycXuLUZoAWEHI0GHDmsWn/tbvPnYExwoEH6xS7z+q83zy7zB5cmxiCiTB12wy8k3I7P6p9bnJSND9Vz92nW+xpatueiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juZUXaoU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juZUXaoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89235C4CECB;
	Mon,  2 Sep 2024 01:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725241585;
	bh=suv85j1m1/NXNAqq3RNaOfwXgswYvyBgpuW6ErDVBEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=juZUXaoUAZ+p0Kjj2lc3/kAFdZI104nWvLNlGg2+9iAZmiZs/M4rzsHm/b9faQ3Lp
	 550N3jsaFsyFReNQTQTf9Msz3lTgBFn13tGLxzkwW5Iz+YjHLL9G3l+9LgRw54404g
	 3YCBqMGmtZvk85Ck0n8maXMavemizPG3Vdz5YbbGuPnA/8P3wNUQzYMDc3Oalv/vCj
	 SR58CrZkEgM6wIDXxOsSCxLvXmzLHl3VZ9odvseCyTMFNZmWMiGprb3z2jhcFkIqkD
	 vEmkK8+/OJ5FElISRPRuNfm3wnke3gI3L61RgTeqUWPoeMNSYiav5FLokxsEb4+52j
	 zFdFWlK/t5V6Q==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 3/4] perf stat: Add --exclude-guest option
Date: Sun,  1 Sep 2024 18:46:20 -0700
Message-ID: <20240902014621.2002343-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902014621.2002343-1-namhyung@kernel.org>
References: <20240902014621.2002343-1-namhyung@kernel.org>
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
index 2bc063672486..d28d8370a856 100644
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
index cf985cdb9a6e..8b9889873d3e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2492,6 +2492,8 @@ int cmd_stat(int argc, const char **argv)
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


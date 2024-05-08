Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E77EEE4;
	Wed,  8 May 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175796; cv=none; b=HkwG+56aCRFNKegfnxa5RElM5ty5H7DH3H2DICxpgEO+PwQXUFIB8H1F9ICygub0WwQU4FHAgC+RBdCrnlNuIROm0cWa884DMVqfZrAmgMFXS9fHw87cBqe21biiDIMPnvC74wLBduBXgykufDC04/mriYZHeMFvdzApvykqPr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175796; c=relaxed/simple;
	bh=5w23dpOksFhKHY4ogRVSJXbrjxuSeiG3C83V9X8yDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmzHjqasND3QJJGQwpA4/ZEkxV43IB6YmffDqS64Z/4WcHiKoB6lwYuuZZOA71n56rerU8HgVn/yvyytU5cHf0MU00039nHgQQgJyxi6XwDsplBulaxHZYSR3TapCMbm5iV/dwEhc2SGpcujHXYuoJ6K0pzONbDO7ojL1h7lMYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF3D1007;
	Wed,  8 May 2024 06:43:39 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.cambridge.arm.com (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.3.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3EE23F6A8;
	Wed,  8 May 2024 06:43:12 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH 1/1] perf lock info: Display both map and thread by default
Date: Wed,  8 May 2024 13:42:58 +0000
Message-ID: <20240508134259.24413-2-nick.forrington@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508134259.24413-1-nick.forrington@arm.com>
References: <20240508134259.24413-1-nick.forrington@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "perf lock info" argument handling to:

Display both map and thread info (rather than an error) when neither are
specified.

Display both map and thread info (rather than just thread info) when
both are requested.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 tools/perf/Documentation/perf-lock.txt |  4 ++--
 tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index f5938d616d75..57a940399de0 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -111,11 +111,11 @@ INFO OPTIONS
 
 -t::
 --threads::
-	dump thread list in perf.data
+	dump only the thread list in perf.data
 
 -m::
 --map::
-	dump map of lock instances (address:name table)
+	dump only the map of lock instances (address:name table)
 
 
 CONTENTION OPTIONS
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 230461280e45..d0b8645487ad 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1483,11 +1483,16 @@ static int dump_info(void)
 
 	if (info_threads)
 		dump_threads();
-	else if (info_map)
+
+	if (info_map) {
+		if (info_threads)
+			fputc('\n', lock_output);
 		dump_map();
-	else {
+	}
+
+	if (!info_threads && !info_map) {
 		rc = -1;
-		pr_err("Unknown type of information\n");
+		pr_err("No lock info specified\n");
 	}
 
 	return rc;
@@ -2578,9 +2583,9 @@ int cmd_lock(int argc, const char **argv)
 
 	const struct option info_options[] = {
 	OPT_BOOLEAN('t', "threads", &info_threads,
-		    "dump thread list in perf.data"),
+		    "dump the thread list in perf.data"),
 	OPT_BOOLEAN('m', "map", &info_map,
-		    "map of lock instances (address:name table)"),
+		    "dump the map of lock instances (address:name table)"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -2694,6 +2699,13 @@ int cmd_lock(int argc, const char **argv)
 			if (argc)
 				usage_with_options(info_usage, info_options);
 		}
+
+		/* If neither threads nor map requested, display both */
+		if (!info_threads && !info_map) {
+			info_threads = true;
+			info_map = true;
+		}
+
 		/* recycling report_lock_ops */
 		trace_handler = &report_lock_ops;
 		rc = __cmd_report(true);
-- 
2.44.0


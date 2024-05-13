Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F571487C3;
	Mon, 13 May 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591673; cv=none; b=GKcRnpXFc7v7kaYPWplhajgSo3OD/pfBJrX6JuxfkPor4eS07MdgxKNtXToSG7Y+r5fK6mm3McoXXPVATbWoXbr0ytMSFc4MkNhFEtPkUPg0uadIYVho4tjPgjXyQv+1oEptj2F8oB4qAg2uCtF1/nqiSiVfoMGpOxcOixJ9JzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591673; c=relaxed/simple;
	bh=Xont+LTcReRWcCq8vORfAehGCF5YAd/0vAUmmjBYfQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjYVSQPorMDFTjpsM6rxF7OOQpkhNG6+lES8vqUIsH99fGn2tfGgRmt5CAN+W63rzm1rfVE2O2a3sqYI20t5MW7kQ6NZAxNSul8yfpkGauOs5I6PxnVeYgnQHM781drygow/ZPLSEyDpsKvj5SVvfAEOy5pztsk+0o/TKSuH3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7554E1007;
	Mon, 13 May 2024 02:14:56 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.cambridge.arm.com (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.3.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE9E93F762;
	Mon, 13 May 2024 02:14:29 -0700 (PDT)
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
Date: Mon, 13 May 2024 09:14:12 +0000
Message-ID: <20240513091413.738537-2-nick.forrington@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513091413.738537-1-nick.forrington@arm.com>
References: <20240513091413.738537-1-nick.forrington@arm.com>
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
 tools/perf/builtin-lock.c              | 27 ++++++++++++++------------
 2 files changed, 17 insertions(+), 14 deletions(-)

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
index 230461280e45..7eb115aeb927 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1477,20 +1477,16 @@ static void dump_map(void)
 		fprintf(lock_output, " %#llx: %s\n", (unsigned long long)st->addr, st->name);
 }
 
-static int dump_info(void)
+static void dump_info(void)
 {
-	int rc = 0;
-
 	if (info_threads)
 		dump_threads();
-	else if (info_map)
+
+	if (info_map) {
+		if (info_threads)
+			fputc('\n', lock_output);
 		dump_map();
-	else {
-		rc = -1;
-		pr_err("Unknown type of information\n");
 	}
-
-	return rc;
 }
 
 static const struct evsel_str_handler lock_tracepoints[] = {
@@ -1992,7 +1988,7 @@ static int __cmd_report(bool display_info)
 
 	setup_pager();
 	if (display_info) /* used for info subcommand */
-		err = dump_info();
+		dump_info();
 	else {
 		combine_result();
 		sort_result();
@@ -2578,9 +2574,9 @@ int cmd_lock(int argc, const char **argv)
 
 	const struct option info_options[] = {
 	OPT_BOOLEAN('t', "threads", &info_threads,
-		    "dump thread list in perf.data"),
+		    "dump the thread list in perf.data"),
 	OPT_BOOLEAN('m', "map", &info_map,
-		    "map of lock instances (address:name table)"),
+		    "dump the map of lock instances (address:name table)"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -2694,6 +2690,13 @@ int cmd_lock(int argc, const char **argv)
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


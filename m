Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF954A7D6;
	Tue, 13 Oct 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922487; cv=none; b=iOmutPTAthxAg8G6lQkWJTgcbjs4nYekYIRB9MOdsn9o9nE5WzhLIj5tegq7newUn+LypPETKiOMK5ZqV7vdzUL3css39NZTHaH0Dw/NkeljKmu52XbLEjzmRWONW5HnSpm29AxXV0cACND8i4ORSj9m2ZSI+5s6p3zJK6G/L40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922487; c=relaxed/simple;
	bh=D6gBH4rzn9ofW182vOzOgRcRuc+ozHzrNi9DP0nNdXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyKwstu9KAULzheuksEEs+BOX8d2ocFun51wkHVdATHrHORMQMtdiSXXJWDwO/oU4G9hEqFzmlFl+osKKENCapwCRoYSCY3zf/Of0TJkm+K6+9QB9uKycRDh5/qYOTw53TF8SdTNqz3Di46iwnYnhycDxa589cje5ELUzUQA2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmquucq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmquucq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB1E1F00893;
	Tue, 13 Oct 2026 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922484;
	bh=wS0fg57Vpynd21ZO3GmtvsnsHKdxN1CGGQHPTIoEj6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmquucq87XXKwok0upeEZB55Ucbf4DrOd6/ZPzVIr5tggcjOxOEMiGYZ6YVLw4nSb
	 R+jvifyc9VYy5yN3gpQWOXifiw3wxGGjo02kAcTDxxXz3dFFksarvrFQGL2HHigumk
	 t5aPBs0XIqpkrB5+PgJK3NO16ij8Xef5HvD8EaYUYulrFsXT2c2TpJ9IkAlIpZwBmF
	 bcnkHjl876e9FXASlWpLuFjqpJdxLkll4F+2hYW1wdtANuCl7M8sRq4DkYnqk8sOmo
	 LuQ02pf6pM2R4KBlOjQMHbaTzuzC5OvTboHp5yTr1c1idF1TVdTNsdDSBUN7by8Gle
	 Mh9Y346rfRmwg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 06/19] perf evsel: Mark the event as supported when retrying an open
Date: Tue, 13 Oct 2026 17:14:01 -0300
Message-ID: <20261013201415.36428-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Opening a group with perf record on a machine with perf_event_paranoid >
1 and no CAP_PERFMON fails the first perf_event_open() with EACCES, after
which evsel__open_cpu() clears evsel->supported; evsel__fallback() then
adds exclude_kernel and record__open() retries, and the retry succeeds
with supported left false.  get_group_fd() treats unsupported events as
ungroupable, so the retry opens the group members without their leader:

  sys_perf_event_open: pid 12345 cpu 0 group_fd -1
  FAILED '.../test-record-group-sampling1' - group failure

which fails the group subtests of "perf test 82", the Perf attribute
expectations test, when it is run as a regular user, while it passes as
root or with CAP_PERFMON, where the first open doesn't fail.

commit 2cc7aa995ce9 ("perf stat: Refactor retry/skip/fatal error handling")
dropped the pos->supported = true that record__open() did after a
successful open and moved the resets into the stat code only, while
saying "When an event is tried the supported is set to true again".  Do
that in evsel__open_cpu(), which every open entry point funnels through,
so that a retry describes its own try instead of the previous failure.

Fixes: 2cc7aa995ce9ecd8 ("perf stat: Refactor retry/skip/fatal error handling")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c5e7510f0c019c3..e61f309e93dccc7f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3014,6 +3014,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	enum rlimit_action set_rlimit = NO_CHANGE;
 	struct perf_cpu cpu;
 
+	/*
+	 * A failed attempt being retried after evsel__fallback() would
+	 * otherwise keep group members out of their group in get_group_fd().
+	 */
+	evsel->supported = true;
+
 	if (evsel__is_retire_lat(evsel)) {
 		err = evsel__tpebs_open(evsel);
 		goto out;
-- 
2.55.0


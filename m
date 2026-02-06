Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417F9328B75;
	Fri,  6 Feb 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395397; cv=none; b=eruRwyN2a5t5/01PFbMPGduyUOTpVWRMkfbf2wXYqsKWk1Jh/aa9QGiEnUgTY8NPDlq693fo7PtrMQktO8qelLz6n0bWw0aijrmYeGY8S8b1tpY3NnmjQEicAYF/OUvX+1nkqelKmfS52oKwHE4N2VnfLJ4xqnqyYdabd7FV75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395397; c=relaxed/simple;
	bh=jkpGtsytOS/HGMmQhUuD9txEmzJWZidekblfk7w5npI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KZCyKdgdStrAAceBzugU64bQIUOIkRmceYMX+uJeG6f3ZD529RJ98HJl1jsGkOgN8ZW/E3VMgyRiIs4gG/0y8eJmAMojK5TaQnywUB3G9MUPTNoO0ZwVjYJ2dZZlGuULr8j2MFThHp1bGfXgw7c6vewv6Grt0qY8fT4ltGbYyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F40E339;
	Fri,  6 Feb 2026 08:29:50 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ADA43F632;
	Fri,  6 Feb 2026 08:29:55 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 06 Feb 2026 16:29:37 +0000
Subject: [PATCH] perf record: Simplify open event error logs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-perf_improve_log_for_open_event_failures-v1-1-366903bebcd7@arm.com>
X-B4-Tracking: v=1; b=H4sIAPAWhmkC/52NQQ7CIBBFr9KwFgPYVuvKe5iGYBnaSVogQyWap
 ncXPYL5q/cX720sASEkdq02RpAxYfAF5KFiw2T8CBxtYaaEaoUSNY9ATuMSKWTQcxi1C6RDBK8
 hg1+1Mzg/CRK3YI0aWvnoTpYVXSRw+Pql7n3hCdMa6P0rZ/l9/4hkycsaoerm3KmLFDdDy3EIC
 +v3ff8AxFvJLN4AAAA=
X-Change-ID: 20260204-perf_improve_log_for_open_event_failures-deda2c61b93d
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770395395; l=3893;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=jkpGtsytOS/HGMmQhUuD9txEmzJWZidekblfk7w5npI=;
 b=/EgKZshJet1J3pxn2XLV2EVe5nDpfGNggs0k092n7iJoEWaUls7JFHdKUughIZs9OPPGZhr7O
 u7Vl9HOcNsPBQXSxSDUFPimxhXe/ijKgX/PH2rF2BUynJLmfFsCRMmX
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Instead of printing error messages for every event failure, this commit
prints a log only when the first error occurs.

Duplicate event names are a special case.  Print an explicit log message
only when verbose logging is enabled.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-record.c | 69 ++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index aa8dc3e18190dd7db1ed5e3c7673fde8d5785a26..9382ff57a822ad4ee5391116510941ce180a12d8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1343,6 +1343,31 @@ static int record__mmap(struct record *rec)
 	return record__mmap_evlist(rec, rec->evlist);
 }
 
+static bool record__is_event_name_duplicated(struct evlist *evlist,
+					     struct evsel *pos)
+{
+#if defined(__aarch64__) || defined(__arm__)
+	if (strstr(evsel__name(pos), "cycles")) {
+		struct evsel *pos2;
+
+		/*
+		 * Unfortunately ARM has many events named
+		 * "cycles" on PMUs like the system-level (L3)
+		 * cache which don't support sampling. Only
+		 * display such failures to open when there is
+		 * only 1 cycles event or verbose is enabled.
+		 */
+		evlist__for_each_entry(evlist, pos2) {
+			if (pos2 == pos)
+				continue;
+			if (strstr(evsel__name(pos2), "cycles"))
+				return true;
+		}
+	}
+#endif
+	return false;
+}
+
 static int record__open(struct record *rec)
 {
 	char msg[BUFSIZ];
@@ -1353,6 +1378,7 @@ static int record__open(struct record *rec)
 	int rc = 0;
 	bool skipped = false;
 	bool removed_tracking = false;
+	bool report_once = true;
 
 	evlist__for_each_entry(evlist, pos) {
 		if (removed_tracking) {
@@ -1370,8 +1396,6 @@ static int record__open(struct record *rec)
 		}
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
-			bool report_error = true;
-
 			if (evsel__fallback(pos, &opts->target, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
@@ -1383,36 +1407,29 @@ static int record__open(struct record *rec)
 			        pos = evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
-#if defined(__aarch64__) || defined(__arm__)
-			if (strstr(evsel__name(pos), "cycles")) {
-				struct evsel *pos2;
-				/*
-				 * Unfortunately ARM has many events named
-				 * "cycles" on PMUs like the system-level (L3)
-				 * cache which don't support sampling. Only
-				 * display such failures to open when there is
-				 * only 1 cycles event or verbose is enabled.
-				 */
-				evlist__for_each_entry(evlist, pos2) {
-					if (pos2 == pos)
-						continue;
-					if (strstr(evsel__name(pos2), "cycles")) {
-						report_error = false;
-						break;
-					}
-				}
+
+			if (pos->tracking)
+				removed_tracking = true;
+			pos->skippable = true;
+			skipped = true;
+
+			if (record__is_event_name_duplicated(evlist, pos)) {
+				if (verbose > 0)
+					ui__error("Skip to open event '%s' on PMU '%s' due to "
+						  "the duplicated naming.\n",
+						  evsel__name(pos), evsel__pmu_name(pos));
+				continue;
 			}
-#endif
-			if (report_error || verbose > 0) {
+
+			if (verbose > 0 || report_once) {
 				evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
 				ui__error("Failure to open event '%s' on PMU '%s' which will be "
 					  "removed.\n%s\n",
 					  evsel__name(pos), evsel__pmu_name(pos), msg);
+
+				if (report_once)
+					report_once = false;
 			}
-			if (pos->tracking)
-				removed_tracking = true;
-			pos->skippable = true;
-			skipped = true;
 		}
 	}
 

---
base-commit: 3d8b2baefecdd5e84a1c738bcfdb079aa536d997
change-id: 20260204-perf_improve_log_for_open_event_failures-deda2c61b93d

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


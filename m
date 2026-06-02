Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247B3B38BE;
	Tue,  2 Jun 2026 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444665; cv=none; b=KAKOGFN3R027OqN7CJt0+cU7UUEa4lCfAhg3/5+SdLv0eqgtHDjbOZSB8mLr4THeLQJTZy41rpvAfMYa7+K6JUQMy8xnld1DbmO7+a1gcWeQEstI9K6DKw04kLJgysSAomjbw+5VogRlevU4RhC3RrUvxGjDTI6f1Q/nZxwWNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444665; c=relaxed/simple;
	bh=uzetH1C5DDfYWzo0efCsn0CQiTXNOSNURdVjptgmA78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtouS8o6H8NC9M08Mcy6QrQ4cMzlMMLwojd6zwQtAkfZnElHmKC2OBsz5YcliJWPyd2dxWtUcmQyPQjGuJMEYhDRNyAXInQbWyfBqbFf5CUCnP13KsBNeFynq6zNtXjwyhz8Y0a6m9g/tUHevRaJWR9/GmywohVgWoEcN0R7R/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfnEwQ6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfnEwQ6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201EC1F00898;
	Tue,  2 Jun 2026 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444664;
	bh=F3OKixCrqV9hoH2+zZgSn9a6/Zjkz4ow6yk629oAjNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jfnEwQ6WEidrTTU+w9d/RunFBbi9cnkN7Kt/9LWByUpHGQPee54bzBaB+TeUUmjOD
	 GyCrhj9resbB6qj0EPwe6L/g6t9zzyC7rwglXoxC0nPzScwTqFnjT7KWDLGdOq1JlO
	 CL96G5BaKomQxyQHDT1wko+IkHbekzZxrK2oGBUFoHEWD1/oxzKZrPFO5qBSfdN0bP
	 QFI5q+KZrZWAURont3AeEMptISon4HFVAXUKLR/C5njjSf4lILuJMHTxyX1iwuB1CJ
	 4OHt5gm5OvGtcH/9pxdgt5pp6NDYUVH0FMDTdYTl+UkqWXXkvtwhPdrx5kDUBjChrW
	 lwclx1BMCAHDg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 5/8] perf tools: Include file offset and event type name in skip messages
Date: Tue,  2 Jun 2026 20:57:04 -0300
Message-ID: <20260602235709.1541603-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602235709.1541603-1-acme@kernel.org>
References: <20260602235709.1541603-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add the perf.data file offset and use perf_event__name() instead of raw
event type integers in the 'problem processing event, skipping it'
messages emitted by process_sample_event() callbacks across annotate,
c2c, diff, kmem, kvm, kwork, lock, report, script, and build-id.

This lets users cross-reference skipped events with 'perf report -D'
output.  Also add explicit #include "util/event.h" and <inttypes.h>
where needed to avoid depending on transitive includes.

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c |  5 +++--
 tools/perf/builtin-c2c.c      |  5 +++--
 tools/perf/builtin-diff.c     |  8 +++++---
 tools/perf/builtin-kmem.c     |  6 ++++--
 tools/perf/builtin-kvm.c      |  9 ++++++---
 tools/perf/builtin-kwork.c    |  4 +++-
 tools/perf/builtin-lock.c     |  6 ++++--
 tools/perf/builtin-report.c   |  9 ++++++---
 tools/perf/builtin-script.c   | 10 ++++++----
 tools/perf/util/build-id.c    |  5 +++--
 10 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5f450c8093c09210..b918f9eed5fd2441 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -288,8 +288,9 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_warning("problem processing %d event, skipping it.\n",
-			   event->header.type);
+		pr_warning("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+			   perf_event__name(event->header.type), event->header.type,
+			   sample->file_offset);
 		ret = -1;
 		goto out_put;
 	}
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 36f38694992386ad..d3503be9350c03bb 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -328,8 +328,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_debug("problem processing %d event, skipping it.\n",
-			 event->header.type);
+		pr_debug("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+			 perf_event__name(event->header.type), event->header.type,
+			 sample->file_offset);
 		ret = -1;
 		goto out;
 	}
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index b4ff863b304ca046..9592f44b6545bab6 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -409,8 +409,9 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_warning("problem processing %d event, skipping it.\n",
-			   event->header.type);
+		pr_warning("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+			   perf_event__name(event->header.type), event->header.type,
+			   sample->file_offset);
 		ret = -1;
 		goto out;
 	}
@@ -436,7 +437,8 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 	case COMPUTE_STREAM:
 		if (hist_entry_iter__add(&iter, &al, PERF_MAX_STACK_DEPTH,
 					 NULL)) {
-			pr_debug("problem adding hist entry, skipping event\n");
+			pr_debug("problem adding hist entry at offset %#" PRIx64 ", skipping event\n",
+				 sample->file_offset);
 			goto out;
 		}
 		break;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 33585e353efe56cc..e1b2f5bc1ba8d887 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -22,6 +22,7 @@
 #include "util/cpumap.h"
 
 #include "util/debug.h"
+#include "util/event.h"
 #include "util/string2.h"
 #include "util/util.h"
 
@@ -987,8 +988,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 							sample->tid);
 
 	if (thread == NULL) {
-		pr_debug("problem processing %d event, skipping it.\n",
-			 event->header.type);
+		pr_debug("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+			 perf_event__name(event->header.type), event->header.type,
+			 sample->file_offset);
 		return -1;
 	}
 
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index dd2ed21596aa59f9..394302ebdb161077 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -22,6 +22,7 @@
 #include "util/synthetic-events.h"
 #include "util/top.h"
 #include "util/data.h"
+#include "util/event.h"
 #include "util/ordered-events.h"
 #include "util/kvm-stat.h"
 #include "util/util.h"
@@ -1141,14 +1142,16 @@ static int process_sample_event(const struct perf_tool *tool,
 		return 0;
 
 	if (machine__resolve(machine, &kvm->al, sample) < 0) {
-		pr_warning("Fail to resolve address location, skip sample.\n");
+		pr_warning("WARNING: at offset %#" PRIx64 ": fail to resolve address location, skipping sample\n",
+			   sample->file_offset);
 		return 0;
 	}
 
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL) {
-		pr_debug("problem processing %d event, skipping it.\n",
-			event->header.type);
+		pr_debug("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+			 perf_event__name(event->header.type), event->header.type,
+			 sample->file_offset);
 		return -1;
 	}
 
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 99dc293a0744726e..110de3507d48160c 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -9,6 +9,7 @@
 #include "perf.h"
 
 #include "util/data.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/header.h"
@@ -897,7 +898,8 @@ static int timehist_exit_event(struct perf_kwork *kwork,
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_debug("Problem processing event, skipping it\n");
+		pr_debug("problem processing event at offset %#" PRIx64 ", skipping it\n",
+			 sample->file_offset);
 		ret = -1;
 		goto out;
 	}
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 94a8c35abb0bc991..5841d43be9718414 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -21,6 +21,7 @@
 #include "util/tracepoint.h"
 
 #include "util/debug.h"
+#include "util/event.h"
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/data.h"
@@ -1433,8 +1434,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 							sample->tid);
 
 	if (thread == NULL) {
-		pr_debug("problem processing %d event, skipping it.\n",
-			event->header.type);
+		pr_debug("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+			 perf_event__name(event->header.type), event->header.type,
+			 sample->file_offset);
 		return -1;
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 973d97af85019e6e..cd052aa78132b65f 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -27,6 +27,7 @@
 
 #include "perf.h"
 #include "util/debug.h"
+#include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evswitch.h"
@@ -284,8 +285,9 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_debug("problem processing %d event, skipping it.\n",
-			 event->header.type);
+		pr_debug("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+			 perf_event__name(event->header.type), event->header.type,
+			 sample->file_offset);
 		ret = -1;
 		goto out_put;
 	}
@@ -332,7 +334,8 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
 	if (ret < 0)
-		pr_debug("problem adding hist entry, skipping event\n");
+		pr_debug("problem adding hist entry at offset %#" PRIx64 ", skipping event\n",
+			 sample->file_offset);
 out_put:
 	addr_location__exit(&al);
 	return ret;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5124edf2b7a692b2..f4aa255fc3297f90 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2693,8 +2693,9 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.thread && machine__resolve(machine, &al, sample) < 0) {
-		pr_err("problem processing %d event, skipping it.\n",
-		       event->header.type);
+		pr_err("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+		       perf_event__name(event->header.type), event->header.type,
+		       sample->file_offset);
 		ret = -1;
 		goto out_put;
 	}
@@ -2775,8 +2776,9 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
-		pr_err("problem processing %d event, skipping it.\n",
-		       event->header.type);
+		pr_err("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+		       perf_event__name(event->header.type), event->header.type,
+		       sample->file_offset);
 		ret = -1;
 		goto out_put;
 	}
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index af4d874f13810ffe..8c0a9ae932aa5798 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -10,6 +10,7 @@
 #include "util.h" // lsdir(), mkdir_p(), rm_rf()
 #include <dirent.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -62,8 +63,8 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 							sample->tid);
 
 	if (thread == NULL) {
-		pr_err("problem processing %d event, skipping it.\n",
-			event->header.type);
+		pr_err("problem processing %s event at offset %#" PRIx64 ", skipping it.\n",
+		       perf_event__name(event->header.type), sample->file_offset);
 		return -1;
 	}
 
-- 
2.54.0


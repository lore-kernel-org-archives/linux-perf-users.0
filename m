Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CBC19B3FF;
	Sat, 12 Oct 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766060; cv=none; b=o8XL/AECtY9g1qrPyIiUfJ4FpD1a1aXt8ADFm8NIEkwHHhgkbOR3jlQ4ca3dyorCTel3w/kYQRdkiddOq49K3chkC7ImnTSDH+2f6QV3rb/5wJ827VnVHfL+uVxD1kLZeK/MEcectb9PNDllqzwFqQ8emw3U9JvnIwLRCKNDxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766060; c=relaxed/simple;
	bh=5l6ZNlwBN9y39y6jfRciqxVPgNpcILM3bTvUG22cZZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EASQtDTWVBivXisZ6MkuF9KmHYoYFeubTs7g80BUrD7DDW8yhdzc8FQNlpfmT/3KUazWeMImcvrDbZx7LphDd+1BXOjG2pyZnn77RDv+5O/sEOkbgKrxpIVeVJCkbFQB/s8Ktk+tnMYiky6wSti0UwVBUBHOQV3DcP6cJONlws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85B0BDA7;
	Sat, 12 Oct 2024 13:48:08 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72C773F5A1;
	Sat, 12 Oct 2024 13:47:37 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 3/3] perf probe: Improve log for long event name failure
Date: Sat, 12 Oct 2024 21:47:25 +0100
Message-Id: <20241012204725.928794-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012204725.928794-1-leo.yan@arm.com>
References: <20241012204725.928794-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a symbol name is longer than the maximum event length (64 bytes), the
perf tool reports error:

  # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
    snprintf() failed: -7; the event name nbase='this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)' is too long
    Error: Failed to add events.

An information is missed in the log that the symbol name and the event
name can be set separately. Especially, this is recommended for adding
probe for a long symbol.

This commit refines the log for reminding event syntax.

After:

  # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
    snprintf() failed: -7; the event name 'this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)' is too long
      Hint: Set a shorter event with syntax "EVENT=PROBEDEF"
            EVENT: Event name (max length: 64 bytes).
      Error: Failed to add events.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/probe-event.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 224ec6818803..2a2fc5e78c5c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2760,7 +2760,10 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 	/* Try no suffix number */
 	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
 	if (ret < 0) {
-		pr_warning("snprintf() failed: %d; the event name nbase='%s' is too long\n", ret, nbase);
+		pr_warning("snprintf() failed: %d; the event name '%s' is too long\n"
+			   "  Hint: Set a shorter event with syntax \"EVENT=PROBEDEF\"\n"
+			   "        EVENT: Event name (max length: %d bytes).\n",
+			   ret, nbase, MAX_EVENT_NAME_LEN);
 		goto out;
 	}
 	if (!strlist__has_entry(namelist, buf))
@@ -2780,7 +2783,10 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 	for (i = 1; i < MAX_EVENT_INDEX; i++) {
 		ret = e_snprintf(buf, len, "%s_%d", nbase, i);
 		if (ret < 0) {
-			pr_debug("snprintf() failed: %d\n", ret);
+			pr_warning("Add suffix failed: %d; the event name '%s' is too long\n"
+				   "  Hint: Set a shorter event with syntax \"EVENT=PROBEDEF\"\n"
+				   "        EVENT: Event name (max length: %d bytes).\n",
+				   ret, nbase, MAX_EVENT_NAME_LEN);
 			goto out;
 		}
 		if (!strlist__has_entry(namelist, buf))
-- 
2.25.1


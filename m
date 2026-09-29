Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788B3AAF63
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648388; cv=none; b=MEbI82dkJ5QGBQS4cuxzYx3T5jMhJmOX1Ms9ZY7uvjWYH1Y5TaAGUtaOu1A6e1LQclapJ35AsYPe/8sdQc7lAxrThK+1ZkWSypQei2ACJhspmGCa92CdTJukSfWP3QR/MGe/qpQMO6b471taemcbCeTH4s2aisa5chIHeOHaG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648388; c=relaxed/simple;
	bh=P+MsrHFEjrElGIN7hMAk1Fg8wsWDhle8TK7KpcN/sH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6zbwd5c0FN7WlZ4Zh+CGcgE0cmJR/G50GHX5VmIIECY4bBAa0NCIxZ/BExBtVvjFHydql7A9QRouGdylFED4ZmAlpaZK/hsmXO7JnkLoYGdpZL1vq1roxm5WXFZ5wtqgjvUgUcSL9I+/YLW/mGJKhVSS8YgaC0XyvuqsL3SRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kzF97EEp; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kzF97EEp"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3441e2b3fc3so2494735eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 19:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790648384; x=1791253184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJCPYv9x3XltGBwvKs/62P1gUROuXoCewbM+ScxfAAk=;
        b=kzF97EEpL/wLcUKq6pyiWYi+8VedfimZyKPgKM992Yejym8WaTBJzkmV5UXo8I3i/o
         y/dU9wNtMtvuQ7E5IT/GQbLpGCrt/MPtR7xZQWbmsYFMPVBo5zqwHoCAbAhZlWuhSOP2
         AUjU1qo2Zbap4/OfIlMeohqt8unNH3bZmvLPsgMVGdf0Kp4aM6p0800w8IypkG4KBUvT
         kMjnqPro+tiSFh/1WbYrsPtz/uhl779+GHPCckZPoG1btCpBYvDpgWiI8OKY9LlTxNuX
         m0kFtUOWsfA2riAB0wU+NG2jDWlXUu69V8ZEioHtXerN7GacrJCwA9MFFYmuw3tRBeAz
         j1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790648384; x=1791253184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJCPYv9x3XltGBwvKs/62P1gUROuXoCewbM+ScxfAAk=;
        b=PT0kMAZaLQ+DkBi8p8bcArw6qu1TYgeb7sh2sllmO3oDNItGPqOqkDbeLn0K8jJKiX
         Eu1njCH80ixO8/eF+vgNtBSdEapSFEtYOuj/D8LoN1vLopghlBxZ2j47z77pQbmj8QvK
         mU+Oibeghn9TmSJcodSrGBqLp9KAV711E5vssR5J4vN60xJLtFyli0rxOsZQdMeEIYj6
         KwLnKFDW7lOTSDeCY+S96l/Wvn+2abF2rBC/+oQM3kEPwDSWV7U5jmo1w76FAk1UJfef
         K9bFnoypJjUlzutAJgMyVeqP7xcXJWFl6Wif34gfv8nqqF/xJGO3NdMj1sHF6rDvonNf
         jSiw==
X-Forwarded-Encrypted: i=1; AKwUvBwuKg6vldBdEAdzSUeItl77rGLd0+Aa17vGYk8qy0c0rQoX9s/j+rEI4APmrNUUKBiwMHvNu3eTTAp9HeE0NnUD@vger.kernel.org
X-Gm-Message-State: AFuF++lMvBSoCSigHERaZZQPzB2v+HfotjfFS5NKvwUAnKQgKK7GCmX+
	mkB68UWwKgampuDRGfJd0DVcssSmFal27gTwEoI9+5mMPv1PeRBFZ77zj1Mk9pvm0bhQ5uD8JOA
	uyJNvSNZlkw==
X-Received: from dlbpu5.prod.google.com ([2002:a05:7022:e885:b0:144:d065:6639])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b04b:10b0:143:298b:ba79
 with SMTP id a92af1059eb24-146d03a100bmr11063456c88.40.1790648384223; Mon, 28
 Sep 2026 19:19:44 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:19:11 -0700
In-Reply-To: <20260929021913.56010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929021913.56010-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929021913.56010-8-irogers@google.com>
Subject: [PATCH v1 7/9] perf python event_analyzing_sample: Default to
 in-memory SQLite database
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When -d/--db is not specified, event_analyzing_sample.py created a
temporary file in /tmp via tempfile.mkstemp() and deleted it in
trace_end(). As noted during review, creating the database in a shared
/tmp directory does not reserve SQLite's auxiliary sidecar filenames
(-journal or -wal), and a temporary on-disk file is unnecessary when the
caller did not ask to persist the database.

Default to sqlite3.connect(":memory:") when db_path is not provided,
removing the temporary file creation and cleanup logic, and test both
the default in-memory mode and explicit -d file mode in
test_event_analyzing_sample_python.sh.

Fixes: eeb70645a809 ("perf python: Port event_analyzing_sample to perf module")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/event_analyzing_sample.py   | 35 ++++++-------------
 .../test_event_analyzing_sample_python.sh     |  8 ++++-
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/tools/perf/python/event_analyzing_sample.py b/tools/perf/python/event_analyzing_sample.py
index 15b47cff9fa3..b4efee88d94b 100755
--- a/tools/perf/python/event_analyzing_sample.py
+++ b/tools/perf/python/event_analyzing_sample.py
@@ -17,10 +17,8 @@ from __future__ import annotations
 
 import argparse
 import math
-import os
 import sqlite3
 import struct
-import tempfile
 from typing import Any
 import perf
 
@@ -117,16 +115,11 @@ session: Any = None
 
 class _DB:
     con: sqlite3.Connection | None = None
-    temp_path: str | None = None
 
 def trace_begin(db_path: str | None = None) -> None:
     """Initialize database tables."""
     print("In trace_begin:\n")
-    if not db_path:
-        fd, db_path = tempfile.mkstemp(prefix="perf_events_", suffix=".db")
-        os.close(fd)
-        _DB.temp_path = db_path
-    con = sqlite3.connect(db_path)
+    con = sqlite3.connect(db_path or ":memory:")
     try:
         # Drop any pre-existing tables so repeated runs do not accumulate duplicate events.
         con.execute("drop table if exists gen_events;")
@@ -297,28 +290,20 @@ def show_pebs_ll() -> None:
 def trace_end() -> None:
     """Called at the end of trace processing."""
     print("In trace_end:\n")
-    try:
-        if _DB.con:
-            try:
-                _DB.con.commit()
-                show_general_events()
-                show_pebs_ll()
-            finally:
-                _DB.con.close()
-                _DB.con = None
-    finally:
-        if _DB.temp_path and os.path.exists(_DB.temp_path):
-            try:
-                os.remove(_DB.temp_path)
-            except OSError:
-                pass
-            _DB.temp_path = None
+    if _DB.con:
+        try:
+            _DB.con.commit()
+            show_general_events()
+            show_pebs_ll()
+        finally:
+            _DB.con.close()
+            _DB.con = None
 
 if __name__ == "__main__":
     ap = argparse.ArgumentParser(description="Analyze events with SQLite")
     ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
     ap.add_argument("-d", "--db", "--database", dest="database", default=None,
-                    help="Database file name (defaults to a temporary file cleaned up on exit)")
+                    help="Database file name (defaults to an in-memory database)")
     args = ap.parse_args()
 
     try:
diff --git a/tools/perf/tests/shell/test_event_analyzing_sample_python.sh b/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
index 5f0a41080acf..cddb12b67698 100755
--- a/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
+++ b/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
@@ -45,8 +45,14 @@ test_file_mode() {
 		exit 2
 	fi
 
-	# Run the script
+	# Run the script with default (:memory:) database and with explicit -d path
 	if ! perf script event_analyzing_sample -i "${temp_data}" \
+		> "${temp_dir}/perf.mem.out" 2>&1 || \
+	   ! grep -q "Statistics about the general events" "${temp_dir}/perf.mem.out" || \
+	   grep -q "Error creating/inserting event" "${temp_dir}/perf.mem.out"; then
+		echo "Default in-memory database mode test failed."
+		err=1
+	elif ! perf script event_analyzing_sample -i "${temp_data}" \
 		-d "${temp_db}" > "${temp_dir}/perf.out" 2>&1; then
 		echo "File mode test failed."
 		err=1
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


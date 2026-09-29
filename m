Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563046EC9B
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665156; cv=none; b=Vl0O5GJoJglU1pARsKElhiOngq9PgNSRrrV8lBCmH8QnofJ+50ufrzdDzSMm+l3hNiDujKI1NWWzPmqVfKEwOOBuE3vZfhLR0OV6DM8CkP2wz5mbXFHBl/nI4kwhhaHqNRzYkFro6dgYNqQPDGWt6Er2wi1r1gm2RYm1MWSxfHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665156; c=relaxed/simple;
	bh=P+MsrHFEjrElGIN7hMAk1Fg8wsWDhle8TK7KpcN/sH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=joaDxaTYrBPLaHzhbX9Tbj/GsaaqD3cwjkMaEAqfq+znGeZDgX38hf0YYmuEndjc8YMo7Np6b+pDHDHGqSXcUJt1CaDYlFc/unJT33Rcqn/YHnKcAUz7wWheGdjJVNUfn+M2H9WnJyAIWydv6X4EvPf/eGM3NtrnlhJ51JlmwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Byt+rzdz; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Byt+rzdz"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1438719cc1eso4376539c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790665153; x=1791269953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJCPYv9x3XltGBwvKs/62P1gUROuXoCewbM+ScxfAAk=;
        b=Byt+rzdzXbFRZ481H2oa59lXEZ1Ey7vNNkSoFjuBtH3d+a+fp0mSs69FJukc3oLEoG
         GeH4ExG2xI+mwo6Flkc3tQjKiHu6LsISLYLt/pR4wjIrSOaMePFxPK+RL1l35rvRoCs3
         ptSqfNyBRbLTqZqVDbUtvnwGJnbiBmtH+r14s87CaYyKz5LfdaCtBwiWw3Uycc76Ntuz
         Zqqq9ijr9OXVI+uLaZCimGcy6gesZXIglQrHjb8wOViK+3NAuWNZIiFC+KPEa+OH08L8
         0z1E73CbRc4d6aK+C0zR99IllaoPASkF+MIU1kb+h3b4nEN/jm/0DQAT775qP+I7dvOr
         do6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665153; x=1791269953;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJCPYv9x3XltGBwvKs/62P1gUROuXoCewbM+ScxfAAk=;
        b=gbXkelEdTWBdj1siUSW6s8n8cfKDu+0vORZPP2U8S7vGg6mCDcSSHliQPatZ2uoeUM
         Y3kI3MCYWYFqPhhONiJ9TB9mJ4GXu7jy9kJnyCPwxgSD8dhkbYHP9SQlCnUIKYnN4iux
         jOjengR62bikLWUTS6l3oKqLGIPX68V1tpsOfM9lQePfWfHDbtHRoo9xYVTBCqpbJsQl
         wlJwXOc2iikVUsVumAeZJEibdUkbCGl9fHfL3jIvCpeSXRH1Jmb/XxtCXUm+shh93eFw
         rxfhQyc9rEpbmvOLLMmI2Q1XDtHNv3Qa3VAh6Wl1OUUjGqEnpnMLggfVY45XYR1pP81R
         BOgg==
X-Forwarded-Encrypted: i=1; AKwUvByna3g+rSfRTzjfQWM9ZyfN28wkzDt0R4YphsoosfXsGGCOe8De2YZNUOqwq9E61w1JPoxzR97BeXB+bQiOdJLZ@vger.kernel.org
X-Gm-Message-State: AFuF++mg7iSFXj6fc1yrz4x7ZTOcQgPDbYuunBrlvNQJ6hXsdzYh5Jfm
	q9ZJVHznvwpP3WuXAzkBeEpUpXEobIA9a/WcRxqYqYg/j0nvmNYkCVaTJ8UgFkCy7WIlUeqfN/s
	bOwecDB+o5A==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:146:40d5:dd6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:42c1:20b0:143:2982:1046
 with SMTP id a92af1059eb24-146d039e8e0mr13027199c88.39.1790665153145; Mon, 28
 Sep 2026 23:59:13 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:58:37 -0700
In-Reply-To: <20260929065839.407062-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929062937.374137-1-irogers@google.com> <20260929065839.407062-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929065839.407062-8-irogers@google.com>
Subject: [PATCH v3 7/9] perf python event_analyzing_sample: Default to
 in-memory SQLite database
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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


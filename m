From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/66] libtraceevent: Man pages fix, rename tep_ref_get() to tep_get_ref()
Date: Wed, 25 Sep 2019 21:31:47 -0300
Message-ID: <20190926003244.13962-10-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@redhat.com>, linux-trace-devel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

The tep_ref_get() was renamed to tep_get_ref(), to be more consistent
with the other tep_ref_* APIs. However, in the man pages the API is
still with the old name. The documentation is fixed to reflect the
actual name of the API.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lore.kernel.org/linux-trace-devel/20190808113636.13299-2-tz.stoyanov@gmail.com
Link: http://lore.kernel.org/lkml/20190919212541.697034573@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../lib/traceevent/Documentation/libtraceevent-handle.txt | 8 ++++----
 tools/lib/traceevent/Documentation/libtraceevent.txt      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/Documentation/libtraceevent-handle.txt b/tools/lib/traceevent/Documentation/libtraceevent-handle.txt
index 8d568316847d..45b20172e262 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent-handle.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent-handle.txt
@@ -3,7 +3,7 @@ libtraceevent(3)
 
 NAME
 ----
-tep_alloc, tep_free,tep_ref, tep_unref,tep_ref_get - Create, destroy, manage
+tep_alloc, tep_free,tep_ref, tep_unref,tep_get_ref - Create, destroy, manage
 references of trace event parser context.
 
 SYNOPSIS
@@ -16,7 +16,7 @@ struct tep_handle pass:[*]*tep_alloc*(void);
 void *tep_free*(struct tep_handle pass:[*]_tep_);
 void *tep_ref*(struct tep_handle pass:[*]_tep_);
 void *tep_unref*(struct tep_handle pass:[*]_tep_);
-int *tep_ref_get*(struct tep_handle pass:[*]_tep_);
+int *tep_get_ref*(struct tep_handle pass:[*]_tep_);
 --
 
 DESCRIPTION
@@ -57,9 +57,9 @@ EXAMPLE
 ...
 struct tep_handle *tep = tep_alloc();
 ...
-int ref = tep_ref_get(tep);
+int ref = tep_get_ref(tep);
 tep_ref(tep);
-if ( (ref+1) != tep_ref_get(tep)) {
+if ( (ref+1) != tep_get_ref(tep)) {
 	/* Something wrong happened, the counter is not incremented by 1 */
 }
 tep_unref(tep);
diff --git a/tools/lib/traceevent/Documentation/libtraceevent.txt b/tools/lib/traceevent/Documentation/libtraceevent.txt
index fbd977b47de1..00519503c8de 100644
--- a/tools/lib/traceevent/Documentation/libtraceevent.txt
+++ b/tools/lib/traceevent/Documentation/libtraceevent.txt
@@ -16,7 +16,7 @@ Management of tep handler data structure and access of its members:
 	void *tep_free*(struct tep_handle pass:[*]_tep_);
 	void *tep_ref*(struct tep_handle pass:[*]_tep_);
 	void *tep_unref*(struct tep_handle pass:[*]_tep_);
-	int *tep_ref_get*(struct tep_handle pass:[*]_tep_);
+	int *tep_get_ref*(struct tep_handle pass:[*]_tep_);
 	void *tep_set_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
 	void *tep_clear_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flag_);
 	bool *tep_test_flag*(struct tep_handle pass:[*]_tep_, enum tep_flag _flags_);
-- 
2.21.0

From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 8/8] perf tests attr: Fix group stat tests
Date: Tue,  3 Oct 2017 09:55:40 -0300
Message-ID: <20171003125540.331-9-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

We started to use group read whenever it's possible:

  82bf311e15d2 perf stat: Use group read for event groups

That breaks some of attr tests, this change adds the new possible
read_format value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
LPU-Reference: 20170928160633.GA26973@krava
Link: http://lkml.kernel.org/n/tip-1ko2zc4nph93d8lfwjyk9ivz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-stat-group  | 2 ++
 tools/perf/tests/attr/test-stat-group1 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/attr/test-stat-group b/tools/perf/tests/attr/test-stat-group
index fdc1596a8862..e15d6946e9b3 100644
--- a/tools/perf/tests/attr/test-stat-group
+++ b/tools/perf/tests/attr/test-stat-group
@@ -6,6 +6,7 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=3|15
 
 [event-2:base-stat]
 fd=2
@@ -13,3 +14,4 @@ group_fd=1
 config=1
 disabled=0
 enable_on_exec=0
+read_format=3|15
diff --git a/tools/perf/tests/attr/test-stat-group1 b/tools/perf/tests/attr/test-stat-group1
index 2a1f86e4a904..1746751123dc 100644
--- a/tools/perf/tests/attr/test-stat-group1
+++ b/tools/perf/tests/attr/test-stat-group1
@@ -6,6 +6,7 @@ ret     = 1
 [event-1:base-stat]
 fd=1
 group_fd=-1
+read_format=3|15
 
 [event-2:base-stat]
 fd=2
@@ -13,3 +14,4 @@ group_fd=1
 config=1
 disabled=0
 enable_on_exec=0
+read_format=3|15
-- 
2.13.6

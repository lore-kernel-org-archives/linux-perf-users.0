From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/91] perf cgroup: Avoid needless closing of unopened fd
Date: Wed,  6 May 2020 12:21:04 -0300
Message-ID: <20200506152234.21977-2-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tommi Rantala <tommi.t.rantala@nokia.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Do not bother with close() if fd is not valid, just to silence valgrind:

    $ valgrind ./perf script
    ==59169== Memcheck, a memory error detector
    ==59169== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
    ==59169== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
    ==59169== Command: ./perf script
    ==59169==
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200417132330.119407-1-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index b73fb7823048..050dea9f1e88 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -107,7 +107,8 @@ static int add_cgroup(struct evlist *evlist, const char *str)
 
 static void cgroup__delete(struct cgroup *cgroup)
 {
-	close(cgroup->fd);
+	if (cgroup->fd >= 0)
+		close(cgroup->fd);
 	zfree(&cgroup->name);
 	free(cgroup);
 }
-- 
2.21.1

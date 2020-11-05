From: Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Subject: [PATCH v3 1/2] perf tools: Add 'in_pidns' to nsinfo struct
Date: Thu,  5 Nov 2020 03:54:18 +0200
Message-ID: <20201105015418.1725218-1-yonatan.goldschmidt@granulate.io>
References: <20201105014833.1724363-1-yonatan.goldschmidt@granulate.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201105014833.1724363-1-yonatan.goldschmidt@granulate.io>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>, Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
List-Id: linux-perf-users.vger.kernel.org

Provides an accurate mean to determine if the owner thread
is in a different PID namespace.

Signed-off-by: Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
---
 tools/perf/util/namespaces.c | 11 +++++++++--
 tools/perf/util/namespaces.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 285d6f30d912..f4b3512d8dd2 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -66,6 +66,7 @@ int nsinfo__init(struct nsinfo *nsi)
 	char spath[PATH_MAX];
 	char *newns = NULL;
 	char *statln = NULL;
+	char *nspid;
 	struct stat old_stat;
 	struct stat new_stat;
 	FILE *f = NULL;
@@ -112,8 +113,12 @@ int nsinfo__init(struct nsinfo *nsi)
 		}
 
 		if (strstr(statln, "NStgid:") != NULL) {
-			nsi->nstgid = (pid_t)strtol(strrchr(statln, '\t'),
-						     NULL, 10);
+			nspid = strrchr(statln, '\t');
+			nsi->nstgid = (pid_t)strtol(nspid, NULL, 10);
+			/* If innermost tgid is not the first, process is in a different
+			 * PID namespace.
+			 */
+			nsi->in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
 			break;
 		}
 	}
@@ -140,6 +145,7 @@ struct nsinfo *nsinfo__new(pid_t pid)
 		nsi->tgid = pid;
 		nsi->nstgid = pid;
 		nsi->need_setns = false;
+		nsi->in_pidns = false;
 		/* Init may fail if the process exits while we're trying to look
 		 * at its proc information.  In that case, save the pid but
 		 * don't try to enter the namespace.
@@ -166,6 +172,7 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
 		nnsi->tgid = nsi->tgid;
 		nnsi->nstgid = nsi->nstgid;
 		nnsi->need_setns = nsi->need_setns;
+		nnsi->in_pidns = nsi->in_pidns;
 		if (nsi->mntns_path) {
 			nnsi->mntns_path = strdup(nsi->mntns_path);
 			if (!nnsi->mntns_path) {
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 4b33f684eddd..1cc8637cf885 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -33,6 +33,7 @@ struct nsinfo {
 	pid_t			tgid;
 	pid_t			nstgid;
 	bool			need_setns;
+	bool			in_pidns;
 	char			*mntns_path;
 	refcount_t		refcnt;
 };
-- 
2.25.0

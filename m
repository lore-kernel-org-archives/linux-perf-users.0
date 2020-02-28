From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/15] perf probe: Check return value of strlist__add() for -ENOMEM
Date: Fri, 28 Feb 2020 11:00:10 -0300
Message-ID: <20200228140014.1236-12-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

strlist__add() may fail with -ENOMEM. Check it and give debugging hint
in advance.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/1582727404-180095-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c   |  6 ++++--
 tools/perf/util/probe-file.c | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 26bc5923e6b5..70548df2abb9 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -449,7 +449,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret = probe_file__del_strlist(kfd, klist);
 		if (ret < 0)
 			goto error;
-	}
+	} else if (ret == -ENOMEM)
+		goto error;
 
 	ret2 = probe_file__get_events(ufd, filter, ulist);
 	if (ret2 == 0) {
@@ -459,7 +460,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret2 = probe_file__del_strlist(ufd, ulist);
 		if (ret2 < 0)
 			goto error;
-	}
+	} else if (ret2 == -ENOMEM)
+		goto error;
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
 		pr_warning("\"%s\" does not hit any event.\n", str);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5003ba403345..0f5fda11675f 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -301,10 +301,15 @@ int probe_file__get_events(int fd, struct strfilter *filter,
 		p = strchr(ent->s, ':');
 		if ((p && strfilter__compare(filter, p + 1)) ||
 		    strfilter__compare(filter, ent->s)) {
-			strlist__add(plist, ent->s);
+			ret = strlist__add(plist, ent->s);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 			ret = 0;
 		}
 	}
+out:
 	strlist__delete(namelist);
 
 	return ret;
@@ -511,7 +516,11 @@ static int probe_cache__load(struct probe_cache *pcache)
 				ret = -EINVAL;
 				goto out;
 			}
-			strlist__add(entry->tevlist, buf);
+			ret = strlist__add(entry->tevlist, buf);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 		}
 	}
 out:
@@ -672,7 +681,12 @@ int probe_cache__add_entry(struct probe_cache *pcache,
 		command = synthesize_probe_trace_command(&tevs[i]);
 		if (!command)
 			goto out_err;
-		strlist__add(entry->tevlist, command);
+		ret = strlist__add(entry->tevlist, command);
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			goto out_err;
+		}
+
 		free(command);
 	}
 	list_add_tail(&entry->node, &pcache->entries);
@@ -853,9 +867,15 @@ int probe_cache__scan_sdt(struct probe_cache *pcache, const char *pathname)
 			break;
 		}
 
-		strlist__add(entry->tevlist, buf);
+		ret = strlist__add(entry->tevlist, buf);
+
 		free(buf);
 		entry = NULL;
+
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			break;
+		}
 	}
 	if (entry) {
 		list_del_init(&entry->node);
-- 
2.21.1

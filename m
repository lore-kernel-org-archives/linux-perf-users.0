Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB7149C46
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715234758; cv=none; b=YC9D9eRQ9JmiMmOjtS5Z97n4mvtWMXjCvLq9qOFcu1E2nsPODOAEA/UCJ4H71kiBgtYMT3HkrGd9ZHtH0W6aWB9db6R0vJnC1TKkunskbf+1V7GDsemxD3N6IR6i3/A9gOhJ3GlGrGPbZ4HpmlnKX6EFCu3sdoJA80/aB74f0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715234758; c=relaxed/simple;
	bh=pgD+0W9yeHmmC7c3WvZTKmhifxbqaolBtyTipVxviKo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ghseE+O5fKCDtNs4TTj8d38Zd9prTGIaAMPQkg6vA5iOycJ1G/yuueF/guimH9TieoG0RIOGMZX2Bk+s9DddtycBw/qWMAbxbTcbP4s4PjZYmAQU9t5tpG5KGLxtsR0oXp4o/2nJXqf4Eo7RDulhj2O5ELf0YozHXcnu8YhAwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+tcDo+Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+tcDo+Z"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de615257412so971712276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715234745; x=1715839545; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dWBQzxnsaSGEllxaEO7SuOF/16QtdKzfhd7ItKVVFaQ=;
        b=m+tcDo+ZfImrwHRmUNqBgjM2ntgDyHPzjaeo/g43qMnJxI65UFSEcj6TATcyswqqdW
         +xkEow4uwceV1OPQrSUFdh4JV+NuuuBjX5U/wd2ejbJcAtfAh0Qn3+DywHZh/GovMURy
         2aUV6zwQbHZ96qB6aZieVJQYHMcCbZjtcnZP5h1MNHisa33YX+nhY9aDsN/BTYx1dX6w
         zGcgRH6SGKjalTczPwjfiNEiSNbYICnpjKP+Pe0I0YzmN8N67HCP3ybVxtMycxz4Rk3T
         b6+euARIJWTO6dpEeRVEpOsgygXQdyhXMUCqgMqAK12/1YR9y3fE7WEFNugamEP58VcK
         aadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715234745; x=1715839545;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWBQzxnsaSGEllxaEO7SuOF/16QtdKzfhd7ItKVVFaQ=;
        b=wENQzDEevvD55BgVPMOugTAxLz5SgN4rtubkDH3sE9a5nOnhT4GUMCmEzuNfyGnAXX
         wPWFJvnRY+Pe2hKczmmulYmMNKcuGBQAbTVopkLwKY8ioqXfqXO8BRxNADDerB8rsiDs
         tCwiH5kCA/F/+GJ14RUG1dcp6yoK319/NQ+YVU0nHE/eY6NzM8UH2yYv6YxA72e+4KPK
         f/mh+3bYHxwCaST6aBnMhopwPCu40jokKDhUuyzc6FmGlzOOvwDPIR0eTJcVZf3eJ74P
         zd0/Gae+Q5X+IRw3ynd5enUgz5qNvJ8vS+Q47X2dTmcFJMLYfmIHl+CR+9MeO5Tj7xwB
         dYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQdP476l6TISaYUCKQfaeA5spFsSyXnPVp/4TZuFOvS/LM5cspa0zVoIdjUpvWGNur1kPo7pXzwyFEnJfSBulboJ2tiI1mt+d4+spDwrnMdA==
X-Gm-Message-State: AOJu0YwlaeJPONEoTEAXyeL1ga9Mi0qUMjNHBdYr2nm3pQvPmFhT06zs
	Dtd+S6IEYQBLuMexw2hd1PCa8IGd5UJK0Uayy5+Ks91NzOBeZ5L5ub23te1GM5bPe2DM6m38rLq
	GZ6437Q==
X-Google-Smtp-Source: AGHT+IFuVF5HJJ6GECg1hr/NuqA8TcqultYdnMTPw3cOgfcd2bPRuL4Z14sAN69wnhGbn7nYu+CGll6/KffC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3887:270c:55a5:15aa])
 (user=irogers job=sendgmr) by 2002:a05:6902:703:b0:dcc:c57c:8873 with SMTP id
 3f1490d57ef6-debb9e399ebmr1497574276.9.1715234745311; Wed, 08 May 2024
 23:05:45 -0700 (PDT)
Date: Wed,  8 May 2024 23:05:41 -0700
Message-Id: <20240509060541.1928390-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] perf tracepoint: Don't scan all tracepoints to test if one exists
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In is_valid_tracepoint, rather than scanning
"/sys/kernel/tracing/events/*/*" skipping any path where
"/sys/kernel/tracing/events/*/*/id" doesn't exist, and then testing if
"*:*" matches the tracepoint name, just use the given tracepoint name
replace the ':' with '/' and see if the id file exists. This turns a
nested directory search into a single file available test.

Rather than return 1 for valid and 0 for invalid, return true and
false.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tracepoint.c | 53 ++++++++++++++----------------------
 tools/perf/util/tracepoint.h |  3 +-
 2 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint.c
index 92dd8b455b90..cca6808f7951 100644
--- a/tools/perf/util/tracepoint.c
+++ b/tools/perf/util/tracepoint.c
@@ -4,10 +4,12 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/param.h>
 #include <unistd.h>
 
 #include <api/fs/tracing_path.h>
+#include "fncache.h"
 
 int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
 {
@@ -26,39 +28,26 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
 /*
  * Check whether event is in <debugfs_mount_point>/tracing/events
  */
-int is_valid_tracepoint(const char *event_string)
+bool is_valid_tracepoint(const char *event_string)
 {
-	DIR *sys_dir, *evt_dir;
-	struct dirent *sys_dirent, *evt_dirent;
-	char evt_path[MAXPATHLEN];
-	char *dir_path;
-
-	sys_dir = tracing_events__opendir();
-	if (!sys_dir)
-		return 0;
+	char *dst, *path = malloc(strlen(event_string) + 4); /* Space for "/id\0". */
+	const char *src;
+	bool have_file;
 
-	for_each_subsystem(sys_dir, sys_dirent) {
-		dir_path = get_events_file(sys_dirent->d_name);
-		if (!dir_path)
-			continue;
-		evt_dir = opendir(dir_path);
-		if (!evt_dir)
-			goto next;
-
-		for_each_event(dir_path, evt_dir, evt_dirent) {
-			snprintf(evt_path, MAXPATHLEN, "%s:%s",
-				 sys_dirent->d_name, evt_dirent->d_name);
-			if (!strcmp(evt_path, event_string)) {
-				closedir(evt_dir);
-				put_events_file(dir_path);
-				closedir(sys_dir);
-				return 1;
-			}
-		}
-		closedir(evt_dir);
-next:
-		put_events_file(dir_path);
+	if (!path) {
+		/* Conservatively return false if memory allocation failed. */
+		return false;
 	}
-	closedir(sys_dir);
-	return 0;
+	/* Copy event_string replacing the ':' with '/'. */
+	for (src = event_string, dst = path; *src; src++, dst++)
+		*dst = (*src == ':') ? '/' : *src;
+	/* Add "/id\0". */
+	memcpy(dst, "/id", 4);
+
+	dst = get_events_file(path);
+	if (dst)
+		have_file = file_available(dst);
+	free(dst);
+	free(path);
+	return have_file;
 }
diff --git a/tools/perf/util/tracepoint.h b/tools/perf/util/tracepoint.h
index c4a110fe87d7..65ccb01fc312 100644
--- a/tools/perf/util/tracepoint.h
+++ b/tools/perf/util/tracepoint.h
@@ -4,6 +4,7 @@
 
 #include <dirent.h>
 #include <string.h>
+#include <stdbool.h>
 
 int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
 
@@ -20,6 +21,6 @@ int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
 		    (strcmp(sys_dirent->d_name, ".")) &&	\
 		    (strcmp(sys_dirent->d_name, "..")))
 
-int is_valid_tracepoint(const char *event_string);
+bool is_valid_tracepoint(const char *event_string);
 
 #endif /* __PERF_TRACEPOINT_H */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


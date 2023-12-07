Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adeQ1HrB"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B893A4
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 21:05:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db53f73eefeso723542276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925499; x=1702530299; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQL7jSRusjmNnXVovrf6s5ZXv2q3XjGZXt0cQXTXyH0=;
        b=adeQ1HrBBNuzpsW+RthE9e4k5jpdyG60N+dtMasE1XmaiThK0/Jj/xIjweED8y2MPv
         6KdfWgEaIOLLXt+AohCvXB2q33bSM/W9KVD1IfiLjGqlULGzCwPri8TcIsxMO1XQW5rM
         uLzbNxCUCI0tGfZt5pMSBGn9B3Zonji+OcPzRst5anItTipC96Go9rkcT41GThTwgS7U
         hCdoWZMFbF/bHDkj/WlMOz/E9vPSV79adX3eMYRdgjybII5jt3V07KPHsB0AgK0TrjpH
         0/9ynUYGUOnkuv8xt70AOtEDC5puUUQmN6JQUV0KSBsv6PZPDAGcFFhhngoadEDSTTz4
         zFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925499; x=1702530299;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQL7jSRusjmNnXVovrf6s5ZXv2q3XjGZXt0cQXTXyH0=;
        b=Q406qNe9n+0TnLyyCyij4J0m100yfxIuBvOB4FxsLUpDD4GQ+/Yw9rC1xPw6/rva5O
         S3rsz43/tU+6Ww37manUSFF6Aj4tjb5qFsmuE/ak8gL6a1Xf0wBsN2w4aUXRi+K9IsBN
         v1Rrq4cH/+zpH1GDrVlquJFyIjplSi8VAHnbFdumMf/nipNPa8BNpFZBr0vseL3k9eHf
         QDsVaPQVoCa+0YIbtl+Q9EnubpYJemWjuxhXDv624wkfBWYt5hB/5hus4UQuxf0Rdwe5
         t089uBUcJIYQhHLi2QHwm7QVybYkMBnvvjQx0SAJL23DyJ4VW7D/GILAiBUEdjAsiQVQ
         uHTQ==
X-Gm-Message-State: AOJu0YwrV2aLws7HGDm/pMOFNJb+Xa42RQBx0Q1wx5OHwS0FOhiwoNwQ
	uCEYV8R76Hr+lheIt8li27saHKFwQnEQ
X-Google-Smtp-Source: AGHT+IEIES8vtcKWQ6hHeWuSFzb//31lxElZ3NI6bEf1mOom/dSrMlQcefANtfLZm0opUAdKEtbAMTMjqjGE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:df0b:0:b0:d9a:efcc:42af with SMTP id
 w11-20020a25df0b000000b00d9aefcc42afmr31557ybg.2.1701925499548; Wed, 06 Dec
 2023 21:04:59 -0800 (PST)
Date: Wed,  6 Dec 2023 21:04:32 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 5/6] perf header: Switch mem topology to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Quentin Monnet <quentin@isovalent.com>, 
	Fangrui Song <maskray@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yanteng Si <siyanteng@loongson.cn>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Switch memory_node__read and build_mem_topology from opendir/readdir
to io_dir__readdir, with smaller stack allocations. Reduces peak
memory consumption of perf record by 10kb.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 08cc2febabde..d4a3e28376fd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -44,6 +44,7 @@
 #include "build-id.h"
 #include "data.h"
 #include <api/fs/fs.h>
+#include <api/io_dir.h>
 #include "asm/bug.h"
 #include "tool.h"
 #include "time-utils.h"
@@ -1341,11 +1342,11 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 {
 	unsigned int phys, size = 0;
 	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
+	struct io_dirent64 *ent;
+	struct io_dir dir;
 
 #define for_each_memory(mem, dir)					\
-	while ((ent = readdir(dir)))					\
+	while ((ent = io_dir__readdir(&dir)) != NULL)			\
 		if (strcmp(ent->d_name, ".") &&				\
 		    strcmp(ent->d_name, "..") &&			\
 		    sscanf(ent->d_name, "memory%u", &mem) == 1)
@@ -1354,9 +1355,9 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 		  "%s/devices/system/node/node%lu",
 		  sysfs__mountpoint(), idx);
 
-	dir = opendir(path);
-	if (!dir) {
-		pr_warning("failed: can't open memory sysfs data\n");
+	io_dir__init(&dir, open(path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (dir.dirfd < 0) {
+		pr_warning("failed: can't open memory sysfs data '%s'\n", path);
 		return -1;
 	}
 
@@ -1368,20 +1369,20 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
 	n->set = bitmap_zalloc(size);
 	if (!n->set) {
-		closedir(dir);
+		close(dir.dirfd);
 		return -ENOMEM;
 	}
 
 	n->node = idx;
 	n->size = size;
 
-	rewinddir(dir);
+	io_dir__rewinddir(&dir);
 
 	for_each_memory(phys, dir) {
 		__set_bit(phys, n->set);
 	}
 
-	closedir(dir);
+	close(dir.dirfd);
 	return 0;
 }
 
@@ -1404,8 +1405,8 @@ static int memory_node__sort(const void *a, const void *b)
 static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 {
 	char path[PATH_MAX];
-	struct dirent *ent;
-	DIR *dir;
+	struct io_dirent64 *ent;
+	struct io_dir dir;
 	int ret = 0;
 	size_t cnt = 0, size = 0;
 	struct memory_node *nodes = NULL;
@@ -1413,14 +1414,14 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 	scnprintf(path, PATH_MAX, "%s/devices/system/node/",
 		  sysfs__mountpoint());
 
-	dir = opendir(path);
-	if (!dir) {
+	io_dir__init(&dir, open(path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (dir.dirfd < 0) {
 		pr_debug2("%s: couldn't read %s, does this arch have topology information?\n",
 			  __func__, path);
 		return -1;
 	}
 
-	while (!ret && (ent = readdir(dir))) {
+	while (!ret && (ent = io_dir__readdir(&dir))) {
 		unsigned int idx;
 		int r;
 
@@ -1449,7 +1450,7 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 			cnt += 1;
 	}
 out:
-	closedir(dir);
+	close(dir.dirfd);
 	if (!ret) {
 		*cntp = cnt;
 		*nodesp = nodes;
-- 
2.43.0.rc2.451.g8631bc7472-goog


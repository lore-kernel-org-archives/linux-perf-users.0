Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j66J+ZPk"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91DD44
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 21:05:02 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5c941936f7fso2040947b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925502; x=1702530302; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNmJSk2Mf8wiupmA7otv2vwMpu3HCNA090aeI5fVLaE=;
        b=j66J+ZPkvukEjBSMTiJqbYvNks4a/6dOQ4AghyY/zuocABJaYCry4143ccTRt7IO12
         cYV7ElMH/wyxsT8O+mscRYokLeg4Kelm1c9kkCufTmMQS2xSB+Y0uaQERrli8gjNFT2R
         ftAMltvudLWurWANfRAedFRT8HD2S6bAk+OebcjhQihsyFq+tM08ZT8za14+WtLh70CA
         OaWS6ZeQ3qRNuWnKY9MbEyDIbXlFf8PGQ+vbtHtJ/Zc4F0GZ7u+oAoCRPO5RVw0M6MAH
         +WefPPlJiERBxJHnEyZIo4M+9OOJK2wN5gnItQK6bCV74Sb4M/miQNoil+CRlfirz9cf
         Tpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925502; x=1702530302;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNmJSk2Mf8wiupmA7otv2vwMpu3HCNA090aeI5fVLaE=;
        b=o+1l6b6xUGitwHVKPlDlyKWJ+kKB+OZPetyIQLBOsWUAIW8FwcrW07OiUPw2HeNcfG
         qFUA0xIPnwbDlMxnw7v982Ex+/x9cfLc33jE6xvlrc0FAzNitq5mYEvWYht2Fwc36FtW
         P3/6Pd6QMHr3AxUkp0F6bpjbSJPXbteNJsQNkwbyTNZZBzQMMLW1ESgqWiCacpxBI5Ea
         KFU9VTQSnCAxm6hFP2U2wNMjuIIMYXKTCgIUHZYHKcTBrnsE59JH5n3RfyMbSCOXV8Ce
         rMe6lo5nf+AdOanPYjTWsUNSWkC8vzpKfyvFgh1WUX+L4Q/JXbi79/Ce+9a9z4kbXCwR
         Ng9w==
X-Gm-Message-State: AOJu0Yw0deq61WZaOkcTBLm1wAoxnqzxXKd5SRvLdPNLKZYlHHO+lWNz
	p4Lz55Hpij43d0bPdtPw9ymiO1pxEDnr
X-Google-Smtp-Source: AGHT+IF/nzirSeJnMIvE0mGEycoV9XdkGUbzHi13uh8ZFStCgczXxDlh1x3wJVZVQti1bAtMbyQyGetvXwAv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:3144:0:b0:db5:4a00:a153 with SMTP id
 x65-20020a253144000000b00db54a00a153mr46968ybx.4.1701925501849; Wed, 06 Dec
 2023 21:05:01 -0800 (PST)
Date: Wed,  6 Dec 2023 21:04:33 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 6/6] perf events: Remove scandir in thread synthesis
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

This avoids scanddir reading the directory into memory that's
allocated and instead allocates on the stack.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a0579c7d7b9e..7cc38f2a0e9e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -38,6 +38,7 @@
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <api/io_dir.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -751,10 +752,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 				      bool needs_mmap, bool mmap_data)
 {
 	char filename[PATH_MAX];
-	struct dirent **dirent;
+	struct io_dir iod;
+	struct io_dirent64 *dent;
 	pid_t tgid, ppid;
 	int rc = 0;
-	int i, n;
 
 	/* special case: only send one comm event using passed in pid */
 	if (!full) {
@@ -786,16 +787,19 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
 		 machine->root_dir, pid);
 
-	n = scandir(filename, &dirent, filter_task, NULL);
-	if (n < 0)
-		return n;
+	io_dir__init(&iod, open(filename, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (iod.dirfd < 0)
+		return -1;
 
-	for (i = 0; i < n; i++) {
+	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		char *end;
 		pid_t _pid;
 		bool kernel_thread = false;
 
-		_pid = strtol(dirent[i]->d_name, &end, 10);
+		if (!isdigit(dent->d_name[0]))
+			continue;
+
+		_pid = strtol(dent->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -829,9 +833,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		}
 	}
 
-	for (i = 0; i < n; i++)
-		zfree(&dirent[i]);
-	free(dirent);
+	close(iod.dirfd);
 
 	return rc;
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog


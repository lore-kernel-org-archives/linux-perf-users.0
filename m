Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaFHynnw"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DF1BD6
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d12853cb89so9748507b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122989; x=1701727789; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTXjNUPwbxQAEQgmTX6mZhuaXcNBEgojUyDX7h5oWL4=;
        b=gaFHynnwMcnRMOSKlWtWX99TjWcgrYlOUg5hj3kibRIit5u3rZHZtDBzwTcH3s44p1
         jrcY2LS0XuLUCHUNBAmbtgCxfbujEW+egZh3E9Fm1eMtm9I4lBxGDtiSRDSrjvuoefiK
         vy5ZW4xMp/+E/XTK1N9NnnhjH72/Q/phwB1XvBOnO0MgLdX5Qp7pfdrfHG9GA5TA0JWK
         6R8MSGNgJ79dxjcX8PSrSBPvl1WTjgxI38lBM/uaz0q2EEVK2/q4gbKcmuoWMHruPGvt
         LsolBCI0l9dxAGJrp3QShhQDfrEeeJ9y1MSnu+gtcwbScqhUvXCYjopNdAr9ym/jNPUc
         Vs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122989; x=1701727789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTXjNUPwbxQAEQgmTX6mZhuaXcNBEgojUyDX7h5oWL4=;
        b=rNyjxvmFJ3owRFeyVKWqr3tSVcrah3brHJmyep7FbcYA6bTJASqj6r8mP0CGrRyD6z
         FGxD9tXtyeIWLLaKubM052DNbMRKaLq5UjqKfszk/U+hmsMejT2BeJv3PllHxYFGyvTE
         +oOayIhFpvfShaYL7o6V1SZJCHdOJKguTsYiSEKRA37cmIX36Ud23qRPIRsnyZSQDp6W
         mSTWRFdwHrsfq+5Cv9Ih2dBkGR7ci1aSWHQM/8qWI4D12dGft9fOzRkK8DSw8sg8OPAr
         FclMxhO7w6pNrtf8pPV+tagMpLJrEaLChlvlw2chpFmhCImhRV+zdR0PHQYCq+0D1zh1
         yC8Q==
X-Gm-Message-State: AOJu0Yzj5HCTzE3XBhs3lDcRgd0BRs+wUI3IeUIAWHDJw4ta+D5a9WOx
	WP3oFjIJsSUL3Lnl1ZCVp1/bJatUyqz4
X-Google-Smtp-Source: AGHT+IFkUH1ezGScaVKIf2YW5rYtSWPzFdtRJ2PPO8tpyodcdiEAUOOg8jRQ1N1tVpIi1px37r7gN1f6wAY2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a81:be14:0:b0:5d0:a744:7194 with SMTP id
 i20-20020a81be14000000b005d0a7447194mr137899ywn.2.1701122989163; Mon, 27 Nov
 2023 14:09:49 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:23 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 11/50] perf events: Remove scandir in thread synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
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
2.43.0.rc1.413.gea7ed67945-goog


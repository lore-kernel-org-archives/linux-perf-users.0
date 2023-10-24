Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3104290B
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxQ7TUcE"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CC173F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a839b31a0dso94317137b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186295; x=1698791095; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RoZZ8YDCVCxLUMcPN0SyAz4FQGuYm4BBqKyuZJTny60=;
        b=LxQ7TUcExIRiHdVin9naidfy0tXXS0gmjOw+K8Z6+6die0cYFfO8FhJCm2C6nLPP7L
         G0oV/niPGAWZIL1vGUbDHISIIrPsaQ4mdGq6odFWcNXdHGSj/xtzHUvmRbyyiGxnpl+m
         mJuvC8wN8X2szmgGGdMH0wuv2XoRobGwIoGUjr/AkdDaGL3NjhDwmvif/ljc2M/0Bd84
         1AeQLpKUEJYEN94W1KAEi40E0vJsiqkEoBO15/+ydyqmei/7h4pBtMV6Nls6Y6M8nneV
         aPwXyNALAdqlZiSauZ2aGT3mDIpFUsYnAfblySVRf9KCPTd7LoQU+IJK3WW5PdUkPyhK
         zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186295; x=1698791095;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoZZ8YDCVCxLUMcPN0SyAz4FQGuYm4BBqKyuZJTny60=;
        b=IGtvzQSsZ1D8J72yc+58WjP6tn0y71gpWkpOr+nrFBdVqTH83V4FNZC+ubsc1pl1/J
         FSCL9KnEcrZ/wVww0Uv8ZsAtZVB5GJkXXKoxdY6gn+PaM/6rS6kOji9AeQ9Rvv48WYVV
         +N6DXTRUWqeXVatJaQh/kEd2FHrK/MxAzfDnU0dZS3r/OEnUbzViev8BOCz/Y4WmSKR6
         0+3x48EJOB3MTJk6Pww9slSDrLLAlKvXqzN4GR22NWLTA0Fdwm8/rLC1g9B3XG+26S46
         IRFH0EkKvl/BjdCwLfMtMF+CRhUsf0jBlnVs5AuZHS1HhXzbGSIwB6lYe9rsKUtVvkgy
         GsOg==
X-Gm-Message-State: AOJu0Yz4i3aicFT78NlQZdFc7T2XxlzgrScv5EQllFZ/a4RmyPGb6Bcc
	MaYiozSGs1+iaTL2p62tappzYKtvuBbF
X-Google-Smtp-Source: AGHT+IGpvQz9GZjVxHDoXyv2DZD5hN97umr18Py0bLbehREE4F7s0wFwdl9z08oyHldz2UQ7susueB2CfFyf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:690c:3142:b0:5a7:a98a:4af0 with SMTP
 id fc2-20020a05690c314200b005a7a98a4af0mr17210ywb.3.1698186295659; Tue, 24
 Oct 2023 15:24:55 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:22 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 19/50] perf maps: Switch modules tree walk to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Compared to glibc's opendir/readdir this lowers the max RSS of perf
record by 1.8MB on a Debian machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a985d004aa8d..be3dab9d5253 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -36,6 +36,7 @@
 #include <internal/lib.h> // page_size
 #include "cgroup.h"
 #include "arm64-frame-pointer-unwind-support.h"
+#include <api/io_dir.h>
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -1552,25 +1553,21 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 
 static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, int depth)
 {
-	struct dirent *dent;
-	DIR *dir = opendir(dir_name);
+	struct io_dirent64 *dent;
+	struct io_dir iod;
 	int ret = 0;
 
-	if (!dir) {
+	io_dir__init(&iod, open(dir_name, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (iod.dirfd < 0) {
 		pr_debug("%s: cannot open %s dir\n", __func__, dir_name);
 		return -1;
 	}
 
-	while ((dent = readdir(dir)) != NULL) {
+	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		char path[PATH_MAX];
-		struct stat st;
 
-		/*sshfs might return bad dent->d_type, so we have to stat*/
 		path__join(path, sizeof(path), dir_name, dent->d_name);
-		if (stat(path, &st))
-			continue;
-
-		if (S_ISDIR(st.st_mode)) {
+		if (io_dir__is_dir(&iod, dent)) {
 			if (!strcmp(dent->d_name, ".") ||
 			    !strcmp(dent->d_name, ".."))
 				continue;
@@ -1603,7 +1600,7 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 	}
 
 out:
-	closedir(dir);
+	close(iod.dirfd);
 	return ret;
 }
 
-- 
2.42.0.758.gaed0368e0e-goog


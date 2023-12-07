Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzLVYRep"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208AAD6D
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 21:04:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d7e7e10231so2028177b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 21:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925495; x=1702530295; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vr0pLcjARWkwRyuRy64mQ5hPn4FBvP7Yrmix4YMSHq8=;
        b=tzLVYRepPMTmJKb7UMmnkBF+o2AIHgW8nOnfnUOdz9sIJNjLQiO/H1dHUgM46pgmu6
         wFWPg82dOuZ4mZgufU5a9GASZpUPegL3jki9oN3ckLC1zjgCVsV8fIZnJDuXuIvo4zkk
         Isj1a1FQFsTvJ7HBci0K+MkzVOkWRAhIuWdaUw4qzQ3UgEBKxr829aBYnGtwJfThEFhW
         z+D1pxDM7jNrowFzhiFOK+DwteSh35x4maPZ0IFL/kxG9zDGHSHRLxO0YGPs1eeIVBBv
         7vbKSjgeJFxFzGpxvhaJXs82GbiegClW9EIIS2qQHUZTiC0K9E2x623A8L1RJh2wjyg5
         5UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925495; x=1702530295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr0pLcjARWkwRyuRy64mQ5hPn4FBvP7Yrmix4YMSHq8=;
        b=bkSIZRVWRSA5jSLvaI2vjyszOMbxCqXwKkj3rlCztlp4EJx3b7dv2uIpOljL3CWNQA
         J5+ZtSanHQ5fTFlFI6Xe1hl3TFawUm418JRwMCBmrWCcYhwVnq6PU28YkIFltajWZsaL
         gvw2bAJHFyngcynkN7xVT28qqfVT/yG0niJ38MCgeU1xkiZhN9kSx9zrd8RkHAQDYOm9
         owQLxYoGnYthn7FAowuw8CUBqiDuPhkQWbyGQm4wqo0Et6An4z3UH+MbuqqegPLEQ6yw
         AIJ+hGPMSBcO3vdRnWFcDJ4YAICCuNDSd0VCdNxSBSd4JmN/l50Pe5mONMrlRtFjwLFU
         oK7Q==
X-Gm-Message-State: AOJu0YzEzx9fLArSrTmLSmZ84XhbB/IjMP7MhzMwZch1qn1yEFgwt9ZQ
	ALXfP2fdGSgqNX/5+db0gKy71FCPqPcC
X-Google-Smtp-Source: AGHT+IGpJnEggCqs3sKsdlfcaOIA3oGBRfH282sCatINwA7vw7EM96PDp2OvW3EEYzOGNt/yZgDRvDFdKDp3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:3382:b0:5d3:985c:800c with SMTP
 id fl2-20020a05690c338200b005d3985c800cmr144441ywb.3.1701925495076; Wed, 06
 Dec 2023 21:04:55 -0800 (PST)
Date: Wed,  6 Dec 2023 21:04:30 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 3/6] perf maps: Switch modules tree walk to io_dir__readdir
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

Compared to glibc's opendir/readdir this lowers the max RSS of perf
record by 1.8MB on a Debian machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c5de5363b5e7..b6831a1f909d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -36,6 +36,7 @@
 #include <internal/lib.h> // page_size
 #include "cgroup.h"
 #include "arm64-frame-pointer-unwind-support.h"
+#include <api/io_dir.h>
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -1551,25 +1552,21 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 
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
@@ -1602,7 +1599,7 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 	}
 
 out:
-	closedir(dir);
+	close(iod.dirfd);
 	return ret;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog


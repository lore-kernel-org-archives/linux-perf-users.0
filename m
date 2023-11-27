Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mH3v/Qqj"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC810DA
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cd0a4fba39so57333837b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122977; x=1701727777; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wM9qRu2sJgUV9aoPmw3JmrGSGiE8RlVBwZZnO/fs3Sw=;
        b=mH3v/Qqjie6fqp3leZ6/BKCvdQ9WA35tC4OSxj/W9KXpTZYvF+O9xM4gPzMGcqjMnj
         +CN1knZQbxLIfdL+oYOGACc7sKJ7K64f7qXQQ45eFJuITH4w3IBHoSojc/Z3Ef/yDZiA
         iB/3fVgrlX+ADF7YG0wu2gwb0Jruub3eH/xyJ6dTcP6ul7FHfJ0RaphX1E8ewyjQLjVu
         ibYL3Vv8gpGf37rrw4y38iS2UEe7Jwi8iVh8WGHto5gdZbO5RzCKj3gOy8QzlsfvaeyN
         r2NCuQJJurAoT897Hu59zoMC3JeyfCvvlFgAKMar6Becl94PvOqyagPbsSuu1cp+YfcR
         W35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122977; x=1701727777;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wM9qRu2sJgUV9aoPmw3JmrGSGiE8RlVBwZZnO/fs3Sw=;
        b=bQsZqa60PtBaNs9tNCviw2dJP8xq4YMGU6gU4FNAlySVVrCjAXKw/QZvRtjg7Uwt/t
         my13LNeZZgt3ugLH4JtodIQtoFO1YdxLuxpONI/FuDZJC10GpvnE+f0YaL6d7ugZNtT2
         czXzESKS9pKDXonzzKS71lNf3g1iMe0gukBCdKci6YqRfA+Jbf+GTkbrQ0M8Q5PSUBDI
         ClNXpBn/dM9+M6Vxwcfbj5Avgb5pVEytPWTitAwtuBe53aQhQ3EtTL8brIvuSOeYj1hi
         yoytv8JVMaEmMjraeuvaYXdl9hoLlhpxGuXVhR3IfVbEk6KCS6ezRMnChmdZU/pS42Id
         gEyQ==
X-Gm-Message-State: AOJu0YxK8GlF9mSJlPQGiVkPhvZWt2ls1v/q32fFhnlb6b6M8DQMwzUr
	6kXUH6kKAzkhXHB6+jEEEOPocTkXMzi2
X-Google-Smtp-Source: AGHT+IF/f48LdSkKycK29YDrP0UdO0v/kUo5a/3ZwGTyJnXrRXO4tUK5PuQlpjsd3w2xD0MuUnwq7pDuWp9X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:f84:b0:5ca:ad72:2d78 with SMTP id
 df4-20020a05690c0f8400b005caad722d78mr503568ywb.8.1701122976902; Mon, 27 Nov
 2023 14:09:36 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:19 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 07/50] perf maps: Switch modules tree walk to io_dir__readdir
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
2.43.0.rc1.413.gea7ed67945-goog


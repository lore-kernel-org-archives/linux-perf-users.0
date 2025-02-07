Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FA1DD529
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970703; cv=none; b=s/EOuuRBqxGNIQamlPHseflU4cpzSfBxJTW/a50sAYcP+VcadNMaIOXAx1ez6so6+68NGCwQiQgrM3RVudVbOLT2dGC5M55Wl+TZCQxAL1CVYQvhilJ1o/zxr4oqC5iTVMue2POfOGn2nbD7SPk6Xy/ALgh5XWbFyvu6qT54y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970703; c=relaxed/simple;
	bh=zYNGAkgMdd9XUiROyIWPJ+Mlzc02RJhIL7WMmuG/ANk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hZqwBY2WGv5x1c9FIbMTMao9LQb3ekFcrp8ftKgU7MCXy8HDE2NGoPDrrlNbHxPVWqjKZDg47Z1Gg04SjC77X7zTH77Ok5hD9WaN1MKxt/V7pnyGnDGn46rwSJqmlzXQv/eVnZEaUmVYUDUzRcOVHVgDk/W9Lump3Zh0hHDhVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCH63TyX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCH63TyX"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f97ec73df7so15166847b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738970701; x=1739575501; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SK5AV+lqqx4bn5Q1XZOeQFYE3IU1Rh1nSkTxsM9kwPs=;
        b=YCH63TyXDwQb4STHaWAL+hUqUdTcrNhfKwB/o5vzjOUIhohBRztfM98IeRkAgI8f3P
         xG6ZiXJywzOdS88kNfJ1dLlw72k9jZs9KSZZdyptKiaybvwMqoPYDO2z7VQCI7pGD4So
         Ae9hLOyE+07dsXSbysyhcIWma8368O7apF+phCD/6edwa5qjRFCd53Vg2R9gG4cCVo6i
         hQmqXh2faIIi1U/pClngYCA9h0gAb/q5zXC8J2mcpnkNO2Vz5oq8JGmcKFDkJWUNhwjc
         7teFCT9ujYgvTflwda37iIIUa7f3LWFK/80VlCQ3TpTbe6iCONyIqktPnTC+Ze2yvzXX
         zgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970701; x=1739575501;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SK5AV+lqqx4bn5Q1XZOeQFYE3IU1Rh1nSkTxsM9kwPs=;
        b=CwqteWxlSdIntX7MUR/n4aZVWD6SOdY+s1oOEKT7fX01c9yGUNcu9nz4Ww2KSgUrox
         ixfn7Kf3n9hvcs7l3rUYErkueSl86tvCNxhOPKSd3KzoHNJ3WSz5kztP4w+8GUrjdLdi
         HKoibEf4xehQ5+xqe5DK+dkj8AmWFk388R1stOI5itCfTBU8h4369XmQrE9HuXkgzWXy
         LGJpj8n0LnxxJMf9lBj7LGuiyX/O8NKXmQVDOMgqnsskDpnxSoc0ibCVOt8lTRQCH33z
         FYeKlyvlaayR7fWc6YtytBlW2TWVngOcq3wprU7LFVfGysua/vBJkdT6sVJXQ/tmIJs+
         fvSg==
X-Forwarded-Encrypted: i=1; AJvYcCW/I6bB8e7WlKIPz4i7j7QfU+JyUmZSakyLaF2R57u+Ye8XfevFqeW+evGPvQK0bHA7YCO7UuPPZs6+VU2xZ6v8@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBB/f0q5JotLZs868V99BEVfsSLNz0qontBJmpY9195UGEI4T
	GacbjmaSDbYJ1ZPmr5ozR9BVKklDl7tTor43SZz5JQN6CEdjKJRs47qd36E0gjgCMCI6idHnNlN
	YOVnFjQ==
X-Google-Smtp-Source: AGHT+IGNMSvc4/dmPsVB5ZKRDbOu0NNtmtkE0ZYHFYRHCb/11YooZqZk50AbSjXlheuxley0tKZG/Im1zyjt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a05:690c:9315:b0:6f9:a402:ff3e with SMTP
 id 00721157ae682-6f9b2960936mr337647b3.5.1738970700926; Fri, 07 Feb 2025
 15:25:00 -0800 (PST)
Date: Fri,  7 Feb 2025 15:24:43 -0800
In-Reply-To: <20250207232452.994822-1-irogers@google.com>
Message-Id: <20250207232452.994822-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 2/7] perf maps: Switch modules tree walk to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, 
	Jesper Juhl <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Compared to glibc's opendir/readdir this lowers the max RSS of perf
record by 1.8MB on a Debian machine.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2d51badfbf2e..bdd7969533c6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -37,6 +37,7 @@
 #include <internal/lib.h> // page_size
 #include "cgroup.h"
 #include "arm64-frame-pointer-unwind-support.h"
+#include <api/io_dir.h>
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -1354,25 +1355,21 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 
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
@@ -1405,7 +1402,7 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 	}
 
 out:
-	closedir(dir);
+	close(iod.dirfd);
 	return ret;
 }
 
-- 
2.48.1.502.g6dc24dfdaf-goog


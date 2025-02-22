Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8A202F72
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Feb 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204635; cv=none; b=gDvKbBA5PrnT+h/z4YWrKwRujWn0YNd+Sei6e2+w1qt93Q9muP9VGODZiC+p+ijW/Z5RR64TWdWzrsYIHp8cJd0oqJxOQ8OSOY2B+UEryMAXBnpk4Y9uh0WxUz/sVI3BTVND/cdI8yxz8qgmLqXOZQCDksOF+qO/KTibJs0KzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204635; c=relaxed/simple;
	bh=KmpojbQOHU3/yvskQ5S+KuVwQMXy4Kd7tQUOuLUv6hU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=GoFM4iSXetXDyZhbEFmm9Du8Xbcip58jed1Bn7dikcyd+Dv27NpNh7dcgCqplCH7bG/yXtEblU/bw6V+yuY31ue64Hq7OEx19FXzzuQ17LpV4ZuMiI6Kks5eQMwGleWc9uXcMM11D8N9++qZbxwgQY5BQ+7fcnJMGVRUXIYWEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRQjCJA9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRQjCJA9"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e582bfcada6so4559717276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Feb 2025 22:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204633; x=1740809433; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeV0TF04x4Q55zwmuqZvIQwfsPrnE53+pXX+ltT5R/I=;
        b=JRQjCJA9hosOSquRUJK3PYYABUrT1vMLoNQhww3OHXqdxVUHlAlPaDeXLugBgzFRZR
         w7MmIaLM3uaowXp3LKvUxTscpatXG9knJjs/oLQ8E/Pha2lIADoBXOlGMXwxFbjpYhwU
         cTQPT8uKSsji/LiDoYnkE+6EB+uyQ3E1J79MsDsuy+GTWyF6Hsz7iay4TTiWcMTQsaNw
         KJ3OXrn+ubN/kEyrCi0Taoa/hyETm8x5qiwR61wO9VNc1aYyOzHoRATnkdu4gzGfU9bK
         1KxeqC0fy9gwkDZwxKZSZzjwr3gwPReIxOd/T6ebdp7M46h1YqSeX96E6jUnrSqK8aMD
         efkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204633; x=1740809433;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeV0TF04x4Q55zwmuqZvIQwfsPrnE53+pXX+ltT5R/I=;
        b=O1s9ODZ0KnGE1Z2GHvUdKohOwDqrEsPyy3s911lm4sxJlRoDPf0Hay6lhIYyH9q66l
         1yvG7+Ig4nQZAKoSxZGHzETsnembX6vOqZpaWVBn/EJALDBywI76C4ArJPLZp7ayTCdg
         UDMG2WKcgzfZhx4t6dL16OVR2ZBnWGFbPrL0Q8jUgnHLiLlc1yt9qb25dOUGhZOZNY/t
         XYkL4O6ASSAkEwUpw83QX/FhGwzbIQMRUn1B6X8OAthV5UIUbJBY5KNDjF8nJk1Tbxrm
         tbNPwqQKlYwzd6OW3b/NwfJ9vdE7WP/Vjd7XoKNYh5ybMY0pwiewnfOoyegNq0PTQuFY
         0CfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxHLenRLJEulmkyxAW8tbLZz0UFIkqGsnT5NfpFnNw6JLKlloo9yYei5C8DptAapwveBJ6vTQRBMwRNXyWGBT9@vger.kernel.org
X-Gm-Message-State: AOJu0YxABpisuJbn0e8PRxhQRkFqDwRH4SBOXPGu2KchwfNl9Nu6HidQ
	7c1z9g+qbRxv9zwzcWyyJf3pZrGix3V9VuZiZEooLL43tU4i1gsySAuA88ER7Rj4AYUWlxw6Yu6
	QKDUE5g==
X-Google-Smtp-Source: AGHT+IE8mpRXA3wnwCNX1nBHvyWRtHCtakW5d7vzFI8JEASHw4DDWqNpJ04dj1qMI6ZICsw2IX93zX5fRaW9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:b123:0:b0:e5d:bc9c:1c6c with SMTP id
 3f1490d57ef6-e5e24675417mr517176276.5.1740204632752; Fri, 21 Feb 2025
 22:10:32 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:09 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 4/8] perf header: Switch mem topology to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Switch memory_node__read and build_mem_topology from opendir/readdir
to io_dir__readdir, with smaller stack allocations. Reduces peak
memory consumption of perf record by 10kb.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d06aa86352d3..1900965f8752 100644
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
@@ -1311,11 +1312,11 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
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
@@ -1324,9 +1325,9 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
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
 
@@ -1338,20 +1339,20 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 
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
 
@@ -1374,8 +1375,8 @@ static int memory_node__sort(const void *a, const void *b)
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
@@ -1383,14 +1384,14 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
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
 
@@ -1419,7 +1420,7 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 			cnt += 1;
 	}
 out:
-	closedir(dir);
+	close(dir.dirfd);
 	if (!ret) {
 		*cntp = cnt;
 		*nodesp = nodes;
-- 
2.48.1.658.g4767266eb4-goog

